package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.*;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.iViewConfigBean;

public final class search_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n");

	try{
		if(CheckSession.checkSession(request,response)<0){
			return;
		}

      out.write("\n<html>\n<head>\n<title>");
      out.print( iViewConfigBean.TITLE );
      out.write("</title>\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\">\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/SearchData.js\"></script>\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></script>\n<script type=\"text/javascript\" language=\"javascript\">\n   \tvar http_request = false;\n   \tvar childwindow;\n   \tvar fieldArray = new Array(\"User\",\"Source\",\"Email Address\");\n   \tvar reportGroupId = new Array(\"26\",\"28\",\"29\");\n\tvar tablefieldArray = new Array(\"username\",\"srcip,host,victim,attacker\",\"sender,recipient\");\n\tvar criteriaArray = new Array(\"is\");\n\tvar criteriaValueArray = new Array(\"=\");\n\n\twindow.onload = function (evt) {\tsetWidth();\t\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n   \tfunction prepareCriteria(){\n   \t   \tif(document.advanceSearch.criteriavalue1.value == ''){\n   \t   \t   \talert(\"Please Enter Criteria Value.\");\n   \t   \t} else {\n\t   \t   \tvar url = \"");
      out.print( request.getContextPath() );
      out.write("/webpages/reportgroup.jsp?reportgroupid=\" + reportGroupId[document.advanceSearch.fieldlist1.selectedIndex];\n\t   \t   \tvar fieldList = (document.advanceSearch.fieldlist1.options[document.advanceSearch.fieldlist1.selectedIndex].value).split(\",\");\n\t   \t   \tfor(i=0; i<fieldList.length; i++){\n\t   \t   \t\turl += \"&\"+fieldList[i]+\"=\"+document.advanceSearch.criteriavalue1.value; \n\t   \t   \t}\n\t   \t\tlocation.href = url;\n   \t   \t}\n   \t   \treturn false;\n   \t}\n</script>\n</head>\n<body>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \n<div class=\"maincontent\" id=\"main_content\">\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp" + (("Date.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("device", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()), out, true);
      out.write("\n\n\t<div style=\"float: left;width: 100%;margin-top: 5px;\">\n\t<form name=\"advanceSearch\" action=\"");
      out.print(request.getContextPath());
      out.write("/webpages/search.jsp\" method=\"POST\" onsubmit=\"return prepareCriteria()\">\n\t\t<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n\t\t<tr>\n\t\t\t<td width=\"20px\" style=\"margin: 10px;\">&nbsp;</td>\n\t\t\t<td colspan=\"4\"><div class=\"reporttitle\" style=\"margin-left:10px\">");
      out.print( TranslationHelper.getTranslatedMessge("Criteria") );
      out.write("</div></td>\n\t\t</tr>\n\t\t<tr>\n\t\t\t<td width=\"20px\" style=\"margin: 10px;\">&nbsp;</td>\n\t\t\t<td style=\"padding: 10px;margin: 10px;\">\n\t\t\t\t<select id=\"fieldlist1\" name=\"fieldlist1\" style=\"font-weight:bold;font-size:11px;color:#2A576A\">\n\t\t\t\t\t<option value=\"username\">");
      out.print( TranslationHelper.getTranslatedMessge("Username") );
      out.write("</option>\n\t\t\t\t\t<option value=\"srcip,host,victim,attacker\">");
      out.print( TranslationHelper.getTranslatedMessge("Source Host") );
      out.write("</option>\n\t\t\t\t\t<option value=\"sender,recipient\">");
      out.print( TranslationHelper.getTranslatedMessge("Email Address") );
      out.write("</option>\n\t\t\t\t</select>\n\t\t\t</td>\n\t\t\t<td style=\"padding:10px;margin:10px;font-weight:bold;font-size:11px;color:#2A576A;\">equals</td>\n\t\t\t<td style=\"padding:10px;margin:10px;\">\n\t\t\t\t<input type=\"text\" name=\"criteriavalue1\" id=\"criteriavalue1\" style=\"font-weight:bold;font-size:11px;color:#2A576A\">\n\t\t\t</td>\n\t\t\t<td style=\"padding: 10px;margin: 10px;\">\n\t\t\t\t<input type=\"submit\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Go") );
      out.write("\" class=\"serButton\" style=\"color: #3B464A\"/>\n\t\t\t</td>\n\t\t</tr>\n\t\t</table>\n\t</form>\n\t</div>\n</div>\n");
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
