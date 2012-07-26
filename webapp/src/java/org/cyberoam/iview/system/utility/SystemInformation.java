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

package org.cyberoam.iview.system.utility;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;
import java.util.StringTokenizer;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.system.beans.CPUUsageBean;
import org.cyberoam.iview.system.beans.DiskUsageBean;
import org.cyberoam.iview.system.beans.MemoryUsageBean;


public class SystemInformation implements Runnable{
	
	public enum OperatingSystem {Linux,Windows,Mac,Other};
	public static OperatingSystem os=null;
	public static boolean isWindow=false;
	public static boolean isLinux=false;
	private static boolean isThreadRunning = false;
	private static Thread diskMonitorThread = null;
	private int threadCount = 0;
	private static long threadSleepTime = 5*60*1000;
	
	static {
		os=detectOS();
	}
	/**
	 * Starts the disk usage monitor thread.
	 */
	public void start(){
		diskMonitorThread = new Thread(this);
		diskMonitorThread.start();
	}
	/**
	 * Get System local ip address.
	 *
	 */
	public static String getFirstLocalIPAddress(){
		String ipAddress="";
		try {
		     Enumeration e = NetworkInterface.getNetworkInterfaces();
		     foundip:
	         while(e.hasMoreElements()) {
	            NetworkInterface ni = (NetworkInterface) e.nextElement();
	            /**
	             * Except lo interface ip.
	             */
	            if(ni.getName().contains("lo")) continue;

	            Enumeration e2 = ni.getInetAddresses();

	            while (e2.hasMoreElements()){
	               InetAddress ip = (InetAddress) e2.nextElement();
	               CyberoamLogger.regLog.debug("IP address: "+ ip.toString());
	               ipAddress=ip.toString();
	               break foundip;
	            }
		     }			
		}catch (Exception e) {
			
		}
		return ipAddress;
	}
	/**
	 * This method runs System usage information.
	 */
	public void run(){
		if(isThreadRunning){
			return;
		}
		isThreadRunning = true;
		try{
			while(true){
				CyberoamLogger.sysLog.debug("System Information Thread Started");
				if(threadCount%12 == 0){ // Disk Usage and Memory Usage to be called every 1 hour. 
					threadCount=1;
					CyberoamLogger.sysLog.debug("System Information Thread Started for disk");
					DiskUsageBean diskUsageBean=SystemInformation.getDiskUsage();
					diskUsageBean.insertRecord();
					MemoryUsageBean memoryUsageBean=SystemInformation.getMemoryUsage();
					memoryUsageBean.insertRecord();
				}
				CPUUsageBean cpuUsageBean= SystemInformation.getCPUUsage();
				cpuUsageBean.insertRecord();
				DeviceBean.checkForNewDevice();
				CyberoamLogger.sysLog.debug("System Information Thread Ended");
				Thread.sleep(threadSleepTime);
				threadCount++;
			}
		}catch(Exception e){
			CyberoamLogger.sysLog.error("DiskUsageMonitor.run() : " + e,e);
			isThreadRunning = false;
		}
	}
	/**
	 * This method will identify Operating system and then return detected OS
	 * @return detected OS
	 */
	public static OperatingSystem detectOS(){
		String os = System.getProperty("os.name").toLowerCase();
		if(os.indexOf( "win" ) >= 0){
			isWindow=true;
			return OperatingSystem.Windows;
		}else if(os.indexOf( "nix") >=0 || os.indexOf( "nux") >=0){
			return OperatingSystem.Linux;
		}else if(os.indexOf( "mac" ) >= 0){
			return OperatingSystem.Mac;
		}else {
			return OperatingSystem.Other;
		}
	}
	/**
	 * Get current disk usage for Archive and Data drive and update database.
	 */
	public static DiskUsageBean getDiskUsage(){
		String output="";
		String archiveCMD="sh /usr/local/garner/getusageinfo.sh archiveusage " + iViewConfigBean.ArchiveHome;
		String dbCMD="sh /usr/local/garner/getusageinfo.sh dbusage " + iViewConfigBean.PostgresHome;
		long freeInArchive=0;
		long usedInArchive=0;
		long freeInDB=0;
		long usedInDB=0;
		boolean isSameDrive=false;
		CyberoamLogger.sysLog.info("iviewConfigpostgres" +iViewConfigBean.PostgresHome.substring(0, 3) + "####archieve dir:"+iViewConfigBean.ArchiveHome.substring(0,3));
		if(iViewConfigBean.PostgresHome.substring(0, 3).equalsIgnoreCase(iViewConfigBean.ArchiveHome.substring(0,3)) ){
			isSameDrive=true;
		}
		DiskUsageBean diskUsageBean=new DiskUsageBean();
		diskUsageBean.setSameDrive(isSameDrive);
		try {
			ProcessManager diskStatProc=ProcessManager.getProcessManager(false);
			diskStatProc.executeProcess(archiveCMD);
			InputStreamReader inputStreamReader = new InputStreamReader(diskStatProc.getInputStream());
			BufferedReader br = new BufferedReader (inputStreamReader);
			String line = null;
			CyberoamLogger.sysLog.info("<OUTPUT>");
			while((line = br.readLine()) != null ) {
				CyberoamLogger.sysLog.info(line);
				output+=line+"\n";
			}
			CyberoamLogger.sysLog.info("</OUTPUT>");
			StringTokenizer outputToken=new StringTokenizer(output," ");
			
			usedInArchive=Long.parseLong(((String)outputToken.nextElement()).trim());
			freeInArchive=Long.parseLong(((String)outputToken.nextElement()).trim());
			CyberoamLogger.sysLog.info("freeinArchive=" +freeInArchive);
			CyberoamLogger.sysLog.info("usedinArchive=" +usedInArchive);
			diskUsageBean.setFreeInArchive(freeInArchive);
			diskUsageBean.setUsedInArchive(usedInArchive);
		}catch (Exception e) {
			CyberoamLogger.sysLog.debug("ArchieveDrive:" +e,e);
		}
		output="";
		try {
			ProcessManager diskStatProc=ProcessManager.getProcessManager(false);
			diskStatProc.executeProcess(dbCMD);
			InputStreamReader inputStreamReader = new InputStreamReader(diskStatProc.getInputStream());
			BufferedReader br = new BufferedReader (inputStreamReader);
			String line = null;
			CyberoamLogger.sysLog.info("<OUTPUT>");
			while((line = br.readLine()) != null ) {
				CyberoamLogger.sysLog.info(line);
				output+=line+"\n";
			}
			CyberoamLogger.sysLog.info("</OUTPUT>");
			StringTokenizer outputToken=new StringTokenizer(output," ");
			
			usedInDB=Long.parseLong(((String)outputToken.nextElement()).trim());
			freeInDB=Long.parseLong(((String)outputToken.nextElement()).trim());
			CyberoamLogger.sysLog.info("freeindb=" +freeInDB);
			CyberoamLogger.sysLog.info("usedindb=" +usedInDB);
			diskUsageBean.setFreeInData(freeInDB);
			diskUsageBean.setUsedInData(usedInDB);
			 
		}catch (Exception e) {
			CyberoamLogger.sysLog.debug("Database drive:" + e,e);
		}
		return diskUsageBean;
	}
	/**
	 * Get current memory usage and update database.
	 */
	public static MemoryUsageBean getMemoryUsage(){
		String output="";
		String cmd="sh /usr/local/garner/getusageinfo.sh memoryusage";
		long free=0;
		long inUse=0;
		MemoryUsageBean memoryUsageBean=new MemoryUsageBean();
		try {
			ProcessManager diskStatProc=ProcessManager.getProcessManager(false);
			diskStatProc.executeProcess(cmd);
			InputStreamReader inputStreamReader = new InputStreamReader(diskStatProc.getInputStream());
			BufferedReader br = new BufferedReader (inputStreamReader);
			String line = null;
			CyberoamLogger.sysLog.info("<OUTPUT>");
			while((line = br.readLine()) != null ) {
				CyberoamLogger.sysLog.info(line);
				output+=line+"\n";
			}
			CyberoamLogger.sysLog.info("</OUTPUT>");
			StringTokenizer outputToken=new StringTokenizer(output," ");
			
			inUse=Long.parseLong(((String)outputToken.nextElement()).trim());
			free=Long.parseLong(((String)outputToken.nextElement()).trim());			
			CyberoamLogger.sysLog.info("Used RAM=" +inUse);
			CyberoamLogger.sysLog.info("Free Ram=" +free);
			memoryUsageBean.setFreeMemory(free);
			memoryUsageBean.setMemoryInUse(inUse);
			
		}catch (Exception e) {
			CyberoamLogger.sysLog.debug("Memory usage:" + e,e);
		}
		return memoryUsageBean;
	}
	/**
	 * Get idle cpu and update database.
	 */
	public static CPUUsageBean getCPUUsage(){
		String output="";
		String cmd="sh /usr/local/garner/getusageinfo.sh cpuusage";
		int free=0;	
		CPUUsageBean processorUsageBean=new CPUUsageBean();
		try {
			ProcessManager diskStatProc=ProcessManager.getProcessManager(false);
			int status = diskStatProc.executeProcess(cmd);
			InputStreamReader inputStreamReader = new InputStreamReader(diskStatProc.getInputStream());
			BufferedReader br = new BufferedReader (inputStreamReader);
			String line = null;
			CyberoamLogger.sysLog.info("<OUTPUT>");
			while((line = br.readLine()) != null ) {
				CyberoamLogger.sysLog.info(line);
				output+=line+"\n";
			}
			CyberoamLogger.sysLog.info("</OUTPUT>");
			StringTokenizer outputToken=new StringTokenizer(output," ");
			free=Integer.parseInt(((String)outputToken.nextElement()).trim());
			CyberoamLogger.sysLog.info("Free CPU=" +free);
			processorUsageBean.setIdlePercent(free);
		}catch (Exception e) {
			CyberoamLogger.sysLog.debug("CPU usage:" + e,e);
		}
		return processorUsageBean;
	}
}

