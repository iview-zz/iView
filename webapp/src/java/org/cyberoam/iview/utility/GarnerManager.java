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

import java.io.BufferedReader;
import java.io.InputStreamReader;

import javax.servlet.ServletContextEvent;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.DataBaseConfigBean;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.system.utility.ProcessManager;
import org.cyberoam.iview.system.utility.SystemInformation;


/**
 * This class is used to manage log collecting module of iView i.e. garner
 * @author Narendra Shah
 *
 */
public class GarnerManager implements javax.servlet.ServletContextListener {
	
	/**
	 * This method check is ubuntu os or not . 
	 */
	public static boolean isUbuntu(){
		boolean flag=false;
		InputStreamReader inputStreamReader=null;
		BufferedReader br =null;
		try {
				ProcessManager osnameprocess=ProcessManager.getProcessManager(false);
				osnameprocess.executeProcess("uname -a ");				
				inputStreamReader = new InputStreamReader(osnameprocess.getInputStream());
				br = new BufferedReader (inputStreamReader);
				String line = null;								
				while((line = br.readLine()) != null ) {
					CyberoamLogger.sysLog.info("osname = "+line);
					if(line.toLowerCase().indexOf("ubuntu")>=0){
						flag=true;
						break;
					}
				}
				br.close();
				inputStreamReader .close();			
				return flag;			
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("GarnerManager.start().e:"+e,e);
			try{
				br.close();
				inputStreamReader .close();
			}catch(Exception e1){}
			return false;
		}
	}
	
	/**
	 * This synchronized is used to start garner.
	 */
	public synchronized static void start(){
		boolean flag=true;		
		try {
			UdpPacketCapture.stopCapture();
			CyberoamLogger.sysLog.info("Starting Garner");				
							
					if(GarnerManager.isUbuntu()){
						flag=false;
						ProcessManager.getProcessManager(true).executeProcess("sudo -s /usr/local/garner/garnerd start");
					}
			
			if(flag){
				ProcessManager.getProcessManager(true).executeProcess("sh /usr/local/garner/garnerd start");
			}			
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("GarnerManager.start().e:"+e,e);
		}
	}
	
	/**
	 * This synchronized is used to stop garner.
	 */
	public synchronized static void stop(){
		boolean flag=true;		
		try {
			CyberoamLogger.sysLog.info("Stopping Garner");			
							
					if(GarnerManager.isUbuntu()){
						flag=false;
						ProcessManager.getProcessManager(true).executeProcess("sudo -s /usr/local/garner/garnerd stop");
					}
						
			if(flag){
				ProcessManager.getProcessManager(true).executeProcess("sh /usr/local/garner/garnerd stop");
			}			
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("GarnerManager.stop().e:"+e,e);			
		}
	}
	/**
	 * This synchronized is used to restart garner.
	 */
	public synchronized static void restart(){
		CyberoamLogger.sysLog.debug("Restarting Garner");
		GarnerManager.stop();
		CyberoamLogger.sysLog.debug("Rewriting Garner.conf..");
		if("0".equalsIgnoreCase(DataBaseConfigBean.getValue(DataBaseConfigBean.ARHIEVE_DATA))){
			if(SystemInformation.isWindow){
				ProcessManager.getProcessManager(true).executeProcess("sh /usr/local/garner/rewrite_garner_conf.sh "+ "/cygdrive/"+iViewConfigBean.ArchiveHome.replaceFirst(":/", "/")+" "+-1+" "+-1+" "+iViewConfigBean.getValueByKey("GarnerPort"));
			}else{
				ProcessManager.getProcessManager(true).executeProcess("sh /usr/local/garner/rewrite_garner_conf.sh "+iViewConfigBean.ArchiveHome+" "+-1+" "+-1+" "+iViewConfigBean.getValueByKey("GarnerPort"));
			}			
		}else if(SystemInformation.isWindow){
			ProcessManager.getProcessManager(true).executeProcess("sh /usr/local/garner/rewrite_garner_conf.sh " + "/cygdrive/"+iViewConfigBean.ArchiveHome.replaceFirst(":/", "/")+" "+iViewConfigBean.getValueByKey("dhcpchecksumval")+" "+iViewConfigBean.getValueByKey("webusagechecksumval")+" "+iViewConfigBean.getValueByKey("GarnerPort"));
		}else{
			ProcessManager.getProcessManager(true).executeProcess("sh /usr/local/garner/rewrite_garner_conf.sh " + iViewConfigBean.ArchiveHome+" "+iViewConfigBean.getValueByKey("dhcpchecksumval")+" "+iViewConfigBean.getValueByKey("webusagechecksumval")+" "+iViewConfigBean.getValueByKey("GarnerPort"));
		}	
		GarnerManager.start();
	}

	/**
	 * The Method to start Garner When Server Starts 
	 */
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		CyberoamLogger.sysLog.info("iView Starting up");
		AuditLog.application.info("iView Server started successfully",null);
	}
	
	/**
	 * The Method to stop Garner When Server Stops
	 */
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
		CyberoamLogger.sysLog.info("iView is Stopping now. And stop garner.");
		AuditLog.application.info("iView Server stopped successfully",null);
		GarnerManager.stop();	
		UdpPacketCapture.stopCapture();
	}	
	/**
	 * Return garner status: is running or not.
	 * @return
	 */
	public static boolean getGarnerStatus(){
		boolean flag=true;		
		int garnerStatus=0;
		try{				
				if(GarnerManager.isUbuntu()){
					flag=false;
					garnerStatus=ProcessManager.getProcessManager(true).executeProcess("sudo -s /usr/local/garner/garnerd status");
				}		
		
		if(flag){
			garnerStatus=ProcessManager.getProcessManager(true).executeProcess("sh /usr/local/garner/garnerd status");			
		}
		CyberoamLogger.sysLog.debug("Check Garner Status : " + garnerStatus);		
		if(garnerStatus == 0){
			return true;
		}else {
			return false;
		}
		}catch (Exception e) {
			CyberoamLogger.sysLog.info("iView Status error");		
			return false;
		}
	}
}