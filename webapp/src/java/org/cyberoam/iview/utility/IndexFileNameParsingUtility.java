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

import org.cyberoam.iview.audit.CyberoamLogger;

/**
 * This utility class is used to parse indexed file names.
 * In iView indexed file names will contain two unix timestamps.
 * i.e. file creation timestamp and event timestamp.
 * @author Narendra Shah
 *
 */
public class IndexFileNameParsingUtility{
  
	/**
	* It return string from given filename starting from first '_' found in filename.
	*/
	public static String getFileStartValue(String fileName) {
		String returnVal=null;
		try {
			if(fileName.indexOf("_1_")>0){
				fileName=fileName.replaceFirst("_1_","1_");
			}
			returnVal = fileName.substring(0,fileName.indexOf("_")-1);
		} catch(Exception e) {
			CyberoamLogger.sysLog.error("IndexFileNameParsingUtility.getFileStartValue.e:" + e, e);
		}
		return returnVal;
	}	
		
	/**
	* It return string between first '_' and second '_' from given filename.
	*/
	public static String getFileFirstUnixTimeStamp(String fileName) {
		String returnVal=null;
		try {
			if(fileName.indexOf("_1_")>0){
				fileName=fileName.replaceFirst("_1_","1_");
			}
			int startIndex = fileName.indexOf("_");
			int endIndex = fileName.indexOf("_",startIndex+1);
			returnVal = fileName.substring(startIndex+1,endIndex);
		} catch(Exception e) {
			CyberoamLogger.sysLog.error("IndexFileNameParsingUtility.getFileFirstUnixTimeStamp.e" + e, e);
		}
		return returnVal;
	}
	
	/**
	* It return string between with second '_' and  '.' from given filename.
	*/	
	public static String getFileSecondUnixTimeStamp(String fileName) {
		String returnVal=null;
		try {
			if(fileName.indexOf("_1_")>0){
				fileName=fileName.replaceFirst("_1_","1_");
			}
			int startIndex = fileName.indexOf("_");
			int endIndex = fileName.indexOf("_",startIndex+1);
			returnVal = fileName.substring(endIndex + 1, fileName.indexOf("."));
		} catch(Exception e) {
			CyberoamLogger.sysLog.error("IndexFileNameParsingUtility.getFileSecondUnixTimeStamp.e:" + e, e);
		}
		return returnVal;
	}
}
