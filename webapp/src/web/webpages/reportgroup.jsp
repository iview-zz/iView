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

<%@page import="java.util.ArrayList"%>
<%@page import="org.cyberoam.iview.beans.*"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	if(CheckSession.checkSession(request,response)<0){
		return;
	}
	
	int reportGroupID=Integer.parseInt(request.getParameter("reportgroupid"));
	ReportGroupBean reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
	ArrayList reportList= reportGroupBean.getReportIdByReportGroupId(reportGroupID);
	int reportID=0;
	/*
	*If report group contains only one group then singlereport.jsp will be displayed.
	*/
	if(reportList.size() == 1){
		reportID=((ReportGroupRelationBean)reportList.get(0)).getReportId();;
		response.sendRedirect(request.getContextPath() +"/webpages/singlereport.jsp?reportid=" +reportID +"&"+request.getQueryString());
		return;
	}
	
	boolean isPinOn = false;
	if(session.getAttribute("pinstatus") != null){
		isPinOn = session.getAttribute("pinstatus").toString().equals("on");
	}
	String isDeviceCombo = request.getParameter("device");
	if(isDeviceCombo == null || "".equalsIgnoreCase(isDeviceCombo) || !"false".equalsIgnoreCase(isDeviceCombo)){
		isDeviceCombo = "Date.jsp?device=true";
	} else {
		isDeviceCombo = "Date.jsp?device=false";
	}
	String url=request.getRequestURL().toString();
	String querystring=request.getQueryString();
	if(querystring.contains("&empty")){
		querystring=querystring.replace("&empty","&empt");
	}
	url+="?"+querystring;
	session.setAttribute("bookmarkurl",url);
%>

<%@page import="org.cyberoam.iview.charts.Chart"%><html>
	<head>
		<title><%= iViewConfigBean.TITLE %></title>
		<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
		<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
 		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
 		<script src="<%=request.getContextPath()%>/javascript/popupform.js"></script>
 		<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popup.js"></script>
 		<script src="<%=request.getContextPath()%>/javascript/container.js"></script>		
		<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/ajax.js"></SCRIPT>
		 
		<script language="javascript">

			var title="";
		
			function setWidth(){
				var main_div = document.getElementById("main_content");
				main_div.style.width = (document.body.clientWidth - 218);
			}
		
			window.onload = function (evt) {
				setWidth();
			};	
			
			function replaceQueryString(url,param,value) {
							var re = new RegExp("([?|&])" + param + "=.*?(&|$)","i");
			    if (url.match(re))
			        return url.replace(re,'$1' + param + "=" + value + '$2');
			    else
			        return url + '&' + param + "=" + value;
			}
			
			function openURL(){
				var index=document.frmlimit.limit.selectedIndex;
				var limit=document.frmlimit.limit.options[index].value;
				var finalhref=location.href;
				var queryString='<%=request.getQueryString() %>';
				if(limit == 15)
					finalhref=replaceQueryString(finalhref,"graph","false");
				else finalhref=replaceQueryString(finalhref,"graph","true");
				finalhref=replaceQueryString(finalhref,"limit",limit);
				location.href=finalhref;
			}
		
			function invokeAjaxURL(url, mode){
				try { 
					ajaxObject = getAjaxObject();
					ajaxObject.open(mode, url, true);
					ajaxObject.onreadystatechange = processResolveIP; 
					ajaxObject.send('');
				}catch(e){
					alert("Problem in sending request to Cyberoam Server:" + e);
				}
			}
			function resolveallip(){
				url="<%=request.getContextPath()%>" + "/AjaxController?resolvedns=1";
				invokeAjaxURL(url,"get");
			}
			
			function processResolveIP(){				
				try{
					if(ajaxObject.readyState == 4){
						document.location.href = unescape(window.location.pathname+"?" + "<%=request.getQueryString()%>");
					}
				}catch(e){
					alert('processResponse problem' +e );
				}
			}
			function showhideallTables(){
				<%
					for(int i=0;i<reportList.size();i++){
						if(((ReportGroupRelationBean)reportList.get(i)).getRowOrder()/10 == 1){
							reportID=((ReportGroupRelationBean)reportList.get(i)).getReportId();
							out.println("showHideTable('"+reportID+"');");
						}
					}
				%>
			}
			function openShowBookmark()	{
				URL = '<%=request.getContextPath()%>/webpages/addbookmark.jsp?title='+title;
				handleThickBox(1,'bookmark',"500");
			}
			
		</script>
