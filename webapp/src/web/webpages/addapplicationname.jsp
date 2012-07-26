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
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	if(CheckSession.checkSession(request,response)<0)
		return;
		ProtocolIdentifierBean protocolIdentifierBean = null;
		ProtocolGroupBean protocolGroupBean = null;
		LinkedHashMap protocolIdentifierBeanMap=null;
		Iterator protocolIdentifierBeanIterator=null;
		String pageHeader = TranslationHelper.getTranslatedMessge("Add");
		String selected="";
		String strAppNameId=request.getParameter("applicationnameid");
		int id=-1,protocolgroupid=ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP,iMode=ApplicationModes.ADD_APPLICATION;
		int mode = -1;
		if(request.getParameter("appmode") != null && request.getParameter("status") != null){
			mode = new Integer(request.getParameter("appmode").trim()).intValue();
			id = new Integer(request.getParameter("status")).intValue();
		}
		if(strAppNameId != null && !"null".equalsIgnoreCase(strAppNameId)){
			id = new Integer(strAppNameId).intValue();
		}
		
		String strMode=request.getParameter("appmode");
		String strStatus = request.getParameter("status");
		int appMode = -1,iStatus = 0;
		if(strMode !=null && !"null".equalsIgnoreCase(strMode)){
			appMode = new Integer(strMode).intValue();
		}
		if(strStatus !=null && !"null".equalsIgnoreCase(strStatus)){
			iStatus = new Integer(strStatus).intValue();
		}
		String message = "";
		if(appMode == ApplicationModes.DELETE_PROTOCOL_IDENTIFIER && iStatus > 0){
			message = TranslationHelper.getTranslatedMessge("Application Identifier deleted successfully.");
		}else if(appMode == ApplicationModes.DELETE_PROTOCOL_IDENTIFIER && iStatus < 0){
			message = TranslationHelper.getTranslatedMessge("Error in Application Identifier Deletion.");
		}else if(appMode == ApplicationModes.ADD_PROTOCOL_IDENTIFIER && iStatus > 0){
			message = TranslationHelper.getTranslatedMessge("Application Identifier added successfully.");
		}else if(appMode == ApplicationModes.ADD_PROTOCOL_IDENTIFIER && iStatus < 0){
			message = TranslationHelper.getTranslatedMessge("Error in Application Identifier Addition.");
		}
		if(request.getParameter("applicationname") != null && !"null".equalsIgnoreCase(request.getParameter("applicationname"))){
			String strApplicationName = request.getParameter("applicationname");
			message = TranslationHelper.getTranslatedMessge("Application Identifier already exists in") + " " + strApplicationName + ".";
		}
		
		if(id > 0){
			pageHeader = TranslationHelper.getTranslatedMessge("Edit");
			ApplicationNameBean applicationNameBean = null;
			applicationNameBean = ApplicationNameBean.getSQLRecordbyPrimarykey(id);
			if(applicationNameBean != null){
				pageHeader += " " + applicationNameBean.getApplicationName();
				protocolgroupid=applicationNameBean.getProtocolGroupId();
			}
			protocolIdentifierBeanMap=ProtocolIdentifierBean.getProtocolIdentifierBeanMap(id);
			if(protocolIdentifierBeanMap !=null && protocolIdentifierBeanMap.size() > 0){
				protocolIdentifierBeanIterator=protocolIdentifierBeanMap.values().iterator();
			}
			iMode=ApplicationModes.UPDATE_APPLICATION;
		}
		LinkedHashMap protocolGroupMap = ProtocolGroupBean.getProtocolGroupMap();
		Iterator protocolGroupIterator = protocolGroupMap.values().iterator();
%>

