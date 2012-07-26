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
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import org.cyberoam.iview.beans.FileHandlerBean;
import org.cyberoam.iview.audit.CyberoamLogger;



/**
 * This utility class is used for rotation of restore files.
 * This thread will rotate all archive and index logs which are 
 * present inside the restore folder to the cold folder.
 * @author Shikha Shah
 */

public class RestoreFilesRotation extends Thread{
	/**
	* This constructor calls the run method of the thread.
	*/
	public RestoreFilesRotation() {
		start();
	}
	/**
	* The run method implements the restoration of files from restore folder to cold folder.
	*/	
	public void run(){
		try{
			CyberoamLogger.sysLog.debug("RestoreFileRotation Starts");			
			restoreIndex(IViewPropertyReader.IndexDIR);
			restoreArchive(IViewPropertyReader.ArchieveDIR);
			CyberoamLogger.sysLog.debug("RestoreFileRotation Ends");
		}
		catch(Exception e){
			CyberoamLogger.sysLog.debug("RestoreFileRotation->run->Exception: " + e);
		}
	}
	/**
	* This method copies the index files from restore folder to cold folder.
	*/		
	public void restoreIndex(String path){
		try{
			FileHandlerBean fileHandlerBean = new FileHandlerBean();
			File file=new File(path);
			String devices[]=file.list();
			int iCntr1;
			int iCntr2;
			int iCntr3;
			int status;
			//loops for all the devices			
			for(iCntr1=0;iCntr1<devices.length;iCntr1++){
				File deviceFile=new File(file.getPath()+"/"+devices[iCntr1]+"/Restore");
				//to check whether the restore folder for a particular device exists or not and if exists contains any files or not.				
				if(!deviceFile.exists() || (deviceFile.list()).length<=0)
					continue;
				String dayList[]=deviceFile.list();
				//loops for each day for a particular device				
				for(iCntr2=0;iCntr2<dayList.length;iCntr2++){
					File files=new File(deviceFile.getPath()+"/"+dayList[iCntr2]);
					/**
					 * To check whether a dayFolder exists within the restore folder for a particular device exists or not and 
					 * if exists contains any files or not.
					 */					
					if(!files.exists() || (files.list()).length<=0)
						continue;
					String fileList[]=files.list();
					for(iCntr3=0;iCntr3<fileList.length;iCntr3++){
						long filesize=0;
						File f = new File(files+"/"+fileList[iCntr3]);
						//to calculate the file size of an existing file						
						if(f.exists()){
							Enumeration entries;
							ZipFile zipFile;
						    try{
								zipFile = new ZipFile(f);
								entries = zipFile.entries();			
								ZipEntry entry = (ZipEntry)entries.nextElement();									
								filesize=entry.getSize();
								zipFile.close();								
							}
						    catch(Exception e){
						    	CyberoamLogger.sysLog.debug("RestoreRotationThread->Exception in opening the zip file");						    	
						    }
						}
						CyberoamLogger.sysLog.debug("RestoreFileRotation->FileName->"+f.getName()+"->FileSize->" + filesize);							
						//to check whether the record already exists within the database or not
						
						fileHandlerBean.setFileName(fileList[iCntr3].substring(0,fileList[iCntr3].length()-4));
						fileHandlerBean.setFileCreationTimestamp(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(fileList[iCntr3]));
						fileHandlerBean.setFileEventTimestamp(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(fileList[iCntr3]));
						fileHandlerBean.setFileSize(filesize);
						fileHandlerBean.setIsLoaded(0);
						fileHandlerBean.setLastAccessTimeStamp("");
						fileHandlerBean.setAppID(devices[iCntr1]);				
						
						status=fileHandlerBean.insertRecord();

						
						//status=insertRecord(fileList[iCntr3],devices[iCntr1],filesize);
						if(status>0 || status==-1){
							new File(path+devices[iCntr1]+IViewPropertyReader.COLD+"/"+dayList[iCntr2]).mkdirs();
							BackupRestoreUtility.copyFile(files+"/"+fileList[iCntr3],path+devices[iCntr1]+IViewPropertyReader.COLD+"/"+dayList[iCntr2]+"/"+fileList[iCntr3]);
						}
					}
					files.delete();
				}
				deviceFile.delete();
			}
		}
		catch(Exception e){
			CyberoamLogger.sysLog.debug("RestoreFileRotation->RestoreIndex->Exception: " + e,e);
		}
	}

	/**
	* This method copies the archive files from restore folder to cold folder.
	*/	
	public void restoreArchive(String path){
		try{
			File file=new File(path);
			String devices[]=file.list();
			int iCntr1;
			int iCntr2;
			int iCntr3;
			//Loops for all the devices			
			for(iCntr1=0;iCntr1<devices.length;iCntr1++){
				File deviceFile=new File(file.getPath()+"/"+devices[iCntr1]+"/Restore");
				//To check whether the restore folder for a particular device exists or not and if exists contains any files or not.				
				if(!deviceFile.exists() || (deviceFile.list()).length<=0)
					continue;
				String dayList[]=deviceFile.list();
				//Loops for each day for a particular device				
				for(iCntr2=0;iCntr2<dayList.length;iCntr2++){
					File files=new File(deviceFile.getPath()+"/"+dayList[iCntr2]);
					//To check whether a dayFolder exists within the restore folder for a particular device exists or not and 
					//if exists contains any files or not.										
					if(!files.exists() || (files.list()).length<=0)
						continue;
					
					String fileList[]=files.list();
					for(iCntr3=0;iCntr3<fileList.length;iCntr3++){
						new File(path+devices[iCntr1]+IViewPropertyReader.COLD+dayList[iCntr2]).mkdirs();
						BackupRestoreUtility.copyFile(files+"/"+fileList[iCntr3],path+devices[iCntr1]+IViewPropertyReader.COLD+dayList[iCntr2]+"/"+fileList[iCntr3]);
					}
					files.delete();
				}
				deviceFile.delete();
			}
		}
		catch(Exception e){
			CyberoamLogger.sysLog.debug("RestoreFileRotation->RestoreArchive->Exception: " + e,e);
		}
	}
}