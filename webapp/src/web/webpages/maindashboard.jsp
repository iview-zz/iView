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

<%@page import="org.cyberoam.iview.utility.CheckSession, java.util.ArrayList"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.text.MessageFormat, java.util.Calendar"%>
<%@page import="org.cyberoam.iview.beans.ReportGroupBean"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.beans.ReportGroupRelationBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.UserBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.RoleBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceTypeBean"%>
<%@page import="org.cyberoam.iview.utility.iViewInfoClient"%>

<html>
<%
	try {	
		if(CheckSession.checkSession(request,response) < 0) {
			return;
		}
		
		int categoryID=Integer.parseInt((String)session.getAttribute("categoryid"));
		int reportGroupID = ReportGroupBean.getMainDashboardReportGroupID(categoryID);
		ArrayList reportList = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportGroupID));
		int reportID = 0;
		if(reportList!= null && reportList.size()>0){
			reportID = ((ReportGroupRelationBean)reportList.get(0)).getReportId();
		}
		session.setAttribute("lastAccess",null);
		DeviceBean.checkForNewDevice();
		boolean isNewDeviceArrived = false;
		UserBean userBean = UserBean.getRecordbyPrimarykey((String)session.getAttribute("username"));
		Iterator deviceBeanItr = DeviceBean.getNewDeviceBeanIterator();
		if(deviceBeanItr.hasNext() && userBean.getRoleId() == RoleBean.SUPER_ADMIN_ROLE_ID  ){
			isNewDeviceArrived = true;
		}
%>

<head>
	<title><%=iViewConfigBean.TITLE%></title>
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">	 
	<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath()%>/javascript/container.js"></script>
	<script src="<%=request.getContextPath()%>/javascript/utilities.js"></script>
	<script LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/popupform.js"></script>
	<script LANGUAGE="Javascript">
		window.onload = function (evt) {			
			setWidth();
		}
		function addToList(deviceId){
			document.frmdevicemgt.deviceidlist.value += (deviceId + ',');
		}
	
		function submitForm(){
			
			var deviceIdList = document.frmdevicemgt.deviceidlist.value;
			deviceIdList = deviceIdList.substring(0,deviceIdList.lastIndexOf(','));
			deviceIdList = deviceIdList.split(",");
			for(var i=0; i<deviceIdList.length; i++){
				if(trim(document.getElementById("devicename"+deviceIdList[i]).value) == ''){
					alert("Please enter Device name.");
					document.getElementById("devicename"+deviceIdList[i]).focus();
					return false;
				}
				if(document.getElementById("devicetype"+deviceIdList[i]).selectedIndex == 0){
					alert("Unknown Device Type is not allowed.");
					return false;
				}
			}
			if( confirm('Are you sure you want to save changes?') ){
				document.frmdevicemgt.submit();
			}
		}
				
		function setWidth(){
			var main_div = document.getElementById("main_content");
			main_div.style.width = (document.body.clientWidth - 218);				
		}
		
	</script>	
</head>

<body onload="setWidth()" onresize="setWidth()">
	<jsp:include page="menu.jsp" flush="true"></jsp:include> 
	<jsp:include page="pageheader.jsp" flush="true"></jsp:include>		
	
	<div class = "maincontent" id="main_content">
	<jsp:include page="Date.jsp" flush="true">
	<jsp:param name="device" value="true"></jsp:param>	
	</jsp:include>
		<% if(iViewInfoClient.message != null) { %>
			<div style="color:red;padding-left:5px"><%= iViewInfoClient.message%></div>
		<%} %>
		<div class="reporttitlebar">			
			<div class="reporttitle">
				<%=TranslationHelper.getTranslatedMessge("Main Dashboard")%>
			</div>
			<div class="reporttimetitle">
				<b>From:</b> <font class="reporttime"><%=session.getAttribute("startdate")%></font>
				</br><b>To:</b> <font class="reporttime"><%=session.getAttribute("enddate")%></font> 
			</div>
			<div class="pdflink">
				<a id="pdfLinkForGroup" onclick="getPDF('<%=reportID%>','<%=reportGroupID %>')" >
					<img src="../images/PdfIcon.jpg" class="pdflink"></img>
				</a>				
			</div>			
			
			 <div class="xlslink"> 
				<a id="xlsLinkForGroup" onclick="getXLS('<%=reportID%>','<%=reportGroupID %>')" >
					<img src="../images/csvIcon.jpg" class="xlslink"></img>
				</a>				
			</div>			

		</div>	

		
				
	<%
	ReportGroupRelationBean reportGroupRelationBean = null; 
	ReportGroupBean reportGroupBean = null;
	MessageFormat queryFormat = null;
	Object[] paramValues = null;
	reportList = null;
	StringTokenizer st = null;
	String timeFrame = null;
	//String paramName = null;
	String startDate = null;
	String endDate = null;
	String limit = null;
	//String title = null;
	String isColumned = "true";
	int order = 0;
	reportID = 0; 
	
	try {			
			reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
			reportList = reportGroupBean.getReportIdByReportGroupId(reportGroupID);
%>
<%
			int lastRowOrder=1;
			CyberoamLogger.appLog.debug("reportList: " + reportList + "\treportList.size(): " + reportList.size());			
			for(int i=0;i<reportList.size();i++){
				reportGroupRelationBean=(ReportGroupRelationBean)reportList.get(i);			  
				reportID=reportGroupRelationBean.getReportId();									
				order=reportGroupRelationBean.getRowOrder();
				
				if(i % 2 == 0) {
%>
					<div class="reportpair">
<%
				}				
				if(order == 1){
%>
					<div class="dashreport">
<%
				}else{
%>	
					<div class="report">
<%
				}
%>
				<jsp:include page='<%="/webpages/dashboardreport.jsp?reportid=" +reportID +"&columned=" + isColumned + "&" + request.getQueryString()%>' flush="true"/>
				</div>
<%
				if (i % 2 != 0) {
%>
	    		</div>
<%
               	}				
         	}
		} catch(Exception e) {
			CyberoamLogger.appLog.error("Exception occured in dashboardreportgroup.jsp: " + e, e);
		}
