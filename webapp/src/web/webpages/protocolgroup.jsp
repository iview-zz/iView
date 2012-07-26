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
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="java.util.*"%>
<%@page import="org.cyberoam.iview.beans.ProtocolGroupBean" %>
<%@page import="org.cyberoam.iview.beans.ApplicationNameBean"%>
<%@page import="org.cyberoam.iview.beans.ProtocolIdentifierBean"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%
	try{
	if(CheckSession.checkSession(request,response)<0)
		return;
	String pmessage="";
	String nmessage="";
	String fontClass="";
	String strMode=request.getParameter("appmode");
	String strStatus = request.getParameter("status");
	int iMode = -1,iStatus = 0;
	if(strMode !=null && !"null".equalsIgnoreCase(strMode)){
		iMode = new Integer(strMode).intValue();
	}
	if(strStatus !=null && !"null".equalsIgnoreCase(strStatus)){
		iStatus = new Integer(strStatus).intValue();
	}
	if(iMode == ApplicationModes.ADD_PROTOCOL_GROUP && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application Group added successfully.");
	}else if(iMode == ApplicationModes.ADD_PROTOCOL_GROUP && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Application Group already exists.");
	}else if(iMode == ApplicationModes.ADD_PROTOCOL_GROUP && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Group Creation.");
	}else if(iMode == ApplicationModes.UPDATE_PROTOCOL_GROUP && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application Group updated successfully.");
	}else if(iMode == ApplicationModes.UPDATE_PROTOCOL_GROUP && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Group Updation.");
	}else if(iMode == ApplicationModes.DELETE_PROTOCOL_GROUP && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application Group deleted successfully.");
	}else if(iMode == ApplicationModes.DELETE_PROTOCOL_GROUP && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Group Deletion.");
	}else if(iMode == ApplicationModes.ADD_APPLICATION && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application added successfully.");
	}else if(iMode == ApplicationModes.ADD_APPLICATION && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Application already exists.");
	}else if(iMode == ApplicationModes.ADD_APPLICATION && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Creation.");
	}else if(iMode == ApplicationModes.UPDATE_APPLICATION && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application updated successfully.");
	}else if(iMode == ApplicationModes.UPDATE_APPLICATION && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Updation.");
	}else if(iMode == ApplicationModes.DELETE_APPLICATION && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application deleted successfully.");
	}else if(iMode == ApplicationModes.DELETE_APPLICATION && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Deletion.");
	}
%>
<HTML>
<HEAD>
	<TITLE><%=iViewConfigBean.TITLE%></TITLE>
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<LINK rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reports.css" />
	<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/protocolgroup.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/popupform.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/utilities.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/ipvalidation.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript">
		window.onload = function (evt) {
			setWidth();
			//getWinSize();
			setAppWin();				
		}		
		function setWidth(){
			var main_div = document.getElementById("main_content");	
			main_div.style.width = (document.body.clientWidth - 217);	
		}
	function deleteProtocolGroup(id,protocolgroup){
		var answer 
	    	answer=confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure to delete")%> " + protocolgroup + " <%=TranslationHelper.getTranslatedMessge("Application group?")%>");
	    if(answer){
	    	document.frmProtocolGroup.id.value=id;
	    	document.frmProtocolGroup.appmode.value=<%=ApplicationModes.DELETE_PROTOCOL_GROUP%>;	
			document.frmProtocolGroup.submit();
		}
	}
	function deleteApplicationName(id,applicationname){
		var answer 
	    	answer=confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure to delete")%> " + applicationname + " <%=TranslationHelper.getTranslatedMessge("Application?")%> ");
	    if(answer){
	    	document.frmProtocolGroup.id.value=id;
	    	document.frmProtocolGroup.appmode.value=<%=ApplicationModes.DELETE_APPLICATION%>;	
			document.frmProtocolGroup.submit();
		}
	}
	function openAddProtocolGroup(id){
		oldURL = URL;
		if(id == ''){
			URL = '<%=request.getContextPath()%>/webpages/addprotocolgroup.jsp';
		} else {
			URL = '<%=request.getContextPath()%>/webpages/addprotocolgroup.jsp?protocolgroupid='+id;
		}
		handleThickBox('1','protocolgrp','500');
		//top.sourceWindow=window.open(reqloc,'_person','width=570,height=480,titlebar=no,scrollbars=yes');
	}
	function openAddApplicationName(id){
		oldURL = URL;
		if(id == '') {
			URL = '<%=request.getContextPath()%>/webpages/addapplicationname.jsp';
		} else {
			URL = '<%=request.getContextPath()%>/webpages/addapplicationname.jsp?applicationnameid='+id;
		}
		handleThickBox('1','application','450');	
		//top.sourceWindow=window.open(reqloc,'_person','width=570,height=480,titlebar=no,scrollbars=yes');
	}
	function deleteProtocolIdentifier(id,identifier){
		var answer 
	    	answer=confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure to delete")%> " + identifier + "?");
	    if(answer){
	    	document.frmAddProtocol.protocolidentifierid.value=id;
	    	document.frmAddProtocol.appmode.value=<%=ApplicationModes.DELETE_PROTOCOL_IDENTIFIER%>;	
			document.frmAddProtocol.submit();
		}
	}
	function openAddProtocolIdentifier(appid){
		oldURL = URL;
		URL = '<%=request.getContextPath()%>/webpages/addprotocolidentifier.jsp?applicationnameid='+appid;
		handleThickBox('2','application');
		handleThickBox('1','applicationIdentifier','400');
		// top.sourceWindow=window.open(reqloc,'_person1','width=300,height=300,titlebar=no,scrollbars=yes');
	}
	function setAppWin(){
	<%boolean isManageApp = false;
		if(iMode == ApplicationModes.DELETE_PROTOCOL_IDENTIFIER && iStatus > 0){
			isManageApp = true;
		}else if(iMode == ApplicationModes.DELETE_PROTOCOL_IDENTIFIER && iStatus < 0){
			isManageApp = true;
		}else if(iMode == ApplicationModes.ADD_PROTOCOL_IDENTIFIER && iStatus > 0){
			isManageApp = true;
		}else if(iMode == ApplicationModes.ADD_PROTOCOL_IDENTIFIER && iStatus < 0){
			isManageApp = true;
		}else if(request.getParameter("applicationname") != null && !"null".equalsIgnoreCase(request.getParameter("applicationname"))){
			isManageApp = true;
		}
		if(isManageApp){%>
			URL = '<%=request.getContextPath()%>/webpages/addapplicationname.jsp?' + '<%=request.getQueryString()%>';
			handleThickBox('1','application');
	<%}%>
	}
	function resetToDefault(){
		var con=confirm('Are you sure you want to reset all Application Group-Application-Identifier to default ?');
		if(con){
			document.frmProtocolGroup.appmode.value=<%=ApplicationModes.RESET_PROTOCOL%>;	
			document.frmProtocolGroup.submit();
		}	
	}
	function handleIdentifier(){
		handleThickBox('2','applicationIdentifier');
		URL = oldURL;
		submitForm('application');
		document.getElementById('applicationIdentifier').style.display = 'none';
		handleThickBox('1','application');
	}
	</SCRIPT>
