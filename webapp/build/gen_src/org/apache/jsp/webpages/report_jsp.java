package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.PrintWriter;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;
import org.cyberoam.iview.utility.PrepareQuery;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.helper.TabularReportGenerator;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.charts.Chart;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.ReportBean;

public final class report_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n");

try {
	if(CheckSession.checkSession(request,response)<0) return;
	response.setHeader("Cache-control","no-cache");
	response.setHeader("Cache-control","no-store");
	response.setDateHeader("Expires",0);
	response.setHeader("Pragma","no-cache");
	
	String reportID=request.getParameter("reportid");
	ReportBean reportBean = null;
	String url = request.getContextPath() + "/webpages/singlereport.jsp?" + request.getQueryString();

      out.write("\n<html>\n<head></head>\n<body bgcolor=\"#EEEEFF\">\n<div id='");
      out.print(reportID);
      out.write("' class=\"container\"></div>\n\t<script type=\"text/javascript\">\n\t");

	if(reportID!=null && !"".equalsIgnoreCase(reportID) && !"null".equalsIgnoreCase(reportID)){
		reportBean = ReportBean.getRecordbyPrimarykey(Integer.parseInt(request.getParameter("reportid")));
	
      out.write("\n\t\tsetSortOnColumn(false);\n\t\tsetQuaryString('");
      out.print(request.getQueryString());
      out.write("');\n\t\tsetContextPath('");
      out.print(request.getContextPath());
      out.write("');\n\t\t");

		int boolGraph = 1;
		int boolTable = 1;
	
		if(reportBean.getReportFormatId() == TabularReportConstants.TABLE_VIEW) {
			boolGraph =0; // only table 
		} else if(reportBean.getReportFormatId() == TabularReportConstants.GRAPH_VIEW) {
			boolTable=0; //only graph
		}	
	
      out.write("\n\t\tsetContainer('");
      out.print(reportID);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print( reportBean.getTitle() );
      out.write("',0,");
      out.print(boolGraph);
      out.write(',');
      out.print(boolTable);
      out.write(",5);\n\t\t\n\t\tsetConWidth('");
      out.print(reportID);
      out.write("','99%');\n\t\tsetImageWidth('");
      out.print(reportID);
      out.write("',parseInt((document.body.clientWidth - 264)/2));\n\t\tsetImageHeight('");
      out.print(reportID);
      out.write("',200);\n\t\tsetViewAllLink(true);\n\t\tsetContPage('");
      out.print(reportID);
      out.write("');\n\t");
	}	
      out.write("\n\t</script>\n</body>\n</html>\n\n");

}catch(Exception e){
	CyberoamLogger.appLog.debug("report.jsp:e => " +e,e );
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
