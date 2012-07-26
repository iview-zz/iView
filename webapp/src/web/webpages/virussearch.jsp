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
<%@page import="org.cyberoam.iview.utility.*"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>

<%
	try{
		if(CheckSession.checkSession(request,response)<0){
			return;
		}
		
		
%>
<html>
<head>
<title><%= iViewConfigBean.TITLE %></title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/container.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/tabs.css">
<script type="text/javascript" language="JavaScript" src="<%=request.getContextPath()%>/javascript/SearchData.js"></script>
<script type="text/javascript" language="JavaScript" src="<%=request.getContextPath()%>/javascript/utilities.js"></script>
<script type="text/javascript" language="javascript">
   	var http_request = false;
   	var childwindow;
   	var fieldArray = new Array("User","Source","Email Address");
   	var reportGroupId = new Array("26","28","29");
	var tablefieldArray = new Array("username","srcip,host,victim,attacker","sender,recipient");
	var criteriaArray = new Array("is");
	var criteriaValueArray = new Array("=");

	window.onload = function (evt) {
		setWidth();		
	}		
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}
   	
	function checkfield(){
		var objusername = document.getElementById("objusername");
		var sender = document.getElementById("sender");
		var recipient = document.getElementById("recipient");
		var subject = document.getElementById("subject");
		var virus = document.getElementById("virus");
		var both = document.getElementById("both");

		both.value = '';
		
		subject.value = '%' + document.getElementById("subjecttxt").value + '%';
		virus.value = '%' + document.getElementById("virustxt").value + '%';		
		sender.value = '%' + document.getElementById("objusernametxt").value + '%';
		recipient.value = '%' + document.getElementById("objusernametxt").value + '%';		

	
		 if( document.websearchform.usertype[0].checked ){			
			recipient.value = '%' + document.getElementById("objusernametxt").value + '%';					
			sender.value = '%';
			both.value = '%';
		 }else if(document.websearchform.usertype[1].checked){			
			sender.value = '%' + document.getElementById("objusernametxt").value + '%';					
			recipient.value = '%';
			both.value = '%';
		}else if(document.websearchform.usertype[2].checked){
			both.value = '%' + document.getElementById("objusernametxt").value + '%';		
			recipient.value = '%';
			sender.value = '%';
		}
		return true;
	}
	/*function setEmailAddress(){
		if(<%=request.getSession().getAttribute("clipboarddata")!=null%> && (copyData==undefined || copyData=='')){		
			copyData='<%=request.getSession().getAttribute("clipboarddata")%>';
		}	
		document.getElementById("objusernametxt").value=copyData;
	}*/		
</script>
</head>
<body>
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>        
<div class="maincontent" id="main_content">
	<jsp:include page="Date.jsp" flush="true">
		<jsp:param name="device"	value="true"></jsp:param>
		<jsp:param name="showtime"	value="true"></jsp:param>
	</jsp:include>
<div class="reporttitlebar">
		<div class="reporttitle"><%= TranslationHelper.getTranslatedMessge("Search Anti Virus Report") %>
		</div>
</div>
<div style="float:left;margin-left:2px;margin-top:3px;width:100%;">
		<form onsubmit = "return checkfield();" action="singlereport.jsp" method=get name=websearchform>
        <input type="hidden"  name="reportid" id="reportid" value="50070"/>
		<input type="hidden"  name="reportgroupid" id="reportgroupid" value="50030"/>
		<input type="hidden"  name="sender" id="sender"/>
		<input type="hidden"  name="recipient" id="recipient"/>
		<input type="hidden"  name="both" id="both" value="%"/>
		<input type="hidden"  name="objusername" id="objusername" value=""/>
		<input type="hidden"  name="subject" id="subject" value=""/>
		<input type="hidden"  name="virus" id="virus" value=""/>
		<input type="hidden"  name="showtime" id="showtime" value="true" />
		<table cellspacing="0" cellpadding="2px" border="0" width="100%" class="TableData">
		<TR align=left>
			<td width="20%">
				<%= TranslationHelper.getTranslatedMessge("Protocol") %>
			</td>
			<td align="left">
				<input type=radio name=application value="smtp"  onclick ="" id="smtp">
				<%= TranslationHelper.getTranslatedMessge("SMTP") %> 
			    <input type=radio name=application value="pop3" onclick ="" id="pop">
			   	<%= TranslationHelper.getTranslatedMessge("POP3") %>
			   	<input type=radio name=application value="imap" onclick ="" id="imap">
			   	<%= TranslationHelper.getTranslatedMessge("IMAP") %>
				<input type=radio name=application value="http" onclick ="" id="http">
			   	<%= TranslationHelper.getTranslatedMessge("HTTP") %>
				<input type=radio name=application value="https" onclick ="" id="https">
			   	<%= TranslationHelper.getTranslatedMessge("HTTPS") %>
				<input type=radio name=application value="ftp" onclick ="" id="ftp">
			   	<%= TranslationHelper.getTranslatedMessge("FTP") %>
			  	<input type=radio name=application value="%" onclick ="" id="anyproto" checked>
			   	<%= TranslationHelper.getTranslatedMessge("Any") %>
			</td>
		</TR>
		<TR align=left>
			<td >
				<%= TranslationHelper.getTranslatedMessge("User Type") %>		  		
			</td>
			<td align="left">
          		<input type=radio name=usertype value="Recipient" onclick =""  id="recipient">
			  	<%= TranslationHelper.getTranslatedMessge("Recipient") %>
				<input type=radio name=usertype value="Sender" onclick ="" id="sender">
			  	<%= TranslationHelper.getTranslatedMessge("Sender") %>
			  	<input type=radio name=usertype value="Any" onclick ="" id="anyuser" checked>
			  	<%= TranslationHelper.getTranslatedMessge("Any") %>
			</td>
		</TR>
		<TR>
			<TD>
				<%= TranslationHelper.getTranslatedMessge("User Email Address") %>
			</TD>
			<TD>
				<input type=text name=objusernametxt id=objusernametxt  value="">		
			</td>
		</TR>
		<TR id="sitenametr" style="display:''">
			<TD><%= TranslationHelper.getTranslatedMessge("Subject") %></TD>
			<TD><input type=text name=subjecttxt id=subjecttxt value="" ></td>
		</TR>
		<TR>
			<TD><%= TranslationHelper.getTranslatedMessge("Virus Name") %></TD>
			<TD><input type=text name=virustxt id=virustxt value="" ></td>
		</TR>
		</table>
		<center>
			<input type=submit name=search value="Search" style="margin-top:8px" class=criButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</center>
		</form>
	</div>
</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
</body>
<%
	} catch(Exception e) {
	}
%>
</html>
