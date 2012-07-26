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

/*
 * 
 */
package org.cyberoam.iview.helper;


import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.MailScheduleBean;



/**
 * This helper class is used for data manipulation of mail schedules into database.
 * <br>This helper class allows to add new mail schedule, update mail schedule and deletion of mail schedule.
 * @author Narendra Shah
 *
 */

public class MailSchedulerHelper {

	public MailSchedulerHelper() {
		// TODO Auto-generated constructor stub
	}
	/**
	 * This method is used for generating next expected date in case of
	 * Add mailScheduler and
	 * Update mailScheduler 
	 * @param mailScheduleBean
	 * @return
	 */
	private static String generateExpectedDate(MailScheduleBean mailScheduleBean){
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar curdate = Calendar.getInstance();
		Calendar expdate = Calendar.getInstance();
		try{
			if(mailScheduleBean.getScheduletype()==MailScheduleBean.DAILY){
				/**
				 * in case of daily
				 * generate expected date of next day
				 */
				if(mailScheduleBean.getHours() > curdate.get(Calendar.HOUR_OF_DAY)){
					expdate.set(Calendar.HOUR_OF_DAY, mailScheduleBean.getHours());
				}else{
					expdate.set(Calendar.HOUR_OF_DAY, mailScheduleBean.getHours());
					expdate.add(Calendar.DAY_OF_MONTH, 1);
				}
					expdate.set(Calendar.MINUTE, 00);
					expdate.set(Calendar.SECOND, 00);
			}else if(mailScheduleBean.getScheduletype()==MailScheduleBean.WEEKLY){
				/**
				 * in case of weekly
				 * generate expected date for current week or next week
				 */
				if(curdate.get(Calendar.DAY_OF_WEEK) <= mailScheduleBean.getDay()){
					expdate.add(Calendar.DAY_OF_WEEK, mailScheduleBean.getDay() - curdate.get(Calendar.DAY_OF_WEEK));
				}else{
					expdate.add(Calendar.DAY_OF_WEEK, 7 -(curdate.get(Calendar.DAY_OF_WEEK) - mailScheduleBean.getDay()));
				}
				expdate.set(Calendar.HOUR_OF_DAY,mailScheduleBean.getHours());
				expdate.set(Calendar.MINUTE,00);
				expdate.set(Calendar.SECOND,00);
				CyberoamLogger.sysLog.debug("expdate - " + simpleDateFormat.format((expdate.getTime())));
			}else if(mailScheduleBean.getScheduletype()==MailScheduleBean.MONTHLY || mailScheduleBean.getScheduletype()==MailScheduleBean.ONLY_ONCE){
				/**
				 * in case of monthly or only once 
				 * generate expected date for current month or next month
				 */
				int lastDayOfMonth = curdate.getActualMaximum(curdate.DAY_OF_MONTH);
				int currentDay = curdate.get(Calendar.DAY_OF_MONTH);
				if(lastDayOfMonth < mailScheduleBean.getDay() && lastDayOfMonth!=currentDay){
					/*
					 *when day is greater then the last day of month and
					 *last day is not current day then set date to last day of current month 
					 */
					expdate.set(Calendar.DAY_OF_MONTH, lastDayOfMonth);
				}else if(lastDayOfMonth < mailScheduleBean.getDay() && lastDayOfMonth==currentDay){
					/*
					 *when day is greated then last day of month and
					 *last day is equal to current day then set date to next month  
					 */
					expdate.add(Calendar.MONTH, 1);
					expdate.set(Calendar.DAY_OF_MONTH, mailScheduleBean.getDay());
				}else if(mailScheduleBean.getDay()==lastDayOfMonth && currentDay==lastDayOfMonth){
					/*
					 * when current day, last day and mail generating day all are same 
					 * then set date to next month
					 */
					expdate.add(Calendar.MONTH, 1);
				}else {
					/*
					 * in all other cases like when generate mail date is > or < current date
					 */
					expdate.set(Calendar.DAY_OF_MONTH, mailScheduleBean.getDay());
					if(mailScheduleBean.getDay() <= currentDay) {
						expdate.add(Calendar.MONTH,1);
					}
				}
				expdate.set(Calendar.HOUR_OF_DAY, mailScheduleBean.getHours());
				expdate.set(Calendar.MINUTE,00);
				expdate.set(Calendar.SECOND, 00);
				CyberoamLogger.sysLog.debug("expdate - " + simpleDateFormat.format((expdate.getTime())));
			}
			
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside addMailScheduler() : MailSchedulerHelper "+e,e);
		}
		return simpleDateFormat.format(expdate.getTime());
	}
	
