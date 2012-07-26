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
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.authentication.beans.RoleBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="java.util.*"%>
<%@page import="org.cyberoam.iview.utility.MultiHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>

<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceTypeBean"%><html>
<%
	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		boolean isUpdate = false;
		DeviceBean deviceBean = null;
		if(request.getParameter("deviceid") != null && !request.getParameter("deviceid").equalsIgnoreCase("")){
			isUpdate = true;
			deviceBean = DeviceBean.getSQLRecordByPrimaryKey(Integer.parseInt(request.getParameter("deviceid")));
		}
		String header = TranslationHelper.getTranslatedMessge(isUpdate==true?"Update Device":"Add Device");
%>
<body>
<div>
<form action="<%=request.getContextPath()%>/iview" method="post" name="frmeditdevice" onsubmit="return validateForm();" >
	<input type="hidden" name="appmode" value="<%=isUpdate?ApplicationModes.MANAGE_DEVICE:ApplicationModes.NEW_DEVICE%>">
	<input type="hidden" name="deviceid" value="<%=isUpdate?deviceBean.getDeviceId():""%>">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">	
		<tr class="innerpageheader">
			<td width="3%">&nbsp;</td>
			<td class="contHead"><%=header%></td>
			<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
			<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','deviceform')" style="cursor: pointer;">
			</td>
		</tr>
	</table>
	<div style="margin:5px" align="center">
	<div style="width:95%;border:1px solid #999999;">
	<table cellpadding="2" cellspacing="2" width="100%" border="0" style="background:#FFFFFF;">
	<tr >
		<td class="textlabels" style="width:100px;" ><%=TranslationHelper.getTranslatedMessge("Device ID")%><font class="compfield">*</font></td>
		<td ><input type="text" name="applianceid" class="datafield" size="38" value="<%=isUpdate?deviceBean.getApplianceID():""%>" <%=isUpdate?"disabled=\"disabled\"":""%> /></td>
	</tr>
	<tr >
		<td class="textlabels"><%=TranslationHelper.getTranslatedMessge("Device Name")%><font class="compfield">*</font></td>
		<td ><input type="text" name="devicename" class="datafield" maxlength="50" value="<%=(isUpdate&&deviceBean.getName()!=null)?deviceBean.getName():""%>" size="38" ></td>
	</tr>
	<tr >
		<td class="textlabels"><%=TranslationHelper.getTranslatedMessge("IP Address")%><font class="compfield">*</font></td>
		<td ><input type="text" name="ip" class="datafield" size="38" value="<%=isUpdate && deviceBean.getIp() != null?deviceBean.getIp():""%>" /></td>
	</tr>
	<tr >
		<td class="textlabels"><%=TranslationHelper.getTranslatedMessge("Device Type")%><font class="compfield">*</font></td>
		<td>
			
			<select name="devicetype" <%=((isUpdate && deviceBean.getDeviceStatus()!=0)?"disabled=disabled":"")%>>
<%
				DeviceTypeBean deviceTypeBean = null;
				Iterator deviceTypeBeanItr = DeviceTypeBean.getDeviceTypeBeanIterator();
				while(deviceTypeBeanItr.hasNext()){
					deviceTypeBean = (DeviceTypeBean)deviceTypeBeanItr.next();
					if(deviceTypeBean!=null){
%>					<option value="<%= deviceTypeBean.getDeviceTypeId() %>" <%= (isUpdate && deviceBean.getDeviceType()==deviceTypeBean.getDeviceTypeId())?"selected=\"selected\"":"" %> ><%= deviceTypeBean.getTypeName() %></option>
<%
					}
				}
%>			</select>
		</td>
	</tr>
	<tr >
		<td class="textlabels"><%=TranslationHelper.getTranslatedMessge("Description")%></td>
		<td>
			<textarea rows="5" cols="35" class="datafield" name="description"><%=isUpdate?deviceBean.getDescription():""%></textarea>
		</td>
	</tr>
	<tr >
		<td class="textlabels"  style="height: 23px"><%=TranslationHelper.getTranslatedMessge("Status")%><font class="compfield">*</font></td>
		<td >
			<select name="devicestatus" size="1" class="datafield">		
			<%	if(isUpdate){ %>
				<option value="<%=DeviceBean.ACTIVE%>" <%=deviceBean.getDeviceStatus()==DeviceBean.NEW || deviceBean.getDeviceStatus()==DeviceBean.ACTIVE?"selected=\"selected\"":""%>><%=TranslationHelper.getTranslatedMessge("Active")%></option>
				<option value="<%=DeviceBean.DEACTIVE%>" <%=deviceBean.getDeviceStatus()!=DeviceBean.DEACTIVE?"":"selected=\"selected\""%> ><%=TranslationHelper.getTranslatedMessge("Deactive")%></option>				
			
			<%}else{ %>
				<option value="<%=DeviceBean.ACTIVE%>" selected="selected"><%=TranslationHelper.getTranslatedMessge("Active")%></option>
				<option value="<%=DeviceBean.DEACTIVE%>" ><%=TranslationHelper.getTranslatedMessge("Deactive")%></option>				
			<%}
			%>
			</select>
		</td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>
</table>
</div>
</div>
	<table align="center">
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="criButton" name="confirm" value="<%=TranslationHelper.getTranslatedMessge(isUpdate?"Update":"Add")%>" >
			<input type="button" class="criButton" value="<%=TranslationHelper.getTranslatedMessge("Cancel")%>" onclick="handleThickBox('2','deviceform')">
		</td>
	</tr>
	</table>
</form>	
</div>
</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.error("ERROR in edit device page :" + e,e);
}
%>
