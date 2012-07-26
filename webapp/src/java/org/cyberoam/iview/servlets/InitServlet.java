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

package org.cyberoam.iview.servlets;


import java.io.File;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.helper.ScheduledReporter;
import org.cyberoam.iview.system.utility.SystemInformation;
import org.cyberoam.iview.search.IndexDeleteThread;
import org.cyberoam.iview.search.IndexManager;
import org.cyberoam.iview.search.IndexSchedulerThread;
import org.cyberoam.iview.utility.Alarms;
import org.cyberoam.iview.utility.GarnerManager;
import org.cyberoam.iview.helper.ScheduleBackupThread;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This servlet is used for processing required while initialization of iView web application.
 * @author Narendra Shah
 *
 */
public class InitServlet extends HttpServlet{
	
	public static String contextPath = "";
	
	/**
	 * This method initializes file manager thread, disk monitor and warm file rotation thread. 
	 */
	public void init() throws ServletException {
		contextPath = getServletContext().getRealPath(System.getProperty("file.separator"));
		CyberoamLogger.appLog.debug(" InitServlet init method called ");
		try{
			CyberoamLogger.appLog.debug("Write ipaddress,active and inactive device files.");
			
			DeviceBean.writeActiveFile();
			DeviceBean.writeInActiveFile();
			DeviceBean.writeIPAddressFile();
			
			CyberoamLogger.appLog.debug(" Start garner ");
			GarnerManager.restart();
			
			//For Post Installation of Upgrade
			getPostInstallStatus();
		
			// File Manager
			CyberoamLogger.appLog.debug(" Adding schedule entry for FileManagerThread  ");						
			Alarms.addFileManagerThread();
			
			//WarmFile Rotation
			CyberoamLogger.appLog.debug(" Adding schedule entry for Warm Files Rotaion   ");										
			Alarms.addWarmFilesRotationThread();
			
			//iViewInfo Client Thread
			CyberoamLogger.appLog.debug(" Adding schedule entry for iView Client Info   ");										
			Alarms.addiViewInfoClientThread();
			
			//Lucene Index file backup thread 
			CyberoamLogger.appLog.debug(" Adding schedule entry for iView schedulebackup Info   ");										
			ScheduleBackupThread.startBackupThread();
			
			
			//Lucene Index creation thread scheduling method call - prepare by Hemant Agrawal
			
			CyberoamLogger.appLog.debug(" Adding schedule entry for Index Creation   ");
			IndexSchedulerThread indexSchedulerThread=new IndexSchedulerThread();
			indexSchedulerThread.process();
			
			IndexDeleteThread indexDeleteThread=new IndexDeleteThread();
			indexDeleteThread.process();
			
			SystemInformation systemInformation=new SystemInformation();
			systemInformation.start();
			
			if(!InitServlet.cleanTempFiles()){
				CyberoamLogger.appLog.error("InitServlet=>Temp Files List=>Clening Failed.");
			}
			
			ScheduledReporter.startReporter();		
			
			
			
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception While Adding schedule   "+e,e);
		}
	}
	