</HEAD>
<BODY>
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>
<div class = "maincontent" id="main_content">
	<div class="reporttitlebar">
		<div class="reporttitlebarleft"></div>
		<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Application Groups")%></div>
	</div>
	<br /><br />
<%
	ProtocolGroupBean protocolGroupBean = null;
	ApplicationNameBean applicationNameBean = null;
	ProtocolIdentifierBean protocolIdentifierBean = null;
	LinkedHashMap protocolGroupMap=null,applicationNameMap=null,protocolIdentifierBeanMap=null;
	Iterator protocolGroupIterator=null,applicationNameIterator=null,protocolIdentifierBeanIterator=null;
	protocolGroupMap = ProtocolGroupBean.getProtocolGroupMap();
%>	
<FORM method="POST" name="frmProtocolGroup" action="<%=request.getContextPath()%>/iview">
<input type="hidden" name="id" value ="-1">
<input type="hidden" name="appmode" value ="-1">
<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin-bottom: 2px;margin-left:2px;">
	<tr>
		<td align="left" class="ButtonBack">
			<input class="criButton" type="button" onClick="openAddApplicationName('');" value="<%=TranslationHelper.getTranslatedMessge("Add Application")%>">
			<input class="criButton" type="button" onClick="openAddProtocolGroup('');" value="<%=TranslationHelper.getTranslatedMessge("Add Application Group")%>">
			<input class="criButton" type="button" onClick="resetToDefault('');" value="<%=TranslationHelper.getTranslatedMessge("Reset to Default")%>">
		</td>
	</tr>
	</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top: 2px;margin-left:2px;">
 <%
	if(!"".equals(pmessage)){
%>
	<tr>
		<td class="posimessage" colspan="4">&nbsp;&nbsp;<%=pmessage%></td>
	</tr>
<%
	}
