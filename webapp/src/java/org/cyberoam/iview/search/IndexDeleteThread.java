
package org.cyberoam.iview.search;

import java.io.File;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.beans.DataBaseConfigBean;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;

/***
 * This class represents schedule thread and  start thread  for creating index.
 * @author Hemant Agrawal
 *
 */
 

public class IndexDeleteThread implements Runnable {

	/**
	 * This method call from initServlet and start delete thread
	 */
	public void process(){
		
		CyberoamLogger.appLog.debug(" call index creation   ");
		int time=0;	
		
		//this try catch block specially handle string to number conversion exception
		
		//This try catch block handle thread exception
		try{	
			ScheduledExecutorService schedExe = Executors.newSingleThreadScheduledExecutor();
			Runnable IndexDelete = new IndexDeleteThread();
			
			/* Start thread scheduling , 
			*  Argument 
			*  		1)	object which execute run method 
			*  		2)	initial delay
			*  		3)  delay between first thread complete and second thread start
			*  		4)	schedule time consider in second 
			*/
			
			 
			ScheduledFuture<?> sf = schedExe.scheduleWithFixedDelay(IndexDelete, 0,60, TimeUnit.SECONDS );
			
			//sf.get() method throw error if any interrupt come in running thread
			
			//CyberoamLogger.repLog.error(sf.get());
			
			//shutdownNow method it is not allow new thread in queue 
			//schedExe.shutdownNow();			
							
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception in IndexSchedulerThread  : " + e,e);					
		}	
	
	}
	public static  void deleteDirectory(File tempDir){		
		if(tempDir != null && tempDir.exists()){
			File[] tempDirFiles = tempDir.listFiles();
			for(int temp = 0 ; temp < tempDirFiles.length ; temp++){				
				if(tempDirFiles[temp].isDirectory()){
					deleteDirectory(tempDirFiles[temp].getAbsoluteFile());
				}
				tempDirFiles[temp].delete();						 
			}
			tempDir.delete();			
		}
	}
	public static int CheckMarkForDeleteEntry(String prefix,String dt){
		SqlReader sqlReader=null;
		ResultSetWrapper rsw = null;
		try{
			sqlReader=new SqlReader();			
			String strquery="select * from tbl_marked_for_delete where table_name like '%"+prefix+"%24hr_ts_"+dt+"';";
			rsw=sqlReader.getInstanceResultSetWrapper(strquery);
			if(rsw.next()){
				return 1;
			}else{
				return 0;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("error in CheckMarkForDeleteEntry "+e);
			return 1;
		} finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
	}
	
	// This funciton calculation delete folder as a count base
	
	public static void CalculateCountTimeDeleteFolder(int value,String modulename,String prefix){
		 
		 DeviceBean devicebean=null;
		 String path=null;
		 String []DateDirectoryList =null;		 		
		 File IndexInfo =null;
		 Date date=null;
		 int count=0;			
		 int i=0;
		 double folderyear=0;
		 double foldermnth=0;
		 double year=0;
		 double mnth=0;
		try{									
			date=new Date();
			
			Iterator deviceIterator=DeviceBean.getDeviceBeanIterator();
			while(deviceIterator.hasNext()){
				devicebean = (DeviceBean)deviceIterator.next();
				
				if(devicebean!=null){						
				
					if(devicebean.getDeviceStatus()==2){
						path=IViewPropertyReader.IndexDIR+devicebean.getApplianceID()+"/"+IndexSearchBean.getValueByKey("indexinfo");
						IndexInfo =new File(path);									
						if(IndexInfo.exists()){
							
							year=date.getYear()+1900;
							mnth=date.getMonth();
							if(mnth==0){
								year-=1;
								mnth=12;
							}
							
							DateDirectoryList = IndexInfo.list();
							Arrays.sort(DateDirectoryList);		
							
							for(i=DateDirectoryList.length-1; i>=0; i--){
								folderyear=Long.parseLong(DateDirectoryList[i].substring(0,4));
								foldermnth=Long.parseLong(DateDirectoryList[i].substring(4,6));
								
								if((year+mnth/10)>=(folderyear+foldermnth/10)){
									
									if(new File(path+"/"+DateDirectoryList[i]+"/"+modulename).exists()){
										count++;
										mnth=foldermnth-1;
										if(mnth==0){
											mnth=12;
											year--;
										}
									}
								}
								if(count==value+1){					
									break;
								}
							}
							for(;i>=0 ; i--){
								
								if(new File(path+"/"+DateDirectoryList[i]+"/"+modulename).exists()){
									String []prefixarr=prefix.split("_");
									int ans=0;
									for(int j=0 ; j<prefixarr.length ; j++){
										ans+=CheckMarkForDeleteEntry(prefixarr[j],DateDirectoryList[i].substring(0,4)+DateDirectoryList[i].substring(4,6));
									}	
									if(ans==0){
										deleteDirectory(new File(path+"/"+DateDirectoryList[i]+"/"+modulename));
									}
								}
							}							
						}
					}
				}	
			}						
		}catch(Exception e){
			CyberoamLogger.repLog.error("error in CalculateTimeDeleteFolder "+e);
		}
	}
	
	
	/* This function is working as a time base for calculationg mark for delete
	 */
	
	/*public static void CalculateTimeDeleteFolder(int value,String modulename,String prefix){
		 Calendar now = null;
		 Calendar folderdate = null;
		 DeviceBean devicebean=null;
		 String path=null;
		 File indexfolder=null;		 
		try{
			now = Calendar.getInstance();
			folderdate=Calendar.getInstance();
			now.add(Calendar.MONTH, -value);
			now.set(Calendar.DATE ,01);
			Iterator deviceIterator=DeviceBean.getDeviceBeanIterator();
			while(deviceIterator.hasNext()){
				devicebean = (DeviceBean)deviceIterator.next();
				if(devicebean!=null){						
					if(devicebean.getDeviceStatus()==2){	
						path=IViewPropertyReader.IndexDIR+devicebean.getApplianceID()+"/"+IndexSearchBean.getValueByKey("indexinfo");
						indexfolder=new File(path);
						if(indexfolder.exists()){
							String dtfolder[]=indexfolder.list();
							for(int i=0 ; i<dtfolder.length ; i++){								
								folderdate.set(Integer.parseInt(dtfolder[i].substring(0,4)),Integer.parseInt(dtfolder[i].substring(4,6)),01);
								if(now.compareTo(folderdate)>0){
									String []prefixarr=prefix.split("_");
									int ans=0;
									for(int j=0 ; j<prefixarr.length ; j++){
										ans+=CheckMarkForDeleteEntry(prefixarr[j],dtfolder[i].substring(0,4)+dtfolder[i].substring(4,6));
									}	
									if(ans==0){
										deleteDirectory(new File(path+"/"+dtfolder[i]+"/"+modulename));
									}
								}								
							}
						}
					}
				}	
			}						
		}catch(Exception e){
			CyberoamLogger.repLog.error("error in CalculateTimeDeleteFolder "+e);
		}
	}*/
	public void run() {
		DataBaseConfigBean databaseconfigbean=null;
		int value=0;
		String valstr=null;
		try{
			databaseconfigbean=new DataBaseConfigBean();
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_accept_top_host_user_rules_protogroup_application");
			value= valstr.length()>2?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"firewalltrafficdata","accept_top_host_user_rules_protogroup_application");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_blocked_deny");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"firewallblockedtrafficdata","blocked_deny");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_web");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"webusagedata","web");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_web");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"fileupload","web");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_mail");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"maildata","mail");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_ftp");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"cleanftpdata","ftp");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_deniedweb");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"deniedwebcontentcategorizationdata","deniedweb");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_ips");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"indexidpalertsdata","ips");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_virus");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"virusdata","virus");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_vpn");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"vpnreport","vpn");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_vpn");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"sslvpnreport","vpn");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_event");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"eventdata","event");
			
			valstr =databaseconfigbean.getValue("MaxNoTables5min_iusg");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"internetusage","iusg");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_im");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"imreports","im");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_webs");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"webusage","webs");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_fw");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"firewallreport","fw");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_update");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"updatedata","update");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_usbc");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"usbcontrol","usbc");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_webr");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"webreport","webr");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_flnt");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"fileantivirus","flnt");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_apct");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"appcontrol","apct");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_apch");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"apache","apch");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_netg");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"netgweb","netg");
			
			valstr =databaseconfigbean.getValue("MaxNoTables24hr_netgdnd");
			value= valstr.length()>1?Integer.parseInt(valstr)%100:Integer.parseInt(valstr)*6;
			CalculateCountTimeDeleteFolder(value,"netgdndweb","netgdnd");
			
		}catch(Exception e){
			CyberoamLogger.repLog.error("error in trhread "+e);
		}
	}
	
}