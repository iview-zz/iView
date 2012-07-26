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
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.beans.CategoryBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean"%>
<%@page import="java.util.ArrayList"%>
<%
	if(CheckSession.checkSession(request,response) < 0) return;

	try{		
		String[] weekdays = {"","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
		String msg = "", msgType = "posimessage";
		String strAppMode = request.getParameter("appmode");
		String strStatus = request.getParameter("status");
		int iAppmode=-1 ,iStatus=-1;
				
		if(strAppMode != null && !strAppMode.equalsIgnoreCase("")){
			iAppmode = Integer.parseInt(strAppMode);
		}
		if(strStatus != null && !strAppMode.equalsIgnoreCase("")){
			iStatus = Integer.parseInt(strStatus);
		}
		if(iAppmode>-1){
			if(iAppmode == ApplicationModes.ADD_MAIL_SCHEDULER && iStatus > 0){
				msg = TranslationHelper.getTranslatedMessge("Report Notification Added Successfully.");
			}else if(iAppmode == ApplicationModes.ADD_MAIL_SCHEDULER && iStatus <= 0){
				msg = TranslationHelper.getTranslatedMessge("Error in Report Notification Adding.");
				msgType = "nagimessage";
			}else if(iAppmode == ApplicationModes.UPDATE_MAIL_SCHEDULER && iStatus > 0){
				msg = TranslationHelper.getTranslatedMessge("Report Notification Updated Successfully.");
				msgType = "posimessage";
			}else if(iAppmode == ApplicationModes.UPDATE_MAIL_SCHEDULER && iStatus <= 0){
				msg = TranslationHelper.getTranslatedMessge("Error in Report Notification Updating Adding.");
				msgType = "nagimessage";
			}else if(iAppmode == ApplicationModes.DELETE_MAIL_SCHEDULER && iStatus > 0){
				msg = iStatus +" "+TranslationHelper.getTranslatedMessge("Report Notification(s) Deleted Successfully.");
				msgType = "posimessage";
			}else if(iAppmode == ApplicationModes.DELETE_MAIL_SCHEDULER && iStatus <= 0){
				msg = TranslationHelper.getTranslatedMessge("Error in Report Notification Deleting.");
				msgType = "nagimessage";
			}
		}
		
		
%>

<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.beans.MailScheduleBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.beans.ReportGroupBean"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean"%>
<%@page import="org.cyberoam.iview.beans.CategoryReportGroupRelationBean"%>
<%@page import="org.cyberoam.iview.beans.BookmarkGroupBean"%>
<%@page import="org.cyberoam.iview.beans.BookmarkBean"%><html>
<head>
<TITLE><%=iViewConfigBean.TITLE%></TITLE>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popupform.js"></script>
<script language="JavaScript"> 
	re = /\w{1,}/;
	userNameCheck= /^\w+(\w+)*(\.\w+(\w+)*)*$/ ;
	window.onload = function (evt) {
		setWidth();	
		getWinSize();					
	}	

	var URL = "";
	var deviceArr;
	
	var dHourObj = null;
	var dScheduleForObj = null;
	var dFromHourObj = null;
	var dToHourObj = null;
	var objDateOfMonth = null;
	var wHourObj = document.getElementById("whour");
	
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}
	function dailyHourSelect() {
		dScheduleForObj = document.getElementById("dschedulefor");
		if(dScheduleForObj.options[dScheduleForObj.selectedIndex].value==2) {
			setDailyToFromHoursSelectBox();
		}
	}
	function dailyFromHourSelect() {
		dHourObj = document.getElementById("dhour");
		dScheduleForObj = document.getElementById("dschedulefor");
		dToHourObj = document.getElementById("dtohour");
		dFromHourObj = document.getElementById("dfromhour");
		dToHourObj.length=0;
		if(dScheduleForObj.options[dScheduleForObj.selectedIndex].value==2) {
			var i=0;
			for(i=parseInt(dFromHourObj.options[dFromHourObj.selectedIndex].value) + 1;i<=dHourObj.options[dHourObj.selectedIndex].value;i++){
				var optn = document.createElement("OPTION");
				optn.text = pad2(i);
				optn.value = i;
				dToHourObj.options.add(optn);
			}
			dToHourObj.selectedIndex = dToHourObj.options.length-1;
		}else{	
			var selOption=0;
			for(i=parseInt(dFromHourObj.options[dFromHourObj.selectedIndex].value) + 1;i<=24;i++){
				var optn = document.createElement("OPTION");
				optn.text = pad2(i);
				optn.value = i;
				dToHourObj.options.add(optn);
				selOption=i;
			}
			dToHourObj.selectedIndex = dToHourObj.options.length-1;
		}
	}
	function pad2(number) {	   
	     return (number < 10 ? '0' : '') + number;
	}	
	function dailyScheduleForSelect(){
		
		setDailyToFromHoursSelectBox();
	}
	function setDailyToFromHoursSelectBox(){
		
		dHourObj = document.getElementById("dhour");
		dScheduleForObj = document.getElementById("dschedulefor");
		dToHourObj = document.getElementById("dtohour");
		dFromHourObj = document.getElementById("dfromhour");
		
		if(dScheduleForObj.options[dScheduleForObj.selectedIndex].value==2) {
			dToHourObj.length=0;
			for(var i=1;i<=dHourObj.options[dHourObj.selectedIndex].value;i++){
				var optn = document.createElement("OPTION");
				optn.text = pad2(i);
				optn.value = i;
				dToHourObj.options.add(optn);
			}
			dToHourObj.selectedIndex = dToHourObj.options.length-1;
			dFromHourObj.length=0;
			for(var i=0;i<dHourObj.options[dHourObj.selectedIndex].value;i++){
				var optn = document.createElement("OPTION");
				optn.text = pad2(i);
				optn.value = i;
				dFromHourObj.options.add(optn);
			}
		}else{
			dFromHourObj.length=0;
			for(var i=0;i<=23;i++){
				var optn = document.createElement("OPTION");
				optn.text = pad2(i);
				optn.value = i;
				dFromHourObj.options.add(optn);
			}
			dToHourObj.length=0;
			for(var i=1;i<=24;i++){
				var optn = document.createElement("OPTION");
				optn.text = pad2(i);
				optn.value = i;
				dToHourObj.options.add(optn);
			}
			dToHourObj.selectedIndex = dToHourObj.options.length-1;			
		}
	}
	function selectall(){ 
		var form = document.manageform;
		var eles = form.getElementsByTagName("input");
		var len = eles.length;
		for(var i=0; i<len;i++){  
			if(eles[i].name == "select"){
				if (form.check1.checked )	
					eles[i].checked=true ; 
				else
					eles[i].checked=false ;
			}
		} 
	}
	function showMonthlyDateStatus(){
		objDateOfMonth = document.getElementById("mdate");
		var dateOfMonth = objDateOfMonth.options[objDateOfMonth.selectedIndex].value; 
		
		if(dateOfMonth==29 || dateOfMonth==30 || dateOfMonth==31 ){
			document.getElementById("monthlyLastDayStatus").style.display = "block";
		}else{
			document.getElementById("monthlyLastDayStatus").style.display = "none";
		}
	}
	function showOnlyOnceDateStatus(){
		objDateOfMonth = document.getElementById("odate");
		var dateOfMonth = objDateOfMonth.options[objDateOfMonth.selectedIndex].value; 
		
		if(dateOfMonth==29 || dateOfMonth==30 || dateOfMonth==31 ){
			document.getElementById("onlyOnceLastDayStatus").style.display = "block";
		}else{
			document.getElementById("onlyOnceLastDayStatus").style.display = "none";
		}
	}
	function changeStatus(){
		var form = document.manageform;
		var eles = form.getElementsByTagName("input");
		var len = eles.length;
		status = true;
		for(var i=0; i<len;i++){  
			if(eles[i].name == "select"){
				if (!eles[i].checked ) {
					form.check1.checked = false;
					status = false;	
					break;	
				}
			}
		} 
		if(status){
			form.check1.checked = true;
		}
	}
	function validateDelete(){
		var elements = document.getElementsByName("select");
		var len = elements.length;
		flag = false ;
		for( i=0;i<len ; i++ ){
			if(elements[i].name == "select"){
				if( elements[i].checked == true ){
					flag = true ;
					break;
				}
			}
		}
		if(!flag){
			alert("<%=TranslationHelper.getTranslatedMessge("You must select atleast one notification")%>");
			return false;
		}
		var con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected Report Notification(s)?")%>");
		if (! con ){ 
			return false ;
		}
		document.manageform.submit();
	}

	function openAddScheduler(id){		
		
		if(id == ''){
			URL = '<%=request.getContextPath()%>/webpages/newmailscheduler.jsp';			
		}else {
			URL = '<%=request.getContextPath()%>/webpages/newmailscheduler.jsp?schedulerid='+id;
		}
		handleThickBox(1,'newshhedular',"535","10");
		
	}
	function setFrequency(){
		document.getElementById("dailyContainer").style.display = "none";
		document.getElementById("weeklyContainer").style.display = "none";
		document.getElementById("monthlyContainer").style.display = "none";
		document.getElementById("onlyonceContainer").style.display = "none";
		
		if(document.getElementById("daily").checked) {
			document.getElementById("dailyContainer").style.display = "block";
		}else if(document.getElementById("weekly").checked) {
			document.getElementById("weeklyContainer").style.display = "block";
		}else if(document.getElementById("monthly").checked) {	
			document.getElementById("monthlyContainer").style.display = "block";
		}else{
			document.getElementById("onlyonceContainer").style.display = "block";
		}
	}
	function decideCombo(){
		var choice = document.getElementsByName('rdchoice');
		var rpgp = document.getElementById("reportgroup");
		var bookmark=document.getElementById("bookmarks");
		if(choice[0].checked){
			bookmark.disabled=true;
			rpgp.disabled=false;
		}
		else{
			if(bookmark.length>0){
				bookmark.disabled=false;
			}
			rpgp.disabled=true;
		}
	} 
	
	function validateForm(mode){
		nameReExp = new RegExp("^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$");
		//emailExp = /^(\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)+,)*(\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)),{0,1}$/ ;
		emailExp = /^([\w-\.]+@[\w-\.]+[\w],)*([\w-\.]+@[\w-\.]+[\w])$/;
		form=document.addnewform;
		if (form.schedulername.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Report Name")%>');
			form.schedulername.focus();
			return false;
		}else if (!nameReExp.test(form.schedulername.value)){
			alert("<%=TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Report Name")%>");
			form.schedulername.focus();
			return false;
		}
		if(form.toaddress.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter email address")%>');
			form.toaddress.focus();
			return false;
		}
		if(!(emailExp.test(form.toaddress.value))){
			alert('<%=TranslationHelper.getTranslatedMessge("Invalid Email Address")%>');
			form.toaddress.focus();
			return false;
		}
		if (form.reportgroup.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must select report group.")%>');
			form.reportgroup.value.focus();
			return false;
		}
		if(form.selecteddevices.length == 0){
				alert('<%=TranslationHelper.getTranslatedMessge("You must select atleast one device")%>');
				return false;
		}
		for(i=0;i<form.selecteddevices.length;i++){
			form.selecteddevices.options[i].selected=true;
		}
		if(mode == <%=ApplicationModes.ADD_MAIL_SCHEDULER%>)
			con = confirm("Are you sure you want to add the Report Notification?");
		else 
			con = confirm("Are you sure you want to update the Report Notification?");
		return con;
	}//function validate form ends here

	function selectDevices(direction){
		var src;
		var dst;
		if(direction == 'right'){
			src = document.getElementById('availabledevices');
			dst = document.getElementById('selecteddevices');
		}else{
			dst = document.getElementById('availabledevices');
			src = document.getElementById('selecteddevices');
		}
		
		for(i=src.length-1;i>=0;i--) {
			if(src[i].selected==true) {
				ln=dst.length;
				dst.options[ln]=new Option(src.options[i].text,src.options[i].value,false,false);
				src.options[i]=null;
			}
		}	
	}
	function getDevicesByCategoty()
	{	
		var id = document.getElementById("mailCategory").value;
		var availableDeviceEle = document.getElementById("availabledevices");
		var selectedDevicesEle = document.getElementById("selecteddevices");
		var reportGroupEle = document.getElementById("reportgroup");
		var bookmarkEle = document.getElementById("bookmarks");
		var choice = document.getElementsByName('rdchoice');
		var ctr=0;

		availableDeviceEle.options.length = 0;		
		selectedDevicesEle.options.length = 0;
		reportGroupEle.options.length = 0;
		bookmarkEle.options.length=0;

	<%
		ReportGroupBean reportGroupBean = null;
		ArrayList reportGrpIds;
		Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
		CategoryBean categoryBean= null;
		if(categoryBeanItr!=null){
			while(categoryBeanItr.hasNext()){	  		
				categoryBean = (CategoryBean)categoryBeanItr.next();
		%>
				if(id == <%=categoryBean.getCategoryId()%>){
					
					ctr=0;	
		<%				
					DeviceBean deviceBean=null;
					String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryBean.getCategoryId());					
					if(deviceIds!= null && deviceIds.length > 0){
						for(int i=0;i<deviceIds.length;i++){
							deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));				
		%>													
							availableDeviceEle.options[ctr++]=new Option('<%= deviceBean.getName()%>',<%=deviceBean.getDeviceId()%>);
									        	      							
		<%				} 
					}
		%>
					ctr=0;		
					
		<%
					reportGrpIds=CategoryReportGroupRelationBean.getReportgroupListByCategory(categoryBean.getCategoryId());
					for(int i=0;i<reportGrpIds.size();i++){
						reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(Integer.parseInt(reportGrpIds.get(i).toString()));
						if(reportGroupBean.getGroupType() == ReportGroupBean.STATIC_GROUP || reportGroupBean.getGroupType() == ReportGroupBean.DYNAMIC_GROUP){						
		%>												
							reportGroupEle.options[ctr++]=new Option('<%= reportGroupBean.getTitle()%>',<%= reportGroupBean.getReportGroupId() %>);							
		<%				}
					}
					%>
					ctr=0;
					<%
					BookmarkBean bookmarkBean=null;
					Iterator bookmarkItr=null;
					bookmarkItr=BookmarkBean.getRecord("categoryid",categoryBean.getCategoryId()).values().iterator();
					if(!bookmarkItr.hasNext()){
						%>
						bookmarkEle.options[ctr++]=new Option('No Bookmarks Found',1);
						bookmarkEle.disabled=true;
						choice[1].disabled=true;
						choice[0].checked="checked";
						reportGroupEle.disabled=false;
						
				<%
					}	
					else{
						while(bookmarkItr.hasNext()){
							bookmarkBean=(BookmarkBean)bookmarkItr.next();
						%>
							choice[1].disabled=false;
							bookmarkEle.options[ctr++]=new Option('<%= bookmarkBean.getName()%>',<%= bookmarkBean.getBookmarkId() %>);
			<%
						}
					%>
					decideCombo();	
					<%}
		%>					
				}			
		<%
			}			
		}
		%>
	}
	
	
