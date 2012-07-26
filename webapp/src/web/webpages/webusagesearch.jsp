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

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.*"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%>
<%@page import="org.cyberoam.iview.servlets.AjaxController"%>


<%
	try{
		if(CheckSession.checkSession(request,response)<0){
			return;
		}
%>
<html>
<head>
<title><%= iViewConfigBean.TITLE %></title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/container.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/tabs.css">
<script type="text/javascript" language="JavaScript" src="<%=request.getContextPath()%>/javascript/SearchData.js"></script>
<script type="text/javascript" language="JavaScript" src="<%=request.getContextPath()%>/javascript/utilities.js"></script>
<script type="text/javascript" language="javascript">
   	var http_request = false;
   	var childwindow;
   	var fieldArray = new Array("User","Source","Email Address");
   	var reportGroupId = new Array("26","28","29");
	var tablefieldArray = new Array("username","srcip,host,victim,attacker","sender,recipient");
	var criteriaArray = new Array("is");
	var criteriaValueArray = new Array("=");

	window.onload = function (evt) {	setWidth();		}		
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}

  	function checkSearchType(){
		if(true ){

			var userfontdiv = document.getElementById("userfontdiv");
			var usernamediv = document.getElementById("usernamediv");
			var groupfontdiv = document.getElementById("groupfontdiv");
			var groupnamediv = document.getElementById("groupnamediv");
			var sitenametr = document.getElementById("sitenametr");
			var categorynametr = document.getElementById("categorynametr");
			var domainlbl = document.getElementById("domaindiv");
			var domainurllbl = document.getElementById("domainurl");
			
			if(document.websearchform.reportdetailtype[0].checked){
				
			 	if( document.websearchform.searchtype[2].checked ){
					var reportid = document.getElementById("reportid");
					reportid.value = 50020;
					document.websearchform.userorgroup[1].disabled = true;
					document.websearchform.userorgroup[0].checked = true;
					userfontdiv.style.display='';
					usernamediv.style.display='';
					groupfontdiv.style.display='none';
					groupnamediv.style.display='none';
					sitenametr.style.display='none';
					categorynametr.style.display='';
				}else if(document.websearchform.searchtype[0].checked){
					var reportid = document.getElementById("reportid");
					reportid.value = 50000;
					document.websearchform.userorgroup[1].disabled = false;
					sitenametr.style.display='';
					categorynametr.style.display='none';
					domainlbl.style.display='';
					domainurllbl.style.display='none';
					checkSearchFor();			
				}else if(document.websearchform.searchtype[1].checked){
					var reportid = document.getElementById("reportid");
					reportid.value = 50010;
					document.websearchform.userorgroup[1].disabled = false;
					sitenametr.style.display='';
					categorynametr.style.display='none';
					domainlbl.style.display='none';
					domainurllbl.style.display='';				
					checkSearchFor();			
				}else{
					document.websearchform.userorgroup[1].disabled = false;
					sitenametr.style.display='';
					categorynametr.style.display='none';
					checkSearchFor();			
				}
			
			}else if(document.websearchform.reportdetailtype[1].checked){
				
				if( document.websearchform.searchtype[2].checked ){
					var reportid = document.getElementById("reportid");
					reportid.value = 48000000;
					document.websearchform.userorgroup[1].disabled = true;
					document.websearchform.userorgroup[0].checked = true;
					userfontdiv.style.display='';
					usernamediv.style.display='';
					groupfontdiv.style.display='none';
					groupnamediv.style.display='none';
					sitenametr.style.display='none';
					categorynametr.style.display='';
				}else if(document.websearchform.searchtype[0].checked){
					var reportid = document.getElementById("reportid");
					reportid.value = 48000000;
					document.websearchform.userorgroup[1].disabled = false;
					sitenametr.style.display='';
					categorynametr.style.display='none';
					domainlbl.style.display='';
					domainurllbl.style.display='none';
					checkSearchFor();			
				}else if(document.websearchform.searchtype[1].checked){
					var reportid = document.getElementById("reportid");
					reportid.value = 48000000;
					document.websearchform.userorgroup[1].disabled = false;
					sitenametr.style.display='';
					categorynametr.style.display='none';
					domainlbl.style.display='none';
					domainurllbl.style.display='';				
					checkSearchFor();			
				}else{
					document.websearchform.userorgroup[1].disabled = false;
					sitenametr.style.display='';
					categorynametr.style.display='none';
					checkSearchFor();			
				}
				
			}
			
		}else {
			document.websearchform.userorgroup[1].disabled = false;
			checkSearchFor();
		}
	}
	
	function checkSearchFor(){

		var userfontdiv = document.getElementById("userfontdiv");
		var usernamediv = document.getElementById("usernamediv");
		var groupfontdiv = document.getElementById("groupfontdiv");
		var groupnamediv = document.getElementById("groupnamediv");
 		var sitenametr = document.getElementById("sitenametr");
		var categorynametr = document.getElementById("categorynametr");

		if(document.websearchform.reportdetailtype[0].checked){
			if(document.websearchform.userorgroup[0].checked){
				var reportid = document.getElementById("reportid");
				if(document.websearchform.searchtype[0].checked){
					reportid.value = 50000;
				}else if(document.websearchform.searchtype[1].checked){
					reportid.value = 50010;
				}
				userfontdiv.style.display='';
				usernamediv.style.display='';
				groupfontdiv.style.display='none';
				groupnamediv.style.display='none';	
				
				if(document.websearchform.searchtype[2].checked){
					document.websearchform.userorgroup[1].disabled = true;
					document.websearchform.userorgroup[0].checked = true;
					sitenametr.style.display='none';
					categorynametr.style.display='';
				}else{
					sitenametr.style.display='';
					categorynametr.style.display='none';
				}
				
			}else if(document.websearchform.userorgroup[1].checked){
				var reportid = document.getElementById("reportid");
				if(document.websearchform.searchtype[0].checked){
					reportid.value = 50030;
				}else if(document.websearchform.searchtype[1].checked){
					reportid.value = 50040;
				}
				userfontdiv.style.display='none';
				usernamediv.style.display='none';
				groupfontdiv.style.display='';
				groupnamediv.style.display='';
				sitenametr.style.display='';
				if(true){
					categorynametr.style.display='none';
				}
			}
		}else if(document.websearchform.reportdetailtype[1].checked){
			if(document.websearchform.userorgroup[0].checked){
				var reportid = document.getElementById("reportid");
				reportid.value = 48000000;
				userfontdiv.style.display='';
				usernamediv.style.display='';
				groupfontdiv.style.display='none';
				groupnamediv.style.display='none';	
				
				if(document.websearchform.searchtype[2].checked){
					document.websearchform.userorgroup[1].disabled = true;
					document.websearchform.userorgroup[0].checked = true;
					sitenametr.style.display='none';
					categorynametr.style.display='';
				}else{
					sitenametr.style.display='';
					categorynametr.style.display='none';
				}
				
			}else if(document.websearchform.userorgroup[1].checked){
				var reportid = document.getElementById("reportid");
				reportid.value = 48000000;
				userfontdiv.style.display='none';
				usernamediv.style.display='none';
				groupfontdiv.style.display='';
				groupnamediv.style.display='';
				sitenametr.style.display='';
				if(true){
					categorynametr.style.display='none';
				}
			}
		}
	}

	

	function checkfield(){		
		var username = document.getElementById("username");
		var usergroup = document.getElementById("usergroup");
		var domain = document.getElementById("domain");
		var category = document.getElementById("category");

		
		username.value = '%' + document.getElementById("usernametxt").value + '%';		
		usergroup.value = '%' + document.getElementById("groupnametxt").value + '%';
		domain.value = '%' + document.getElementById("domaintxt").value + '%';
		category.value = '%' + document.getElementById("categorytxt").value + '%';
		
		return true;
	}

