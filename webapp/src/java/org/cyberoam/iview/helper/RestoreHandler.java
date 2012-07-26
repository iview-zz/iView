package org.cyberoam.iview.helper;

/**
 * This Class is used to  restore of archieveindexfile. 
 * @author Jenit Shah
 *
 */
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.FileBackupBean;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.utility.FTPFileManager;
import org.cyberoam.iview.utility.zipFileUtility;
import org.cyberoam.iview.modes.ApplicationModes;

public class RestoreHandler extends Thread {
	static String startDate,endDate;
	static int returnStatus;
	
	public RestoreHandler(String startdt,String enddt){
		RestoreHandler.startDate=startdt;
		RestoreHandler.endDate=enddt;
	}	
	
	public static void process(HttpServletRequest req, HttpServletResponse res,String startDate,String endDate){
		
		try{	
		RestoreHandler rh=new RestoreHandler(startDate, endDate);
		CyberoamLogger.appLog.info("RestoreDataHandler:process:calling Thread Start...");
		rh.start();
		rh.join();
		CyberoamLogger.appLog.info("RestoreDataHandler:process:calling Thread End...");
		res.sendRedirect(req.getContextPath()+"/webpages/schedulebackuprestore.jsp?appmode="+ApplicationModes.RESTORE_REQUEST+"&status="+RestoreHandler.returnStatus);
		
		}catch(Exception e){
			CyberoamLogger.appLog.info("excetpion accures");
			try{
				res.sendRedirect(req.getContextPath()+"/webpages/schedulebackuprestore.jsp?appmode="+ApplicationModes.RESTORE_REQUEST+"&status="+RestoreHandler.returnStatus);
			}catch(Exception e1){
				
			}
		}
	}
	public  void run(){
		String filenames=null,restorefiles[]=null,retrievefailfilelist=null;
		File restorefilelist[];
		Boolean direxist=false;
		returnStatus=1;
		String restoredir=iViewConfigBean.ArchiveHome+iViewConfigBean.RESTORE;
		CyberoamLogger.appLog.debug("RestoreHandler Calling Run Method ");
		CyberoamLogger.appLog.debug("RestoreHandler Calling Run Method Restoration between "+startDate+" and  "+endDate+" Date");
		try{
		  FileBackupBean fb=new FileBackupBean(startDate,endDate);
		  fb.getsqlrecordsforfilenames();
		  filenames=fb.getFileNames();
			if(filenames!=null){
				restorefiles=filenames.split(",");
				File restoredirfolder=new File(restoredir);
				if(!restoredirfolder.exists()){
					direxist=restoredirfolder.mkdir();
				}
				else{
					direxist=true;
				}
				if(direxist){		  		
					retrievefailfilelist=ftpRetrieveFile(restoredir,restorefiles);
					if(retrievefailfilelist!=null){
					CyberoamLogger.appLog.debug("RestoreHandler Run Method File could not retrieve from ftp "+retrievefailfilelist.toString());
					}
					restorefilelist=restoredirfolder.listFiles();
					if(restorefilelist!=null){
						for(File file:restorefilelist){
							if((zipFileUtility.isValidZipFile(file))){
								zipFileUtility.unzipFiles(file.getPath(),iViewConfigBean.ArchiveHome+iViewConfigBean.INDEXFILES);
								CyberoamLogger.appLog.debug("RestoreHandler Run Method File Restore successfully -->"+file.getName());
							}else{
								returnStatus=-6;
								CyberoamLogger.appLog.debug("RestoreHandler Run Method zip File Corrup "+file.getName());
						    }
						file.delete();
						}
				    }else{
				    	returnStatus=-5;
				    	CyberoamLogger.appLog.debug("RestoreHandler Run Method Backup File Could Not Retrieve ");
				    }				  				
					File folderdelete=new File(restoredir);
					folderdelete.delete();
					CyberoamLogger.appLog.debug("RestoreHandler Run Method End ");
				}
			  }else{
				  CyberoamLogger.appLog.debug("RestoreHandler Run Method Backup File Not Found For Restoration ");
				  	returnStatus=-4;
			  }  	
		 	
		}catch (Exception e) {
			returnStatus=-1;
			CyberoamLogger.appLog.debug("RestoreHandler Exception for Run Method  "+e);
		} 
	 }

	public static String  ftpRetrieveFile(String restoredir,String [] retrievefilenames){
		int i=0,returnstatus=-1;
		String retrievefailfilelist=null;
		int flag=0;
		String ftpusername=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_USERNAME);
		String ftppassword=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_PASSWORD);
		String ftpserverip=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_SERVERIP);
		
		if(!"".equals(ftpserverip) && !"".equals(ftpusername) && !"".equals(ftppassword)) {
			try{
				FTPFileManager ftpobj=new FTPFileManager();
			returnstatus=ftpobj.login(ftpusername, ftppassword, ftpserverip, false);
			if(returnstatus > 0){
					for(String retrievefile:retrievefilenames){
					returnstatus=ftpobj.retrieveFile(retrievefile,restoredir);
					if(returnstatus < 0){
						if(flag==0){
							retrievefailfilelist=retrievefile+",";
							flag=1;
						}else
							retrievefailfilelist=retrievefailfilelist+retrievefile+",";						
					}else{
						CyberoamLogger.appLog.debug("RestoreHandler ftpRetrieveFile Method File Store on Locale Drive"+retrievefile);
					}
				}
				ftpobj.logout();				
			}else{
				CyberoamLogger.appLog.debug("RestoreHandler FTP Login Fail");
				retrievefailfilelist="FTPLogin Failed";
			}
		}catch(Exception e){
				CyberoamLogger.appLog.debug("RestoreHandler Exception for FtpRetrieveFile method  "+e);
				retrievefailfilelist="FTPLogin Failed";
		}
		}else{
			retrievefailfilelist="FTPLogin Failed";
		}
		return retrievefailfilelist;
	}
}