%>
<%
	if(!"".equals(nmessage)){
%>
	<tr>
		<td class="nagimessage" colspan="4">&nbsp;&nbsp;<%=nmessage%></td>
	</tr>
<%
	}
%>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="TableData">
			<tr>
				<td class="tdhead">&nbsp;</td>
				<td class="tdhead" width="20%"><%=TranslationHelper.getTranslatedMessge("Application Groups")%></td>
				<td class="tdhead"><%=TranslationHelper.getTranslatedMessge("Description")%></td>
				<td class="tdhead" width="8%" align="center"><%=TranslationHelper.getTranslatedMessge("Delete")%></td>
			</tr>
			<%
				if(protocolGroupMap != null && protocolGroupMap.size() > 0){
						protocolGroupIterator = protocolGroupMap.values().iterator();
						int grpCounter = 0;
						String rowStyle = "";
						String tdStyle="";
						String astyle="";
						while(protocolGroupIterator.hasNext()){
							grpCounter++;							
							if(grpCounter%2 == 0)
									rowStyle = "trdark";
								else
									rowStyle = "trlight";
							protocolGroupBean=(ProtocolGroupBean)protocolGroupIterator.next();
							if(protocolGroupBean.getIsDefault()==ProtocolGroupBean.ISDEFAULT){
								tdStyle="tddata";
								astyle="";
							}else{
								tdStyle="tddatablue";
								astyle="style=color:#2388C7;";
							}
			%>
						<tr class="<%=rowStyle%>">
							<td class="tddata" align="center" width="5%">
								<input type="hidden" id="<%="0_1_"+ grpCounter%>" value="<%=request.getContextPath()%>/images/collapse.gif" />
								<img id="<%="1_1_"+ grpCounter%>" src="<%=request.getContextPath()%>/images/inactiveexpand.gif" onClick="changeImg(this.id);" style="cursor: pointer;" />
							</td>								
							<td class="<%=tdStyle%>">
								<a  <%=astyle%> href="#" <%=astyle%> title="<%=protocolGroupBean.getDescription()%>" onClick="openAddProtocolGroup('<%=protocolGroupBean.getProtocolgroupId()%>');" > <%=protocolGroupBean.getProtocolGroup()%> </A>
							</td>
							<td class="<%=tdStyle%>"><%=protocolGroupBean.getDescription()==null?" ":protocolGroupBean.getDescription()%></td>
							<%
								if(protocolGroupBean.getProtocolgroupId() == ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP){
							%>
								<td class="<%=tdStyle%>" align="center">&nbsp;</td>
							<%
								} else {
							%>
								<td class="<%=tdStyle%>" align="center"><img src="<%=request.getContextPath()%>/images/false.gif" title="Disable" onClick="deleteProtocolGroup(<%=protocolGroupBean.getProtocolgroupId()%> ,'<%=protocolGroupBean.getProtocolGroup()%>')" ></td>
							<%
								}
							%>
							
						</tr>
						<tr class="trlight" id="1_<%=grpCounter%>_0" style="display: none;">
							<td class="tddata">&nbsp;</td>
							<td colspan="2" class="tddata">
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td class="tdhead">&nbsp;</td>
									<td class="tdhead" colspan="2"><%=TranslationHelper.getTranslatedMessge("Application")%></td>
								</tr>
						<%
							applicationNameMap=ApplicationNameBean.getApplicationNameBeanMap(protocolGroupBean.getProtocolgroupId());
										if(applicationNameMap !=null && applicationNameMap.size() > 0){
											applicationNameIterator=applicationNameMap.values().iterator();
											int protoCounter = 0;
											String protoRowStyle = "";
											String ptdStyle="";
											String pastyle="";
											while(applicationNameIterator.hasNext()){
												protoCounter++;
												if(protoCounter%2 == 0)
													protoRowStyle = "trdark";
												else
													protoRowStyle = "trlight";
												applicationNameBean=(ApplicationNameBean)applicationNameIterator.next();
												if(applicationNameBean.getIsDefault()==ApplicationNameBean.ISDEFAULT){
													ptdStyle="tddata";
													pastyle="";
												}else{
													ptdStyle="tddatablue";
													pastyle="style=color:#2388C7;";
												}
												
						%>
								<tr class="<%=protoRowStyle%>">
									<td class="<%=ptdStyle%>" align="center" width="5%">
										<input type="hidden" id="0_2_<%=grpCounter + "_" + protoCounter%>" value="<%=request.getContextPath()%>/images/collapse.gif" />
										<img id="1_2_<%=grpCounter + "_" + protoCounter%>" src="<%=request.getContextPath()%>/images/inactiveexpand.gif" onClick="changeImg(this.id);" style="cursor: pointer;" />
									</td>
									<td class="<%=ptdStyle%>"><A <%=pastyle%> href="#" onClick="openAddApplicationName('<%=applicationNameBean.getApplicationNameId()%>')" ><%=applicationNameBean.getApplicationName()%> </A></td>
									<td class="<%=ptdStyle%>" width="8%" align="center"><img src="<%=request.getContextPath()%>/images/false.gif" title="Disable" onClick="deleteApplicationName( <%=applicationNameBean.getApplicationNameId()%> ,'<%=applicationNameBean.getApplicationName()%> ')"></td>							
								</tr>
								<tr class="trdark" id="2_<%=grpCounter + "_" + protoCounter%>_0" style="display: none;">
									<td class="tddata" colspan="3">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" class="TableData">
						<%
							protocolIdentifierBeanMap = ProtocolIdentifierBean.getProtocolIdentifierBeanMap(applicationNameBean.getApplicationNameId());
												if(protocolIdentifierBeanMap !=null && protocolIdentifierBeanMap.size() > 0){
													protocolIdentifierBeanIterator=protocolIdentifierBeanMap.values().iterator();
													String protocolIdentifierTdStyle="";
													while(protocolIdentifierBeanIterator.hasNext()){
														protocolIdentifierBean=(ProtocolIdentifierBean)protocolIdentifierBeanIterator.next();
														if(protocolIdentifierBean.getIsDefault()!=ProtocolIdentifierBean.ISDEFAULT) {
															protocolIdentifierTdStyle="tddatablue";
														}else{
															protocolIdentifierTdStyle="tddata";
														}
														String identifier="";
														if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.ICMP)
															identifier="icmp/"+protocolIdentifierBean.getPort();
														else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.TCP)
															identifier="tcp/"+protocolIdentifierBean.getPort();
														else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.UDP)
															identifier="udp/"+protocolIdentifierBean.getPort();
						%>
									<tr class="trlight">
										<td class="tddata" width="5%">&nbsp;</td>
										<td class="<%=protocolIdentifierTdStyle%>"><%=identifier%></td>
									</tr>
						<%
							}
												} else {
						%>
									<tr class="trlight">
										<td class="tddata" width="5%">&nbsp;</td>
										<td class="tddata"><%=TranslationHelper.getTranslatedMessge("No Identifiers")%></td>
									</tr>
						<%
							}
						%>
									</table>
									</td>
									</tr>
						<%
							}
										}
						%>
							</table>
							</td>
							<td>&nbsp;</td>
						</tr>
						
				<%
											}
												}else{
										%>
					<td colspan="2"><%=TranslationHelper.getTranslatedMessge("No Application Group exists.")%></td></tr>
				<%
				}
				%>
			</table>
		</td>
	</tr>
</table>
</FORM>
</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
<div id="protogrp2" class="protoGrp" style="display: none;" ></div>
<div class="TB_window" id="protocolgrp"></div>
<div class="TB_window" id="application"></div>
<div class="TB_window" id="applicationIdentifier"></div>
</BODY> 
</HTML>
<%
	} catch(Exception e){
		CyberoamLogger.appLog.info("Exception in protocolgroup.jsp");
	}
%>
