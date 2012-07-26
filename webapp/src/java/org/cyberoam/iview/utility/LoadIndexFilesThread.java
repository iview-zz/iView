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
import java.util.ArrayList;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.Vector;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.FileHandlerBean;
import org.cyberoam.iview.helper.LoadDataHandler;


/**
 * <p>This Thread class is used to give progress of loading index files in table.</p>
 * 
 * @author Narendra Shah
 *
 */
public class LoadIndexFilesThread implements Runnable{
	private ArrayList indexFileList=null;
	private ArrayList appIDList=null;
	private String checkedDate;
	private static int processedFiles = 0;
	private String categoryID = null;
	
	/**
	 * Default constructor for {@link LoadIndexFilesThread}. 
	 */
	public LoadIndexFilesThread(){}
	
	/**
	 * 
	 * This constructor initializes index file list, appliance Ids, table name and list of table for merging. 
	 * @param indexFileList
	 * @param appIDs	 
	 * @param checkedDate
	 */
	public LoadIndexFilesThread(ArrayList indexFileList,ArrayList appIDs,String tablename,String checkedDate,String categoryID){
		this(indexFileList,appIDs);
		this.checkedDate = checkedDate;
		this.categoryID = categoryID;
	}
	/**
	 * This constructor initializes index file list, appliance Ids, table name and list of table for merging. 
	 * @param indexFileList
	 * @param appIDs
	 * @param tablename
	 * @param mergetablelist
	 */
	public LoadIndexFilesThread(ArrayList indexFileList,ArrayList appIDs){
		this.indexFileList=indexFileList;
		this.appIDList=appIDs;	
	}
	
	/**
	 * When we load data for the searching purpose then in that case this method will create indexing for
	 * selected hours logs and it will create thread for each selected hours logs 
	 */
			
