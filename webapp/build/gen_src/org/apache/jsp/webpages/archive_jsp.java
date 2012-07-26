package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.net.*;
import java.io.*;
import org.cyberoam.iview.beans.FileHandlerBean;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import org.cyberoam.iview.audit.CyberoamLogger;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.TimeZone;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.helper.LoadDataHandler;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.utility.ByteInUnit;
import org.cyberoam.iview.device.beans.DeviceGroupRelationBean;
import org.cyberoam.iview.device.beans.DeviceGroupBean;
import java.util.Iterator;
import org.cyberoam.iview.authentication.beans.*;

public final class archive_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

try{
	if(CheckSession.checkSession(request,response)<0){
		return;
	}
	
	
	int iPageno = 1;
	String strPageno = request.getParameter("pageno");
	if(strPageno != null && !"".equalsIgnoreCase(strPageno)){
		iPageno = Integer.parseInt(strPageno);
	}
	int iLimit = 5;
	String strLimit = request.getParameter("limit");
	if(strLimit != null){
		iLimit = Integer.parseInt(strLimit);
	}
	// Terminating process if loading process completed or termination request
	if("yes".equalsIgnoreCase(request.getParameter("stop"))){
		CyberoamLogger.appLog.debug(" User request to terminate loading process ");
		
		LoadDataHandler.setStopFlag(1);
		if(!(LoadDataHandler.getProcessPercentComplete() == 100))
			LoadDataHandler.setProcessPercentComplete(99);
	}

	// If request to extract row log otherw.ise null value
	String startrowlogfile= request.getParameter("startrowlogfile");
	String endrowlogfile= request.getParameter("endrowlogfile");
	if(startrowlogfile == null){
		startrowlogfile="";
	}
	if(endrowlogfile == null){
		endrowlogfile="";
	}

	//Reading status if any loading process is currently running or not
	boolean isLoadingProcessRunning=false;
	if(LoadDataHandler.getStopFlag() == 0){
		CyberoamLogger.appLog.error(" Process is running "); 
		isLoadingProcessRunning=true;
	}
	
	String formattedstartdate=request.getParameter("formattedstartdate");
	if(formattedstartdate == null || "NULL".equalsIgnoreCase(formattedstartdate) || "".equalsIgnoreCase(formattedstartdate) ){
		formattedstartdate = (new SimpleDateFormat("dd, MMM yyyy")).format(new Date());
	}
	String formattedenddate=request.getParameter("formattedenddate");
	if(formattedenddate == null || "NULL".equalsIgnoreCase(formattedenddate) || "".equalsIgnoreCase(formattedenddate) ){
		formattedenddate=(new SimpleDateFormat("dd, MMM yyyy")).format(new Date());
	}
	String qString = request.getQueryString();
	if(qString == null){
		qString = "";
	}

      out.write("\n<html>\n<head>\n<title>");
      out.print(iViewConfigBean.TITLE);
      out.write("</title>\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\">\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/combo.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script>\n<SCRIPT SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ajax.js\"></SCRIPT>\n<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></SCRIPT>\n<style type=\"text/css\">\n.loadButton{\n\tborder: 0px;\n\tbackground: transparent;\n\tfont-family: Verdana,Arial,Helvetica,sans-serif; \n\tfont-size: 11px;\n\ttext-decoration: underline;\n}\n.loadButton1{\n\tborder: 0px;\n\tbackground: transparent;\n\tfont-family: Verdana,Arial,Helvetica,sans-serif; \n\tfont-size: 11px;\n\ttext-decoration: none;\n}\n</style>\n<script type=\"text/javascript\" language=\"javascript\">\n\tvar URL = \"");
      out.print(request.getContextPath());
      out.write("/webpages/archive.jsp?");
      out.print(qString);
      out.write("\";\n\tvar iPageno = '");
      out.print(iPageno);
      out.write("';\n\tvar iLastPage = null;\n\tvar http_request = false;\n\tvar childwindow;\n\tvar cnt = 0;\n\tvar timerVal;\n\tvar filenotfountcount = 0;\n\tvar xmlHttp = null;\n   \n\twindow.onload = function (evt) {\n\t\tsetWidth();\t\t\t\t\n\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n\tfunction changeColor(mode,element,inTable){\n\t\tif(mode == '1'){\n\t\t\telement.className=\"trlight1\";\n\t\t\tdocument.getElementById(inTable).className = \"innerTableData2\";\n\t\t} else {\n\t\t\telement.className=\"trlight\";\n\t\t\tdocument.getElementById(inTable).className = \"innerTableData1\";\n\t\t}\n\t}\n   \tfunction LoadData(day){\n\t\tvar filelist=\"\";\n\t\tvar dateList=\"\"\n\t\tvar ischeck=false;\n\t\tvar processobj = document.getElementById(\"clickprocess\");\n\t\tvar overlay = document.getElementById(\"TB_overlay\");\n\t\tif(");
      out.print(isLoadingProcessRunning);
      out.write(" || processobj.style.display==''){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Loading Process Already Running"));
      out.write("\");\n\t\t\treturn false;\n\t\t}\n\t\tvar checkstmp = document.getElementsByName(day);\n\t\tfor (var j = 0; j <  checkstmp.length; ++j) { \n\t\t   if ( checkstmp[j].type == \"checkbox\") { \n\t\t     \tif(checkstmp[j].checked == true ){\n\t\t     \t\tif(!checkstmp[j].disabled){\n\t\t\t     \t\tischeck\t= true;\n\t\t     \t\t}\n\t\t     \t\tif(filelist == \"\"){\n\t\t     \t\t\tfilelist = checkstmp[j].value;\n\t\t     \t\t}else{\n\t\t\t     \t\tfilelist = filelist + \",\" + checkstmp[j].value;\n\t\t     \t\t}\n\t\t     \t\tif(dateList == \"\"){\n\t\t\t     \t\tif(j == 0)\n\t\t     \t\t\t\tdateList = day+\" 18_23\"; \t\t\t     \t\t\n\t\t\t     \t\telse if(j == 1)\n\t\t     \t\t\t\tdateList = day+\" 12_17\";\n\t\t\t     \t\telse if(j == 2)\n\t\t     \t\t\t\tdateList = day+\" 06_11\";\n\t\t\t     \t\telse if(j == 3)\n\t\t     \t\t\t\tdateList = day+\" 00_05\";\n\t\t     \t\t}else{\n\t\t     \t\t\tif(j == 0)\n\t\t     \t\t\t\tdateList = dateList + \",\" + day+\" 18_23\"; \t\t\t     \t\t\n\t\t\t     \t\telse if(j == 1)\n\t\t     \t\t\t\tdateList = dateList + \",\" + day+\" 12_17\";\n\t\t\t     \t\telse if(j == 2)\n\t\t     \t\t\t\tdateList = dateList + \",\" + day+\" 06_11\";\n\t\t\t     \t\telse if(j == 3)\n\t\t     \t\t\t\tdateList = dateList + \",\" + day+\" 00_05\";\n");
      out.write("\t\t     \t\t}\t\n\t\t     \t}\n\t\t   } \n\t\t}\n\t\tif(!ischeck){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Select atleast one check box to load data to search"));
      out.write("\");\n\t\t\treturn false;\n\t\t}\n\t\t\n\t\tdocument.viewarchivedetail.extractrowlog.value = \"1\";\n\t\tprocessobj.style.display = '';\n\t\toverlay.style.display = '';\n\t\tdocument.viewarchivedetail.indexfilelist.value = filelist;\n\t\tdocument.viewarchivedetail.daystring.value = day;\n\t\tdocument.viewarchivedetail.checkeddate.value = dateList;\n\t\tdocument.viewarchivedetail.submit();\t\t\n\t\treturn true;\n\t}\n\tfunction dofilter(){\n\t\tlocation.href=\"/iview/webpages/archive.jsp?startdate=\"+document.viewarchivedetail.startdate.value+\"&enddate=\"+document.viewarchivedetail.enddate.value+\"&formattedstartdate=\"+document.viewarchivedetail.displaystartdate.value+\"&formattedenddate=\"+document.viewarchivedetail.displayenddate.value;\n\t}\n\tfunction createXMLHttpRequest(){\n        if(typeof XMLHttpRequest != \"undefined\"){\n\t        xmlHttp = new XMLHttpRequest();\n\t    }\n\t    else if(typeof window.ActiveXObject != \"undefined\"){\n\t        try {\n\t            xmlHttp = new ActiveXObject(\"Msxml2.XMLHTTP.4.0\");\n\t        }\n\t        catch(e){\n\t            try {\n\t                xmlHttp = new ActiveXObject(\"MSXML2.XMLHTTP\");\n");
      out.write("\t            }\n\t            catch(e){\n\t                try {\n\t                    xmlHttp = new ActiveXObject(\"Microsoft.XMLHTTP\");\n\t                }\n\t                catch(e){\n\t                    xmlHttp = null;\n\t                }\n\t            }\n\t        }\n\t    }\n\t    return xmlHttp;\n\t}\n\tfunction getTheContent(URL){\n\t    if(createXMLHttpRequest()){\n\t\t\tif(\"");
      out.print(endrowlogfile);
      out.write("\" == \"\" && \"");
      out.print(startrowlogfile);
      out.write("\" == \"\" && cnt==0){\n\t\t\t\tcnt=1;\n\t\t\t}\n\t\t\tcnt++;\n\t\t\txmlHttp.open(\"GET\", URL+\"?\"+cnt++, true);\n\t\t\txmlHttp.onreadystatechange = function() { contentIsReady(xmlHttp); }\n\t\t\txmlHttp.send(null);\n\t    }\n\t}\n\t\n\tfunction contentIsReady(xmlHttp){\n\t    if(xmlHttp && xmlHttp.readyState == 4){\n\t\t\talertContents(xmlHttp);\n\t        xmlHttp = null;\n\t    }\n\t}\n\tfunction closeWindow(){\n\t");
