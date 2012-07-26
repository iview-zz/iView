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
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.TreeSet;

import javax.servlet.http.HttpServletResponse;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import org.cyberoam.iview.beans.DataBaseConfigBean;
import org.cyberoam.iview.beans.FileHandlerBean;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This utility class is used for rotation of warm files.
 * This thread will rotate all archive and index logs which are older than given time.<br>
 * Functionality to remove cold data as per configuration in data configuration is also provided.
 * @author Narendra Shah
 *
 */
public class WarmFilesRotation implements Runnable {
	
	private static int percentageTaskCompleted;
	
	private static boolean processFlag=false;		
	
	private static String appIdList=null;
	
	private static String day=null;
	
	private static boolean unloadStatus=false;
	
	private static String categoryID = null;
	
	public static synchronized void setUnloadStatus(boolean value){
		unloadStatus = value;
	}
	
	public static boolean getUnloadStatus(){
		return unloadStatus;
	}
	
	public static void setPercentageTaskCompleted(int value){
		percentageTaskCompleted=value;
	}
	
	public static int getpercentageTaskCompleted(){
		return percentageTaskCompleted;
	}
	
	public static synchronized boolean setprocessFlag(boolean value){	
		if(value==true){
			if(getprocessFlag()!=true){
				processFlag=value;
			}else{
				return false;
			}
				
		}else{
			processFlag=value;
		}
		return true;
	}
	
	public static synchronized boolean getprocessFlag(){
		return processFlag;
	}
	
	public static void getTaskStatus(HttpServletResponse response){
		PrintWriter out=null;
		try{
			out=response.getWriter();
			response.setContentType("text/xml");
			out.println("<root>");
			CyberoamLogger.sysLog.info("<root>");
			out.println("<msg>");
			CyberoamLogger.sysLog.info("<msg>");
			out.println(getpercentageTaskCompleted() + " % completed");
			CyberoamLogger.sysLog.info(getpercentageTaskCompleted() + "% completed");
			out.println("</msg>");
			CyberoamLogger.sysLog.info("</msg>");
			out.println("<status>");
			CyberoamLogger.sysLog.info("<status>");
			if(getpercentageTaskCompleted()==100){
				out.println("0");
				CyberoamLogger.sysLog.info("0");				
			}else{
				out.println("1");
				CyberoamLogger.sysLog.info("1");				
			}
			out.println("</status>");
			CyberoamLogger.sysLog.info("</status>");
			
		}catch(Exception ex){
			CyberoamLogger.sysLog.info("Exception --> "+ ex, ex);			
		}
		out.println("</root>");
		CyberoamLogger.sysLog.info("</root>");
		out.close();
	}
	
	/**
	 * This method rotates both warm and cold folder files.
	 */
	public void run(){
		CyberoamLogger.sysLog.debug(" WarmFilesRotation Thread execution start : ");
		if(getprocessFlag()==false){
			rotateWarmData();
			rotateColdData();
		}else{
			WarmFilesRotation.unloadWarmFile();
		}				
	}
	
	
	public static void startThread(String appIdList, String day, String categoryID,HttpServletResponse response){
		PrintWriter out=null;
		String msg="Unloading Process Started";
		CyberoamLogger.sysLog.info("Request Time1: " + (new Date()).getTime());
		if(getprocessFlag()==false){
			CyberoamLogger.sysLog.info("Request Time2: " + (new Date()).getTime());
			if(setprocessFlag(true)==true){
				WarmFilesRotation.appIdList=appIdList;
				WarmFilesRotation.day=day;
				WarmFilesRotation.categoryID = categoryID;
				try{
					out=response.getWriter();
					response.setContentType("text/xml");
					Thread warmFileRotationThread= new Thread(new WarmFilesRotation());
					warmFileRotationThread.start();					
				}catch(Exception ex){
					msg="Error in Processing";
					CyberoamLogger.sysLog.info("Exception: " + ex);
					setprocessFlag(false);
				}
			}else{
				msg="Process already Running";
				CyberoamLogger.sysLog.info(msg);
			}
		}else{
			msg="Process already Running";
			CyberoamLogger.sysLog.info(msg);
		}
		out.println("<root>");
		CyberoamLogger.sysLog.info("<root>");
		out.println("<msg>");
		out.println(msg);
		CyberoamLogger.sysLog.info(msg);
		out.println("</msg>");
		out.println("<status>");
		out.println("1");
		out.println("</status>");
		out.println("</root>");		
		CyberoamLogger.sysLog.info("</root>");
		out.close();						
	}
	
