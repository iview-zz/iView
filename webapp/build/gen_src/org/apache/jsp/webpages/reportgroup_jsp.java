package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import org.cyberoam.iview.beans.*;
import org.cyberoam.iview.utility.CheckSession;
import java.util.StringTokenizer;
import java.text.MessageFormat;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.charts.Chart;

public final class reportgroup_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n");

	if(CheckSession.checkSession(request,response)<0){
		return;
	}
	
	int reportGroupID=Integer.parseInt(request.getParameter("reportgroupid"));
	ReportGroupBean reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
	ArrayList reportList= reportGroupBean.getReportIdByReportGroupId(reportGroupID);
	int reportID=0;
	/*
	*If report group contains only one group then singlereport.jsp will be displayed.
	*/
	if(reportList.size() == 1){
		reportID=((ReportGroupRelationBean)reportList.get(0)).getReportId();;
		response.sendRedirect(request.getContextPath() +"/webpages/singlereport.jsp?reportid=" +reportID +"&"+request.getQueryString());
		return;
	}
	
	boolean isPinOn = false;
	if(session.getAttribute("pinstatus") != null){
		isPinOn = session.getAttribute("pinstatus").toString().equals("on");
	}
	String isDeviceCombo = request.getParameter("device");
	if(isDeviceCombo == null || "".equalsIgnoreCase(isDeviceCombo) || !"false".equalsIgnoreCase(isDeviceCombo)){
		isDeviceCombo = "Date.jsp?device=true";
	} else {
		isDeviceCombo = "Date.jsp?device=false";
	}
	String url=request.getRequestURL().toString();
	String querystring=request.getQueryString();
	if(querystring.contains("&empty")){
		querystring=querystring.replace("&empty","&empt");
	}
	url+="?"+querystring;
	session.setAttribute("bookmarkurl",url);

      out.write("\n\n<html>\n\t<head>\n\t\t<title>");
      out.print( iViewConfigBean.TITLE );
      out.write("</title>\n\t\t<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n\t\t<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n \t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n \t\t<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></script>\n \t\t<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popup.js\"></script>\n \t\t<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script>\t\t\n\t\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ajax.js\"></SCRIPT>\n\t\t \n\t\t<script language=\"javascript\">\n\n\t\t\tvar title=\"\";\n\t\t\n\t\t\tfunction setWidth(){\n\t\t\t\tvar main_div = document.getElementById(\"main_content\");\n\t\t\t\tmain_div.style.width = (document.body.clientWidth - 218);\n\t\t\t}\n\t\t\n\t\t\twindow.onload = function (evt) {\n\t\t\t\tsetWidth();\n\t\t\t};\t\n\t\t\t\n\t\t\tfunction replaceQueryString(url,param,value) {\n\t\t\t\t\t\t\tvar re = new RegExp(\"([?|&])\" + param + \"=.*?(&|$)\",\"i\");\n\t\t\t    if (url.match(re))\n\t\t\t        return url.replace(re,'$1' + param + \"=\" + value + '$2');\n\t\t\t    else\n\t\t\t        return url + '&' + param + \"=\" + value;\n\t\t\t}\n\t\t\t\n\t\t\tfunction openURL(){\n\t\t\t\tvar index=document.frmlimit.limit.selectedIndex;\n\t\t\t\tvar limit=document.frmlimit.limit.options[index].value;\n\t\t\t\tvar finalhref=location.href;\n\t\t\t\tvar queryString='");
      out.print(request.getQueryString() );
      out.write("';\n\t\t\t\tif(limit == 15)\n\t\t\t\t\tfinalhref=replaceQueryString(finalhref,\"graph\",\"false\");\n\t\t\t\telse finalhref=replaceQueryString(finalhref,\"graph\",\"true\");\n\t\t\t\tfinalhref=replaceQueryString(finalhref,\"limit\",limit);\n\t\t\t\tlocation.href=finalhref;\n\t\t\t}\n\t\t\n\t\t\tfunction invokeAjaxURL(url, mode){\n\t\t\t\ttry { \n\t\t\t\t\tajaxObject = getAjaxObject();\n\t\t\t\t\tajaxObject.open(mode, url, true);\n\t\t\t\t\tajaxObject.onreadystatechange = processResolveIP; \n\t\t\t\t\tajaxObject.send('');\n\t\t\t\t}catch(e){\n\t\t\t\t\talert(\"Problem in sending request to Cyberoam Server:\" + e);\n\t\t\t\t}\n\t\t\t}\n\t\t\tfunction resolveallip(){\n\t\t\t\turl=\"");
      out.print(request.getContextPath());
      out.write("\" + \"/AjaxController?resolvedns=1\";\n\t\t\t\tinvokeAjaxURL(url,\"get\");\n\t\t\t}\n\t\t\t\n\t\t\tfunction processResolveIP(){\t\t\t\t\n\t\t\t\ttry{\n\t\t\t\t\tif(ajaxObject.readyState == 4){\n\t\t\t\t\t\tdocument.location.href = unescape(window.location.pathname+\"?\" + \"");
      out.print(request.getQueryString());
      out.write("\");\n\t\t\t\t\t}\n\t\t\t\t}catch(e){\n\t\t\t\t\talert('processResponse problem' +e );\n\t\t\t\t}\n\t\t\t}\n\t\t\tfunction showhideallTables(){\n\t\t\t\t");

					for(int i=0;i<reportList.size();i++){
						if(((ReportGroupRelationBean)reportList.get(i)).getRowOrder()/10 == 1){
							reportID=((ReportGroupRelationBean)reportList.get(i)).getReportId();
							out.println("showHideTable('"+reportID+"');");
						}
					}
				
      out.write("\n\t\t\t}\n\t\t\tfunction openShowBookmark()\t{\n\t\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addbookmark.jsp?title='+title;\n\t\t\t\thandleThickBox(1,'bookmark',\"500\");\n\t\t\t}\n\t\t\t\n\t\t</script>\n</head>\n<body onload=\"setWidth()\">\n  \t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\n        \n        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("  \n\n\t\t<div class=\"maincontent\" id=\"main_content\">\t\t\t\t\t\t\t\t\n\t\n\t\t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response,  isDeviceCombo , out, true);
      out.write("\t\t\n\t\t\t\n\t\t\t<div class=\"reporttitlebar\">\n\t\t\t\t");

					String title= Chart.getFormattedTitle(request,reportGroupBean,false) ;
				
      out.write("\n\t\t\t\t");
String truncatetitle=title.replaceAll("<i>|</i>","");	
					
      out.write("\n\t\t\t\t\t<script language=\"javascript\">title='");
      out.print(truncatetitle);
      out.write("';</script>\n\t\t\t\t<div class=\"reporttitle\" title=\"");
      out.print(truncatetitle);
      out.write("\">\n\t\t\t\t\t\t");
      out.print(truncatetitle.length()>90?truncatetitle.substring(0,91)+"...":title);
      out.write("\t\n\t\t\t</div>\n\t\t\t\t<div class=\"reporttimetitle\">\n\t\t\t\t\t&nbsp;&nbsp;\n\t\t\t\t\t<b>From:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("startdate") );
      out.write("</font>\n\t\t\t\t\t</br><b>To:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("enddate") );
      out.write("</font> \n\t\t\t\t</div> \t\n\t\t\t\t\t\n\t\t\t\t<div class=\"pdflink\">\n\t\t\t\t\t<img class=\"xlslink\" src=\"../images/bookmark.png\"  onclick=\"openShowBookmark();\" title=\"Bookmark This Page\">\t\t\t\t\n\t\t\t\t</div>\n\t\t\t\t\n\t\t\t\t<div class=\"pdflink\">\n\t\t\t\t<a id=\"pdfLinkForGroup\" href=\"\"  onclick=getPDF('");
      out.print(reportID);
      out.write("')>\n\t\t\t\t\t<img src=\"../images/PdfIcon.jpg\" class=\"pdflink\"></img>\n\t\t\t\t</a>\t\n\t\t\t\t</div>\n\t\t\t\t\n\t\t\t\t<div class=\"xlslink\">\n\t\t\t\t<a id=\"xlsLinkForGroup\" href=\"\"  onclick=getXLS('");
      out.print(reportID);
      out.write("')>\n\t\t\t\t\t<img src=\"../images/csvIcon.jpg\" class=\"xlslink\"></img>\n\t\t\t\t</a>\t\n\t\t\t\t</div>\n\t\t\t</table>\n\t\t\t</form>\n            \n            \n            </div> \n\t\t\t\n\t\t\n\t\t\t");
 	
				int lastRowOrder=1;
				for(int i=0;i<reportList.size();i++){
					
					ReportGroupRelationBean reportGroupRelationBean=(ReportGroupRelationBean)reportList.get(i);
			  
					reportID=reportGroupRelationBean.getReportId();
					int order=reportGroupRelationBean.getRowOrder();
					if (i % 2 == 0) {
						
      out.write("\n\n\t\t\t\t\t\t\t<div class=\"reportpair\">\n\t");
						
					}
					if(order == 1){
	
      out.write("\n\t\t\t\t\t\t<div class=\"dashreport\">\n\t");
				}else{
	
      out.write("\n\t\t\t\t\t\t<div class=\"report\">\n\t");
 } 
      out.write("\t\t\t\t\t\t\n                        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/webpages/report.jsp?reportid=" +reportID +"&"+request.getQueryString() , out, true);
      out.write("\n\t\t\t\t</div>\n\t\t\t\t\n\t\t\t");

					if (i % 2 != 0 || i == (reportList.size() -1)) {
						
      out.write("\n                        \t</div>\n                        ");

					}
			   }
				
			
      out.write("\t\n\t\t\n\t\t\t\n\t \t</div>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n\t\t<div id=\"searchDiv\" class=\"TB_window\" style=\"width: 450px; left: 287px;\">\n\t\t<form name=\"searchreport\" onsubmit=\"return getSearchResult()\">\n\t\t<input type=\"hidden\" id=\"reportid\" name=\"reportid\" value=\"\" />\n\t\t<input type=\"hidden\" id=\"columnid\" name=\"columnid\" value=\"\" />\n\t\t\t<div>\n\t\t\t\t<table width=\"100%\" cellspacing=\"0\" cellpadding=\"2\" border=\"0\">\t\n\t\t\t\t<tr class=\"innerpageheader\">\n\t\t\t\t\t<td width=\"3%\">&nbsp;</td>\n\t\t\t\t\t<td id=\"searchHead\" class=\"contHead\">Search</td>\n\t\t\t\t\t<td align=\"right\" style=\"padding-right: 5px; padding-top: 2px;\" colspan=\"3\">\n\t\t\t\t\t\t<img height=\"15\" width=\"15\" style=\"cursor: pointer;\" onclick=\"hideSearch()\" src=\"../images/close.jpg\"/>\n\t\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t\t<div align=\"center\" style=\"margin: 5px;\">\n\t\t\t\t\t<div style=\"border: 1px solid rgb(153, 153, 153); width: 95%;\">\n\t\t\t\t\t\t<table width=\"100%\" cellspacing=\"2\" cellpadding=\"2\" align=\"center\">\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t<td id=\"searchLabel\" class=\"textlabels\">Search</td>\n");
      out.write("\t\t\t\t\t\t\t<td class=\"textlabels\">\n\t\t\t\t\t\t\t<select name=\"searchCritValue\">\n\t\t\t\t\t\t\t<option value=\"=\" >is</option>\n\t\t\t\t\t\t\t<option value=\"!=\" >is not</option>\n\t\t\t\t\t\t\t<option value=\"like\" selected=\"selected\">contains</option>\n\t\t\t\t\t\t\t<option value=\"not like\" >does not contain</option>\n\t\t\t\t\t\t\t</select>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td id=\"searchLabeltxt\" ></td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t</table>\n\t\t\t\t\t</div>\n\t\t\t\t\t<table align=\"center\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td colspan=\"2\">\n\t\t\t\t\t\t\t<input type=\"submit\" value=\"Search\" name=\"confirm\" class=\"criButton\" />\n\t\t\t\t\t\t\t<input type=\"button\" onclick=\"hideSearch()\" value=\"Cancel\" class=\"criButton\"/>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t\t</form>\n\t\t</div>\n\t\t<div id=\"bubble_tooltip\">\n\t\t\t<div class=\"bubble_top\"><span></span></div>\n\t\t\t<div class=\"bubble_middle\"><span id=\"bubble_tooltip_content\"></span></div>\n\t\t\t<div class=\"bubble_bottom\"></div>\n\t\t</div>\n\t\t<div class=\"TB_window\" id=\"bookmark\"></div>\n\t\t\t");

				if(session.getAttribute("bookmarkstatus")!=null)
				{
			
      out.write("\n\t\t\t\t\t<script>alert('");
      out.print(session.getAttribute("bookmarkstatus").toString());
      out.write("');\n\t\t\t\t\t</script>\n\t\t\t");

					session.removeAttribute("bookmarkstatus");
				}
			
      out.write("\n\t</body>\n</html>\n\t\t\n");
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
