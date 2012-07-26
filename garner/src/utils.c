/* ***********************************************************************
*  Cyberoam iView - The Intelligent logging and reporting solution that 
*  provides network visibility for security, regulatory compliance and 
*  data confidentiality 
*  Copyright  (C ) 2009  Elitecore Technologies Ltd.
*  
*  This program is free software: you can redistribute it and/or modify 
*  it under the terms of the GNU General Public License as published by 
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*  
*  This program is distributed in the hope that it will be useful, but 
*  WITHOUT ANY WARRANTY; without even the implied warranty of 
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
*  General Public License for more details.
*  
*  You should have received a copy of the GNU General Public License 
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*  
*  The interactive user interfaces in modified source and object code 
*  versions of this program must display Appropriate Legal Notices, as 
*  required under Section 5 of the GNU General Public License version 3.
*  
*  In accordance with Section 7(b) of the GNU General Public License 
*  version 3, these Appropriate Legal Notices must retain the display of
*   the "Cyberoam Elitecore Technologies Initiative" logo.
*************************************************************************/

/* utils.c
 *
 * Misc. routines which are used by the various functions to handle strings
 * and memory allocation and pretty much anything else we can think of. Also,
 * the load cutoff routine is in here. Could not think of a better place for
 * it, so it's in here.
 *
 */

#include "garner.h"
#include "utils.h"

/*
 * Safely creates filename and returns the low-level file descriptor.
 */
int
create_file_safely(const char *filename, unsigned int truncate_file)
{
    struct stat lstatinfo;
    int fildes;

    /*
     * lstat() the file. If it doesn't exist, create it with O_EXCL.
     * If it does exist, open it for writing and perform the fstat()
     * check.
     */
    if (lstat(filename, &lstatinfo) < 0) {
	/*
	 * If lstat() failed for any reason other than "file not
	 * existing", exit.
	 */
	if (errno != ENOENT) {
	    fprintf(stderr, "%s: Error checking file %s: %s\n",
				PACKAGE, filename, strerror(errno));
	    return -EACCES;
	}

OPENNEW:
	/*
	 * The file doesn't exist, so create it with O_EXCL to make
	 * sure an attacker can't slip in a file between the lstat()
	 * and open()
	 */
	if ((fildes = open(filename, O_RDWR | O_CREAT | O_EXCL, 0666)) < 0) {
	    fprintf(stderr, "%s: Could not create file %s: %s\n",
					PACKAGE, filename, strerror(errno));
	    return fildes;
	}
    } else {
	struct stat fstatinfo;
	int flags;

	flags = O_RDWR;
	if (!truncate_file)
	    flags |= O_APPEND;

	/*
	 * Open an existing file.
	 */
	if ((fildes = open(filename, flags, 0666)) < 0) {
	    fprintf(stderr, "%s: Could not open file %s: %s\n",
			    PACKAGE, filename, strerror(errno));
	    return fildes;
	}

	/*
	 * fstat() the opened file and check that the file mode bits,
	 * inode, and device match.
	 */
	if (fstat(fildes, &fstatinfo) < 0
		|| lstatinfo.st_mode != fstatinfo.st_mode
		|| lstatinfo.st_ino != fstatinfo.st_ino
		|| lstatinfo.st_dev != fstatinfo.st_dev) {
	    fprintf(stderr, "%s: The file %s has been "\
			    "changed before it could be opened\n",
			    PACKAGE, filename);
	    close(fildes);
	    return -EIO;
	}

	/*
	 * If the above check was passed, we know that the lstat()
	 * and fstat() were done on the same file. Now we check that
	 * there's only one link, and that it's a normal file (this
	 * isn't strictly necessary because the fstat() vs lstat()
	 * st_mode check would also find this)
	 */
	if (!S_ISREG(lstatinfo.st_mode)) {
	    fprintf(stderr, "%s: The file %s is not a regular file\n",
						    PACKAGE, filename);
	    close(fildes);
	    return -EMLINK;
	}

	if(fstatinfo.st_nlink > 1) {
	    fprintf(stderr, "%s: The file %s has too many links; unlinking it\n",
						    PACKAGE, filename);
	    close(fildes);
	    if(unlink(filename) != 0) {
		fprintf(stderr, "%s: unlink(%s) failed: %s\n",
			    PACKAGE, filename, strerror(errno));
		return -EMLINK;
	    }
	    goto OPENNEW;
	}

	/*
	 * Just return the file descriptor if we _don't_ want the file
	 * truncated.
	 */
	if (!truncate_file)
	    return fildes;

	/*
	 * On systems which don't support ftruncate() the best we can
	 * do is to close the file and reopen it in create mode, which
	 * unfortunately leads to a race condition, however "systems
	 * which don't support ftruncate()" is pretty much SCO only,
	 * and if you're using that you deserve what you get.
	 * ("Little sympathy has been extended")
	 */
#ifdef HAVE_FTRUNCATE
	ftruncate(fildes, 0);
#else
	close(fildes);
	if ((fildes = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0600)) < 0) {
	    fprintf(stderr, "%s: Could not open file %s: %s.",
			    PACKAGE, filename, strerror(errno));
	    return fildes;
	}
#endif	    /* HAVE_FTRUNCATE */
    }

    return fildes;
}

/*
 * Write the PID of the program to the specified file.
 */
