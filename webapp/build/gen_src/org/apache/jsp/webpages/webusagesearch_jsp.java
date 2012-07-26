package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.text.*;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.*;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.servlets.AjaxController;

public final class webusagesearch_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n");

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
      out.write("/javascript/utilities.js\"></script>\n<script type=\"text/javascript\" language=\"javascript\">\n   \tvar http_request = false;\n   \tvar childwindow;\n   \tvar fieldArray = new Array(\"User\",\"Source\",\"Email Address\");\n   \tvar reportGroupId = new Array(\"26\",\"28\",\"29\");\n\tvar tablefieldArray = new Array(\"username\",\"srcip,host,victim,attacker\",\"sender,recipient\");\n\tvar criteriaArray = new Array(\"is\");\n\tvar criteriaValueArray = new Array(\"=\");\n\n\twindow.onload = function (evt) {\tsetWidth();\t\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n\n  \tfunction checkSearchType(){\n\t\tif(true ){\n\n\t\t\tvar userfontdiv = document.getElementById(\"userfontdiv\");\n\t\t\tvar usernamediv = document.getElementById(\"usernamediv\");\n\t\t\tvar groupfontdiv = document.getElementById(\"groupfontdiv\");\n\t\t\tvar groupnamediv = document.getElementById(\"groupnamediv\");\n\t\t\tvar sitenametr = document.getElementById(\"sitenametr\");\n\t\t\tvar categorynametr = document.getElementById(\"categorynametr\");\n");
      out.write("\t\t\tvar domainlbl = document.getElementById(\"domaindiv\");\n\t\t\tvar domainurllbl = document.getElementById(\"domainurl\");\n\t\t\t\n\t\t\tif(document.websearchform.reportdetailtype[0].checked){\n\t\t\t\t\n\t\t\t \tif( document.websearchform.searchtype[2].checked ){\n\t\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\t\treportid.value = 50020;\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = true;\n\t\t\t\t\tdocument.websearchform.userorgroup[0].checked = true;\n\t\t\t\t\tuserfontdiv.style.display='';\n\t\t\t\t\tusernamediv.style.display='';\n\t\t\t\t\tgroupfontdiv.style.display='none';\n\t\t\t\t\tgroupnamediv.style.display='none';\n\t\t\t\t\tsitenametr.style.display='none';\n\t\t\t\t\tcategorynametr.style.display='';\n\t\t\t\t}else if(document.websearchform.searchtype[0].checked){\n\t\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\t\treportid.value = 50000;\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = false;\n\t\t\t\t\tsitenametr.style.display='';\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t\tdomainlbl.style.display='';\n\t\t\t\t\tdomainurllbl.style.display='none';\n");
      out.write("\t\t\t\t\tcheckSearchFor();\t\t\t\n\t\t\t\t}else if(document.websearchform.searchtype[1].checked){\n\t\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\t\treportid.value = 50010;\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = false;\n\t\t\t\t\tsitenametr.style.display='';\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t\tdomainlbl.style.display='none';\n\t\t\t\t\tdomainurllbl.style.display='';\t\t\t\t\n\t\t\t\t\tcheckSearchFor();\t\t\t\n\t\t\t\t}else{\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = false;\n\t\t\t\t\tsitenametr.style.display='';\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t\tcheckSearchFor();\t\t\t\n\t\t\t\t}\n\t\t\t\n\t\t\t}else if(document.websearchform.reportdetailtype[1].checked){\n\t\t\t\t\n\t\t\t\tif( document.websearchform.searchtype[2].checked ){\n\t\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\t\treportid.value = 48000000;\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = true;\n\t\t\t\t\tdocument.websearchform.userorgroup[0].checked = true;\n\t\t\t\t\tuserfontdiv.style.display='';\n\t\t\t\t\tusernamediv.style.display='';\n\t\t\t\t\tgroupfontdiv.style.display='none';\n");
      out.write("\t\t\t\t\tgroupnamediv.style.display='none';\n\t\t\t\t\tsitenametr.style.display='none';\n\t\t\t\t\tcategorynametr.style.display='';\n\t\t\t\t}else if(document.websearchform.searchtype[0].checked){\n\t\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\t\treportid.value = 48000000;\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = false;\n\t\t\t\t\tsitenametr.style.display='';\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t\tdomainlbl.style.display='';\n\t\t\t\t\tdomainurllbl.style.display='none';\n\t\t\t\t\tcheckSearchFor();\t\t\t\n\t\t\t\t}else if(document.websearchform.searchtype[1].checked){\n\t\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\t\treportid.value = 48000000;\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = false;\n\t\t\t\t\tsitenametr.style.display='';\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t\tdomainlbl.style.display='none';\n\t\t\t\t\tdomainurllbl.style.display='';\t\t\t\t\n\t\t\t\t\tcheckSearchFor();\t\t\t\n\t\t\t\t}else{\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = false;\n\t\t\t\t\tsitenametr.style.display='';\n\t\t\t\t\tcategorynametr.style.display='none';\n");
      out.write("\t\t\t\t\tcheckSearchFor();\t\t\t\n\t\t\t\t}\n\t\t\t\t\n\t\t\t}\n\t\t\t\n\t\t}else {\n\t\t\tdocument.websearchform.userorgroup[1].disabled = false;\n\t\t\tcheckSearchFor();\n\t\t}\n\t}\n\t\n\tfunction checkSearchFor(){\n\n\t\tvar userfontdiv = document.getElementById(\"userfontdiv\");\n\t\tvar usernamediv = document.getElementById(\"usernamediv\");\n\t\tvar groupfontdiv = document.getElementById(\"groupfontdiv\");\n\t\tvar groupnamediv = document.getElementById(\"groupnamediv\");\n \t\tvar sitenametr = document.getElementById(\"sitenametr\");\n\t\tvar categorynametr = document.getElementById(\"categorynametr\");\n\n\t\tif(document.websearchform.reportdetailtype[0].checked){\n\t\t\tif(document.websearchform.userorgroup[0].checked){\n\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\tif(document.websearchform.searchtype[0].checked){\n\t\t\t\t\treportid.value = 50000;\n\t\t\t\t}else if(document.websearchform.searchtype[1].checked){\n\t\t\t\t\treportid.value = 50010;\n\t\t\t\t}\n\t\t\t\tuserfontdiv.style.display='';\n\t\t\t\tusernamediv.style.display='';\n\t\t\t\tgroupfontdiv.style.display='none';\n\t\t\t\tgroupnamediv.style.display='none';\t\n");
      out.write("\t\t\t\t\n\t\t\t\tif(document.websearchform.searchtype[2].checked){\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = true;\n\t\t\t\t\tdocument.websearchform.userorgroup[0].checked = true;\n\t\t\t\t\tsitenametr.style.display='none';\n\t\t\t\t\tcategorynametr.style.display='';\n\t\t\t\t}else{\n\t\t\t\t\tsitenametr.style.display='';\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t}\n\t\t\t\t\n\t\t\t}else if(document.websearchform.userorgroup[1].checked){\n\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\tif(document.websearchform.searchtype[0].checked){\n\t\t\t\t\treportid.value = 50030;\n\t\t\t\t}else if(document.websearchform.searchtype[1].checked){\n\t\t\t\t\treportid.value = 50040;\n\t\t\t\t}\n\t\t\t\tuserfontdiv.style.display='none';\n\t\t\t\tusernamediv.style.display='none';\n\t\t\t\tgroupfontdiv.style.display='';\n\t\t\t\tgroupnamediv.style.display='';\n\t\t\t\tsitenametr.style.display='';\n\t\t\t\tif(true){\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t}\n\t\t\t}\n\t\t}else if(document.websearchform.reportdetailtype[1].checked){\n\t\t\tif(document.websearchform.userorgroup[0].checked){\n\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n");
      out.write("\t\t\t\treportid.value = 48000000;\n\t\t\t\tuserfontdiv.style.display='';\n\t\t\t\tusernamediv.style.display='';\n\t\t\t\tgroupfontdiv.style.display='none';\n\t\t\t\tgroupnamediv.style.display='none';\t\n\t\t\t\t\n\t\t\t\tif(document.websearchform.searchtype[2].checked){\n\t\t\t\t\tdocument.websearchform.userorgroup[1].disabled = true;\n\t\t\t\t\tdocument.websearchform.userorgroup[0].checked = true;\n\t\t\t\t\tsitenametr.style.display='none';\n\t\t\t\t\tcategorynametr.style.display='';\n\t\t\t\t}else{\n\t\t\t\t\tsitenametr.style.display='';\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t}\n\t\t\t\t\n\t\t\t}else if(document.websearchform.userorgroup[1].checked){\n\t\t\t\tvar reportid = document.getElementById(\"reportid\");\n\t\t\t\treportid.value = 48000000;\n\t\t\t\tuserfontdiv.style.display='none';\n\t\t\t\tusernamediv.style.display='none';\n\t\t\t\tgroupfontdiv.style.display='';\n\t\t\t\tgroupnamediv.style.display='';\n\t\t\t\tsitenametr.style.display='';\n\t\t\t\tif(true){\n\t\t\t\t\tcategorynametr.style.display='none';\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t}\n\n\t\n\n\tfunction checkfield(){\t\t\n\t\tvar username = document.getElementById(\"username\");\n\t\tvar usergroup = document.getElementById(\"usergroup\");\n");
      out.write("\t\tvar domain = document.getElementById(\"domain\");\n\t\tvar category = document.getElementById(\"category\");\n\n\t\t\n\t\tusername.value = '%' + document.getElementById(\"usernametxt\").value + '%';\t\t\n\t\tusergroup.value = '%' + document.getElementById(\"groupnametxt\").value + '%';\n\t\tdomain.value = '%' + document.getElementById(\"domaintxt\").value + '%';\n\t\tcategory.value = '%' + document.getElementById(\"categorytxt\").value + '%';\n\t\t\n\t\treturn true;\n\t}\n\n/*\tfunction setTextUsername(){\n\t\tif(");
      out.print(request.getSession().getAttribute("clipboarddata")!=null);
      out.write(" && (copyData==undefined || copyData=='')){\t\t\n\t\t\tcopyData='");
      out.print(request.getSession().getAttribute("clipboarddata"));
      out.write("';\n\t\t}\t\n\t\tdocument.getElementById(\"usernametxt\").value=copyData;\n\t}*/\t\n\t\n</script>\n</head>\n<body>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \n<div class=\"maincontent\" id=\"main_content\">\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp" + (("Date.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("device", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()) + "&" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("showtime", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()), out, true);
      out.write("\n<div class=\"reporttitlebar\">\n\t\t<div class=\"reporttitle\">");
      out.print( TranslationHelper.getTranslatedMessge("Search Web Surfing Report") );
      out.write("\n\t\t</div>\n</div>\n<div style=\"float:left;margin-left:2px;margin-top:3px;width:100%;\">\n\t\t<form onsubmit = \"return checkfield();\" action=\"singlereport.jsp\" method=get name=websearchform>\n\t\t<input type=\"hidden\"  name=\"reportid\" id=\"reportid\" value=\"50000\" />\n\t\t<input type=\"hidden\"  name=\"reportgroupid\" id=\"reportgroupid\" value=\"50000\" />\n\t\t<input type=\"hidden\"  name=\"username\" id=\"username\" value=\"\" />\n\t\t<input type=\"hidden\"  name=\"usergroup\" id=\"usergroup\" value=\"\" />\n\t\t<input type=\"hidden\"  name=\"domain\" id=\"domain\" value=\"\" />\n\t\t<input type=\"hidden\"  name=\"category\" id=\"category\" value=\"\" />\n\t\t<input type=\"hidden\"  name=\"showtime\" id=\"showtime\" value=\"true\" />\n\t\t\t\t\n\t\t<table cellspacing=\"0\" cellpadding=\"2px\" border=\"0\" width=\"100%\" class=\"TableData\" style=\"\">\n\t\t<TR align=left>\n\t\t\t<td  width=\"20%\">\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Report Type") );
      out.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t</td>\n\t\t\t<td align=\"left\">\n\t\t\t\t<input type=radio name=reportdetailtype value=0 checked onclick =\"checkSearchType();\">\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Summary Report") );
      out.write("\n\t\t\t    <input type=radio name=reportdetailtype value=1 onclick =\"checkSearchType();\">\n\t\t\t    ");
      out.print( TranslationHelper.getTranslatedMessge("Detail Report") );
      out.write("\n\t\t\t</td>\n\t\t</TR>\n\t\t<TR align=left>\n\t\t\t<td  width=\"20%\">\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Search Type") );
      out.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t</td>\n\t\t\t<td align=\"left\">\n\t\t\t\t<input type=radio name=searchtype value=0  onclick =\"checkSearchType();\" checked>\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Domain") );
      out.write("\n\t\t\t    <input type=radio name=searchtype value=1 onclick =\"checkSearchType();\">\n\t\t\t    ");
      out.print( TranslationHelper.getTranslatedMessge("URL") );
      out.write("\n\t\t\t\t<input type=radio name=searchtype value=2 onclick =\"checkSearchType();\">\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Category") );
      out.write("\n\t\t\t</td>\n\t\t</TR>\n\t\t<TR align=left>\n\t\t\t<td>\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Search For") );
      out.write("\n\t\t\t</td>\n\t\t\t<td align=\"left\">\n\t\t\t\t<input type=radio name=userorgroup value=0 onclick =\"checkSearchFor();\" checked>\n\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("User") );
      out.write("\n\t\t\t    <input type=radio name=userorgroup value=1 onclick =\"checkSearchFor();\" />\n\t\t\t    ");
      out.print( TranslationHelper.getTranslatedMessge("Group") );
      out.write("\n\t\t\t</td>\n\t\t</TR>\n\t\t<TR>\n\t\t\t<TD>\n\t\t\t\t<div id=\"userfontdiv\" style=\"display:\">\n\t\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("User Name") );
      out.write("\n\t\t\t\t</div>\n\t\t\t\t<div id=\"groupfontdiv\" style=\"display:none\">\n\t\t\t\t\t");
      out.print( TranslationHelper.getTranslatedMessge("Group Name") );
      out.write("\n\t\t\t\t</div>\n\t\t\t</TD>\n\t\t\t<TD>\n\t\t\t\t<div id=\"usernamediv\" style=\"display:\">\n\t\t\t\t\t<input type=text name=usernametxt id=usernametxt value=\"\">\t\t\n\t\t\t\t</div>\n\t\t\t\t<div id=\"groupnamediv\" style=\"display:none\">\n\t\t\t\t\t<input type=text name=groupnametxt id=groupnametxt value=\"\">\n\t\t\t\t</div>\n\t\t\t</td>\n\t\t</TR>\n\t\t<TR id=\"sitenametr\" style=\"display:\">\n\t\t\t<TD>\n\t\t\t\t<div id=\"domaindiv\" style=\"display:\">");
      out.print( TranslationHelper.getTranslatedMessge("Domain") );
      out.write("</div>\n\t\t\t\t\t<div id=\"domainurl\" style=\"display:none\">");
      out.print( TranslationHelper.getTranslatedMessge("Domain URL") );
      out.write("</div>\n\t\t\t</TD>\n\t\t\t<TD>\n\t\t\t\t<input type=text name=\"domaintxt\" id=domaintxt value=\"\" >\n\t\t\t</td>\n\t\t</TR>\n\t\t<TR id=\"categorynametr\" style=\"display:none\">\n\t\t\t<TD>");
      out.print( TranslationHelper.getTranslatedMessge("Category Name") );
      out.write("</TD>\n\t\t\t<TD><input type=text name=categorytxt id=categorytxt value=\"\" ></td>\n\t\t</TR>\n\t\t</table>\n\t\t<center>\n\t\t\t<input type=submit name=search style=\"margin-top:8px\" class=criButton value=\"Search\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t</center>\n\t</form>\n</div>\n</div>\n");
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
