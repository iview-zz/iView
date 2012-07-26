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
********************************************************************** -->
<%@ page contentType="text/html; charset=UTF-8"%>

<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.beans.BookmarkGroupBean"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Iterator"%>

<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%><html>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/container.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/tabs.css">
<%
	try{
	String url=session.getAttribute("bookmarkurl").toString();
	String description=null;
	int urlindex=0;
	if(url.contains("&empt")){
		url=url.replace("&empt","&empty");
		urlindex=url.indexOf("&empty");
		url=url.substring(0,urlindex);
	}
	else if(url.contains("&flushCache") || url.contains("&devicelist")){
		urlindex=url.indexOf("&devicelist");
		if(urlindex>url.indexOf("&flushcache")){
			urlindex=url.indexOf("&flushCache");
		}
		url=url.substring(0,urlindex);
		
	}
	
	LinkedHashMap bookmarkGroupMap = BookmarkGroupBean.getRecord();
	Iterator bookmarkGroupMapIterator=null;
	BookmarkGroupBean bookmarkGroupBean=null;
	if(bookmarkGroupMap!=null && bookmarkGroupMap.size()>0){
		bookmarkGroupMapIterator=bookmarkGroupMap.values().iterator();
	}
	
	if(request.getParameter("title")!=null){
		description=request.getParameter("title");
	}
%>

<body>
<div>
<form name="bookmark" action="<%=request.getContextPath()%>/iview" method="post" onsubmit="return checkBlankBookmark('<%=url%>');">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">	
		<tr class="innerpageheader">
			<td width="3%">&nbsp;</td>
			<td class="contHead"><div id="formtitle">Add Bookmark</div></td>
			<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
			<img src="../images/close.jpg" width="15px" height="15px" style="cursor: pointer;" onclick="handleThickBox(2,'bookmark');">
			</td>
		</tr>
	</table>
	
<div style="margin:5px" align="center">
<div style="width:95%;border:1px solid #999999;">
	<input type="hidden" name="url" id="url">
	<input type="hidden" name="appmode" id="appmode" value="<%=ApplicationModes.NEWBOOKMARK%>">
	<input type="hidden" name="categoryid" id="categoryid" value="<%=(String)session.getAttribute("categoryid")%>">
	<table cellpadding="2" cellspacing="2" width="100%" border="0" style="background:#FFFFFF;">
	<tr>
		<td>
			Bookmark Name : 
		</td>
		<td>
			<input type="text" name="bm_name" id="bm_name" maxlength="20">
		</td>
	</tr>
		<tr>
			<td>Description : </td>
			<td colspan="2"><textarea id="description" name="description" rows="3" cols="35"><%=description%></textarea></td>
		</tr>
	<tr>
		<td>
			Bookmark Group :
		</td>	
		<td>	
			<select name="bm_group" id="bm_group" onchange="addnewgroup()">
				<%while(bookmarkGroupMapIterator.hasNext()){
					bookmarkGroupBean=(BookmarkGroupBean)bookmarkGroupMapIterator.next(); 
					%>
					<option value="<%=bookmarkGroupBean.getBookmarkGroupID() %>"><%=bookmarkGroupBean.getName() %></option>
				<%
				}
				%>
				<option value="0">[Add Bookmark Group]</option>
			</select>
		</td>
		<td>
			<div id="newgroup"></div>
		</td>
		</tr>
</table>
</div>
</div>
	<table align="center">
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="criButton" name="add" id="add" value="Add">
			<input type="button" class="criButton" value="Close" onclick="handleThickBox(2,'bookmark');">
		</td>
	</tr>
	</table>
</form>	
</div>
</body>
<%}
	catch(Exception e){
		CyberoamLogger.appLog.debug("Exception in addbookmark.jsp" + e,e);
	}
%>
</html>