/*	function setTextUsername(){
		if(<%=request.getSession().getAttribute("clipboarddata")!=null%> && (copyData==undefined || copyData=='')){		
			copyData='<%=request.getSession().getAttribute("clipboarddata")%>';
		}	
		document.getElementById("usernametxt").value=copyData;
	}*/	
	
</script>
</head>
<body>
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>        
<div class="maincontent" id="main_content">
	<jsp:include page="Date.jsp" flush="true">
		<jsp:param name="device"	value="true"></jsp:param>
		<jsp:param name="showtime"	value="true"></jsp:param>
	</jsp:include>
<div class="reporttitlebar">
		<div class="reporttitle"><%= TranslationHelper.getTranslatedMessge("Search Web Surfing Report") %>
		</div>
</div>
<div style="float:left;margin-left:2px;margin-top:3px;width:100%;">
		<form onsubmit = "return checkfield();" action="singlereport.jsp" method=get name=websearchform>
		<input type="hidden"  name="reportid" id="reportid" value="50000" />
		<input type="hidden"  name="reportgroupid" id="reportgroupid" value="50000" />
		<input type="hidden"  name="username" id="username" value="" />
		<input type="hidden"  name="usergroup" id="usergroup" value="" />
		<input type="hidden"  name="domain" id="domain" value="" />
		<input type="hidden"  name="category" id="category" value="" />
		<input type="hidden"  name="showtime" id="showtime" value="true" />
				
		<table cellspacing="0" cellpadding="2px" border="0" width="100%" class="TableData" style="">
		<TR align=left>
			<td  width="20%">
				<%= TranslationHelper.getTranslatedMessge("Report Type") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td align="left">
				<input type=radio name=reportdetailtype value=0 checked onclick ="checkSearchType();">
				<%= TranslationHelper.getTranslatedMessge("Summary Report") %>
			    <input type=radio name=reportdetailtype value=1 onclick ="checkSearchType();">
			    <%= TranslationHelper.getTranslatedMessge("Detail Report") %>
			</td>
		</TR>
		<TR align=left>
			<td  width="20%">
				<%= TranslationHelper.getTranslatedMessge("Search Type") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td align="left">
				<input type=radio name=searchtype value=0  onclick ="checkSearchType();" checked>
				<%= TranslationHelper.getTranslatedMessge("Domain") %>
			    <input type=radio name=searchtype value=1 onclick ="checkSearchType();">
			    <%= TranslationHelper.getTranslatedMessge("URL") %>
				<input type=radio name=searchtype value=2 onclick ="checkSearchType();">
				<%= TranslationHelper.getTranslatedMessge("Category") %>
			</td>
		</TR>
		<TR align=left>
			<td>
				<%= TranslationHelper.getTranslatedMessge("Search For") %>
			</td>
			<td align="left">
				<input type=radio name=userorgroup value=0 onclick ="checkSearchFor();" checked>
				<%= TranslationHelper.getTranslatedMessge("User") %>
			    <input type=radio name=userorgroup value=1 onclick ="checkSearchFor();" />
			    <%= TranslationHelper.getTranslatedMessge("Group") %>
			</td>
		</TR>
		<TR>
			<TD>
				<div id="userfontdiv" style="display:">
					<%= TranslationHelper.getTranslatedMessge("User Name") %>
				</div>
				<div id="groupfontdiv" style="display:none">
					<%= TranslationHelper.getTranslatedMessge("Group Name") %>
				</div>
			</TD>
			<TD>
				<div id="usernamediv" style="display:">
					<input type=text name=usernametxt id=usernametxt value="">		
				</div>
				<div id="groupnamediv" style="display:none">
					<input type=text name=groupnametxt id=groupnametxt value="">
				</div>
			</td>
		</TR>
		<TR id="sitenametr" style="display:">
			<TD>
				<div id="domaindiv" style="display:"><%= TranslationHelper.getTranslatedMessge("Domain") %></div>
					<div id="domainurl" style="display:none"><%= TranslationHelper.getTranslatedMessge("Domain URL") %></div>
			</TD>
			<TD>
				<input type=text name="domaintxt" id=domaintxt value="" >
			</td>
		</TR>
		<TR id="categorynametr" style="display:none">
			<TD><%= TranslationHelper.getTranslatedMessge("Category Name") %></TD>
			<TD><input type=text name=categorytxt id=categorytxt value="" ></td>
		</TR>
		</table>
		<center>
			<input type=submit name=search style="margin-top:8px" class=criButton value="Search">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</center>
	</form>
</div>
</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
</body>
<%
	} catch(Exception e) {
	}
%>
</html>
