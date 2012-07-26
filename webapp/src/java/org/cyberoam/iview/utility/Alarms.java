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

import java.util.Calendar;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.jfree.data.time.Hour;




/**
  * This class is used to schedule bunch of threads on specific time.
  * Currently file manager thread and warm file rotation thread are scheduled from here.  
  *
  * @author  Narendra Shah
  */
public class Alarms {
	/**
	 * This method is used for archive file management scheduling.
	 * @throws Exception
	 */
		public static void addFileManagerThread() throws Exception {
		CyberoamLogger.appLog.info("Filemanger thread sleeptime : " + IViewPropertyReader.FileManagerSleepTimeMIN);
		ScheduledExecutorService scheduler = new ResubmittingScheduledThreadPoolExecutor(1,new MyScheduledExceptionHandler());
		scheduler.scheduleAtFixedRate(new FileManager(), 0, IViewPropertyReader.FileManagerSleepTimeMIN*60, TimeUnit.SECONDS);		
	}
	/**
	 * This method is used for warm file rotation scheduling.
	 * @throws Exception
	 */
	public static void addWarmFilesRotationThread() throws Exception {
		CyberoamLogger.appLog.info("Warm Files Rotaion thread sleeptime Hours : " + IViewPropertyReader.WarmFileSleepTimeHours);		
		ScheduledExecutorService scheduler = new ResubmittingScheduledThreadPoolExecutor(1,new MyScheduledExceptionHandler());
		Calendar tmpDate = Calendar.getInstance();
		tmpDate.set(Calendar.HOUR_OF_DAY, 23);		
		tmpDate.set(Calendar.MINUTE,30);
		Calendar now = Calendar.getInstance();
				
		long diffSeconds = Math.abs((now.getTimeInMillis()-tmpDate.getTimeInMillis())) / 1000;
		scheduler.scheduleAtFixedRate(new WarmFilesRotation(), diffSeconds, IViewPropertyReader.WarmFileSleepTimeHours*60*60, TimeUnit.SECONDS);
		CyberoamLogger.sysLog.info("Alarms.java->WarmFileRotationThread will execute after "+diffSeconds+" seconds.");
	}
	public static void addiViewInfoClientThread(){
		CyberoamLogger.appLog.info("iViewInfoClient thread sleeptime : 1 hour");
		ScheduledExecutorService scheduler = new ResubmittingScheduledThreadPoolExecutor(1,new MyScheduledExceptionHandler());		
		scheduler.scheduleAtFixedRate(new iViewInfoClient(), 0, 60*60, TimeUnit.SECONDS);
	}
}


