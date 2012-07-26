<!-- ***********************************************************************
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
*********************************************************************** -->

<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.audit.*"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.beans.*"%>
<%@page import="org.cyberoam.iview.authentication.beans.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="java.util.*"%>
<%@page import="org.cyberoam.iview.beans.CategoryReportGroupRelationBean;"%><html>
<%
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
%>
<head>
<title><%= iViewConfigBean.TITLE %></title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<style>
td.tddata1 {
	color:#313131;
	font-family:Arial,Verdana,Helvetica,sans-serif;
	font-size:12px;
	height:18px;
	overflow:hidden;
	padding:0 4px 0 4px;
	white-space:nowrap;
}
</style>
</head>
<body onload="loadMailSchedule()">
<form action="<%=request.getContextPath()%>/iview" method="post" name="addnewform" onSubmit="return validateForm('<%= isUpdate?ApplicationModes.UPDATE_MAIL_SCHEDULER:ApplicationModes.ADD_MAIL_SCHEDULER %>');">
<input type="hidden" name="appmode" value="<%= isUpdate?ApplicationModes.UPDATE_MAIL_SCHEDULER:ApplicationModes.ADD_MAIL_SCHEDULER %>">
<input type="hidden" name="schedulerid" value="<%= isUpdate?mailScheduleBean.getMailScheduleID():"" %>">

<table cellpadding="2" cellspacing="0" width="100%" border="0">	
	<tr class="innerpageheader">
		<td width="3%">&nbsp;</td>
		<td class="contHead"><%= header %></td>
		<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
		<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','newshhedular')" style="cursor: pointer;">
		</td>
	</tr>
</table>
<div style="margin:5px" align="center">
<div style="width:95%;border:1px solid #999999;">
<table cellpadding="2" cellspacing="2" width="100%" align="center" style="background:#FFFFFF;">
<%	
	if(session.getAttribute("message") != null){	%>
	<tr><td colspan="2" align="left" class="message"><%=session.getAttribute("message") %></td></tr>
<%	
	session.removeAttribute("message");	
	}
