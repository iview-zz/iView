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
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>

<%
	session.invalidate();
%>

<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.authentication.modes.AuthConstants"%><html>
<head>
<title>::: Welcome To iView - Please Login :::</title>
<link href="<%=request.getContextPath()%>/css/login.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<script language="JavaScript" src="/javascript/utilities.js"></script>
<script language="JavaScript">

function loginValidation() {
	
		form = document.forms[0] ;
		form.action= '<%=request.getContextPath() + "/iview"%>';
        if (form.username.value == "" ){
                alert('<%= TranslationHelper.getTranslatedMessge("You must enter the Username") %>');
				form.username.focus();
                return false ;
        } else if (form.password.value == "" ) {
                alert('<%= TranslationHelper.getTranslatedMessge("You must enter the Password") %>');
				form.password.focus();
                return false ;
        }
        re = /\w{1,}/;
		usernamere=/^[a-zA-Z0-9_\.\@\- ]{1,60}$/;
		if (!(re.test(form.username.value))){
			alert('<%= TranslationHelper.getTranslatedMessge("Please enter valid Username") %>');
      		form.username.focus();
     		return false; 
			}
		else if (!(usernamere.test(form.username.value))){
    		alert('<%= TranslationHelper.getTranslatedMessge("Only alpha numeric characters are allowed in Username") %>');
			form.username.focus();
     		return false; 
		} 
		form.mode.value='<%=ApplicationModes.LOGIN %>';

		document.getElementById("bodyWidth").value = document.body.clientWidth;
}


</script>
</head>

<%
	String fontclass="arial12whitebold" ;
	String message="" ;
	String status = request.getParameter("status");
	if(status != null){
		int iStatus = Integer.parseInt(status);
		if(iStatus == AuthConstants.LOGIN_FAILED){
			fontclass="arial12redbold" ;
			message= TranslationHelper.getTranslatedMessge("Wrong username / password");
		} else if(iStatus == AuthConstants.DB_CONNECTION_FAILED){
			fontclass="arial12redbold" ;
			message= TranslationHelper.getTranslatedMessge("Database connection lost");
		}else if(iStatus == AuthConstants.UNAUTHORIZED_ACCESS){
			fontclass="arial12redbold" ;
			message= TranslationHelper.getTranslatedMessge("You are trying to access UnAuthorized Page");
		}
		
	}
%>

<body onLoad="document.forms[0].username.focus();" align="center">
<FORM onSubmit="return loginValidation()" ACTION='<%=request.getContextPath() + "/iview"%>' METHOD=POST>
<input type="hidden" name="login_username" VALUE="" >
<input type="hidden" name="secretkey" VALUE="" >
<input type="hidden" name="mode" VALUE="" >
<INPUT TYPE=HIDDEN NAME="js_autodetect_results" VALUE="SMPREF_JS_OFF">
<INPUT TYPE=HIDDEN NAME="just_logged_in" value=1>
<INPUT TYPE=hidden NAME=appmode VALUE='<%=ApplicationModes.LOGIN %>' >
<INPUT TYPE=hidden NAME=bodyWidth id=bodyWidth  VALUE=1024 >
<div id="wrapper">
	<div class="loginbkgd">
		<div class="iviewlogo"></div>
		<div class="tagline">Intelligent Logging & Reporting</div>
		<div class="screens"></div>
		<div class="errormsg"><%=message%></div>
		<div id="loginform">
			<table border="0" cellpadding="1" cellspacing="2" width=230px>
			<form>
			<tr>
				<td height="40" class="signin">Sign In</td>
			</tr>
			<tr>
              <td height="10"></td>
			  </tr>
			<tr>
				<td><strong><%= TranslationHelper.getTranslatedMessge("Username")%></strong></td>
			  </tr>
			<tr>
			  <td><input type="text" class="inputbox" name="username" id="username" /></td>
			  </tr>
			<tr>
			  <td height="10"></td>
			  </tr>
			<tr>
				<td><strong><%= TranslationHelper.getTranslatedMessge("Password")%></strong></td>
			  </tr>
			<tr>
			  <td><input type="password" class="inputbox" name="password" id="password" /></td>
			  </tr>
			<tr>
              <td height="10"></td>
			  </tr>
			<tr>
				<td><input type="image" src="<%=request.getContextPath()%>/images/login.png" border="0"></td>
			  </tr>
			</form>
			</table>
		</div><!-- end of loginform -->
	</div><!-- end of loginbkgd -->
</div><!-- end of wrapper -->
<div class="footer">&copy;&nbsp;&nbsp;Elitecore Technologies Ltd.<br> The Program is provided AS IS, without warranty. Licensed under <a target="_blank" href="<%=request.getContextPath()%>/LICENSE.txt">GPLv3</a>. This program is free software; you can redistribute it and/or modify it under the terms of the <a target="_blank" href="<%=request.getContextPath()%>/LICENSE.txt">GNU General Public License version 3</a> as published by the Free Software Foundation including the additional permission set forth in the source code header.</br><img style="cursor:pointer" src="../images/InitiativeLogo.png" onclick="window.open('http://www.cyberoam.com','blank')"></img>

</div>
</form>

</body>
</html>

