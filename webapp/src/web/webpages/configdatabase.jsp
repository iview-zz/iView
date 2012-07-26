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
<%@page import="org.cyberoam.iview.authentication.beans.UserBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.RoleBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>

<%
	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		/*String detailTable = DataBaseConfigBean.getValue(DataBaseConfigBean.MAX_TABLE_NO_FOR5MIN);		
		String summaryTable = DataBaseConfigBean.getValue(DataBaseConfigBean.MAX_TABLE_NO_FOR4HR);*/
		String categoryId=null;
		 if(session.getAttribute("categoryid")!=null){	
				categoryId = (String)session.getAttribute("categoryid");	
			}
		String MaxNoTables24hr_web=DataBaseConfigBean.getValue("MaxNoTables24hr_web");
		String MaxNoTables24hr_mail=DataBaseConfigBean.getValue("MaxNoTables24hr_mail");
		String MaxNoTables24hr_ftp=DataBaseConfigBean.getValue("MaxNoTables24hr_ftp");
		String MaxNoTables24hr_deniedweb=DataBaseConfigBean.getValue("MaxNoTables24hr_deniedweb");
		String MaxNoTables24hr_ips=DataBaseConfigBean.getValue("MaxNoTables24hr_ips");
		String MaxNoTables24hr_spam=DataBaseConfigBean.getValue("MaxNoTables24hr_spam");
		String MaxNoTables24hr_virus=DataBaseConfigBean.getValue("MaxNoTables24hr_virus");
		String MaxNoTables24hr_event=DataBaseConfigBean.getValue("MaxNoTables5min_event");
		String MaxNoTables24hr_vpn=DataBaseConfigBean.getValue("MaxNoTables5min_vpn");
		String MaxNoTables24hr_im=DataBaseConfigBean.getValue("MaxNoTables24hr_im");
		String MaxNoTables5min_iusg=DataBaseConfigBean.getValue("MaxNoTables5min_iusg");
		//SELECT tablename FROM pg_tables WHERE schemaname = 'public' and tablename like 'top%24hr_ts_201107' and tablename not like 'top_denyrules%24hr_ts_201107' 
			//or tablename like 'accept%24hr_ts_201107' or tablename like 'host%24hr_ts_201107' or tablename like 'user%24hr_ts_201107' or tablename like 'rules%24hr_ts_201107'
			//or tablename like 'protogroup%24hr_ts_201107' or tablename like 'application%24hr_ts_201107' order by tablename;
		String MaxNoTables24hr_accept_top_host_user_rules_protogroup_application=DataBaseConfigBean.getValue("MaxNoTables24hr_accept_top_host_user_rules_protogroup_application");
		//SELECT tablename FROM pg_tables WHERE schemaname = 'public' and tablename like '%blocked%24hr_ts_201107' or tablename like '%deny%24hr_ts_201107'; 
		String MaxNoTables24hr_blocked_deny=DataBaseConfigBean.getValue("MaxNoTables24hr_blocked_deny");
		String MaxNoTables24hr_apch=DataBaseConfigBean.getValue("MaxNoTables24hr_apch");
		String MaxNoTables24hr_usbc=DataBaseConfigBean.getValue("MaxNoTables24hr_usbc");
		String MaxNoTables24hr_webr=DataBaseConfigBean.getValue("MaxNoTables24hr_webr");
		String MaxNoTables24hr_update=DataBaseConfigBean.getValue("MaxNoTables24hr_update");
		String MaxNoTables24hr_flnt=DataBaseConfigBean.getValue("MaxNoTables24hr_flnt");
		String MaxNoTables24hr_apct=DataBaseConfigBean.getValue("MaxNoTables24hr_apct");
		String MaxNoTables24hr_mscan=DataBaseConfigBean.getValue("MaxNoTables24hr_mscan");
		String MaxNoTables24hr_fw=DataBaseConfigBean.getValue("MaxNoTables24hr_fw");
		String MaxNoTables24hr_webs=DataBaseConfigBean.getValue("MaxNoTables24hr_webs");
		String MaxNoTables24hr_netg=DataBaseConfigBean.getValue("MaxNoTables24hr_netg");
		String MaxNoTables24hr_netgdnd=DataBaseConfigBean.getValue("MaxNoTables24hr_netgdnd");
		String MaxNoTables24hr_netg_ips=DataBaseConfigBean.getValue("MaxNoTables24hr_netg_ips");
		String MaxNoTables24hr_netg_virus=DataBaseConfigBean.getValue("MaxNoTables24hr_netg_virus");
		String MaxNoTables24hr_netg_application=DataBaseConfigBean.getValue("MaxNoTables24hr_netg_application");
		
		String archieveLimit = DataBaseConfigBean.getValue(DataBaseConfigBean.ARHIEVE_DATA);