%>
	<tr >
		<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Name") %><font class="compfield">*</font></td>
		<td><input type="text" name="schedulername" class="datafield" maxlength="25" value="<%=isUpdate==true?mailScheduleBean.getScheduleName():"" %>" <%= isUpdate?"disabled=\"disabled\"":"" %>></td>
	</tr>
	<tr >
		<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Description") %></td>
		<td><textarea rows="2" cols="17" name="description" class="datafield" ><%=(isUpdate==true&&mailScheduleBean.getDescription()!=null)?mailScheduleBean.getDescription():"" %></textarea></td>
	</tr>
	<tr >
		<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("To Email Address") %><font class="compfield">*</font></td>
		<td><input type="text" name="toaddress" maxlength="100" class="datafield" value="<%=isUpdate==true?mailScheduleBean.getToaddress():"" %>">&nbsp;&nbsp;(Use comma "," for multiple mail id's)
	</tr>
	<tr >
	
		<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Select Category") %><font class="compfield">*</font></td>
		<td>
		
		<select id='mailCategory' name="mailCategory" style="width:45%" onchange='getDevicesByCategoty();' <%= isUpdate?"disabled=\"disabled\"":"" %>>
		<%   			
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
				 
		%> 				
  			<option value='<%=categoryBean.getCategoryId()%>' <%=(categoryBean.getCategoryId() == categoryId)?"selected='selected'":"" %> ><%=categoryBean.getCategoryName()%></option>  				
  		<%}
  		%>
  		</select>  	
  		</td>  		
	</tr>
	<tr>
			<td class="textlabels" width="20%">
				<input type="radio" value="Report Group" name="rdchoice" <%=!isBookmark?"checked='checked'":"" %> onclick="decideCombo();">Report Group
			</td>
			<!--removed the div tag because in some browser it was not showing bookamrk option at proper place-->
			<td style="font-family:Arial,Helvetica,sans-serif;font-size:12px">
				<input type="radio" value="Bookmarks" align="left" name="rdchoice" <%=isBookmark?"checked='checked'":"" %> onclick="decideCombo();" <%=bookmarkIterator.hasNext()?"":"disabled='disabled'" %>>Bookmarks
			</td>
	</tr>
	<tr>
		<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Report Group") %><font class="compfield">*</font></td>
		<td ><select name="reportgroup" id='reportgroup' <%=!isBookmark?"":"disabled='disabled'"%>>
		<%
			for(int i=0;i<reportGrpIds.size();i++){
				reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(Integer.parseInt(reportGrpIds.get(i).toString()));				
				if(reportGroupBean.getGroupType() == ReportGroupBean.STATIC_GROUP || reportGroupBean.getGroupType() == ReportGroupBean.DYNAMIC_GROUP){					
		%>
					<option value="<%= reportGroupBean.getReportGroupId() %>" <%= reportGroupBean.getReportGroupId()==reportGroupId?"selected=\"selected\"":"" %> ><%= reportGroupBean.getTitle() %></option>
		<%		}
			}
		%> 
			</select>
		</td>
	</tr>
	<tr>
		<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Bookmarks") %><font class="compfield">*</font></td>
		<td ><select name="bookmarks" id='bookmarks' <%=isBookmark?"":"disabled='disabled'"%>>
		<%
			BookmarkBean bookmarkBean=null;
			if(bookmarkIterator.hasNext()){
				while(bookmarkIterator.hasNext()){
					bookmarkBean = (BookmarkBean)bookmarkIterator.next();				
									
		%>
						<option value="<%= bookmarkBean.getBookmarkId() %>"><%= bookmarkBean.getName() %></option>
		<%		
				}
			 }
			else{%>
				<option value="0">No Bookmarks Found</option>
			<%}
		%> 
			</select>
		</td>
	</tr>
	<tr><td></td></tr>
	<tr style="border-top:1px solid #AAAAAA">
		<td colspan="2" align="left" style="height: 23px"><%= TranslationHelper.getTranslatedMessge("Device Selection") %></td>
	</tr>
	<tr >
		<td colspan="2"  style="height: 23px">
			<div id="deviceinfo" align="center">
				<table width="85%" border="0" cellpadding="0" cellspacing="3">
				<tr>
					<td class="trContainer1"><%= TranslationHelper.getTranslatedMessge("Available Devices") %></td>
					<td>&nbsp;</td>
					<td class="trContainer1"><%= TranslationHelper.getTranslatedMessge("Selected Devices") %><font class="compfield">*</font></td>
				</tr>
				<tr>
					<td class="trContainer1" rowspan="2" width="45%">
						<select name="availabledevices" id="availabledevices" size="4" multiple="multiple" style="width: 100%" class="datafield">
<%	
	DeviceBean deviceBean = null;
						String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryId);							
						if(deviceIds!= null && deviceIds.length > 0){
							for(int i=0;i<deviceIds.length;i++){									
								deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));									
		if(!isUpdate){
%>
			<option value="<%= deviceBean.getDeviceId() %>" ><%= deviceBean.getName()%></option>								
<%
		continue;
		}
		if(schedulerDeviceIdList!=null && !schedulerDeviceIdList.contains(new Integer(deviceBean.getDeviceId()))){
%>
						<option value="<%= deviceBean.getDeviceId() %>" ><%= deviceBean.getName()%></option>								
<%
		}
	}
						}
%>			</select>
			</td>
			<td class="trContainer1" align="center" valign="bottom">
				<img src="../images/cal_next_month.jpg" onClick="selectDevices('right');">
					</td>
					<td class="trContainer1" rowspan="2" width="45%">
						<select name="selecteddevices" id="selecteddevices" size="4" multiple="multiple" style="width: 100%" class="datafield">
