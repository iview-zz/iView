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

<%@page import="org.cyberoam.iview.modes.ApplicationModes"%><html>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/container.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/tabs.css">

<body>
<div>
<form name="bookmark" action="<%=request.getContextPath()%>/iview" method="post" onsubmit="return checkBlankGroupname();">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">	
		<tr class="innerpageheader">
			<td width="3%">&nbsp;</td>
			<td class="contHead"><div id="formtitle">Add Bookmark Group</div></td>
			<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
			<img src="../images/close.jpg" width="15px" height="15px" style="cursor: pointer;" onclick="handleThickBox(2,'bookmarkgroup');">
			</td>
		</tr>
	</table>
	
<div style="margin:5px" align="center">
<div style="width:95%;border:1px solid #999999;">
	<table cellpadding="2" cellspacing="2" width="100%" border="0" style="background:#FFFFFF;">
	
	<tr>
	<td>
			
		<input type="hidden" name="appmode" id="appmode" value="<%=ApplicationModes.NEWBOOKMARKGROUP%>">
			Bookmark Group Name : <input type="text" name="bmg_name" id="bmg_name">
		</td>
		</tr>
</table>
</div>
</div>
	<table align="center">
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="criButton" name="add" id="add" value="Add">
			<input type="button" class="criButton" value="Close" onclick="handleThickBox(2,'bookmarkgroup');">
		</td>
	</tr>
	</table>
</form>	
</div>
</body>
</html>

