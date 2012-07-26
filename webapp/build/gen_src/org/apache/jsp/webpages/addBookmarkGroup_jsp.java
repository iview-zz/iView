package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.modes.ApplicationModes;

public final class addBookmarkGroup_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<!-- ***********************************************************************\n*  Cyberoam iView - The Intelligent logging and reporting solution that \n*  provides network visibility for security, regulatory compliance and \n*  data confidentiality \n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\n*  \n*  This program is free software: you can redistribute it and/or modify \n*  it under the terms of the GNU General Public License as published by \n*  the Free Software Foundation, either version 3 of the License, or\n*  (at your option) any later version.\n*  \n*  This program is distributed in the hope that it will be useful, but \n*  WITHOUT ANY WARRANTY; without even the implied warranty of \n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \n*  General Public License for more details.\n*  \n*  You should have received a copy of the GNU General Public License \n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\n*  \n*  The interactive user interfaces in modified source and object code \n");
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n********************************************************************** -->\n\n\n<html>\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\">\n\n<body>\n<div>\n<form name=\"bookmark\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" onsubmit=\"return checkBlankGroupname();\">\n\t<table cellpadding=\"2\" cellspacing=\"0\" width=\"100%\" border=\"0\">\t\n\t\t<tr class=\"innerpageheader\">\n\t\t\t<td width=\"3%\">&nbsp;</td>\n\t\t\t<td class=\"contHead\"><div id=\"formtitle\">Add Bookmark Group</div></td>\n\t\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" style=\"cursor: pointer;\" onclick=\"handleThickBox(2,'bookmarkgroup');\">\n\t\t\t</td>\n\t\t</tr>\n\t</table>\n\t\n<div style=\"margin:5px\" align=\"center\">\n<div style=\"width:95%;border:1px solid #999999;\">\n\t<table cellpadding=\"2\" cellspacing=\"2\" width=\"100%\" border=\"0\" style=\"background:#FFFFFF;\">\n\t\n\t<tr>\n\t<td>\n\t\t\t\n\t\t<input type=\"hidden\" name=\"appmode\" id=\"appmode\" value=\"");
      out.print(ApplicationModes.NEWBOOKMARKGROUP);
      out.write("\">\n\t\t\tBookmarkGroup Name : <input type=\"text\" name=\"bmg_name\" id=\"bmg_name\">\n\t\t</td>\n\t\t</tr>\n</table>\n</div>\n</div>\n\t<table align=\"center\">\n\t<tr>\n\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t<input type=\"submit\" class=\"criButton\" name=\"add\" id=\"add\" value=\"Add\">\n\t\t\t<input type=\"button\" class=\"criButton\" value=\"Close\" onclick=\"handleThickBox(2,'bookmarkgroup');\">\n\t\t</td>\n\t</tr>\n\t</table>\n</form>\t\n</div>\n</body>\n</html>\n\n");
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