<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.beans.ProtocolIdentifierBean"%>
<%@page import="org.cyberoam.iview.beans.ProtocolGroupBean"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.beans.ApplicationNameBean"%><HTML>
<HEAD></HEAD>
<BODY>
	<FORM method="POST" name="frmAddProtocol" action="<%=request.getContextPath()%>/iview">
	<input type="hidden" name="id" value =<%=id %>>
	<input type="hidden" name="protocolidentifierid" value="">
	<input type="hidden" name="appmode" value=<%=iMode %>>
	
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr class="innerpageheader">
		<td width="3%">&nbsp;</td>
		<td class="contHead"><%= pageHeader +" " + TranslationHelper.getTranslatedMessge("Application") %></td>
		<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
		<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','application')" style="cursor: pointer;">
		</td>
	</tr>
	</table>

	<tr>
		<td width="7%">&nbsp;</td>
		<td>
			<div style="margin:5px" align="center">
			<div style="width:95%;border:1px solid #999999;">
			<table border="0" cellpadding="2" cellspacing="2" width="100%" class="trContainer" style="background:#FFFFFF;">
			<%if(!"".equals(message)){ %>
				<tr><td class="message" colspan="2"><%=message %></td></tr>
				<tr><td colspan="2">&nbsp;</td></tr>
			<% } %>	

			<%
				if(!(id > 0)){
			%>
			<tr>
				<td  class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Application Name") %><font class="compfield">*</font></td>
				<td>  <input type="text" name="applicationname" value="" style="width:180px" /></td>
			</tr>
			<tr >
				<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Application Group") %><font class="compfield">*</font></td>
				<td >
			<%	} else {
			%>
			<tr >
				<td colspan="2" align="left" class="Buttonback">
					<input class="criButton" type="button" name="" value="<%= TranslationHelper.getTranslatedMessge("Add Application Identifier") %>" onclick="openAddProtocolIdentifier('<%= id %>');">
				</td>	
			</tr>
			<tr >
				<td  class="textlabels" style="width:50%"><%= TranslationHelper.getTranslatedMessge("Application Group") %><font class="compfield">*</font></td>
				<td  >
			<%	
			}
			%>
					<select name="protocolgroup" style="width:180px">
		<%
					while(protocolGroupIterator.hasNext()){
						protocolGroupBean =(ProtocolGroupBean)protocolGroupIterator.next();
		%>			
						<option value="<%=protocolGroupBean.getProtocolgroupId() %>" <%=(protocolGroupBean.getProtocolgroupId() == protocolgroupid)?"selected":"" %>><%=protocolGroupBean.getProtocolGroup() %></option>
		<% } %>
					</select>
				</td>
			</tr>
		<% 
			if(id > 0){
		%>
			
		<%
				if(protocolIdentifierBeanMap !=null && protocolIdentifierBeanMap.size() > 0){
		%>
			<tr >
				<td class="textlabels" style="width:35%"><%= TranslationHelper.getTranslatedMessge("Application Identifiers") %></td>
				<td></td>
			</tr>
			<tr >
				<td colspan="2" align="left" >
				<div class="IdentDiv">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" class="trContainer">
		<%
					boolean firstRow = true;
					while(protocolIdentifierBeanIterator.hasNext()){
						protocolIdentifierBean=(ProtocolIdentifierBean)protocolIdentifierBeanIterator.next();
						String identifier="";
						if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.ICMP)
							identifier="icmp/"+protocolIdentifierBean.getPort();
						else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.TCP)
							identifier="tcp/"+protocolIdentifierBean.getPort();
						else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.UDP)
							identifier="udp/"+protocolIdentifierBean.getPort();

		%>
			<tr >
				<td class="textlabels" style="width:50%"><%=identifier %></td>
				<td align="left">
					<img src="<%=request.getContextPath()%>/images/false.gif" title="Disable" style="cursor:hand" onclick="deleteProtocolIdentifier(<%=protocolIdentifierBean.getId() %>,'<%=identifier %>')">
				</td>
			</tr>
		<%					firstRow = false;
					}
		
		%>
					</div>
					</table>	
				</td>
			</tr>
		<%
				}
			}
		%>
			</table>
			</div></div>
			<table align="center">
			<tr>
				<td colspan="2" align="center">
					<input class="criButton" type="button" onclick="return validateProtocolForm();" value="<%= TranslationHelper.getTranslatedMessge("Done") %>" name="ok"/>
					&nbsp;&nbsp;
					<input class="criButton" type="button" onclick="handleThickBox('2','application');" value="<%= TranslationHelper.getTranslatedMessge("Cancel") %>" name="Cancel" />	
				</td>
			</tr>
			</table>
		</td>
		<td width="7%">&nbsp;</td>
	</tr>
	<tr><td colspan="3">&nbsp;</td></tr>
	</table>
</BODY> 
</HTML>