	private static void getPostInstallStatus() { 
	
		Runnable r=new Runnable(){
			public void run(){
				CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus()->Thread For Post Installation Starts here");
				int retStatus = 1;
				SqlReader sqlReader=new SqlReader();
				ResultSetWrapper rsw = null;
				try {
					//0 Indicates post installation is remaining in case of Upgrade
					String query = "select value from tbliviewconfig where keyname='PostInstallStatus';";
					rsw=sqlReader.getInstanceResultSetWrapper(query);
					
					while(rsw.next()){
						retStatus=Integer.parseInt(rsw.getString("value"));
						if(rsw.wasNull()){
							CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus->Post Installation is already done in case of Full Installation");
							return;
						}else{
							if(retStatus==0){
								//For executing the all drop statements
								query = "select * from drop_unused_tables();";
								executePostInstallProcedure(query,0);
								CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus()->Drop Statement is successfully done");
								//For moving 12 hours table data
								query = "select * from move_existing_12hr_tablesdata();";
								executePostInstallProcedure(query,91);
								CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus()->12 hours table data is successfully moved");
								/*For moving 24 hours table data
								execute24hoursPostInstallProcedure();
								CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus()->24 hours table data is successfully moved");*/
								//For updating the status
								int updateStatus=updatePostInstallStatus();
								CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus()->Post Installation status is Updated-> "+updateStatus);
								
							}
							else{
								CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus()->Post Installation is already done before");
							}
						}
					}			
				}catch (Exception e) {
					CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus()->Exception in Upgrade"+e,e);
				}finally {
					try {
						rsw.close();
						sqlReader.close();
					} catch (Exception e) {
					}
				}
				
			}};
	    Thread t=new Thread(r);
	    CyberoamLogger.appLog.debug("InitServlet.getPostInstallStatus()->Thread for Upgrade");
	    t.setPriority(Thread.MAX_PRIORITY);
	    t.start();
	}
	private static void execute24hoursPostInstallProcedure() {
		//getting the number of 24 hour tables
		int total24hrsTable=getNumberof24hourTables();
		
		int offset=0;
		if(offset==0){
			offset=getPostInstall24hourLimit();
		}
		for(;offset<total24hrsTable;offset=offset+10){
			SqlReader sqlReader=new SqlReader();
			ResultSetWrapper rsw = null;
			String query="select * from move_existing_24hr_tablesdata("+offset+");";
			try {
				rsw=sqlReader.getInstanceResultSetWrapper(query);
				while(rsw.next()){
					CyberoamLogger.appLog.debug("execute24hoursPostInstallProcedure()");
				}
			
			}catch (Exception e) {
				CyberoamLogger.appLog.debug("execute24hoursPostInstallProcedure()->Exception in Upgrade"+e,e);
			}finally {
				try {
					rsw.close();
					sqlReader.close();
				} catch (Exception e) {
				}
			}
		}
	}
	private static int getPostInstall24hourLimit() {
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		int value=0;
		try {
			String query = "select value from tbliviewconfig where keyname='PostInstallLimit';";
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			while(rsw.next()){
				value=Integer.parseInt(rsw.getString("value"));
				CyberoamLogger.appLog.debug("getPostInstall24hourLimit()->"+value);
				}
						
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("getNumberof24hourTables()->Exception in Upgrade"+e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return value;
	}
	private static int getNumberof24hourTables() {
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		int count=0;
		try {
			String query = "SELECT count(tablename) FROM pg_tables WHERE schemaname = 'public' and tablename like '%24hr';";
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			while(rsw.next()){
				count=Integer.parseInt(rsw.getString("count"));
				CyberoamLogger.appLog.debug("getNumberof24hourTables()->"+count);
				}
						
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("getNumberof24hourTables()->Exception in Upgrade"+e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return count;
	}
	private static void executePostInstallProcedure(String query,int counter) {
		for(;counter<=91;counter++)
		{
			SqlReader sqlReader=new SqlReader();
			ResultSetWrapper rsw = null;
			
			try {
				
				rsw=sqlReader.getInstanceResultSetWrapper(query);
				while(rsw.next()){
						CyberoamLogger.appLog.debug("executePostInstallProcedure()->"+counter);
					}
							
			}catch (Exception e) {
				CyberoamLogger.appLog.debug("executePostInstallProcedure()->Exception in Upgrade"+e,e);
			}finally {
				try {
					rsw.close();
					sqlReader.close();
				} catch (Exception e) {
				}
			}
		}
	}
	private static int updatePostInstallStatus() {
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		int retStatus=0;
		try {
			String query = "UPDATE tbliviewconfig set value=1 where keyname='PostInstallStatus';";
			retStatus=sqlReader.executeUpdate(query, 5);
			
			CyberoamLogger.appLog.debug("InitServlet.updatePostInstallStatus()->Status of PostInstall is Updated");
						
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("InitServlet.updatePostInstallStatus()->Exception in Upgrade"+e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
	private static boolean cleanTempFiles() {
		boolean retStatus = true;
		File tempDir = new File(System.getProperty("java.io.tmpdir"));
		String[] tempFiles = null;
		try{
			if(tempDir!=null && tempDir.isDirectory()){
				CyberoamLogger.appLog.info("InitServlet=>Temp Folder Path:"+tempDir.getAbsolutePath());
				tempFiles = tempDir.list();
				CyberoamLogger.appLog.info("InitServlet=>Number of Files in Temp Folder Path:"+tempFiles.length);
				for(int fileCnt=0; fileCnt<tempFiles.length; fileCnt++){
					CyberoamLogger.appLog.info("InitServlet=>Deleting file:"+tempDir.getAbsolutePath() + "\\" + tempFiles[fileCnt]);
					new File(tempDir.getAbsolutePath() + System.getProperty("file.separator") + tempFiles[fileCnt]).delete();
				}
			}											 
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("Exception=>InitServlet=>"+e,e);
			retStatus = false;
		}
		return retStatus;
	}
}