	/**
	 * This method is used to insert new mail schedule into database table.Following parameters must be passed with {@link HttpServletRequest} entity.
	 * <ul>
	 * <li><b>schedulername</b> : name of mail scheduler</li>
	 * <li><b>description</b> : description of mail scheduler</li>
	 * <li><b>toaddress</b> : email address to which mail needs to be sent</li>
	 * <li><b>reportgroup</b> : report group whose notofication will be sent as email</li>
	 * <li><b>selecteddevices</b> : comma separated device list for which email needs to be sent</li>
	 * <li><b>scheduletype</b> : states whether mail will be sent daily or weekly or montly or onlyonce</li>
	 * <li><b>hour</b> : hour at which email needs to be sent</li>
	 * <li><b>schedulefor</b> : set 1,2,3,4 for previous day,same day,last 7 days,last 30 days respectively </li>
	 * <li><b>weekday</b> : day or date on which email needs to be sent.
	 * <br>0 for sunday, 1 for monday and so on. and date 1 to 30 or 31 depends on month
	 * </li></ul>
	 * @param request
	 * @param response
	 * @return
	 */
	public static int addMailScheduler(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		MailScheduleBean mailScheduleBean = null;
		String schedulerName = request.getParameter("schedulername");
		try{
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			mailScheduleBean = new MailScheduleBean();
			String description = request.getParameter("description");
			String toAddress = request.getParameter("toaddress");
			String reportGroupId = request.getParameter("reportgroup");
			String bookmarkId = request.getParameter("bookmarks");
			String[] deviceId = request.getParameterValues("selecteddevices");
			String scheduletype = request.getParameter("scheduletype");
			String hour = null;
			String weekday = null;
			String schedulefor=null;
			String fromhour=null;
			String tohour=null;
			String date = null;
			int[] iDeviceId = null;

			mailScheduleBean.setScheduleName(schedulerName);
			mailScheduleBean.setDescription(description);
			mailScheduleBean.setToaddress(toAddress);
			if(reportGroupId!=null){
				mailScheduleBean.setReportGroupID(Integer.parseInt(reportGroupId));
				mailScheduleBean.setIsBookamrk(false);
			}
			if(bookmarkId!=null){
				mailScheduleBean.setReportGroupID(Integer.parseInt(bookmarkId));
				mailScheduleBean.setIsBookamrk(true);
			}
			
			switch(Integer.parseInt(scheduletype)){
				//daily case
				case MailScheduleBean.DAILY:
					hour = request.getParameter("dhour");
					mailScheduleBean.setDay(0);
					schedulefor = request.getParameter("dschedulefor");
					fromhour = request.getParameter("dfromhour");
					tohour =  request.getParameter("dtohour");
					break;
				//weekly case
				case MailScheduleBean.WEEKLY:
					hour = request.getParameter("whour");
					weekday=request.getParameter("weekday");
					mailScheduleBean.setDay(Integer.parseInt(weekday));
					schedulefor ="0";
					fromhour= "0";
					tohour= "0";
					break;
				//monthly case
				case MailScheduleBean.MONTHLY:
					hour = request.getParameter("mhour");
					date = request.getParameter("mdate");
					mailScheduleBean.setDay(Integer.parseInt(date));
					schedulefor ="0";
					fromhour= "0";
					tohour= "0";
					break;
				//onlyonce case
				case MailScheduleBean.ONLY_ONCE:
					hour = request.getParameter("ohour");
					date = request.getParameter("odate");
					mailScheduleBean.setDay(Integer.parseInt(date));
					schedulefor = request.getParameter("oschedulefor");
					fromhour= "0";
					tohour= "0";
					break;
			}
			mailScheduleBean.setHours(Integer.parseInt(hour));
			mailScheduleBean.setSchedulefor(Integer.parseInt(schedulefor));
			mailScheduleBean.setFromhour(Integer.parseInt(fromhour));
			mailScheduleBean.setTohour(Integer.parseInt(tohour));
			mailScheduleBean.setScheduletype(Integer.parseInt(scheduletype));
			iDeviceId = new int[deviceId.length];
			for(int i=0; i<deviceId.length; i++) {
				iDeviceId[i] = Integer.parseInt(deviceId[i]);
			}
			mailScheduleBean.setDeviceID(iDeviceId);
			mailScheduleBean.setLastsendtime("2001-01-01 00:00:00");
			mailScheduleBean.setExpectedDate(generateExpectedDate(mailScheduleBean));
			returnStatus = mailScheduleBean.insertRecord();
			CyberoamLogger.appLog.debug("Scheduler added : addMailScheduler() : MailSchedulerHelper ");
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside addMailScheduler() : MailSchedulerHelper "+e,e);
			returnStatus = -1;
		}
		if(returnStatus>0){
			AuditLog.mail.info("Report notification " + schedulerName + " added successfully", request);
		} else {
			AuditLog.mail.critical("Report notification " + schedulerName + " addition failed", request);
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to update mail schedule into database table.Following parameters must be passed with {@link HttpServletRequest} entity.
	 * <ul>
	 * <li><b>schedulerid</b> : Id of mail scheduler</li>
	 * <li><b>description</b> : description of mail scheduler</li>
	 * <li><b>toaddress</b> : email address to which mail needs to be sent</li>
	 * <li><b>reportgroup</b> : report group whose notofication will be sent as email</li>
	 * <li><b>selecteddevices</b> : comma separated device list for which email needs to be sent</li>
	 * <li><b>frequency</b> : states whether mail will be sent daily or weekly</li>
	 * <li><b>hour</b> : hour at which email needs to be sent</li>
	 * <li><b>schedulefor</b> : 0 for previous day and 1 for current(same) day</li>
	 * <li><b>fromhour</b> : statring hour for generating report</li>
	 * <li><b>tohour</b> : ending hour for generating report</li>
	 * <li><b>weekday</b> : day on which email needs to be sent.-1 for daily
	 * <br>0 for sunday, 1 for monday and so on.
	 * </li></ul>
	 * @param request
	 * @param response
	 * @return
	 */
	public static int updateMailScheduler(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar curdate = Calendar.getInstance();
		Calendar expdate = Calendar.getInstance();
		MailScheduleBean mailScheduleBean = null;
		String schedulerId = request.getParameter("schedulerid");
		mailScheduleBean = MailScheduleBean.getRecordByPrimaryKey(Integer.parseInt(schedulerId));
		String schedulerName = mailScheduleBean.getScheduleName();
		try{
			String description = request.getParameter("description");
			String toAddress = request.getParameter("toaddress");
			String reportGroupId = request.getParameter("reportgroup");
			String[] deviceId = request.getParameterValues("selecteddevices");
			String frequency = request.getParameter("frequency");
			String hour = request.getParameter("hour");
			String weekday = request.getParameter("weekday");
			String scheduletype = request.getParameter("scheduletype");
			
			String schedulefor=null;
			String fromhour=null;
			String tohour=null;
			String date = null;
			
			String bookmarkId = request.getParameter("bookmarks");
			int[] iDeviceId = null;

			mailScheduleBean.setDescription(description);
			mailScheduleBean.setToaddress(toAddress);
			if(reportGroupId!=null){
				mailScheduleBean.setReportGroupID(Integer.parseInt(reportGroupId));
				mailScheduleBean.setIsBookamrk(false);
			}
			if(bookmarkId!=null){
				mailScheduleBean.setReportGroupID(Integer.parseInt(bookmarkId));
				mailScheduleBean.setIsBookamrk(true);
			}
			switch(Integer.parseInt(scheduletype)){
			case MailScheduleBean.DAILY :
				//daily case
				hour = request.getParameter("dhour");
				mailScheduleBean.setDay(0);
				schedulefor = request.getParameter("dschedulefor");
				fromhour = request.getParameter("dfromhour");
				tohour =  request.getParameter("dtohour");
				break;
			case MailScheduleBean.WEEKLY:
				//weelky case
				hour = request.getParameter("whour");
				weekday=request.getParameter("weekday");
				mailScheduleBean.setDay(Integer.parseInt(weekday));
				schedulefor= "0";
				fromhour= "0";
				tohour= "0";
				break;
			case MailScheduleBean.MONTHLY:
				//monthly case
				hour = request.getParameter("mhour");
				date = request.getParameter("mdate");
				mailScheduleBean.setDay(Integer.parseInt(date));
				schedulefor= "0";
				fromhour= "0";
				tohour= "0";
				break;
			case MailScheduleBean.ONLY_ONCE:
				//only once case
				hour = request.getParameter("ohour");
				date = request.getParameter("odate");
				mailScheduleBean.setDay(Integer.parseInt(date));
				schedulefor= request.getParameter("oschedulefor");
				fromhour= "0";
				tohour= "0";
				break;
			}
			mailScheduleBean.setHours(Integer.parseInt(hour));
			mailScheduleBean.setSchedulefor(Integer.parseInt(schedulefor));
			mailScheduleBean.setFromhour(Integer.parseInt(fromhour));
			mailScheduleBean.setTohour(Integer.parseInt(tohour));
			mailScheduleBean.setScheduletype(Integer.parseInt(scheduletype));
			mailScheduleBean.setExpectedDate(generateExpectedDate(mailScheduleBean));
			iDeviceId = new int[deviceId.length];
			for(int i=0; i<deviceId.length; i++) {
				iDeviceId[i] = Integer.parseInt(deviceId[i]);
			}
			mailScheduleBean.setDeviceID(iDeviceId);
			
			returnStatus = mailScheduleBean.updateRecord();
			CyberoamLogger.appLog.debug("Scheduler updated : updateMailScheduler() : MailSchedulerHelper ");
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside updateMailScheduler() : MailSchedulerHelper "+e,e);
			returnStatus = -1;
		}
		if(returnStatus>0){
			AuditLog.mail.info("Report notification " + schedulerName + " updated successfully", request);
		} else {
			AuditLog.mail.critical("Report notification " + schedulerName + " updation failed", request);
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to delete mail schedule from database table.
	 * Here &quot;select&quot; parameter must be contain array of mail schedule Ids which needs to be deleted.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int deleteMailScheduler(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		MailScheduleBean mailScheduleBean = null;
		String reportSchIDs[] = request.getParameterValues("select");
		String reportSchNames[] = null;
		String reportSchList="";
		try{
			reportSchNames = new String[reportSchIDs.length];
			for(int i=0;i<reportSchIDs.length;i++){
				reportSchList += reportSchIDs[i]+ ",";
				reportSchNames[i] = MailScheduleBean.getRecordByPrimaryKey(Integer.parseInt(reportSchIDs[i])).getScheduleName();
			}
			reportSchList = reportSchList.substring(0,reportSchList.length()-1);
			returnStatus = MailScheduleBean.deleteAllRecord(reportSchList);
			CyberoamLogger.appLog.debug("Scheduler deleted : deleteMailScheduler() : MailSchedulerHelper ");
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside deleteMailScheduler() : MailSchedulerHelper "+e,e);
			AuditLog.mail.debug("Report notification deletion failed : " + e.getMessage(), request);
			return -1;
		}
		if(returnStatus == reportSchIDs.length){
			reportSchList = "";
			for(int i=0;i<reportSchIDs.length;i++){
				reportSchList += reportSchNames[i]+ ",";
			}
			AuditLog.mail.info("Report notification for " + reportSchList.substring(0, reportSchList.length()-1) + " deleted successfully", request);
		} else {
			AuditLog.mail.info(returnStatus + " Report notification(s) deleted successfully", request);
			AuditLog.mail.critical((reportSchIDs.length - returnStatus) + " Report notification deletion failed", request);
		}
		return returnStatus;
	}
}
