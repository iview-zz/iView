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
<%@ page import="java.util.*" %>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.beans.*"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%
	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		//int curLanguageId = Integer.parseInt(iViewConfigBean.getValueByKey(iViewConfigBean.LANGUAGE));
		String serverHost = "";
		String serverPort = "";
		String fromEmail = "";
		int curSMTPAuthID = 0;
		String dispName = "";
		String username = "";
		
		String testConfig = (String)session.getAttribute("testConfig");
		if(testConfig==null || "".equalsIgnoreCase(testConfig) || "null".equalsIgnoreCase(testConfig)){
	serverHost = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERHOST);
	serverPort = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERPORT);
	fromEmail = iViewConfigBean.getValueByKey(iViewConfigBean.MAIL_ADMIN_ID);
	curSMTPAuthID = Integer.parseInt(iViewConfigBean.getValueByKey(iViewConfigBean.AUTHENTICATIONFLAG));
	dispName = iViewConfigBean.getValueByKey(iViewConfigBean.MAIL_ADMIN_NAME);
	username = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERUSERNAME);
		} else {
	String[] testConfigData = testConfig.split(",");
	serverHost = testConfigData[0];
	serverPort = testConfigData[1];
	fromEmail = testConfigData[2];
	curSMTPAuthID = Integer.parseInt(testConfigData[3]);
	dispName = testConfigData[4];
	if(curSMTPAuthID == 1)
		username = testConfigData[5];
	session.removeAttribute("testConfig");
		}
		if(dispName == null || "".equalsIgnoreCase(dispName) || "null".equalsIgnoreCase(dispName)){
	dispName = "";
		}
		if(username == null || "".equalsIgnoreCase(username) || "null".equalsIgnoreCase(username)){
	username = "";
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
		if(iMode == ApplicationModes.UPDATE_CONFIGURATION && iStatus > 0){
	pmessage = TranslationHelper.getTranslatedMessge("Configuration updated successfully.");
		} else if(iMode == ApplicationModes.UPDATE_CONFIGURATION && iStatus <= 0){
	nmessage = TranslationHelper.getTranslatedMessge("Error in Configuration updation.");
		} else if(iMode == ApplicationModes.SEND_TEST_MAIL && iStatus >= 0){
	pmessage = TranslationHelper.getTranslatedMessge("Test mail sent successfully.");
		} else if(iMode == ApplicationModes.SEND_TEST_MAIL && iStatus < 0){
	nmessage = TranslationHelper.getTranslatedMessge("Error sending test mail.");
		}
%>

<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%><html>
<head>
<TITLE><%=iViewConfigBean.TITLE%></TITLE>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/ipvalidation.js"></script>
<script type="text/javascript">
	window.onload = function (evt) {
		setWidth();
		setAuth(document.manageconfig.smtpAuth);
		setWinSize('testip');
	}		
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);
	}
	function setAuth(smtpAuth){
		if(smtpAuth.checked){
			document.manageconfig.username.disabled = '';
			document.manageconfig.password.disabled = '';
		} else {
			document.manageconfig.username.disabled = 'disabled';
			document.manageconfig.password.disabled = 'disabled';
		}
	}
	function submitForm(isTestMail){
		re = /\w{1,}/;
		var reExp = /^[a-zA-Z0-9][a-zA-Z0-9_.@]*$/;
		emailExp = /^\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)+$/ ;
		form = document.manageconfig;
		form.appmode.value = '<%=ApplicationModes.UPDATE_CONFIGURATION%>';
		if(!isValidIP(form.serverip.value)){
			if(isTestMail)
				handleThickBox('2','testip');
			alert('<%=TranslationHelper.getTranslatedMessge("Please Enter valid IP Address.")%>');
			return false;
		}
		if(!isValidPort(form.serverport.value)){
			if(isTestMail)
				handleThickBox('2','testip');
			alert('<%=TranslationHelper.getTranslatedMessge("Please Enter valid Server Port.")%>');
			return false;
		}
		if(form.fromemail.value == ''){
			if(isTestMail)
				handleThickBox('2','testip');
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter email address")%>');
			form.fromemail.focus();
			return false;
		}
		if(!(emailExp.test(form.fromemail.value))){
			if(isTestMail)
				handleThickBox('2','testip');
			alert('<%=TranslationHelper.getTranslatedMessge("Invalid Email Address")%>');
			form.fromemail.focus();
			return false;
		}
		if(form.smtpAuth.checked){
			if (!(re.test(form.username.value))){
				if(isTestMail)
					handleThickBox('2','testip');
				alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Username")%>');
				form.username.focus();
				return false;
			}else if (!(reExp.test(form.username.value))){
				if(isTestMail)
					handleThickBox('2','testip');
				alert("<%=TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@' and '.' allowed in username")%>");
				form.username.focus();
				return false;
			}
			if (form.password.value == ''){
				if(isTestMail)
					handleThickBox('2','testip');
				alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Password")%>');
				form.password.focus();
				return false;
			}
		}
		if(isTestMail){
			return true;
		} else {
			var con = confirm('<%=TranslationHelper.getTranslatedMessge("Are you sure you want to update configuration?")%>');
			return con;
		}
	}
	function sendTestMail(){
		if(form.testEmail.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter email address for test")%>');
			form.testEmail.focus();
			return false;
		}
		if(!(emailExp.test(form.testEmail.value))){
			alert('<%=TranslationHelper.getTranslatedMessge("Invalid Email Address for test")%>');
			form.testEmail.focus();
			return false;
		}
		document.manageconfig.appmode.value = '<%=ApplicationModes.SEND_TEST_MAIL%>';
		document.manageconfig.submit();
	}
	function handleThickBox(op,container){
		var thickBox = document.getElementById('TB_overlay');
		var containerBox = document.getElementById(container);
		if(op == 1 && submitForm(true)){
			thickBox.style.display = '';
			containerBox.style.display = 'block';
		}else{
			thickBox.style.display = 'none';
			containerBox.style.display = 'none';
		}
	}
	function setWinSize(container){
		if( typeof( window.innerWidth ) == 'number' ) {		//Non-IE
		   	winWidth = window.innerWidth;
		   	winHeight = window.innerHeight;
		} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
		   	winWidth = document.documentElement.clientWidth;
		   	winHeight = document.documentElement.clientHeight;
		} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
		   	//IE 4 compatible
		   	winWidth = document.body.clientWidth;
		   	winHeight = document.body.clientHeight;
		}
		document.getElementById(container).style.left = (winWidth - 450)/2;
  		document.getElementById(container).style.top = '50px';
  	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>

    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>

    <div class="maincontent" id="main_content">
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Mail server configuration")%></div>
		</div>
		<br><br>
	<form action="<%=request.getContextPath()%>/iview" method="post" name="manageconfig" onsubmit="return submitForm(false)">  
	<input type="hidden" name="appmode" value="<%=ApplicationModes.UPDATE_CONFIGURATION%>" >
	<table border="0" width="100%" cellpadding="2" cellspacing="2">