<%
	if(isUpdate){
							Iterator itrDevice = DeviceBean.getDeviceBeanIterator();
		while(itrDevice.hasNext()){
			deviceBean = (DeviceBean) itrDevice.next();
			if(schedulerDeviceIdList!=null && schedulerDeviceIdList.contains(new Integer(deviceBean.getDeviceId()))){
%>
						<option value="<%= deviceBean.getDeviceId() %>" ><%= deviceBean.getName()%></option>								
<%
			}
		}
	}
%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="trContainer1" align="center" valign="top">
						<img src="../images/cal_prv_month.jpg" vspace="1" onClick="selectDevices('left');">
					</td>
				</tr>
				</table>
			</div>
		</td>
	</tr>
<%
	
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
%>	

	<tr>
		<td colspan="2" align="center">
			<div style="float:left">Email Frequency<font class="compfield">*</font></div>
			<div style="padding: 1px 45px 1px 1px;">
				<input type="radio" name="scheduletype" value="1" id="daily" onclick="setFrequency()" <%= (scheduletype==0 || scheduletype==MailScheduleBean.DAILY)?"checked=\"checked\"":"" %> />&nbsp;&nbsp; Daily&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<input type="radio" name="scheduletype" value="2" id="weekly" onclick="setFrequency()" <%= scheduletype==MailScheduleBean.WEEKLY?"checked=\"checked\"":"" %> />&nbsp;&nbsp;Weekly&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="scheduletype" value="3" id="monthly" onclick="setFrequency()" <%= scheduletype==MailScheduleBean.MONTHLY?"checked=\"checked\"":"" %> />&nbsp;&nbsp;Monthly&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="scheduletype" value="4" id="onlyonce" onclick="setFrequency()" <%=scheduletype==MailScheduleBean.ONLY_ONCE?"checked=\"checked\"":"" %> />&nbsp;&nbsp;Only once&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<br>
			<div style="padding: 1px 0px 1px 5px; height:85px; width:350px; display:<%= (scheduletype==0 || scheduletype==MailScheduleBean.DAILY)?"block":"none" %>;" id="dailyContainer">
			<table border="0" width="350px">	
			<tr>
				<td>
				Send mail at :
				<select name="dhour" onChange="dailyHourSelect()" id="dhour">
				<%	for(int hr=1; hr<=24; hr++){
												%>
 									<option value="<%= hr %>" <%= (hr==((isUpdate && scheduletype!=MailScheduleBean.DAILY)?10:hours))?"selected=\"selected\"":"" %> ><%= nf.format((long)hr) %></option>
				<%	}		%>
				</select>&nbsp;&nbsp;<%= TranslationHelper.getTranslatedMessge("Hour(s)") %>
				</td>
			</tr>
			<tr>
				<td>
				Generate report for :
				<select name="dschedulefor" id="dschedulefor" onChange="dailyScheduleForSelect()">
					<option value="1" <%=(scheduletype==MailScheduleBean.DAILY)&& schedulefor==MailScheduleBean.PREVIOUS_DAY?"selected=\"selected\"":"" %>>Previous Day</option>
					<option value="2" <%=(scheduletype==MailScheduleBean.DAILY)&& schedulefor==MailScheduleBean.SAME_DAY?"selected=\"selected\"":"" %>>Same Day</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>From : 
				<select name="dfromhour" id="dfromhour" onchange="dailyFromHourSelect()">
				<% for(int i=0 ;i<= (((isUpdate) && (schedulefor==MailScheduleBean.PREVIOUS_DAY || schedulefor==MailScheduleBean.SAME_DAY) && (schedulefor==MailScheduleBean.SAME_DAY))? hours-1:23);i++) {%>
					<option value="<%=i%>" <%=(i== ((isUpdate)?fromhour:0))?"selected=\"selected\"":""%>><%= nf.format((long)i) %></option>
				<% }%> </select>  Hour(s)
				To :
				<select name="dtohour" id="dtohour">
				<% for(int i=fromhour+1;i<=(((isUpdate) && (schedulefor==1 || schedulefor==2) && (schedulefor==2))? hours:24);i++) {%>
					<option value="<%=i%>" <%=(i==((isUpdate && scheduletype==MailScheduleBean.DAILY)?tohour:24))?"selected=\"selected\"":"" %>><%= nf.format((long)i) %></option>
				<%} %>  
				</select> Hour(s)
				</td>
			</tr>
			</table>
			</div>
			
			<div style="padding: 1px 0px 1px 5px; height:85px; width:350px; display:<%=scheduletype==2?"block":"none" %>;" id="weeklyContainer">
			<table border="0" width="350px">
			<tr>
			<td>
			Send mail at :
			<select name="whour">
			<%				for(int hr=1; hr<=24; hr++){		%>
								<option value="<%= hr %>" <%= (hr==((isUpdate && scheduletype!=MailScheduleBean.WEEKLY)?10:hours))?"selected=\"selected\"":"" %> ><%= nf.format((long)hr) %></option>
			<%				}		%>
				</select>&nbsp;&nbsp;<%= TranslationHelper.getTranslatedMessge("Hour(s)") %>
			</td>
			</tr>
			<td>
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr >
				<td ><input name="weekday" value="1" type="radio"  <%= (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==1?"checked=\"checked\"":"" %> /><%= TranslationHelper.getTranslatedMessge("Sunday") %></td>
				<td ><input name="weekday" value="2" type="radio"  <%= (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==2?"checked=\"checked\"":((scheduletype!=MailScheduleBean.WEEKLY)?"checked=\"checked\"":"") %> /><%= TranslationHelper.getTranslatedMessge("Monday") %></td>
				<td ><input name="weekday" value="3" type="radio"  <%= (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==3?"checked=\"checked\"":"" %> /><%= TranslationHelper.getTranslatedMessge("Tuesday") %></td>
				<td ><input name="weekday" value="4" type="radio"  <%= (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==4?"checked=\"checked\"":"" %> /><%= TranslationHelper.getTranslatedMessge("Wednesday") %></td>
			</tr>
			<tr >
				<td ><input name="weekday" value="5" type="radio"  <%= (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==5?"checked=\"checked\"":"" %> /><%= TranslationHelper.getTranslatedMessge("Thursday") %></td>
				<td ><input name="weekday" value="6" type="radio"  <%= (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==6?"checked=\"checked\"":"" %> /><%= TranslationHelper.getTranslatedMessge("Friday") %></td>
				<td ><input name="weekday" value="7" type="radio"  <%= (scheduletype==MailScheduleBean.WEEKLY)&&mailScheduleBean.getDay()==7?"checked=\"checked\"":"" %> /><%= TranslationHelper.getTranslatedMessge("Saturday") %></td>
				<td >&nbsp;</td>
			</tr>
			</table>
			</td>
			</table>
			</div>
			
			<div style="padding: 1px 0px 1px 5px; height:85px; width:350px; display:<%= scheduletype==MailScheduleBean.MONTHLY?"block":"none" %>;" id="monthlyContainer">
			<table border="0" width="350px">	
			<tr>
				<td>
				Send mail at :
				<select name="mdate" id="mdate" onchange="showMonthlyDateStatus()">
				<% for(int dt=1; dt<=31; dt++) { %>
					<option value="<%=nf.format((long)dt)%>" <%=(dt== ((scheduletype==MailScheduleBean.MONTHLY)?day:0))?"selected=\"selected\"":"" %> ><%=dt %></option>
				<%} %>
				</select>&nbsp;Date&nbsp;&nbsp;
				<select name="mhour" id="dhour">
				<%	for(int hr=1; hr<=24; hr++){
												%>
 									<option value="<%= nf.format((long)hr) %>" <%= (hr==((isUpdate && scheduletype!=MailScheduleBean.MONTHLY)?10:hours))?"selected=\"selected\"":"" %> ><%= nf.format((long)hr) %></option>
				<%	}		%>
				</select>&nbsp;&nbsp;<%= TranslationHelper.getTranslatedMessge("Hour(s)") %>
				</td>
			</tr>
			<tr>
				<div id="monthlyLastDayStatus" class="datafield" style="display:<%= (isUpdate && mailScheduleBean.getScheduletype() == MailScheduleBean.MONTHLY ) && (mailScheduleBean.getDay()==29 || mailScheduleBean.getDay()==30 || mailScheduleBean.getDay()==31)?"block":"none"%>;">In case there is no above selected date in Scheduled Month, Last day(date) of Month will be considered</div>
			</tr>
			</table>
			</div>
			
			<div style="padding: 1px 0px 1px 5px; height:85px; width:350px; display:<%= scheduletype==MailScheduleBean.ONLY_ONCE?"block":"none" %>;" id="onlyonceContainer">
			<table border="0" width="350px">	
			<tr>
				<td>
				Send mail at :
				<select name="odate" id="odate" onchange="showOnlyOnceDateStatus()">
				<% for(int dt=1; dt<=31; dt++) { %>
					<option value="<%=dt%>" <%= (dt==((scheduletype==MailScheduleBean.ONLY_ONCE)?day:0))?"selected=\"selected\"":"" %>><%=dt %></option>
				<%} %>
				</select>&nbsp;Date&nbsp;&nbsp;
				<select name="ohour"  id="ohour">
				<%	for(int hr=1; hr<=24; hr++){
												%>
 									<option value="<%= hr %>" <%= (hr==((isUpdate && scheduletype!=MailScheduleBean.ONLY_ONCE)?10:hours))?"selected=\"selected\"":"" %>><%= nf.format((long)hr) %></option>
				<%	}		%>
				</select>&nbsp;&nbsp;<%= TranslationHelper.getTranslatedMessge("Hour(s)") %>
				</td>
			</tr>
			<tr>
				<td>
					Generate report for :
					<select name="oschedulefor" id="oschedulefor">
						<option value="1" <%= (scheduletype==MailScheduleBean.ONLY_ONCE && schedulefor==MailScheduleBean.PREVIOUS_DAY)?"selected=\"selected\"":"" %> >Previous Day</option>
						<option value="2" <%= (scheduletype==MailScheduleBean.ONLY_ONCE && schedulefor==MailScheduleBean.SAME_DAY)?"selected=\"selected\"":"" %> >Same Day</option>
						<option value="3" <%= (scheduletype==MailScheduleBean.ONLY_ONCE && schedulefor==MailScheduleBean.LAST_WEEK)?"selected=\"selected\"":"" %> >Last Week</option>
						<option value="4" <%= (scheduletype==MailScheduleBean.ONLY_ONCE && schedulefor==MailScheduleBean.LAST_MONTH)?"selected=\"selected\"":"" %> >Last Month</option>
					</select>
				</td>
			</tr>
			<tr>
				<div id="onlyOnceLastDayStatus" class="datafield" style="display:<%= (isUpdate && mailScheduleBean.getScheduletype() == MailScheduleBean.ONLY_ONCE) && (mailScheduleBean.getDay()==29 || mailScheduleBean.getDay()==30 || mailScheduleBean.getDay()==31)?"block":"none"%>;">In case there is no above selected date in Scheduled Month, Last day(date) of Month will be considered</div>
			</tr>
			</table>
			</div>
		</td>
	</tr>
	</table>
	</div>
	</div>
	<table align="center">
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="criButton" name="confirm" value=<%= TranslationHelper.getTranslatedMessge(isUpdate==true ?"Update":"Add") %> />
			<input type="button" class="criButton" value="<%= TranslationHelper.getTranslatedMessge("Cancel") %>" onclick="handleThickBox('2','newshhedular')" />
		</td>
	</tr>
	</table>
</form>	
</div>

</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.error("ERROR in new proactive report :" + e,e);
}

%>