	/**
	 * This method uses rotateWarmData() to unload Warm files on request
	 */	
	public static void unloadWarmFile(){
		TreeSet deviceSet=null;
		String []device=null;
		String val=null;
		Iterator deviceIt=null;
		int count=0;					
		try{			
			device=appIdList.split(",");
			if(device!=null){
				deviceSet=new TreeSet();
				for(int i=0;i<device.length;i++){
					deviceSet.add(device[i]);
					count++;
				}
				deviceIt=deviceSet.iterator();				
				if(deviceIt!=null){
					setPercentageTaskCompleted(0);
					int i=0;
					performRotationForUnload();
					/*while(deviceIt.hasNext()){
						val=deviceIt.next().toString();
						CyberoamLogger.sysLog.info("Device: --> " + val);			
						performRotation(val.substring(1, val.length()-1), day);
						i++;
						setPercentageTaskCompleted((int)((i*100)/count));
					}*/
					setPercentageTaskCompleted(100);											
				}
			}
		}catch(Exception ex){
			CyberoamLogger.sysLog.info("Exception in WarmfileRotation --> " + ex,ex);
		}						
		CyberoamLogger.sysLog.info("Request Time3: " + (new Date()).getTime());
		setprocessFlag(false);
	}
	
	
	/**
	 * This method returns File Objects for each file in Given Directory
	 */
	private static File[] getDirContent(File dir,String day){		
		if(day==null){
			return dir.listFiles();
		}else{		
			File []files=new File[1];			
			files[0]=new File(dir.getAbsolutePath()+"/"+day);
			if(files[0]!=null && files[0].exists())
				return files;
			else
				return null;
		}
	}
	
