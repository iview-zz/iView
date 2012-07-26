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
<%@page import="org.cyberoam.iview.utility.*,org.cyberoam.iview.*" %>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.authentication.beans.RoleBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean"%>
<%@page import="java.util.*"%>
<%@page import="org.cyberoam.iview.utility.MultiHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupBean"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<html>
<%
	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		boolean isUpdate = false;
		UserBean userBean = null;
		RoleBean roleBean = null;
		if(request.getParameter("username") != null){
	isUpdate = true;
	userBean = UserBean.getRecordbyPrimarykey(request.getParameter("username"));
		}
		String header = TranslationHelper.getTranslatedMessge(isUpdate==true?"Update User":"Add User");
%>
<head>
<title><%=iViewConfigBean.TITLE%></title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />

</head>
<body >
<div>
<form action="<%=request.getContextPath()%>/iview" method="post" name="registrationform" onSubmit="return validateFrom();">
<input type="hidden" name="appmode" value="<%=ApplicationModes.NEWUSER%>">
<table cellpadding="2" cellspacing="0" width="100%" border="0">	
	<tr class="innerpageheader">
		<td width="3%">&nbsp;</td>
		<td class="contHead"><%=header%></td>
		<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
		<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','user')" style="cursor: pointer;">
		</td>
	</tr>
</table>
<div style="margin:5px" align="center">
<div style="width:95%;border:1px solid #999999;">
	<table cellpadding="2" cellspacing="2" width="100%" align="center" style="background:#FFFFFF;">
<%
	if(session.getAttribute("message") != null){
%>
	<tr><td colspan="2" align="left" class="message"><%=session.getAttribute("message")%></td></tr>
<%
	session.removeAttribute("message");	
	}
%>
	
	<tr >
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Name")%><font class="compfield">*</font></td>
		<td ><input type="text" name="name" class="datafield" style="width:180px" maxlength="50" value="<%=isUpdate==true?userBean.getName():""%>"></td>
	</tr>
	<tr >
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Username")%><font class="compfield">*</font></td>
		<td ><input type="text" name="username" class="datafield" style="width:180px" maxlength="30" value="<%=isUpdate==true?userBean.getUserName():""%>" <%=isUpdate==true?"disabled":""%>></td>
	</tr>
	<tr >
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Password")%><font class="compfield"><%= isUpdate?"":"*" %></font></td>
		<td ><input type="password" name="passwd" class="datafield" style="width:180px" maxlength="30"  value="" /></td>
	</tr>
	<tr >
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Confirm Password")%><font class="compfield"><%= isUpdate?"":"*" %></font></td>
		<td ><input type="password" name="confirmpasswd" class="datafield" style="width:180px" maxlength="30" value=""></td>
	</tr>
	<tr>
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("E-mail")%><font class="compfield">*</font></td>
		<td ><input type="text" name="email" maxlength="100" class="datafield" style="width:180px" value="<%=isUpdate==true?userBean.getEmail():""%>">
	</tr>
	<tr>
		<td class="textlabels" style="height: 23px" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Role")%></td>
		<td>
			<select name="role" id="role" size="1" class="datafield" style="width:180px">
<%
	UserBean sessionUserBean = UserBean.getRecordbyPrimarykey(session.getAttribute("username").toString());
	Iterator itrRole = RoleBean.getRoleBeanIterator();
	if(isUpdate && userBean.getRoleId() == RoleBean.SUPER_ADMIN_ROLE_ID){
		roleBean = RoleBean.getRecordbyPrimarykey(RoleBean.SUPER_ADMIN_ROLE_ID);
%>
		<option value="<%=roleBean.getRoleId()%>"><%=roleBean.getRoleName()%></option>
<%
	} else {
		while(itrRole.hasNext()){
			roleBean = (RoleBean) itrRole.next();
			if(roleBean.getRoleId() > sessionUserBean.getRoleId() ) {
				if(isUpdate){
%>
				<option value="<%=roleBean.getRoleId()%>" <%=roleBean.getRoleId()==userBean.getRoleId()?"selected":""%> ><%=roleBean.getRoleName()%></option>
<%
				} else {
%>
					<option value="<%=roleBean.getRoleId()%>"><%=roleBean.getRoleName()%></option>
<%
				}
			} else if(isUpdate && sessionUserBean.getRoleId() == roleBean.getRoleId() && sessionUserBean.getUserId() == userBean.getUserId()){
%>
			<option value="<%=roleBean.getRoleId()%>"><%=roleBean.getRoleName()%></option>
<%
			}
		}
	}
%>		
			</select>
		</td>
	</tr>
<%
	if(isUpdate==false){
		roleBean = RoleBean.getRecordbyPrimarykey(RoleBean.ADMIN_ROLE_ID);
	} else {
		roleBean = RoleBean.getRecordbyPrimarykey(userBean.getRoleId());
	}
%>	
		<tr id="deviceinfo" style="display: <%=roleBean.getRoleId()==RoleBean.SUPER_ADMIN_ROLE_ID?"none":""%>">		
			<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Select Device")%><font class="compfield">*</font></td>
			<td>
		<div id="devicelist1" style="float:left;">
 			<div class="grouptext" id="devicelist" style="height:20px;*height:20px;float:left;margin-right:2px;margin-top:4px"></div>
 		</div>
 			</td>
		</tr>
</table>
</div>
<%
	String deviceListSel="";
	String deviceGroupListSel="";
	
	if(isUpdate){
		Iterator itrDevice = DeviceBean.getAllDeviceBeanIterator();
		DeviceBean deviceBean = null;
		while(itrDevice.hasNext()){
			deviceBean = (DeviceBean) itrDevice.next();
			if(UserCategoryDeviceRelBean.isRelationshipExistsWithDevice(userBean.getUserId(),deviceBean.getDeviceId())){
				deviceListSel += ""+deviceBean.getDeviceId()+",";	
			}
		}
		if(deviceListSel != "") {
			deviceListSel = deviceListSel.substring(0,(deviceListSel.length()-1));			
		}
		itrDevice = DeviceGroupBean.getDeviceGroupBeanIterator();
		DeviceGroupBean deviceGroupBean = null;
		
		while(itrDevice.hasNext()){
			deviceGroupBean = (DeviceGroupBean) itrDevice.next();				
			if(UserCategoryDeviceRelBean.isRelationshipExistsWithGroup(userBean.getUserId(),deviceGroupBean.getGroupID())){					
				deviceGroupListSel += ""+deviceGroupBean.getGroupID()+",";	
			}
		}
		if(deviceGroupListSel != "") {
			deviceGroupListSel = deviceGroupListSel.substring(0,(deviceGroupListSel.length()-1));			
		}
	}
%>
	<table align="center">
		<tr>
			<td colspan="2">
				<input type="hidden" id="selecteddevices" name="selecteddevices" value=<%=deviceListSel%> >
				<input type="hidden" id="selectedgroups" name="selectedgroups" value=<%=deviceGroupListSel%> >								
				<input type="hidden" id="operation" value=<%=isUpdate?"update":"Add"%> >
				<input type="submit" class="criButton" name="confirm" value=<%=TranslationHelper.getTranslatedMessge(isUpdate?"Update":"Add")%>>
				<input type="button" class="criButton" value="<%=TranslationHelper.getTranslatedMessge("Cancel")%>" onclick="handleThickBox('2','user')">
			</td>
		</tr>
	</table>
</form>	
</div>
</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.error("ERROR in new user page :" + e,e);
}
%>