	public void run()
	{		
		CyberoamLogger.appLog.error("run method of loadindexfilesthread.java");
		int totalFiles = 0;		
		
		StringTokenizer selectedDates = new StringTokenizer(checkedDate,",");
		Vector threadPool = new Vector();
		
		CyberoamLogger.appLog.error("total files: "+totalFiles);
		CyberoamLogger.appLog.error("total dates: "+checkedDate);
		try {
			/*
			 * the LoadDataHandler.setCommit(0) says that the data we are loading is not committed
			 * so we will display committing process after the indexing gets over  
			 */
			LoadDataHandler.setCommit(0);
			setProcessedFiles();
			/*
			 * the below while loop will iterate for number of timestamp we have selected for loading 
			 * and in each iteration different thread gets created and that will work on that perticular 
			 * timestamp
			 */
			while(selectedDates.hasMoreTokens())	{
				CyberoamLogger.appLog.error("in while loop of string tokenizer");
				String range = selectedDates.nextToken();			
				try	{															
					long startDate = new SimpleDateFormat("yyyyMMdd hh:mm:ss").parse(range.substring(0,range.indexOf(" "))+" "+range.substring(range.indexOf(" ")+1,range.indexOf("_"))+":00:00").getTime();
					long endDate = new SimpleDateFormat("yyyyMMdd hh:mm:ss").parse(range.substring(0,range.indexOf(" "))+" "+range.substring(range.indexOf("_")+1,range.length())+":59:59").getTime();
										
					String sDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyyMMdd").parse(range.substring(0,range.indexOf(" "))));
					String eDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyyMMdd").parse(range.substring(0,range.indexOf(" "))));
					
					CyberoamLogger.appLog.error("sDate loadindexfilesthread: "+sDate);
					CyberoamLogger.appLog.error("eDate loadindexfilesthread: "+eDate);
					String dateFolder = range.substring(0,range.indexOf(" "));
					
					String fileTimestamp = "";
					CyberoamLogger.appLog.error("start date: "+startDate);
					CyberoamLogger.appLog.error("end date: "+endDate);
					if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
						fileTimestamp = "fileeventtimestamp";
					}else{
						fileTimestamp = "filecreationtimestamp";
					}
					String deviceCriteria = "";
					ArrayList addedAppList = new ArrayList();
					for(int dev=0 ; dev<appIDList.size() ; dev++){
						if(!addedAppList.contains(appIDList.get(dev))){
							addedAppList.add(appIDList.get(dev));
							if(deviceCriteria.equals(""))
								deviceCriteria += "and appid='"+appIDList.get(dev)+"'";
							else
								deviceCriteria += "or appid='"+appIDList.get(dev)+"'";
						}						
					}
					String criteria = "where isloaded=0 and "+fileTimestamp+" between '"+startDate/1000+"' and '"+endDate/1000+"'";					
					criteria += deviceCriteria;
					CyberoamLogger.appLog.error("load query: "+criteria);
					ArrayList fileList = FileHandlerBean.getFileList(criteria, "", sDate, eDate);
					totalFiles += fileList.size();
					
					/*
					 * IndexFilesThread is a thread which will index the data according to timestamp 
					 * e.g. if we do have 2 ranges of data to load like 00_05 and 06_11 then here 2 threads
					 * will created and that 2 thread will work on their specific timestamp data
					 */
					File rangeDir = new File(IViewPropertyReader.IndexDIR+"category"+categoryID+"/"+dateFolder+"/"+range.substring(range.indexOf(" ")+1,range.length()));
					if(!rangeDir.exists())
						rangeDir.mkdirs();
					else{
						rangeDir = new File(IViewPropertyReader.IndexDIR+"category"+categoryID+"/"+dateFolder+"/"+"temp"+range.substring(range.indexOf(" ")+1,range.length()));
					}

					File dateDir = new File(IViewPropertyReader.IndexDIR+"category"+categoryID+"/"+dateFolder);
					boolean isLock = false;
					for(File rangeDirVal : dateDir.listFiles()){
						for(String fileVal : rangeDirVal.list()){
							if(fileVal.equalsIgnoreCase("write.lock")){
								isLock = true;
								break;
							}							
						}
						if(isLock)
							break;
					}
					if(isLock){
						for(File rangeDirVal : dateDir.listFiles()){
							for(File fileVal : rangeDirVal.listFiles()){
								fileVal.delete();
							}
							if(!rangeDirVal.getName().equals(range.substring(range.indexOf(" ")+1,range.length()))){
								rangeDirVal.delete();
							}
							else
								rangeDir = new File(IViewPropertyReader.IndexDIR+"category"+categoryID+"/"+dateFolder+"/"+range.substring(range.indexOf(" ")+1,range.length()));
						}	
						String whereCriteria = "where isloaded=1 and "+fileTimestamp+" between '"+startDate/1000+"' and '"+endDate/1000+"'";
						FileHandlerBean.updateLoadedindexFileStatusForDateRange(whereCriteria,"tblfilelist"+dateFolder,0);
					}
					
					IndexFilesThread indexedFilesThread = new IndexFilesThread(IViewPropertyReader.IndexDIR, fileList, dateFolder, range.substring(range.indexOf(" ")+1,range.length()), deviceCriteria,startDate/1000,endDate/1000,categoryID);
					
					threadPool.add(indexedFilesThread);
				}
				catch(Exception e)	{
					CyberoamLogger.appLog.error("Exception in LoadedIndexFilesThread: "+e,e);
				}					
			}
			/*
			 * for loop in which Main thread will wait for its further execution until all the threads 
			 * will finish their work 
			 */
			for(int i=0 ; i < threadPool.size() ; i++){
				((IndexFilesThread)threadPool.get(i)).setTotalFiles(totalFiles);
				CyberoamLogger.appLog.error("Indexing Start: "+new Date());
				((IndexFilesThread)threadPool.get(i)).start();				
			}
			for(int k=0 ; k < threadPool.size() ; k++)		{								
					CyberoamLogger.appLog.debug("going to wait for joining thread :" + ((IndexFilesThread)threadPool.get(k))) ;
					((IndexFilesThread)threadPool.get(k)).join();
					CyberoamLogger.appLog.debug("competed joining thread:" + ((IndexFilesThread)threadPool.get(k))) ;
			}
			CyberoamLogger.appLog.error("Indexing End: "+new Date());
			/*
			 * LoadDataHandler.setCommit(1) says that here our all the data which we are indexing has get
			 * committed and the committing process should get stop 
			 */
			
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("LoadIndexFilesThread.run: " +e ,e);
		}finally{
			LoadDataHandler.setCommit(1);
			LoadDataHandler.setProcessPercentComplete(100);
		}
	}
	
	synchronized public static void setProcessedFiles(){
		processedFiles = 0;		
	}
	synchronized public static int getProcessedFiles(){
		processedFiles += 1;
		return processedFiles;
	}
}
