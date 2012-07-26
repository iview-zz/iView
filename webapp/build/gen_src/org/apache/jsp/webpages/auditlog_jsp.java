package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.audit.AuditLogHelper;

public final class auditlog_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html");
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
	if(CheckSession.checkSession(request,response)<0)
		return;
	String logOffset = request.getParameter("logOffset");
	int iLogOffset = 0;
	if(logOffset!=null && (!"null".equalsIgnoreCase(logOffset)) && (!"".equalsIgnoreCase(logOffset))){
		iLogOffset = Integer.parseInt(logOffset);
	}
	String logLimit = request.getParameter("logLimit");
	int ilogLimit = 15;
	if(logLimit!=null && (!"null".equalsIgnoreCase(logLimit)) && (!"".equalsIgnoreCase(logLimit))){
		ilogLimit = Integer.parseInt(logLimit);
	}

      out.write("\n\n<html>\n<head>\n<title>");
      out.print(iViewConfigBean.TITLE);
      out.write("</title>\n<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/grid.css\" />\n<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\" />\n<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" />\n<script language=\"Javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ajax.js\"></script>\n<script language=\"Javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script>\n<script language=\"Javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/combo.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/dhtmlxcommon.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/dhtmlxgrid.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/dhtmlxgridcell.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/dhtmlxgrid_filter.js\"></script>\n<script>\n\tvar mygrid;\n\tvar arrCat = new Array(\"Mail\", \"User\", \"Device\", \"Application\", \"Views\", \"Data\", \"Archive\", \"Report\");\n\tvar arrSev = new Array(\"Emergency\", \"Alert\", \"Critical\", \"Error\", \"Warning\", \"Notice\", \"Info\", \"Debug\");\n\n\tvar gridQString = \"");
      out.print(request.getContextPath());
      out.write("/iview?offset=\"+");
      out.print(iLogOffset);
      out.write("+\"&logLimit=\"+");
      out.print(ilogLimit);
      out.write("+\"&appmode=\"+");
      out.print(ApplicationModes.GET_AUDIT_LOGS);
      out.write("+\"&severity=-1&category=-1\";\n\tvar URL = \"");
      out.print(request.getContextPath());
      out.write("/webpages/auditlog.jsp?");
      out.print(request.getQueryString()==null?"":request.getQueryString());
      out.write("\";\n\twindow.onload = function (evt) {\n\t\tsetWidth();\n\t\tdoInitGrid();\n\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\n\t\tmain_div.style.width = (document.body.clientWidth - 215);\n\t}\n\tfunction replaceQueryString(url,param,value) {\n\t\tvar re = new RegExp(\"([?|&])\" + param + \"=.*?(&|$)\",\"i\");\n\t\tif (url.match(re)) {\n\t\t\treturn url.replace(re,'$1' + param + \"=\" + value + '$2');\n\t\t} else {\n\t\t\treturn url + '&' + param + \"=\" + value;\n\t\t}\n\t}\n\tfunction doInitGrid(){\n\t\tmygrid = new dhtmlXGridObject('auditlog_grid');\n\t\tmygrid.setImagePath(\"");
      out.print(request.getContextPath());
      out.write("/images/grid_images/\");\n\t\tmygrid.setHeader(\"Event Time,Category,Severity,Message,Username,IP Address\");\n\t\tmygrid.setInitWidths(\"125,100,100,*,100,100\");\n\t\tmygrid.setColAlign(\"center,left,left,left,left,left,left\");\n\t\tmygrid.setSkin(\"light\");\n\t\tmygrid.setColSorting(\"str,str,str,str,str,str\");\n\t\tmygrid.setColTypes(\"ro,ro,ro,ro,ro,ro\");\n\t\tmygrid.enableAutoHeigth(true,\"1000\");\n\t\tmygrid.init();\n\t\tmygrid.loadXML(gridQString, function(){\n\t\t\tmygrid.attachHeader(\",<div id='categ_flt'></div>,<div id='sever_flt'></div>,#text_filter,#text_filter,#text_filter\");\n\t\t\tvar categFlt = document.getElementById(\"categ_flt\").appendChild(document.getElementById(\"categ_flt_box\").childNodes[0]);\n\t\t\tvar severFlt = document.getElementById(\"sever_flt\").appendChild(document.getElementById(\"sever_flt_box\").childNodes[0]);\n\t\t\tpopulateSelect(severFlt, arrSev);\n\t\t\tpopulateSelect(categFlt, arrCat);\n\t\t\tmygrid.setSizes();\n\t\t});\n\t}\n\t//filter grid contnet based on values of two filter fields\n    function filterBy(){\n        var severVal = document.getElementById(\"sever_flt\").childNodes[0].value;\n");
      out.write("        var categVal = document.getElementById(\"categ_flt\").childNodes[0].value;\n        gridQString = replaceQueryString(gridQString,\"severity\",severVal);\n        gridQString = replaceQueryString(gridQString,\"category\",categVal);\n        mygrid.clearAll();\n        mygrid.loadXML(gridQString);\n    }\n    function populateSelect(selObj, arrEle){\n        selObj.options.add(new Option(\"All\",\"-1\"));\n        for(i=0; i<arrEle.length; i++ ){\n        \tselObj.options.add(new Option(arrEle[i],i));\n        }\n    }\n    function setPage(ele){\n    \tURL = replaceQueryString(URL,'logLimit',ele.value);\n    \tlocation.href = URL;\n    }\n    function selectCombo(id,index){\n\t\tele = document.getElementById(\"Combo_item\"+id+\"_\"+index);\n\t\tvar limit = ele.innerHTML;\n\t\tURL = replaceQueryString(URL,'logLimit',limit);\n    \tlocation.href = URL;\n    }\n\t\n    function movePage(pageNum , totalPages){\n    \tif(pageNum <= 0)\n    \t\tpageNum = 1;\n    \telse if(pageNum > totalPages)\n    \t\tpageNum = totalPages;\n    \tpageNum = ((parseInt(pageNum)-1)*");
      out.print(ilogLimit);
      out.write(");\n    \tURL = replaceQueryString(URL,'logOffset',pageNum);\n    \tlocation.href = URL;\n    }\n    function jumpPage(totalPages){\n\t\tvar pageNo = document.getElementById(\"gotopage\").value;\n\t\tif(pageNo == null || isNaN(pageNo) || pageNo < 1 || pageNo > totalPages){ //");
