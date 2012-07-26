package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.*;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.modes.ApplicationModes;

public final class Checksum_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<!-- ***********************************************************************\n*  provides network visibility for security, regulatory compliance and \n*  data confidentiality \n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\n*  \n*  This program is free software: you can redistribute it and/or modify \n*  it under the terms of the GNU General Public License as published by \n*  the Free Software Foundation, either version 3 of the License, or\n*  (at your option) any later version.\n*  \n*  This program is distributed in the hope that it will be useful, but \n*  WITHOUT ANY WARRANTY; without even the implied warranty of \n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \n*  General Public License for more details.\n*  \n*  You should have received a copy of the GNU General Public License \n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\n*  \n*  The interactive user interfaces in modified source and object code \n*  versions of this program must display Appropriate Legal Notices, as \n");
      out.write("*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n");

	try{
		if(CheckSession.checkSession(request,response)<0){
			return;
		}
		
		String webusagechecksumval = iViewConfigBean.getValueByKey(iViewConfigBean.WEBUSAGE_CHECKSUM_VAL);
		String dhcpchecksumval= iViewConfigBean.getValueByKey(iViewConfigBean.DHCP_CHECKSUM_VAL);
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
		if(iMode == ApplicationModes.CHECKSUM_REQUEST && iStatus > 0){
	pmessage = TranslationHelper.getTranslatedMessge("Configuration updated successfully.");
		} else if(iMode == ApplicationModes.CHECKSUM_REQUEST && iStatus <= 0){
	nmessage = TranslationHelper.getTranslatedMessge("Error in Configuration updation.");
		}

      out.write("\n<html>\n<head>\n<title>");
      out.print( iViewConfigBean.TITLE );
      out.write("</title>\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/SearchData.js\"></script>\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></script>\n<script type=\"text/javascript\" language=\"javascript\">\n  \twindow.onload = function (evt) {\n\t\tsetWidth();\t\t\n\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n   \t\n\t\t\n</script>\n</head>\n<body>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \n<div class=\"maincontent\" id=\"main_content\">\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Checksum Configuration"));
      out.write("\n\t\t\t</div>\n\t\t</div>\t\t\n\t\t<br><br>\n<div style=\"float:left;margin-left:2px;margin-top:3px;width:100%;\">\n\t<form  action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=post name=ftpsearchform>\n\t\n\t<input type=hidden name=appmode value=\"");
      out.print(ApplicationModes.CHECKSUM_REQUEST);
      out.write("\">\n\t<table cellspacing=\"0\" cellpadding=\"2px\" border=\"0\" width=\"100%\"  >\n\t\t\t\n\t\n\t<table border=\"0\" cellpadding=\"2\" cellspacing=\"2\" class=\"TableData\">\n\t\n\t");

	if(!"".equals(pmessage)){
	
      out.write("\n\t<tr>\n\t\t<td  colspan=\"4\" class=\"posimessage\" >&nbsp;&nbsp;");
      out.print(pmessage);
      out.write("</td>\n\t</tr>\n");

	}

      out.write('\n');

	if(!"".equals(nmessage)){

      out.write("\n\t<tr>\n\t\t<td  colspan=\"4\"  class=\"nagimessage\">&nbsp;&nbsp;");
      out.print(nmessage);
      out.write("</td>\n\t</tr>\n");

	}

      out.write("\n\t<tr>\n\t   <td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Checksum Module"));
      out.write("</td>\n\t   <td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge(""));
      out.write("</td>\n\t</tr>\n\t\t<TR align=left>\n\t\t\t<td  width=\"20%\">\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("DHCP") );
      out.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t</td>\n\t\t\t\n\t\t\t<td align=\"left\">\n\t\t\t\t<input type=radio name=dhcpchecksum value=0 ");
      out.print(("0".equals(dhcpchecksumval))?"checked":"");
      out.write(" />\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Disable") );
      out.write("\n\t\t\t    <input type=radio name=dhcpchecksum value=1 ");
      out.print(("1".equals(dhcpchecksumval))?"checked":"");
      out.write(" />\n\t\t\t    ");
      out.print( TranslationHelper.getTranslatedMessge("Enable") );
      out.write("\t\t\t    \n\t\t\t</td>\n\t\t</TR>\t\t\n\t\t<TR align=left>\n\t\t\t<td>\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Web Usage") );
      out.write("\n\t\t\t</td>\n\t\t\t\n\t\t\t<td align=\"left\">\n\t\t\t\t<input type=radio name=webusagechecksum value=0  ");
      out.print(("0".equals(webusagechecksumval))?"checked":"");
      out.write("/>\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Disable") );
      out.write("\n\t\t\t    <input type=radio name=webusagechecksum value=1 ");
      out.print(("1".equals(webusagechecksumval))?"checked":"");
      out.write("/>\n\t\t\t    ");
      out.print( TranslationHelper.getTranslatedMessge("Enable") );
      out.write("\n\t\t\t</td>\n\t\t</TR>\n\t\t</table>\n\t\t<br>\n\t\t<tr>\t\t\n\t\t    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n\t\t\t<td align=\"left\">\t\t\n\t\t\t<input type=submit name=save  class=criButton value=\"Save\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t</td>\n\t\t</tr>\n\t</table>\t\n\t</form>\n</div>\n</div>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n</body>\n");

	} catch(Exception e) {
	}

      out.write("\n</html>\n");
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
