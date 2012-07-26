<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes" %>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@ page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.cyberoam.iview.authentication.beans.*"%>
<%@page import="org.cyberoam.iview.utility.DateDifference"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%>

<%
	if(CheckSession.checkSession(request,response) < 0) return;

	String startDate="";
	String endDate="";
	String ftpServer=null,ftpUserName=null,ftpPassword=null,backupfreq=null,lastbackupdatetime=null,hourtime=null;
	
 try{
 	ftpServer=iViewConfigBean.getValueByKey("FTPServerIP");
 	ftpUserName=iViewConfigBean.getValueByKey("FTPUserName");
 	ftpPassword=iViewConfigBean.getValueByKey("FTPPassword");
 	backupfreq=iViewConfigBean.getValueByKey("ScheduleBackupFrequency");
 	lastbackupdatetime=iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_LAST_BACKUP);
 	hourtime=iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_BACKUP_TIME);
 	
 	if("1".equals(backupfreq)){
 		if(!("".equals(lastbackupdatetime)) && lastbackupdatetime != null){
 			lastbackupdatetime=lastbackupdatetime.substring(0,4)+"-"+lastbackupdatetime.substring(4,6)+"-"+lastbackupdatetime.substring(6,8)+" "+hourtime;
 		}
	}
 	if(ftpServer == null || "".equalsIgnoreCase(ftpServer) || "null".equalsIgnoreCase(ftpServer)){
 		ftpServer = "";
	}
	if(ftpUserName== null || "".equalsIgnoreCase(ftpUserName) || "null".equalsIgnoreCase(ftpUserName)){
		ftpUserName = "";
	}
	if(ftpPassword== null || "".equalsIgnoreCase(ftpPassword) || "null".equalsIgnoreCase(ftpPassword)){
		ftpUserName = "";
	}
		
	String appmode = request.getParameter("appmode");
	int iMode = -1;
	if(appmode != null && !"null".equalsIgnoreCase(appmode)){
		iMode = Integer.parseInt(appmode);
	}
	String strStatus = request.getParameter("status");
	int iStatus = -1;
	if(strStatus != null && !"null".equalsIgnoreCase(strStatus)){
		iStatus = Integer.parseInt(strStatus);
	}
	String pmessage = "";
	String nmessage = "";
	if(iMode == ApplicationModes.SCHEDULE_BACKUP && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Configuration updated successfully.");
	} else if(iMode == ApplicationModes.SCHEDULE_BACKUP && iStatus == -1){
		nmessage = TranslationHelper.getTranslatedMessge("FTP ServerIP Not Valid.");
	}else if(iMode == ApplicationModes.SCHEDULE_BACKUP && iStatus == -2){
		nmessage = TranslationHelper.getTranslatedMessge("Username or Password Not Valid.");
	}else if(iMode == ApplicationModes.SCHEDULE_BACKUP && iStatus == -3){
		nmessage = TranslationHelper.getTranslatedMessge("FTP Server can not reachable");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Backup Files Could Not Found");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -1){
			nmessage = TranslationHelper.getTranslatedMessge("Restoration Not Done");	
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Restoration Successfully done");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -5){
		nmessage = TranslationHelper.getTranslatedMessge(" Error At Time of File Retrieve From FTP Please Check FTP Configuration And Try Again");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -6){
		nmessage = TranslationHelper.getTranslatedMessge("Some Zip Files Are Corrupted At Time Of Retrieve From FTP Please Try Again");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -7){
		nmessage = TranslationHelper.getTranslatedMessge("Please Update FTP Configuration ");
	}
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=iViewConfigBean.TITLE%></title>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/ipvalidation.js"></script>
<script type="text/javascript" language="JavaScript" src="<%=request.getContextPath()%>/javascript/SearchData.js"></script>
<script type="text/javascript" language="JavaScript" src="<%=request.getContextPath()%>/javascript/utilities.js"></script>
<style type="text/css" >@import url(<%=request.getContextPath()%>/css/calendar-blue.css);</style>
<style type="text/css" >@import url(<%=request.getContextPath()%>/css/configuration.css);</style>
<style type="text/css">@import url(<%=request.getContextPath()%>/css/newTheme.css);</style>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/popup.css">
<script language="JavaScript" src="/javascript/cyberoam.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popup.js"></script>

<script language="JavaScript" src="/javascript/cyberoam.js"></script>
<script type="text/javascript">
window.onload = function (evt) {
	setWidth();
	backupfrequency();
}
function setWidth(){
	var main_div = document.getElementById("main_content");	
	main_div.style.width = (document.body.clientWidth - 229);	
}

