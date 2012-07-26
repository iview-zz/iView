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
import java.util.Enumeration;
import java.io.FileInputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;

/**
 * This utility class is used for the functionality of backup and restore.
 * @author Shikha Shah
 */public class BackupRestoreUtility{
	/**
	* This method is used to take the backup of the log files.
	*/	
	public static void Backup(String appID,String filename,String day,String type,ZipOutputStream zip){	 
		try{
			byte[] buf = new byte[1024];
			int len;
			String source;
			//type specifies whether the file is index file or archive file.			
			if(type.equals("index")){
				source="indexfiles";
			}
			else{
				source="archievefiles";
			}

			FileInputStream in = new FileInputStream(iViewConfigBean.ArchiveHome+source+"/"+appID+"/cold/"+day+"/" +filename);
			zip.putNextEntry(new ZipEntry(source+"/"+appID+"/Restore/"+day+"/"+filename));
			while ((len = in.read(buf)) > 0) {
				zip.write(buf, 0, len);
			}
			in.close();			
		}
		catch(Exception e){
			CyberoamLogger.appLog.debug("BackupRestoreUtility->Backup->Exception: "+e);
		}
	}
	/**
	* This method is used to copy a file from source to destination specified.
	*/		
	public static void copyFile(String sourceFile,String destinationFile)
	  throws IOException{
		try{
			copyInputStream(new BufferedInputStream(new FileInputStream(sourceFile)),
						   new BufferedOutputStream(new FileOutputStream(destinationFile)));
			new File(sourceFile).delete();
		}
		catch(Exception e){
			CyberoamLogger.appLog.debug("BackupRestoreUtility->copyFile->Exception: "+e,e);			
		}
	}
	/**
	* This method is used to copy a inputstream to outputstream.
	*/	
	public static void copyInputStream(InputStream in, OutputStream out)
	  throws IOException {
			byte[] buffer = new byte[4028];
		    int len;
			while((len = in.read(buffer)) >= 0){
		      out.write(buffer, 0, len);
			}	
		    in.close();
			out.close();
	}
	
	/**
	* This method is used to achieve the Restore Functionality.
	* The sourcePath is the zipped file which is been extracted and moved to the destination location specified.
	*/		

	public static int Restore(String sourcePath,String destinationPath) {
	    Enumeration entries;
		ZipFile zipFile;
	    try{
			if(isValidArchiveFile(sourcePath)==-1){
				return -1;
			}			
			zipFile = new ZipFile(sourcePath);
			entries = zipFile.entries();				
			while(entries.hasMoreElements()) {
				ZipEntry entry = (ZipEntry)entries.nextElement();
				if(entry.isDirectory()) {
					(new File(destinationPath+entry.getName())).mkdir();
					continue;
		        }
		        copyInputStream(zipFile.getInputStream(entry),
				new BufferedOutputStream(new FileOutputStream(destinationPath+entry.getName())));
			}
			zipFile.close();
			return 0;
	    } 
	    catch (Exception e){
	    	CyberoamLogger.appLog.debug("BackupRestoreUtility->Restore->Exception: "+e);				
	    	return -1;
	    }
	}
 
/**
* This method is used to check whether a file ia a  valid archive file or not.
*/		

	public static int isValidArchiveFile(String sourcePath) {
		ZipFile zipFile;
	    try{
			zipFile = new ZipFile(sourcePath);
			//to check whether the zip file contains indexfiles and archivefiles entry or not.			
			if(zipFile.getEntry("archievefiles")==null){
				CyberoamLogger.appLog.debug("BackupRestoreUtility->IsValidArchiveFile->Filename->" + sourcePath + " not Valid");
				zipFile.close();
				return -1;				
			}
			zipFile.close();
			return 0;
	    }
	    catch(Exception e){
	    		CyberoamLogger.appLog.debug("BackupRestoreUtility->IsValidArchiveFile->Exception: "+e);
	    		return -1;
	    }
	}
}