if("yes".equalsIgnoreCase(request.getParameter("processrunning")) && isLoadingProcessRunning){
      out.write("\n\t\tclearTimeout(timerVal);\n\t\tif(\"");
      out.print(endrowlogfile);
      out.write("\" == \"\" && \"");
      out.print(startrowlogfile);
      out.write("\" == \"\"){\n\t\t\t//timerVal=setTimeout('functionCall()',2000);\n\t\t\tlocation.href='");
      out.print(request.getContextPath());
      out.write("/webpages/archive.jsp?stop=yes&startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value;\n\t\t}else{\n\t\t\tdocument.progressbarform.startdate.value = document.viewarchivedetail.startdate.value\n\t\t\tdocument.progressbarform.enddate.value = document.viewarchivedetail.enddate.value\n\t\t\tdocument.progressbarform.submit();\n\t\t}\n\t\treturn;\n\t");
}else{
      out.write("\n\tlocation.href='");
      out.print(request.getContextPath());
      out.write("/webpages/archive.jsp?startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value;\n\t");
}
      out.write("\n\t}\n\n\tfunction doSomething() {\n\t\ttimerVal=setTimeout('loadFunctionCall()',1000);\n\t}\n\tfunction loadFunctionCall(){\n\t\tvar overlay = document.getElementById(\"TB_overlay\");\n\t\toverlay.style.display = '';\n\t\tgetTheContent('");
      out.print(request.getContextPath());
      out.write("/AjaxController?giveloadtime=true');\t\t\n\t}\n\tfunction replaceQueryString(url,param,value) {\n\t\tvar re = new RegExp(\"([?|&])\" + param + \"=.*?(&|$)\",\"i\");\n\t\tif (url.match(re)) {\n\t\t\treturn url.replace(re,'$1' + param + \"=\" + value + '$2');\n\t\t} else {\n\t\t\treturn url + '&' + param + \"=\" + value;\n\t\t}\n\t}\n\tfunction selectCombo(id,index){\n\t\tele = document.getElementById(\"Combo_item\"+id+\"_\"+index);\n\t\tvar limit = ele.innerHTML;\n\t\tURL = replaceQueryString(URL,'limit',limit);\t\n\t\tdocument.location.href = URL;\n\t}\n\tfunction movePage(num){\n\t\tURL = replaceQueryString(URL,'pageno',num);\t\n\t\tdocument.location.href = URL;\n\t}\n\tfunction  jumpPage(){\n\t\tvar pageNo = document.getElementById(\"gotopage\").value;\n\t\tif(pageNo == null || isNaN(pageNo) || pageNo < 1 || pageNo > iLastPage){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Please enter valid page no."));
      out.write("\");\n\t\t}else{\n\t\t\tURL = replaceQueryString(URL,'pageno',pageNo);\t\n\t\t\tdocument.location.href = URL;\n\t\t}\n\t}\n\tfunction alertContents(http_request) {\n\t\tvar regExp=/^[0-9]+$/\n\t\tif (http_request.readyState == 4) {\n        \tif (http_request.status == 200) {\n           \t\tif(http_request.responseText != -1){\n\t\t\t\t\tif(isNaN(http_request.responseText) == false){\n\t\t\t\t\t\tvar obj=document.getElementById(\"first\");\n\t\t\t\t\t\tvar obj1=document.getElementById(\"second\");\n\t\t\t\t\t\tvar obj2=document.getElementById(\"data\");\n\t\t\t\t\t\tvar resWidth;\n\t\t\t\t\t\tif(http_request.responseText == 0 || http_request.responseText == ''){\n\t\t\t\t\t\t\tresWidth = 1;\n\t\t\t\t\t\t\tobj2.innerHTML = '&nbsp;'+resWidth+'%';\n\t\t\t\t\t\t\tobj.width = resWidth + '%';\n\t\t\t\t\t\t\tobj1.width = (100 - resWidth) + '%';\n\t\t\t\t\t\t\tfilenotfountcount=0;\n\t\t\t\t\t\t}\n\t\t\t\t\t\telse if(http_request.responseText == 99){\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tdocument.getElementById(\"indexDiv\").style.display = \"none\";\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tdocument.getElementById(\"TB_overlay\").style.display = 'block';\n\t\t\t\t\t\t\tdocument.getElementById(\"indexCommitProcess\").style.display = 'block';\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t}\n\t\t\t\t\t\telse if(http_request.responseText == 100){\n\t\t\t\t\t\t\tcloseWindow();\t\t\n\t\t\t\t\t\t\treturn;\n\t\t\t\t\t\t}\n\t\t\t\t\t\telse{ \n\t\t\t\t\t\t\tresWidth = http_request.responseText;\n\t\t\t\t\t\tobj2.innerHTML = '&nbsp;'+resWidth+'%';\n\t\t\t\t\t\tobj.width = resWidth + '%';\n\t\t\t\t\t\tobj1.width = (100 - resWidth) + '%';\n\t\t\t\t\t\tfilenotfountcount=0;\n\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t}else{\n\t\t\t\t\tfilenotfountcount++;\n\t\t\t\t}\n\t\t\t\tif(http_request.responseText == 100){\t\n\t\t\t\t\tcloseWindow();\t\t\n\t\t\t\t\treturn;\t\t\t\n\t\t\t\t}\n\t\t\t\tif(filenotfountcount > 10){\n\t\t\t\t\treturn;\n\t\t\t\t}\n           \t\tdoSomething();\n           } else {\n               alert(\"");
      out.print(TranslationHelper.getTranslatedMessge("There is a problem with the request."));
      out.write(" \");\n           }\n       }\n    }\n    \n   \tfunction unloadFile(dayStr){\n\t\tvar url=\"");
      out.print(request.getContextPath());
      out.write("\" + \"/iview\";\n\t\tvar queryStr=\"?appmode=\"+\"");
      out.print(ApplicationModes.WARMFILE_UNLOAD_REQUEST);
      out.write("\"\t\t\n\t\tqueryStr=queryStr+\"&daystr=\"+dayStr;\t\t\t\t\n\t\turl=url+queryStr;\t\t\t\t\t\t\t\n\t\tSimpleAJAXCall(url,getResponse,\"get\",dayStr);\t\t\n\t\tGetStatusValue();\t\t\t\t\n\t}   \n\tfunction unloadAll(){\n\t\tvar confirmation=confirm(\"Are you sure to unload all data?\");\t\t\n\t\tif(confirmation) {\n\t\t\tdocument.viewarchivedetail.appmode.value = \"");
      out.print(ApplicationModes.WARMFILE_UNLOAD_ALL);
      out.write("\";\n\t\t\tdocument.viewarchivedetail.submit();\n\t\t}\n\t\treturn;\t\t\t\n\t}  \n\tfunction GetStatusValue(){\t\t\t\t\t\n\t\tvar url=\"");
      out.print(request.getContextPath());
      out.write("\" + \"/iview\";\n\t\tvar queryStr=\"?appmode=\"+\"");
      out.print(ApplicationModes.WARMFILE_UNLOAD_REQUEST);
      out.write("\";\t\t\t\n\t\tqueryStr=queryStr+\"&getstatus=true\";\n\t\turl=url+queryStr;\t\t\n\t\tSimpleAJAXCall(url,getResponse,\"get\",url);\t\t\t\t\t\n\t}\n\t\n\tfunction getResponse(xmlReq,id){\t\t\n\t\tif(xmlReq!=null){\t\t\t\n\t\t\tvar rootObj=xmlReq.getElementsByTagName(\"root\").item(0);\n\t\t\tvar msgObj=rootObj.getElementsByTagName(\"msg\").item(0);\n\t\t\tvar statusObj=rootObj.getElementsByTagName(\"status\").item(0);\n\t\t\tvar data=msgObj.childNodes[0].data;\n\t\t\tvar status=statusObj.childNodes[0].data;\n\t\t\tvar divObj=document.getElementById(\"statusDivMain\");\n\t\t\tdivObj.style.display=\"block\";\n\t\t\tvar div=document.getElementById(\"statusDiv\");\n\t\t\tdiv.innerHTML=data;\t\t\t\n\t\t\tif(status==1){\t\t\t\t\t\t\n\t\t\t\tsetTimeout(\"GetStatusValue()\",500);\t\t\t\t\n\t\t\t}else{\t\t\t\t\n\t\t\t\tsetTimeout(\"hideStatus()\",3000);\n\t\t\t\t\n\t\t\t\n\t\t\t} \n\t\t\t\n\t\t}\t\t\t\n\t}\n\t\n\tfunction hideStatus(){\n\t\tvar divObj=document.getElementById(\"statusDivMain\");\n\t\tdivObj.style.display=\"none\";\n\t\t//alert(\"");
      out.print(request.getQueryString());
      out.write("\");\n\t\twindow.location.href=\"");
      out.print(request.getContextPath());
      out.write("\"+\"/webpages/archive.jsp\";\t\t\n\t}\n\n</script>\n</head>\n<body ");
      out.print((isLoadingProcessRunning)?"onload=\"loadFunctionCall();\"":"");
      out.write(' ');
      out.write('>');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write(" \n<div class=\"maincontent\" id=\"main_content\">\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp" + (("Date.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("device", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()), out, true);
      out.write('\n');

		String 	startdate = (String)session.getAttribute("startdate");
		String enddate = (String)session.getAttribute("enddate");

      out.write("\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Archived Files"));
      out.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>\n\t\t\t<div class=\"reporttimetitle\">\n\t\t\t\t\t<b>From:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("startdate"));
      out.write("</font>\n\t\t\t\t\t</br><b>To:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("enddate"));
      out.write("</font> \n\t\t\t</div>\n\t\t\t<div class=\"unloadAll\">\t\n\t\t\t\t<input align=\"right\" type=\"button\" name=\"unloadAll\"  onclick=\"unloadAll()\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Unload All"));
      out.write("\" class=\"criButton\" style=\"height:20px\"/>\n\t\t\t\t&nbsp;\n\t\t\t</div>\n\t\t</div>\n\n");
 	
		if(request.getParameter("statusCheck")!=null) { 
      out.write("\n\t\t\t<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\" class=\"TableData\" style=\"padding:3px 0pt 0pt 3px;\">\n");
			if(request.getParameter("statusCheck").equals("1")){ 
      out.write(" \n\t\t\t\t<tr><td align=\"left\" class=\"posimessage\">");
      out.print( TranslationHelper.getTranslatedMessge("Unload all completed."));
      out.write("</td></tr>\n");
			} 

      out.write("\t\t\t</table>\t\t\n");
		}

      out.write("\n\n\n\n\t\t<div style=\"float: left;width: 100%\">\n\t\t\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"viewarchivedetail\">\n\t\t\t\t<input type=\"hidden\" id=\"indfilelist\" name=\"indexfilelist\" value=\"\" />\n\t\t\t\t<input type=\"hidden\" id=\"pageno\" name=\"pageno\" value=\"");
      out.print(strPageno);
      out.write("\" />\n\t\t\t\t<input type=\"hidden\" id=\"exctractlog\" name=\"extractrowlog\" value=\"0\" />\n\t\t\t\t<input type=\"hidden\" id=\"dstring\" name=\"daystring\" value=\"\" />\n\t\t\t\t<input type=\"hidden\" name=\"startdate\" value=\"");
      out.print(startdate);
      out.write("\" />\n\t\t\t\t<input type=\"hidden\" name=\"enddate\" value=\"");
      out.print(enddate);
      out.write("\" />\n\t\t\t\t<input type=\"hidden\" name=displaystartdate value=\"");
      out.print(formattedstartdate);
      out.write("\" />\n\t\t\t\t<input type=\"hidden\" name=displayenddate value=\"");
      out.print(formattedenddate);
      out.write("\" />\n\t\t\t\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.ARCHIEVE_LOAD_REQUEST);
      out.write("\" />\n\t\t\t\t<input type=\"hidden\" name=\"categoryID\" value=\"");
      out.print((String)session.getAttribute("categoryid"));
      out.write("\" />\n\t\t\t\t<input type=\"hidden\" name=\"checkeddate\" value=\"\" />\n\n");
	
				String newStartDate = (String)session.getAttribute("startdate");
				String newSDate = newStartDate;	
				String newEndDate = (String)session.getAttribute("enddate") ;
				String newEDate = newEndDate;
				DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
				DateFormat fmtwithtime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date sDate = fmt.parse(newStartDate);
				Date eDate = fmt.parse(newEndDate);
				long msecDiff = eDate.getTime() - sDate.getTime();  
				int daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000))) + 1;
				int daysInPage = daysDiff;
				int iLastPage = (int)Math.ceil(((float)daysDiff/(float)iLimit));
				out.println("<script type=\"text/javascript\">iLastPage="+iLastPage+"</script>");
				if(iPageno > iLastPage){
					iPageno = iLastPage;
					out.println("<script type=\"text/javascript\">iPageno="+iPageno+"</script>");
				}
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar now = Calendar.getInstance();
				
				int numOfdays = (iPageno-1)*iLimit;
				
				now.setTime(sdf.parse(newEndDate));
				now.add(Calendar.DAY_OF_MONTH, (-1 * numOfdays));
				newEndDate = String.valueOf(sdf.format(now.getTime()));
			
				if(numOfdays+iLimit < (daysDiff)){
					newStartDate = newEndDate;
					now.setTime(sdf.parse(newStartDate));
					now.add(Calendar.DAY_OF_MONTH, (iLimit-1)*-1);
				}else {
					now.setTime(sdf.parse(newStartDate));
				}
				newStartDate = String.valueOf(sdf.format(now.getTime()));

      out.write("\n\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n\t\t\t\t<tr>\n\t\t\t\t\t<td align=\"left\">\n\t\t\t\t\t\t<table width=\"100%\">\n\t\t\t\t\t\t<tr><td colspan=\"2\">\n\t\t\t\t\t\t\t\t<div class=\"content_head\" width=\"100%\">\n\t\t\t\t\t\t\t\t\t<div width=\"100%\" class=\"Con_nevi\">\n\t\t\t\t\t\t\t\t\t\t<table width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n\t\t\t\t\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t\t\t\t\t<td align=\"left\" class=\"navigationfont\" width=\"200px\"><span style=\"float:left;margin-top:1px;\">");
      out.print(TranslationHelper.getTranslatedMessge("Show"));
      out.write("&nbsp;\n\t\t\t\t\t\t\t\t\t\t\t\t</span><span style=\"float:left\">\n\t\t\t\t\t\t\t\t\t\t\t\t<div id=\"sizelimit\" class=\"Combo_container\" style=\"margin-bottom:3px;\"></div>\n\t\t\t\t\t\t\t\t\t\t\t\t</span>\n\t\t\t\t\t\t\t\t\t\t\t\t<span style=\"float:left;margin-top:1px;\">&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("days per page"));
      out.write("</span>\n\t\t\t\t\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t\t\t\t\t<script language=\"javascript\">\n\t\t\t\t\t\t\t\t\t\t\t\tsetComboContainer(\"sizelimit\",\"40px\",\"1\");\n\t\t\t\t\t\t\t\t\t\t\t\tinsertElements(\"sizelimit\",[\"5\",\"10\",\"15\",\"20\",\"25\"]);\n\t\t\t\t\t\t\t\t\t\t\t\tsetSelectedText(\"sizelimit\",");
      out.print(iLimit);
      out.write(");\n\t\t\t\t\t\t\t\t\t\t\t</script>\n\t\t\t\t\t\t\t\t\t\t\t<td class=\"navigationfont\" align=\"right\">\n\t\t\t\t\t\t\t\t\t\t\t<span style=\"float:right;margin-right:10px;\"><input type='button' class='navibutton' value='Go' onClick=\"jumpPage()\" ></span>\n\t\t\t\t\t\t\t\t\t\t\t<span style=\"float:right\"><input class=\"navitext\" id=\"gotopage\" size=\"5\" type=\"text\" style=\"width:35px;margin-left:5px;margin-right:5px;\"></span>\n\t\t\t\t\t\t\t\t\t\t\t<span style=\"float:right;margin-top:2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("Go to page :"));
      out.write("</span>\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t<span style=\"float:right;margin-top:2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("Page"));
      out.write("&nbsp;");
      out.print(iPageno);
      out.write("&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("of"));
      out.write("&nbsp;");
      out.print(iLastPage);
      out.write("</span>\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t<span style=\"float:right\">\n\t\t\t\t\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/first.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('1')\" >\n\t\t\t\t\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/prev.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print((iPageno!=1)?(iPageno-1):1);
      out.write("')\" >\n\t\t\t\t\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/next.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print((iPageno!=iLastPage)?(iPageno+1):iLastPage);
      out.write("')\" >\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/last.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print(iLastPage);
      out.write("')\" >\n\t\t\t\t\t\t\t\t\t\t\t</span>\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\t\t\t\t</table>\n\t\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t<td colspan=\"2\">\n");

	int hrs = 6;
	try{
		if(request.getParameter("hours")!=null){
			hrs = Integer.parseInt(request.getParameter("hours"));
		}
		if(hrs < 1 || hrs > 24 ){
			hrs = 6;
		}
	}catch(Exception e){
		hrs = 6;
	}
	String criteria = "";
	try{
		if(request.getParameter("criteria")!=null){
			criteria = request.getParameter("criteria");
		}
	}catch(Exception e){
		criteria = "";
	}
	ArrayList filelist = null;
	if(!session.getAttribute("appliancelist").toString().equals("")){	
		criteria = " where  appid in (" +(String)session.getAttribute("appliancelist") +")";
		filelist = FileHandlerBean.getFileList(criteria,"",newStartDate,newEndDate);
	}	
	
	long starttimestamp = 0;
	long endtimestamp = 0;
	String current_date = "";
	String old_date = "";
	long filesize = 0;
	long loadedFilesize = 0;
	long totalfilesize = 0;
	long dayendtimestamp = 0;
	long timestamp;
	long oldTimestamp;
	int hrscount = 0;
	int recordcount = 0;
	int isloadedval = 1;
	int allindexfileloaded = 1;
	int noOfRows = 0;
	String slotfilelist = "";
	String fileName = "";
	String stringDay = "";
	FileHandlerBean fileHandlerBean = null;
	DecimalFormat df = new DecimalFormat("0.###");

      out.write("\n\t\t\t\t<table class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n\t\t\t\t<tr height=\"25px\">\n\t\t\t\t\t<td class=\"tdhead\" style=\"padding-left:10px\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Date"));
      out.write("</b></td>\n\t\t\t\t\t<td style=\"padding-left:10px\" class=\"tdhead\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("File Details"));
      out.write("</b></td>\n\t\t\t\t\t<td align=\"center\" class=\"tdhead\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Total Size"));
      out.write("</b></td>\n\t\t\t\t\t<td align=\"center\" class=\"tdhead\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Action"));
      out.write("</b></td>\n\t\t\t\t</tr>\n");

	if((24%hrs) == 0){
		noOfRows=(24/hrs);
	}else{
		noOfRows=(24/hrs)+1;			
	}
	int dayCont = 0; 
	if(filelist != null && filelist.size() > 0){
		fileHandlerBean = (FileHandlerBean)filelist.get(recordcount);
		recordcount++;
		if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
			timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp())*1000;
		}else{
			timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp())*1000;
		}
		oldTimestamp = timestamp;
		
		sDate = fmt.parse(newEndDate);
		eDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(timestamp)));
		
		msecDiff = sDate.getTime() - eDate.getTime();  
		daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000)));
		
		for(int i=0; i<daysDiff ; i++){
			dayCont++;
			now.setTime(sDate);
			now.add(Calendar.DATE, -i);
			old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));

      out.write("\n \t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\n\t\t\t\t\t<td class=\"tddata\" align=\"center\">");
      out.print(old_date);
      out.write("</td>\n\t\t\t\t\t<td class=\"tddata\" align=\"left\" colspan=\"3\">&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+" "+old_date);
      out.write("</td>\n\t\t\t\t</tr>\n");

		}		
		
		while(true){
			dayCont++;
			
			if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
				timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp())*1000;
			}else{
				timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp())*1000;
			}
	
			Date d = new Date(timestamp);
			current_date = (new SimpleDateFormat("yyyy/MM/dd")).format(d);
			stringDay = (new SimpleDateFormat("yyyyMMdd")).format(d);
			Date d1 = new Date(current_date);
	
			Date oldDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(oldTimestamp)));
			
			msecDiff = oldDate.getTime() - d1.getTime();  
			daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000)))-1;
			starttimestamp=d1.getTime() + (24*60*60*1000);
			endtimestamp=d1.getTime() + (24*60*60*1000);
			dayendtimestamp = d1.getTime();
		
			for(int i=0; i<daysDiff ; i++){
				dayCont++;
				now.setTime(oldDate);
				now.add(Calendar.DATE, -1*(i+1));
				old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));

      out.write("\n  \t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\n\t\t\t\t\t<td class=\"tddata\" align=\"center\">");
      out.print(old_date);
      out.write("</td>\n\t\t\t\t\t<td class=\"tddata\" align=\"left\" colspan=\"3\">&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+ old_date);
      out.write("</td>\n\t\t\t\t</tr>\n");

			}

      out.write("\n\t\t\t\t<tr class=\"trlight\" onMouseOver='changeColor(\"1\",this,\"");
      out.print(dayCont);
      out.write("\");' onMouseOut='changeColor(\"2\",this,\"");
      out.print(dayCont);
      out.write("\");'>\n\t\t\t\t\t<td class=\"tddata\" style=\"padding-left:10px\" align=\"center\">");
      out.print(current_date);
      out.write("</td>\n\t\t\t\t\t<td>\n\t\t\t\t\t\t<table id=\"");
      out.print(dayCont);
      out.write("\" onMouseOver=\"this.className='innerTableData2'\" onMouseOut=\"this.className='innerTableData1'\" class=\"innerTableData1\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n");

			filesize=0;
			totalfilesize=0;
			loadedFilesize = 0;
			boolean unloadFlag=false;
			String attribute=null;
			for(hrscount=0;hrscount<24;hrscount=hrscount+hrs){		
				starttimestamp=endtimestamp;
				endtimestamp = starttimestamp - (hrs*60*60*1000);
				isloadedval=1;
				if(endtimestamp < dayendtimestamp){
					endtimestamp=dayendtimestamp;
				}
				slotfilelist="";
				
				String slotSDate = (new SimpleDateFormat("HH")).format(new Date(starttimestamp-1000));
				String slotEDate = (new SimpleDateFormat("HH")).format(new Date(endtimestamp));
				
				while(true){ 
					if((starttimestamp > timestamp) && (timestamp >= endtimestamp)){
						if(fileHandlerBean.getIsLoaded() == 0){
							isloadedval=0;
							filesize = filesize+fileHandlerBean.getFileSize();
						} else {
							loadedFilesize += fileHandlerBean.getFileSize();
						}
						if("".equalsIgnoreCase(slotfilelist)){
							slotfilelist = slotfilelist + fileHandlerBean.getAppID()+"@"+ fileHandlerBean.getFileName();
						}else{
							slotfilelist = slotfilelist + "," + fileHandlerBean.getAppID()+"@"+ fileHandlerBean.getFileName();
						}
						oldTimestamp = timestamp;
						if(recordcount < filelist.size()){	
							fileHandlerBean = (FileHandlerBean)filelist.get(recordcount);
							if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
								timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp())*1000;
							}else{
								timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp())*1000;
							}
							recordcount++;
						}else{
							timestamp=0;
						}
					}else{
						break;
					}
				}
				if(isloadedval == 0){
					allindexfileloaded=0;
				}
				if(isloadedval==1 && filesize!=0 && loadedFilesize!=0){
					attribute="checked disabled";
					unloadFlag=true;
				}else{
					attribute="";
				}
					
				if(filesize==0 && loadedFilesize==0){
					attribute="disabled";
				}else{
					attribute="";
				}
				out.println("<tr class=\"innertrlight\"><td class=\"innertddata\" style=\"padding-left:5px\"><input name=\""+stringDay+"\" id=\""+stringDay+"\" type=\"checkbox\" value=\""+slotfilelist+"\""+ ((isloadedval==1 && filesize==0 && loadedFilesize!=0) ?"checked disabled":"")+((filesize==0 && loadedFilesize==0)?"disabled":"") +"> "+ slotEDate + "_"+ slotSDate +"hrs.log ("+((filesize==0 && loadedFilesize!=0)?ByteInUnit.getBytesInUnit(loadedFilesize):ByteInUnit.getBytesInUnit(filesize))+") "+((loadedFilesize!=0 && filesize!=0)?"<font class=\"message\">"+ByteInUnit.getBytesInUnit(loadedFilesize)+" Loaded...</font>":"")+"</td></tr>");		
				totalfilesize = totalfilesize + filesize + loadedFilesize;
				filesize = 0;
				loadedFilesize = 0;
			}
			out.println("</table></td><td class=\"tddata\" align=\"center\">"+ ByteInUnit.getBytesInUnit(totalfilesize)+"</td>");
			out.println("<td class=\"tddata\" align=\"center\">");
			
			if(allindexfileloaded==0){
				out.println("<input type=\"button\" class=\"loadButton\" onmouseover=\"this.className = 'loadButton1'\" onmouseout=\"this.className = 'loadButton'\" value=\"Load\" onclick=\"LoadData('"+stringDay+"');\" />"+"<br>");
				//out.println("<a href=\"javascript:;\" onclick=\"LoadData('"+stringDay+"');\">"+TranslationHelper.getTranslatedMessge("Load")+"</a><br>");		
			}else{
			
			//if(unloadFlag==true){
				out.println("<span style='text-decoration:underline;cursor:pointer;' onclick=unloadFile('"+(new SimpleDateFormat("yyyyMMdd")).format(d)+"')>"+TranslationHelper.getTranslatedMessge("Unload")+"</span><br>");
			}
			out.println("<a href=\""+request.getContextPath()+"/webpages/archivelogs.jsp?startdate="+(new SimpleDateFormat("yyyy-MM-dd")).format(d)+" 00:00:00&enddate="+(new SimpleDateFormat("yyyy-MM-dd")).format(d)+" 23:59:59\">"+TranslationHelper.getTranslatedMessge("Raw Log")+"</a><br>");
			//out.println("<a href=\""+request.getContextPath()+"/webpages/archivelogs.jsp?tblname=tblindex"+stringDay+"\">"+TranslationHelper.getTranslatedMessge("Search")+"</a></td></tr>");	
			if(recordcount >= filelist.size() && timestamp==0){
				break;
			}
		}
		Date oldDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(oldTimestamp)));
	
		int diff=0;
		if(iLastPage != iPageno & (daysInPage%iLimit)!=0) {
			diff=iLimit-dayCont;
		}else{
			diff=daysInPage-dayCont;
		}			
		for(int i=0; i<diff ; i++){
			now.setTime(oldDate);
			now.add(Calendar.DATE, -1*(i+1));
			old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));

      out.write("\n \t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\n\t\t\t\t<td class=\"tddata\" align=\"center\">");
      out.print(old_date);
      out.write("</td>\n\t\t\t\t<td class=\"tddata\" align=\"left\" colspan=\"3\">&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+" "+old_date.toString());
      out.write("</td>\n\t\t\t</tr>\n");

		}	
	}else{
		out.println("<tr class=\"trlight\"><td class=\"tddata\" align=\"center\" colspan=\"4\" >"+TranslationHelper.getTranslatedMessge("No archive File is Available for loading between")+" "+newStartDate+" "+TranslationHelper.getTranslatedMessge("and")+" "+newEndDate+"</td></tr>");
	}
	out.println("</table>");

      out.write("\n\t\t\t</td>\n\t\t</tr>\n\t\t</table>\n\t</td>\n</tr>\n</table>\n<br/>\n<center>\n\t<div id=\"statusDivMain\" style=\"display:none;\">\n\t\t<div class=\"navigationfont\">\t\t\t\n\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/progress.gif\"></img>\n\t\t\tUnloading Archived Files\n\t\t</div>\n\t\t<div id=\"statusDiv\" class=\"navigationfont\">\t\t\t\n\t\t</div>\t\t\n\t</div>\n</center>\n</form>\n</div>\n</div>\n");