%>
<%@page import="org.cyberoam.iview.beans.DataBaseConfigBean"%>

<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%><html>
<head>
<TITLE><%=iViewConfigBean.TITLE%></TITLE>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="/javascript/cyberoam.js"></script>
<script language="JavaScript"> 
	window.onload = function (evt) {
		setWidth();				
	}		
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}

</script>
</head>

<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>  
	<div class="maincontent" id="main_content">
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Data Management")%></div>
		</div>
		<br><br>
	<form action="<%=request.getContextPath()%>/iview" method=post name=manageactiveusers >
	<input type=hidden name=appmode value="<%=ApplicationModes.UPDATE_DATABASE_CONFIGURATION%>">
	<input type="hidden" name="categoryID" value="<%=(String)session.getAttribute("categoryid")%>" />
	<table width="100%" border="0" cellpadding="0" cellspacing="0">

	<tr>
		<td>
			<table cellpadding="2px" cellspacing="0" width="100%" border="0" class="TableData">
			<tr>
				<td align="center" class="tdhead" width="30%"><%=TranslationHelper.getTranslatedMessge("Log Retention")%></td>
				<td align="center" class="tdhead" width="10%"><%=TranslationHelper.getTranslatedMessge("Report Period")%></td>
				<td align="center" class="tdhead" width="20%"><%=TranslationHelper.getTranslatedMessge("Size")%></td>
				<td align="center" class="tdhead" width="40%"><%=TranslationHelper.getTranslatedMessge("Status")%></td>
			</tr>
			<%if (categoryId.equalsIgnoreCase("1")) {%>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Web Surfing Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_web">
					<option value=101 <%="101".equals(MaxNoTables24hr_web)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_web)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_web)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_web)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_web)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_web)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("web")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("web Surfing"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>
			</tr>
			
			<tr>
			<td >
				<%=TranslationHelper.getTranslatedMessge("Retain Mail Logs For Last")%>
			</td>
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_mail">
					<option value=101 <%="101".equals(MaxNoTables24hr_mail)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_mail)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_mail)?"selected='selected'":"" %> >3 Months</option>
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("mail")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Mail Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>
			</tr>
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain IM Logs For Last")%>
			</td>
			
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_im">	
					<option value=101 <%="101".equals(MaxNoTables24hr_im)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_im)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_im)?"selected='selected'":"" %> >3 Months</option>													
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("im")%>	
			</td>
			<td align="center">
						<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("IM Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>
			</tr>
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain FTP Logs For Last")%>
			</td>
						
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_ftp">
					<option value=101 <%="101".equals(MaxNoTables24hr_ftp)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_ftp)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_ftp)?"selected='selected'":"" %> >3 Months</option>						
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("ftp")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("FTP Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>
			</tr>
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain VPN Logs For Last")%>
			</td> 
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_vpn"> 		
					<option value=1 <%="1".equals(MaxNoTables24hr_vpn)?"selected='selected'":"" %>>1 Day</option>		
					<option value=2 <%="2".equals(MaxNoTables24hr_vpn)?"selected='selected'":"" %>>2 Days</option>		
					<option value=3 <%="3".equals(MaxNoTables24hr_vpn)?"selected='selected'":"" %>>3 Days</option>		
					<option value=5 <%="5".equals(MaxNoTables24hr_vpn)?"selected='selected'":"" %>>5 Days</option>		
					<option value=7 <%="7".equals(MaxNoTables24hr_vpn)?"selected='selected'":"" %>>7 Days</option>		
					<option value=30 <%="30".equals(MaxNoTables24hr_vpn)?"selected='selected'":"" %>>1 Month</option>
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("vpn")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("VPN Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>
			</tr>
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Internet Usage Logs For Last")%>
			</td>	 
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables5min_iusg">			 		
					<option value=1 <%="1".equals(MaxNoTables5min_iusg)?"selected='selected'":"" %>>1 Day</option>		
					<option value=2 <%="2".equals(MaxNoTables5min_iusg)?"selected='selected'":"" %>>2 Days</option>		
					<option value=3 <%="3".equals(MaxNoTables5min_iusg)?"selected='selected'":"" %>>3 Days</option>		
					<option value=5 <%="5".equals(MaxNoTables5min_iusg)?"selected='selected'":"" %>>5 Days</option>		
					<option value=7 <%="7".equals(MaxNoTables5min_iusg)?"selected='selected'":"" %>>7 Days</option>		
					<option value=30 <%="30".equals(MaxNoTables5min_iusg)?"selected='selected'":"" %>>1 Months</option>
					<option value=90 <%="90".equals(MaxNoTables5min_iusg)?"selected='selected'":"" %>>3 Months</option>
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("iusg")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Internet Usage"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>
			</tr>
			
			<tr>
			<td>
					<%=TranslationHelper.getTranslatedMessge("Retain Blocked Web Attempts Logs For Last")%>
			</td>
			
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_deniedweb">
					<option value=101 <%="101".equals(MaxNoTables24hr_deniedweb)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_deniedweb)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_deniedweb)?"selected='selected'":"" %> >3 Months</option>								
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("deniedweb")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Blocked Web Attempts"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>	
			</tr>
			
			<tr>
			<td>
					<%=TranslationHelper.getTranslatedMessge("Retain IPS Attacks Logs For Last")%>
			</td>
			
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_ips">
					<option value=101 <%="101".equals(MaxNoTables24hr_ips)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_ips)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_ips)?"selected='selected'":"" %> >3 Months</option>								
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("ips")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("IPS Attacks"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>	
			</tr>
			
			<tr>
			<td>
					<%=TranslationHelper.getTranslatedMessge("Retain Spam Logs For Last")%>
			</td>
			
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_spam">
					<option value=101 <%="101".equals(MaxNoTables24hr_spam)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_spam)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_spam)?"selected='selected'":"" %> >3 Months</option>						
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("spam")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Spam Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>	
			</tr>
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Virus Logs For Last")%>
			</td>
			
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_virus">
					<option value=101 <%="101".equals(MaxNoTables24hr_virus)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_virus)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_virus)?"selected='selected'":"" %> >3 Months</option>
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("virus")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Virus Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>	
			</tr>
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Appliance Audit Logs For Last")%>
			</td>
			<td align="center">
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_event">		
					<option value=1 <%="1".equals(MaxNoTables24hr_event)?"selected='selected'":"" %>>1 Day</option>		
					<option value=2 <%="2".equals(MaxNoTables24hr_event)?"selected='selected'":"" %>>2 Days</option>		
					<option value=3 <%="3".equals(MaxNoTables24hr_event)?"selected='selected'":"" %>>3 Days</option>		
					<option value=5 <%="5".equals(MaxNoTables24hr_event)?"selected='selected'":"" %>>5 Days</option>		
					<option value=7 <%="7".equals(MaxNoTables24hr_event)?"selected='selected'":"" %>>7 Days</option>		
					<option value=30 <%="30".equals(MaxNoTables24hr_event)?"selected='selected'":"" %>>1 Month</option>
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("event")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Appliance Audit Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>	
			</tr>	
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Application Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_accept_top_host_user_rules_protogroup_application">
					<option value=101 <%="101".equals(MaxNoTables24hr_accept_top_host_user_rules_protogroup_application)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_accept_top_host_user_rules_protogroup_application)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_accept_top_host_user_rules_protogroup_application)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_accept_top_host_user_rules_protogroup_application)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_accept_top_host_user_rules_protogroup_application)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_accept_top_host_user_rules_protogroup_application)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("accept_top_host_user_rules_protogroup_application")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Application Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>			
			</tr>	
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Blocked Attempt Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_blocked_deny">
					<option value=101 <%="101".equals(MaxNoTables24hr_blocked_deny)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_blocked_deny)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_blocked_deny)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_blocked_deny)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_blocked_deny)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_blocked_deny)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>	
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("blocked_deny")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Blocked Attempt Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>	
			<%}%>
			<%if (categoryId.equalsIgnoreCase("4")) {%>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Apache Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_apch">
					<option value=101 <%="101".equals(MaxNoTables24hr_apch)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_apch)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_apch)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_apch)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_apch)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_apch)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("apch")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Apache"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>	
			<%}%>
			<%if (categoryId.equalsIgnoreCase("3")) {%>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain USB Control Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_usbc">
					<option value=101 <%="101".equals(MaxNoTables24hr_usbc)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_usbc)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_usbc)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_usbc)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_usbc)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_usbc)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>	
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("usbc")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("USB Control"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>			
			</tr>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Web Report Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_webr">
					<option value=101 <%="101".equals(MaxNoTables24hr_webr)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_webr)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_webr)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_webr)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_webr)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_webr)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>	
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("webr")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Web Report"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>			
			</tr>
				<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Update Data Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_update">
					<option value=101 <%="101".equals(MaxNoTables24hr_update)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_update)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_update)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_update)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_update)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_update)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("update")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Update Data"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain File Antivirus Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_flnt">
					<option value=101 <%="101".equals(MaxNoTables24hr_flnt)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_flnt)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_flnt)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_flnt)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_flnt)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_flnt)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("flnt")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("File Antivirus"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>				
			</tr>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Application Control Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_apct">
					<option value=101 <%="101".equals(MaxNoTables24hr_apct)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_apct)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_apct)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_apct)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_apct)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_apct)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("apct")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Application Control"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Email Scanning Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_mscan">
					<option value=101 <%="101".equals(MaxNoTables24hr_mscan)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_mscan)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_mscan)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_mscan)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_mscan)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_mscan)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("mscan")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Email Scanning"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>				
			</tr>
			
			<%}%>
			<%if (categoryId.equalsIgnoreCase("2")) {%>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Firewall Report Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_fw">
					<option value=101 <%="101".equals(MaxNoTables24hr_fw)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_fw)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_fw)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_fw)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_fw)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_fw)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("fw")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Firewall Report"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>
			
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge("Retain Web Usage Logs For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_webs">
					<option value=101 <%="101".equals(MaxNoTables24hr_webs)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_webs)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_webs)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_webs)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_webs)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_webs)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("webs")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Web Usage Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>				
			</tr>
			<%}%>
			<%if (categoryId.equalsIgnoreCase("5")) {%>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge(" Retain Net Genie Application Activity For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_netg_application">
					<option value=101 <%="101".equals(MaxNoTables24hr_netg_application)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_netg_application)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_netg_application)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_netg_application)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_netg_application)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_netg_application)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("netg_application")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Netgenie Application Activtiy"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge(" Retain Net Genie Web Allow For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_netg">
					<option value=101 <%="101".equals(MaxNoTables24hr_netg)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_netg)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_netg)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_netg)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_netg)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_netg)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("netg")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("NetGenie Web Allow"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge(" Retain Net Genie Web Denied For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_netgdnd">
					<option value=101 <%="101".equals(MaxNoTables24hr_netgdnd)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_netgdnd)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_netgdnd)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_netgdnd)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_netgdnd)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_netgdnd)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("netgdnd")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("NetGenie Web Denied"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>	
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge(" Retain Net Genie Attack For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_netg_ips">
					<option value=101 <%="101".equals(MaxNoTables24hr_netg_ips)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_netg_ips)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_netg_ips)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_netg_ips)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_netg_ips)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_netg_ips)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("netg_ips")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Netgenie IPS Attacks"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>
			<tr>
			<td>
				<%=TranslationHelper.getTranslatedMessge(" Retain Net Genie Virus For Last")%>
			</td>
			<td align="center">	
				<select class="datafield" style="width:80px" name="MaxNoTables24hr_netg_virus">
					<option value=101 <%="101".equals(MaxNoTables24hr_netg_virus)?"selected='selected'":"" %> >1 Month</option>
					<option value=102 <%="102".equals(MaxNoTables24hr_netg_virus)?"selected='selected'":"" %> >2 Months</option>
					<option value=103 <%="103".equals(MaxNoTables24hr_netg_virus)?"selected='selected'":"" %> >3 Months</option>
					<option value=1 <%="1".equals(MaxNoTables24hr_netg_virus)?"selected='selected'":"" %> >6 Months</option>
					<option value=109 <%="109".equals(MaxNoTables24hr_netg_virus)?"selected='selected'":"" %> >9 Months</option>
					<option value=2 <%="2".equals(MaxNoTables24hr_netg_virus)?"selected='selected'":"" %> >1 Year</option>				
				</select>
			</td>		
			<td align="center">
					<%=DataBaseConfigBean.getTablesSize("netg_virus")%>	
			</td>
			<td align="center">
					<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("Netgenie Virus Logs"))?"Change will Apply After 12":"Last Changes Applied"%>	
			</td>		
			</tr>
			<%}%>
			<tr >
					<td> <%=TranslationHelper.getTranslatedMessge("Archive Log")%> </td>
					<td align="center"> 
						<select class="datafield" style="width:80px" name="archieve_limit">
							<option <%=("1".equals(archieveLimit))?"selected":""%> value="1">1 day</option>
							<option <%=("2".equals(archieveLimit))?"selected":""%> value="2">2 day</option>
							<option <%=("5".equals(archieveLimit))?"selected":""%> value="5">5 day</option>
							<option <%=("7".equals(archieveLimit))?"selected":""%> value="7">1 week</option>
							<option <%=("14".equals(archieveLimit))?"selected":""%> value="14">2 week</option>
							<option <%=("30".equals(archieveLimit))?"selected":""%> value="30">1 Month</option>
							<option <%=("91".equals(archieveLimit))?"selected":""%> value="91">3 Month</option>
							<option <%=("182".equals(archieveLimit))?"selected":""%> value="182">6 Month</option>
							<option <%=("365".equals(archieveLimit))?"selected":""%> value="365">1 Year</option>
							<option <%=("1095".equals(archieveLimit))?"selected":""%> value="1095">3 Year</option>
							<option <%=("2555".equals(archieveLimit))?"selected":""%> value="2555">7 Year</option>
							<option <%=("-1".equals(archieveLimit))?"selected":""%> value="-1">Forever</option>
							<option <%=("0".equals(archieveLimit))?"selected":""%> value="0">Disable</option>
						</select> 
					</td>
					<td align="center">
						<%=DataBaseConfigBean.getArchieveSize()%>	
					</td>
					<td align="center">
						<%="0".equals(DataBaseConfigBean.getSpecifiedTableStatus("ArchieveData"))?"Change will Apply After 12":"Last Changes Applied"%>	
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" >
			<input class="criButton" type="submit" value="<%=TranslationHelper.getTranslatedMessge("Apply")%>" >			
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
	CyberoamLogger.appLog.debug("Exception in manageactiveusers.jsp : "+e,e);
}
%>
