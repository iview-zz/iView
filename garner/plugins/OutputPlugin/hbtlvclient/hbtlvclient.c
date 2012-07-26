#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

#include "hbtlvclient.h"
#define HB_TOK_LEN 2048

static u_int32_t g_hb_tlv_counter = 0;

typedef struct _hb_tlv {
    u_int8_t type;
    u_int32_t len;
    u_int8_t data[0];
}__attribute__((packed)) hb_tlv;

struct _hbtlv_plugin_data {
    struct in_addr server_ip;
    u_int32_t server_port;

    void *handle;
};


#define xassert(EX)  ((EX)?((void)0):hb_tlv_assert(#EX, __FILE__, __LINE__))

void
hb_tlv_assert(const char *msg, const char *file, int line)
{
    fprintf(stderr, "file %s:%d, Assertion '%s' failed\n", file, line, msg);
    abort();
}

static int
hbtlv_get_token(char *src, char *dst)
{
    int count;
    char *start,*end, *comma_p;

    start = src;
    /* trimming the token at start - skipping spaces/tabs/new lines */
    while(isspace(*start)){
	start++;
    }

    /* get pointer to next token delimiter */
    for(comma_p=start ; (*comma_p != ',') && (*comma_p != '\0'); comma_p++);

    /* trimming the token at end - skipping spaces/tabls/ne lines */
    if(comma_p != start) {
	end = comma_p-1;
	while((end!=src) && isspace(*end)){
	    end--;
	}
	/* length of token(n bytes) */
	count=end-start+1;
    }

    if(comma_p == src || end == src) {
	/* token is empty string */
	count = 0;
    }

    xassert(count < HB_TOK_LEN) ;
    /* to return token to caller */
    if(dst != NULL) {
	memcpy(dst, start, count);
	dst[count] = '\0';
    }
    /* return number of bytes to be skipped to get next token */
    return (comma_p-src+1);
}


static int
hbtlv_parse_init_data(const char *argstring, struct _hbtlv_plugin_data *pdata)
{
    char token[HB_TOK_LEN];
    int offset;
    int ret = 0;

    if (!pdata) {
	return -1;
    }

    offset = 0;
    offset += hbtlv_get_token((char *)argstring+offset, token);
    if (!strcmp(token,"")) {
	strcpy(token, "127.0.0.1");
    }

    if ((ret = inet_pton(AF_INET, token, &pdata->server_ip)) < 0) {
	fprintf(stderr,"hbtlv_parse_init_data faild '%s'\n", strerror(errno));
	return -1;
    } else if (ret <= 0) {
	fprintf(stderr, "hbtlv_parse_init_data: the ipaddress is not in valid ip4 format or in ip6 format\n");
	return -1;
    }

    offset += hbtlv_get_token((char *)argstring+offset, token);
    if (!strcmp(token,"")) {
	strcpy(token, "1414");
    }
    pdata->server_port = atoi(token);
    return 0;
}

/*
 * Arguments:
 *	argstring - Arguments passed along with the output line in output block.
 *	version - version of garner.
 *	handle - to store an pointer to internal state information.
 * Return Value:
 *	Returns 0 on success, -1 on failure.
 *	Can directly write the errors on standard out and error.
 *        They will be reflected to log file. Also errno can be used.
 * Description:
 *	This routine would be called once by garner during initialization.
 *	Version mismatch can be check during init itself.
 */
int
hbtlvclient_init(const char *argstring, u_int32_t version, void **handle)
{
    struct _hbtlv_plugin_data *pdata;

   /* if (g_hb_tlv_counter) {
	return 0;
    }*/

    pdata = (struct _hbtlv_plugin_data*) calloc(1, sizeof(struct _hbtlv_plugin_data));

    if (hbtlv_parse_init_data(argstring, pdata) != 0) {
	fprintf(stderr, "hbtlvclient_init: parsing failed '%s'\n", argstring);
	fprintf(stderr, "hbtlvclient_init failed\n");
	free(pdata);
	return -1;
    }

    pdata->handle = (void*) pdata;

    g_hb_tlv_counter++;

    *handle = (void*)pdata;

    return 0;
}


/*
 * Frees the internal data-structures of the library.
 */
void
hbtlvclient_close(void *handle)
{

    free(handle);
    handle=NULL;
    g_hb_tlv_counter--;
    return;
}

static void
hb_process_tlv(const char *ip, const char *msg, struct _hbtlv_plugin_data *pdata)
{
    int len, idx=0;
    char *nexttok, *nextval;
    char *tok;
    char t_msg[(len=(msg?strlen(msg):0)+1)];
    char data[(len=(msg?strlen(msg):0)+INET_ADDRSTRLEN+1)];

    if (!pdata) {
	return;
    }

    strcpy(t_msg, msg);

    tok = strtok_r(t_msg, "&&", &nexttok);
    while (tok) {
	strtok_r(tok, "||", &nextval);
	snprintf(&data[idx], len-1, "%s#", nextval?nextval+1:"");
	tok = strtok_r(NULL, "&&", &nexttok);
	idx=strlen(data);
    }
    sprintf(&data[idx-2], "#%s", ip);
    idx += strlen(ip);
    data[idx-1]='\0';
    fprintf(stderr, "hb_process_tlv:%d %s\n", idx, data);

    {
	int buflen;
	int fd;
	char buffer[(buflen=(strlen(data)+sizeof(hb_tlv))+1)];
	hb_tlv *tlv;
	struct sockaddr_in ser_addr={0};


	tlv = (hb_tlv *) (buffer);
	memset(buffer, 0, buflen);
	tlv->type = 1;
	tlv->len = strlen(data);
	memcpy(tlv->data, data, tlv->len);

//	fprintf(stderr, "Size of tlv : %d-%d\n", sizeof(hb_tlv), buflen);

	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
	    fprintf(stderr,"hb_process_tlv: socket failed : %s\n", strerror(errno));
	    return;
	}

	ser_addr.sin_family=AF_INET;
	ser_addr.sin_port = htons(pdata->server_port);
	ser_addr.sin_addr = pdata->server_ip;

	if (sendto(fd, buffer, buflen, 0, (struct sockaddr *) &ser_addr, sizeof(ser_addr))< 0) {
	    char dst_ip[INET_ADDRSTRLEN];
	    inet_ntop(AF_INET, &pdata->server_ip, (char *)dst_ip, INET_ADDRSTRLEN);
	    fprintf(stderr, "hb_process_tlv: faild on %s:%d '%s'\n", dst_ip, pdata->server_port, strerror(errno));
	}
	close(fd);
    }
}


/*
 * Arguments:
 *	searray - an array of standard events
 *	nse - number of elements in searray.
 *	output_data_list - 2D pointer to output data list
 * Description:
 *      Output plugin, can be formatter or processor
 */
void
hbtlvclient_output(struct _std_event *searray, u_int32_t nse,
				struct _output_data **output_data_list, void *handle)
{
    int idx;
    struct _std_event *se;
    struct _hbtlv_plugin_data *pdata;
    fprintf(stdout, "hbtlvclient_output called\n"); 

    if (!handle) {
	fprintf(stderr,"hbtlvclient_output: Invalid plug-in Call\n");
	return;
    }

    pdata = (struct _hbtlv_plugin_data *) handle;

    for (idx=0; idx < nse; idx++) {
	se = &searray[idx];
	hb_process_tlv(se->device.device_name, se->log.raw_log, pdata);
    }
    return;
}

int 
hbtlvclient_reconfig(const char *argstring, void **handle)
{
    hbtlvclient_close(*handle);

    return hbtlvclient_init(argstring, STD_EVENT_VERSION, handle);
}

