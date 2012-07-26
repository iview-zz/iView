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

<%@page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@page import="org.cyberoam.iview.authentication.beans.*"%>
<%@page import="org.cyberoam.iview.utility.DateDifference"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
try {	
	int categoryid = Integer.parseInt(session.getAttribute("categoryid").toString());
	
	DeviceBean deviceBean = null;
	UserBean userBean=UserBean.getRecordbyPrimarykey((String)session.getAttribute("username"));
	int userId = userBean.getUserId();
	
	String isDeviceSel = request.getParameter("device");	
	boolean isDeviceSelection = false;
	
	if(isDeviceSel!=null && "true".equalsIgnoreCase(isDeviceSel)) {
		isDeviceSelection = true;
	}
	
	boolean isShowtime=false;
	String strshowtime=request.getParameter("showtime");
	if ( strshowtime!= null && !"".equals(strshowtime)){
		isShowtime=Boolean.parseBoolean(strshowtime);
		CyberoamLogger.appLog.debug("check the show time value date.jsp :" + request.getParameter("showtime")+"bval"+isShowtime);
	}	
	
	
	
	/**
	*If category wise devices are there then and then only show "Select device" menu. 
	*/		
	CyberoamLogger.appLog.info("DATE.JSP::userid ="+userId+"categoryid=="+categoryid);
	String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForUserCategory(userId,categoryid);
	String strDeviceGroupList[] = UserCategoryDeviceRelBean.getDeviceGroupIdListForUserCategory(userId,categoryid);
	if(deviceIds!= null && deviceIds.length > 0 || strDeviceGroupList!= null && strDeviceGroupList.length > 0)
		isDeviceSelection = true;
	else
		isDeviceSelection = false;
		
	String startDate = request.getParameter("startdate");
	String endDate = request.getParameter("enddate");
	
	if(startDate != null){
		CyberoamLogger.appLog.debug("Setting Start Date :" + startDate);
		session.setAttribute("startdate",startDate);
	}
	if(endDate != null){
		CyberoamLogger.appLog.debug("Setting End Date :" + endDate);
		session.setAttribute("enddate",endDate);
	}
	
	Date dateTemp=null;
	String []startDateTemp=new String[2];
	if(session.getAttribute("startdate") != null){
		dateTemp=DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd HH:mm:ss");
		if(isShowtime){
			startDate=DateDifference.dateToString(dateTemp);
		}else{			
			startDateTemp=(DateDifference.dateToString(dateTemp)).split(" ");
			startDate=startDateTemp[0];	  
		}
	}
	dateTemp=null;
	String []endDateTemp=new String[2];
	if(session.getAttribute("enddate") != null){
		dateTemp=DateDifference.stringToDate((String)session.getAttribute("enddate"),"yyyy-MM-dd HH:mm:ss");
		if(isShowtime){
			    endDate=DateDifference.dateToString(dateTemp);
			}else{
				endDateTemp=(DateDifference.dateToString(dateTemp)).split(" ");
				endDate=endDateTemp[0];		    
			 }
	}
	
	
	String limit=request.getParameter("limit");
	if(limit != null){
		session.setAttribute("limit",limit);
	}else if(session.getAttribute("limit") != null){
		limit =(String)session.getAttribute("limit");
	}else {
		limit = Integer.toString(TabularReportConstants.DEFAULT_LIMIT);
		session.setAttribute("limit",limit);
	}	
	
	DeviceBean.setDeviceListForUser(request);
	String strDeviceList = "";
	String selectedDeviceGroup = (String)session.getAttribute("devicegrouplist");
	
%>

<%@page import="org.cyberoam.iview.device.beans.DeviceGroupRelationBean"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%><html>

<head>	
	<style type="text/css" >@import url(<%=request.getContextPath()%>/css/calendar-blue.css);</style>
	<style type="text/css" >@import url(<%=request.getContextPath()%>/css/configuration.css);</style>
	<style type="text/css">@import url(<%=request.getContextPath()%>/css/newTheme.css);</style>
	<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/popup.css">
	<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popup.js"></script>
	
<script language="JavaScript">
	
	var deviceList = null;
	var isShowtimejs=false;
	isShowtimejs=<%=isShowtime%>;
	
	
	function showHideDeviceInfo(){
		var role = document.getElementById('role');
		var selIndex = role.selectedIndex;
		if(role.options[selIndex].text == 'Admin'){
			document.getElementById('deviceinfo').style.display='none';
		}else{
			document.getElementById('deviceinfo').style.display='';
		}
	}

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
	function getRecord(id){
		if(id=="Device"){
			return data = deviceListJS;
		}
		if(id=="Device Group"){
			return data = devicdGroupListJS;
		}
	}
</script>
</head>
<body>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/calendar-en.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/calendar-setup.js"></script>
<div style="float: right;" id="calendar-container"></div>

<div style="z-index:99999;position:absolute;top:0px;left:0px;float:left" id="temp"></div>
<script type="text/javascript">
var deviceList = '';
var isAllDevice = true;

function getObj(name)
{
 if (document.getElementById)
	return document.getElementById(name);
 else if (document.all)
	return document.all[name];
 else if (document.layers){
	 if (document.layers[name])
		 return document.layers[name];
	 else
		 return document.layers.main.layers[name];
  }
}

function toggleStep(hideStep,showStep,cTO,tabHide,tabShow,page)
{

	var cookieName = "cTO_"+page;
	var hideObj=getObj(hideStep);
	var showObj= getObj(showStep);
	hideObj.style.display="none";
	showObj.style.display="block";
	var tabHideObj = getObj(tabHide);
	var tabShowObj = getObj(tabShow);

	if(eval(tabHideObj) && eval(tabShowObj))
	{
		tabHideObj.className="calTabON";
		tabShowObj.className="calTabOFF";
		createCookie(cookieName,tabHide,1);
	}
}


function correctDigit(digits)
{
 if(digits < 10)
 {
	var result = "0"+digits;
 return result;
 }
 return digits;
}


function dateChanged(calendar)
{
 if (calendar.dateClicked)
 {
 var y = calendar.date.getFullYear();
 var m = correctDigit(calendar.date.getMonth()+1);// integer, 0..11
 var d = correctDigit(calendar.date.getDate()); // integer, 1..31
 var hours = calendar.date.getHours();
 var mins = calendar.date.getMinutes();
 var secs = calendar.date.getSeconds();
 // redirect...
 var date = y+"-"+m+"-"+d+" "+hours+":"+mins+":"+secs;
 //alert("Date="+date);
 var startdate = y+"-"+m+"-"+d+" 00:00:00";
 var enddate = y+"-"+m+"-"+d+" 23:59:59";
 document.timeForm.startdate.value=startdate;
 document.timeForm.enddate.value=enddate;
 document.timeForm.DateRange.value="true";
 document.timeForm.flushCache.value="true";
 addAdditionalParameters(startdate,enddate,"true");
 }
}
//This will validate the Custom selected Time using Calendar
function passSelectedValues()
{
 var start = document.timeForm.startdate;
 var end = document.timeForm.enddate;

 if(eval("document.timeForm.startdate").value == '')
 {
 alert("Please enter the Start date");
 start.focus();
 return false;
 }
 else if(eval("document.timeForm.enddate").value == '')
 {
 alert("Please enter the End date");
 end.focus();
 return false;
 }
 else
 {
	 var time1 = document.timeForm.startdate.value;
	 var time2 = document.timeForm.enddate.value;
	 if(!isShowtimejs){
		 time1=time1+" 00:00:00";
		 time2=time2+" 23:59:59";
	 }
	 var dt1 = getDate(time1, 'Start Date');
	 if(dt1 == false)
	 {
	 start.focus();
	 return false;
	 }

	 var dt2 = getDate(time2, 'End Date');
	 if(dt2 == false)
	 {
	 end.focus();
	 return false;
	 }
	 timeDiff = dt2 - dt1;
	 if(timeDiff < 0)
	 {
	 	var temp = time1;
	 	time1 = time2;
	 	time2 = temp;
	 	
	 	if(!isShowtimejs){
			 var timearr1=new Array();
			 timearr1=time1.split(" ");
		     time1=timearr1[0]+" 00:00:00";
		     var timearr2=new Array();
		     timearr2=time2.split(" ");
		     time2=timearr2[0]+" 23:59:59";
		}
	 }
	 /* Adding check to find difference between Start Date & End Date
		should not be more than 3.5 years
	 */
	 var diff_date = dt2 - dt1;
	 var num_years = diff_date/31536000000;
	 var num_months = (diff_date % 31536000000)/2628000000;
	 var num_days = ((diff_date % 31536000000) % 2628000000)/86400000;

	 if(num_years >= 3 && num_months >= 6){
		alert("Date interval should not be more than 3.5 years");
		start.focus();
		return false;
	 }
 }
 document.timeForm.flushCache.value="true";
 document.timeForm.DateRange.value="true";
 addAdditionalParameters(time1,time2,"true");
}
function addAdditionalParameters(start,end,range,timeFrame)
{
 var queryStr = window.parent.location.href;
 var delimiter = "?";
 //this will contain the final href ... safer-side(??) assign the current href
 var finalHref = queryStr;
 var questionMarkIndex = queryStr.indexOf("?");
 if( questionMarkIndex > 0 ){
 var myQueryStr = queryStr.substring(0,questionMarkIndex+1);
 var parameters = queryStr.substring(questionMarkIndex+1,queryStr.length);
 var parameters_splitted = parameters.split("&");
 var restQueryString = new Array();
 var counter = 0;
 for(i=0; i< parameters_splitted.length; i++){
	 var temp = parameters_splitted[i];
	 var hashIndex = temp.indexOf("#");
	 temp = (hashIndex > 0)?(temp.substring(0,hashIndex)):(temp);
	 var tempSplitted = temp.split("=");
	 if((tempSplitted.length == 2)){
	 var _key = tempSplitted[0];
	 if( (_key == "startdate") || (_key == "enddate") || (_key =="DateRange") || (_key == "timeFrame") ||(_key == "flushCache")||(_key == "enddate")){ continue;}
	 else{ restQueryString[counter++] = temp; }
}
 }
 myQueryStr = myQueryStr + restQueryString.join("&");
 delimiter = "";
 var params = document.timeForm.additionalParams.value;
 var splittedParams = params.split("&");
 var toAppend = new Array();
 var marker = 0;
 for(num=0; num<splittedParams.length; num++){
	 var temp = splittedParams[num];
	 var tempSplitted = temp.split("=");
	 if( tempSplitted.length == 2 ){
	 var searchFor = tempSplitted[0]+"=";
	 if( queryStr.indexOf( searchFor ) < 0 ){ toAppend[marker++] = temp; }
	 }
 }
 if( marker >= 0 ){
 var appendStr = toAppend.join("&");
 finalHref = myQueryStr+"&"+appendStr;
 }
 }
 //simply append the time criteria and additional parameters if any ...
 var timeString = delimiter+"flushCache=true";
 if( range == "false" ){ timeString = timeString +"&DateRange=false&timeFrame="+timeFrame; }
 else{ timeString = timeString +"&DateRange=true&startdate="+start+"&enddate="+end; }
 finalHref = finalHref + timeString;
 if(document.getElementById("devicelist")){
	 isDeviceGroup="false";
 	deviceList = getCheckedIds("devicelist");
 	if(deviceList == ""){
		deviceList="-1";
	}
	
 	if(getCheckedValues("devicelist","popupratio"+"devicelist").toString().indexOf("Device Group") != -1){
		 isDeviceGroup="true";
		 finalHref = replaceQueryString(finalHref,'devicegrouplist',deviceList);
		 finalHref = clearQueryStringParam(finalHref,'deviceid');
		 finalHref = clearQueryStringParam(finalHref,'devicelist');
	}else {
		 finalHref = replaceQueryString(finalHref,'devicelist',deviceList);
		 finalHref = clearQueryStringParam(finalHref,'deviceid');
		 finalHref = clearQueryStringParam(finalHref,'devicegrouplist');
	}
	finalHref = replaceQueryString(finalHref,"isdevicegroup",isDeviceGroup);
	finalHref = finalHref.replace("&&","&");
	
 }
 window.parent.location.href = finalHref;
}
function getDate(str, FromTo)
{
 timeArray = new Array();
 startArray1 = new Array();
 startArray2 = new Array();
 date = new Date();

 var checkFormat = checkDateTimeFormat(str, FromTo);
 if(checkFormat == false)
 return false;

 timeArray = str.split(" ");
 var startStr1 = timeArray[0];
 var startStr2 = timeArray[1];
 startArray1 = startStr1.split("-");
 var yr = startArray1[0];
 var mon = startArray1[1];
 var day = startArray1[2];
 startArray2 = startStr2.split(":");
 var hr = startArray2[0];
 var min = startArray2[1];

 if(day<1 || day>31 || mon<1 || mon>12 || yr<1 || yr<1980)
 {
 alert("Please enter a valid "+FromTo+"[YYYY-MM-DD HH:MM:SS]");
 return false;
 }

 if((mon==2) && (day>29)) //checking of no. of days in february month
 {
 alert("Please enter a valid "+FromTo+"[YYYY-MM-DD HH:MM:SS]");
 return false;
 }

 if((mon==2) && (day>28) && ((yr%4)!=0)) //leap year checking
 {
 alert("Please enter a valid "+FromTo+"[YYYY-MM-DD HH:MM:SS]");
return false;
 }

 if(hr<0 || hr>23 || min<0 || min>59)
 {
 alert("Please enter a valid "+FromTo+"[YYYY-MM-DD HH:MM:SS]");
 return false;
 }

 date = new Date(yr, (mon-1), day, hr, min);
 return date;
}

function checkDateTimeFormat(timeStr, fromto)
{
 var dateTimeRe = /^(\d{4})-(\d{1,2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/;
 var start = document.timeForm.startdate;
 var end = document.timeForm.enddate;


 if(!dateTimeRe.test(timeStr))
 {
 alert("Please enter a valid "+fromto+"[YYYY-MM-DD HH:MM:SS]");
 return false;
 }else
 {
 return true;
 }

}

function setPeriod()
{
 document.timeForm.DateRange.value="false";
 document.timeForm.flushCache.value="true";
 var index = document.timeForm.timeFrame.selectedIndex;
 var timeFrame = document.timeForm.timeFrame.options[index].value;
 document.timeForm.startdate.value='';
 document.timeForm.enddate.value='';
 addAdditionalParameters('','',"false",timeFrame);
}

function createCookie(name,value,days)
{
 if (days)
 {
 var date = new Date();
 date.setTime(date.getTime()+(days*24*60*60*1000));
 var expires = "; expires="+date.toGMTString();
 }
 else var expires = "";
 document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name)
{
 var nameEQ = name + "=";
 var ca = document.cookie.split(';');
for(var i=0;i < ca.length;i++)
 {
 var c = ca[i];
 while (c.charAt(0)==' ') c = c.substring(1,c.length);
 if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
 }
 return null;
}

function eraseCookie(name)
{
 createCookie(name,"",-1);
}

function checkEnter(e)
{
 var characterCode;
 if(e && e.which){
 characterCode = e.which;
 }else{
 characterCode = e.keyCode;
 }
 if(characterCode == 13){ passSelectedValues(); }
}
function syncDate(){
	var dateTimeRe = /^(\d{4})-(\d{1,2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/;
 	var start = document.timeForm.startdate.value;
 	var end = document.timeForm.enddate.value;
 	if(!isShowtimejs){
		 start=start+" 00:00:00";
		 end=end+" 23:59:59";
	 }
 	if(!dateTimeRe.test(start))
 	{
 		alert("Please enter a valid Start Date [YYYY-MM-DD HH:MM:SS]");
 	} else {
 		var dt1 = getDate(start, 'Start Date');
 		var dt2 = getDate(end, 'end Date');
 	 	if(dt1 > dt2){
 			var pos = start.toString().indexOf(' ');
 			document.getElementById('dateField1').value = start.substring(0,pos);
 	 	}
 	}
	
}
deviceList = '';
isAllDevice = true;
function checkDeviceList(devList){
	if(isAllDevice){
		for(i=1; i<devList.length; i++){
			if(devList[i].selected){
				devList[0].selected = false;
				isAllDevice = false;
				break;
			}
		}
	}else{
		if(devList[0].selected){
			for(i=1; i<devList.length; i++){
				devList[i].selected = false;
				isAllDevice = true;
			}
		}
	}
}
function createDeviceList(devList){
	deviceList = '';
	if(!isAllDevice){
		for(i=0; i<devList.length; i++){
			if(devList[i].selected){
				deviceList += (devList[i].value + ',');
			}
		}
		deviceList = deviceList.substring(0,deviceList.lastIndexOf(','));
	}else{
		deviceList = '-1';
	}
}
function replaceQueryString(url,param,value) {
	var re = new RegExp("([?|&])" + param + "=.*?(&|$)","i");
	if (url.match(re)) {
		return url.replace(re,'$1' + param + "=" + value + '$2');
	} else {
		return url + '&' + param + "=" + value;
	}
}
function clearQueryStringParam(url,param) {
	var re = new RegExp("([?|&])" + param + "=.*?(&|$)","i");
	if (url.match(re)) {
		return url.replace(re,'$1' + '$2');
	}else {
		return url;
	}
}

</script>
<div id="contentheader" class="contentheader" style="z-index:2;">
	<div class = "left"> </div>
    <form name="timeForm" method="post" style="margin: 0px;">
    	<input name="additionalParams" value="flushCache=true" type="hidden">
<% if(isDeviceSelection){ %>
		<div id="devicelist1" style="float:left;">	
			<div title="<%= (String)session.getAttribute("appliancelist") %>" class="grouptext" id="devicelist" style="background: url('../images/select_device_button.jpg');height:42px;*height:40px;float:left;margin-right:2px;margin-top:4px"></div>
		</div>
<% } %>

<%
	String deviceList2="";
	String deviceGroupList="";
	
	if(isDeviceSelection){
		
		strDeviceList = (String)session.getAttribute("devicelist");
	
		
		String strDeviceList2[] = UserCategoryDeviceRelBean.getDeviceIdListForUserCategory(userId,categoryid);
		if(strDeviceList2 != null && strDeviceList2.length > 0){
			for(int i = 0;i < strDeviceList2.length ;i++){						
				deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList2[i]));
				deviceList2 += "\""+deviceBean.getName()+"|"+deviceBean.getDeviceId()+"\",";				
			}
		}
	
		DeviceGroupBean deviceGroupBean = null;
		strDeviceGroupList = UserCategoryDeviceRelBean.getDeviceGroupIdListForUserCategory(userId,categoryid);
		if(strDeviceGroupList != null && strDeviceGroupList.length > 0){
			for(int i = 0;i < strDeviceGroupList.length ;i++){						
				deviceGroupBean = DeviceGroupBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceGroupList[i]));						
				deviceGroupList += "\""+deviceGroupBean.getName()+"|"+deviceGroupBean.getGroupID()+"\",";				
				}
		}	
		
		if(!"".equals(deviceList2))
			deviceList2 = "[" + deviceList2.substring(0,deviceList2.length()-1) + "]";
		else
			deviceList2 = "[" + deviceList2 + "]";		
		
		if(!"".equals(deviceGroupList))
			deviceGroupList = "[" + deviceGroupList.substring(0,deviceGroupList.length()-1) + "]";
		else 
			deviceGroupList = "[" + deviceGroupList + "]";		
	}else{
		deviceList2 ="[]";
		deviceGroupList = "[]";		
	}
	
%>
	
<script language="JavaScript">	
	deviceListJS = <%=deviceList2%>;
	devicdGroupListJS = <%=deviceGroupList%>;
</script>

	<div id="timeDiv">
		<div style="float:left;background:url('../images/date_border_left.jpg') no-repeat;width:3px;height:42px;*height:40px;"></div>
		<div style="float:right;background:url('../images/date_border_right.jpg');width:3px;height:42px;*height:40px;"></div>
	    <table border="0" cellpadding="0" cellspacing="0" width="190px" style="margin:3px">
	  	<tbody style="border:none">
		<tr align="right" valign="middle">
			<td class="bodyTextTitle" nowrap="nowrap"><%=TranslationHelper.getTranslatedMessge("Start Date")%> </td>
			<td class="bodyText" align="left" height="16px" width="120px" nowrap="nowrap"> 
		  		<input name="startdate" id="dateField" class="txtbox" value='<%=startDate%>' onKeyPress="checkEnter(event)" type="text" onchange="syncDate();">
	            <a href="javascript:;">
	            	<img src="../images/calendar.png" id="startTrigger" align="absmiddle" border="0" width=16px height=16px>
	            </a>
				<script type="text/javascript">
				var showtimeval=false;
		           var ifformatval="%Y-%m-%d";
		           if(isShowtimejs){
		            	showtimeval=true;
		            	ifformatval="%Y-%m-%d %H:%M:%S";
		            }  
	            	var today = new Date();
	                      Calendar.setup({
	                       inputField     :    "dateField",     // id of the input field
	                       ifFormat       :    ifformatval,      // format of the input field
	                       showsTime	  :    showtimeval,	
	                       button         :    "startTrigger",  // trigger for the calendar (button ID)
	                       timeFormat     :    "24",
	                       weekNumbers    :    false,
	                       align          :    "B1",           // alignment (defaults to "Bl")
	                       singleClick    :    true,
	                       timeFormatOnToday : 1,
	                       dateStatusFunc :function (date) 
	                       { 
	                       return date.getTime() > today.getTime() && date.getDate() != today.getDate();
	                       }
	                       });
	            </script>
			</td>
		</tr>
		<tr align="right" valign="middle"> 
	     	<td class="bodyTextTitle" nowrap="nowrap"><%=TranslationHelper.getTranslatedMessge("End Date")%> </td>
	        <td class="bodyText" align="left" height="16" width=120px nowrap="nowrap">
	        	<input name="enddate" id="dateField1" class="txtbox" value='<%=endDate%>' onKeyPress="checkEnter(event)" type="text">
	            <a href="javascript:;">
	            	<img src="../images/calendar.png" id="startTrigger1" align="absmiddle" border="0" width="16px" heightL="16px">
				</a>
	            <script type="text/javascript">
	            var showtimeval=false;
	            var ifformatval="%Y-%m-%d";
	            if(isShowtimejs){
	            	showtimeval=true;
	            	ifformatval="%Y-%m-%d %H:%M:%S";
	             } 
					 var today = new Date();
					 Calendar.setup({
					 inputField     :    "dateField1",     // id of the input field
					 ifFormat       :   ifformatval,      // format of the input field
					 showsTime	   :    showtimeval,	
					 button         :    "startTrigger1",  // trigger for the calendar (button ID)
					 timeFormat     :    "24",
					 weekNumbers     :    false,
					 align          :    "Bl",           // alignment (defaults to "Bl")
					 singleClick    :    true,
					 timeFormatOnToday : 0,
					 dateStatusFunc :function (date)
					 { 
					 return date.getTime() > today.getTime() && date.getDate() != today.getDate();
					 }
					 });
	            </script> 
			</td>           
		</tr>       
		</tbody>
		</table>      
	</div>
	<div style="float:left;">
		<input name="button" onClick="passSelectedValues();" class="gobutton" type="button">
		<input name="DateRange" type="hidden"> 
		<input name="flushCache" type="hidden">		   
	</div>      
	</form>
</div>
<script language="JavaScript">
	var cTO = readCookie("cTO_null");
	getObj("calendar-container").style.display="none";
	getObj("timeDiv").style.display="block";
	function callme(id)
	{
		 if(id=="r") {
		 toggleStep('calendar-container','timeDiv','r','r','c','null')
		 }
		 else if(id=="c"){
		 toggleStep('timeDiv','calendar-container','c','c','r','null');
		 } 
	}
	
	 var today = new Date();
	 Calendar.setup(
	 {
	 flat : "calendar-container", // ID of the parent element
	 flatCallback : dateChanged, // our callback function
	 date:'<%=startDate%>', 
	 timeFormat : "12",
	 weekNumbers : false,
	 mytab : true,
	 dateStatusFunc :function (date)
	 {
	 return date.getTime() > today.getTime() && date.getDate() != today.getDate();
	 }
	 }
	 );
	
	<%	if(isDeviceSelection){
			CyberoamLogger.appLog.info("selectedDeviceGroup:::"+selectedDeviceGroup+"strDeviceList:::"+strDeviceList);
			if(session.getAttribute("isdevicegroup") !=null && "true".equalsIgnoreCase((String)session.getAttribute("isdevicegroup"))  ) {%>
				createPopUp("devicelist",["Device|1|0","Device Group|1|0"],"Device Group",<%="[\""+selectedDeviceGroup+"\"]"%>);
	<%	 	
			}else { 
	%>			
					createPopUp("devicelist",["Device|1|0","Device Group|1|0"],"Device",<%="[\""+strDeviceList+"\"]"%>);	
	<%				
			}	
	%>
	
	var okButton = document.getElementById("btn1devicelist");
	if(document.all){
		okButton.onclick = function () { passSelectedValues(); };
	} else {
		okButton.setAttribute("onclick","passSelectedValues();");
	}
		
		myDashbordPopup("devicelist","45");
	<%	}else {
			deviceList2 = "[]";
			deviceGroupList = "[]";
		}
		%>
	
	</script>

</body>
</html>
<%
	}catch(Exception e){
	CyberoamLogger.appLog.error("date.jsp:"+e,e);
}
%>   
