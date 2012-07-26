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
   	
	function checkSearchFor(){

		var userfontdiv = document.getElementById("userfontdiv");
		var filefontdiv = document.getElementById("filefontdiv");
		 		
		if(document.ftpsearchform.userorfile[0].checked){
				userfontdiv.style.display='';				
				filefontdiv.style.display='none';												
			}else if(document.ftpsearchform.userorfile[1].checked){
				userfontdiv.style.display='none';				
				filefontdiv.style.display='';				
			}
		}
	
	function checkfield(){		
		var username = document.getElementById("username");
		var filename = document.getElementById("filename");
		if(document.ftpsearchform.userorfile[0].checked){				
			username.value = '%' + document.getElementById("nametxt").value + '%';			
			filename.value='%';			
		}else if(document.ftpsearchform.userorfile[1].checked){
			filename.value='%' + document.getElementById("nametxt").value + '%';
			username.value='%';			
		}
		return true;
	}
	/*function setTextUsername(){
		if(<%=request.getSession().getAttribute("clipboarddata")!=null%> && (copyData==undefined || copyData=='')){		
			copyData='<%=request.getSession().getAttribute("clipboarddata")%>';
		}	
		document.getElementById("usernametxt").value=copyData;
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
		<div class="reporttitle">
			<%= TranslationHelper.getTranslatedMessge("Search FTP Usage Report") %>
		</div>
</div>
<div style="float:left;margin-left:2px;margin-top:3px;width:100%;">
		<form onsubmit = "return checkfield();" action="singlereport.jsp" method=get name=ftpsearchform>
		<input type="hidden"  name="reportid" id="reportid" value="50040100" />
		<input type="hidden"  name="reportgroupid" id="reportgroupid" value="50040" />
		<input type="hidden"  name="username" id="username" value="" />
		<input type="hidden"  name="filename" id="filename" value="" />
		<input type="hidden"  name="showtime" id="showtime" value="true" />
		<table cellspacing="0" cellpadding="2px" border="0" width="100%" class="TableData" style="">
		<TR align=left>
			<td  width="20%">
				<%= TranslationHelper.getTranslatedMessge("Transfer Type") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td align="left">
				<input type=radio name=direction value=1 checked onclick ="">
				<%= TranslationHelper.getTranslatedMessge("Download") %>
			    <input type=radio name=direction value=0 onclick ="">
			    <%= TranslationHelper.getTranslatedMessge("Upload") %>
			    <input type=radio name=direction value="2" onclick ="" checked>
			    <%= TranslationHelper.getTranslatedMessge("Any") %>
			</td>
		</TR>		
		<TR align=left>
			<td>
				<%= TranslationHelper.getTranslatedMessge("Search For") %>
			</td>
			<td align="left">
				<input type=radio name=userorfile value="username" onclick ="checkSearchFor();" checked>
				<%= TranslationHelper.getTranslatedMessge("User") %>
			    <input type=radio name=userorfile value="filename" onclick ="checkSearchFor();" />
			    <%= TranslationHelper.getTranslatedMessge("File") %>
			</td>
		</TR>
		<TR>
			<TD>
				<div id="userfontdiv" style="display:">
					<%= TranslationHelper.getTranslatedMessge("User Name") %>
				</div>
				<div id="filefontdiv" style="display:none">
					<%= TranslationHelper.getTranslatedMessge("File Name") %>
				</div>
			</TD>
			<TD>				
					<input type=text name=nametxt id=nametxt value="">				
			</td>
		</TR>
			
		</table>
		<center>
			<input type=submit name=search style="margin-top:8px" class=criButton value="Search">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
