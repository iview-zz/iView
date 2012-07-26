package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class pagefooter_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=utf-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			"", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- ***********************************************************************\n*  Cyberoam iView - The Intelligent logging and reporting solution that \n*  provides network visibility for security, regulatory compliance and \n*  data confidentiality \n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\n*  \n*  This program is free software: you can redistribute it and/or modify \n*  it under the terms of the GNU General Public License as published by \n*  the Free Software Foundation, either version 3 of the License, or\n*  (at your option) any later version.\n*  \n*  This program is distributed in the hope that it will be useful, but \n*  WITHOUT ANY WARRANTY; without even the implied warranty of \n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \n*  General Public License for more details.\n*  \n*  You should have received a copy of the GNU General Public License \n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\n*  \n*  The interactive user interfaces in modified source and object code \n");
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html>\n<head>\n<script type=\"text/javascript\"> \nfunction resize(){ \n\tvar htmlheight = document.body.parentNode.clientHeight; \n\tvar windowheight = window.screen.height; \n\tvar sidebar = document.getElementById(\"sidebar\"); \n\tif ( htmlheight < windowheight )\t { \n\t\tsidebar.style.height = windowheight + \"px\";\n\t} \n} \n</script> \n</head>\n<body>\n<script> resize();</script>\n<table width=\"100%\" border=\"0\" class=\"pagefooter\" cellpadding=\"0\" cellspacing=\"0\">\n<tr>\n\t<td align=\"center\" class=\"footerHead\">&copy;&nbsp;&nbsp;Elitecore Technologies Ltd.</td>\n");
      out.write("</tr>\n<tr>\n\t<td align=\"center\" class=\"footerBody\">The Program is provided AS IS, without warranty. Licensed under <a target=\"_blank\"  class=\"pagefooterlink\" href=\"");
      out.print(request.getContextPath());
      out.write("/LICENSE.txt\" style=\"color:#08467C\">GPLv3</a>. This program is free software; you can redistribute it and/or modify it under the terms of the <a target=\"_blank\" class=\"pagefooterlink\" href=\"");
      out.print(request.getContextPath());
      out.write("/LICENSE.txt\" style=\"color:#08467C\">GNU General Public License version 3</a> as published by the Free Software Foundation including the additional permission set forth in the source code header.</td>\n</tr>\n<tr>\t\n\t<td align=\"center\"><img style=\"cursor:pointer\" src=\"../images/InitiativeLogo.png\" onclick=\"window.open('http://www.cyberoam.com','blank')\" /></td>\n</tr>\n</table>\n</body>\n</html>\n");
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
