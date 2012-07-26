package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.*;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.modes.ApplicationModes;

public final class garnerport_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- ***********************************************************************\r\n*  provides network visibility for security, regulatory compliance and \r\n*  data confidentiality \r\n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\r\n*  \r\n*  This program is free software: you can redistribute it and/or modify \r\n*  it under the terms of the GNU General Public License as published by \r\n*  the Free Software Foundation, either version 3 of the License, or\r\n*  (at your option) any later version.\r\n*  \r\n*  This program is distributed in the hope that it will be useful, but \r\n*  WITHOUT ANY WARRANTY; without even the implied warranty of \r\n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \r\n*  General Public License for more details.\r\n*  \r\n*  You should have received a copy of the GNU General Public License \r\n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\r\n*  \r\n*  The interactive user interfaces in modified source and object code \r\n*  versions of this program must display Appropriate Legal Notices, as \r\n");
      out.write("*  required under Section 5 of the GNU General Public License version 3.\r\n*  \r\n*  In accordance with Section 7(b) of the GNU General Public License \r\n*  version 3, these Appropriate Legal Notices must retain the display of\r\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\r\n*********************************************************************** -->\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n");

	try{
		if(CheckSession.checkSession(request,response)<0){
			return;
		}
		
		String strStatus = request.getParameter("status");
		int iStatus = -1;
		if(strStatus != null && !"null".equalsIgnoreCase(strStatus)){
			iStatus = Integer.parseInt(strStatus);
		}
		String appmode = request.getParameter("appmode");
		int iMode = -1;
		if(appmode != null && !"null".equalsIgnoreCase(appmode)){
			iMode = Integer.parseInt(appmode);
		}
		
		String pmessage = "";
		String nmessage = "";
		String msgType= "";
		if(iMode == ApplicationModes.GARNER_PORT_CHANGE && iStatus > 0){
	pmessage = TranslationHelper.getTranslatedMessge("Configuration updated successfully.");
		} else if(iMode == ApplicationModes.GARNER_PORT_CHANGE && iStatus <= 0){
			if(iStatus==-2){
				nmessage = TranslationHelper.getTranslatedMessge("Port already in Use by another process please give another port.");	
			}
			else{
		   nmessage = TranslationHelper.getTranslatedMessge("Error in Configuration updation.");
			}
		}

      out.write("\r\n<html>\r\n<head>\r\n<title>");
      out.print( iViewConfigBean.TITLE );
      out.write("</title>\r\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\r\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\">\r\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\">\r\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/SearchData.js\"></script>\r\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></script>\r\n<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ipvalidation.js\"></script>\r\n<script type=\"text/javascript\" language=\"javascript\">\r\n  \twindow.onload = function (evt) {\r\n\t\tsetWidth();\t\t\r\n\t}\t\t\r\n\tfunction setWidth(){\r\n\t\tvar main_div = document.getElementById(\"main_content\");\t\r\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\r\n\t}\r\n\tfunction submitForm(){\r\n\t\tvar garnerport=document.getElementById(\"garnerport\");\r\n\t\t\r\n\t\tif(isValidPort(garnerport.value)){\r\n\t\t\tvar con = confirm('");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to update configuration?"));
      out.write("');\r\n\t\t\treturn con;\r\n\t\t}else {\r\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("Please Enter valid Syslog Server Port."));
      out.write("');\r\n\t\t\treturn false;\r\n\t\t}\r\n\t}\r\n   \t\r\n\t\t\r\n</script>\r\n</head>\r\n<body>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \r\n<div class=\"maincontent\" id=\"main_content\">\r\n\t\t<div class=\"reporttitlebar\">\r\n\t\t\t<div class=\"reporttitlebarleft\"></div>\r\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Syslog Server Port Configuration"));
      out.write("\r\n\t\t\t</div>\r\n\t\t</div>\t\t\r\n\t\t<br><br>\r\n<div style=\"float:left;margin-left:2px;margin-top:3px;width:100%;\">\r\n\t<form  action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=post name=ftpsearchform onsubmit=\"return submitForm();\">\r\n\t\r\n\t<input type=hidden name=appmode value=\"");
      out.print(ApplicationModes.GARNER_PORT_CHANGE);
      out.write("\">\r\n\t<table cellspacing=\"0\" cellpadding=\"2px\" border=\"0\" width=\"100%\"  >\r\n\t");

	if(!"".equals(pmessage)){
	
      out.write("\r\n\t<tr>\r\n\t\t<td  colspan=\"4\" class=\"posimessage\" >&nbsp;&nbsp;");
      out.print(pmessage);
      out.write("</td>\r\n\t</tr>\r\n");

	}

      out.write('\r');
      out.write('\n');

	if(!"".equals(nmessage)){

      out.write("\r\n\t<tr>\r\n\t\t<td  colspan=\"4\"  class=\"nagimessage\">&nbsp;&nbsp;");
      out.print(nmessage);
      out.write("</td>\r\n\t</tr>\r\n");

	}

      out.write("\r\n\t<table border=\"0\" cellpadding=\"2\" cellspacing=\"2\" >\r\n\t\t\t<tr >\r\n\t\t\t\t<td class=\"textlabels\" >&nbsp;\r\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Syslog Server Port"));
      out.write("<font class=\"compfield\">*</font>\r\n\t\t\t\t</td>\r\n\t\t\t\t<td >\r\n\t\t\t\t\t<input type=\"text\" class=\"datafield\" name=\"garnerport\" id=\"garnerport\" value=\"");
      out.print(iViewConfigBean.getValueByKey("GarnerPort"));
      out.write("\" style=\"width:80px\"/>\r\n\t\t\t\t</td>\r\n\t\t\t\t</tr>\r\n\t\t</table>\r\n\t\t<br>\r\n\t\t<tr>\t\t\r\n\t\t    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\r\n\t\t\t<td align=\"left\" style>\t\t\r\n\t\t\t<input type=submit name=save  class=criButton value=\"Save\">\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t</table>\t\r\n\t</form>\r\n</div>\r\n</div>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\r\n</body>\r\n");

	} catch(Exception e) {
	}

      out.write("\r\n</html>\r\n");
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
