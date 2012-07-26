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
import java.text.SimpleDateFormat;
import java.util.Iterator;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.beans.DataBaseConfigBean;
import org.cyberoam.iview.beans.FileHandlerBean;
import org.cyberoam.iview.beans.iViewConfigBean;

/**
 * This thread manages the rotated files to archived files and moving files from /hot/rotated/files 
 * to /cold/ as archived and /warm/ as current data. 
 * @author Narendra Shah
 */
public class FileManager implements Runnable {
	
		/**
	 * This method manages the rotated files to archived files and moving /hot/rotated/files 
	 * to /cold/ as zip and /warm/ as current data. 
	 * @see java.util.TimerTask#run()
	 */
	@SuppressWarnings("unchecked")
	public void run(){
		CyberoamLogger.sysLog.debug(" File Manager Thread execution start : ");
		File srcLogFileObj=null;
		File srcMD5FileObj=null;
		String strLogFileName=null;
		String strMD5FileName=null;
		Iterator activeDeviceBeanItr=DeviceBean.getDeviceBeanIterator();		
		boolean lawflag=Boolean.parseBoolean(""+iViewConfigBean .getValueByKey("ArchiveHomeLawFlag"));
		CyberoamLogger.sysLog.debug("lawflag = "+lawflag);
		File Law5651=new File(iViewConfigBean.ArchiveHome+"Law5651");
		CyberoamLogger.sysLog.debug("lawfile path = "+Law5651.getAbsolutePath());
		if(lawflag){
			if(!Law5651.exists()){
				Law5651.mkdirs();
			}
		}
		DeviceBean deviceBean=null;
	//	String hotIndexDirPath="";
	//	String coldIndexDirPath="";		
					
		String hotRAWDirPath="";
		String coldRAWDirPath="";
		CyberoamLogger.sysLog.debug("activedeviceiterator : "+activeDeviceBeanItr);
		boolean archiveDisabled = DataBaseConfigBean.getValue(DataBaseConfigBean.ARHIEVE_DATA).equalsIgnoreCase("0");		
		if(archiveDisabled){
			CyberoamLogger.sysLog.debug("FileManager:Archive log disabled.");				
			return;
		}
		
		while(activeDeviceBeanItr !=null && activeDeviceBeanItr.hasNext()){
			deviceBean=(DeviceBean)activeDeviceBeanItr.next();
			//hotIndexDirPath=IViewPropertyReader.IndexDIR+deviceBean.getApplianceID()+IViewPropertyReader.HOT;
			//coldIndexDirPath=IViewPropertyReader.IndexDIR+deviceBean.getApplianceID()+ IViewPropertyReader.COLD;
			
			hotRAWDirPath=IViewPropertyReader.ArchieveDIR+deviceBean.getApplianceID()+IViewPropertyReader.HOT;
			coldRAWDirPath=IViewPropertyReader.ArchieveDIR+deviceBean.getApplianceID()+IViewPropertyReader.COLD;
			
			//CyberoamLogger.sysLog.debug("hotindex : " +hotIndexDirPath);
			//CyberoamLogger.sysLog.debug("coldindex : " +coldIndexDirPath);
			/*
			 * Get All newly created files from Indexed HOT DIR
			 * Iterate each file one bye one  
			*/
		//	File fileObj = new File(hotIndexDirPath);			
			/*try {
				if(!fileObj.exists()) fileObj.mkdirs();
				File filelist[] = fileObj.listFiles(new FileFilter(IViewPropertyReader.IndexLogFileFilterRegExp));
				CyberoamLogger.sysLog.debug("Index filelist size : " + filelist.length );
				for(int filecount=0;filecount<filelist.length;filecount++){
					strMD5FileName=null;
					if(filelist[filecount].isFile() ){
						if( (filelist[filecount].getName().toString()).split("[.]")[1].equalsIgnoreCase("log")){
							strLogFileName = filelist[filecount].getName();	
							for(int i=filecount+1 ; i <filelist.length  ; i++){
								if((strLogFileName.split("[.]")[0]).equalsIgnoreCase((filelist[i].getName().toString()).split("[.]")[0]) && (filelist[i].getName().toString()).split("[.]")[1].equalsIgnoreCase("md5")){
									strMD5FileName=filelist[i].getName();
									break;
								}
							}	
						}else{
							strMD5FileName=null;	
							continue;
						}
						/*
						 * Select next file from list and parse file name
						 * Prepare File Information and insert into Database
						 * We parse file creation and file event time stamp from filename
						 * We get filename,filesize and isloaded set default false  
						 * We set lastaccesstime with current time
						*/
												
					/*	FileHandlerBean fileHandlerObj = new FileHandlerBean();
						fileHandlerObj.setFileName(strLogFileName);
						String timestamp=null;
						timestamp = IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(strLogFileName);
						CyberoamLogger.sysLog.debug(" File Creation TimeStamp Long : "+timestamp);
						fileHandlerObj.setFileCreationTimestamp(timestamp);
						timestamp = IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(strLogFileName);
						CyberoamLogger.sysLog.debug(" File Event TimeStamp Long : "+timestamp);
						fileHandlerObj.setFileEventTimestamp(timestamp);
						fileHandlerObj.setFileSize(filelist[filecount].length());
						fileHandlerObj.setIsLoaded(0);
						fileHandlerObj.setLastAccessTimeStamp(new Long(System.currentTimeMillis()).toString());
						fileHandlerObj.setAppID(deviceBean.getApplianceID());
						int insStatus=fileHandlerObj.insertRecord();
						CyberoamLogger.sysLog.debug("filehandlerbean.insert : " + fileHandlerObj.toString());
						if(insStatus > 0){
							
							/*
							 *Prepar date string for create folder with particular date
							 *If DIR with particular date in which file fall is doesn't exists
							 *We create DIR with same name   
							*/
					/*		String current_day="";
							if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
								current_day = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(Long.parseLong(fileHandlerObj.getFileEventTimestamp())*1000));
							}else{
								current_day = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(Long.parseLong(fileHandlerObj.getFileCreationTimestamp())*1000));
							}

							srcLogFileObj = new File(hotIndexDirPath + strLogFileName);
							CyberoamLogger.sysLog.info("Going to create cold(zip) for " + srcLogFileObj.getAbsolutePath());
							File coldIndexDirWithDay = new File(coldIndexDirPath + current_day);
							if (!coldIndexDirWithDay.exists())
								coldIndexDirWithDay.mkdirs();
							coldIndexDirWithDay = new File(coldIndexDirWithDay.getAbsolutePath() + "/"
									+ strLogFileName + ".zip");
							if(strMD5FileName==null){		
								if (zipFileUtility.zipFile(srcLogFileObj.getAbsolutePath(),coldIndexDirWithDay.getAbsolutePath())  == 1) {
									srcLogFileObj.delete();
									CyberoamLogger.sysLog.debug("Zip created for index : " + coldIndexDirWithDay);
								} else {
									CyberoamLogger.sysLog.debug("Zip creation failed for index " + coldIndexDirWithDay);
								}
							}else{
								srcMD5FileObj = new File(hotIndexDirPath + strLogFileName);
								String [] filesObj={srcLogFileObj.getAbsolutePath(),srcMD5FileObj.getAbsolutePath()};
								if (zipFileUtility.zipFiles(filesObj,coldIndexDirWithDay.getAbsolutePath())  == 1) {
									srcLogFileObj.delete();
									srcMD5FileObj.delete();
									CyberoamLogger.sysLog.debug("Zip created for index : " + coldIndexDirWithDay);
								} else {
									CyberoamLogger.sysLog.debug("Zip creation failed for index " + coldIndexDirWithDay);
								}

							}	
							srcLogFileObj = null;
							srcMD5FileObj = null;
						}else{
							CyberoamLogger.sysLog.debug(" File Info --> " + strLogFileName
									+ "  Inserted Unsuccessfully but not zipped(Cold)");
						}
					}
				}
			}catch (Exception e) {
				CyberoamLogger.sysLog.debug("FileManager.indexBlock.e : "+e,e );
			}*/
			try{
				File fileObj = new File(hotRAWDirPath);				
				if(!fileObj.exists())
					fileObj.mkdirs();
				File rowfilelist[] = fileObj.listFiles(new FileFilter(IViewPropertyReader.RowLogFileFilterRegExp));
				CyberoamLogger.sysLog.debug("row rowfilelist size : " + rowfilelist.length );
				for(int filecount=0;filecount<rowfilelist.length;filecount++){
					try{
						strMD5FileName=null;
						if(rowfilelist[filecount].isFile() ){
							if( (rowfilelist[filecount].getName().toString()).split("[.]")[1].equalsIgnoreCase("log")){
								strLogFileName = rowfilelist[filecount].getName();	
								for(int i=filecount+1 ; i <rowfilelist.length  ; i++){
									if((strLogFileName.split("[.]")[0]).equalsIgnoreCase((rowfilelist[i].getName().toString()).split("[.]")[0]) && (rowfilelist[i].getName().toString()).split("[.]")[1].equalsIgnoreCase("md5")){
										strMD5FileName=rowfilelist[i].getName();
										break;
									}
								}	
							}else{
								strMD5FileName=null;
								continue;
							}						
						String current_day="";
						if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
							current_day = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(Long.parseLong(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(strLogFileName))*1000));
						}else{
							current_day = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(strLogFileName))*1000));
						}
						FileHandlerBean fileHandlerObj = new FileHandlerBean();
						fileHandlerObj.setFileName(strLogFileName);
						String timestamp=null;
						timestamp = IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(strLogFileName);
						CyberoamLogger.sysLog.debug(" File Creation TimeStamp Long : "+timestamp);
						fileHandlerObj.setFileCreationTimestamp(timestamp);
						timestamp = IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(strLogFileName);
						CyberoamLogger.sysLog.debug(" File Event TimeStamp Long : "+timestamp);
						fileHandlerObj.setFileEventTimestamp(timestamp);
						fileHandlerObj.setFileSize(rowfilelist[filecount].length());
						fileHandlerObj.setIsLoaded(0);
						fileHandlerObj.setLastAccessTimeStamp(new Long(System.currentTimeMillis()).toString());
						fileHandlerObj.setAppID(deviceBean.getApplianceID());
						int insStatus=fileHandlerObj.insertRecord();
						CyberoamLogger.sysLog.debug("filehandlerbean.insert : " + fileHandlerObj.toString());
						if(insStatus <= 0){
							continue;
						
						}
						srcLogFileObj = new File(hotRAWDirPath+strLogFileName);
						
						CyberoamLogger.sysLog.info("Going to create cold(zip) for " + srcLogFileObj.getAbsolutePath());
						File coldRAWDirWithDay = new File(coldRAWDirPath + current_day);
						if (!coldRAWDirWithDay.exists()) {
							coldRAWDirWithDay.mkdirs();
						}
						coldRAWDirWithDay= 	new File(coldRAWDirWithDay.getAbsolutePath()+ "/" + (strLogFileName.split("[.]")[0]) + ".zip");
						if(strMD5FileName==null){		
							if (zipFileUtility.zipFile(srcLogFileObj.getAbsolutePath(), coldRAWDirWithDay.getAbsolutePath()) == 1) {								
								if(lawflag){
									zipFileUtility.zipFile(srcLogFileObj.getAbsolutePath(), Law5651+"/"+deviceBean.getApplianceID()+"_"+srcLogFileObj.getName().split("[.]")[0]+".zip");
									CyberoamLogger.sysLog.debug(" LAW5651 Zip File Created :"+Law5651+"/"+deviceBean.getApplianceID()+"_"+srcLogFileObj.getName().split("[.]")[0]+".zip");
								}
								srcLogFileObj.delete();
								CyberoamLogger.sysLog.debug("Zip created for raw " + coldRAWDirWithDay);							
							} else {
								CyberoamLogger.sysLog.debug("Zip creation failed for raw " + coldRAWDirWithDay );							
							}						
						}else{
								srcMD5FileObj = new File(hotRAWDirPath + strMD5FileName);
								String [] rowFilesObj={srcLogFileObj.getAbsolutePath(),srcMD5FileObj.getAbsolutePath()};
								if (zipFileUtility.zipFiles(rowFilesObj, coldRAWDirWithDay.getAbsolutePath()) == 1) {
									if(lawflag){
										zipFileUtility.zipFiles(rowFilesObj, Law5651+"/"+deviceBean.getApplianceID()+"_"+srcLogFileObj.getName().split("[.]")[0]+".zip");
										CyberoamLogger.sysLog.debug(" LAW5651 Zip File Created :"+Law5651+"/"+deviceBean.getApplianceID()+"_"+srcLogFileObj.getName().split("[.]")[0]+".zip");
										//zipFileUtility.zipFile(rowFilesObj[1], Law5651+"/"+deviceBean.getApplianceID()+"_"+srcMD5FileObj.getName()+".zip");
									}
									srcLogFileObj.delete();
									srcMD5FileObj.delete();
									CyberoamLogger.sysLog.debug("Zip created for index : " + coldRAWDirWithDay);
								} else {
									CyberoamLogger.sysLog.debug("Zip creation failed for index " + coldRAWDirWithDay);
								}	
						}
						srcLogFileObj = null;
						}
						if(lawflag){
							//For DHCP
							String [] dhcphotflderlist=new File(iViewConfigBean .getValueByKey("ArchiveHome")+"dhcp/hot/rotated").list();
							File dhcpcoldfldr=new File(iViewConfigBean .getValueByKey("ArchiveHome")+"dhcp/cold");
							if(!dhcpcoldfldr.exists()){
								dhcpcoldfldr.mkdirs();
							}
							for(int k=0 ; k<dhcphotflderlist.length ; k++){
								File dhcphotflderfile=new File(iViewConfigBean .getValueByKey("ArchiveHome")+"dhcp/hot/rotated/"+dhcphotflderlist[k]);
//								if (zipFileUtility.zipFile(dhcphotflderfile.getAbsolutePath(), iViewConfigBean.getValueByKey("ArchiveHome")+"dhcp\\cold\\"+dhcphotflderfile.getName()+".zip") == 1) {							
									dhcphotflderfile.renameTo(new File(Law5651+"\\"+dhcphotflderlist[k]));
									CyberoamLogger.sysLog.debug(" LAW5651 DHCP File Moved:"+dhcphotflderlist[k]);
									
//								}
							}
						}
					}catch(Exception e){
						CyberoamLogger.sysLog.debug("FileManager.rawBlock.e : "+e,e );
					}
				}			
			}catch(Exception e){
				CyberoamLogger.sysLog.debug("FileManager.e : "+e,e );
			}
		}		
		CyberoamLogger.sysLog.debug(" FileManaget Thread execution end : ");		
	}
}
