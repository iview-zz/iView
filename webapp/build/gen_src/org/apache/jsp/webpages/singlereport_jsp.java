package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.text.*;
import org.cyberoam.iview.charts.Chart;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.*;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.modes.TabularReportConstants;

public final class singlereport_jsp extends org.apache.jasper.runtime.HttpJspBase
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

	try {
	if(CheckSession.checkSession(request,response)<0){
		return;
	}
	ReportBean reportBean = null;
	if(request.getParameter("reportid")!=null && !"".equals(request.getParameter("reportid").trim())) {
		reportBean = ReportBean.getRecordbyPrimarykey(request.getParameter("reportid"));	    
	} else {
		return;
	}
	int reportGroupID=Integer.parseInt(request.getParameter("reportgroupid"));
	ReportGroupBean reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
	
	String title = Chart.getFormattedTitle(request,reportGroupBean,false) ;
	if(!reportGroupBean.getTitle().equals(reportBean.getDefaultTitle()) && reportBean.getDefaultTitle()!= null){
		if(!reportBean.getDefaultTitle().equals("") && !reportBean.getDefaultTitle().equals(reportBean.getDefaultTitle()))
			title +=" > "+ TranslationHelper.getTranslatedMessge(reportBean.getDefaultTitle());
	}
	String title1 = "";
	if(!reportBean.getTitle().equals(""))
		title1 =" > "+ TranslationHelper.getTranslatedMessge(reportBean.getTitle());
	if(title1 == ""){
		title1 = title.substring(title.lastIndexOf(">"));
		title = title.substring(title.lastIndexOf(">"));
	}
	String reportID=request.getParameter("reportid");
	int iReportID = Integer.parseInt(reportID);
	
	String limit = request.getParameter("limit");		
	if(limit != null)
		limit = (String)session.getAttribute("limit");
	if(limit == null)
		limit = "10";
	
	String isDeviceCombo = request.getParameter("device");
	if(isDeviceCombo == null || "".equalsIgnoreCase(isDeviceCombo) || !"false".equalsIgnoreCase(isDeviceCombo)){
		isDeviceCombo = "true";
	} else {
		isDeviceCombo = "false";
	}
	String isShowTime ="false"; 
	isShowTime = request.getParameter("showtime");
	if("true".equalsIgnoreCase(isShowTime) && !"".equalsIgnoreCase(isShowTime) && isShowTime!=null ){
		isShowTime="true";
	}else{
		isShowTime="false";	
	}	
		
	boolean isNavigation = true;
	if(request.getParameter("navigation") == null || "".equalsIgnoreCase(request.getParameter("navigation")) || !"false".equalsIgnoreCase(request.getParameter("navigation"))){
		isNavigation = true;
	} else {
		isNavigation = false;
	}
	String url=request.getRequestURL().toString();
	String querystring=request.getQueryString();
	if(querystring.contains("&empty")){
	querystring=querystring.replace("&empty","&empt");
	}
	url+="?"+querystring;
	session.setAttribute("bookmarkurl",url);

      out.write("\n\n\n<html>\n<head>\n<title>iView</title>\n<meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></SCRIPT>\n<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popup.js\"></script>\n<SCRIPT language=\"JavaScript\">\n\n\tvar title=\"\";\n\t\n\tfunction setWidth(){\n\t\t\n\t\tvar main_div = document.getElementById(\"main_content\");\n\t\tmain_div.style.width = (document.body.clientWidth - 218);\n\t}\n\t\n\twindow.onload = function (evt) {\n\t\tsetWidth();\n\t};\t\n\t\n\tfunction ");
      out.print("showhidetable"+reportID);
      out.write("(){\n\t\tform = document.frmreport ;\n\t\tif(document.getElementById('");
      out.print("tableshowhide"+reportID);
      out.write("').innerHTML == '[Show Table]'){\t\t\n\t\t\tdocument.getElementById('");
      out.print("report" + reportID);
      out.write("').style.display='';\n\t\t\tdocument.getElementById('");
      out.print("tableshowhide"+reportID);
      out.write("').innerHTML=\"[Hide Table]\";\n\t\t}else{\n\t\t\tdocument.getElementById('");
      out.print("tableshowhide"+reportID);
      out.write("').innerHTML=\"[Show Table]\";\n\t\t\tdocument.getElementById('");
      out.print("report" + reportID);
      out.write("').style.display='none';\n\t\t}\n\t}\n\t\t\n\tfunction openShowBookmark()\t{\n\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addbookmark.jsp?title='+title;\n\t\thandleThickBox(1,'bookmark',\"500\");\n\t}\n\n</SCRIPT>\n<SCRIPT SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ajax.js\"></SCRIPT>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></script>\n</head>\n<body bgcolor=\"#EEEEFF\" onload=\"setWidth();setData()\"  onresize=\"setWidth()\">\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\n        \n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \n\t\n\t<div class=\"maincontent\" id=\"main_content\">\n\t\n\t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp" + (("Date.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("device", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(isDeviceCombo ), request.getCharacterEncoding()) + "&" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("showtime", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(isShowTime ), request.getCharacterEncoding()), out, true);
      out.write("\n\t\t\n\t\t<div class=\"reporttitlebar\">\n\t\t\n\t\t");
String truncatetitle=title.replaceAll("<i>|</i>","");
		
      out.write("\n\t\t\t<script language=\"javascript\">title='");
      out.print(truncatetitle+title1);
      out.write("';</script>\n\t\t\t<div class=\"reportnavigationtitle\" title=\"");
      out.print(truncatetitle);
      out.write("\">\n\t\t\t\t");
      out.print(truncatetitle.length()>90?truncatetitle.substring(0,91)+"...":title);
      out.write("\n\t\t\t</div>\n\t\t\t<div class=\"reporttitle\" >\n\t\t\t\t\t\t");
      out.print(title1);
      out.write("\n\t\t\t</div>\n\t\t\t<div class=\"reporttimetitle\">\n\t\t\t\t\t&nbsp;&nbsp;\t\t\t\t\t\t\t\n\t\t\t\t\t<b>From:</b> <font class=\"reporttime\"> ");
      out.print(session.getAttribute("startdate"));
      out.write("</font>\n\t\t\t\t\t<br><b>To:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("enddate"));
      out.write("</font> \n\t\t\t</div>\n\t\t\t\n\t\t\t<div class=\"pdflink\">\n\t\t\t\t<img class=\"xlslink\" src=\"../images/bookmark.png\"  onclick=\"openShowBookmark();\" title=\"Bookmark This Page\">\n\t\t\t</div>\n\t\t\t\n\t\t\t<div class=\"pdflink\">\n\t\t\t\t<a id=\"pdfLinkForSingle\"  href=\"\" onclick=\"getPDF('");
      out.print(reportID);
      out.write("')\">\n\t\t\t\t\t<img src=\"../images/PdfIcon.jpg\" title=\"Export as PDF\" class=\"pdflink\"></img>\n\t\t\t\t</a>\t\t\t\t\n\t\t\t\t\n\t\t\t</div>\n\t\t\t<div class=\"xlslink\" title=\"Export As Excel\">\n\t\t\t\t<a id=\"xlsLinkForSingle\"  href=\"\" onclick=\"getXLS('");
      out.print(reportID);
      out.write("')\">\n\t\t\t\t\t<img src=\"../images/csvIcon.jpg\" title=\"Export as Excel\" class=\"xlslink\"></img>\n\t\t\t\t</a>\t\t\t\t\n\t\t\t</div>\t\n\t\t</div>\t\t\n\t\t<div class=\"reportpair\">\n\t\t\t\t<div id='");
      out.print(reportID);
      out.write("' class=\"container\"></div>\n\t\t\t\t<script type=\"text/javascript\">\n\t\t\t\tfunction setData() {\n\t\t\t\t\tsetQuaryString('");
      out.print(request.getQueryString());
      out.write("');\n\t\t\t\t\tsetContextPath('");
      out.print(request.getContextPath());
      out.write("');\n\t\t\t\t\t\n\t\t\t\t\t");

						int boolGraph = 1;
						int boolTable = 1;
					
						if(reportBean.getReportFormatId() == TabularReportConstants.TABLE_VIEW)	{
							boolGraph =0; // only table 
						} else if(reportBean.getReportFormatId() == TabularReportConstants.GRAPH_VIEW) {
							boolTable=0; //only graph
						}	
					
      out.write("\n\t\t\t\t\t\n\t\t\t\t\tsetContainer('");
      out.print(reportID);
      out.write("','',1,");
      out.print(boolGraph);
      out.write(',');
      out.print(boolTable);
      out.write(',');
      out.print(limit);
      out.write(");\n\t\t\t\t\tsetConWidth('");
      out.print(reportID);
      out.write("','99.25%');\n\t\t\t\t");
 if(isNavigation) { 
      out.write("\n\t\t\t\t\tsetNevigation('");
      out.print(reportID);
      out.write("',[5,10,15,20,25,50,100,500,1000],1);\n\t\t\t\t");
 } 
      out.write("\n\t\t\t\t\tsetImageWidth('");
      out.print(reportID);
      out.write("',(document.body.clientWidth - 220));\t\n\t\t\t\t//\talert(document.body.clientWidth - 220);\n\t\t\t\t\tsetContPage('");
      out.print(reportID);
      out.write("');\t\t\t\t\t\t\n\t\t\t\t}\n\t\t\t\t</script> \t\t\t\n\t\t</div>\n\t</div>\n\t\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n\t\n\t<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n\t<div id=\"searchDiv\" class=\"TB_window\" style=\"width: 450px; left: 287px;\">\n\t\t<form name=\"searchreport\" onSubmit=\"return getSearchResult()\">\n\t\t<input type=\"hidden\" id=\"reportid\" name=\"reportid\" value=\"\" />\n\t\t<input type=\"hidden\" id=\"columnid\" name=\"columnid\" value=\"\" />\n\t\t\t<div>\n\t\t\t\t<table width=\"100%\" cellspacing=\"0\" cellpadding=\"2\" border=\"0\">\t\n\t\t\t\t<tr class=\"innerpageheader\">\n\t\t\t\t\t<td width=\"3%\">&nbsp;</td>\n\t\t\t\t\t<td id=\"searchHead\" class=\"contHead\">Search</td>\n\t\t\t\t\t<td align=\"right\" style=\"padding-right: 5px; padding-top: 2px;\" colspan=\"3\">\n\t\t\t\t\t\t<img height=\"15\" width=\"15\" style=\"cursor: pointer;\" onClick=\"hideSearch()\" src=\"../images/close.jpg\"/>\n\t\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t\t<div align=\"center\" style=\"margin: 5px;\">\n\t\t\t\t\t<div style=\"border: 1px solid rgb(153, 153, 153); width: 95%;\">\n\t\t\t\t\t\t<table width=\"100%\" cellspacing=\"2\" cellpadding=\"2\" align=\"center\">\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t<td id=\"searchLabel\" class=\"textlabels\">Search</td>\n");
      out.write("\t\t\t\t\t\t\t<td class=\"textlabels\">\n\t\t\t\t\t\t\t<select name=\"searchCritValue\">\n\t\t\t\t\t\t\t<option value=\"=\" >is</option>\n\t\t\t\t\t\t\t<option value=\"!=\" >is not</option>\n\t\t\t\t\t\t\t<option value=\"like\" selected=\"selected\">contains</option>\n\t\t\t\t\t\t\t<option value=\"not like\" >does not contain</option>\n\t\t\t\t\t\t\t</select>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td id=\"searchLabeltxt\" ></td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t</table>\n\t\t\t\t\t</div>\n\t\t\t\t\t<table align=\"center\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td colspan=\"2\">\n\t\t\t\t\t\t\t<input type=\"submit\" value=\"Search\" name=\"confirm\" class=\"criButton\" />\n\t\t\t\t\t\t\t<input type=\"button\" onClick=\"hideSearch()\" value=\"Cancel\" class=\"criButton\"/>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</form>\n\t</div>\n\t<div id=\"bubble_tooltip\">\n\t\t<div class=\"bubble_top\"><span></span></div>\n\t\t<div class=\"bubble_middle\"><span id=\"bubble_tooltip_content\"></span></div>\n\t\t<div class=\"bubble_bottom\"></div>\n\t</div>\n\t<div class=\"TB_window\" id=\"bookmark\"></div>\n\t\t\t");

				if(session.getAttribute("bookmarkstatus")!=null)
				{
			
      out.write("\n\t\t\t\t\t<script>alert('");
      out.print(session.getAttribute("bookmarkstatus").toString());
      out.write("');\n\t\t\t\t\t</script>\n\t\t\t");

					session.removeAttribute("bookmarkstatus");
				}
			
      out.write("\n</body>\n</html>\n");

	}catch(Exception e){
	CyberoamLogger.appLog.debug("singlereport.jsp:e => " +e,e );
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