%>		
				</div>
	<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
		<% if(isNewDeviceArrived){ %>
	
	<div id="TB_overlay" class="TB_overlayBG"></div>
	<div class="TB_window" id="newdeviceform" style="display:block;top: 100px">
	<FORM method="POST" name="frmdevicemgt" action="<%=request.getContextPath()%>/iview">
	<input type="hidden" name="appmode" value="<%=ApplicationModes.MANAGE_DEVICE%>">
	<input type="hidden" name="deviceidlist" value="">
	<input type="hidden" name="deviceid" value="">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">	
		<tr class="innerpageheader">
			<td width="3%">&nbsp;</td>
			<td class="contHead">New Device(s) Found</td>
			<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
			<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','newdeviceform')" style="cursor: pointer;">
			</td>
		</tr>
	</table>
	<div style="margin:5px" align="center">
	<div style="width:100%;border:1px solid #999999;">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" class="TableData">
	<tr>
		<td class="tdhead" width="30%"><%=TranslationHelper.getTranslatedMessge("Device Name")%></td>
		<td class="tdhead" width="30%"><%=TranslationHelper.getTranslatedMessge("IP Address")%></td>
		<td class="tdhead" width="30%"><%=TranslationHelper.getTranslatedMessge("Device Type")%></td>
		<td class="tdhead"><%=TranslationHelper.getTranslatedMessge("Status")%></td>
	</tr>
<%
	
	DeviceBean deviceBean = null;
	int deviceCnt = 0;
	String rowStyle = "trdark";
	
	while(deviceBeanItr.hasNext()){
		deviceBean = (DeviceBean)deviceBeanItr.next();
		if(deviceBean==null ||  deviceBean.getDeviceStatus()!=DeviceBean.NEW)
			continue;
		deviceCnt++;
		out.println("<script>addToList("+deviceBean.getDeviceId()+")</script>");
		if(deviceCnt%2 == 0)
			rowStyle = "trdark";
		else 
			rowStyle = "trlight";
%>
	<tr class="<%=rowStyle%>">
		<td class="tddata"><input type="text" id="devicename<%=deviceBean.getDeviceId()%>" name="devicename<%=deviceBean.getDeviceId()%>"></td>
		<td class="tddata"><%=deviceBean.getIp() != null?deviceBean.getIp():""%></td>
		
		<td class="tddata" align="center">
			<select name="devicetype<%=deviceBean.getDeviceId()%>" id="devicetype<%=deviceBean.getDeviceId()%>">
				<option value="-1" selected="selected">UNKNOWN</option>
<%
				DeviceTypeBean deviceTypeBean = null;
				Iterator deviceTypeBeanItr = DeviceTypeBean.getDeviceTypeBeanIterator();
				while(deviceTypeBeanItr.hasNext()){
					deviceTypeBean = (DeviceTypeBean)deviceTypeBeanItr.next();
					if(deviceTypeBean!=null){
%>					<option value="<%= deviceTypeBean.getDeviceTypeId() %>" ><%= deviceTypeBean.getTypeName() %></option>
<%
					}
				}
%>			</select>
		</td>
		<td class="tddata">
			<input type="radio" name="devicestatus<%=deviceBean.getDeviceId()%>" value="<%=DeviceBean.ACTIVE%>" checked="checked"/><%=TranslationHelper.getTranslatedMessge("Active")%>&nbsp;&nbsp;
			<input type="radio" name="devicestatus<%=deviceBean.getDeviceId()%>" value="<%=DeviceBean.DEACTIVE%>" /><%=TranslationHelper.getTranslatedMessge("Deactive")%> &nbsp;&nbsp;
		</td>
	</tr>
<%
	}
%>
	<tr><td colspan="4">&nbsp;</td></tr>
	</table>
	</div>
	</div>
	<table align="center">
	<tr>
		<td colspan="2" align="center">
			<input class="criButton" type="button" name="Add" value="<%=TranslationHelper.getTranslatedMessge("Save")%>" onclick="submitForm()" />
		</td>
	</tr>
	</table>
	
</form>
<script>
	getWinSize("newdeviceform");
</script>
	
	</div>
	</div>
<%  }%>


</body>
</html>
<%
		}
		catch(Exception e) {
		CyberoamLogger.appLog.error("Exception: " + e, e);
	}
%>
