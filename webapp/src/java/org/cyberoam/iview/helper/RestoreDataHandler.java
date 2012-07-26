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
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.utility.BackupRestoreUtility;
import org.cyberoam.iview.utility.RestoreFilesRotation;

/**
 * This file is used to upload(Restore) multiple logs to the archivedir location.
 * @author Shikha Shah
 */   
public class RestoreDataHandler extends Thread {
	
	static boolean stopped = true;
	static List fileItemsList;		
	static int loaded=0;
	static int notloaded=0;
	static HttpSession session;
	
	public static int getLoaded() {
		return loaded;
	}
	public synchronized static void setLoaded(int loaded) {
		RestoreDataHandler.loaded = loaded;
	}		
	public static int getNotLoaded() {
		return notloaded;
	}
	public synchronized static void setNotLoaded(int notloaded) {
		RestoreDataHandler.notloaded = notloaded;
	}		

	public RestoreDataHandler(List fileItemsList){
		this.fileItemsList = fileItemsList;		
	}

	
	public static boolean isStopped() {
		return stopped;
	}
	public synchronized static void setStopFlag(boolean stopped) {
		RestoreDataHandler.stopped = stopped;
	}
	
	/**

	 */	
	public static void process(HttpServletRequest request,HttpServletResponse response){
		try{	
			if(!isStopped()){
				response.sendRedirect(request.getContextPath()+"/webpages/backuprestore.jsp");
			} else {
				setStopFlag(false);
			}
			session=request.getSession(false);			
			CyberoamLogger.appLog.info("RestoreDataHandler:process:calling Thread");				
			// 	Creates a new file upload handler
			ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());				  
			// Parses the request
			List fileItemsList = servletFileUpload.parseRequest(request);			
			new RestoreDataHandler(fileItemsList).start();
			CyberoamLogger.appLog.info("RestoreDataHandler:process:redirect:"+request.getContextPath()+"/webpages/backuprestore.jsp");
			CyberoamLogger.appLog.info("RestoreDataHandler:process:calling Thread Ends...");						
			response.sendRedirect(request.getContextPath()+"/webpages/backuprestore.jsp");
		}
		catch(Exception e){
			CyberoamLogger.appLog.debug("RestoreDataHandler->process->Exception: " + e,e);
			setStopFlag(true);								
			try{
				response.sendRedirect(request.getContextPath()+"/webpages/backuprestore.jsp?backup=true&stop=false");
			} catch (Exception e1) {
				CyberoamLogger.appLog.debug("BackupDataHandler->process->Exception:In Redirection:",e1);
			}
		}		
	}
	public void run() {
		
		try{ 	
			session.setAttribute("statusCheck", "3");
		// Processes the uploaded items
			Iterator it = fileItemsList.iterator();
			while (it.hasNext()){
				if(RestoreDataHandler.isStopped()){
					break;
				}
			
				FileItem fileItem = (FileItem)it.next();
				//checks whether the fileitem is a form field or not.
				if (fileItem.isFormField()){		
					//checks whether the form field name is filename or not.
					if(fileItem.getFieldName()!="filename")
						continue;
					fileItem.getString();
				}				    
			  
				if (fileItem!=null){
					String fileName = fileItem.getName();
					if("".equalsIgnoreCase(fileName.trim()))
						continue;
					String fName[]=fileName.replace("\\","/").split("/");
					if(fName!=null && fName.length>0){
						fileName=fName[fName.length-1];
					}
					
					if (fileItem.getSize() > 0){
						CyberoamLogger.appLog.debug("FileName: " + fileName);
						//saves the file temporary in iViewConfigBean.ArchiveHome location
						File saveTo = new File(iViewConfigBean.ArchiveHome + fileName);
				    	try {
							fileItem.write(saveTo);
							int status=BackupRestoreUtility.Restore(saveTo.getPath(),iViewConfigBean.ArchiveHome);
							if(status==-1){
								setNotLoaded(getNotLoaded()+1);
							}
							else{
								setLoaded(getLoaded()+1);								
							}
							//delete the temporary file
							saveTo.delete();
						}
						catch (Exception e){
							CyberoamLogger.appLog.debug("An error occurred when we tried to save the uploaded file");
						}							
					}
				}
			}
			
			//starts the restorefilesrotation thread if one or more files are uploded
			if(getLoaded()>0)
				new RestoreFilesRotation();
			RestoreDataHandler.setStopFlag(true);						
//			response.sendRedirect(request.getContextPath() + "/webpages/backuprestore.jsp?statusCheck=3&loaded="+loaded+"&notloaded="+notloaded);
		}
	
		catch(Exception e){
			session.setAttribute("statusCheck","3");
			RestoreDataHandler.setStopFlag(true);
			CyberoamLogger.appLog.debug("RestoreDataHandler->process->Exception->"+e,e);
		}
	}	
}