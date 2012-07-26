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
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.beans.*"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%
	try{
	if(CheckSession.checkSession(request,response)<0){
		return;
	}
		String pmsg = "";
		String nmsg = "";
		String strAppMode = request.getParameter("appmode");
		String strStatus = request.getParameter("status");
		int iAppmode=-1 ,iStatus=-1;
		if(strAppMode != null && !strAppMode.equalsIgnoreCase("")){
	iAppmode = Integer.parseInt(strAppMode);
		}
		if(strStatus != null && !strAppMode.equalsIgnoreCase("")){
	iStatus = Integer.parseInt(strStatus);
		}
		if(iAppmode>-1){
	if(iAppmode == ApplicationModes.ADD_REPORT_PROFILE && iStatus > 0){
		pmsg = TranslationHelper.getTranslatedMessge("Custom View Added Successfully.");
	}else if(iAppmode == ApplicationModes.ADD_REPORT_PROFILE && iStatus == -4){
		nmsg = TranslationHelper.getTranslatedMessge("Report profile with the same name already exist.");
	}else if(iAppmode == ApplicationModes.ADD_REPORT_PROFILE && iStatus <= 0){
		nmsg = TranslationHelper.getTranslatedMessge("Error while adding Custom View.");
	}else if(iAppmode == ApplicationModes.UPDATE_REPORT_PROFILE && iStatus > 0){
		pmsg = TranslationHelper.getTranslatedMessge("Custom View Updated Successfully.");
	}else if(iAppmode == ApplicationModes.UPDATE_REPORT_PROFILE && iStatus <= 0){
		nmsg = TranslationHelper.getTranslatedMessge("Error while updating Custom View.");
	}else if(iAppmode == ApplicationModes.DELETE_REPORT_PROFILE && iStatus > 0){
		pmsg = iStatus +" "+ TranslationHelper.getTranslatedMessge("Custom View Deleted Successfully.");
	}else if(iAppmode == ApplicationModes.DELETE_REPORT_PROFILE && iStatus == -4){
		nmsg = TranslationHelper.getTranslatedMessge("Error! View already in use with Report notification.");
	}else if(iAppmode == ApplicationModes.DELETE_REPORT_PROFILE && iStatus <= 0){
		nmsg = TranslationHelper.getTranslatedMessge("Error while deleting Custom View.");
	}
		}
%>
<html>
<head>
<TITLE><%=iViewConfigBean.TITLE%></TITLE>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="/javascript/cyberoam.js"></script>
<script type="text/javascript">
	window.onload = function (evt) {
		setWidth();				
	}	
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 218);	
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
		flag = false;
		elements = document.reportprofileform.select;		
		if(elements.length == undefined){			
			if( elements.checked == true)			
					flag = true;
		}else{
			for( i=0;i<elements.length ; i++ ){
				if( elements[i].checked == true ){
					flag = true ;
					break;
				}
			}
		}
		if(!flag){
			alert("<%=TranslationHelper.getTranslatedMessge("You must select atleast one profile")%>");
			return false;
		}
		var con = confirm("<%=TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected Profile(s)?")%>");
		if (! con ){ 
			return false ;
		}
		//document.reportprofileform.profileid.value = profileId;
		document.reportprofileform.submit();
	}
	
	
</script>
</head>
<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>  
	<div class="maincontent" id="main_content">
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Custom Views")%></div>
		</div>
		<br><br>

	<form action="<%=request.getContextPath()%>/iview" method="post" name="reportprofileform" id="reportprofileform">
	<input type="hidden" name="appmode" value="<%=ApplicationModes.DELETE_REPORT_PROFILE%>" >
	<input type="hidden" name="profileid" value="" >
	<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin-bottom: 2px;margin-left:2px;">
		<tr>
			<td align="left" class="ButtonBack">
				<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Add")%>" onclick="location.href='<%=request.getContextPath()%>/webpages/managereportprofile.jsp'">
				<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Delete")%>" onclick="return validateDelete()">
			</td>
		</tr>
		</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top: 2px;margin-left:2px;">
<%
 	if(!"".equals(pmsg)){
%>
		<tr>
			<td class="message">
				<font class="posimessage"><%=pmsg%></font>
			</td>
		</tr>
<%
	}
%>
<%
 	if(!"".equals(nmsg)){
 %>
	<tr>
		<td class="message">
			<font class="nagimessage"><%=nmsg%></font>
		</td>
	</tr>
<%
	}
%>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="TableData">
			<tr>
				<td class="tdhead" align="center" width="8%"><input type=checkbox id="check1" name=check1 onClick="selectall()"></td>
				<td class="tdhead"><%=TranslationHelper.getTranslatedMessge("Custom View Name")%></td>
				<td class="tdhead"><%=TranslationHelper.getTranslatedMessge("Custom View Description")%></td>
				
			</tr>
<%
			int profileCnt = 0;
		    int categoryid;
			String rowStyle = "trdark";
			Iterator reportGroupBeanItr = ReportGroupBean.getReportGroupBeanIterator();
			ReportGroupBean reportGroupBean = null;
			while(reportGroupBeanItr.hasNext()){
				reportGroupBean = (ReportGroupBean)reportGroupBeanItr.next();
				if(reportGroupBean.getGroupType() == ReportGroupBean.DYNAMIC_GROUP){
					//categoryid=CategoryReportGroupRelationBean.getCategoryIdByReportGroupId(reportGroupBean.getReportGroupId());
					categoryid = reportGroupBean.getCategoryId();
					profileCnt++; 
					if(profileCnt%2 == 0)
						rowStyle = "trlight";
					else 
						rowStyle = "trdark";
%>
			<tr class="<%=rowStyle%>">
				<td class="tddata" align="center"><!-- <img src="<%=request.getContextPath()%>/images/delete.bmp" title="<%=TranslationHelper.getTranslatedMessge("Delete")%>" onClick="deleteProfile('<%=reportGroupBean.getReportGroupId()%>')" width="25px" height="20px"> -->
				<input type="checkbox"  name="select" value="<%=reportGroupBean.getReportGroupId()%>" onClick="deselectall()">
				</td>
				<td class="tddata">
					<a href="<%=request.getContextPath()%>/webpages/managereportprofile.jsp?profileid=<%=reportGroupBean.getReportGroupId()%>&category=<%=categoryid%>"><%=reportGroupBean.getTitle()%></a>
				</td>
				<td class="tddata"><%=reportGroupBean.getDescription()%>&nbsp;</td>
			</tr>
<%
		}
	}
	if(profileCnt == 0 ){
%>
			<tr class="trdark">
				<td class="tddata" colspan="3" align="center"><%=TranslationHelper.getTranslatedMessge("Custom View Not Available")%></td>
			</tr>
<%					
	}
%>	
			</table>
		</td>
	</tr>
	</table>
	</form>
	</div>
	<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
</body>
</html>
<%
	}catch(Exception  e){
		CyberoamLogger.appLog.debug("Exception in reportprofile.jsp : "+e,e);
		out.println(e);
}
%>
