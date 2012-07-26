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
<%@page import="java.io.File"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>

<html>
<head>
<style type="text/css">
.loadButton{
	border: 0px;
	background: transparent;
	font-family: Verdana,Arial,Helvetica,sans-serif; 
	font-size: 11px;
	text-decoration: underline;
}
.loadButton1{
	border: 0px;
	background: transparent;
	font-family: Verdana,Arial,Helvetica,sans-serif; 
	font-size: 11px;
	text-decoration: none;
}
</style>
</head>
  
<body>

<div>
<form action="<%=request.getContextPath()%>/iview?appmode=<%=ApplicationModes.ARCHIEVE_RESTORE_REQUEST%>" enctype="multipart/form-data" method="post" name="frmRestore">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">	
		<tr class="innerpageheader">
			<td width="3%">&nbsp;</td>
			<td class="contHead">Restore Files</td>
			<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
			<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','backuprestore')" style="cursor: pointer;">
			</td>
		</tr>
	</table>
<div style="margin:5px" align="center">
<div style="width:95%;border:1px solid #999999;">

<table name="data" class="TableData" width="100%" cellspacing="0" cellpadding="0">
	<tbody id="tbldata">
	<tr height="25px">
		<td class="tdhead" style="padding-left:10px"><b><%=TranslationHelper.getTranslatedMessge("Filename")%></b></td>
		<td align="center" class="tdhead"><b><%=TranslationHelper.getTranslatedMessge("Action")%></b></td>
	</tr>
	
	
	<tr height="25px">
		<td class="tddata"><input type="file" name="filename" id="filename0"></td>
		<td class="tddata" align="center">
		<input type="button" onclick="addRow();" class="loadButton" onmouseover="this.className = 'loadButton1'" onmouseout="this.className = 'loadButton'" value="<%=TranslationHelper.getTranslatedMessge("Add")%>">		
		</td>
	</tr>			
	</tbody>
</table>

</div>
</div>

	<table align="center">
	<tr>
		<td colspan="2" align="center">
			<input type="submit" id="btnRestore" class="criButton" name="confirm" value="<%=TranslationHelper.getTranslatedMessge("Restore")%>" onClick="return checkRestore(this);">
			<input type="button" class="criButton" value="<%=TranslationHelper.getTranslatedMessge("Cancel")%>" onclick="handleThickBox('2','backuprestore')">
		</td>
	</tr>
	</table>

</form>	
</div>
</body>
</html>
