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

package org.cyberoam.iview.helper;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.ArchiveUtility;
import org.cyberoam.iview.utility.BackupRestoreUtility;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.IndexFileNameParsingUtility;
/**
 * This class is used for taking backup for archived logs and storing it with the structure
 * applianceid-dayhour/(archivefiles)/applianceid/day/restore/file.
 * @author Shikha Shah
 */   
public class BackupDataHandler extends Thread {
	
	private static boolean stopped = true;
	private static boolean stoppedThread = true;	
	private static String devicelist[] = null;
	private static String filelist[] = null;	
	static HttpSession session;
	
	public static boolean isStopped() {
		return stopped;
	}
	public synchronized static void setStopFlag(boolean stopped) {
		BackupDataHandler.stopped = stopped;
	}
	
	public static boolean isStoppedThread() {
		return stoppedThread;
	}
	public synchronized static void setStopFlagThread(boolean stopped) {
		BackupDataHandler.stoppedThread = stopped;
	}
	
	public BackupDataHandler(String filelist[],String devicelist[]){
		CyberoamLogger.appLog.info("BackupDataHandler:process:calling Thread");		
		this.filelist=filelist;
		this.devicelist=devicelist;
	}
	
	/**
	 * This method is used to take the backup using {@link BackupDataThread}
	 */	
	public static void process(HttpServletRequest request,HttpServletResponse response){
		try{			
			if(!isStopped()){
				response.sendRedirect(request.getContextPath()+"/webpages/backuprestore.jsp");
			} else {
				setStopFlag(false);
				setStopFlagThread(false);
			}
			session=request.getSession(false);
			CyberoamLogger.appLog.info("BackupDataHandler:process:calling Thread");
			filelist = request.getParameter("indexfilelist").split(",");
			devicelist = ((String)request.getSession(false).getAttribute("appliancelist")).split(",");
			new BackupDataHandler(filelist,devicelist).start();
			CyberoamLogger.appLog.info("BackupDataHandler:process:redirect:"+request.getContextPath()+"/webpages/backuprestore.jsp");
			CyberoamLogger.appLog.info("BackupDataHandler:process:calling Thread Ends...");			
			//session.setAttribute("statusCheck","1");			
			response.sendRedirect(request.getContextPath()+"/webpages/backuprestore.jsp");
		}
		catch(Exception e){
			CyberoamLogger.appLog.debug("BackupDataHandler->process->Exception: " + e,e);
			setStopFlag(true);
			setStopFlagThread(true);								
			try{
				response.sendRedirect(request.getContextPath()+"/webpages/backuprestore.jsp?backup=true&stop=false");
			} catch (Exception e1) {
				CyberoamLogger.appLog.debug("BackupDataHandler->process->Exception:In Redirection:",e1);
			}
		}		
	}
	@SuppressWarnings("deprecation")
	public void run() {
		try{				
			boolean checkFlag=false;
			CyberoamLogger.appLog.info("Run Method");
			if(devicelist==null){
				CyberoamLogger.appLog.info("No device selected");
				BackupDataHandler.setStopFlag(true);
				setStopFlagThread(true);
				return;
			}
			String day;
			File dstPath=null;
			File srcPath=null;			
			int recordcount;
			int iCntr,iCntr1;
		    ZipOutputStream zip = null;
			FileOutputStream fileWriter = null;
			//loops for all the 6hr files whose backup is to be taken
			for(recordcount=0;recordcount<filelist.length;recordcount++){
				if(BackupDataHandler.isStopped()){					
					setStopFlagThread(true);					
					break;
				}
				else{
					setStopFlagThread(false);
				}	
				CyberoamLogger.appLog.info("filelist->"+filelist[recordcount]);
				Date startDate = new Date(Integer.parseInt(filelist[recordcount].substring(0,4))-1900,
										  Integer.parseInt(filelist[recordcount].substring(4,6))-1,
										  Integer.parseInt(filelist[recordcount].substring(6,8)),
										  Integer.parseInt(filelist[recordcount].substring(9,11)),0,0);				
				Date endDate = new Date(Integer.parseInt(filelist[recordcount].substring(0,4))-1900,
						  Integer.parseInt(filelist[recordcount].substring(4,6))-1,
						  Integer.parseInt(filelist[recordcount].substring(6,8)),
						  Integer.parseInt(filelist[recordcount].substring(12,14)),59,59);
				day=filelist[recordcount].split(":")[0];				
				for(iCntr=0;iCntr<devicelist.length;iCntr++){
	
					srcPath=new File(IViewPropertyReader.ArchieveDIR+devicelist[iCntr].substring(1,devicelist[iCntr].length()-1)+"/cold/"+day+"/");
					String files[] = srcPath.list();
					if(files==null){
						continue;
					}
					checkFlag=true;
					CyberoamLogger.appLog.info("srcPath->"+srcPath.getPath());
					
					long timestamp=0;
					boolean flag=true;
					long starttimestamp=0;
					long endtimestamp=0;
					ArrayList archivefiles;
					
					
					for(iCntr1=0;iCntr1<files.length;iCntr1++){						
						if (IViewPropertyReader.IndexFileTimeStampUsed == 2) {
							timestamp=Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(files[iCntr1]))*1000;
						} else {
							timestamp=Long.parseLong(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(files[iCntr1]))*1000;
						}		
						if(timestamp>=startDate.getTime() && timestamp<=endDate.getTime()){	
							//for the first record					
							if(flag==true){
								dstPath=new File(IViewPropertyReader.BackupDIR+devicelist[iCntr].substring(1,devicelist[iCntr].length()-1)+"_"+day+filelist[recordcount].split(":")[1].split("_")[0]+filelist[recordcount].split(":")[1].split("_")[1]+".zip");
								fileWriter = new FileOutputStream(dstPath);	
								zip = new ZipOutputStream(fileWriter);								
								zip.putNextEntry(new ZipEntry("archievefiles/"));
								zip.putNextEntry(new ZipEntry("archievefiles/"+devicelist[iCntr].substring(1,devicelist[iCntr].length()-1)+"/"));
								zip.putNextEntry(new ZipEntry("archievefiles/"+devicelist[iCntr].substring(1,devicelist[iCntr].length()-1)+"/Restore/"));
								zip.putNextEntry(new ZipEntry("archievefiles/"+devicelist[iCntr].substring(1,devicelist[iCntr].length()-1)+"/Restore/"+day+"/"));
								starttimestamp=timestamp;
								endtimestamp=timestamp;
								flag=false;
							}
							else{
								endtimestamp=timestamp;
							}
						//	BackupRestoreUtility.Backup(devicelist[iCntr].substring(1,devicelist[iCntr].length()-1),files[iCntr1],day,"index",zip);
						}
					}
				
//					the archive files of that particular devices are obtained.
					
					if(starttimestamp!=0 && endtimestamp!=0){
										
						archivefiles=ArchiveUtility.getArchiveFiles(starttimestamp,endtimestamp,devicelist[iCntr].substring(1,devicelist[iCntr].length()-1),day);
						if(archivefiles!=null){
							for(iCntr1=0;iCntr1<archivefiles.size();iCntr1++){
								BackupRestoreUtility.Backup(devicelist[iCntr].substring(1,devicelist[iCntr].length()-1),(String)archivefiles.get(iCntr1),day,"archive",zip);
							}							
						}
					}
					if(flag==false){
						zip.finish();
						fileWriter.close();
					}
					CyberoamLogger.appLog.debug("BackupDataThread->File->"+dstPath.getPath());					
				}
			}
			BackupDataHandler.setStopFlag(true);
			setStopFlagThread(true);
			CyberoamLogger.appLog.debug("BackupDataThread Ends");
			if(checkFlag==false){
				session.setAttribute("statusCheck","4");
			}else{
				session.setAttribute("statusCheck","1");
			}
		}
		catch(Exception e){
			BackupDataHandler.setStopFlag(true);
			setStopFlagThread(true);
			session.setAttribute("statusCheck","4");
			CyberoamLogger.appLog.debug("BackupDataHandler->process->Exception: " + e,e);
		}		
	}	
}