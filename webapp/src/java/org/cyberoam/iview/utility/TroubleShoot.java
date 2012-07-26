package org.cyberoam.iview.utility;

import java.io.File;
import java.io.RandomAccessFile;
import java.util.ArrayList;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.system.utility.SystemInformation;
import org.cyberoam.iview.system.utility.SystemInformation.OperatingSystem;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;import org.cyberoam.iview.system.beans.MemoryUsageBean;;
/**
 * 
 * @author darshanshah 
 * @author huzaifa bhavnagri 
 */
/**
 * This class is designed for providing troubleshooting information for garner log, postgres log, tomcat log. 
 * System information. 
 */

public class TroubleShoot {
	 String garner,tomapp,tomsys,tomaudit,tomrep,tomcon,tomsql;
	 ArrayList logcontainer=new ArrayList();	
	
	 /**
	  * Give logs for given file id in limit no of lines
	  * @param loglimit
	  * @param fileid
	  */
	 public void generateResponse(int loglimit,String fileid,String searchkey){
		tomaudit = iViewConfigBean.iViewHome+"tomcat/logs/auditlog.log";
		tomapp = iViewConfigBean.iViewHome+"tomcat/logs/applog.log";
	    tomsys = iViewConfigBean.iViewHome+"tomcat/logs/syslog.log";
	    tomrep = iViewConfigBean.iViewHome+"tomcat/logs/replog.log";
	    tomcon = iViewConfigBean.iViewHome+"tomcat/logs/connectionpool.log";
	    tomsql = iViewConfigBean.iViewHome+"tomcat/logs/sqllog.log";
	    
		if(SystemInformation.os == OperatingSystem.Windows){
			garner = iViewConfigBean.iViewHome+"cygwin/usr/local/garner/log/garner.log";
		}	
		else{
			garner = iViewConfigBean.iViewHome+"garner/log/garner.log";
		}
		
		String filepath="";		
		try{			
			if(fileid.equalsIgnoreCase("garner")){
				filepath=garner;
			}
			else if(fileid.equalsIgnoreCase("tomapp")){
				filepath=tomapp;
			}
			else if(fileid.equalsIgnoreCase("tomsys")){
				filepath=tomsys;
			}
			else if(fileid.equalsIgnoreCase("tomrep")){
				filepath=tomrep;
			}
			else if(fileid.equalsIgnoreCase("tomaudit")){
				filepath=tomaudit;
			}
			else if(fileid.equalsIgnoreCase("tomcon")){
				filepath=tomcon;
			}
			else if(fileid.equalsIgnoreCase("tomsql")){
				filepath=tomsql;
			}
			else if(fileid.equalsIgnoreCase("rwtable")){
				logcontainer=getRWtables(searchkey);	
				setResponse(logcontainer);
				return;
			}
			else if(fileid.equalsIgnoreCase("showquery")){
				logcontainer=getQueries(loglimit,searchkey);
				setResponse(logcontainer);
				return;
			}
			
			File file=new File(filepath);	
			RandomAccessFile rf=new RandomAccessFile(file,"r");	
			long pos=rf.length();
			int content=0;
			String log="";
			
			for(int i=0;i<loglimit;i++){
				while(true){
					rf.seek(pos);
					content=rf.read();
					if(content==10 || content==13){
						pos=pos-2;
						break;
					}
					else
					{
						pos--;
					}
					if(pos<0)
					{
						rf.seek(0);
						break;
					}
				}
				if(pos<0){
					log=rf.readLine();
					if(log!=null && !log.equals("")){						if(searchkey==null && searchkey.equals("")){
							logcontainer.add(log.trim());						}						else						{							if(log.toLowerCase().contains(searchkey.toLowerCase())|| log.equalsIgnoreCase(searchkey)){								logcontainer.add(log.trim());							}						}
					}					
					break;
				}
				log=rf.readLine();
				if(log!=null && !log.equals("")){					if(searchkey==null && searchkey.equals("")){						logcontainer.add(log.trim());					}					else					{						if(log.toLowerCase().contains(searchkey.toLowerCase()) || log.equalsIgnoreCase(searchkey)){							logcontainer.add(log.trim());						}					}
				}else{
					loglimit++;
				}				
			}			
			rf.close();				
		}catch(Exception e){
			logcontainer.add("TroubleShooting error:" + e.getMessage());
			CyberoamLogger.appLog.debug("Troubleshoot:e" +e,e);			
		}
		setResponse(logcontainer);
		return;
	}
	 /**
	  * 
	  * @param logcontainer
	  */
	public void setResponse(ArrayList logcontainer){
		this.logcontainer=logcontainer;		
	}
	/**
	 * 
	 * @param loglimit
	 * @param fileid
	 * @return
	 */
	public ArrayList getResponse(int loglimit,String fileid,String searchkey){
		generateResponse(loglimit, fileid, searchkey);
		return logcontainer;		
	}
	
