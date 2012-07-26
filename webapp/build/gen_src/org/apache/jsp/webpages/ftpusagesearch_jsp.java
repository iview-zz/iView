package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.*;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.iViewConfigBean;

public final class ftpusagesearch_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("/javascript/utilities.js\"></script>\n<script type=\"text/javascript\" language=\"javascript\">\n   \tvar http_request = false;\n   \tvar childwindow;\n   \tvar fieldArray = new Array(\"User\",\"Source\",\"Email Address\");\n   \tvar reportGroupId = new Array(\"26\",\"28\",\"29\");\n\tvar tablefieldArray = new Array(\"username\",\"srcip,host,victim,attacker\",\"sender,recipient\");\n\tvar criteriaArray = new Array(\"is\");\n\tvar criteriaValueArray = new Array(\"=\");\n\n\twindow.onload = function (evt) {\n\t\tsetWidth();\t\t\n\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n   \t\n\tfunction checkSearchFor(){\n\n\t\tvar userfontdiv = document.getElementById(\"userfontdiv\");\n\t\tvar filefontdiv = document.getElementById(\"filefontdiv\");\n\t\t \t\t\n\t\tif(document.ftpsearchform.userorfile[0].checked){\n\t\t\t\tuserfontdiv.style.display='';\t\t\t\t\n\t\t\t\tfilefontdiv.style.display='none';\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t}else if(document.ftpsearchform.userorfile[1].checked){\n\t\t\t\tuserfontdiv.style.display='none';\t\t\t\t\n");
      out.write("\t\t\t\tfilefontdiv.style.display='';\t\t\t\t\n\t\t\t}\n\t\t}\n\t\n\tfunction checkfield(){\t\t\n\t\tvar username = document.getElementById(\"username\");\n\t\tvar filename = document.getElementById(\"filename\");\n\t\tif(document.ftpsearchform.userorfile[0].checked){\t\t\t\t\n\t\t\tusername.value = '%' + document.getElementById(\"nametxt\").value + '%';\t\t\t\n\t\t\tfilename.value='%';\t\t\t\n\t\t}else if(document.ftpsearchform.userorfile[1].checked){\n\t\t\tfilename.value='%' + document.getElementById(\"nametxt\").value + '%';\n\t\t\tusername.value='%';\t\t\t\n\t\t}\n\t\treturn true;\n\t}\n\t/*function setTextUsername(){\n\t\tif(");
      out.print(request.getSession().getAttribute("clipboarddata")!=null);
      out.write(" && (copyData==undefined || copyData=='')){\t\t\n\t\t\tcopyData='");
      out.print(request.getSession().getAttribute("clipboarddata"));
      out.write("';\n\t\t}\t\n\t\tdocument.getElementById(\"usernametxt\").value=copyData;\n\t}*/\n</script>\n</head>\n<body>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \n<div class=\"maincontent\" id=\"main_content\">\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp" + (("Date.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("device", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()) + "&" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("showtime", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()), out, true);
      out.write("\n<div class=\"reporttitlebar\">\n\t\t<div class=\"reporttitle\">\n\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Search FTP Usage Report") );
      out.write("\n\t\t</div>\n</div>\n<div style=\"float:left;margin-left:2px;margin-top:3px;width:100%;\">\n\t\t<form onsubmit = \"return checkfield();\" action=\"singlereport.jsp\" method=get name=ftpsearchform>\n\t\t<input type=\"hidden\"  name=\"reportid\" id=\"reportid\" value=\"50040100\" />\n\t\t<input type=\"hidden\"  name=\"reportgroupid\" id=\"reportgroupid\" value=\"50040\" />\n\t\t<input type=\"hidden\"  name=\"username\" id=\"username\" value=\"\" />\n\t\t<input type=\"hidden\"  name=\"filename\" id=\"filename\" value=\"\" />\n\t\t<input type=\"hidden\"  name=\"showtime\" id=\"showtime\" value=\"true\" />\n\t\t<table cellspacing=\"0\" cellpadding=\"2px\" border=\"0\" width=\"100%\" class=\"TableData\" style=\"\">\n\t\t<TR align=left>\n\t\t\t<td  width=\"20%\">\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Transfer Type") );
      out.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t</td>\n\t\t\t<td align=\"left\">\n\t\t\t\t<input type=radio name=direction value=1 checked onclick =\"\">\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Download") );
      out.write("\n\t\t\t    <input type=radio name=direction value=0 onclick =\"\">\n\t\t\t    ");
      out.print( TranslationHelper.getTranslatedMessge("Upload") );
      out.write("\n\t\t\t    <input type=radio name=direction value=\"2\" onclick =\"\" checked>\n\t\t\t    ");
      out.print( TranslationHelper.getTranslatedMessge("Any") );
      out.write("\n\t\t\t</td>\n\t\t</TR>\t\t\n\t\t<TR align=left>\n\t\t\t<td>\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Search For") );
      out.write("\n\t\t\t</td>\n\t\t\t<td align=\"left\">\n\t\t\t\t<input type=radio name=userorfile value=\"username\" onclick =\"checkSearchFor();\" checked>\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("User") );
      out.write("\n\t\t\t    <input type=radio name=userorfile value=\"filename\" onclick =\"checkSearchFor();\" />\n\t\t\t    ");
      out.print( TranslationHelper.getTranslatedMessge("File") );
      out.write("\n\t\t\t</td>\n\t\t</TR>\n\t\t<TR>\n\t\t\t<TD>\n\t\t\t\t<div id=\"userfontdiv\" style=\"display:\">\n\t\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("User Name") );
      out.write("\n\t\t\t\t</div>\n\t\t\t\t<div id=\"filefontdiv\" style=\"display:none\">\n\t\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("File Name") );
      out.write("\n\t\t\t\t</div>\n\t\t\t</TD>\n\t\t\t<TD>\t\t\t\t\n\t\t\t\t\t<input type=text name=nametxt id=nametxt value=\"\">\t\t\t\t\n\t\t\t</td>\n\t\t</TR>\n\t\t\t\n\t\t</table>\n\t\t<center>\n\t\t\t<input type=submit name=search style=\"margin-top:8px\" class=criButton value=\"Search\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t</center>\n\t</form>\n</div>\n</div>\n");
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