function handleThickBox(op,container,width,top){
	var thickBox = document.getElementById('TB_overlay');
	var containerBox = document.getElementById(container);
	if(top != undefined)
		containerBox.style.top = top;
	if(width != undefined)
		containerBox.style.width = width;
	if(op == 1){			
		thickBox.style.display = '';
		containerBox.style.display = 'block';
	}else{
		thickBox.style.display = 'none';
		containerBox.style.display = 'none';
		containerBox.innerHTML = '';
	}
}

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
 var date = y+"-"+m+"-"+d;
 //alert("Date="+date);
 var startdate = y+"-"+m+"-"+d;
 var enddate = y+"-"+m+"-"+d;
 document.timeForm.startdate.value=startdate;
 document.timeForm.enddate.value=enddate;
 document.timeForm.DateRange.value="true";
 document.timeForm.flushCache.value="true";
 
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
		 alert("StartDate Can not Be Greater Than EndDate");
		 return false;
	 }
	 
 }
	var con=confirm('<%=TranslationHelper.getTranslatedMessge("Are You Sure You Want To Restore ")%>');
	if(con == true){
		handleThickBox(1,'progressbar',"500");
		return true;
	}else{
		return false;
	}
}

function getWinSize(container) {
	if( typeof( window.innerWidth ) == 'number' ) {		//Non-IE
    	winWidth = window.innerWidth;
    	winHeight = window.innerHeight;
  	} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    	winWidth = document.documentElement.clientWidth;
    	winHeight = document.documentElement.clientHeight;
  	} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    	winWidth = document.body.clientWidth;	    
    	winHeight = document.body.clientHeight;
  	}
	if(document.getElementById(container)){			
		document.getElementById(container).style.left = (winWidth - document.getElementById(container).offsetWidth)/2;			
		if(parseInt(document.getElementById(container).style.left) > 232 || parseInt(document.getElementById(container).style.left) < 200){			
			document.getElementById(container).style.left = "232px";											
		}			
		if(document.getElementById(container).style.top == "")
	  		document.getElementById(container).style.top = (winHeight - 50)/2 - document.getElementById(container).offsetHeight;
	  	if(parseInt(document.getElementById(container).style.top) < 0){
            document.getElementById(container).style.top = 50;
	  	}
	}
	if(navigator.appName == "Microsoft Internet Explorer" ){
		document.body.scrollTop = "0";
		document.getElementById(container).style.right = parseInt(document.getElementById(container).style.left)+ document.getElementById(container).offsetWidth + "px";
	}	
}

function getDate(str, FromTo)
{
 startArray1 = new Array();
 date = new Date();

 var checkFormat = checkDateTimeFormat(str, FromTo);
 if(checkFormat == false)
 return false;

 /*timeArray = str.split(" ");
 var startStr1 = timeArray[0];
 var startStr2 = timeArray[1];*/
 startArray1 = str.split("-");
 var yr = startArray1[0];
 var mon = startArray1[1];
 var day = startArray1[2];
 
 if(day<1 || day>31 || mon<1 || mon>12 || yr<1 || yr<1980)
 {
 alert("Please enter a valid "+FromTo+"[YYYY-MM-DD]");
 return false;
 }

 if((mon==2) && (day>29)) //checking of no. of days in february month
 {
 alert("Please enter a valid "+FromTo+"[YYYY-MM-DD]");
 return false;
 }

 if((mon==2) && (day>28) && ((yr%4)!=0)) //leap year checking
 {
 alert("Please enter a valid "+FromTo+"[YYYY-MM-DD]");
return false;
 } 

 date = new Date(yr, (mon-1), day);
 return date;
}

function checkDateTimeFormat(timeStr, fromto)
{
 var dateTimeRe = /^(\d{4})-(\d{1,2})-(\d{2})$/;
 var start = document.timeForm.startdate;
 var end = document.timeForm.enddate;


 if(!dateTimeRe.test(timeStr))
 {
 alert("Please enter a valid "+fromto+"[YYYY-MM-DD]");
 return false;
 }else
 {
 return true;
 }

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
	var dateTimeRe = /^(\d{4})-(\d{1,2})-(\d{2})$/;
 	var start = document.timeForm.startdate.value;
 	var end = document.timeForm.enddate.value;
 	if(eval("document.timeForm.enddate").value == ''){
 		document.getElementById('dateField1').value = document.timeForm.startdate.value;
 	}
 	if(!dateTimeRe.test(start))
 	{
 		alert("Please enter a valid Start Date [YYYY-MM-DD]");
 	} else {
 		var dt1 = getDate(start, 'Start Date');
 		var dt2 = getDate(end, 'end Date');
 	 	if(dt1 > dt2 ){
 			document.getElementById('dateField1').value = document.timeForm.startdate.value;
 	 	}
 	 	
 	}
 }
 
