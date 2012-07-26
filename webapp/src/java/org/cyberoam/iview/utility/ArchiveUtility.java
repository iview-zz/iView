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

import java.io.File;
import java.util.ArrayList;

import org.cyberoam.iview.audit.CyberoamLogger;

/**
 * This utility class is used to get all the archive files
 * of a particular device between particular timestamps
 * @author Shikha Shah
 */


public class ArchiveUtility {	
	/**
	* This method is used to get the list of archive files between two given filenames.
	*/		
	public static ArrayList getArchiveFiles(long starttimestamp,long endtimestamp,String appid,String day){
		ArrayList files = null;
		try{
			int iCntr1;
			long time;
			File dstPath=new File(IViewPropertyReader.ArchieveDIR+appid+"/cold/"+day+"/");
			CyberoamLogger.appLog.debug("dstPath : "+dstPath.getPath());
			String archiveFiles[] = dstPath.list();
			if(archiveFiles==null){
				CyberoamLogger.appLog.debug("No Archive Files");
				return null;
			}
			files = new ArrayList();
			for(iCntr1=0;iCntr1<archiveFiles.length;iCntr1++){
				//extracting the timestamp of the archive files				
				
				if (IViewPropertyReader.IndexFileTimeStampUsed == 2) {
					time=Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(archiveFiles[iCntr1]))*1000;
				} else {
					time=Long.parseLong(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(archiveFiles[iCntr1]))*1000;
				}
				
				//checking whether the timestamp of the current file is between the two timestamps required.				
				if(time>=starttimestamp && time<=endtimestamp){
					files.add(archiveFiles[iCntr1]);					
				}
			}
		}
		catch(Exception e){
			CyberoamLogger.appLog.debug("ArchiveUtility->getArchiveFiles->Exception:"+e,e);
		}
		return files;
	}
}
