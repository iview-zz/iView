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
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%><html>

<html>
<%
	if(CheckSession.checkSession(request,response) < 0) return;
	try{
%>

<head>
<TITLE><%=iViewConfigBean.TITLE%></TITLE>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>
	<div class="maincontent" id="main_content">
	<table width="100%" border="0">
	<tr>
		<td align="center" style="height: 100px;"></td>
	</tr>
	<tr>
		<td align="center" style="height: 100px;color:#D42A1D;font-size:60px;">Access Denied</td>
	</tr>
	<tr>
		<td align="center" style="height: 50px;color:#D42A1D;font-size:20px;">You are not allowed to view this page.</td>
	</tr>
	<tr>
		<td align="center" style="height: 50px;color:#D42A1D;font-size:20px;">For more information contact iView administrator.</td>
	</tr>
	</table>
	</div>
	<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in iviewconfig.jsp : "+e,e);
}
%>
