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
<%@ page import="java.util.*" %>
<%@ page import="org.cyberoam.iview.utility.*" %>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.RoleBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupBean"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupRelationBean"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>



<%
	if(CheckSession.checkSession(request,response) < 0) return;
	try{		
		String userName=(String)session.getAttribute("username");
		int roleID=UserBean.getRecordbyPrimarykey(userName).getRoleId();	
		DeviceBean deviceBean = null;
		int userId = UserBean.getRecordbyPrimarykey(userName).getUserId();
				
		String deviceList="[";
		String strDeviceList[] = UserCategoryDeviceRelBean.getDeviceIdListForUser(userId);				
		if(strDeviceList != null && strDeviceList.length > 0){
			for(int i = 0; i<strDeviceList.length; i++){
				deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList[i]));
				if(deviceBean !=null)
					deviceList += "\""+deviceBean.getName()+"|"+deviceBean.getDeviceId()+"\",";
			}
		}
		
		DeviceGroupBean deviceGroupBean = null;
		String deviceGroupList="[";
		String strDeviceGroupList[] = UserCategoryDeviceRelBean.getDeviceGroupIdListForUser(userId);
		if(strDeviceGroupList != null && strDeviceGroupList.length > 0){
			for(int i = 0; i<strDeviceGroupList.length; i++){
				deviceGroupBean = DeviceGroupBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceGroupList[i]));				
				if(deviceGroupBean !=null)
					deviceGroupList += "\""+deviceGroupBean.getName()+"|"+deviceGroupBean.getGroupID()+"\",";
			}
		}
		
		if(!"[".equals(deviceList))
			deviceList = deviceList.substring(0,deviceList.length()-1) + "]";
		else 
			deviceList = deviceList + "]";
		
		if(!"[".equals(deviceGroupList))
			deviceGroupList = deviceGroupList.substring(0,deviceGroupList.length()-1) + "]";
		else 
			deviceGroupList = deviceGroupList + "]";		
%>
<html>
<head>
<TITLE><%=iViewConfigBean.TITLE%></TITLE>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/popup.css">
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popup.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popupform.js"></script>
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<script language="JavaScript"> 
	var deviceList = null;
	window.onload = function (evt) {
		setWidth();				
	}	
	var URL = "";	
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 218);	
	}
	re = /\w{1,}/;	
	
	function selectall(obj){ 
		var chk = document.getElementById("check1");
		var checkstmp = document.getElementsByName("usernames");
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
		var checkstmp = document.getElementsByName("usernames");
		var i;
		for(i=0;i<checkstmp.length;i++){
			if(checkstmp[i].checked==false){
				chk.checked=false;
				break;
			}
		}
	}
	
	function validateDelete(){
		elements = document.manageactiveusers.elements;
		flag = false ;
		for( i=0,j=elements.length ; i < j ; i++ ){
			if(elements[i].name == "usernames"){
				if( elements[i].checked == true ){
					flag = true ;
					break;
				}
			}
		}
		if(!flag){
			alert("<%=TranslationHelper.getTranslatedMessge("You must select atleast one user")%>");
			return false;
		}
		var con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected User(s)?")%>");
		if (! con ){ 
			return false ;
		}
		document.manageactiveusers.submit();
	}
	
	function openAddUser(id){
		deviceListJS = <%=deviceList%>;
		devicdGroupListJS = <%=deviceGroupList%>;		
		if(id == ''){
			URL = '<%=request.getContextPath()%>/webpages/newuser.jsp';
		} else {
			URL = '<%=request.getContextPath()%>/webpages/newuser.jsp?username='+id;
		}
		handleThickBox(1,'user','450',"10");
	}
	function inituser(){
		var	selval = document.getElementById("selecteddevices").value;
		var selgroupval = document.getElementById("selectedgroups").value;
		if(selval != ""){
			selval = selval.split(",");
			createPopUp("devicelist",["Device|1|0","Device Group|1|0"],'Device',selval);
		} else if(selgroupval != "") {
			selgroupval = selgroupval.split(",");
			createPopUp("devicelist",["Device|1|0","Device Group|1|0"],'Device Group',selgroupval);
		}else{
			createPopUp("devicelist",["Device|1|0","Device Group|1|0"]);
		} 
	}
	re = /\w{1,}/;
	userNameCheck= /^\w+(\w+)*(\.\w+(\w+)*)*$/ ;
	
	function validateFrom(){
		reExp = new RegExp("^[0-9a-zA-Z][0-9a-zA-Z_.@]*$");
		nameReExp = new RegExp("^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$");
		emailExp = /^\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)+$/ ;
		form=document.registrationform;
		var isUpdate = false;
		if(document.getElementById("operation").value == 'update'){
			isUpdate = true;
		}
		if (document.registrationform.name.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Name")%>');
			document.registrationform.name.focus();
			return false;
		}else if (!nameReExp.test(document.registrationform.name.value)){
			alert("<%=TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Name")%>");
			document.registrationform.name.focus();
			return false;
		}
		if(isUpdate == false){
			if (!(re.test(document.registrationform.username.value))){
				alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Username")%>');
				document.registrationform.username.focus();
				return false;
			}else if (!reExp.test(document.registrationform.username.value)){
				alert("<%=TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@' and '.' allowed in username")%>");
				document.registrationform.username.focus();
				return false;
			}
			if (document.registrationform.passwd.value == ''){
				alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Password")%>');
				document.registrationform.passwd.focus();
				return false;
			}
			if (document.registrationform.passwd.value != document.registrationform.confirmpasswd.value){
				alert('<%=TranslationHelper.getTranslatedMessge("The passwords you typed do not match")%>');
				document.registrationform.confirmpasswd.focus();
				return false;
			}
		}
		if(document.registrationform.email.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter email address")%>');
			document.registrationform.email.focus();
			return false;
		}
		if(!(emailExp.test(document.registrationform.email.value))){
			alert('<%=TranslationHelper.getTranslatedMessge("Invalid Email Address")%>');
			document.registrationform.email.focus();
			return false;
		}
		if(document.registrationform.role.value != <%= RoleBean.SUPER_ADMIN_ROLE_ID %>){
			var selecteddevice = getCheckedIds("devicelist");
			if(selecteddevice == ''){
				alert("<%=TranslationHelper.getTranslatedMessge("Select atleast one device.")%>");
				return false;			
			}else {
				document.getElementById("selecteddevices").value = selecteddevice;
			}
		}
		
		if(isUpdate == true){
			form.appmode.value = '<%=ApplicationModes.UPDATEUSER%>';
			con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to update User information?")%>");
		} else {
			con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to add the User?")%>");
		}
		if(con){
			document.registrationform.username.disabled = false;
		}
		return con;
	}//function validate form ends here

	function showHideDeviceInfo(){
		var role = document.getElementById('role');
		var selIndex = role.selectedIndex;
		if(role.options[selIndex].text == 'Admin'){
			document.getElementById('deviceinfo').style.display='none';
		}else{
			document.getElementById('deviceinfo').style.display='';
		}
	}

	function selectDevices(direction){
		var src;
		var dst;
		if(direction == 'right'){
			src = document.getElementById('availabledevices');
			dst = document.getElementById('selecteddevices');
		}else{
			dst = document.getElementById('availabledevices');
			src = document.getElementById('selecteddevices');
		}
		
		for(i=src.length-1;i>=0;i--) {
			if(src[i].selected==true) {
				ln=dst.length;
				dst.options[ln]=new Option(src.options[i].text,src.options[i].value,false,false);
				src.options[i]=null;
			}
		}	
	}
	function getRecord(id){
		if(id=="Device"){
			return data = deviceListJS;
		}
		if(id=="Device Group"){
			return data = devicdGroupListJS;
		}
	}
		
