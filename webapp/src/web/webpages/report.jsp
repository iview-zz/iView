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

<%@page import="java.io.PrintWriter"%>
<%@page import="org.cyberoam.iviewdb.utility.ResultSetWrapper"%>
<%@page import="org.cyberoam.iviewdb.utility.SqlReader"%>
<%@page import="org.cyberoam.iview.utility.PrepareQuery"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%>
<%@page import="org.cyberoam.iview.helper.TabularReportGenerator"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.charts.Chart"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.ReportBean"%>
<%
try {
	if(CheckSession.checkSession(request,response)<0) return;
	response.setHeader("Cache-control","no-cache");
	response.setHeader("Cache-control","no-store");
	response.setDateHeader("Expires",0);
	response.setHeader("Pragma","no-cache");
	
	String reportID=request.getParameter("reportid");
	ReportBean reportBean = null;
	String url = request.getContextPath() + "/webpages/singlereport.jsp?" + request.getQueryString();
%>
<html>
<head></head>
<body bgcolor="#EEEEFF">
<div id='<%=reportID%>' class="container"></div>
	<script type="text/javascript">
	<%
	if(reportID!=null && !"".equalsIgnoreCase(reportID) && !"null".equalsIgnoreCase(reportID)){
		reportBean = ReportBean.getRecordbyPrimarykey(Integer.parseInt(request.getParameter("reportid")));
	%>
		setSortOnColumn(false);
		setQuaryString('<%=request.getQueryString()%>');
		setContextPath('<%=request.getContextPath()%>');
		<%
		int boolGraph = 1;
		int boolTable = 1;
	
		if(reportBean.getReportFormatId() == TabularReportConstants.TABLE_VIEW) {
			boolGraph =0; // only table 
		} else if(reportBean.getReportFormatId() == TabularReportConstants.GRAPH_VIEW) {
			boolTable=0; //only graph
		}	
	%>
		setContainer('<%=reportID%>','<%= reportBean.getTitle() %>',0,<%=boolGraph%>,<%=boolTable%>,5);
		
		setConWidth('<%=reportID%>','99%');
		setImageWidth('<%=reportID%>',parseInt((document.body.clientWidth - 264)/2));
		setImageHeight('<%=reportID%>',200);
		setViewAllLink(true);
		setContPage('<%=reportID%>');
	<%	}	%>
	</script>
</body>
</html>

<%
}catch(Exception e){
	CyberoamLogger.appLog.debug("report.jsp:e => " +e,e );
}
%>

			
