package org.cyberoam.iview.helper;

import java.io.File;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.helper.BackupHandler;
import org.cyberoam.iview.utility.FTPFileManager;
import org.cyberoam.iview.utility.DateDifference;
import org.cyberoam.iview.utility.zipFileUtility;
import org.cyberoam.iview.beans.FileBackupBean;;

/**
 * This Class is used to take backup at scheduletime and store file on ftp. 
 * @author Jenit Shah
 *
 */ 
public class ScheduleBackupThread implements Runnable{

	private static ScheduledFuture sf = null;
	private static Thread scheduleBackupThread;
	public static final int BACKUP_SCHEDULE_NEVER = -1;
	public static final int BACKUP_SCHEDULE_DAILY = 1;
		
	public ScheduleBackupThread(){
	}
	
	public void run() {
				CyberoamLogger.appLog.debug("SchedulebackupThread Run Method Called");
				String dstfullpath=null;
				int returnstatus=-1;
				String lastbackup=null,nextbackup=null; 
				lastbackup=iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_LAST_BACKUP);
				nextbackup=iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_NEXT_BACKUP);
				GregorianCalendar tmpgc=new GregorianCalendar();
				tmpgc.add(Calendar.DAY_OF_MONTH,-1);
				if(lastbackup==null || "".equals(lastbackup)){
					iViewConfigBean.updateRecord(iViewConfigBean.SCHEDULED_LAST_BACKUP,DateDifference.datetostring(tmpgc));					
				}
				if(nextbackup==null || "".equals(nextbackup)){
					iViewConfigBean.updateRecord(iViewConfigBean.SCHEDULED_NEXT_BACKUP,DateDifference.datetostring(tmpgc));
				}
				Long startdate=Long.parseLong(iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_LAST_BACKUP));
				Long enddate=Long.parseLong(iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_NEXT_BACKUP));
				if(startdate>enddate){
					iViewConfigBean.updateRecord(iViewConfigBean.SCHEDULED_NEXT_BACKUP,DateDifference.datetostring(tmpgc));
				}
				String dstfilename=startdate.toString()+"-"+enddate.toString()+".zip";
				dstfullpath = iViewConfigBean.ArchiveHome+iViewConfigBean.BACKUPDIR+"/"+iViewConfigBean.FTPBACKUPDIR+"/"+dstfilename;
				File dstfolder=new File(iViewConfigBean.ArchiveHome+iViewConfigBean.BACKUPDIR+"/"+iViewConfigBean.FTPBACKUPDIR);
				if(!(dstfolder.exists())){
					dstfolder.mkdirs();					
				}
				try{
				returnstatus=BackupHandler.backup(startdate,enddate,dstfullpath);
				}catch(Exception e){
					CyberoamLogger.appLog.debug("SchedulebackupThread Exception At Time Of Taking a Backup");
				}
				if(returnstatus>0){
					GregorianCalendar gc=new GregorianCalendar(Integer.parseInt(enddate.toString().substring(0,4)),(Integer.parseInt(enddate.toString().substring(4,6)))-1,Integer.parseInt(enddate.toString().substring(6,8)));
					gc.add(Calendar.DAY_OF_MONTH,1);
					iViewConfigBean.updateRecord(iViewConfigBean.SCHEDULED_LAST_BACKUP,DateDifference.datetostring(gc));
					
				}else{	
				if(!(zipFileUtility.isValidZipFile(new File(dstfullpath))))
					returnstatus=-1;
				}
				if(returnstatus>0 && returnstatus!=2){
					FileBackupBean fb=new FileBackupBean(startdate.toString(), enddate.toString());
					fb.insertRecord();
					CyberoamLogger.appLog.debug("SchedulebackupThread Backuptaken from "+startdate.toString()+" to "+enddate.toString());
					returnstatus=ftphelper(dstfilename);
					if(returnstatus<0){
					CyberoamLogger.appLog.debug("SchedulebackupThread FileStore on ftp Failed");
					}
				}
			
		sf=null;
		try{
			Thread.sleep(60000);
		}catch(Exception e){
			CyberoamLogger.appLog.debug("SchedulebackupThread Exception for wait " + e,e);
		}
		startBackupThread();		
	}
	
	public static void startBackupThread() {
		if(sf!=null){
			sf.cancel(true);
			 CyberoamLogger.appLog.debug("Previous ScheduleBackupThread Canceled");
		}
		
		String restoredir=iViewConfigBean.ArchiveHome+iViewConfigBean.RESTORE;
		File restoredirfolder=new File(restoredir);
		if(restoredirfolder.exists()){
			File restorefilelist[]= restoredirfolder.listFiles();
				if(restorefilelist!=null){
					for(File file:restorefilelist){
						if((zipFileUtility.isValidZipFile(file))){
							zipFileUtility.unzipFiles(file.getPath(),iViewConfigBean.ArchiveHome+iViewConfigBean.INDEXFILES);
						}
						file.delete();
					}
					File folderdelete=new File(restoredir);
					folderdelete.delete();
			}
		}
		
		GregorianCalendar gregorianCalendar=new  GregorianCalendar(); 
		GregorianCalendar nextStartTime=null;
		CyberoamLogger.appLog.debug("ScheduleBackupThread is called at "+gregorianCalendar);
		
		int hours=0,minutes=0;
		try{
			int backupInterval = Integer.parseInt(iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_BACKUP_FREQUENCY));
								
			hours=Integer.parseInt(iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_BACKUP_TIME).split(":")[0]);
			minutes=Integer.parseInt(iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_BACKUP_TIME).split(":")[1]);
	
			if(backupInterval== ScheduleBackupThread.BACKUP_SCHEDULE_DAILY) {
				if((gregorianCalendar.get(Calendar.HOUR_OF_DAY) < hours) || (gregorianCalendar.get(Calendar.HOUR_OF_DAY) == hours && gregorianCalendar.get(Calendar.MINUTE) <= minutes)){
					nextStartTime = new GregorianCalendar(gregorianCalendar.get(Calendar.YEAR),gregorianCalendar.get(Calendar.MONTH),gregorianCalendar.get(Calendar.DAY_OF_MONTH),hours,minutes,0);
				}else{
					gregorianCalendar.add(Calendar.HOUR, 24);			
					nextStartTime = new GregorianCalendar(gregorianCalendar.get(Calendar.YEAR),gregorianCalendar.get(Calendar.MONTH),gregorianCalendar.get(Calendar.DAY_OF_MONTH),hours,minutes,0);
				}
			}
			
			if(backupInterval != ScheduleBackupThread.BACKUP_SCHEDULE_NEVER){
				CyberoamLogger.appLog.debug("ScheduleBackupThread is scheduled at "+nextStartTime);
				ScheduledThreadPoolExecutor scheduledThreadPoolExecutor = new ScheduledThreadPoolExecutor(1);
				if(scheduleBackupThread!=null && scheduleBackupThread.isAlive()){
					scheduleBackupThread.stop();
				}
				scheduleBackupThread=null;
				scheduleBackupThread = new Thread(new ScheduleBackupThread());
				long initialDelay = nextStartTime.getTimeInMillis() - System.currentTimeMillis();
				
				CyberoamLogger.appLog.debug("Initial Delay "+ initialDelay);
				sf=scheduledThreadPoolExecutor.schedule(scheduleBackupThread, initialDelay, TimeUnit.MILLISECONDS);
				
				nextStartTime.add(Calendar.DAY_OF_MONTH,-1);
				iViewConfigBean.updateRecord(iViewConfigBean.SCHEDULED_NEXT_BACKUP,DateDifference.datetostring(nextStartTime));
			}else{
				iViewConfigBean.updateRecord(iViewConfigBean.SCHEDULED_LAST_BACKUP,"");
				iViewConfigBean.updateRecord(iViewConfigBean.SCHEDULED_NEXT_BACKUP,"");
				
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception in ScheduleBackupThread->startBackupThread" + e);
		}
	} 
	public static int ftphelper(String remotefilename){
		int returnstatus=1;
		String ftpusername=null,ftppassword=null,ftpserver=null;
		ftpusername=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_USERNAME);
		ftppassword=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_PASSWORD);
		ftpserver=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_SERVERIP);
		try{
		if(ftpusername !=null && ftppassword != null && ftpserver != null){
			FTPFileManager ftp=new FTPFileManager();
			returnstatus=ftp.login(ftpusername, ftppassword, ftpserver, false);
			if(returnstatus >0){
				String localdirpath=iViewConfigBean.ArchiveHome+iViewConfigBean.BACKUPDIR+"/"+iViewConfigBean.FTPBACKUPDIR;
				File ftpbackupfolder=new File(localdirpath);
				File [] ftpbackupfiles=ftpbackupfolder.listFiles();
				for(int i=0;i<ftpbackupfiles.length;i++){ 
					returnstatus=ftp.storeFile(ftpbackupfiles[i].getName(),ftpbackupfiles[i].getPath());
					if(returnstatus>0){
						CyberoamLogger.appLog.debug("SchedulebackupThread FileStore on ftp ->"+ftpbackupfiles[i]);
						ftpbackupfiles[i].delete();
						
					}
				}
				ftp.logout();
				}else{
					CyberoamLogger.appLog.debug("Exception in ScheduleBackupThread FTPhelper Connection Refused");
				}
		}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception in ScheduleBackupThread FTPhelper on File upload" + e);
		}
		return returnstatus;
	}
		
}

