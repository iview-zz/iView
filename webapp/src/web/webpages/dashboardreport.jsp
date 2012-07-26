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

<%@page import="org.cyberoam.iviewdb.utility.ResultSetWrapper"%>
<%@page import="org.cyberoam.iviewdb.utility.SqlReader"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.cyberoam.iview.helper.TabularReportGenerator"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>

<%
	ReportBean reportBean = null;
	PrepareQuery prepareQuery = null;
	ResultSetWrapper rsw = null;
	SqlReader sqlReader = null;
	String title = null;
	String reportQuery = null;
	String reportID = null;
	String isColumned = null;
	boolean columned = false;
	
	try {
		if(CheckSession.checkSession(request,response)<0){
	return;
		}
		/*response.setHeader("Cache-control","no-cache");
		response.setHeader("Cache-control","no-store");	
		response.setHeader("Pragma","no-cache");
		response.setDateHeader("Expires",0);*/
		
		reportID = request.getParameter("reportid");
		isColumned = request.getParameter("columned");
		columned = Boolean.parseBoolean(isColumned);		
		if(reportID != null && !"".equals(reportID.trim())) {
	reportBean = ReportBean.getRecordbyPrimarykey(reportID);	    
		} else {
	return;
		}
		
		title = reportBean.getTitle();
		String limit="5";
		prepareQuery = new PrepareQuery();	
		sqlReader = new SqlReader(false);	
		
		reportQuery = prepareQuery.getQuery(reportBean, request);	
		//rsw = sqlReader.getInstanceResultSetWrapper(reportQuery);
		try {
			rsw = sqlReader.getInstanceResultSetWrapper(reportQuery);
		} catch (org.postgresql.util.PSQLException e) {
			if (reportQuery.indexOf("5min_ts_20") > -1){
				reportQuery = reportQuery.substring(0,reportQuery.indexOf("5min_ts_20")) + "4hr" +reportQuery.substring(reportQuery.indexOf("5min_ts_20") + 16,reportQuery.length());
				if (reportQuery.indexOf("5min_ts_20") > -1){
					reportQuery = reportQuery.substring(0,reportQuery.indexOf("5min_ts_20")) + "4hr" +reportQuery.substring(reportQuery.indexOf("5min_ts_20") + 16,reportQuery.length());
				}						
				rsw = sqlReader.getInstanceResultSetWrapper(reportQuery);
				
			} else {
				CyberoamLogger.appLog.error("Exception in Dashboardreport.jsp "+e,e );
			}
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception in Dashboardreport.jsp "+e,e );
			rsw.close();
		}
		
		String startDate=(String)session.getAttribute("startdate");
		String endDate=(String)session.getAttribute("enddate");
		int boolGraph = 1;
		int boolTable = 1;
	
		if(reportBean.getReportFormatId() == TabularReportConstants.TABLE_VIEW) {
			boolGraph =0;
		} else if(reportBean.getReportFormatId() == TabularReportConstants.GRAPH_VIEW) {
			boolTable=0;
		}	
%>

<%
	int imgwd = Integer.parseInt(session.getAttribute("bodyWidth").toString());
	int imght = 250;
	
	imgwd = (imgwd - 213) - 30 ;
	String filename = Chart.getChartForWeb(request,new PrintWriter(out),rsw,imgwd,imght);
	String graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
%>


<%@page import="org.cyberoam.iview.charts.Chart"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.beans.ReportBean"%>
<%@page import="org.cyberoam.iview.utility.PrepareQuery"%><SCRIPT language=javascript>	
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
</SCRIPT>


<div id='<%=reportID%>' class="container"></div>
	<script type="text/javascript">	
		setContainer('<%=reportID%>','<%=TranslationHelper.getTranslatedMessge(reportBean.getTitle())%>',0,<%=boolGraph%>,<%=boolTable%>,<%=limit%>);
	<%if(boolGraph == 1){%>
		setGraph('<%=reportID%>','<%=graphURL%>','<%=filename%>','<%=imgwd%>','<%=imght%>');			
	<%}%>
	<%if(boolTable == 1){%>
			setTable('<%=reportID%>',<%=TabularReportGenerator.getBody(request,rsw,true)%>);		 
	<%}%>
	</script>

<%
	} catch(Exception e) {
		CyberoamLogger.appLog.error("Exception occured in dashboardreport.jsp: " + e, e);
	} finally {
		if(rsw != null) {
	try {
		rsw.close();
	} catch(Exception e) {}
		}
		if(sqlReader != null) {
	try {
		sqlReader.close();
	} catch(Exception e) {}			
		}
	}
%>

			
