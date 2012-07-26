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

<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.beans.ProtocolIdentifierBean"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	if(CheckSession.checkSession(request,response)<0)
		return;
	String strAppNameId=request.getParameter("applicationnameid");
	int applicationNameId = -1;
	if(strAppNameId != null){
		applicationNameId = new Integer(strAppNameId).intValue();
	}
%>

<html>
<head></head>
<body>
	<FORM method="POST" name="frmProtocolIdentifier" action="<%=request.getContextPath()%>/iview">
	<input type="hidden" name="appmode" value="<%=ApplicationModes.ADD_PROTOCOL_IDENTIFIER %>" >
	<input type="hidden" name="applicationnameid" value="<%=applicationNameId %>" >
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr class="innerpageheader">
		<td width="3%">&nbsp;</td>
		<td class="contHead"><%= TranslationHelper.getTranslatedMessge("Add Application Identifier") %></td>
		<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
		<img src="../images/close.jpg" width="15px" height="15px" onclick="handleIdentifier()" style="cursor: pointer;">
		</td>
	</tr>
	</table>
	<tr><td colspan="3">&nbsp;</td></tr>
	<tr>
		<td width="7%">&nbsp;</td>
		<td>
			<div style="margin:5px" align="center">
			<div style="width:95%;border:1px solid #999999;">
			<table cellspacing="2" cellpadding="2" border="0" width="100%" class="trContainer" style="background:#FFFFFF;">
			<tr>
				<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Application") %></td>
				<td >
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr>
						<td style="width:50%">
							<input type="radio" checked name="rdoProtocol" id="rdoProtocolTcp" value="<%=ProtocolIdentifierBean.TCP %>">&nbsp;TCP&nbsp;
						</td>
						<td >
							<input type="radio" name="rdoProtocol" id="rdoProtocolUdp" value="<%=ProtocolIdentifierBean.UDP %>">&nbsp;UDP&nbsp;
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Port Type") %></td>
				<td >
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr>
						<td style="width:50%">
							<input type="radio" name="rdoPort" id="rdoPort" value="1" onclick="onChangePortType();" checked>&nbsp;Port&nbsp;
						</td>
						<td >
							<input type="radio" name="rdoPort" id="rdoPortRange" value="2" onclick="onChangePortType();" >&nbsp;Port&nbsp;&nbsp;Range&nbsp;
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("From") %><font class="compfield">*</font></td>
				<td ><input type="text" name="txtFrom" id="txtFrom" value=""></td>
			</tr>
			<tr>
				<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("To") %><font class="compfield">*</font></td>
				<td ><input type="text" name="txtTo" id="txtTo"  disabled value=""></td>
			</tr>
			<tr><td colspan="2">&nbsp;</td></tr>
			</table></div></div>
			<table align="center">
			<tr>
				<td colspan="2" align="center">
					<input class="criButton" type="button" onclick="return validateIdentifierForm();" value="<%= TranslationHelper.getTranslatedMessge("Done") %>" name="ok"/>
					<input class="criButton" type="button" onclick="handleIdentifier();" value="<%= TranslationHelper.getTranslatedMessge("Cancel") %>" name="Cancel"/>
				</td>
			</tr>
			</table>
			
			</td>
			<td width="7%">&nbsp;</td>
		</tr>
		<tr><td colspan="3">&nbsp;</td></tr>
		</table>
	</form>
</body> 
</html>