String display = "none";
if("yes".equalsIgnoreCase(request.getParameter("stop"))){
      out.write('\n');

	display = "";
} 

      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: ");
      out.print(display);
      out.write(";\"></div>\n<div class=\"TB_window\" id=\"deviceform\"></div> \n<div id=\"clickprocess\" style=\"z-index:150;display: none;position: absolute;left: 250px;top: 200px;width:50%;background-color:#EEEEEE;\">\n\t<table align=\"center\" width=\"100%\">\n\t<tr>\n\t\t<td align=\"center\">\n\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/progress.gif\"/>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td><center><b>");
      out.print(TranslationHelper.getTranslatedMessge("Process of loading index file is running.....Please wait...."));
      out.write("</b></center></td>\n\t</tr>\n\t</table>\n</div>\n");

display = "none";
if("yes".equalsIgnoreCase(request.getParameter("stop"))){
      out.write('\n');

display = "";
} 

      out.write("\n<div id=\"indexCommitProcess\" style=\"z-index:150;display: ");
      out.print(display);
      out.write(";position: absolute;left: 250px;top: 200px;width:50%;background-color:#EEEEEE;\">\n\t<table align=\"center\" width=\"100%\">\n\t<tr>\n\t\t<td align=\"center\">\n\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/progress.gif\"/>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td><center><b>");
      out.print(TranslationHelper.getTranslatedMessge("Commiting indexed data.....Please wait...."));
      out.write("</b></center></td>\n\t</tr>\n\t</table>\n</div>\n");

		if(isLoadingProcessRunning){
			

      out.write("\n\t\t\t<div id=\"indexDiv\">\n\t\t\t<form name=\"progressbarform\" action=\"");
      out.print(request.getContextPath());
      out.write("/servlets/LoadDataManager\" method=\"POST\">\n\t\t\t\t<input type=\"hidden\" name=\"startrowlogfile\" value=\"");
      out.print(startrowlogfile);
      out.write("\">\n\t\t\t\t<input type=\"hidden\" name=\"endrowlogfile\" value=\"");
      out.print(endrowlogfile);
      out.write("\">\n\t\t\t\t<input type=\"hidden\" name=\"startdate\" value=\"");
      out.print(newStartDate);
      out.write("\">\n\t\t\t\t<input type=\"hidden\" name=\"enddate\" value=\"");
      out.print(newEndDate);
      out.write("\">\n\t\t\t\t<div class=\"progressbar\" style=\"z-index:150;position: absolute;left: 250px;top: 200px;width:50%;background-color: #EEEEEE;\">\n\t\t\t\t\t<table align=\"center\" width=\"100%\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td colspan=\"3\"><center><b>\n");

						if("yes".equalsIgnoreCase(request.getParameter("processrunning"))){
							if(LoadDataHandler.getRunningProcessFlag()==2){

      out.write("\n\t\t\t\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Extracting row file(s), Please wait..."));
      out.write('\n');

							}else{

      out.write("\n\t\t\t\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Loading index files, Please wait..."));
      out.write('\n');

								}
						}else{

      out.write("\n\t\t\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Loading Process is Already running Please Wait...") + "<br>");
      out.write('\n');

						}

      out.write("\n\t\t\t\t\t\t</b></center>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td width=\"25%\" align=\"right\"><img alt=\"Loading\" src=\"");
      out.print(request.getContextPath());
      out.write("/images/loader.gif\" /></td>\n\t\t\t\t\t\t<td>\n\t\t\t\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border: 2px solid #999999;\">\n\t\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t\t<td id=\"first\" height=\"15px\" width=\"0%\" style=\"background-color: #96AEBE;\"></td>\n\t\t\t\t\t\t\t\t<td id=\"second\" height=\"15px\" width=\"100%\" style=\"background-color: #E8EDF1;\"></td>\n\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\t</table>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td id=\"data\" width=\"25%\" align=\"left\">&nbsp;&nbsp;0%</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t\t<table align=\"center\" width=\"100\">\n\t\t\t\t\t<tr width=\"100\">\n\t\t\t\t\t\t<td width=\"100\" align=\"center\">\n\t\t\t\t\t\t\t<input type=\"button\" class=\"criButton\" value=\"Cancel\" onClick=\"location.href='");
      out.print(request.getContextPath());
      out.write("/webpages/archive.jsp?stop=yes&startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value\"/>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t</div>\n\t\t\t</form>\n\t\t\t</div>\n");

		}
	} catch(Exception e){
		CyberoamLogger.appLog.debug("archive.jsp.e " +e,e);
	}

      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n<div class=\"TB_window\" id=\"deviceform\"></div> \n<script type=\"text/javascript\">\n");

	if("yes".equalsIgnoreCase(request.getParameter("stop"))){
		while(LoadDataHandler.getCommit() == 0)	
			Thread.sleep(1000);	

      out.write("\n\t\tdocument.getElementById(\"indexCommitProcess\").style.display = 'none';\n\t\tdocument.getElementById(\"TB_overlay\").style.display = 'none';\t\n");

	}

      out.write("\n</script>\n</body>\n</html>\n");
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
