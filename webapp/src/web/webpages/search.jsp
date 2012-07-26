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

	window.onload = function (evt) {	setWidth();		}		
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}
   	function prepareCriteria(){
   	   	if(document.advanceSearch.criteriavalue1.value == ''){
   	   	   	alert("Please Enter Criteria Value.");
   	   	} else {
	   	   	var url = "<%= request.getContextPath() %>/webpages/reportgroup.jsp?reportgroupid=" + reportGroupId[document.advanceSearch.fieldlist1.selectedIndex];
	   	   	var fieldList = (document.advanceSearch.fieldlist1.options[document.advanceSearch.fieldlist1.selectedIndex].value).split(",");
	   	   	for(i=0; i<fieldList.length; i++){
	   	   		url += "&"+fieldList[i]+"="+document.advanceSearch.criteriavalue1.value; 
	   	   	}
	   		location.href = url;
   	   	}
   	   	return false;
   	}
</script>
</head>
<body>
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>        
<div class="maincontent" id="main_content">
	<jsp:include page="Date.jsp" flush="true">
		<jsp:param name="device"	value="true"></jsp:param>
	</jsp:include>

	<div style="float: left;width: 100%;margin-top: 5px;">
	<form name="advanceSearch" action="<%=request.getContextPath()%>/webpages/search.jsp" method="POST" onsubmit="return prepareCriteria()">
		<table cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td width="20px" style="margin: 10px;">&nbsp;</td>
			<td colspan="4"><div class="reporttitle" style="margin-left:10px"><%= TranslationHelper.getTranslatedMessge("Criteria") %></div></td>
		</tr>
		<tr>
			<td width="20px" style="margin: 10px;">&nbsp;</td>
			<td style="padding: 10px;margin: 10px;">
				<select id="fieldlist1" name="fieldlist1" style="font-weight:bold;font-size:11px;color:#2A576A">
					<option value="username"><%= TranslationHelper.getTranslatedMessge("Username") %></option>
					<option value="srcip,host,victim,attacker"><%= TranslationHelper.getTranslatedMessge("Source Host") %></option>
					<option value="sender,recipient"><%= TranslationHelper.getTranslatedMessge("Email Address") %></option>
				</select>
			</td>
			<td style="padding:10px;margin:10px;font-weight:bold;font-size:11px;color:#2A576A;">equals</td>
			<td style="padding:10px;margin:10px;">
				<input type="text" name="criteriavalue1" id="criteriavalue1" style="font-weight:bold;font-size:11px;color:#2A576A">
			</td>
			<td style="padding: 10px;margin: 10px;">
				<input type="submit" value="<%= TranslationHelper.getTranslatedMessge("Go") %>" class="serButton" style="color: #3B464A"/>
			</td>
		</tr>
		</table>
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