	/**
	 * 
	 * @param viewlimit
	 * @return
	 */
	public ArrayList getRWtables(String searchkey){
		String query="";		String log="";
		ArrayList tablecontainer=new ArrayList();
		ResultSetWrapper rsw=null;
		try{					query="select getQueueTable('used','tablename')";			 rsw=SqlReader.getResultSetWrapper(query);			 while(rsw.next()){				 log="Used : "+rsw.getString("getQueueTable");				 if(searchkey==null && searchkey.equals("")){					 tablecontainer.add(log);					}					else					{						if(log.toLowerCase().contains(searchkey.toLowerCase()) || log.equalsIgnoreCase(searchkey)){							tablecontainer.add(log);						}					}				 }			 rsw.close();
			 query="select getQueueTable('avail','tablename')";
			 rsw=SqlReader.getResultSetWrapper(query);			 
			 while(rsw.next()){				 log="Available : "+rsw.getString("getQueueTable");				 if(searchkey==null && searchkey.equals("")){					 tablecontainer.add(log);					}					else					{						if(log.toLowerCase().contains(searchkey.toLowerCase()) || log.equalsIgnoreCase(searchkey)){							tablecontainer.add(log);						}					}	
			 }						 			 
			 if(tablecontainer.size()<=0){
				 tablecontainer.add("No Queued tables Available");
			 }
		}
		catch(Exception e){
			tablecontainer.add("Cant Acceess The Database"+e.getMessage());
			CyberoamLogger.appLog.debug("Troubleshoot:e" +e,e);
		}finally{
			rsw.close();
		}		
		return tablecontainer;
	}
	/**
	 * 
	 * @param viewlimit
	 * @return
	 */
	public ArrayList getQueries(int viewlimit,String searchkey){
		String query="";		String log="";
		ArrayList tablecontainer=new ArrayList();
		ResultSetWrapper rsw=null;
		try{
			query="SELECT current_query FROM pg_stat_activity where current_query != '<IDLE>' and current_query not like 'SELECT current_query FROM pg_stat_activity where current_query != %' limit "+viewlimit+"";
			rsw= SqlReader.getResultSetWrapper(query);
			while(rsw.next()){			  log=rsw.getString("current_query");			  if(searchkey==null && searchkey.equals("")){				  tablecontainer.add(log);					}					else					{						if(log.toLowerCase().contains(searchkey.toLowerCase()) || log.equalsIgnoreCase(searchkey)){							 tablecontainer.add(log);						}					}
			 
			}
			if(tablecontainer.size()<=0){
				tablecontainer.add("No Queries are Running now");
			}			 
		}
		catch(Exception e){			
			tablecontainer.add("Database Connectivity lost ");
			CyberoamLogger.appLog.debug("Troubleshoot:e" +e,e);
		}finally{
			rsw.close();
		}		
		return tablecontainer;
	}
	/**
	 * Get Total no. of connection for postgres  
	 * @return 
	 */
	public String getTotalCon()	{
		String totalcon="0";
		ResultSetWrapper rsw=null;
		try{
			String query="SELECT count(*) as totalcon from pg_stat_activity";
			rsw=SqlReader.getResultSetWrapper(query);			
			if(rsw.next()){
				totalcon=rsw.getString("totalcon");
			}
		}catch(Exception e){
			totalcon="No connection Found" + e.getMessage();
			CyberoamLogger.appLog.debug("Troubleshoot.getTotalConnection:e" +e,e);
		}finally{
			rsw.close();						
		}
		return totalcon;
	}		public static MemoryUsageBean getMemoryUsage()	{		MemoryUsageBean memoryUsageBean=new MemoryUsageBean();		ResultSetWrapper rsw=null;		try{			String query="select * from getsystemusage('memoryusage')";			rsw=SqlReader.getResultSetWrapper(query);						while(rsw.next()){				if(rsw.getString("usagetype").equalsIgnoreCase("used")){					memoryUsageBean.setMemoryInUse(Long.parseLong(rsw.getString("usage")));				}				else				{					memoryUsageBean.setFreeMemory(Long.parseLong(rsw.getString("usage")));				}			}		}catch(Exception e){			CyberoamLogger.appLog.debug("Troubleshoot.getMemoryUsage:e" +e,e);		}finally{			rsw.close();								}		return memoryUsageBean;	}	
}