	private static void performRotation(String applianceId,String dayList){
		int noOfRecord=-1;
		//String warmIndexDirPath="";
	//	String loadedDataIndexDirPath = "";
		String warmRAWDirPath="";
		//String updateCmd="delete from tblindex"+ dayList+" where device_name='"+applianceId+"'";
		String countCmd="select count(*) As Count from tblindex"+dayList;
		//CyberoamLogger.sysLog.info("Delete Query: " + updateCmd);
		CyberoamLogger.sysLog.info("Select Query: " + countCmd);
		ResultSetWrapper rsw=null;
		try{
			//warmIndexDirPath=IViewPropertyReader.IndexDIR+applianceId+ IViewPropertyReader.WARM;
			warmRAWDirPath=IViewPropertyReader.ArchieveDIR+applianceId+IViewPropertyReader.WARM;
			//loadedDataIndexDirPath = IViewPropertyReader.IndexDIR;
			
			
			CyberoamLogger.sysLog.info("Row Dir Path: "+ warmRAWDirPath);
			/*File IndexDIRObj = new File(warmIndexDirPath);
			if(!IndexDIRObj.exists())
				return;*/
			//File IndexDIRlist[] = IndexDIRObj.listFiles(new FileFilter(IViewPropertyReader.IndexLogFileFilterRegExp));
			/*File IndexDIRlist[] =getDirContent(IndexDIRObj,dayList);
			CyberoamLogger.sysLog.info("WARM : DAYLIST VAL : _--"+dayList);
			File loadedIndexDatelist[] =getDirContent(new File(loadedDataIndexDirPath),dayList);
			CyberoamLogger.sysLog.debug(" DIR List --> "+IndexDIRlist);
			/*
			 * Get All newly created files from Indexed HOT DIR
			 * Iterate each file one bye one  
			*/
		/*	if(IndexDIRlist!=null) {				
				for(int filecount=0;filecount<IndexDIRlist.length;filecount++){
					if(IndexDIRlist[filecount].isDirectory()){
						
						/*
						 * Select next file from list and parse file name
						 * Prepare File Information and insert into Database
						 * We parse file creation and file event time stamp from filename
						 * We get filename,filesize and isloaded set default false  
						 * We set lastaccesstime with current time
						*/
					/*	File dir = IndexDIRlist[filecount];
						int count;												
						if (dir.isDirectory()) {
							long longRetailFilesTime = System.currentTimeMillis() - (1000*60*60*24*IViewPropertyReader.RetainWARMFilesForDay);
							DateFormat df = new SimpleDateFormat("yyyyMMdd");
							long longCurrentFilesTime = df.parse(dir.getName()).getTime();											
							CyberoamLogger.sysLog.error(" Directory Time --> " + longCurrentFilesTime + "  AND Retail File Time -->" + longRetailFilesTime );
							if(longCurrentFilesTime < longRetailFilesTime  || dayList!=null){																									
					            String[] children = dir.list();						            
					            for (int i=0; i<children.length; i++) {
					            	try{
					            		(new File(dir, children[i])).delete();
					            							            							            		
					            		String fileNameParts[] = children[i].split("_");							
										long timestamp = Long.parseLong(fileNameParts[2].substring(0, fileNameParts[2].indexOf('.')));												
										String dateQuery = "select FROM_UNIXTIME(" + timestamp + ")";																												
										String dateParts[] = ((SqlReader.getResultAsArrayList(dateQuery, 1000)).get(0)).toString().split("-");
										String tableName = new String("tblfilelist"+dateParts[0].substring(1)+dateParts[1]+(dateParts[2]).substring(0,2));										
										
					            		FileHandlerBean.updateLoadedIndexedFileStatus(children[i],tableName,0);
					            	}catch(Exception e){
					            		CyberoamLogger.sysLog.error(" Exception while deleting Index file and table --> "+children[i]);
					            	}
					            }					           
					            dir.delete();						            
					        }
						}
					}
				}
			}
			if(loadedIndexDatelist != null){
				try{
					for(int i=0 ; i<loadedIndexDatelist.length ; i++){
						String[] timeStampArr = loadedIndexDatelist[i].list();
						for(int j=0 ; j<timeStampArr.length ; j++){
							CyberoamLogger.appLog.error("time stamp directory path: "+loadedIndexDatelist[i].getPath()+"/"+timeStampArr[j]);
							File timeStampDir = new File(loadedIndexDatelist[i].getPath()+"/"+timeStampArr[j]);
							if(timeStampDir != null && timeStampDir.isDirectory()){
								String[] timeStampFiles = timeStampDir.list();
								for(int k=0 ; k<timeStampFiles.length ; k++){
									CyberoamLogger.appLog.error("time stamp files: "+loadedIndexDatelist[i].getPath()+"/"+timeStampArr[j]+"/"+timeStampFiles[k]);
									(new File(loadedIndexDatelist[i].getPath()+"/"+timeStampArr[j]+"/"+timeStampFiles[k])).delete();
									FileHandlerBean.updateLoadedIndexedFileStatus(timeStampFiles[k],"tblfilelist",0);
								}
								timeStampDir.delete();
								timeStampDir = null;
							}
						}
						loadedIndexDatelist[i].delete();
						loadedIndexDatelist[i] = null;
					}
				}catch(Exception e){
					CyberoamLogger.appLog.error("exception in date directory listing: "+e,e);
				}
			}*/
			File archiveDIRObj = new File(warmRAWDirPath);
			if(!archiveDIRObj.exists())
				return;
			//File archiveDIRlist[] = archiveDIRObj.listFiles(new FileFilter(IViewPropertyReader.RowLogFileFilterRegExp));
			File archiveDIRlist[] = getDirContent(archiveDIRObj,dayList);
			if(archiveDIRlist!=null){
				for(int filecount=0;filecount<archiveDIRlist.length;filecount++){
					if(archiveDIRlist[filecount].isDirectory()){
						
						/*
						 * Select nect file from list and parse file name
						 * Prepare File Information and insert into Database
						 * We parse file creation and file event time stamp from filename
						 * We get filename,filesize and isloaded set default false  
						 * We set lastaccesstime with current time
						*/
						File dir = archiveDIRlist[filecount];
					    if (dir.isDirectory()) {
							CyberoamLogger.sysLog.error(" Deleting Archiving files of day --> "+dir.getName());
							long longRetailFilesTime = System.currentTimeMillis() - (1000*60*60*24*IViewPropertyReader.RetainWARMFilesForDay);
							DateFormat df = new SimpleDateFormat("yyyyMMdd");
							long longCurrentFilesTime = df.parse(dir.getName()).getTime();
							//long longCurrentFilesTime = new Date(Integer.parseInt(dir.getName().substring(0,4)),Integer.parseInt(dir.getName().substring(4,6)),Integer.parseInt(dir.getName().substring(6,8))).getTime();
							CyberoamLogger.sysLog.error(" Directory Time --> " + longCurrentFilesTime + "  AND Retail File Time --> " + longRetailFilesTime );
							if(longCurrentFilesTime < longRetailFilesTime ||dayList!=null){ 
					            String[] children = dir.list();
					            for (int i=0; i<children.length; i++) {
					            	try{
					            		(new File(dir, children[i])).delete();
					            	}catch(Exception e){
					            		CyberoamLogger.sysLog.error(" Exception while deleting Archive file --> "+children[i]);
					            	}
					            }
					            dir.delete();
					        }
						}
					}
				}
			}				
		}catch(Exception ex){
			CyberoamLogger.sysLog.debug("performRotation->Warm file rotation error: " +ex,ex);
			CyberoamLogger.sysLog.info("performRotation->Warm file rotation error: " +ex.getMessage());
		}
	}
	
