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
<%@page import="java.text.MessageFormat"%>
<%@page import="java.util.*"%>
<%@page import="org.cyberoam.iview.beans.ProtocolGroupBean" %>
<%@page import="org.cyberoam.iview.beans.ApplicationNameBean"%>
<%@page import="org.cyberoam.iview.beans.ProtocolIdentifierBean"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	try{
	if(CheckSession.checkSession(request,response)<0)
		return;
		ApplicationNameBean applicationNameBean = null;
		LinkedHashMap applicationNameMap=null;
		Iterator applicationNameIterator=null;
		applicationNameMap=ApplicationNameBean.getApplicationNameBeanMap(ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP);
		if(applicationNameMap !=null && applicationNameMap.size() > 0){
		applicationNameIterator=applicationNameMap.values().iterator();
		}
		String pageHeader = TranslationHelper.getTranslatedMessge("Add");
		String desc="";
		boolean isUnassigned = false;
		String strProtocolGrpId=request.getParameter("protocolgroupid");
		int id=-1,iMode=ApplicationModes.ADD_PROTOCOL_GROUP;
		if(strProtocolGrpId != null){
			pageHeader = TranslationHelper.getTranslatedMessge("Edit");
			id = new Integer(strProtocolGrpId).intValue();
			ProtocolGroupBean protocolGroupBean = null;
			protocolGroupBean = ProtocolGroupBean.getSQLRecordbyPrimarykey(id);
			if(protocolGroupBean != null){
				isUnassigned = protocolGroupBean.getProtocolgroupId() == ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP;
				pageHeader+= " " + protocolGroupBean.getProtocolGroup();
				desc=protocolGroupBean.getDescription();
			}
			iMode = ApplicationModes.UPDATE_PROTOCOL_GROUP;
		}
%>

<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<HTML>
<HEAD></HEAD>
<BODY>
	<FORM method="POST" name="frmAddProtocolGroup" action="<%=request.getContextPath()%>/iview">
	<input type="hidden" name="appmode" value =<%=iMode %>>
	<input type="hidden" name="id" value=<%=id %>>
	
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr class="innerpageheader">
		<td width="3%">&nbsp;</td>
		<td class="contHead"><%= pageHeader +" " + TranslationHelper.getTranslatedMessge("Application Group") %></td>
		<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
		<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','protocolgrp')" style="cursor: pointer;">
		</td>
	</tr>
</table>
	<tr>
		<td width="7%">&nbsp;</td>
		<td>
		<div style="margin:5px" align="center">
			<div style="width:95%;border:1px solid #999999;">
			<table cellspacing="2" cellpadding="2" border="0" width="100%" style="background:#FFFFFF;">
			<tr>
				<td>
					<table cellspacing="2" cellpadding="2" border="0" width="100%" class="trContainer">
					<%
					if(strProtocolGrpId == null){
					%>
					<tr >
						<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Group Name") %><font class="compfield">*</font></td>
						<td> <input size="29" type="text" name="protocolgroupname" value="" /></td>
					</tr>
					<tr >
						<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Description") %></td>
						<td >
					<%	
					} else {
					%>
					<tr >
						<td  class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Description")%></td>
						<td  >
					<%
					}
					%>
							<textarea rows=4 name=description cols="22"><%=(desc !=null && !"null".equalsIgnoreCase(desc))?desc:"" %></textarea>
						</td>
					</tr>
					<tr >
						<td colspan="2" >
							<table cellspacing="3" cellpadding="0" border="0" width="100%">
							<tr class="trContainer1" <%= isUnassigned?"colspan=\"3\"":"" %> <%= isUnassigned?"align=\"center\"":"" %> >
								<td class="trContainer1"><%= TranslationHelper.getTranslatedMessge("Unassigned Applications") %></td>
					<% if(!isUnassigned) { %>
								<td class="trContainer1">&nbsp;</td>
								<td class="trContainer1"><%= TranslationHelper.getTranslatedMessge("Selected Applications") %><font class="compfield">*</font></td>
					<% } %>
							</tr>
							<tr class="trContainer">
								<td class="trContainer1" <%= isUnassigned?"colspan=\"3\"":"" %>  align="center">
									<select style="width: 200px;" size="10" multiple="multiple" name="availableapps">
				<%
				if(applicationNameIterator !=null && applicationNameIterator.hasNext()){
							while(applicationNameIterator.hasNext()){
								applicationNameBean=(ApplicationNameBean)applicationNameIterator.next();
				%>
										<option value="<%=applicationNameBean.getApplicationNameId() %>"><%=applicationNameBean.getApplicationName() %></option>
				<%
					}
				}
				%>
									</select>
								</td>
				<%
					if(!isUnassigned){
				%>				
								<td align="center" class="trContainer1">
									<input class="criButton" type="button" onClick="movelistitems('right')" value="&nbsp;>&nbsp;">
									<br>
									<input class="criButton" type="button" onClick="movelistitems('left')" value="&nbsp;<&nbsp;">
								</td>
								<td class="trContainer1">
									<select style="width: 200px;" size="10" multiple="multiple" name="selectedapps">
				<%
							applicationNameMap=ApplicationNameBean.getApplicationNameBeanMap(id);
							if(applicationNameMap !=null && applicationNameMap.size() > 0){
								applicationNameIterator=applicationNameMap.values().iterator();
							}
							while(applicationNameIterator.hasNext()){
								applicationNameBean=(ApplicationNameBean)applicationNameIterator.next();
				%>
										<option value="<%=applicationNameBean.getApplicationNameId() %>"><%=applicationNameBean.getApplicationName() %></option>
				<% } %>			
									</select>
								</td>
				<% } %>				
								</tr>
							</table>
						</td>		
					</tr>
					</table>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			</table>
			</div></div>
		<table align="center">	
		<tr>
				<td align="center">
					<input class="criButton" type="button" onClick="return validateForm();" value="<%= TranslationHelper.getTranslatedMessge("Done") %>" name="ok"/>
					&nbsp;&nbsp;
					<input class="criButton" type="button" onClick="handleThickBox('2','protocolgrp');" value="<%= TranslationHelper.getTranslatedMessge("Cancel") %>" name="Cancel"/>
				</td>
			</tr>
			
		</table>

		<td width="7%">&nbsp;</td>
	</tr>
	<tr><td colspan="3">&nbsp;</td></tr>
	</table>
</FORM>
</BODY> 
</HTML>
<% 
	}catch(Exception e){
		CyberoamLogger.appLog.error("addprotocolgroup.jsp:"+e,e);
	}
%>
%>