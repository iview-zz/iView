package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.beans.*;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.audit.CyberoamLogger;

public final class reportprofile_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n");

	try{
	if(CheckSession.checkSession(request,response)<0){
		return;
	}
		String pmsg = "";
		String nmsg = "";
		String strAppMode = request.getParameter("appmode");
		String strStatus = request.getParameter("status");
		int iAppmode=-1 ,iStatus=-1;
		if(strAppMode != null && !strAppMode.equalsIgnoreCase("")){
	iAppmode = Integer.parseInt(strAppMode);
		}
		if(strStatus != null && !strAppMode.equalsIgnoreCase("")){
	iStatus = Integer.parseInt(strStatus);
		}
		if(iAppmode>-1){
	if(iAppmode == ApplicationModes.ADD_REPORT_PROFILE && iStatus > 0){
		pmsg = TranslationHelper.getTranslatedMessge("Custom View Added Successfully.");
	}else if(iAppmode == ApplicationModes.ADD_REPORT_PROFILE && iStatus == -4){
		nmsg = TranslationHelper.getTranslatedMessge("Report profile with the same name already exist.");
	}else if(iAppmode == ApplicationModes.ADD_REPORT_PROFILE && iStatus <= 0){
		nmsg = TranslationHelper.getTranslatedMessge("Error while adding Custom View.");
	}else if(iAppmode == ApplicationModes.UPDATE_REPORT_PROFILE && iStatus > 0){
		pmsg = TranslationHelper.getTranslatedMessge("Custom View Updated Successfully.");
	}else if(iAppmode == ApplicationModes.UPDATE_REPORT_PROFILE && iStatus <= 0){
		nmsg = TranslationHelper.getTranslatedMessge("Error while updating Custom View.");
	}else if(iAppmode == ApplicationModes.DELETE_REPORT_PROFILE && iStatus > 0){
		pmsg = iStatus +" "+ TranslationHelper.getTranslatedMessge("Custom View Deleted Successfully.");
	}else if(iAppmode == ApplicationModes.DELETE_REPORT_PROFILE && iStatus == -4){
		nmsg = TranslationHelper.getTranslatedMessge("Error! View already in use with Report notification.");
	}else if(iAppmode == ApplicationModes.DELETE_REPORT_PROFILE && iStatus <= 0){
		nmsg = TranslationHelper.getTranslatedMessge("Error while deleting Custom View.");
	}
		}

      out.write("\n<html>\n<head>\n<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script language=\"JavaScript\" src=\"/javascript/cyberoam.js\"></script>\n<script type=\"text/javascript\">\n\twindow.onload = function (evt) {\n\t\tsetWidth();\t\t\t\t\n\t}\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 218);\t\n\t}\n\tfunction selectall(){ \n\t\tvar chk = document.getElementById(\"check1\");\n\t\tvar checkstmp = document.getElementsByName(\"select\");\n\t\tvar i;\n\t\tfor(i=0;i<checkstmp.length;i++){\n\t\t\tif(chk.checked==true){\n\t\t\t\tcheckstmp[i].checked=true;\n\t\t\t}\n\t\t\telse{\n\t\t\t\tcheckstmp[i].checked=false;\n\t\t\t}\n\t\t}\n\t}\n\n\tfunction deselectall(){\n\t\tvar chk = document.getElementById(\"check1\");\n\t\tvar checkstmp = document.getElementsByName(\"select\");\n\t\tvar i;\n\t\tfor(i=0;i<checkstmp.length;i++){\n\t\t\tif(checkstmp[i].checked==false){\n\t\t\t\tchk.checked=false;\n\t\t\t\tbreak;\n\t\t\t}\n\t\t}\n\t}\t\n\t\n\tfunction validateDelete(){\n\t\tflag = false;\n\t\telements = document.reportprofileform.select;\t\t\n\t\tif(elements.length == undefined){\t\t\t\n");
      out.write("\t\t\tif( elements.checked == true)\t\t\t\n\t\t\t\t\tflag = true;\n\t\t}else{\n\t\t\tfor( i=0;i<elements.length ; i++ ){\n\t\t\t\tif( elements[i].checked == true ){\n\t\t\t\t\tflag = true ;\n\t\t\t\t\tbreak;\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t\tif(!flag){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("You must select atleast one profile"));
      out.write("\");\n\t\t\treturn false;\n\t\t}\n\t\tvar con = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected Profile(s)?"));
      out.write("\");\n\t\tif (! con ){ \n\t\t\treturn false ;\n\t\t}\n\t\t//document.reportprofileform.profileid.value = profileId;\n\t\tdocument.reportprofileform.submit();\n\t}\n\t\n\t\n</script>\n</head>\n<body>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("  \n\t<div class=\"maincontent\" id=\"main_content\">\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Custom Views"));
      out.write("</div>\n\t\t</div>\n\t\t<br><br>\n\n\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"reportprofileform\" id=\"reportprofileform\">\n\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.DELETE_REPORT_PROFILE);
      out.write("\" >\n\t<input type=\"hidden\" name=\"profileid\" value=\"\" >\n\t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"margin-bottom: 2px;margin-left:2px;\">\n\t\t<tr>\n\t\t\t<td align=\"left\" class=\"ButtonBack\">\n\t\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Add"));
      out.write("\" onclick=\"location.href='");
      out.print(request.getContextPath());
      out.write("/webpages/managereportprofile.jsp'\">\n\t\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete"));
      out.write("\" onclick=\"return validateDelete()\">\n\t\t\t</td>\n\t\t</tr>\n\t\t</table>\n\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 2px;margin-left:2px;\">\n");

 	if(!"".equals(pmsg)){

      out.write("\n\t\t<tr>\n\t\t\t<td class=\"message\">\n\t\t\t\t<font class=\"posimessage\">");
      out.print(pmsg);
      out.write("</font>\n\t\t\t</td>\n\t\t</tr>\n");

	}

      out.write('\n');

 	if(!"".equals(nmsg)){
 
      out.write("\n\t<tr>\n\t\t<td class=\"message\">\n\t\t\t<font class=\"nagimessage\">");
      out.print(nmsg);
      out.write("</font>\n\t\t</td>\n\t</tr>\n");

	}

      out.write("\n\t<tr>\n\t\t<td>\n\t\t\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"TableData\">\n\t\t\t<tr>\n\t\t\t\t<td class=\"tdhead\" align=\"center\" width=\"8%\"><input type=checkbox id=\"check1\" name=check1 onClick=\"selectall()\"></td>\n\t\t\t\t<td class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Custom View Name"));
      out.write("</td>\n\t\t\t\t<td class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Custom View Description"));
      out.write("</td>\n\t\t\t\t\n\t\t\t</tr>\n");

			int profileCnt = 0;
		    int categoryid;
			String rowStyle = "trdark";
			Iterator reportGroupBeanItr = ReportGroupBean.getReportGroupBeanIterator();
			ReportGroupBean reportGroupBean = null;
			while(reportGroupBeanItr.hasNext()){
				reportGroupBean = (ReportGroupBean)reportGroupBeanItr.next();
				if(reportGroupBean.getGroupType() == ReportGroupBean.DYNAMIC_GROUP){
					//categoryid=CategoryReportGroupRelationBean.getCategoryIdByReportGroupId(reportGroupBean.getReportGroupId());
					categoryid = reportGroupBean.getCategoryId();
					profileCnt++; 
					if(profileCnt%2 == 0)
						rowStyle = "trlight";
					else 
						rowStyle = "trdark";

      out.write("\n\t\t\t<tr class=\"");
      out.print(rowStyle);
      out.write("\">\n\t\t\t\t<td class=\"tddata\" align=\"center\"><!-- <img src=\"");
      out.print(request.getContextPath());
      out.write("/images/delete.bmp\" title=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete"));
      out.write("\" onClick=\"deleteProfile('");
      out.print(reportGroupBean.getReportGroupId());
      out.write("')\" width=\"25px\" height=\"20px\"> -->\n\t\t\t\t<input type=\"checkbox\"  name=\"select\" value=\"");
      out.print(reportGroupBean.getReportGroupId());
      out.write("\" onClick=\"deselectall()\">\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\">\n\t\t\t\t\t<a href=\"");
      out.print(request.getContextPath());
      out.write("/webpages/managereportprofile.jsp?profileid=");
      out.print(reportGroupBean.getReportGroupId());
      out.write("&category=");
      out.print(categoryid);
      out.write('"');
      out.write('>');
      out.print(reportGroupBean.getTitle());
      out.write("</a>\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\">");
      out.print(reportGroupBean.getDescription());
      out.write("&nbsp;</td>\n\t\t\t</tr>\n");

		}
	}
	if(profileCnt == 0 ){

      out.write("\n\t\t\t<tr class=\"trdark\">\n\t\t\t\t<td class=\"tddata\" colspan=\"3\" align=\"center\">");
      out.print(TranslationHelper.getTranslatedMessge("Custom View Not Available"));
      out.write("</td>\n\t\t\t</tr>\n");
					
	}

      out.write("\t\n\t\t\t</table>\n\t\t</td>\n\t</tr>\n\t</table>\n\t</form>\n\t</div>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n</body>\n</html>\n");

	}catch(Exception  e){
		CyberoamLogger.appLog.debug("Exception in reportprofile.jsp : "+e,e);
		out.println(e);
}

      out.write('\n');
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
