package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;
import java.io.PrintWriter;
import org.cyberoam.iview.helper.TabularReportGenerator;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.charts.Chart;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.utility.PrepareQuery;

public final class dashboardreport_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- ***********************************************************************\n*  Cyberoam iView - The Intelligent logging and reporting solution that \n*  provides network visibility for security, regulatory compliance and \n*  data confidentiality \n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\n*  \n*  This program is free software: you can redistribute it and/or modify \n*  it under the terms of the GNU General Public License as published by \n*  the Free Software Foundation, either version 3 of the License, or\n*  (at your option) any later version.\n*  \n*  This program is distributed in the hope that it will be useful, but \n*  WITHOUT ANY WARRANTY; without even the implied warranty of \n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \n*  General Public License for more details.\n*  \n*  You should have received a copy of the GNU General Public License \n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\n*  \n*  The interactive user interfaces in modified source and object code \n");
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n");

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

      out.write('\n');
      out.write('\n');

	int imgwd = Integer.parseInt(session.getAttribute("bodyWidth").toString());
	int imght = 250;
	
	imgwd = (imgwd - 213) - 30 ;
	String filename = Chart.getChartForWeb(request,new PrintWriter(out),rsw,imgwd,imght);
	String graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;

      out.write("\n\n\n\n\n\n<SCRIPT language=javascript>\t\n\tfunction ");
      out.print("showhidetable"+reportID);
      out.write("(){\n\t\tform = document.frmreport ;\n\t\tif(document.getElementById('");
      out.print("tableshowhide"+reportID);
      out.write("').innerHTML == '[Show Table]'){\t\t\n\t\t\tdocument.getElementById('");
      out.print("report" + reportID);
      out.write("').style.display='';\n\t\t\tdocument.getElementById('");
      out.print("tableshowhide"+reportID);
      out.write("').innerHTML=\"[Hide Table]\";\n\t\t}else{\n\t\t\tdocument.getElementById('");
      out.print("tableshowhide"+reportID);
      out.write("').innerHTML=\"[Show Table]\";\n\t\t\tdocument.getElementById('");
      out.print("report" + reportID);
      out.write("').style.display='none';\n\t\t}\n\t}\n</SCRIPT>\n\n\n<div id='");
      out.print(reportID);
      out.write("' class=\"container\"></div>\n\t<script type=\"text/javascript\">\t\n\t\tsetContainer('");
      out.print(reportID);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(TranslationHelper.getTranslatedMessge(reportBean.getTitle()));
      out.write("',0,");
      out.print(boolGraph);
      out.write(',');
      out.print(boolTable);
      out.write(',');
      out.print(limit);
      out.write(");\n\t");
if(boolGraph == 1){
      out.write("\n\t\tsetGraph('");
      out.print(reportID);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(graphURL);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(filename);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(imgwd);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(imght);
      out.write("');\t\t\t\n\t");
}
      out.write('\n');
      out.write('	');
if(boolTable == 1){
      out.write("\n\t\t\tsetTable('");
      out.print(reportID);
      out.write('\'');
      out.write(',');
      out.print(TabularReportGenerator.getBody(request,rsw,true));
      out.write(");\t\t \n\t");
}
      out.write("\n\t</script>\n\n");

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

      out.write("\n\n\t\t\t\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