int
pidfile_create(const char *filename)
{
    int fildes;
    FILE *fd;

    /*
     * Create a new file
     */
    if ((fildes = create_file_safely(filename, TRUE)) < 0)
	return fildes;

    /*
     * Open a stdio file over the low-level one.
     */
    if ((fd = fdopen(fildes, "w")) == NULL) {
	fprintf(stderr, "%s: Could not write PID file %s: %s.",
				PACKAGE, filename, strerror(errno));
	close(fildes);
	unlink(filename);
	return -EIO;
    }

    fprintf(fd, "%ld\n", (long) getpid());
    fclose(fd);
    return 0;
}


/*
 * Removes any new-line or carriage-return characters from the end of the
 * string. This function is named after the same function in Perl.
 * "length" should be the number of characters in the buffer, not including
 * the trailing NULL.
 *
 * Returns the number of characters removed from the end of the string.  A
 * negative return value indicates an error.
 */
ssize_t
chomp(char *buffer, size_t length)
{
    size_t chars;

    xassert(buffer != NULL);
    xassert(length > 0);

    chars = 0;

    --length;
    while (buffer[length] == '\r' || buffer[length] == '\n') {
	buffer[length] = '\0';
	chars++;

	/* Stop once we get to zero to prevent wrap-around */
	if (length-- == 0) break;
    }

    return chars;
}

char* trim_start(const char* data)
{
    while(*data && isspace(*data))
	++data;
    return (char*)data;
}

char* trim_end(char* data)
{
    char* t = data + strlen(data);

    while(t > data && isspace(*(t - 1))) {
	t--;
	*t = 0;
    }

    return data;
}

char* trim_space(char* data)
{
    data = (char*)trim_start(data);
    return trim_end(data);
}

char *
notspace(char *str)
{
    while(*str && isspace(*str))str++;
    return str;
}

/* arguments are seconds and nanoseconds */
inline void
do_nanosleep(time_t  tv_sec, long tv_nsec)
{
    struct timespec req;
    req.tv_sec = tv_sec;
    req.tv_nsec = tv_nsec;

    nanosleep(&req, NULL);
}

char *
get_tok(char *str, char** endp)
{
    char *p = notspace(str),*q;
    if(!p) return NULL;
    q = p;
    while(*q && !isspace(*q)) q++;
    if(q) {
	*q='\0';
	q = notspace(q+1);
    }
    if(endp)
	*endp = q?q:NULL;
    return p;
}

/*
 * Read in a "line" from the socket. It might take a few loops through
 * the read sequence. The full string is allocate off the heap and stored
 * at the whole_buffer pointer. The caller needs to free the memory when
 * it is no longer in use. The returned line is NULL terminated.
 *
 * Returns the length of the buffer on success (not including the NULL
 * termination), 0 if the socket was closed, and -1 on all other errors.
 */
#define SEGMENT_LEN (512)
#define MAXIMUM_BUFFER_LENGTH (128 * 1024)
ssize_t
readline(int fd, char **whole_buffer)
{
    ssize_t whole_buffer_len;
    char buffer[SEGMENT_LEN];
    char *ptr;

    ssize_t ret;
    ssize_t diff;

    struct read_lines_s {
	char *data;
	size_t len;
	struct read_lines_s *next;
    } *first_line, *line_ptr;

    first_line = (struct read_lines_s*)calloc(sizeof(struct read_lines_s), 1);
    if (!first_line)
	return -ENOMEM;

    line_ptr = first_line;

    whole_buffer_len = 0;
    for (;;) {
	ret = recv(fd, buffer, SEGMENT_LEN, MSG_PEEK);
	if (ret <= 0)
	    goto CLEANUP;

	diff = ret;
	for(ptr=buffer; ptr < buffer+ret; ptr++) {
	    if (*ptr == '\n') {
		diff = ptr - buffer + 1;
		break;
	    }
	}
	whole_buffer_len += diff;

	/*
	 * Don't allow the buffer to grow without bound. If we
	 * get to more than MAXIMUM_BUFFER_LENGTH close.
	 */
	if (whole_buffer_len > MAXIMUM_BUFFER_LENGTH) {
	    ret = -ERANGE;
	    goto CLEANUP;
	}

	line_ptr->data = (char*)malloc(diff);
	if (!line_ptr->data) {
	    ret = -ENOMEM;
	    goto CLEANUP;
	}

	recv(fd, line_ptr->data, diff, 0);
	line_ptr->len = diff;

	if (*ptr == '\n')
	    break;

	line_ptr->next =
		(struct read_lines_s*)calloc(sizeof(struct read_lines_s), 1);
	if (!line_ptr->next) {
	    ret = -ENOMEM;
	    goto CLEANUP;
	}
	line_ptr = line_ptr->next;
    }

    *whole_buffer = (char*)malloc(whole_buffer_len + 1);
    if (!*whole_buffer) {
	ret = -ENOMEM;
	goto CLEANUP;
    }

    *(*whole_buffer + whole_buffer_len) = '\0';

    whole_buffer_len = 0;
    line_ptr = first_line;
    while (line_ptr) {
	memcpy(*whole_buffer + whole_buffer_len, line_ptr->data, line_ptr->len);
	whole_buffer_len += line_ptr->len;
	line_ptr = line_ptr->next;
    }

    ret = whole_buffer_len;
CLEANUP:
    do {
	line_ptr = first_line->next;
	if (first_line->data)
	    free(first_line->data);
	free(first_line);
	first_line = line_ptr;
    } while (first_line);

    return ret;
}

