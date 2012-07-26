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
<html>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/container.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/tabs.css">
<body>
<div>
<form name="viewlog">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">	
		<tr class="innerpageheader">
			<td width="3%">&nbsp;</td>
			<td class="contHead"><div id="formtitle"></div></td>
			<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
			<img src="../images/close.jpg" width="15px" height="15px" onclick="closeForm()" style="cursor: pointer;">
			</td>
		</tr>
	</table>
	
	
<div style="margin:5px" align="center">
<div style="width:95%;border:1px solid #999999;">
	<table cellpadding="2" cellspacing="2" width="100%" border="0" style="background:#FFFFFF;">
	
	<tr >
		<td class="textlabels">Show last<font class="compfield">*</font></td>
		<td>
			<select name="limit" id="limit" onchange="userRefresh()">
					<option value="100" selected="selected">100</option>
					<option value="500" >500</option>
					<option value="1000" >1000</option>
					<option value="2000" >2000</option>
					
			</select>
		</td>
		<td class="textlabels">Refresh Time : <font class="compfield">*</font></td>
		<td>
			<select name="refreshtime" id="refreshtime" onchange="userRefresh()">
					<option value="5" selected="selected">5 Sec</option>
					<option value="10" >10 Sec</option>
					<option value="15" >15 Sec</option>
					<option value="30" >30 Sec</option>
					<option value="60" >1 Min</option>
					<option value="120" >2 Min</option>
					<option value="180" >3 Min</option>
			</select>
		</td>
		<td>
			Search By: <input type="text" name="searchkey" id="searchkey">
			<input type="button" class="criButton" style="width:50px" name="search" id="search" value="Search" onclick="userRefresh()">
		</td>
	</tr>

</table>
<div id='archiveContent' style='height:300px;width:100%;overflow:auto' align="left">
</div>

</div>
</div>
	<table align="center">
	<tr>
		<td colspan="2" align="center">
			<input type="button" class="criButton" name="stop" id="stop" value="Stop" onclick="stoplogs()">
			<input type="button" class="criButton" name="refresh" id="refresh" value="Refresh" onclick="userRefresh()">
			<input type="button" class="criButton" value="ClearLogs" id="clear" name="clear" onclick="clearlogs()">
			<input type="button" class="criButton" value="Close" onclick="closeForm()">
		</td>
	</tr>
	</table>
</form>	
</div>
</body>
</html>

