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
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupBean"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%>
<%@page import="org.cyberoam.iview.beans.CategoryBean"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupRelationBean"%>

<html>
<%
	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		boolean isUpdate = false;
		DeviceGroupBean deviceGroupBean = null;
		int categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());			
		if(request.getParameter("devicegroupname") != null){
			isUpdate = true;
			deviceGroupBean = DeviceGroupBean.getRecordbyPrimarykey(Integer.parseInt(request.getParameter("devicegroupname")));
			categoryId = deviceGroupBean.getCategoryID();
		}
		String header = TranslationHelper.getTranslatedMessge(isUpdate==true?"Update Device Group":"Add Device Group");
%>

<head>
<title><%=iViewConfigBean.TITLE%></title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />

</head>
<body>
<div>
<form action="<%=request.getContextPath()%>/iview" method="post" name="registrationform" onSubmit="return validateFrom();">
<input type="hidden" name="appmode" value="<%=ApplicationModes.NEW_DEVICE_GROUP%>">
<table cellpadding="2" cellspacing="0" width="100%" border="0">	
	<tr class="innerpageheader">
		<td width="3%">&nbsp;</td>
		<td class="contHead"><%=header%></td>
		<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
		<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','devicegroup');" style="cursor: pointer;">
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
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Device Group Name")%><font class="compfield">*</font></td>
		<td ><input type="text" name="grpname" class="datafield" style="width:150px" maxlength="50" value="<%=isUpdate==true?deviceGroupBean.getName():""%>"></td>
	</tr>  
	<tr >
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Description")%></td>
		<td >
		<textarea rows="3" cols="20" type="text" name="description" class="datafield" style="width:180px" ><%=isUpdate==true?deviceGroupBean.getDescription():""%></textarea>
		</td>
	</tr>
	<tr >
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Select Category")%><font class="compfield">*</font></td>
		<td >
		<select name="catId" id="catId" <%=(isUpdate==true?"disabled=true":"")%> onchange="getDevicesByCategory();">
		<%   			
  			Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
  			CategoryBean categoryBean= null;
  			while(categoryBeanItr.hasNext()){	  		
  				categoryBean = (CategoryBean)categoryBeanItr.next(); 
				if(categoryBean.getCategoryId()== categoryId){ %>   				
  					<option value='<%=categoryBean.getCategoryId()%>' selected ><%=categoryBean.getCategoryName()%></option>  				
  				<% }else{ %>  				
  				
  				<option value='<%=categoryBean.getCategoryId()%>'><%=categoryBean.getCategoryName()%></option> 
<%  			}
  			}
  		%>
		</select>
		</td>
	</tr>
	<tr id="deviceinfo" style="width:35%">		
		<td class="textlabels" style="width:35%"><%=TranslationHelper.getTranslatedMessge("Select Device")%><font class="compfield">*</font></td>
 		<td>
 		<div id="devicelist1" style="float:left">
 			<div class="grouptext" id="devicelist" style="height:20px;*height:20px;float:left;margin-right:2px;margin-top:4px"></div>
 		</div>
 		</td> 
	</tr>
</table>
</div>
</div>
<%
	String deviceListSel="";
	if(isUpdate){
		//Iterator itrDevice = DeviceBean.getAllDeviceBeanIterator();
		Iterator itrDevice = DeviceBean.getAllDeviceBeanIterator();
		DeviceBean deviceBean = null;
		while(itrDevice.hasNext()){			
			deviceBean = (DeviceBean) itrDevice.next();
			if(DeviceGroupRelationBean.isRelationExists(deviceGroupBean.getGroupID(),deviceBean.getDeviceId())){
				deviceListSel += ""+deviceBean.getDeviceId()+",";	
			}		
		}
		
		if(deviceListSel != "")
			deviceListSel = deviceListSel.substring(0,(deviceListSel.length()-1));
		}
%>


	<table align="center">
		<tr >
			<td colspan="2" >         
			<%
         				if(isUpdate) {
         			%>
					<input type="hidden" id="groupid" name="groupid" value=<%=deviceGroupBean.getGroupID()%> >
					<%
						}
					%>   
				<input type="hidden" id="selecteddevice" name="selecteddevice" value=<%=deviceListSel%> >
				<input type="hidden" id="operation" value=<%=isUpdate?"update":"Add"%> >
				<input type="submit" class="criButton" name="confirm" value=<%=TranslationHelper.getTranslatedMessge(isUpdate?"Update":"Add")%>>
				<input type="button" class="criButton" value="<%=TranslationHelper.getTranslatedMessge("Cancel")%>" onclick="handleThickBox('2','devicegroup');"">
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
