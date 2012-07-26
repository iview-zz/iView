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
import java.io.FileInputStream;
import java.util.ArrayList;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.system.beans.CPUUsageBean;
import org.cyberoam.iview.system.beans.DiskUsageBean;
import org.cyberoam.iview.system.beans.MemoryUsageBean;
import org.cyberoam.iview.system.utility.SystemInformation;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.TroubleShoot;
import java.text.DecimalFormat;

/**
* This servlet is used for downloading a backup file or deleting a backup file from server.
* @author Shikha Shah
*/

public class BackupServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response){
		doPost(request,response);
	}
	/**
	* The Post method of the servlet is used for handling whether the delete request or the download request
	* specified by the client.
	*/	
	public void doPost(HttpServletRequest request,HttpServletResponse response){
		try {
			//if choice=1, the request is delete request.			
			HttpSession session = request.getSession(false);
			if(CheckSession.checkSession(request, response) < 0){ 
				return ;
			}
			int choice=Integer.parseInt(request.getParameter("choice"));
			ServletOutputStream out = null;
			byte[] buf = null;
			int len=0;
			switch(choice) {
				case 1: 
					String filename[] = request.getParameterValues("filenames");
					String fname="";
					
					if(filename!=null){
						for(int iCntr=0;iCntr<filename.length;iCntr++){
							fname+=filename[iCntr]+" ";
							File file= new File(IViewPropertyReader.BackupDIR + filename[iCntr]);
							file.delete();
							CyberoamLogger.appLog.debug("BackupFileServlet->Delete->filename->"+file.getName());
						}
					}				
					session.setAttribute("statusCheck","2");
					session.setAttribute("fileName",fname);				
					response.sendRedirect(request.getContextPath() + "/webpages/backuprestore.jsp?statusCheck=2&fileName="+fname);
					break;
				case 2:	//if choice=2, the request is download request.
					out = response.getOutputStream();
					buf = new byte[1024];
					response.setContentType("application/octet-stream");
					FileInputStream in=new FileInputStream(IViewPropertyReader.BackupDIR + request.getRequestURI().replace("/backup/",""));
					while ((len = in.read(buf)) > 0) {
						out.write(buf, 0, len);
					}
					in.close();
					out.flush();
					out.close();
					CyberoamLogger.appLog.debug("BackupFileServlet->Download");
					break;
			case 3: 
				out = response.getOutputStream();
				String exportcontent="",logs="";
				ArrayList logcontainer=null;
				response.setContentType("application/octet-stream");
				CPUUsageBean cpuUsageBean=SystemInformation.getCPUUsage();
				MemoryUsageBean memoryUsageBean=TroubleShoot.getMemoryUsage();
				DiskUsageBean diskUsageBean=SystemInformation.getDiskUsage();
				exportcontent="Logs Started on : "+new java.util.Date().toString();
				exportcontent+="\n\n\t\t\tCPU Usage Details\n\nFree : "+new Integer(cpuUsageBean.getIdlePercent())+ "%\t\tUsed : "+(100-new Integer(cpuUsageBean.getIdlePercent())+" %");
				exportcontent+="\n\n\t\t\tMemory Usage Details\n\nFree : "+new DecimalFormat(".##").format(memoryUsageBean.getFreeMemory()/(1024*1024))+" MB\t\tUsed : "+new DecimalFormat(".##").format(memoryUsageBean.getMemoryInUse()/(1024*1024))+" MB";
				exportcontent+="\n\n\t\t\tArchive In Disk Details\n\nFree : "+new DecimalFormat(".##").format((double)diskUsageBean.getFreeInArchive()/(1024*1024))+" GB\t\tUsed : "+new DecimalFormat(".##").format((double)diskUsageBean.getUsedInArchive()/(1024*1024))+" GB";
				exportcontent+="\n\n\t\t\tDatabase In Disk Details\n\nFree : "+new DecimalFormat(".##").format((double)diskUsageBean.getFreeInData()/(1024*1024))+" GB\t\tUsed : "+new DecimalFormat(".##").format((double)diskUsageBean.getUsedInData()/(1024*1024))+" GB";
				exportcontent+="\n\n\t\t\tGarner Logs\n\n";
				logcontainer=new TroubleShoot().getResponse(2000, "garner" ,"");
				logs=logcontainer.toString();
				exportcontent+=logs.substring(1, logs.length()-1).replace(", ","\n");
				exportcontent+="\n\n\t\t\tTomcat System Logs\n\n";
				logcontainer=new TroubleShoot().getResponse(2000, "tomsys", "");
				logs=logcontainer.toString();
				exportcontent+=logs.substring(1, logs.length()-1).replace(", ","\n");
				exportcontent+="\n\n\t\t\tCurrent Running Queries\n\n";
				logcontainer=new TroubleShoot().getQueries(100,"");
				logs=logcontainer.toString();
				exportcontent+=logs.substring(1, logs.length()-1).replace(", ","\n");
				exportcontent+="\n\n\t\t\tCurrent Database Connections : "+new TroubleShoot().getTotalCon();
				exportcontent+="\n\nLogs Ended on : "+new java.util.Date().toString();
				len=exportcontent.getBytes().length;
				buf = new byte[len];
				buf=exportcontent.getBytes();	
				out.write(buf, 0, len);
				buf=null;
				exportcontent="";
				out.flush();
				out.close();
				CyberoamLogger.appLog.debug("BackupFileServlet->Troubleshoot Download");				
			}
		}
		catch(Exception e){
			CyberoamLogger.appLog.debug("BackupServlet->Exception-> " + e,e);
			try{
				response.sendRedirect(request.getContextPath() + "/webpages/backuprestore.jsp");
			}
			catch(Exception e1){}
		}
	}
}
