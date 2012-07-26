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
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.authentication.beans.RoleBean"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupBean"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupRelationBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean"%>
<%@page import="org.cyberoam.iview.beans.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<html>
<head>
<%
	if(CheckSession.checkSession(request,response) < 0) return;
	try{
	
%>
<%
		int catId=Integer.parseInt(session.getAttribute("categoryid").toString());		
		DeviceBean deviceBean = null;
		String deviceList="[";
		
		String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(Integer.parseInt(session.getAttribute("categoryid").toString()));
		
		if(deviceIds!= null && deviceIds.length > 0){
			for(int i=0;i<deviceIds.length;i++){
				deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));				
				deviceList += "\""+deviceBean.getName()+"|"+deviceBean.getDeviceId()+"\",";
			}
			deviceList = deviceList.substring(0,deviceList.length()-1);
		}
		
		deviceList += "]";		
	%>
	

<TITLE><%=iViewConfigBean.TITLE%></TITLE>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/popup.css">
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popup.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popupform.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="/javascript/cyberoam.js"></script>
<script language="JavaScript"> 
	window.onload = function (evt) {
		setWidth();				
	}		
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 220);	
	}
	
	
	function openAddDeviceGroup(id,deviceList){
		deviceListJS = <%=deviceList%>;
		if(id == ''){
			URL = '<%=request.getContextPath()%>/webpages/newdevicegroup.jsp';
		} else {			

			var devList= deviceList.split(",");
			deviceListJS=devList;
			URL = '<%=request.getContextPath()%>/webpages/newdevicegroup.jsp?devicegroupname='+id;
		}
		handleThickBox(1,'devicegroup','450');
		//top.sourceWindow=window.open(reqloc,'_person','width=570,height=480,titlebar=no,scrollbars=yes');
	}
	
	function initdevicegroup(){
		var selval = document.getElementById("selecteddevice").value;
		if(selval != ""){
			selval = selval.split(",");
			createPopUp("devicelist",["Device|1|0"],'Device',selval);
		}else{
			createPopUp("devicelist",["Device|1|0"]);
		} 
	}

	function showHideDeviceInfo(){
		var role = document.getElementById('role');
		var selIndex = role.selectedIndex;
		if(role.options[selIndex].text == 'Admin'){
			document.getElementById('deviceinfo').style.display='none';
		}else{
			document.getElementById('deviceinfo').style.display='';
		}
	}

	function selectall(){
		var chk = document.getElementById("check1");
		var checkstmp = document.getElementsByName("devicegroupids");
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
		var checkstmp = document.getElementsByName("devicegroupids");
		var i;
		for(i=0;i<checkstmp.length;i++){
			if(checkstmp[i].checked==false){
				chk.checked=false;
				break;
			}
		}
	}

	function validateFrom(){
		reExp = new RegExp("^[0-9a-zA-Z][0-9a-zA-Z_.@]*$");
		nameReExp = new RegExp("^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$");
		emailExp = /^\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)+$/ ;
		form=document.registrationform;
		var isUpdate = false;
		
		if(document.getElementById("operation").value == 'update'){
			isUpdate = true;
		}
		
		if (document.registrationform.grpname.value == ''){
			alert('<%=TranslationHelper.getTranslatedMessge("You must enter the Device Group Name")%>');
			document.registrationform.grpname.focus();
			return false;
		}else if (!nameReExp.test(document.registrationform.name.value)){
			alert("<%=TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Device Group Name")%>");
			document.registrationform.name.focus();
			return false;
		}
		
 
		//if(document.registrationform.role.value != '<%=RoleBean.ADMIN_ROLE_ID%>' ){
		var selecteddevice = getCheckedIds("devicelist");
		if(selecteddevice == ''){
			alert("<%=TranslationHelper.getTranslatedMessge("Select atleast one device.")%>");
			return false;			
		}else {
			document.getElementById("selecteddevice").value = selecteddevice;
		}
		//}
		if(isUpdate == true){
			form.appmode.value = '<%=ApplicationModes.UPDATE_DEVICE_GROUP%>';
			con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to update the Device Group?")%>");
		}else {
			con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to add the Device Group?")%>");
		}
		return con;
	}//function validate form ends here
	
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
	}
	
	function validateDelete(){
		elements = document.managedevicegroup.elements;
		flag = false ;
		for( i=0,j=elements.length ; i < j ; i++ ){
			if(elements[i].name == "devicegroupids"){
				if( elements[i].checked == true ){
					flag = true ;
					break;
				}
			}
		}
		if(!flag){
			alert("<%=TranslationHelper.getTranslatedMessge("You must select atleast one Device Group")%>");
			return false;
		}
		var con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected Device Group(s)?")%>");
		if (! con ){ 
			return false ;
		}
		document.managedevicegroup.submit();
	}
	
	function getDevicesByCategory()
	{
		var id=document.getElementById("catId").value;
		var selval=document.getElementById("devicelist");
		var div=document.getElementById("popupdevicelist").parentNode;
		var olddiv=document.getElementById("popupdevicelist");
		div.removeChild(olddiv);		
		selval.innerHTML="";			
		
		var devList;
		var cnt;
<%
		Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
		CategoryBean categoryBean= null;
		while(categoryBeanItr.hasNext()){	
			categoryBean = (CategoryBean)categoryBeanItr.next();
%>
			if(id == <%=categoryBean.getCategoryId()%>){
							
				devList=new Array();
				cnt=0;
<%				
				deviceIds = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryBean.getCategoryId());									
				if(deviceIds!= null && deviceIds.length > 0){
					for(int i=0;i<deviceIds.length;i++){
						deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));					
%>
						devList[cnt++] = "<%=deviceBean.getName()%>|<%=deviceBean.getDeviceId()%>";
<%				
					}					
				}