	private static void performRotationForUnload(){
		try{		
			String day = WarmFilesRotation.day;	
			CyberoamLogger.appLog.error("performRotationForUnload day: "+day);
			String date = day.substring(0,4)+"-"+day.substring(4,6)+"-"+day.substring(6,8);
			CyberoamLogger.appLog.error("performRotationForUnload date: "+date);
			ArrayList fileList = FileHandlerBean.getFileList("", "", date, date);
			CyberoamLogger.appLog.error("performRotationForUnload fileList.size(): "+fileList.size());
			ArrayList deviceList = new ArrayList();
			FileHandlerBean fileHandlerBean = null;
			//File indexFile = null;
			File archiveFile = null;
			
		/*	for(int i=fileList.size()-1 ; i >= 0 ; i--)	{
				fileHandlerBean = (FileHandlerBean)fileList.get(i);
				indexFile = new File(IViewPropertyReader.IndexDIR+fileHandlerBean.getAppID()+
  						IViewPropertyReader.WARM+day+"/"+fileHandlerBean.getFileName());				
				
				if(indexFile.exists())
					indexFile.delete();
								
				indexFile = null;
				
				if(!deviceList.contains(fileHandlerBean.getAppID()))
					deviceList.add(fileHandlerBean.getAppID());
			}*/		
			for(int iCnt = 0 ; iCnt<deviceList.size() ; iCnt++){
				/*File dayFileIndex = new File(IViewPropertyReader.IndexDIR+deviceList.get(iCnt)+
							IViewPropertyReader.WARM+day);			
			
				if(dayFileIndex.isDirectory() && dayFileIndex.list().length == 0)
					dayFileIndex.delete();
				
				dayFileIndex = null;
				*/
				archiveFile = new File(IViewPropertyReader.ArchieveDIR+deviceList.get(iCnt)+
							IViewPropertyReader.WARM+day);
				if(archiveFile.exists() && archiveFile.isDirectory())
				{
					File[] archiveDirList = archiveFile.listFiles();
					for(int i=0 ; i<archiveDirList.length ; i++){
						archiveDirList[i].delete();
						archiveDirList[i] = null;
					}
				}
				if(archiveFile.exists() && archiveFile.list().length == 0)
					archiveFile.delete();
				archiveFile = null;
			}						
			
		/*	File loadedIndexDatelist = new File(IViewPropertyReader.IndexDIR+"category"+categoryID+"/"+day);
			if(loadedIndexDatelist != null && loadedIndexDatelist.isDirectory())
			{
				String[] timeStampArr = loadedIndexDatelist.list();
				for(int j=0 ; j<timeStampArr.length ; j++){
					CyberoamLogger.appLog.error("time stamp directory path: "+loadedIndexDatelist.getPath()+"/"+timeStampArr[j]);
					File timeStampDir = new File(loadedIndexDatelist.getPath()+"/"+timeStampArr[j]);
					if(timeStampDir != null && timeStampDir.isDirectory()){
						String[] timeStampFiles = timeStampDir.list();
						for(int k=0 ; k<timeStampFiles.length ; k++){
							CyberoamLogger.appLog.error("time stamp files: "+loadedIndexDatelist.getPath()+"/"+timeStampArr[j]+"/"+timeStampFiles[k]);
							(new File(loadedIndexDatelist.getPath()+"/"+timeStampArr[j]+"/"+timeStampFiles[k])).delete();							
						}
						timeStampDir.delete();
						timeStampDir = null;
					}
				}
				loadedIndexDatelist.delete();
				loadedIndexDatelist = null;
			}
			File loadedIndexCategory = new File(IViewPropertyReader.IndexDIR+"category"+categoryID);
			if(loadedIndexCategory != null && loadedIndexCategory.isDirectory() && loadedIndexCategory.list().length == 0)
				loadedIndexCategory.delete();
			*/
			long startDate = new SimpleDateFormat("yyyyMMdd hh:mm:ss").parse(day+" 00:00:00").getTime();
			long endDate = new SimpleDateFormat("yyyyMMdd hh:mm:ss").parse(day+" 23:59:59").getTime();
			String fileTimestamp = null;
			if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
				fileTimestamp = "fileeventtimestamp";
			}else{
				fileTimestamp = "filecreationtimestamp";
			}
			String whereCriteria = "where "+fileTimestamp+" between '"+startDate/1000+"' and '"+endDate/1000+"'";
			CyberoamLogger.appLog.error("performRotationForUnload where criteria: "+whereCriteria);
			FileHandlerBean.updateLoadedindexFileStatusForDateRange(whereCriteria, "tblfilelist"+day, 0);
		
			
		}catch(Exception e){
			CyberoamLogger.sysLog.debug("exception is performRotationForUnload: "+e,e);
		}
		
	}
	/**
	 * This method rotates warm folder files.
	 */

	private static void rotateWarmData(){
		try{
			CyberoamLogger.sysLog.debug(" Warm file rotation start : ");
			Iterator activeDeviceBeanItr=DeviceBean.getDeviceBeanIterator();
			DeviceBean deviceBean=null;			
			while(activeDeviceBeanItr.hasNext()){				
				deviceBean=(DeviceBean)activeDeviceBeanItr.next();
				performRotation(deviceBean.getApplianceID(), null);
			}			
		}catch(Exception e){
			CyberoamLogger.sysLog.debug("RotateWarmData->Warm file rotation error:" +e,e);
		}
		CyberoamLogger.sysLog.debug(" WarmFilesRotation Thread execution end : ");
	}
	
	/**
	 * This method delete file entry from database.
	 */
	
	private static int deleteFromDatabase(String dt,String filename){
		SqlReader sqlReader = null;
		int deleteValue = -1;
		try{
			sqlReader = new SqlReader(false);
			deleteValue=sqlReader.executeUpdate("delete from tblfilelist"+dt+" where filename='"+filename+"' ;",5);
		}catch(Exception e){
			CyberoamLogger.sysLog.error(" Exception->deleteRecord()->DeviceBean: " + e,e);
			deleteValue = -1;			
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){}
		}
		return deleteValue;		
	}
	
	/**
	* This method rotates cold folder files. 
	*/
	
	private static void rotateColdData(){
		CyberoamLogger.sysLog.debug(" Cold file rotation start : ");
		try{
			Iterator activeDeviceBeanItr=DeviceBean.getDeviceBeanIterator();
			int retainDay=Integer.parseInt(DataBaseConfigBean.getValue(DataBaseConfigBean.ARHIEVE_DATA));
			
			/*
			 * Archieve Configuration is forever or disable then no need to delete any file.  
			 */
			if(retainDay <= 0){
				CyberoamLogger.sysLog.debug(" Cold Files Rotation Thread execution end as retention for dataconfig is disable or forever: ");
				return;
			}
				
			long longRetailFilesTime = System.currentTimeMillis() - (1000l*60l*60l*24l*retainDay);
			Calendar preserveLastDate=Calendar.getInstance();
			preserveLastDate.setTimeInMillis(longRetailFilesTime);
			
			AuditLog.data.notice("Archieve(cold) log file will be deleted till date(dd-mm-yyyy) " + preserveLastDate.get(Calendar.DAY_OF_MONTH) +"-"+ preserveLastDate.get(Calendar.MONTH) +"-"+ preserveLastDate.get(Calendar.YEAR) , null);
			CyberoamLogger.sysLog.debug("presrve day:" + retainDay + "### for date" + preserveLastDate.get(Calendar.DAY_OF_MONTH) +"-"+ preserveLastDate.get(Calendar.MONTH) + preserveLastDate.get(Calendar.YEAR)   );
			DeviceBean deviceBean=null;
			//String coldIndexDirPath="";
			String coldRAWDirPath="";
			while(activeDeviceBeanItr.hasNext()){
				
				deviceBean=(DeviceBean)activeDeviceBeanItr.next();
				//coldIndexDirPath=IViewPropertyReader.IndexDIR+deviceBean.getApplianceID()+ IViewPropertyReader.COLD;
				coldRAWDirPath=IViewPropertyReader.ArchieveDIR+deviceBean.getApplianceID()+IViewPropertyReader.COLD;
				/*File IndexDIRObj = new File(coldIndexDirPath);
				if(!IndexDIRObj.exists())
					continue;
				File IndexDIRlist[] = IndexDIRObj.listFiles();
				CyberoamLogger.sysLog.debug(" DIR List --> "+IndexDIRlist);
				/*
				 * Get All newly created files from Indexed Cold DIR
				 * Iterate each file one bye one  
				*/
			/*	for(int filecount=0;filecount<IndexDIRlist.length;filecount++){
					if(IndexDIRlist[filecount].isDirectory()){						
				*/		/*
						 * Select nect file from list and parse file name
						 * Prepare File Information and insert into Database
						 * We parse file creation and file event time stamp from filename
						 * We get filename,filesize and isloaded set default false  
						 * We set lastaccesstime with current time
						*/
						/*File dir = IndexDIRlist[filecount];
						if (dir.isDirectory()) {
							
							DateFormat df = new SimpleDateFormat("yyyyMMdd");
							long longCurrentFilesTime = df.parse(dir.getName()).getTime();
							CyberoamLogger.sysLog.error(" Directory Time --> " + longCurrentFilesTime  );
							if(longCurrentFilesTime < longRetailFilesTime){
								if(FileHandlerBean.isTableExists("tblindex"+dir.getName())==1){
									FileHandlerBean.dropTable("tblindex"+dir.getName());
								}
								// drop tblfilelisttimestamp
								if(FileHandlerBean.isTableExists("tblfilelist"+dir.getName())==1){
									FileHandlerBean.dropTable("tblfilelist"+dir.getName());
								}
								
								CyberoamLogger.sysLog.error(" Deleting Cold Index files from dir --> "+dir.getName());
					            String[] children = dir.list();
					            for (int i=0; i<children.length; i++) {
					            	CyberoamLogger.sysLog.debug(" Delete the index file with dir :" + dir + " and file " + children[i]);
					            	CyberoamLogger.sysLog.debug(" Delete the index table content for :" +  children[i].substring(0, children[i].length()-4));
					            	try{
					            		(new File(dir, children[i])).delete();
					            		if(FileHandlerBean.isTableExists(children[i].substring(0,children[i].length()-4)) == 1){
					            			FileHandlerBean.dropTable(children[i].substring(0,children[i].length()-4));
					            		}			            					            							            		
					            
					            	//FileHandlerBean.deleteIndexedFile(children[i].substring(0, children[i].length()-4));
					            	}catch(Exception e){
					            		CyberoamLogger.sysLog.error(" Exception while deleting Index file and table --> "+children[i]);
					            	}
					            }
							  dir.delete();
							}else {
					        	CyberoamLogger.sysLog.debug("skipping " + dir);
					        }
						}
					}
				}*/
				
				File archiveDIRObj = new File(coldRAWDirPath);
				if(!archiveDIRObj.exists())
					continue;
				File archiveDIRlist[] = archiveDIRObj.listFiles();
				for(int filecount=0;filecount<archiveDIRlist.length;filecount++){
					if(archiveDIRlist[filecount].isDirectory()){						
						/*
						 * Select nect file from list and parse file name
						 * Prepare File Information and insert into Database
						 * We parse file creation and file event time stamp from filename
						 * We get filename,filesize and isloaded set default false  
						 * We set lastaccesstime with current time
						*/
						File dir = archiveDIRlist[filecount];
					    if (dir.isDirectory()) {
							CyberoamLogger.sysLog.error(" Deleting Archiving files of day --> "+dir.getName());
							DateFormat df = new SimpleDateFormat("yyyyMMdd");
							long longCurrentFilesTime = df.parse(dir.getName()).getTime();
							//long longCurrentFilesTime = new Date(Integer.parseInt(dir.getName().substring(0,4)),Integer.parseInt(dir.getName().substring(4,6)),Integer.parseInt(dir.getName().substring(6,8))).getTime();
							CyberoamLogger.sysLog.error(" Directory Time --> " + longCurrentFilesTime + "  AND Retail File Time --> " + longRetailFilesTime );
							if(longCurrentFilesTime < longRetailFilesTime){
					            String[] children = dir.list();
					            for (int i=0; i<children.length; i++) {
					            	CyberoamLogger.sysLog.debug(" Delete the archive file with dir :" + dir + " and file " + children[i]);
					            	try{
					            	 	(new File(dir, children[i])).delete();
					            	 	long timestamp =Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(children[i]));
					            	 	String date=DateDifference.UnixToDateString(timestamp);
					            	 	CyberoamLogger.sysLog.info("date : "+date);
					            	 	if(WarmFilesRotation.deleteFromDatabase(date, children[i].replaceAll("zip", "log"))<=0){
					            	 		CyberoamLogger.sysLog.info(children[i]+" File is not deleted from database");
					            	 	}
					            	}catch(Exception e){
					            		CyberoamLogger.sysLog.error(" Exception while deleting Archive file --> "+children[i]);
					            	}
					            }
							  dir.delete();
							 }else {
					        	CyberoamLogger.sysLog.debug("skipping " + dir);
					        }
						}
					}
				}				
			}			
			//FileHandlerBean.deleteRecordsOlderThan(longRetailFilesTime);
		}catch(Exception e){
			CyberoamLogger.sysLog.debug("Cold file Rotatation error e:" +e ,e);
		}
		CyberoamLogger.sysLog.debug(" Cold Files Rotation Thread execution end : ");
	}


	public static void unLoadAll(String catID)
	{		
		try{
			// deleting files from warm folder of each device		
			String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(Integer.parseInt(catID));
			DeviceBean deviceBean = null;
			String warmDirPath;
			String archiveDirPath;
			
			if(deviceIds!=null && deviceIds.length > 0){
				for(int i=0;i<deviceIds.length;i++){
					deviceBean=DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));
					
					//removing files from index folder
					warmDirPath=IViewPropertyReader.IndexDIR+deviceBean.getApplianceID()+IViewPropertyReader.WARM;				
					File IndexDIRObj = new File(warmDirPath);
					String[] loadedIndexDatelist = IndexDIRObj.list();
					File IndexDIRlist[] = IndexDIRObj.listFiles();
				
					if(IndexDIRObj.exists())
					{
						for(int filecount=0;filecount<IndexDIRlist.length;filecount++){					
							if(IndexDIRlist[filecount].isDirectory()){													
								File fileList[] = IndexDIRlist[filecount].listFiles();
								String[] fileDelList = IndexDIRlist[filecount].list();
								for(int ctr=0;ctr<fileList.length;ctr++){
									FileHandlerBean.updateLoadedIndexedFileStatus(fileDelList[ctr],"tblfilelist"+loadedIndexDatelist[filecount],0);
									fileList[ctr].delete();																	
								}
								IndexDIRlist[filecount].delete();
							}						
						}
						IndexDIRObj.delete();
						CyberoamLogger.sysLog.info("WarmFilesRotation->unLoadAll(): folder deleted:: "+warmDirPath);
					}
				
					//removing files from archive folder
					archiveDirPath=IViewPropertyReader.ArchieveDIR+deviceBean.getApplianceID()+IViewPropertyReader.WARM;				
					File ArchiveDIRObj = new File(archiveDirPath);
					File ArchiveDIRlist[] = ArchiveDIRObj.listFiles();
				
					if(ArchiveDIRObj.exists())
					{
						for(int filecount=0;filecount<ArchiveDIRlist.length;filecount++){					
							if(ArchiveDIRlist[filecount].isDirectory()){													
								File fileList[] = ArchiveDIRlist[filecount].listFiles();
								for(int ctr=0;ctr<fileList.length;ctr++){																			
									fileList[ctr].delete();																	
								}
								ArchiveDIRlist[filecount].delete();
							}						
						}
						ArchiveDIRObj.delete();
						CyberoamLogger.sysLog.info("WarmFilesRotation->unLoadAll(): folder deleted:: "+archiveDirPath);
					}
								
					if(loadedIndexDatelist != null){
						try{
							File tempFile = null;
							for(i=0 ; i<loadedIndexDatelist.length ; i++){
								tempFile = new File(IViewPropertyReader.IndexDIR+"category"+catID+"/"+loadedIndexDatelist[i]);
								CyberoamLogger.appLog.error("date directory path: "+IViewPropertyReader.IndexDIR+"category"+categoryID+"/"+loadedIndexDatelist[i]);
								if(tempFile.exists()){
									String[] timeStampArr = tempFile.list();
									for(int j=0 ; j<timeStampArr.length ; j++){
										CyberoamLogger.appLog.error("time stamp directory path: "+tempFile.getPath()+"/"+timeStampArr[j]);
										File timeStampDir = new File(tempFile.getPath()+"/"+timeStampArr[j]);
										if(timeStampDir != null && timeStampDir.isDirectory()){
											String[] timeStampFiles = timeStampDir.list();
											for(int k=0 ; k<timeStampFiles.length ; k++){
												CyberoamLogger.appLog.error("time stamp files: "+tempFile.getPath()+"/"+timeStampArr[j]+"/"+timeStampFiles[k]);
												(new File(tempFile.getPath()+"/"+timeStampArr[j]+"/"+timeStampFiles[k])).delete();									
											}
											timeStampDir.delete();
											timeStampDir = null;
										}
									}
									tempFile.delete();
									tempFile = null;
								}						
							}
							tempFile = new File(IViewPropertyReader.IndexDIR+"category"+catID);
							if(tempFile.exists() && tempFile.isDirectory() && tempFile.list().length == 0){
								tempFile.delete();
								tempFile = null;
							}
						}catch(Exception e){
							CyberoamLogger.appLog.error("exception in date directory listing: "+e,e);
						}
					}
				}
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("exception in unload all: "+e);
		}
	}
}
