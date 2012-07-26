package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.audit.*;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.*;
import org.cyberoam.iview.authentication.beans.*;
import java.util.Iterator;
import java.text.NumberFormat;
import org.cyberoam.iview.modes.ApplicationModes;
import java.util.*;
import org.cyberoam.iview.beans.CategoryReportGroupRelationBean;;

public final class newmailscheduler_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- ***********************************************************************\n*  Cyberoam iView - The Intelligent logging and reporting solution that \n*  provides network visibility for security, regulatory compliance and \n*  data confidentiality \n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\n*  \n*  This program is free software: you can redistribute it and/or modify \n*  it under the terms of the GNU General Public License as published by \n*  the Free Software Foundation, either version 3 of the License, or\n*  (at your option) any later version.\n*  \n*  This program is distributed in the hope that it will be useful, but \n*  WITHOUT ANY WARRANTY; without even the implied warranty of \n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \n*  General Public License for more details.\n*  \n*  You should have received a copy of the GNU General Public License \n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\n*  \n*  The interactive user interfaces in modified source and object code \n");
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n<html>\n");

	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		boolean isUpdate = false;
		MailScheduleBean mailScheduleBean = null;
		ArrayList schedulerDeviceIdList = null;
		int reportGroupId = -1;
		
		
		int reportType=1;
		
		Iterator bookmarkIterator=null;
		boolean isBookmark=false;
		int	categoryId = Integer.parseInt(session.getAttribute("categoryid").toString());
				
		if(request.getParameter("schedulerid") != null && !"".equalsIgnoreCase(request.getParameter("schedulerid"))){
			isUpdate = true;
			mailScheduleBean = MailScheduleBean.getRecordByPrimaryKey(Integer.parseInt(request.getParameter("schedulerid")));
			reportGroupId = mailScheduleBean.getReportGroupID();
			isBookmark=mailScheduleBean.getIsBookmark();
			int[] deviceId = mailScheduleBean.getDeviceID();
			schedulerDeviceIdList = new ArrayList(deviceId.length);
			for(int i=0; i<deviceId.length; i++){
				schedulerDeviceIdList.add(i,new Integer(deviceId[i]));
			}
		}
		String header = TranslationHelper.getTranslatedMessge(isUpdate==true?"Update Report Notification":"Add Report Notification");
		NumberFormat nf=NumberFormat.getInstance();
		nf.setMinimumIntegerDigits(2);
			
		ArrayList reportGrpIds=CategoryReportGroupRelationBean.getReportgroupListByCategory(categoryId);
		bookmarkIterator=BookmarkBean.getRecord("categoryid",categoryId).values().iterator();
		ReportGroupBean reportGroupBean = null;	
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Pragma","no-cache");
		response.setHeader("Cache-Control","no-store");

      out.write("\n<head>\n<title>");
      out.print( iViewConfigBean.TITLE );
      out.write("</title>\n<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n<style>\ntd.tddata1 {\n\tcolor:#313131;\n\tfont-family:Arial,Verdana,Helvetica,sans-serif;\n\tfont-size:12px;\n\theight:18px;\n\toverflow:hidden;\n\tpadding:0 4px 0 4px;\n\twhite-space:nowrap;\n}\n</style>\n</head>\n<body onload=\"loadMailSchedule()\">\n<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"addnewform\" onSubmit=\"return validateForm('");
      out.print( isUpdate?ApplicationModes.UPDATE_MAIL_SCHEDULER:ApplicationModes.ADD_MAIL_SCHEDULER );
      out.write("');\">\n<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print( isUpdate?ApplicationModes.UPDATE_MAIL_SCHEDULER:ApplicationModes.ADD_MAIL_SCHEDULER );
      out.write("\">\n<input type=\"hidden\" name=\"schedulerid\" value=\"");
      out.print( isUpdate?mailScheduleBean.getMailScheduleID():"" );
      out.write("\">\n\n<table cellpadding=\"2\" cellspacing=\"0\" width=\"100%\" border=\"0\">\t\n\t<tr class=\"innerpageheader\">\n\t\t<td width=\"3%\">&nbsp;</td>\n\t\t<td class=\"contHead\">");
      out.print( header );
      out.write("</td>\n\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleThickBox('2','newshhedular')\" style=\"cursor: pointer;\">\n\t\t</td>\n\t</tr>\n</table>\n<div style=\"margin:5px\" align=\"center\">\n<div style=\"width:95%;border:1px solid #999999;\">\n<table cellpadding=\"2\" cellspacing=\"2\" width=\"100%\" align=\"center\" style=\"background:#FFFFFF;\">\n");
	
	if(session.getAttribute("message") != null){	
      out.write("\n\t<tr><td colspan=\"2\" align=\"left\" class=\"message\">");
      out.print(session.getAttribute("message") );
      out.write("</td></tr>\n");
	
	session.removeAttribute("message");	
	}

      out.write("\n\t<tr >\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Name") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td><input type=\"text\" name=\"schedulername\" class=\"datafield\" maxlength=\"25\" value=\"");
      out.print(isUpdate==true?mailScheduleBean.getScheduleName():"" );
      out.write('"');
      out.write(' ');
      out.print( isUpdate?"disabled=\"disabled\"":"" );
      out.write("></td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Description") );
      out.write("</td>\n\t\t<td><textarea rows=\"2\" cols=\"17\" name=\"description\" class=\"datafield\" >");
      out.print((isUpdate==true&&mailScheduleBean.getDescription()!=null)?mailScheduleBean.getDescription():"" );
      out.write("</textarea></td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("To Email Address") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td><input type=\"text\" name=\"toaddress\" maxlength=\"100\" class=\"datafield\" value=\"");
      out.print(isUpdate==true?mailScheduleBean.getToaddress():"" );
      out.write("\">&nbsp;&nbsp;(Use comma \",\" for multiple mail id's)\n\t</tr>\n\t<tr >\n\t\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Select Category") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td>\n\t\t\n\t\t<select id='mailCategory' name=\"mailCategory\" style=\"width:45%\" onchange='getDevicesByCategoty();' ");
      out.print( isUpdate?"disabled=\"disabled\"":"" );
      out.write(">\n\t\t");
   			
  			Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
  			CategoryBean categoryBean= null;
  			while(categoryBeanItr.hasNext()){	  		
  				categoryBean = (CategoryBean)categoryBeanItr.next();
  				if(isUpdate) { 			
  					if(!isBookmark){
  						categoryId = ReportGroupBean.getRecordbyPrimarykey(reportGroupId).getCategoryId();  					
  						reportGrpIds=CategoryReportGroupRelationBean.getReportgroupListByCategory(categoryId);
  					}
  					else{
  						categoryId=BookmarkBean.getRecordbyPrimarykey(reportGroupId).getCategoryId();
  						bookmarkIterator=BookmarkBean.getRecord("categoryid",categoryId).values().iterator();		
  					}
  					
  				}  				
				 
		
      out.write(" \t\t\t\t\n  \t\t\t<option value='");
      out.print(categoryBean.getCategoryId());
      out.write('\'');
      out.write(' ');
      out.print((categoryBean.getCategoryId() == categoryId)?"selected='selected'":"" );
      out.write(' ');
      out.write('>');
      out.print(categoryBean.getCategoryName());
      out.write("</option>  \t\t\t\t\n  \t\t");
}
  		
      out.write("\n  \t\t</select>  \t\n  \t\t</td>  \t\t\n\t</tr>\n\t<tr>\n\t\t\t<td class=\"textlabels\" width=\"20%\">\n\t\t\t\t<input type=\"radio\" value=\"Report Group\" name=\"rdchoice\" ");
      out.print(!isBookmark?"checked='checked'":"" );
      out.write(" onclick=\"decideCombo();\">Report Group\n\t\t\t</td>\n\t\t\t<!--removed the div tag because in some browser it was not showing bookamrk option at proper place-->\n\t\t\t<td style=\"font-family:Arial,Helvetica,sans-serif;font-size:12px\">\n\t\t\t\t<input type=\"radio\" value=\"Bookmarks\" align=\"left\" name=\"rdchoice\" ");
      out.print(isBookmark?"checked='checked'":"" );
      out.write(" onclick=\"decideCombo();\" ");
      out.print(bookmarkIterator.hasNext()?"":"disabled='disabled'" );
      out.write(">Bookmarks\n\t\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Report Group") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td ><select name=\"reportgroup\" id='reportgroup' ");
      out.print(!isBookmark?"":"disabled='disabled'");
      out.write(">\n\t\t");

			for(int i=0;i<reportGrpIds.size();i++){
				reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(Integer.parseInt(reportGrpIds.get(i).toString()));				
				if(reportGroupBean.getGroupType() == ReportGroupBean.STATIC_GROUP || reportGroupBean.getGroupType() == ReportGroupBean.DYNAMIC_GROUP){					
		
      out.write("\n\t\t\t\t\t<option value=\"");
      out.print( reportGroupBean.getReportGroupId() );
      out.write('"');
      out.write(' ');
      out.print( reportGroupBean.getReportGroupId()==reportGroupId?"selected=\"selected\"":"" );
      out.write(' ');
      out.write('>');
      out.print( reportGroupBean.getTitle() );
      out.write("</option>\n\t\t");
		}
			}
		
      out.write(" \n\t\t\t</select>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Bookmarks") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td ><select name=\"bookmarks\" id='bookmarks' ");
      out.print(isBookmark?"":"disabled='disabled'");
      out.write(">\n\t\t");

			BookmarkBean bookmarkBean=null;
			if(bookmarkIterator.hasNext()){
				while(bookmarkIterator.hasNext()){
					bookmarkBean = (BookmarkBean)bookmarkIterator.next();				
									
		
      out.write("\n\t\t\t\t\t\t<option value=\"");
      out.print( bookmarkBean.getBookmarkId() );
      out.write('"');
      out.write('>');
      out.print( bookmarkBean.getName() );
      out.write("</option>\n\t\t");
		
				}
			 }
			else{
      out.write("\n\t\t\t\t<option value=\"0\">No Bookmarks Found</option>\n\t\t\t");
}
		
      out.write(" \n\t\t\t</select>\n\t\t</td>\n\t</tr>\n\t<tr><td></td></tr>\n\t<tr style=\"border-top:1px solid #AAAAAA\">\n\t\t<td colspan=\"2\" align=\"left\" style=\"height: 23px\">");
      out.print( TranslationHelper.getTranslatedMessge("Device Selection") );
      out.write("</td>\n\t</tr>\n\t<tr >\n\t\t<td colspan=\"2\"  style=\"height: 23px\">\n\t\t\t<div id=\"deviceinfo\" align=\"center\">\n\t\t\t\t<table width=\"85%\" border=\"0\" cellpadding=\"0\" cellspacing=\"3\">\n\t\t\t\t<tr>\n\t\t\t\t\t<td class=\"trContainer1\">");
      out.print( TranslationHelper.getTranslatedMessge("Available Devices") );
      out.write("</td>\n\t\t\t\t\t<td>&nbsp;</td>\n\t\t\t\t\t<td class=\"trContainer1\">");
      out.print( TranslationHelper.getTranslatedMessge("Selected Devices") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t\t</tr>\n\t\t\t\t<tr>\n\t\t\t\t\t<td class=\"trContainer1\" rowspan=\"2\" width=\"45%\">\n\t\t\t\t\t\t<select name=\"availabledevices\" id=\"availabledevices\" size=\"4\" multiple=\"multiple\" style=\"width: 100%\" class=\"datafield\">\n");
	
	DeviceBean deviceBean = null;
						String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryId);							
						if(deviceIds!= null && deviceIds.length > 0){
							for(int i=0;i<deviceIds.length;i++){									
								deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));									
		if(!isUpdate){

      out.write("\n\t\t\t<option value=\"");
      out.print( deviceBean.getDeviceId() );
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print( deviceBean.getName());
      out.write("</option>\t\t\t\t\t\t\t\t\n");

		continue;
		}
		if(schedulerDeviceIdList!=null && !schedulerDeviceIdList.contains(new Integer(deviceBean.getDeviceId()))){

      out.write("\n\t\t\t\t\t\t<option value=\"");
      out.print( deviceBean.getDeviceId() );
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print( deviceBean.getName());
      out.write("</option>\t\t\t\t\t\t\t\t\n");

		}
	}
						}

      out.write("\t\t\t</select>\n\t\t\t</td>\n\t\t\t<td class=\"trContainer1\" align=\"center\" valign=\"bottom\">\n\t\t\t\t<img src=\"../images/cal_next_month.jpg\" onClick=\"selectDevices('right');\">\n\t\t\t\t\t</td>\n\t\t\t\t\t<td class=\"trContainer1\" rowspan=\"2\" width=\"45%\">\n\t\t\t\t\t\t<select name=\"selecteddevices\" id=\"selecteddevices\" size=\"4\" multiple=\"multiple\" style=\"width: 100%\" class=\"datafield\">\n");

	if(isUpdate){
							Iterator itrDevice = DeviceBean.getDeviceBeanIterator();
		while(itrDevice.hasNext()){
			deviceBean = (DeviceBean) itrDevice.next();
			if(schedulerDeviceIdList!=null && schedulerDeviceIdList.contains(new Integer(deviceBean.getDeviceId()))){

      out.write("\n\t\t\t\t\t\t<option value=\"");
      out.print( deviceBean.getDeviceId() );
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print( deviceBean.getName());
      out.write("</option>\t\t\t\t\t\t\t\t\n");

			}
		}
	}

      out.write("\n\t\t\t\t\t\t</select>\n\t\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t\t<tr>\n\t\t\t\t\t<td class=\"trContainer1\" align=\"center\" valign=\"top\">\n\t\t\t\t\t\t<img src=\"../images/cal_prv_month.jpg\" vspace=\"1\" onClick=\"selectDevices('left');\">\n\t\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\t\t</td>\n\t</tr>\n");

	
	int day = 0;
	int hours = 10;
	int schedulefor = 0;
	int fromhour = 0;
	int tohour = 24;
	int scheduletype = 0;
	if(isUpdate){
		day = mailScheduleBean.getDay();
		hours = mailScheduleBean.getHours();
		schedulefor = mailScheduleBean.getSchedulefor();
		fromhour = mailScheduleBean.getFromhour();
		tohour = mailScheduleBean.getTohour();
		scheduletype= mailScheduleBean.getScheduletype();	
	}

      out.write("\t\n\n\t<tr>\n\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t<div style=\"float:left\">Email Frequency<font class=\"compfield\">*</font></div>\n\t\t\t<div style=\"padding: 1px 45px 1px 1px;\">\n\t\t\t\t<input type=\"radio\" name=\"scheduletype\" value=\"1\" id=\"daily\" onclick=\"setFrequency()\" ");
      out.print( (scheduletype==0 || scheduletype==MailScheduleBean.DAILY)?"checked=\"checked\"":"" );
      out.write(" />&nbsp;&nbsp; Daily&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \n\t\t\t\t<input type=\"radio\" name=\"scheduletype\" value=\"2\" id=\"weekly\" onclick=\"setFrequency()\" ");
      out.print( scheduletype==MailScheduleBean.WEEKLY?"checked=\"checked\"":"" );
      out.write(" />&nbsp;&nbsp;Weekly&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t\t<input type=\"radio\" name=\"scheduletype\" value=\"3\" id=\"monthly\" onclick=\"setFrequency()\" ");
      out.print( scheduletype==MailScheduleBean.MONTHLY?"checked=\"checked\"":"" );
      out.write(" />&nbsp;&nbsp;Monthly&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t\t<input type=\"radio\" name=\"scheduletype\" value=\"4\" id=\"onlyonce\" onclick=\"setFrequency()\" ");
      out.print(scheduletype==MailScheduleBean.ONLY_ONCE?"checked=\"checked\"":"" );
      out.write(" />&nbsp;&nbsp;Only once&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t</div>\n\t\t\t<br>\n\t\t\t<div style=\"padding: 1px 0px 1px 5px; height:85px; width:350px; display:");
      out.print( (scheduletype==0 || scheduletype==MailScheduleBean.DAILY)?"block":"none" );
      out.write(";\" id=\"dailyContainer\">\n\t\t\t<table border=\"0\" width=\"350px\">\t\n\t\t\t<tr>\n\t\t\t\t<td>\n\t\t\t\tSend mail at :\n\t\t\t\t<select name=\"dhour\" onChange=\"dailyHourSelect()\" id=\"dhour\">\n\t\t\t\t");
	for(int hr=1; hr<=24; hr++){
												
      out.write("\n \t\t\t\t\t\t\t\t\t<option value=\"");
      out.print( hr );
      out.write('"');
      out.write(' ');
      out.print( (hr==((isUpdate && scheduletype!=MailScheduleBean.DAILY)?10:hours))?"selected=\"selected\"":"" );
      out.write(' ');
      out.write('>');
      out.print( nf.format((long)hr) );
      out.write("</option>\n\t\t\t\t");
	}		
      out.write("\n\t\t\t\t</select>&nbsp;&nbsp;");
      out.print( TranslationHelper.getTranslatedMessge("Hour(s)") );
      out.write("\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td>\n\t\t\t\tGenerate report for :\n\t\t\t\t<select name=\"dschedulefor\" id=\"dschedulefor\" onChange=\"dailyScheduleForSelect()\">\n\t\t\t\t\t<option value=\"1\" ");
      out.print((scheduletype==MailScheduleBean.DAILY)&& schedulefor==MailScheduleBean.PREVIOUS_DAY?"selected=\"selected\"":"" );
      out.write(">Previous Day</option>\n\t\t\t\t\t<option value=\"2\" ");
      out.print((scheduletype==MailScheduleBean.DAILY)&& schedulefor==MailScheduleBean.SAME_DAY?"selected=\"selected\"":"" );
      out.write(">Same Day</option>\n\t\t\t\t</select>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td>From : \n\t\t\t\t<select name=\"dfromhour\" id=\"dfromhour\" onchange=\"dailyFromHourSelect()\">\n\t\t\t\t");
 for(int i=0 ;i<= (((isUpdate) && (schedulefor==MailScheduleBean.PREVIOUS_DAY || schedulefor==MailScheduleBean.SAME_DAY) && (schedulefor==MailScheduleBean.SAME_DAY))? hours-1:23);i++) {
      out.write("\n\t\t\t\t\t<option value=\"");
      out.print(i);
      out.write('"');
      out.write(' ');
      out.print((i== ((isUpdate)?fromhour:0))?"selected=\"selected\"":"");
      out.write('>');
      out.print( nf.format((long)i) );
      out.write("</option>\n\t\t\t\t");
 }
      out.write(" </select>  Hour(s)\n\t\t\t\tTo :\n\t\t\t\t<select name=\"dtohour\" id=\"dtohour\">\n\t\t\t\t");
 for(int i=fromhour+1;i<=(((isUpdate) && (schedulefor==1 || schedulefor==2) && (schedulefor==2))? hours:24);i++) {
      out.write("\n\t\t\t\t\t<option value=\"");
      out.print(i);
      out.write('"');
      out.write(' ');
      out.print((i==((isUpdate && scheduletype==MailScheduleBean.DAILY)?tohour:24))?"selected=\"selected\"":"" );
      out.write('>');
      out.print( nf.format((long)i) );
      out.write("</option>\n\t\t\t\t");
} 
      out.write("  \n\t\t\t\t</select> Hour(s)\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t</table>\n\t\t\t</div>\n\t\t\t\n\t\t\t<div style=\"padding: 1px 0px 1px 5px; height:85px; width:350px; display:");
      out.print(scheduletype==2?"block":"none" );
      out.write(";\" id=\"weeklyContainer\">\n\t\t\t<table border=\"0\" width=\"350px\">\n\t\t\t<tr>\n\t\t\t<td>\n\t\t\tSend mail at :\n\t\t\t<select name=\"whour\">\n\t\t\t");
				for(int hr=1; hr<=24; hr++){		
      out.write("\n\t\t\t\t\t\t\t\t<option value=\"");
      out.print( hr );
      out.write('"');
      out.write(' ');
      out.print( (hr==((isUpdate && scheduletype!=MailScheduleBean.WEEKLY)?10:hours))?"selected=\"selected\"":"" );
      out.write(' ');
      out.write('>');
      out.print( nf.format((long)hr) );
      out.write("</option>\n\t\t\t");
				}		
      out.write("\n\t\t\t\t</select>&nbsp;&nbsp;");
      out.print( TranslationHelper.getTranslatedMessge("Hour(s)") );
      out.write("\n\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<td>\n\t\t\t<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n\t\t\t<tr >\n\t\t\t\t<td ><input name=\"weekday\" value=\"1\" type=\"radio\"  ");
      out.print( (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==1?"checked=\"checked\"":"" );
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print( TranslationHelper.getTranslatedMessge("Sunday") );
      out.write("</td>\n\t\t\t\t<td ><input name=\"weekday\" value=\"2\" type=\"radio\"  ");
      out.print( (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==2?"checked=\"checked\"":((scheduletype!=MailScheduleBean.WEEKLY)?"checked=\"checked\"":"") );
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print( TranslationHelper.getTranslatedMessge("Monday") );
      out.write("</td>\n\t\t\t\t<td ><input name=\"weekday\" value=\"3\" type=\"radio\"  ");
      out.print( (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==3?"checked=\"checked\"":"" );
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print( TranslationHelper.getTranslatedMessge("Tuesday") );
      out.write("</td>\n\t\t\t\t<td ><input name=\"weekday\" value=\"4\" type=\"radio\"  ");
      out.print( (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==4?"checked=\"checked\"":"" );
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print( TranslationHelper.getTranslatedMessge("Wednesday") );
      out.write("</td>\n\t\t\t</tr>\n\t\t\t<tr >\n\t\t\t\t<td ><input name=\"weekday\" value=\"5\" type=\"radio\"  ");
      out.print( (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==5?"checked=\"checked\"":"" );
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print( TranslationHelper.getTranslatedMessge("Thursday") );
      out.write("</td>\n\t\t\t\t<td ><input name=\"weekday\" value=\"6\" type=\"radio\"  ");
      out.print( (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==6?"checked=\"checked\"":"" );
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print( TranslationHelper.getTranslatedMessge("Friday") );
      out.write("</td>\n\t\t\t\t<td ><input name=\"weekday\" value=\"7\" type=\"radio\"  ");
      out.print( (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==7?"checked=\"checked\"":"" );
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print( TranslationHelper.getTranslatedMessge("Saturday") );
      out.write("</td>\n\t\t\t\t<td >&nbsp;</td>\n\t\t\t</tr>\n\t\t\t</table>\n\t\t\t</td>\n\t\t\t</table>\n\t\t\t</div>\n\t\t\t\n\t\t\t<div style=\"padding: 1px 0px 1px 5px; height:85px; width:350px; display:");
      out.print( scheduletype==MailScheduleBean.MONTHLY?"block":"none" );
      out.write(";\" id=\"monthlyContainer\">\n\t\t\t<table border=\"0\" width=\"350px\">\t\n\t\t\t<tr>\n\t\t\t\t<td>\n\t\t\t\tSend mail at :\n\t\t\t\t<select name=\"mdate\" id=\"mdate\" onchange=\"showMonthlyDateStatus()\">\n\t\t\t\t");
 for(int dt=1; dt<=31; dt++) { 
      out.write("\n\t\t\t\t\t<option value=\"");
      out.print(nf.format((long)dt));
      out.write('"');
      out.write(' ');
      out.print((dt== ((scheduletype==MailScheduleBean.MONTHLY)?day:0))?"selected=\"selected\"":"" );
      out.write(' ');
      out.write('>');
      out.print(dt );
      out.write("</option>\n\t\t\t\t");
} 
      out.write("\n\t\t\t\t</select>&nbsp;Date&nbsp;&nbsp;\n\t\t\t\t<select name=\"mhour\" id=\"dhour\">\n\t\t\t\t");
	for(int hr=1; hr<=24; hr++){
												
      out.write("\n \t\t\t\t\t\t\t\t\t<option value=\"");
      out.print( nf.format((long)hr) );
      out.write('"');
      out.write(' ');
      out.print( (hr==((isUpdate && scheduletype!=MailScheduleBean.MONTHLY)?10:hours))?"selected=\"selected\"":"" );
      out.write(' ');
      out.write('>');
      out.print( nf.format((long)hr) );
      out.write("</option>\n\t\t\t\t");
	}		
      out.write("\n\t\t\t\t</select>&nbsp;&nbsp;");
      out.print( TranslationHelper.getTranslatedMessge("Hour(s)") );
      out.write("\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<div id=\"monthlyLastDayStatus\" class=\"datafield\" style=\"display:");
      out.print( (isUpdate && mailScheduleBean.getScheduletype() == MailScheduleBean.MONTHLY ) && (mailScheduleBean.getDay()==29 || mailScheduleBean.getDay()==30 || mailScheduleBean.getDay()==31)?"block":"none");
      out.write(";\">In case there is no above selected date in Scheduled Month, Last day(date) of Month will be considered</div>\n\t\t\t</tr>\n\t\t\t</table>\n\t\t\t</div>\n\t\t\t\n\t\t\t<div style=\"padding: 1px 0px 1px 5px; height:85px; width:350px; display:");
      out.print( scheduletype==MailScheduleBean.ONLY_ONCE?"block":"none" );
      out.write(";\" id=\"onlyonceContainer\">\n\t\t\t<table border=\"0\" width=\"350px\">\t\n\t\t\t<tr>\n\t\t\t\t<td>\n\t\t\t\tSend mail at :\n\t\t\t\t<select name=\"odate\" id=\"odate\" onchange=\"showOnlyOnceDateStatus()\">\n\t\t\t\t");
 for(int dt=1; dt<=31; dt++) { 
      out.write("\n\t\t\t\t\t<option value=\"");
      out.print(dt);
      out.write('"');
      out.write(' ');
      out.print( (dt==((scheduletype==MailScheduleBean.ONLY_ONCE)?day:0))?"selected=\"selected\"":"" );
      out.write('>');
      out.print(dt );
      out.write("</option>\n\t\t\t\t");
} 
      out.write("\n\t\t\t\t</select>&nbsp;Date&nbsp;&nbsp;\n\t\t\t\t<select name=\"ohour\"  id=\"ohour\">\n\t\t\t\t");
	for(int hr=1; hr<=24; hr++){
												
      out.write("\n \t\t\t\t\t\t\t\t\t<option value=\"");
      out.print( hr );
      out.write('"');
      out.write(' ');
      out.print( (hr==((isUpdate && scheduletype!=MailScheduleBean.ONLY_ONCE)?10:hours))?"selected=\"selected\"":"" );
      out.write('>');
      out.print( nf.format((long)hr) );
      out.write("</option>\n\t\t\t\t");
	}		
      out.write("\n\t\t\t\t</select>&nbsp;&nbsp;");
      out.print( TranslationHelper.getTranslatedMessge("Hour(s)") );
      out.write("\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td>\n\t\t\t\t\tGenerate report for :\n\t\t\t\t\t<select name=\"oschedulefor\" id=\"oschedulefor\">\n\t\t\t\t\t\t<option value=\"1\" ");
      out.print( (scheduletype==MailScheduleBean.ONLY_ONCE && schedulefor==MailScheduleBean.PREVIOUS_DAY)?"selected=\"selected\"":"" );
      out.write(" >Previous Day</option>\n\t\t\t\t\t\t<option value=\"2\" ");
      out.print( (scheduletype==MailScheduleBean.ONLY_ONCE && schedulefor==MailScheduleBean.SAME_DAY)?"selected=\"selected\"":"" );
      out.write(" >Same Day</option>\n\t\t\t\t\t\t<option value=\"3\" ");
      out.print( (scheduletype==MailScheduleBean.ONLY_ONCE && schedulefor==MailScheduleBean.LAST_WEEK)?"selected=\"selected\"":"" );
      out.write(" >Last Week</option>\n\t\t\t\t\t\t<option value=\"4\" ");
      out.print( (scheduletype==MailScheduleBean.ONLY_ONCE && schedulefor==MailScheduleBean.LAST_MONTH)?"selected=\"selected\"":"" );
      out.write(" >Last Month</option>\n\t\t\t\t\t</select>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<div id=\"onlyOnceLastDayStatus\" class=\"datafield\" style=\"display:");
      out.print( (isUpdate && mailScheduleBean.getScheduletype() == MailScheduleBean.ONLY_ONCE) && (mailScheduleBean.getDay()==29 || mailScheduleBean.getDay()==30 || mailScheduleBean.getDay()==31)?"block":"none");
      out.write(";\">In case there is no above selected date in Scheduled Month, Last day(date) of Month will be considered</div>\n\t\t\t</tr>\n\t\t\t</table>\n\t\t\t</div>\n\t\t</td>\n\t</tr>\n\t</table>\n\t</div>\n\t</div>\n\t<table align=\"center\">\n\t<tr>\n\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t<input type=\"submit\" class=\"criButton\" name=\"confirm\" value=");
      out.print( TranslationHelper.getTranslatedMessge(isUpdate==true ?"Update":"Add") );
      out.write(" />\n\t\t\t<input type=\"button\" class=\"criButton\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Cancel") );
      out.write("\" onclick=\"handleThickBox('2','newshhedular')\" />\n\t\t</td>\n\t</tr>\n\t</table>\n</form>\t\n</div>\n\n</body>\n</html>\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.error("ERROR in new proactive report :" + e,e);
}


      out.write("\n\n\n\n\n\n\n\n\n\n\n\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