%>
			}							
<%		} 	%>	
		deviceListJS = devList;
		initdevicegroup();					
	}

</script>
</head>
<body>
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>
<div class = "maincontent" id="main_content">
	<div class="reporttitlebar">	
		<div class="reporttitlebarleft"></div>				
		<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Device Group Management")%></div>			
	</div>		
	<br><br>	
	
		
	<form action="<%=request.getContextPath()%>/iview" method=post name=managedevicegroup >
	
	<input type=hidden name=appmode value=<%=ApplicationModes.DELETE_DEVICE_GROUP%>>
	
	<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin-bottom: 2px;margin-left:2px;">
	<tr>
		<td align="left" class="ButtonBack">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Add")%>" onClick="openAddDeviceGroup('');">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Delete")%>" onClick="return validateDelete();">
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
				<td align="center" class="tdhead"><input type=checkbox id="check1" name="check1" onClick="selectall()"></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Device Group")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Description")%></td>
				<td align="left" class="tdhead"><%=TranslationHelper.getTranslatedMessge("Device Name(s)")%></td>
			</tr>
			
<%
				Iterator itrDeviceGroup = DeviceGroupBean.getDeviceGroupBeanIterator();
				DeviceGroupBean deviceGroupBean = null;
				DeviceGroupRelationBean deviceGroupRelationBean = new DeviceGroupRelationBean();
				ArrayList deviceListArray = null;			
				String strDeviceList = "";
				int deviceGrpNum = 0;
				boolean oddRow = false;
				String rowStyle = "trdark";
				
				while(itrDeviceGroup.hasNext()){
					deviceGrpNum++;
					oddRow = !oddRow;
					if(oddRow)
						rowStyle = "trdark";
					else
						rowStyle = "trlight";				
					
					strDeviceList = "";
					deviceGroupBean = (DeviceGroupBean) itrDeviceGroup.next();
					catId=deviceGroupBean.getCategoryID();
										
					deviceBean = null;
					deviceList="";					
					deviceIds = UserCategoryDeviceRelBean.getDeviceIdListForCategory(catId);					
					if(deviceIds!= null && deviceIds.length > 0){												
						for(int i=0;i<deviceIds.length;i++){							
							deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));						
							deviceList += deviceBean.getName()+"|"+deviceBean.getDeviceId()+",";							
						}
						deviceList = deviceList.substring(0,deviceList.length()-1);						
					}			
					
					deviceListArray = DeviceGroupRelationBean.getRelationByGroupID(deviceGroupBean.getGroupID());
									
					for(int i = 0;i< deviceListArray.size();i++) {					
						deviceGroupRelationBean = (DeviceGroupRelationBean) deviceListArray.get(i);
						strDeviceList += DeviceBean.getRecordbyPrimarykey(deviceGroupRelationBean.getDeviceID()).getName() + ",";
					}
					
			%>
				<tr class="<%=rowStyle%>">
					<td align="center" class="tddata" ><input type=checkbox name="devicegroupids" value="<%=deviceGroupBean.getGroupID()%>" onClick="deselectall()" ></td>
					<td align="left" class="tddata">
					<a title="Edit Device Group" class="configLink" href="#" onclick=openAddDeviceGroup('<%=deviceGroupBean.getGroupID()%>','<%=deviceList%>') ><%=deviceGroupBean.getName()%></a>				
					</td>				
					<td align="left" class="tddata"> <%=deviceGroupBean.getDescription()%> </td>
					<td align="left" class="tddata"><%=strDeviceList!=""?strDeviceList.substring(0,(strDeviceList.length()-1)):""%></td>
				</tr>
				<%
					} 
				if(deviceGrpNum == 0){
%>
				<tr class="trdark">
					<td class="tddata" colspan="4" align="center"><%=TranslationHelper.getTranslatedMessge("Device Group(s) Not Available")%></td>
				</tr>
<%				}	%>
				</table>
		</td>
	</tr>
	</table>
	
	</form>		
</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
<div class="TB_window" id="devicegroup"></div>
</body>
</html>

<%
	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in managedevicegroup.jsp : "+e,e);
}
%>