function backupfrequency(){
	
	var ftpserver= document.getElementById("ftpserverip");	
	var ftppassword= document.getElementById("ftppassword");
	var ftpusername=document.getElementById("ftpusername");	
	if(document.backupform.backupfreq[0].checked){
		ftpserver.disabled='disabled';
		ftppassword.disabled='disabled';
		ftpusername.disabled='disabled';		
	}	
	if(document.backupform.backupfreq[1].checked){
		ftpserver.disabled='';
		ftppassword.disabled='';
		ftpusername.disabled='';
	}	
}

function submitForm(){
	var form=document.backupform;
	if(document.backupform.backupfreq[1].checked){
		if(form.ftpserverip.value ==''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter  FTP Server IP")%>');
			form.ftpserverip.focus();
			return false;
		}
		if(form.ftppassword.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter Password")%>');
			form.ftppassword.focus();
			return false;
		}
		if(form.ftpusername.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter username")%>');
			form.ftpusername.focus();
			return false;
		}		
	}
	if(document.backupform.backupfreq[0].checked){
		form.ftpserverip.value = '';
		form.ftppassword.value = '';
		form.ftpusername.value = '';
	}
	var con = confirm('<%=TranslationHelper.getTranslatedMessge("Are you sure you want to update configuration?")%>');
	return con;
}


