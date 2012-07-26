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

/**
 * 
 */
package org.cyberoam.iview.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Timer;
import java.util.TimerTask;

import javax.activation.FileDataSource;
import javax.mail.internet.MimeBodyPart;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.beans.BookmarkBean;
import org.cyberoam.iview.beans.MailScheduleBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportGroupBean;
import org.cyberoam.iview.beans.ReportGroupRelationBean;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.charts.Chart;
import org.cyberoam.iview.utility.DateDifference;
import org.cyberoam.iview.utility.MailSender;

/**
 * This timer task is used to sent scheduled mails on specified time period.
 * @author Narendra Shah
 * 
 */
public class ScheduledReporter extends TimerTask {
	/**
	 * Timer used for scheduled task. 
	 */
	public static final Timer timer = new Timer();

	/**
	 * This method starts timer task for execution.
	 * Executing this method enables execution of run method every hour.
	 */
	public static void startReporter() {
		CyberoamLogger.sysLog.debug(":::::init ScheduleReporter:::::");
		TimerTask scheduleReporter = new ScheduledReporter();
		Calendar time = Calendar.getInstance();
		/*
		 * Starts to run on each hour with min 0 and seconds also to 0
		 */
		time.add(Calendar.HOUR_OF_DAY, 1);
		time.set(Calendar.MINUTE, 0);
		time.set(Calendar.SECOND, 0);	
		/*
		 * Scheduling hourly to send mail
		 */
		timer.scheduleAtFixedRate(scheduleReporter, time.getTime(), 3600000);
	}
	/**
	 * This method will be executed on specified time period. Here this will be executed every hour.
	 * <br>This method checks mail schedule and send mails that are required to be sent in execution time period.
	 */
	@Override
	public void run() {
		CyberoamLogger.sysLog.debug(":::::Starting ScheduleReporter:::::");
		String pdfFileName = null;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String limit = "15";
		String startDate = null;
		String endDate = null;
		String title=null;
		String bookmarkurl=null;
		String bookmarkfilename=null;
		int reportGroupId=0;
		int reportId=0;
		boolean isBookmark=false;
		boolean isGroup=true;
		Calendar now = null;
		double dayDiff = 0;
		double hourDiff = 0;
		try {
			String fromAddress = iViewConfigBean.getValueByKey(iViewConfigBean.MAIL_ADMIN_ID);
			String message = null;
			BookmarkBean bookmarkBean=null;
			String queryString[];
			LinkedHashMap paramMap=new LinkedHashMap();
			Iterator mailScheduleItr = MailScheduleBean.getIterator();
			String deleteRecord = null;
			boolean sendMail = false;
			Calendar expdate = Calendar.getInstance();
			Calendar curdate = Calendar.getInstance();
			while (mailScheduleItr.hasNext()) {
			 try{
				isGroup=true;
				MailScheduleBean mailScheduleBean = (MailScheduleBean) mailScheduleItr.next();	
				CyberoamLogger.sysLog.debug(":::::Starting ScheduleReporter:::::");
				CyberoamLogger.sysLog.debug("Time = : "+ mailScheduleBean.getLastsendtime().toString());
				expdate.setTime(DateDifference.stringToDate(mailScheduleBean.getExpectedDate()));
				CyberoamLogger.sysLog.debug("expdate from database :- " + simpleDateFormat.format(expdate.getTime()));
				now = Calendar.getInstance();
				sendMail = false;
				
				if(curdate.getTimeInMillis() >= expdate.getTimeInMillis()){
					isBookmark=mailScheduleBean.getIsBookmark();
					if(isBookmark){
						bookmarkBean=BookmarkBean.getRecordbyPrimarykey(mailScheduleBean.getReportGroupID());
						title=bookmarkBean.getDescription();
						bookmarkurl=bookmarkBean.getUrl();
						bookmarkfilename=bookmarkBean.getName();
						if(bookmarkurl.endsWith("=")){
							bookmarkurl+=" ";
						}
						queryString=bookmarkurl.substring(bookmarkurl.indexOf("?")+1,bookmarkurl.length()).split("[=&]");
						
						for(int i=0;i<queryString.length;i=i+2){
								paramMap.put(queryString[i], queryString[i+1]);
						}
						
						if(bookmarkurl.contains("reportgroup.jsp")){
							isGroup=true;
							reportGroupId=Integer.parseInt(paramMap.get("reportgroupid").toString());
							paramMap.remove("reportgroupid");
						}
						
						else{
							isGroup=false;
							reportGroupId=Integer.parseInt(paramMap.get("reportgroupid").toString());
							reportId=Integer.parseInt(paramMap.get("reportid").toString());
							paramMap.remove("reportgroupid");
							paramMap.remove("reportid");
						}
					}
					else{
						title = ReportGroupBean.getRecordbyPrimarykey(mailScheduleBean.getReportGroupID()).getTitle();
						reportGroupId=mailScheduleBean.getReportGroupID();
					}
					
					paramMap.put("title",title);	
					
					if(isBookmark){
						pdfFileName = System.getProperty("java.io.tmpdir") + System.getProperty("file.separator") + bookmarkfilename.replace(' ', '_') + ".pdf";
					}
					else{
						pdfFileName = System.getProperty("java.io.tmpdir") + System.getProperty("file.separator") + title.replace(' ', '_') + ".pdf";
					}
					if (mailScheduleBean.getScheduletype() == MailScheduleBean.DAILY) {
					/**
						 * If notification of type is daily then
					 */
						if(mailScheduleBean.getSchedulefor()==MailScheduleBean.PREVIOUS_DAY){
							/*
							 * in case of previous day 
							 */
							now.add(Calendar.DAY_OF_MONTH, -1);
						}
						now.set(Calendar.HOUR_OF_DAY, mailScheduleBean.getFromhour());
						now.set(Calendar.MINUTE, 0);
						now.set(Calendar.SECOND, 0);
						startDate = simpleDateFormat.format(now.getTime());
						now.set(Calendar.HOUR_OF_DAY, mailScheduleBean.getTohour() -1);
						now.set(Calendar.MINUTE, 59);
						now.set(Calendar.SECOND, 59);
						endDate = simpleDateFormat.format(now.getTime());
						
						while(expdate.getTimeInMillis() < curdate.getTimeInMillis()){
							expdate.add(Calendar.DAY_OF_MONTH,1);
						}
						sendMail = true;
					} else if (mailScheduleBean.getScheduletype()==MailScheduleBean.WEEKLY) {
						/**
						 * If notification of type weekly then
						 */
						now.add(Calendar.DAY_OF_MONTH, -1);
						now.set(Calendar.HOUR_OF_DAY, 23);
						now.set(Calendar.MINUTE, 59);
						now.set(Calendar.SECOND, 59);
						endDate = simpleDateFormat.format(now.getTime());

						now.add(Calendar.DAY_OF_YEAR, -6);
						now.set(Calendar.HOUR_OF_DAY, 0);
						now.set(Calendar.MINUTE, 0);
						now.set(Calendar.SECOND, 0);
						startDate = simpleDateFormat.format(now.getTime());
						
						while(expdate.getTimeInMillis() < curdate.getTimeInMillis()){
							expdate.add(Calendar.WEEK_OF_MONTH,1);
						}
						sendMail = true;
					} else if(mailScheduleBean.getScheduletype() == MailScheduleBean.MONTHLY  ){
						/**
						 * If notification of type is Monthly then
						 */
						now.add(Calendar.DAY_OF_MONTH,-1);
						now.set(Calendar.HOUR_OF_DAY, 23);
						now.set(Calendar.MINUTE, 59);
						now.set(Calendar.SECOND, 59);
						endDate = simpleDateFormat.format(now.getTime());
						
						now.add(Calendar.MONTH, -1);
						now.set(Calendar.HOUR_OF_DAY, 0);
						now.set(Calendar.MINUTE, 0);
						now.set(Calendar.SECOND, 0);
						startDate = simpleDateFormat.format(now.getTime());
						CyberoamLogger.sysLog.debug("expdate from database :- " + simpleDateFormat.format(expdate.getTime()));
						CyberoamLogger.sysLog.debug("nxt mnth = " + expdate.get(expdate.MONTH) + " day = " + expdate.get(Calendar.DAY_OF_MONTH));
						while(expdate.getTimeInMillis() < curdate.getTimeInMillis()){
							expdate.add(Calendar.MONTH, 1);
					}
						CyberoamLogger.sysLog.debug("nxt mnth = " + expdate.get(Calendar.MONTH) + " day = " + expdate.get(Calendar.DAY_OF_MONTH));
						if((expdate.get(Calendar.MONTH)==0 || //January
							expdate.get(Calendar.MONTH)==2 || //March
							expdate.get(Calendar.MONTH)==4 || //May
							expdate.get(Calendar.MONTH)==6 || //July
							expdate.get(Calendar.MONTH)==7 || //August
							expdate.get(Calendar.MONTH)==9 || //October
							expdate.get(Calendar.MONTH)==11 )&&( //December
							expdate.get(Calendar.DAY_OF_MONTH) == 28 ||
							expdate.get(Calendar.DAY_OF_MONTH) == 29 || 
							expdate.get(Calendar.DAY_OF_MONTH) == 30 )){
							CyberoamLogger.sysLog.debug(mailScheduleBean.getDay());
					/**
							 * if expected months are from january, march, may, july, august, october, december and
							 * expected day of month is from 28, 29, 30 then set day of month explicitly
					 */
							expdate.set(Calendar.DAY_OF_MONTH, mailScheduleBean.getDay());
						}
						sendMail = true;
					} else if(mailScheduleBean.getScheduletype()==MailScheduleBean.ONLY_ONCE){
						/**
						 * If notification of type is only once then
						 */
						int toHour = mailScheduleBean.getHours();
						
						if(mailScheduleBean.getSchedulefor()==MailScheduleBean.SAME_DAY){
							//in case of same day set toHours to current hour -1
							now.set(Calendar.HOUR_OF_DAY, toHour - 1);
						}else{
							//in case of else set end date of month as previous day
						now.add(Calendar.DAY_OF_MONTH, -1);
						now.set(Calendar.HOUR_OF_DAY, 23);
						}
						now.set(Calendar.MINUTE, 59);
						now.set(Calendar.SECOND, 59);
						endDate = simpleDateFormat.format(now.getTime());
						if(mailScheduleBean.getSchedulefor()==MailScheduleBean.LAST_WEEK){
							//in previous week case
							now.add(Calendar.WEEK_OF_MONTH, -1);
						}else{
							//in previous month case
							now.add(Calendar.MONTH, -1);
						}
						now.set(Calendar.HOUR_OF_DAY, 0);
						now.set(Calendar.MINUTE, 0);
						now.set(Calendar.SECOND, 0);
						startDate = simpleDateFormat.format(now.getTime());
						if(deleteRecord==null){
							deleteRecord = "" + mailScheduleBean.getMailScheduleID();
						}else{
							deleteRecord += "," + mailScheduleBean.getMailScheduleID();
						}
						sendMail = true;
					}
				}
				CyberoamLogger.sysLog.debug("startdate:" + startDate + "#enddate:" + endDate);
				if (sendMail) {
					/**
					 * Generating html message part for mail
					 */
					String reportName="";
					String top,middle1,middle2,bottom;
					/**
					 * Static contents
					 */
					top="<html><head><title>Cyberoam iView Report Profile</title></head><body><font style=\"FONT-WEIGHT: bold;FONT-SIZE: 11px;COLOR: green;FONT-FAMILY: tahoma,arial,san-serif;TEXT-DECORATION: none\">Note: This message is auto generated by Cyberoam iView.</font><br><br><font style=\"font-family: Arial, Helvetica, sans-serif;font-size: 12px;color: #000000;padding-left: 2px;\">Dear User,<p>As of your request the following Report Profile is sent to you. <br/><br/>Please Check pdf Attachment</p></font><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=100%><tr><table style=\"BACKGROUND-COLOR: #EEEEF0\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" width=100%><tr><td style=\"BORDER-LEFT:#96AEBE 3px solid;BORDER-RIGHT: white 2px solid;HEIGHT: 18pt;BACKGROUND-COLOR: #96AEBE\" align=\"left\" width=15%><font style=\"FONT-WEIGHT: bolder;FONT-SIZE: 10px;COLOR: white;FONT-FAMILY: tahoma,arial,san-serif;TEXT-DECORATION: none\">Report Profile</font></td><td colspan=\"2\" style=\"BORDER-LEFT: #96AEBE 3px solid;BORD"+
					"ER-RIGHT: white 2px solid;HEIGHT: 18pt;BACKGROUND-COLOR: #96AEBE\" align=\"left\"><font style=\"FONT-WEIGHT: bolder;FONT-SIZE: 10px;COLOR: white;FONT-FAMILY: tahoma,arial,san-serif;TEXT-DECORATION: none\">";
					if(isGroup){
						middle1="&nbsp;</font></td></tr>" + "<tr><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\" width=17%><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><b>Start Date</b></td><td><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + startDate + "</font></td></tr>" + "<tr><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\" width=17%\"><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><b>End Date</b></td><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\"width=75%\"><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + endDate + "</font></td></tr>" + 
								"<tr><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\" width=17%><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><b>Reports</b></td><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\"width=75%><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><ol>";
						middle2="</ol></td></tr><tr><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\" width=17%><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><b>Device names(IP Address)</b></td><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\"width=75%><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><ol>";
					}
					else
					{
						middle1="&nbsp;</font></td></tr>" + "<tr><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\" width=17%><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><b>Start Date</b></td><td><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + startDate + "</font></td></tr>" + "<tr><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\" width=17%\"><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><b>End Date</b></td><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\"width=75%\"><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + endDate + "</font></td></tr>";
						middle2="<tr><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\" width=17%><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><b>Device names(IP Address)</b></td><td style=\"border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-top-style: none;border-right-style: solid;border-bottom-style: solid;border-left-style: none;border-top-color: #FFFFFF;border-right-color: #FFFFFF;border-bottom-color: #FFFFFF;border-left-color: #FFFFFF;\" align=\"left\"width=75%><font style=\"FONT-SIZE: 12px;COLOR: black;FONT-FAMILY: arial,san-serif;TEXT-DECORATION: none\"><ol>";
					}
					
					bottom="</ol></td></tr></table><font style=\"font-family: Arial, Helvetica, sans-serif;font-size: 12px;color: #000000;padding-left: 2px;\"><br><br>Cyberoam iView.</font></body></html>";
					/**
					 * Report names which are included in the pdf.
					 */
					
					ArrayList reportGroupRelBeanList;
					ReportGroupRelationBean reportGroupRelationBean;					
					ReportGroupBean reportGroupBean=new ReportGroupBean();
					reportGroupRelBeanList=reportGroupBean.getReportIdByReportGroupId(reportGroupId);
					int len=reportGroupRelBeanList.size();
					for(int k=0;k<len;k++) {
						reportGroupRelationBean=(ReportGroupRelationBean)reportGroupRelBeanList.get(k);
						reportName += "<li>" +ReportBean.getRecordbyPrimarykey(reportGroupRelationBean.getReportId()).getTitle() +"</li>";
					}
					
					/**
					 * Get device name with IP Address
					 */
					int [] deviceIDs=mailScheduleBean.getDeviceID();
					DeviceBean deviceBean=null;
					String deviceNameWithIP="";
					for(int i=0;i<deviceIDs.length;i++){
						deviceBean=DeviceBean.getRecordbyPrimarykey(deviceIDs[i]);
						if(deviceBean != null){
							deviceNameWithIP += "<li>" + deviceBean.getName() + " (" + deviceBean.getIp() +") </li>";
						}
					}
					if(isGroup){
					message=top+ title+middle1+ reportName+ middle2+ deviceNameWithIP + bottom;
					}
					else{
						message=top+ title+middle1+ middle2+ deviceNameWithIP + bottom;
					}
					
					/**
					 * Generate PDF in the given file which should be attached with the mail
					 */
					if(isGroup){
						Chart.generatePDFReportGroup(new FileOutputStream(pdfFileName),reportGroupId, mailScheduleBean.getApplianceID(), startDate,
							endDate, limit,deviceIDs,null,paramMap);
					}
					else
					{
						Chart.generatePDFReport(new FileOutputStream(pdfFileName),reportId, mailScheduleBean.getApplianceID(), startDate,
								endDate, limit,deviceIDs,null,reportGroupId,paramMap);
					}
					
					new FileDataSource(pdfFileName);
					MimeBodyPart mimePart = new MimeBodyPart();
					mimePart.attachFile(pdfFileName);
					mimePart.setHeader("Content-Type", "application/pdf");
					/**
					 * Send mail
					 */
					MailSender mailSender = new MailSender(fromAddress, mailScheduleBean.getToaddress(), title, message);
					int mailSendStatus = mailSender.sendWithAttachment(mimePart);
					/**
					 * Check the status if mail sent or not.
					 */
					if (mailSendStatus == 0 && mailScheduleBean.getScheduletype() != MailScheduleBean.ONLY_ONCE) {
						mailScheduleBean.setExpectedDate(simpleDateFormat.format(expdate.getTime()));
						mailScheduleBean.setLastsendtime(simpleDateFormat.format(Calendar.getInstance().getTime()));
						mailScheduleBean.updateRecord();
					}
					File pdf = new File(pdfFileName);
					/**
					 * Clear PDF file
					 */
					if (pdf.exists())
						pdf.delete();
				}
			}
			 catch (Exception e) {
				CyberoamLogger.sysLog.debug("ScheduleReporter.e - > mailscheduleitr.next()" + e, e);
			}
			}
			if(deleteRecord!=null)
			MailScheduleBean.deleteOnlyOnceRecord(deleteRecord);
			
		}

		catch (Exception e) {
			CyberoamLogger.sysLog.debug("ScheduleReporter.e" + e, e);
		}
		CyberoamLogger.sysLog.debug(":::::ending ScheduleReporter:::::");
	}
}
