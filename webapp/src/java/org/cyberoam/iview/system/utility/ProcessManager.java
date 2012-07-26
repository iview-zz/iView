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

import java.io.InputStream;
import java.io.OutputStream;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.system.utility.SystemInformation.OperatingSystem;


public class ProcessManager extends Process{
	private Process process = null;
	private Runtime runTime = null;
	boolean  waitForFlag;

	private ProcessManager() {    	
	        runTime = Runtime.getRuntime();
	}    
	public void destroy() {
		process.destroy();	
	}

	public int exitValue() {
		return process.exitValue();
	}

	public InputStream getErrorStream() {
		return process.getErrorStream();
	}

	public InputStream getInputStream() {
		return process.getInputStream();
	}

	public OutputStream getOutputStream() {
		return process.getOutputStream();
	}

	public int waitFor() throws InterruptedException {
		return process.waitFor();
	}
	public int executeProcess(String command){
		int status = 0;
		try{ 
			
			if(SystemInformation.os == OperatingSystem.Windows){
				CyberoamLogger.sysLog.debug("Cygwin Execute : "+command);
				process = runTime.exec("\"" + iViewConfigBean.iViewHome + "cygwin/bin/bash.exe\" --login -i -c '" + command+ "'" ,null) ;
			}else {
				CyberoamLogger.sysLog.debug("Unix Execute : "+command);
				process = runTime.exec(command);
			}
			
			if(waitForFlag){
				status = process.waitFor();
				CyberoamLogger.sysLog.info("Process Exit Value : "+status);
			}
		}catch (Exception e) {
			status=-1;
			CyberoamLogger.sysLog.debug("CygwinManager.executeProcess.e:"+e,e);
		}
		return status;
	}
	

	public static ProcessManager getProcessManager(boolean waitForFlag) {
    	ProcessManager processManager = new ProcessManager();
    	processManager.setWaitForFlag(waitForFlag);
    	return processManager;
    }
	/**
	 * @return the waitForFlag
	 */
	public boolean isWaitForFlag() {
		return waitForFlag;
	}

	/**
	 * @param waitForFlag the waitForFlag to set
	 */
	public void setWaitForFlag(boolean waitForFlag) {
		this.waitForFlag = waitForFlag;
	}    
}