<%
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
		<td class="nagemessage" colspan="4">&nbsp;&nbsp;<%=nmessage%></td>
	</tr>
<%
	}
%>
	<td >
			<table border="0" cellpadding="2" cellspacing="2">
			<tr >
				<td class="textlabels" >&nbsp;
					<%=TranslationHelper.getTranslatedMessge("Mail Server IP")%>&nbsp;-&nbsp;<%=TranslationHelper.getTranslatedMessge("Port")%><font class="compfield">*</font>
				</td>
				<td >
					<input type="text" class="datafield" name="serverip" value="<%=serverHost%>" style="width:180px"/>&nbsp;-&nbsp;<input type="text" class="datafield" size="5" name="serverport" value="<%=serverPort%>" />
				</td>
			</tr>
			<tr>
				<td class="textlabels" width="50%">&nbsp;
					<%=TranslationHelper.getTranslatedMessge("Display Name")%>
				</td>
				<td ><input type="text" class="datafield" name="dispname" value="<%=dispName%>" style="width:180px" /></td>
			</tr>
			<tr >
				<td class="textlabels" width="50%">&nbsp;
					<%=TranslationHelper.getTranslatedMessge("From Email Address")%><font class="compfield">*</font>
				</td>
				<td><input type="text" class="datafield" name="fromemail" value="<%=fromEmail%>" style="width:180px" /></td>
			</tr>
			<tr>
				<td class="textlabels" width="50%">&nbsp;
					<%=TranslationHelper.getTranslatedMessge("SMTP Authentication")%>
				</td>
				<td align="left"><input type="checkbox" class="datafield" name="smtpAuth" value="<%=curSMTPAuthID%>" <%=curSMTPAuthID==1?"checked=\"checked\"":""%>  onclick="setAuth(this)" /></td>
			</tr>
			<tr>
				<td class="textlabels" width="50%">&nbsp;
					<%=TranslationHelper.getTranslatedMessge("Username")%><font class="compfield">*</font>
				</td>
				<td><input type="text" class="datafield" name="username" value="<%=username%>" style="width:180px"/></td>
			</tr>
			<tr>
				<td class="textlabels" width="50%">&nbsp;
					<%=TranslationHelper.getTranslatedMessge("Password")%><font class="compfield">*</font>
				</td>
				<td ><input type="password" class="datafield" name="password" value=""  title="For security reasons old password can not be displayed." style="width:180px"/></td>
			</tr>
			<tr>
				<td></td>
				<td align="left">
					<input class="criButton" type="submit" value="<%=TranslationHelper.getTranslatedMessge("Save")%>" />
					<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Send Test Mail")%>" onclick="handleThickBox('1','testip')" />
				</td>
			</tr>
			</table>
		</td>
	</table>
	</div>
	<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
	<div class="TB_window" id="testip" style="width: 350px;">
	<div>
		<table width="100%" cellspacing="0" cellpadding="2" border="0">	
		<tr class="innerpageheader">
			<td width="3%"> </td>
			<td class="contHead">Send Test Mail to</td>
			<td align="right" style="padding-right: 5px; padding-top: 2px;" colspan="3">
				<img height="15" width="15" style="cursor: pointer;" onclick="handleThickBox('2','testip')" src="../images/close.jpg"/>
			</td>
		</tr>
		</table>
		<div align="center" style="margin: 5px;">
			<div style="border: 1px solid rgb(153, 153, 153); width: 95%;">
				<table width="100%" cellspacing="2" cellpadding="2" border="0" style="background: rgb(255, 255, 255) none repeat scroll 0% 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;">
				<tr>
					<td style="width: 100px;" class="textlabels">To Address<font class="compfield">*</font></td>
					<td><input type="text" size="25" class="datafield" name="testEmail"/></td>
				</tr>
				</table>
			</div>
		</div>
		<table align="center">
		<tr>
			<td align="center" colspan="2">
				<input type="button" value="Send" name="confirm" class="criButton" onclick="sendTestMail()" />
				<input type="button" onclick="handleThickBox('2','testip')" value="Cancel" class="criButton"/>
			</td>
		</tr>
		</table>
	</div>
	</div>
	</form>
	<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in iviewconfig.jsp : "+e,e);
}
%>
