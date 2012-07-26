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
<%
	try{
	if(CheckSession.checkSession(request,response)<0)
		return;
	DeviceBean.checkForNewDevice();	
	
	boolean allDevices = true;
	String pmessage = "";
	String nmessage = "";
	if(request.getParameter("alldevice") != null && "false".equalsIgnoreCase(request.getParameter("alldevice"))){
		allDevices = false;
	}
	String[] statusImg = new String[6];
	statusImg[0] = "new.jpg";
	statusImg[1] = "user.jpg";
	statusImg[2] = statusImg[4] = "true.gif";
	statusImg[3] = statusImg[5] = "false.gif";
	
	String[] rowTitle = new String[6];
	rowTitle[0] = TranslationHelper.getTranslatedMessge("New Device Discoverd");
	rowTitle[1] = TranslationHelper.getTranslatedMessge("Pending Decision by User");
	rowTitle[2] = rowTitle[4] = TranslationHelper.getTranslatedMessge("Active Device");
	rowTitle[3] = rowTitle[5] = TranslationHelper.getTranslatedMessge("Deactive Device");
	
	String appmode = request.getParameter("appmode");
	int iMode = -1;
	if(appmode != null && !"null".equalsIgnoreCase(appmode)){
		iMode = Integer.parseInt(appmode);
	}
	String strStatus = request.getParameter("status");
	int iStatus = -1;
	if(strStatus != null && !"null".equalsIgnoreCase(strStatus)){
		iStatus = Integer.parseInt(strStatus);
	}
	if(iMode == ApplicationModes.MANAGE_DEVICE && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Device updated successfully.");
	}else if(iMode == ApplicationModes.MANAGE_DEVICE && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Duplicate devicename or appliance ID");
	}else if(iMode == ApplicationModes.MANAGE_DEVICE){
		nmessage = TranslationHelper.getTranslatedMessge("Error in device updation.");
	}else if(iMode == ApplicationModes.NEW_DEVICE && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Device added successfully.");
	}else if(iMode == ApplicationModes.NEW_DEVICE && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Duplicate device name or appliance ID or device with same IP Address and Device Type.");
	}else if(iMode == ApplicationModes.NEW_DEVICE){
		nmessage = TranslationHelper.getTranslatedMessge("Error in device addition.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE && iStatus > 0){
		pmessage = iStatus + " " + TranslationHelper.getTranslatedMessge("Device deleted successfully.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Device relation exist with Device Group.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE && iStatus == -5){
		nmessage = TranslationHelper.getTranslatedMessge("Device relation exist with Report Notification.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE && iStatus == -6){
		nmessage = TranslationHelper.getTranslatedMessge("Device relation exist with User.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Device deletion.");
	}
%>

<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceTypeBean"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean"%><HTML>
<HEAD>
	<TITLE><%=iViewConfigBean.TITLE%></TITLE>
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<LINK rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reports.css" />
	<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/utilities.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/ipvalidation.js"></SCRIPT>
<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/popupform.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript">
		var deviceid = '';
		window.onload = function (evt) {
			setWidth();
		}		
		function setWidth(){
			var main_div = document.getElementById("main_content");	
			main_div.style.width = (document.body.clientWidth - 217);	
		}
		
		function submitForm(){
			var devIdList = document.frmdevicemgt.deviceidlist;
			devIdList.value = devIdList.value.substring(0,devIdList.value.lastIndexOf(','));
			if(confirm('<%=TranslationHelper.getTranslatedMessge("Are you sure you want to save changes?")%>')){
				document.frmdevicemgt.submit();
			}
		}
		
		function addToList(deviceId){
			document.frmdevicemgt.deviceidlist.value += (deviceId + ',');
		}
		
		function selectall(){
			var chk = document.getElementById("check1");
			var checkstmp = document.getElementsByName("select");
			var i;
			for(i=0;i<checkstmp.length;i++){
				if(chk.checked==true){
					checkstmp[i].checked=true;
				}
				else{
					checkstmp[i].checked=false;
				}
			}
		}


		function deselectall(){
			var chk = document.getElementById("check1");
			var checkstmp = document.getElementsByName("select");
			var i;
			for(i=0;i<checkstmp.length;i++){
				if(checkstmp[i].checked==false){
					chk.checked=false;
					break;
				}
			}
		}
		
		function validateDelete(){
			elements = document.frmdevicemgt.select;
			flag = false ;
			if(elements.length == undefined){
				flag = true;
			} else
				for( i=0;i<elements.length ; i++ ){
					if( elements[i].checked == true ){
						flag = true ;
						break;
					}
				}
			if(!flag){
				alert("<%=TranslationHelper.getTranslatedMessge("You must select atleast one device")%>");
				return false;
			}
			var con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected Devices(s)?")%>");
			if (! con ){ 
				return false ;
			}
			document.frmdevicemgt.appmode.value = '<%=ApplicationModes.DELETE_DEVICE%>';
			document.frmdevicemgt.submit();
		}
		function openAddDevice(id){
			if(id == ''){
				URL = '<%=request.getContextPath()%>/webpages/editdevice.jsp';
			} else {
				URL = '<%=request.getContextPath()%>/webpages/editdevice.jsp?deviceid='+id;
			}
			handleThickBox(1,'deviceform',"500");
		}
		function validateForm(){
			form = document.frmeditdevice;
			reExp = new RegExp("^[0-9a-zA-Z][0-9a-zA-Z_.@]*$");
			nameReExp = new RegExp("^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$");
			
			if(form.appmode.value == <%=ApplicationModes.NEW_DEVICE%>){
				if (trim(document.frmeditdevice.applianceid.value) == ''){
					alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Appliance ID")%>');
					form.applianceid.focus();
					return false;
				}
				if(!isValidIP(form.ip.value)){
					alert('<%=TranslationHelper.getTranslatedMessge("Please Enter valid IP Address.")%>');
					return false;
				}
			}
			if (document.frmeditdevice.devicename.value == ''){
				alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Device Name")%>');
				document.frmeditdevice.devicename.focus();
				return false;
			}else if (!nameReExp.test(document.frmeditdevice.devicename.value)){
				alert("<%=TranslationHelper.getTranslatedMessge("alpha numeric characters, '_', '-', '@', ' ' and '.' allowed in Device Name")%> ");
				document.frmeditdevice.devicename.focus();
				return false;
			}
			if(form.appmode.value == <%=ApplicationModes.NEW_DEVICE%>){
				con = confirm("Are you sure you want to add the device?");
			} else {
				con = confirm("Are you sure you want to update the device?");
			}
			return con;
		}
		function deleteDevice(devId){
			form = document.frmdevicemgt;
			var con = confirm('<%=TranslationHelper.getTranslatedMessge("Are you sure you want to delete device?")%>');
			if (con){
				form.appmode.value = '<%=ApplicationModes.DELETE_DEVICE%>';
				form.deviceid.value = devId;
				form.submit();
			}
		}
	</SCRIPT>
</HEAD>
<BODY>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
	<jsp:include page="pageheader.jsp" flush="true">
		<jsp:param name="setdevice"	value="false"></jsp:param>
	</jsp:include>
	
	<div class="maincontent" id="main_content">
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Device Management")%></div>
		</div>
	<br /><br />
	<FORM method="POST" name="frmdevicemgt" action="<%=request.getContextPath()%>/iview">
	<input type="hidden" name="appmode" value="<%=ApplicationModes.MANAGE_DEVICE%>">
	<input type="hidden" name="deviceidlist" value="">
	<input type="hidden" name="deviceid" value="">
	<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin-bottom: 2px;margin-left:2px;">
	<tr>
		<td align="left" class="ButtonBack">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Add")%>" onClick="openAddDevice('');">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Delete")%>" onclick="return validateDelete()">
		</td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top: 2px;margin-left:2px;">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="TableData">
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
				<td align="center" class="tdhead"><input type=checkbox name=check1 id="check1" onClick="selectall()"></td>
				<td class="tdhead" align="center" width="6%"><%=TranslationHelper.getTranslatedMessge("Current Status")%></td>
				<td class="tdhead" width="30%"><%=TranslationHelper.getTranslatedMessge("Device Name")%></td>
				<td class="tdhead" width="30%"><%=TranslationHelper.getTranslatedMessge("IP Address")%></td>
				<td class="tdhead" width="30%"><%=TranslationHelper.getTranslatedMessge("Device Type")%></td>
				<td class="tdhead"><%=TranslationHelper.getTranslatedMessge("Status")%></td>
				
			</tr>
<%
	Iterator newdeviceBeanItr=DeviceBean.getNewDeviceBeanIterator();
	Iterator deviceBeanItr = DeviceBean.getAllDeviceBeanIterator();
	DeviceBean deviceBean = null;
	int deviceCnt = 0;
	String rowStyle = "trdark";
	if(newdeviceBeanItr.hasNext()){
		while(newdeviceBeanItr.hasNext()){
		deviceBean = (DeviceBean)newdeviceBeanItr.next();
		if(!allDevices && deviceBean.getDeviceStatus()!=DeviceBean.NEW)
			continue;
		deviceCnt++;
		out.println("<script>addToList("+deviceBean.getDeviceId()+")</script>");
		if(deviceCnt%2 == 0)
	rowStyle = "trdark";
		else 
	rowStyle = "trlight";
%>
			<tr class="<%=rowStyle%>" title="<%=rowTitle[deviceBean.getDeviceStatus()]%>">
				<td class="tddata" align="center" title="<%=TranslationHelper.getTranslatedMessge("Delete Device")%>"><!-- <img src="<%=request.getContextPath() + "/images/delete.bmp"%>" onclick="deleteDevice('<%=deviceBean.getDeviceId()%>')" width="25px" height="20px"/> -->
				<input type="checkbox" name="select" value="<%=deviceBean.getDeviceId()%>" >
				</td>
				<td class="tddata" align="center">
					<img src="<%=request.getContextPath() + "/images/" + statusImg[deviceBean.getDeviceStatus()]%>" height="15" width="15" />
				</td>
				<td class="tddata"><a class="configLink" href="#" onclick="openAddDevice('<%=deviceBean.getDeviceId()%>')" ><%=deviceBean.getName()==null || deviceBean.getName().equals("") ? "N/A" : deviceBean.getName()%></a></td>
				<td class="tddata"><%=deviceBean.getIp() != null?deviceBean.getIp():""%></td>
				<td class="tddata" align="center">
					<select name="devicetype<%=deviceBean.getDeviceId()%>">
<%
				DeviceTypeBean deviceTypeBean = null;
				Iterator deviceTypeBeanItr = DeviceTypeBean.getDeviceTypeBeanIterator();
				while(deviceTypeBeanItr.hasNext()){
					deviceTypeBean = (DeviceTypeBean)deviceTypeBeanItr.next();
					if(deviceTypeBean!=null){
%>					<option value="<%= deviceTypeBean.getDeviceTypeId() %>" <%= (deviceBean.getDeviceType()==deviceTypeBean.getDeviceTypeId())?"selected=\"selected\"":"" %> ><%= deviceTypeBean.getTypeName() %></option>
<%
					}
				}
%>					</select>
				</td>
				<td class="tddata">
					<input type="radio" name="devicestatus<%=deviceBean.getDeviceId()%>" value="<%=DeviceBean.ACTIVE%>" <%=deviceBean.getDeviceStatus()==DeviceBean.ACTIVE || deviceBean.getDeviceStatus()==DeviceBean.NEW ?"checked=\"checked\"":""%>  /> <%=TranslationHelper.getTranslatedMessge("Active")%>&nbsp;&nbsp;
					<input type="radio" name="devicestatus<%=deviceBean.getDeviceId()%>" value="<%=DeviceBean.DEACTIVE%>" <%=deviceBean.getDeviceStatus()==DeviceBean.DEACTIVE?"checked=\"checked\"":""%> /><%=TranslationHelper.getTranslatedMessge("Deactive")%> &nbsp;&nbsp;
				</td>
				
			</tr>
<%
	
		}	
	}
	while(deviceBeanItr.hasNext()){
		deviceBean = (DeviceBean)deviceBeanItr.next();
		if(!allDevices && deviceBean.getDeviceStatus()!=DeviceBean.NEW)
			continue;
		deviceCnt++;
		out.println("<script>addToList("+deviceBean.getDeviceId()+")</script>");
		if(deviceCnt%2 == 0)
	rowStyle = "trdark";
		else 
	rowStyle = "trlight";
%>
			<tr class="<%=rowStyle%>" title="<%=rowTitle[deviceBean.getDeviceStatus()]%>">
				<td class="tddata" align="center" title="<%=TranslationHelper.getTranslatedMessge("Delete Device")%>"><!-- <img src="<%=request.getContextPath() + "/images/delete.bmp"%>" onclick="deleteDevice('<%=deviceBean.getDeviceId()%>')" width="25px" height="20px"/> -->
				<input type="checkbox" name="select" value="<%=deviceBean.getDeviceId()%>"  onclick="deselectall()">
				</td>
				<td class="tddata" align="center">
					<img src="<%=request.getContextPath() + "/images/" + statusImg[deviceBean.getDeviceStatus()]%>" height="15" width="15" />
				</td>
				<td class="tddata"><a class="configLink" href="#" onclick="openAddDevice('<%=deviceBean.getDeviceId()%>')" ><%=deviceBean.getName()==null || deviceBean.getName().equals("") ? "N/A" : deviceBean.getName()%></a></td>
				<td class="tddata"><%=deviceBean.getIp() != null?deviceBean.getIp():""%></td>
				<td class="tddata" align="center">
					<select name="devicetype<%=deviceBean.getDeviceId()%>" disabled='disabled'>
<%
				DeviceTypeBean deviceTypeBean = null;
				Iterator deviceTypeBeanItr = DeviceTypeBean.getDeviceTypeBeanIterator();
				while(deviceTypeBeanItr.hasNext()){
					deviceTypeBean = (DeviceTypeBean)deviceTypeBeanItr.next();
					if(deviceTypeBean!=null){
%>					<option value="<%= deviceTypeBean.getDeviceTypeId() %>" <%= (deviceBean.getDeviceType()==deviceTypeBean.getDeviceTypeId())?"selected=\"selected\"":"" %> ><%= deviceTypeBean.getTypeName() %></option>
<%
					}
				}
%>					</select>
				</td>
				<td class="tddata">
					<input type="radio" name="devicestatus<%=deviceBean.getDeviceId()%>" value="<%=DeviceBean.ACTIVE%>" <%=deviceBean.getDeviceStatus()==DeviceBean.ACTIVE || deviceBean.getDeviceStatus()==DeviceBean.NEW ?"checked=\"checked\"":""%>  /> <%=TranslationHelper.getTranslatedMessge("Active")%>&nbsp;&nbsp;
					<input type="radio" name="devicestatus<%=deviceBean.getDeviceId()%>" value="<%=DeviceBean.DEACTIVE%>" <%=deviceBean.getDeviceStatus()==DeviceBean.DEACTIVE?"checked=\"checked\"":""%> /><%=TranslationHelper.getTranslatedMessge("Deactive")%> &nbsp;&nbsp;
				</td>
				
			</tr>
<%
	}
	if(deviceCnt == 0){
%>
		<tr class="trdark">
			<td class="tddata" colspan="5" align="center"><%=TranslationHelper.getTranslatedMessge("Device(s) Not Available")%></td>
		</tr>
		</table>
		</td>
	</tr>
<%	} else { 	%>
</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><input class="criButton" type="button" name="Add" value="<%=TranslationHelper.getTranslatedMessge("Save")%>" onclick="submitForm()" /></td>
	</tr>
<%	}
	} catch(Exception e){
		CyberoamLogger.appLog.debug("ManageDevice.jsp=>exception:"+e,e);
		
	}
	
	%>
	
	</table>
	</form>
	</div>
	<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
<div class="TB_window" id="deviceform"></div>
	
</body>
</html>