</script>
</head>
<body>
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>
    
    <div class="maincontent" id="main_content">    
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Backup configuration")%></div>
		</div>
		<br><br>     
	<form action="<%=request.getContextPath()%>/iview" method="post" name="backupform" onsubmit="return submitForm();">
	<input type=hidden name=appmode value="<%=ApplicationModes.SCHEDULE_BACKUP%>">
	<table border="0" width="50%" cellpadding="2" cellspacing="2">
	<%
	if(iMode==ApplicationModes.SCHEDULE_BACKUP){
		if(!"".equals(pmessage)){
		%>
		<tr>
			<td class="posimessage" colspan="4">&nbsp;&nbsp;<%=pmessage%></td>
		</tr>
		<%
		}
	%>
	<%
	if(!"".equals(nmessage)){
	%>
	<tr>
		<td class="nagimessage" colspan="4">&nbsp;&nbsp;<%=nmessage%></td>
	</tr>
	<%
	 }
		}
	%>	
	
	<td>
	<table border="0" cellpadding="2" cellspacing="2">
			<tr>
				<td class="textlabels" >&nbsp;
				<%=TranslationHelper.getTranslatedMessge("Backup Frequency")%>
				</td>
				<td>
				  <input type="radio"  name="backupfreq" id="backupfreq" onclick="backupfrequency()" value="-1"<%="-1".equals(backupfreq)?"checked='checked'":""%>/>
				  <label><%=TranslationHelper.getTranslatedMessge("Never")%></label>
				  <input type="radio"  name="backupfreq" id="backupfreq" onclick="backupfrequency()" value="1"<%="1".equals(backupfreq)?"checked='checked'":""%> />
				  <label><%=TranslationHelper.getTranslatedMessge("Daily")%></label>&nbsp;&nbsp;
					<%
					if("1".equals(backupfreq) && !"".equals(lastbackupdatetime)){
					%>	
				     <b><label><%=TranslationHelper.getTranslatedMessge("Last Backup Taken On "+lastbackupdatetime)%></label></b>
					<% 					
					}				
					%>	
				  
				</td>
			</tr>
			<tr >
				<td class="textlabels" >&nbsp;
					<%=TranslationHelper.getTranslatedMessge("FTP Server IP")%><font class="compfield">*</font>
				</td>
				<td >
					<input type="text" class="datafield" name="ftpserverip" id="ftpserverip" value="<%=ftpServer%>" style="width:180px"/>
				</td>
			</tr>
			<tr>
				<td class="textlabels" width="50%">&nbsp;
					<%=TranslationHelper.getTranslatedMessge("User Name")%><font class="compfield">*</font>
				</td>
				<td ><input type="text" class="datafield" name="ftpusername" id="ftpusername" value="<%=ftpUserName%>" style="width:180px" /></td>
			</tr>
			<tr >
				<td class="textlabels" width="50%">&nbsp;
					<%=TranslationHelper.getTranslatedMessge("Password")%><font class="compfield">*</font>
				</td>
				<td><input type="password" class="datafield" name="ftppassword" id="ftppassword"  value="<%=ftpPassword%>" style="width:180px" /></td>
			</tr>				
		    <tr>
				<td></td>
				<td align="left">	
	   			<input class="criButton" type="submit" name="btnsubmit" value="Save"/>
	   			</td>
	   	</table>
	   	   </td>
	   </table>
	</form>
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Restore")%></div>
		</div>
		<br>
		<br>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/calendar.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/calendar-en.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/calendar-setup.js"></script>
		<form action="<%=request.getContextPath()%>/iview" name="timeForm" method="post" style="margin:0px;" onsubmit="return passSelectedValues();">
		<input type=hidden name=appmode value="<%=ApplicationModes.RESTORE_REQUEST%>">
	<div >
		<table border="0" width="50%" cellpadding="2" cellspacing="2">
	<%
	if(iMode==ApplicationModes.RESTORE_REQUEST){
		if(!"".equals(pmessage)){
		%>
		<tr>
			<td class="posimessage" colspan="4">&nbsp;&nbsp;<%=pmessage%></td>
		</tr>
		<%
		}
	%>
	<%
	if(!"".equals(nmessage)){
	%>
	<tr>
		<td class="nagimessage" colspan="4">&nbsp;&nbsp;<%=nmessage%></td>
	</tr>
	<%
	 }
		}
	%>	
	<td> 
	 <table border="0" cellpadding="2" cellspacing="2">
		  	<tbody style="border:none">
		<tr align="right" valign="middle">
			<td class="textlabels" >&nbsp; 
			<%=TranslationHelper.getTranslatedMessge("Start Date")%></td>
			<td align="left"> 
		  		<input name="startdate" id="dateField" class="datafield" value='<%=startDate%>' style="width:100px" onKeyPress="checkEnter(event)" type="text"> <!--  onchange="syncDate();">-->
	            <a href="javascript:;">
	            	<img src="../images/calendar.png" id="startTrigger" align="absmiddle" border="0" width=16px height=16px>
	            </a>
				<script type="text/javascript">
				          var today = new Date();
				          today.setDate(today.getDate()-1);
	                      Calendar.setup({
	                       inputField     :    "dateField",     // id of the input field
	                       ifFormat       :    "%Y-%m-%d",      // format of the input field
	                       showsTime	  :    false,	
	                       button         :    "startTrigger",  // trigger for the calendar (button ID)
	                       timeFormat     :    "24",
	                       weekNumbers    :    false,
	                       align          :    "B1",           // alignment (defaults to "Bl")
	                       singleClick    :    true,
	                       timeFormatOnToday : 1,
	                       dateStatusFunc :function (date) 
	                       { 
	                       return date.getTime() > today.getTime()&& date.getDate() != today.getDate();
	                       }
	                       });
	            </script>
			</td>
		</tr>
		<tr align="right" valign="middle"> 
	     	<td class="textlabels" >&nbsp; 
	     	<%=TranslationHelper.getTranslatedMessge("End Date")%></td>
	        <td  align="left">
	        	<input name="enddate" id="dateField1" class="datafield" value='<%=endDate%>' style="width:100px" onKeyPress="checkEnter(event)" type="text">
	            <a href="javascript:;">
	            	<img src="../images/calendar.png" id="startTrigger1" align="absmiddle" border="0" width="16px" heightL="16px">
				</a>
	            <script type="text/javascript">
	           		 var today = new Date();
	           		today.setDate(today.getDate()-1);
					 Calendar.setup({
					 inputField     :    "dateField1",     // id of the input field
                     ifFormat       :    "%Y-%m-%d",      // format of the input field
                     showsTime	    :    false,
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
		<tr> 
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr> 
		<tr>
				
				<td></td>
				<td>
					<input class="criButton" type="submit" name="Restorebtn" value="Restore">			
				</td>
				
		</tr>     
		</tbody>
		</table>  
		</td>    
	</table>
	</div>
	</form>	
		</div>
			
	<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
	<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
	<div id="progressbar"  class="TB_window" style="left: 250px; top: 200px;">
				<table align="center">
					<tr>
						<td align="center"><img alt="Loading"
							src="<%=request.getContextPath()%>/images/progress.gif" /></td>
					</tr>
					<tr>
						<td><b><%=TranslationHelper.getTranslatedMessge("Restoring, Please wait...")%></b></td>
					</tr>
				</table>
			</div>	
</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in ScheduleBackupRestore.jsp : "+e,e);
}
%>