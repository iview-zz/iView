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

package org.cyberoam.iview.utility;

import java.io.*;
/**
 * This class is use to filter file list by pattern matching.
 * Means it gives only files that match given pattern.
 * @author Narendra Shah
 */
public class FileFilter implements FilenameFilter{
	private String regexp;
	
	/**
	 * Default constructor for filter that can match all file name.
	 */
	public FileFilter(){
		this.regexp = ".*";	
	}
	/**
	 * Constructor with given pattern that can match all file name.
	 * @param regexp - pattern to be matched for file name.
	 */
	public FileFilter(String regexp){
		this.regexp = regexp;
	}
	/**
	 * Tests if a specified file should be included in a file list.
	 * @param directory - the directory in which the file was found.
	 * @param name - the name of the file. 
	 */
	public boolean accept(File directory, String name){
		return (name.matches(regexp));
	}	
}
