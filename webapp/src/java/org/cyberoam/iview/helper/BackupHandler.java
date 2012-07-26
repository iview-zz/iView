package org.cyberoam.iview.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.zip.ZipException;
import java.util.zip.ZipOutputStream;
import org.cyberoam.iview.utility.zipFileUtility;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.beans.FileBackupBean;
import org.cyberoam.iview.utility.FTPFileManager;



/**
 * This Class is used to take backup  of archieveindexfile. 
 * @author Jenit Shah
 *
 */

public class BackupHandler {
	
	public static int backup(Long startdate,Long enddate,String dstfullpath){
		int returnstatus=1;
		  try {
			String src=null;
			int flag=0;
			ZipOutputStream zip = null;
		    FileOutputStream fileWriter = null;
		 	fileWriter = null;
		    
		    		   			
		    Iterator itrdevicebean = DeviceBean.getAllDeviceBeanIterator();
			while(itrdevicebean.hasNext()){
			DeviceBean devicebean=(DeviceBean)itrdevicebean.next();
			String appid= devicebean.getApplianceID();
			src=iViewConfigBean.ArchiveHome+iViewConfigBean.INDEXFILES+"/"+appid+"/"+iViewConfigBean.IndexInfo;
			File indexfolder=new File(src);
				if(indexfolder.exists()){
				 File indexfiles[] = indexfolder.listFiles();
				 for(int j=0;j<indexfiles.length;j++){
				try{
					if(Long.parseLong(indexfiles[j].getName()) >= startdate && Long.parseLong(indexfiles[j].getName())<=enddate){
						if(flag==0){
							fileWriter=new FileOutputStream(dstfullpath);
							zip = new ZipOutputStream(fileWriter);
							flag=1;
						}
						returnstatus=zipFileUtility.addFolderToZip(appid+"/"+iViewConfigBean.IndexInfo,indexfiles[j].getPath(), zip);	
					}						
				 }
				 catch(NumberFormatException e){
					 CyberoamLogger.appLog.debug("BackupHandler Exception Number Format Exception"+e);
				 }
				 }				 
				}
			}		
		    if(zip!=null){
		    	zip.flush();
		    	zip.finish();
		    	zip.close();		    	
		    }else{
		    	returnstatus=2;
		    }
		  }catch(ZipException zipe){
			  returnstatus=-1;
			  CyberoamLogger.appLog.debug("BackupHandler ZIpException for Backup Method  "+zipe);
			  File zipfiledelete=new File(dstfullpath);
			  try{
				  zipfiledelete.delete();
			  }catch(Exception e){
			   }		  
		  }
		  catch(Exception e){
			 returnstatus=-1;
			 CyberoamLogger.appLog.debug("BackupHandler Exception for Backup Method  "+e);
			 File zipfiledelete=new File(dstfullpath);
			  try{
				  zipfiledelete.delete();
			  }catch(Exception ce){
				  returnstatus=-2;
			  }		
		  }
		  return  returnstatus;
		  
	}
}
	