</head>
<body onload="setWidth()">
  		<jsp:include page="menu.jsp" flush="true"></jsp:include>
        
        <jsp:include page="pageheader.jsp" flush="true"></jsp:include>  

		<div class="maincontent" id="main_content">								
	
			<jsp:include page="<%= isDeviceCombo %>" flush="true"></jsp:include>		
			
			<div class="reporttitlebar">
				<%
					String title= Chart.getFormattedTitle(request,reportGroupBean,false) ;
				%>
				<%String truncatetitle=title.replaceAll("<i>|</i>","");	
					%>
					<script language="javascript">title='<%=truncatetitle%>';</script>
				<div class="reporttitle" title="<%=truncatetitle%>">
						<%=truncatetitle.length()>90?truncatetitle.substring(0,91)+"...":title%>	
			</div>
				<div class="reporttimetitle">
					&nbsp;&nbsp;
					<b>From:</b> <font class="reporttime"><%=session.getAttribute("startdate") %></font>
					</br><b>To:</b> <font class="reporttime"><%=session.getAttribute("enddate") %></font> 
				</div> 	
					
				<div class="pdflink">
					<img class="xlslink" src="../images/bookmark.png"  onclick="openShowBookmark();" title="Bookmark This Page">				
				</div>
				
				<div class="pdflink">
				<a id="pdfLinkForGroup" href=""  onclick=getPDF('<%=reportID%>')>
					<img src="../images/PdfIcon.jpg" class="pdflink"></img>
				</a>	
				</div>
				
				<div class="xlslink">
				<a id="xlsLinkForGroup" href=""  onclick=getXLS('<%=reportID%>')>
					<img src="../images/csvIcon.jpg" class="xlslink"></img>
				</a>	
				</div>
			</table>
			</form>
            
            
            </div> 
			
		
			<% 	
				int lastRowOrder=1;
				for(int i=0;i<reportList.size();i++){
					
					ReportGroupRelationBean reportGroupRelationBean=(ReportGroupRelationBean)reportList.get(i);
			  
					reportID=reportGroupRelationBean.getReportId();
					int order=reportGroupRelationBean.getRowOrder();
					if (i % 2 == 0) {
						%>

							<div class="reportpair">
	<%						
					}
					if(order == 1){
	%>
						<div class="dashreport">
	<%				}else{
	%>
						<div class="report">
	<% } %>						
                        <jsp:include page='<%="/webpages/report.jsp?reportid=" +reportID +"&"+request.getQueryString() %>' flush="true"/>
				</div>
				
			<%
					if (i % 2 != 0 || i == (reportList.size() -1)) {
						%>
                        	</div>
                        <%
					}
			   }
				
			%>	
		
			
	 	</div>
	<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
		<div id="searchDiv" class="TB_window" style="width: 500px; left: 287px;">
		<form name="searchreport" onsubmit="return getSearchResult()">
		<input type="hidden" id="reportid" name="reportid" value="" />
		<input type="hidden" id="columnid" name="columnid" value="" />
			<div>
				<table width="100%" cellspacing="0" cellpadding="2" border="0">	
				<tr class="innerpageheader">
					<td width="3%">&nbsp;</td>
					<td id="searchHead" class="contHead">Search</td>
					<td align="right" style="padding-right: 5px; padding-top: 2px;" colspan="3">
						<img height="15" width="15" style="cursor: pointer;" onclick="hideSearch()" src="../images/close.jpg"/>
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
							<td id="searchLabeltxt" align='Center' ></td>
						</tr>
						</table>
					</div>
					<table align="center">
					<tr>
						<td colspan="2">
							<input type="submit" value="Search" name="confirm" class="criButton" />
							<input type="button" onClick="clearSearch()" value="Clear" class="criButton" />
							<input type="button" onclick="hideSearch()" value="Cancel" class="criButton"/>
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
		