//=numOfPages
      out.write("\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Please enter valid page no."));
      out.write("\");\n\t\t}else{\n\t\t\tmovePage(pageNo,totalPages);\t\n\t\t}\n\t}\n</script>\n</head>\n<body>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \n\t<div class=\"maincontent\" id=\"main_content\">\n\t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp", out, true);
      out.write("\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitle\">Audit Logs</div>\n\t\t\t<div class=\"reporttimetitle\">\n\t\t\t\t\t<b>From:</b><font class=\"reporttime\">");
      out.print(session.getAttribute("startdate"));
      out.write("</font>\n\t\t\t\t\t</br><b>To:</b><font class=\"reporttime\">");
      out.print(session.getAttribute("enddate"));
      out.write("</font> \n\t\t\t</div> \n\t\t</div>\n\t\t");

		int numOfLogs = AuditLogHelper.getNumOfLogs(session.getAttribute("startdate").toString(), session.getAttribute("enddate").toString());
		int numOfPages = 0;
		if(numOfLogs%ilogLimit == 0)
			numOfPages =(numOfLogs/ilogLimit);
		else
			numOfPages =(numOfLogs/ilogLimit)+1;
		int curPage = (iLogOffset/ilogLimit)+1;
		
      out.write("\n\t\t<table cellpadding=\"0\" cellspacing=\"2\" width=\"100%\" border=\"0\">\n\t\t<tr>\t\n\t\t\t<td>\n\t\t\t\t<div class=\"content_head\" width=\"100%\">\n\t\t\t\t\t<div width=\"100%\" class=\"Con_nevi\">\n\t\t\t\t\t\t<table width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t<td align=\"left\" class=\"navigationfont\" width=\"200px\"><span style=\"float:left;margin-top:1px;\">");
      out.print(TranslationHelper.getTranslatedMessge("Show"));
      out.write("&nbsp;\n\t\t\t\t\t\t\t\t</span><span style=\"float:left\"><div id=\"sizelimit\" class=\"Combo_container\" style=\"margin-bottom:3px;\"></div>\n\t\t\t\t\t\t\t\t</span><span style=\"float:left;margin-top:1px;\">&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("results per page"));
      out.write("</span>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<script language=\"javascript\">\n\t\t\t\t\t\t\t\tsetComboContainer(\"sizelimit\",\"40px\",\"1\");\n\t\t\t\t\t\t\t\tinsertElements(\"sizelimit\",[\"15\",\"20\",\"25\"]);\n\t\t\t\t\t\t\t\tsetSelectedText(\"sizelimit\",");
      out.print(ilogLimit);
      out.write(");\n\t\t\t\t\t\t\t</script>\n\t\t\t\t\t\t\t<td class=\"navigationfont\" align=\"right\">\n\t\t\t\t\t\t\t<span style=\"float:right;margin-right:10px;\"><input type='button' class='navibutton' value='Go' onClick=\"jumpPage('");
      out.print(numOfPages );
      out.write("')\"\" ></span>\n\t\t\t\t\t\t\t<span style=\"float:right\"><input class=\"navitext\" id=\"gotopage\" size=\"5\" type=\"text\" style=\"width:35px;margin-left:5px;margin-right:5px;\"></span>\n\t\t\t\t\t\t\t<span style=\"float:right;margin-top:2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("Go to page :"));
      out.write("</span>\n\t\t\t\t\t\t\t<span style=\"float:right;margin-top:2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page&nbsp;");
      out.print(curPage);
      out.write("&nbsp;of&nbsp;");
      out.print(numOfPages);
      out.write("</span>\n\t\t\t\t\t\t\t<span style=\"float:right\">\n\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/first.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('1','");
      out.print(numOfPages );
      out.write("')\" >\n\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/prev.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print(curPage-1);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(numOfPages );
      out.write("')\" >\n\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/next.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print(curPage+1);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(numOfPages );
      out.write("')\" >\n\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/last.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print(numOfPages);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(numOfPages );
      out.write("')\" >\n\t\t\t\t\t\t\t</span>\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t</table>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</td>\n\t\t</tr>\n\t\t<tr><td><div id=\"auditlog_grid\" style=\"width:100%;height:350px;\"></div></td></tr>\n\t\t</table>\n\t</div>\n\t<div style=\"display:none\">\n\t\t<div id=\"sever_flt_box\"><select style=\"width:90%\" onclick=\"(arguments[0]||window.event).cancelBubble=true;\" onchange=\"filterBy()\"></select></div>\n\t\t<div id=\"categ_flt_box\"><select style=\"width:90%\" onclick=\"(arguments[0]||window.event).cancelBubble=true;\" onchange=\"filterBy()\"></select></div>\n\t</div>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n</body>\n");

	}catch(Exception e){
	CyberoamLogger.appLog.debug("auditlog.jsp"+e,e);
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