</script>
</head>
<body >
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>  
	<div class="maincontent" id="main_content">
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Report Notification")%></div>
		</div>
		<br><br>
	<form action="<%=request.getContextPath()%>/iview" method="post" name="manageform">
	<input type="hidden" name="appmode" value="<%=ApplicationModes.DELETE_MAIL_SCHEDULER%>">
	<input type="hidden" name="scheduleid" value="">
	<table width="100%" style="margin-bottom: 2px;">
	<tr>
		<td align="left" class="ButtonBack">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Add")%>" onClick="openAddScheduler('');">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Delete")%>" onclick ="return validateDelete()">
		</td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" >
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" width="100%" border="0" class="TableData">
<%
	if(msg != null){
%>
			<tr><td colspan=7 align="left" class="<%=msgType %>"><%=msg%></td></tr>
<%
	
	}
%>
			<tr>
				<td align="center" class="tdhead"><input type=checkbox name=check1 onClick="selectall()"></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Name")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Report Group / Bookmark")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Device Name")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Email Frequency")%></td>		
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("To Email Address")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Last Sent Time")%></td> 
			</tr>
<%
	String rowStyle = "trdark"; // trlight
	boolean oddRow = false;
	Iterator mailSchedulerItr = null;
	MailScheduleBean mailScheduleBean = null;
	mailSchedulerItr = MailScheduleBean.getIterator();
	String reportGropuTitle = "";
	String deviceNameList = "";
	String toAddress = "";
	String lastSent = "";
	boolean isScheAvailable = mailSchedulerItr.hasNext();
	while(mailSchedulerItr.hasNext()){
		mailScheduleBean = (MailScheduleBean)mailSchedulerItr.next();
		oddRow = !oddRow;
		if(oddRow) 
			rowStyle = "trdark";
		else
			rowStyle = "trlight";
		if(!mailScheduleBean.getIsBookmark()){
			reportGropuTitle = ReportGroupBean.getRecordbyPrimarykey(mailScheduleBean.getReportGroupID()).getTitle();
		}
		else{
			reportGropuTitle=((BookmarkBean)BookmarkBean.getRecord("bookmarkid",mailScheduleBean.getReportGroupID()).values().iterator().next()).getName();
		}
		deviceNameList = mailScheduleBean.getDeviceName();
		toAddress = mailScheduleBean.getToaddress();
		lastSent = "2001-01-01 00:00:00".equalsIgnoreCase(mailScheduleBean.getLastsendtime())?"Not sent":mailScheduleBean.getLastsendtime();
%>
			<tr class="<%= rowStyle %>">
				<td class="tddata" align="center" title="delete"><input type="checkbox" name="select" onClick="changeStatus()" value="<%= mailScheduleBean.getMailScheduleID() %>" ></td>
				<td class="tddata"><a title="Edit Scheduler" class="configLink" href="#" onclick="openAddScheduler('<%= mailScheduleBean.getMailScheduleID() %>')" ><%= mailScheduleBean.getScheduleName() %></a></td>
				<td class="tddata" title="<%= reportGropuTitle %>"><%= reportGropuTitle.length()>15?(reportGropuTitle.substring(0,15)+"..."):reportGropuTitle %></td>
				<td class="tddata" title="<%= deviceNameList %>" ><%= deviceNameList.length()>15?(deviceNameList.substring(0,15)+"..."):deviceNameList %></td>
				<!-- 
					<td class="tddata"><%= mailScheduleBean.getScheduletype()==1?"Daily":(mailScheduleBean.getScheduletype()==2)?"On " + weekdays[mailScheduleBean.getDay()]:"on " %>&nbsp;at&nbsp;<%= mailScheduleBean.getHours() + " hrs." %></td>
				-->
				<td class="tddata"><%= mailScheduleBean.getScheduletype()==1?"Daily at " + mailScheduleBean.getHours() + " hrs.":mailScheduleBean.getScheduletype()==2?"On " + weekdays[mailScheduleBean.getDay()] + " at " + mailScheduleBean.getHours() + " hrs.":mailScheduleBean.getScheduletype()==3?"Monthly on " + mailScheduleBean.getDay() + " at " + mailScheduleBean.getHours() + " hrs.":"Only Once on " + mailScheduleBean.getDay() + " at " + mailScheduleBean.getHours() + " hrs." %></td>
				<td class="tddata" title="<%= toAddress %>"><%= toAddress.length()>15?(toAddress.substring(0,15)+"..."):toAddress %></td>
				<td class="tddata"><%= lastSent %></td>
			</tr>
<% } 
		if(!isScheAvailable){
%>
		<tr class="<%= rowStyle %>">
			<td class="tddata" colspan="8" align="center">Report Notification(s) Not Available</td>
		</tr>
<% } %>
			</table>
		</td>
	</tr>
	</table>
	</form>
</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
<div class="TB_window" id="newshhedular"></div>
</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in mailscheduler.jsp : "+e,e);
}
%>
