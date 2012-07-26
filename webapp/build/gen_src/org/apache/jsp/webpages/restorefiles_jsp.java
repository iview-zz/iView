package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.File;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.mlm.TranslationHelper;

public final class restorefiles_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n<html>\n<head>\n<style type=\"text/css\">\n.loadButton{\n\tborder: 0px;\n\tbackground: transparent;\n\tfont-family: Verdana,Arial,Helvetica,sans-serif; \n\tfont-size: 11px;\n\ttext-decoration: underline;\n}\n.loadButton1{\n\tborder: 0px;\n\tbackground: transparent;\n\tfont-family: Verdana,Arial,Helvetica,sans-serif; \n\tfont-size: 11px;\n\ttext-decoration: none;\n}\n</style>\n</head>\n  \n<body>\n\n<div>\n<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview?appmode=");
      out.print(ApplicationModes.ARCHIEVE_RESTORE_REQUEST);
      out.write("\" enctype=\"multipart/form-data\" method=\"post\" name=\"frmRestore\">\n\t<table cellpadding=\"2\" cellspacing=\"0\" width=\"100%\" border=\"0\">\t\n\t\t<tr class=\"innerpageheader\">\n\t\t\t<td width=\"3%\">&nbsp;</td>\n\t\t\t<td class=\"contHead\">Restore Files</td>\n\t\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleThickBox('2','backuprestore')\" style=\"cursor: pointer;\">\n\t\t\t</td>\n\t\t</tr>\n\t</table>\n<div style=\"margin:5px\" align=\"center\">\n<div style=\"width:95%;border:1px solid #999999;\">\n\n<table name=\"data\" class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n\t<tbody id=\"tbldata\">\n\t<tr height=\"25px\">\n\t\t<td class=\"tdhead\" style=\"padding-left:10px\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Filename"));
      out.write("</b></td>\n\t\t<td align=\"center\" class=\"tdhead\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Action"));
      out.write("</b></td>\n\t</tr>\n\t\n\t\n\t<tr height=\"25px\">\n\t\t<td class=\"tddata\"><input type=\"file\" name=\"filename\" id=\"filename0\"></td>\n\t\t<td class=\"tddata\" align=\"center\">\n\t\t<input type=\"button\" onclick=\"addRow();\" class=\"loadButton\" onmouseover=\"this.className = 'loadButton1'\" onmouseout=\"this.className = 'loadButton'\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Add"));
      out.write("\">\t\t\n\t\t</td>\n\t</tr>\t\t\t\n\t</tbody>\n</table>\n\n</div>\n</div>\n\n\t<table align=\"center\">\n\t<tr>\n\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t<input type=\"submit\" id=\"btnRestore\" class=\"criButton\" name=\"confirm\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Restore"));
      out.write("\" onClick=\"return checkRestore(this);\">\n\t\t\t<input type=\"button\" class=\"criButton\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Cancel"));
      out.write("\" onclick=\"handleThickBox('2','backuprestore')\">\n\t\t</td>\n\t</tr>\n\t</table>\n\n</form>\t\n</div>\n</body>\n</html>\n");
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