</script>
</head>
<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>  
	<div class="maincontent" id="main_content">
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("User Management")%></div>
		</div>
		<br /><br />
		
	<form action="<%=request.getContextPath()%>/iview" method=post name=manageactiveusers >
	<input type=hidden name=appmode value="<%=ApplicationModes.DELETEUSER%>">
	<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin-bottom: 2px;margin-left:2px;">
	<tr>
		<td align="left" class="ButtonBack">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Add")%>" onClick="openAddUser('');">
			<input class="criButton" type=button value="<%=TranslationHelper.getTranslatedMessge("Delete")%>" onClick="return validateDelete();">
		</td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top: 2px;margin-left:2px;">
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" width="100%" border="0" class="TableData">
<%
	if(session.getAttribute("pmessage") != null){
%>
			<tr><td colspan=7 align="left" class="posimessage"><%=session.getAttribute("pmessage")%></td></tr>
<%
	session.removeAttribute("pmessage");
	}
%>
<%
	if(session.getAttribute("nmessage") != null){
%>
			<tr><td colspan=7 align="left" class="nagimessage"><%=session.getAttribute("nmessage")%></td></tr>
<%
	session.removeAttribute("nmessage");
	}
%>
			<tr>
				<td align="center" class="tdhead"><input type=checkbox name="check1" id="check1" onClick="selectall(this)"></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Username")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Name")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Role")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Email")%></td>		
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Created By")%></td> 
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Last Login Time")%></td>
			</tr>
<%
	Iterator itrUser = UserBean.getUserBeanIterator();
	UserBean userBean = null;
	RoleBean roleBean = null;
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy h:mm:ss a");
	boolean oddRow = false;
	String rowStyle = "trdark";
	while(itrUser.hasNext()){
		oddRow = !oddRow;
		if(oddRow)
			rowStyle = "trdark";
		else
			rowStyle = "trlight";
		userBean = (UserBean) itrUser.next();
		
		if(roleID != RoleBean.SUPER_ADMIN_ROLE_ID && !userName.equalsIgnoreCase(userBean.getUserName()) && userBean.getRoleId() != RoleBean.VIEWER_ROLE_ID)		
			continue;
		
			
%>
			<tr class="<%= rowStyle %>">
<%
		if(userBean.getUserId() == 1 || userBean.getUserName().equals(session.getAttribute("username").toString())){
%>
				<td class="tddata" align="center"><input type=checkbox disabled="disabled" name=userIds value="<%=userBean.getUserId()%>" ></td>
<%
		}else{
%>
				<td class="tddata" align="center"><input type=checkbox id="usernames" name=usernames value="<%=userBean.getUserName()%>" onclick="deselectall()"></td>
<%		} %>
				<td class="tddata">
					<a title="Edit User" class="configLink" href="#" onclick="openAddUser('<%=userBean.getUserName() %>')" ><%=userBean.getUserName() %></a>
				</td>
				<td class="tddata"><%=userBean.getName() %></td>
		
<%
		roleBean = RoleBean.getRecordbyPrimarykey(userBean.getRoleId());
%>
				<td class="tddata"><%=roleBean.getRoleName() %></td>
				<td class="tddata"><%=userBean.getEmail() %></td>
				<td class="tddata"><%=userBean.getCreatedBy() %></td>
				<td class="tddata"><%=userBean.getLastLoginTime() == null ? "--NA--":simpleDateFormat.format(userBean.getLastLoginTime()) %></td>
			</tr>
<%	
	}	%>
			</table>
		</td>
	</tr>
	</table>
	</form>
</div>	
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
<div class="TB_window" id="user"></div>
</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.debug("manageuser.jsp : "+e,e);
}
%>
