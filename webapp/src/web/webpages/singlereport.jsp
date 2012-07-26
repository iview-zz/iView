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
<%@page import="org.cyberoam.iview.charts.Chart"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.*"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%>


<%
	try {
	if(CheckSession.checkSession(request,response)<0){
		return;
	}
	ReportBean reportBean = null;
	if(request.getParameter("reportid")!=null && !"".equals(request.getParameter("reportid").trim())) {
		reportBean = ReportBean.getRecordbyPrimarykey(request.getParameter("reportid"));	    
	} else {
		return;
	}
	int reportGroupID=Integer.parseInt(request.getParameter("reportgroupid"));
	ReportGroupBean reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
	
	String title = Chart.getFormattedTitle(request,reportGroupBean,false) ;
	if(!reportGroupBean.getTitle().equals(reportBean.getDefaultTitle()) && reportBean.getDefaultTitle()!= null){
		if(!reportBean.getDefaultTitle().equals("") && !reportBean.getDefaultTitle().equals(reportBean.getDefaultTitle()))
			title +=" > "+ TranslationHelper.getTranslatedMessge(reportBean.getDefaultTitle());
	}
	String title1 = "";
	if(!reportBean.getTitle().equals(""))
		title1 =" > "+ TranslationHelper.getTranslatedMessge(reportBean.getTitle());
	if(title1 == ""){
		title1 = title.substring(title.lastIndexOf(">"));
		title = title.substring(title.lastIndexOf(">"));
	}
	String reportID=request.getParameter("reportid");
	int iReportID = Integer.parseInt(reportID);
	
	String limit = request.getParameter("limit");		
	if(limit != null)
		limit = (String)session.getAttribute("limit");
	if(limit == null)
		limit = "10";
	
	String isDeviceCombo = request.getParameter("device");
	if(isDeviceCombo == null || "".equalsIgnoreCase(isDeviceCombo) || !"false".equalsIgnoreCase(isDeviceCombo)){
		isDeviceCombo = "true";
	} else {
		isDeviceCombo = "false";
	}
	String isShowTime ="false"; 
	isShowTime = request.getParameter("showtime");
	if("true".equalsIgnoreCase(isShowTime) && !"".equalsIgnoreCase(isShowTime) && isShowTime!=null ){
		isShowTime="true";
	}else{
		isShowTime="false";	
	}	
		
	boolean isNavigation = true;
	if(request.getParameter("navigation") == null || "".equalsIgnoreCase(request.getParameter("navigation")) || !"false".equalsIgnoreCase(request.getParameter("navigation"))){
		isNavigation = true;
	} else {
		isNavigation = false;
	}
	String url=request.getRequestURL().toString();
	String querystring=request.getQueryString();
	if(querystring.contains("&empty")){
	querystring=querystring.replace("&empty","&empt");
	}
	url+="?"+querystring;
	session.setAttribute("bookmarkurl",url);
%>


<html>
<head>
<title>iView</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/popupform.js"></SCRIPT>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popup.js"></script>
<SCRIPT language="JavaScript">

	var title="";
	
	function setWidth(){
		
		var main_div = document.getElementById("main_content");
		main_div.style.width = (document.body.clientWidth - 218);
	}
	
	window.onload = function (evt) {
		setWidth();
	};	
	
	function <%="showhidetable"+reportID%>(){
		form = document.frmreport ;
		if(document.getElementById('<%="tableshowhide"+reportID%>').innerHTML == '[Show Table]'){		
			document.getElementById('<%="report" + reportID%>').style.display='';
			document.getElementById('<%="tableshowhide"+reportID%>').innerHTML="[Hide Table]";
		}else{
			document.getElementById('<%="tableshowhide"+reportID%>').innerHTML="[Show Table]";
			document.getElementById('<%="report" + reportID%>').style.display='none';
		}
	}
		
	function openShowBookmark()	{
		URL = '<%=request.getContextPath()%>/webpages/addbookmark.jsp?title='+title;
		handleThickBox(1,'bookmark',"500");
	}

</SCRIPT>
<SCRIPT SRC="<%=request.getContextPath()%>/javascript/ajax.js"></SCRIPT>
<script src="<%=request.getContextPath()%>/javascript/container.js"></script>
<script src="<%=request.getContextPath()%>/javascript/popupform.js"></script>
</head>
<body bgcolor="#EEEEFF" onload="setWidth();setData()"  onresize="setWidth()">
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
        
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>        
	
	<div class="maincontent" id="main_content">
	
		<jsp:include page="Date.jsp" flush="true">
		<jsp:param name="device"	value="<%=isDeviceCombo %>"></jsp:param>
		<jsp:param name="showtime"	value="<%=isShowTime %>"></jsp:param>
		</jsp:include>
		
		<div class="reporttitlebar">
		
		<%String truncatetitle=title.replaceAll("<i>|</i>","");
		%>
			<script language="javascript">title='<%=truncatetitle+title1%>';</script>
			<div class="reportnavigationtitle" title="<%=truncatetitle%>">
				<%=truncatetitle.length()>90?truncatetitle.substring(0,91)+"...":title%>
			</div>
			<div class="reporttitle" >
						<%=title1%>
			</div>
			<div class="reporttimetitle">
					&nbsp;&nbsp;							
					<b>From:</b> <font class="reporttime"> <%=session.getAttribute("startdate")%></font>
					<br><b>To:</b> <font class="reporttime"><%=session.getAttribute("enddate")%></font> 
			</div>
			
			<div class="pdflink">
				<img class="xlslink" src="../images/bookmark.png"  onclick="openShowBookmark();" title="Bookmark This Page">
			</div>
			
			<div class="pdflink">
				<a id="pdfLinkForSingle"  href="" onclick="getPDF('<%=reportID%>')">
					<img src="../images/PdfIcon.jpg" title="Export as PDF" class="pdflink"></img>
				</a>				
				
			</div>
			<div class="xlslink" title="Export As Excel">
				<a id="xlsLinkForSingle"  href="" onclick="getXLS('<%=reportID%>')">
					<img src="../images/csvIcon.jpg" title="Export as Excel" class="xlslink"></img>
				</a>				
			</div>	
		</div>		
		<div class="reportpair">
				<div id='<%=reportID%>' class="container"></div>
				<script type="text/javascript">
				function setData() {
					setQuaryString('<%=request.getQueryString()%>');
					setContextPath('<%=request.getContextPath()%>');
					
					<%
						int boolGraph = 1;
						int boolTable = 1;
					
						if(reportBean.getReportFormatId() == TabularReportConstants.TABLE_VIEW)	{
							boolGraph =0; // only table 
						} else if(reportBean.getReportFormatId() == TabularReportConstants.GRAPH_VIEW) {
							boolTable=0; //only graph
						}	
					%>
					
					setContainer('<%=reportID%>','',1,<%=boolGraph%>,<%=boolTable%>,<%=limit%>);
					setConWidth('<%=reportID%>','99.25%');
				<% if(isNavigation) { %>
					setNevigation('<%=reportID%>',[5,10,15,20,25,50,100,500,1000],1);
				<% } %>
					setImageWidth('<%=reportID%>',(document.body.clientWidth - 220));	
				//	alert(document.body.clientWidth - 220);
					setContPage('<%=reportID%>');						
				}
				</script> 			
		</div>
	</div>
	
	<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
	
	<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
	<div id="searchDiv" class="TB_window" style="width: 500px; left: 287px;">
		<form name="searchreport" onSubmit="return getSearchResult()">
		<input type="hidden" id="reportid" name="reportid" value="" />
		<input type="hidden" id="columnid" name="columnid" value="" />
			<div>
				<table width="100%" cellspacing="0" cellpadding="2" border="0">	
				<tr class="innerpageheader">
					<td width="3%">&nbsp;</td>
					<td id="searchHead" class="contHead">Search</td>
					<td align="right" style="padding-right: 5px; padding-top: 2px;" colspan="3">
						<img height="15" width="15" style="cursor: pointer;" onClick="hideSearch()" src="../images/close.jpg"/>
					</td>
				</tr>
				</table>
				<div align="center" style="margin: 5px;">
					<div style="border: 1px solid rgb(153, 153, 153); width: 95%;">
						<table width="100%" cellspacing="2" cellpadding="2" align="center">
						<tr>
							<td id="searchLabel" class="textfilterlabels">Search</td>
							<td class="textfilterlabels">
							<select name="searchCritValue">
							<option value="=" >is</option>
							<option value="!=" >is not</option>
							<option value="like" selected="selected">contains</option>
							<option value="not like" >does not contain</option>
							</select>
							</td>
							<td id="searchLabeltxt" align='Center'></td>
						</tr>
						</table>
					</div>
					<table align="center">
					<tr>
						<td colspan="2">
							<input type="submit" value="Search" name="confirm" class="criButton" />
							<input type="button" onClick="clearSearch()" value="Clear" class="criButton" />
							<input type="button" onClick="hideSearch()" value="Cancel" class="criButton"/>
						</td>
					</tr>
					</table>
				</div>
			</div>
		</form>
	</div>
	<div id="bubble_tooltip">
		<div class="bubble_top"><span></span></div>
		<div class="bubble_middle"><span id="bubble_tooltip_content"></span></div>
		<div class="bubble_bottom"></div>
	</div>
	<div class="TB_window" id="bookmark"></div>
			<%
				if(session.getAttribute("bookmarkstatus")!=null)
				{
			%>
					<script>alert('<%=session.getAttribute("bookmarkstatus").toString()%>');
					</script>
			<%
					session.removeAttribute("bookmarkstatus");
				}
			%>
</body>
</html>
<%
	}catch(Exception e){
	CyberoamLogger.appLog.debug("singlereport.jsp:e => " +e,e );
}
%>
