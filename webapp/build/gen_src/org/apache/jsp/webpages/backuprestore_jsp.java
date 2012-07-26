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
import org.cyberoam.iviewdb.helper.ConnectionPool;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.helper.LoadDataHandler;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.utility.ByteInUnit;
import org.cyberoam.iview.helper.BackupDataHandler;
import org.cyberoam.iview.helper.RestoreDataHandler;
import org.cyberoam.iview.device.beans.DeviceGroupRelationBean;
import org.cyberoam.iview.device.beans.DeviceGroupBean;
import java.util.Iterator;
import org.cyberoam.iview.authentication.beans.*;

public final class backuprestore_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

	try {
		if (CheckSession.checkSession(request, response) < 0) {
			return;
		}

		int iPageno = 1;
		String strPageno = request.getParameter("pageno");
		if (strPageno != null && !"".equalsIgnoreCase(strPageno)) {
			iPageno = Integer.parseInt(strPageno);
		}
		int iLimit = 5;
		String strLimit = request.getParameter("limit");
		if (strLimit != null) {
			iLimit = Integer.parseInt(strLimit);
		}

		// If request to extract row log otherwise null value
		String startrowlogfile = request.getParameter("startrowlogfile");
		String endrowlogfile = request.getParameter("endrowlogfile");
		if (startrowlogfile == null) {
			startrowlogfile = "";
		}
		if (endrowlogfile == null) {
			endrowlogfile = "";
		}

		boolean isBackupProcessRunning = false;
		if (!BackupDataHandler.isStopped()) {
			String backstop = request.getParameter("backupstop");
			if (backstop != null && "true".equalsIgnoreCase(backstop)) {
				BackupDataHandler.setStopFlag(true);
			} else {
				isBackupProcessRunning = true;
			}
		}

		if (BackupDataHandler.isStopped())
			isBackupProcessRunning = false;

//		session.setAttribute("statusCheck", request.getParameter("statusCheck"));
		
		boolean isRestoreProcessRunning = false;
		if (!RestoreDataHandler.isStopped()) {
			String restorestop = request.getParameter("restorestop");
			if (restorestop != null && "true".equalsIgnoreCase(restorestop)) {
				session.setAttribute("statusCheck","3");
				RestoreDataHandler.setStopFlag(true);
			} else {
				isRestoreProcessRunning = true;
			}
		}
		

		String formattedstartdate = request.getParameter("formattedstartdate");
		if (formattedstartdate == null || "NULL".equalsIgnoreCase(formattedstartdate) || "".equalsIgnoreCase(formattedstartdate)) {
			formattedstartdate = (new SimpleDateFormat("dd, MMM yyyy")).format(new Date());
		}
		String formattedenddate = request.getParameter("formattedenddate");
		if (formattedenddate == null || "NULL".equalsIgnoreCase(formattedenddate) || "".equalsIgnoreCase(formattedenddate)) {
			formattedenddate = (new SimpleDateFormat("dd, MMM yyyy")).format(new Date());
		}
		String qString = request.getQueryString();
		if (qString == null) {
			qString = "";
		}

      out.write("\n\n<html>\n<head>\n<title>");
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
      out.write("/javascript/container.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/combo.js\"></script>\n<SCRIPT SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ajax.js\"></SCRIPT>\n<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></SCRIPT>\n<style type=\"text/css\">\n.loadButton {\n\tborder: 0px;\n\tbackground: transparent;\n\tfont-family: Verdana, Arial, Helvetica, sans-serif;\n\tfont-size: 11px;\n\ttext-decoration: underline;\n}\n\n.loadButton1 {\n\tborder: 0px;\n\tbackground: transparent;\n\tfont-family: Verdana, Arial, Helvetica, sans-serif;\n\tfont-size: 11px;\n\ttext-decoration: none;\n}\n</style>\n<script type=\"text/javascript\" language=\"javascript\">\n\tvar URL = \"");
      out.print(request.getContextPath());
      out.write("/webpages/backuprestore.jsp?");
      out.print(qString);
      out.write("\";\n\tvar iPageno = '");
      out.print(iPageno);
      out.write("';\n\tvar iLastPage = null;\n\tvar http_request = false;\n\tvar childwindow;\n\tvar cnt = 0;\n\tvar timerVal;\n\tvar filenotfountcount = 0;\n\tvar xmlHttp = null;\n   \n\twindow.onload = function (evt) {\n\t\tsetWidth();\t\t\t\n\t\tcheckLoading();\t\n\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n\tfunction changeColor(mode,element,inTable){\n\t\tif(mode == '1'){\n\t\t\telement.className=\"trlight1\";\n\t\t\tdocument.getElementById(inTable).className = \"innerTableData2\";\n\t\t} else {\n\t\t\telement.className=\"trlight\";\n\t\t\tdocument.getElementById(inTable).className = \"innerTableData1\";\n\t\t}\n\t}\n\n\t//Takes the backup of the checkboxes(6hours) selected and for selected devices for a particular day\n   \tfunction BackupData(){\n\t\tvar filelisttmp=\"\";\n\t\tvar filelist=\"\";\t\t\n\t\tvar ischeck=false;\t\t\n\t\tvar criteria=\"\";\n\n   \t\tfor(var j=0;j<viewarchivedetail.length;j++){ \n\t\t   filelisttmp=\"\";\n\t\t   if (viewarchivedetail[j].type == \"checkbox\") {\n\t\t     \tif(viewarchivedetail[j].checked == true ){\t\t\t     \t\n");
      out.write("\t\t     \t\tif(!viewarchivedetail[j].disabled){\n\t\t\t     \t\tischeck\t= true;\n\t\t\t     \t\tif(filelist == \"\"){\n\t\t     \t\t\t\tfilelist = viewarchivedetail[j].value;\n\t\t\t     \t\t}else{\n\t\t\t     \t\t\tfilelist = filelist + \",\" + viewarchivedetail[j].value;\n\t\t\t     \t\t}\n\t\t    \t \t}\n\t\t   \t\t} \t\t   \n\t\t\t}\n\t\t}\n\t\t\n\t\tif(!ischeck){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Select atleast one check box to take Backup"));
      out.write("\");\t\t\n\t\t\treturn false;\n\t\t}\n\t\tdocument.viewarchivedetail.indexfilelist.value = filelist;\n\t\tdocument.viewarchivedetail.appmode.value = \"");
      out.print(ApplicationModes.ARCHIEVE_BACKUP_REQUEST);
      out.write("\";\n\t\tdocument.viewarchivedetail.submit();\n\t\treturn true;\n\t}\n\n\tfunction dofilter(){\n\t\tlocation.href=\"/iview/webpages/backuprestore.jsp?startdate=\"+document.viewarchivedetail.startdate.value+\"&enddate=\"+document.viewarchivedetail.enddate.value+\"&formattedstartdate=\"+document.viewarchivedetail.displaystartdate.value+\"&formattedenddate=\"+document.viewarchivedetail.displayenddate.value;\n\t}\n\tfunction createXMLHttpRequest(){\n        if(typeof XMLHttpRequest != \"undefined\"){\n\t        xmlHttp = new XMLHttpRequest();\n\t    }\n\t    else if(typeof window.ActiveXObject != \"undefined\"){\n\t        try {\n\t            xmlHttp = new ActiveXObject(\"Msxml2.XMLHTTP.4.0\");\n\t        }\n\t        catch(e){\n\t            try {\n\t                xmlHttp = new ActiveXObject(\"MSXML2.XMLHTTP\");\n\t            }\n\t            catch(e){\n\t                try {\n\t                    xmlHttp = new ActiveXObject(\"Microsoft.XMLHTTP\");\n\t                }\n\t                catch(e){\n\t                    xmlHttp = null;\n\t                }\n\t            }\n\t        }\n");
      out.write("\t    }\n\t    return xmlHttp;\n\t}\n\tfunction getTheContent(URL){\n\t    if(createXMLHttpRequest()){\n\t\t\tif(\"");
      out.print(endrowlogfile);
      out.write("\" == \"\" && \"");
      out.print(startrowlogfile);
      out.write("\" == \"\" && cnt==0){\n\t\t\t\tcnt=1;\n\t\t\t}\n\t\t\tcnt++;\n\t\t\txmlHttp.open(\"GET\", URL+\"?\"+cnt++, true);\n\t\t\txmlHttp.onreadystatechange = function() { contentIsReady(xmlHttp); };\n\t\t\txmlHttp.send(null);\n\t    }\n\t}\n\t\n\tfunction contentIsReady(xmlHttp){\n\t    if(xmlHttp && xmlHttp.readyState == 4){\n\t\t\talertContents(xmlHttp);\n\t        xmlHttp = null;\n\t    }\n\t}\n\tfunction closeWindow(){\n\t");
if ("yes".equalsIgnoreCase(request.getParameter("processrunning"))) {
      out.write("\n\t\tclearTimeout(timerVal);\n\t\tif(\"");
      out.print(endrowlogfile);
      out.write("\" == \"\" && \"");
      out.print(startrowlogfile);
      out.write("\" == \"\"){\n\t\t\t//timerVal=setTimeout('functionCall()',2000);\n\t\t\tlocation.href='");
      out.print(request.getContextPath());
      out.write("/webpages/backuprestore.jsp?stop=yes&startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value;\n\t\t}else{\n\t\t\tdocument.progressbarform.startdate.value = document.viewarchivedetail.startdate.value\n\t\t\tdocument.progressbarform.enddate.value = document.viewarchivedetail.enddate.value\n\t\t\tdocument.progressbarform.submit();\n\t\t}\n\t\treturn;\n\t");
} else {
      out.write("\n\t\tlocation.href='");
      out.print(request.getContextPath());
      out.write("/webpages/backuprestore.jsp?startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value;\n\t");
}
      out.write("\n\t}\n\n\tfunction doSomething() {\n\t\ttimerVal=setTimeout('loadFunctionCall()',1000);\n\t}\n\t\n\tfunction replaceQueryString(url,param,value) {\n\t\tvar re = new RegExp(\"([?|&])\" + param + \"=.*?(&|$)\",\"i\");\n\t\tif (url.match(re)) {\n\t\t\treturn url.replace(re,'$1' + param + \"=\" + value + '$2');\n\t\t} else {\n\t\t\treturn url + '&' + param + \"=\" + value;\n\t\t}\n\t}\n\tfunction selectCombo(id,index){\n\t\tele = document.getElementById(\"Combo_item\"+id+\"_\"+index);\n\t\tvar limit = ele.innerHTML;\n\t\tURL = replaceQueryString(URL,'limit',limit);\t\n\t\tdocument.location.href = URL;\n\t}\n\tfunction movePage(num){\n\t\tURL = replaceQueryString(URL,'pageno',num);\t\n\t\tdocument.location.href = URL;\n\t}\n\tfunction  jumpPage(){\n\t\tvar pageNo = document.getElementById(\"gotopage\").value;\n\t\tif(pageNo == null || isNaN(pageNo) || pageNo < 1 || pageNo > iLastPage){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Please enter valid page no."));
      out.write("\");\n\t\t}else{\n\t\t\tURL = replaceQueryString(URL,'pageno',pageNo);\t\n\t\t\tdocument.location.href = URL;\n\t\t}\n\t}\n\tfunction alertContents(http_request) {\n\t\tvar regExp=/^[0-9]+$/\n\t\tif (http_request.readyState == 4) {\n        \tif (http_request.status == 200) {\n           \t\tif(http_request.responseText != -1){\n\t\t\t\t\tif(isNaN(http_request.responseText) == false){\n\t\t\t\t\t\tvar obj=document.getElementById(\"first\");\n\t\t\t\t\t\tvar obj1=document.getElementById(\"second\");\n\t\t\t\t\t\tvar obj2=document.getElementById(\"data\");\n\t\t\t\t\t\tvar resWidth;\n\t\t\t\t\t\tif(http_request.responseText == 0 || http_request.responseText == '')\n\t\t\t\t\t\t\tresWidth = 1;\n\t\t\t\t\t\telse if(http_request.responseText == 100){\n\t\t\t\t\t\t\tcloseWindow();\t\t\n\t\t\t\t\t\t\treturn;\n\t\t\t\t\t\t}\n\t\t\t\t\t\telse resWidth = http_request.responseText;\n\t\t\t\t\t\tobj2.innerHTML = '&nbsp;'+resWidth+'%';\n\t\t\t\t\t\tobj.width = resWidth + '%';\n\t\t\t\t\t\tobj1.width = (100 - resWidth) + '%';\n\t\t\t\t\t\tfilenotfountcount=0;\n\t\t\t\t\t}\n\t\t\t\t}else{\n\t\t\t\t\tfilenotfountcount++;\n\t\t\t\t}\n\t\t\t\tif(http_request.responseText == 100){\t\n\t\t\t\t\tcloseWindow();\t\t\n\t\t\t\t\treturn;\t\t\t\n");
      out.write("\t\t\t\t}\n\t\t\t\tif(filenotfountcount > 10){\n\t\t\t\t\treturn;\n\t\t\t\t}\n           \t\tdoSomething();\n           } else {\n               alert(\"");
      out.print(TranslationHelper.getTranslatedMessge("There is a problem with the request."));
      out.write(" \");\n           }\n       }\n    }\n\t\n\tfunction getResponse(xmlReq,id){\t\t\n\t\tif(xmlReq!=null){\t\t\t\n\t\t\tvar rootObj=xmlReq.getElementsByTagName(\"root\").item(0);\n\t\t\tvar msgObj=rootObj.getElementsByTagName(\"msg\").item(0);\n\t\t\tvar statusObj=rootObj.getElementsByTagName(\"status\").item(0);\n\t\t\tvar data=msgObj.childNodes[0].data;\n\t\t\tvar status=statusObj.childNodes[0].data;\n\t\t\tvar divObj=document.getElementById(\"statusDivMain\");\n\t\t\tdivObj.style.display=\"block\";\n\t\t\tvar div=document.getElementById(\"statusDiv\");\n\t\t\tdiv.innerHTML=data;\t\t\t\n\t\t\tif(status==1){\n\t\t\t\tsetTimeout(\"GetStatusValue()\",500);\n\t\t\t}else{\n\t\t\t\tsetTimeout(\"hideStatus()\",3000);\t\t\t\t\n\t\t\t}\n\t\t}\t\t\t\n\t}\n\t\n\tfunction hideStatus(){\n\t\tvar divObj=document.getElementById(\"statusDivMain\");\n\t\tdivObj.style.display=\"none\";\n\t\twindow.location.href='");
      out.print(request.getContextPath());
      out.write("/webpages/backuprestore.jsp';\t\t\n\t}\n\n\t//opens the popup box depending upon the choice for backedup files and to restore files\n\tfunction openFiles(id){\t\n\t\tvar head=document.getElementById(\"contentheader\");\n\t\thead.style.zIndex=\"111\";\n\t\n\t\tif(id=='1'){\t\t\t\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/backupfiles.jsp';\n\t\t}\n\t\telse{\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/restorefiles.jsp';\n\t\t}\t\t\t\n\t\t\n\t\thandleThickBox(1,'backuprestore',500);\t\t\n\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/backuprestore.jsp?';\t\n\t}\n\t\t\n\t//adds a row while uploading multiple files for restoration.\n\tfunction addRow() {\n\t\tvar table = document.getElementById(\"tbldata\");\n\n\t\tvar row=document.createElement(\"TR\");\n\t\trow.height=\"25px\";\n\t\trow.id=table.rows.length+2;\n\t\n\t\tvar cell1=document.createElement(\"TD\");\n\t\tcell1.className=\"tddata\";\n\t\tcell1.innerHTML=\"<input type='file' name='filename'>\"\n\t\n\t\tvar cell2=document.createElement(\"TD\");\n\t\tcell2.className=\"tddata\";\n\t\tcell2.innerHTML=\"<center><input type='button' onclick=deleteRow('\" + row.id + \"') class='loadButton' value='Delete'></center>\"\t\n\t\n\t    row.appendChild(cell1);\t\n\t\trow.appendChild(cell2);\t\n\t    table.appendChild(row);\n\t}\n\n\t//deletes a row from restorefiles page\n\tfunction deleteRow(rowIndex) {\n\t\tvar table = document.getElementById(\"tbldata\");\n\t\tvar row = document.getElementById(rowIndex);\t\n\t\ttable.removeChild(row);\n\t}\n\t//to confirm the action of delete from the server containing the backedup files.\n\tfunction confirmAction(x) {\n\t\tvar flag=0;\n\t\tfor(var i=1,l=x.form.length; i<l; i++){\n");
      out.write("\t\t\tif(x.form[i].type == 'checkbox' && x.form[i].checked==true){\n\t\t\t\tflag=1;\n\t\t\t\tbreak;\n\t\t\t}\n\t\t}\n\t\tif(flag==0){\n\t\t\talert(\"Select atleast one file to delete\");\t\t\n\t\t\treturn false;\n\t\t}\n\t\tif(confirm(\"Do you want to delete?\")==true){    \n\t    \treturn true;\n\t\t}  \n\t\telse{\n\t\t\treturn false;\n\t\t}  \n\t}\n\n\tfunction checkRestore(x){\n\t\tvar restorebtn=document.getElementsByName(\"filename\");\n\t\tfor(var i=0;i<restorebtn.length; i++){\t\t\t\t\n\t\t\tif(restorebtn[i].value!=\"\"){\n\t\t\t\treturn true;\n\t\t\t}\n\t\t}\n\t\talert(\"No files selected to restore\");\n\t\treturn false;\t \n\t}\t\n\t\n\tfunction loadBackupCall(){\n\t\tvar overlay = document.getElementById(\"TB_overlay\");\n\t\toverlay.style.display = '';\n\t\tcnt++;\n");
		if (BackupDataHandler.isStoppedThread() == true) {
			isBackupProcessRunning = false;
				}
      out.write("\n\t\tif(createXMLHttpRequest()){\n\t\t\tcnt++;\n\t\t\txmlHttp.open(\"GET\", \"");
      out.print(request.getContextPath());
      out.write("/AjaxController?givebackuptime=true&counter=\"+cnt, true);\n\t\t\txmlHttp.onreadystatechange = function() { backupStatus(xmlHttp); }\n\t\t\txmlHttp.send(null);\n\t    }\n\t}\n      \n\tfunction backupStatus(xmlHttp){\t\t\n\t    if(xmlHttp && xmlHttp.readyState == 4){\n\t\t\t//alertContents(xmlHttp);\n\t\t\tvar regExp=/^[0-9]+$/\n\t\t\tif (xmlHttp.readyState == 4) {\n        \t\tif (xmlHttp.status == 200) {\n           \t\t\tif(xmlHttp.responseText != -1){\n               \t\t\tif(isNaN(xmlHttp.responseText) == false){\n\t\t\t\t\t\t\t//alert('##' + xmlHttp.responseText + '##');\n\t\t\t\t\t\t\t//if(cnt>=500){\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t//} else \n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tif(xmlHttp.responseText == 0){\n\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\ttimerVal=setTimeout('loadBackupCall()',1000);\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\telse {\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\tlocation.href='");
      out.print(request.getContextPath());
      out.write("/webpages/backuprestore.jsp?statusCheck=1&backupstop=true';\n\t\t\t\t\t\t\t\treturn;\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t}\n\t\t\t\t\t} else {\n\t\t\t\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("There is a problem with the request."));
      out.write(" \");\n\t\t\t\t\t}\n       \t\t\t}\n\t        \txmlHttp = null;\n\t    \t}\n\t\t}\n\t}\n\n\t\tfunction loadRestoreCall(){\n\t\tvar overlay = document.getElementById(\"TB_overlay\");\n\t\toverlay.style.display = '';\n\t\tcnt++;\n\t\t\n\t\tif(createXMLHttpRequest()){\n\t\t\tcnt++;\n\t\t\txmlHttp.open(\"GET\", \"");
      out.print(request.getContextPath());
      out.write("/AjaxController?giverestoretime=true&counter=\"+cnt, true);\n\t\t\txmlHttp.onreadystatechange = function() { restoreStatus(xmlHttp); }\n\t\t\txmlHttp.send(null);\n\t    }\n\t}\n      \n\tfunction restoreStatus(xmlHttp){\t\t\n\t    if(xmlHttp && xmlHttp.readyState == 4){\n\t\t\t//alertContents(xmlHttp);\n\t\t\tvar regExp=/^[0-9]+$/\n\t\t\tif (xmlHttp.readyState == 4) {\n        \t\tif (xmlHttp.status == 200) {\n           \t\t\tif(xmlHttp.responseText != -1){\n               \t\t\tif(isNaN(xmlHttp.responseText) == false){\n\t\t\t\t\t\t\t//alert('##' + xmlHttp.responseText + '##');\n\t\t\t\t\t\t\t//if(cnt>=500){\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t//} else \n\t\t\t\t\t\t\tif(xmlHttp.responseText == 0){ \n\t\t\t\t\t\t\t\ttimerVal=setTimeout('loadRestoreCall()',1000);\n\t\t\t\t\t\t\t}else {\n\t\t\t\t\t\t\t\tlocation.href='");
      out.print(request.getContextPath());
      out.write("/webpages/backuprestore.jsp?statusCheck=3&restorestop=true';\n\t\t\t\t\t\t\t\treturn;\n\t\t\t\t\t\t\t} \n\t\t\t\t\t\t}\n\t\t\t\t\t} else {\n\t\t\t\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("There is a problem with the request."));
      out.write(" \");\n\t\t\t\t\t}\n       \t\t\t}\n\t        \txmlHttp = null;\n\t    \t}\n\t\t}\n\t}\n\t\n\tfunction checkLoading(){\n");
		if (isRestoreProcessRunning) {
			out.println("loadRestoreCall();");
		}
		else if (isBackupProcessRunning) {
			out.println("loadBackupCall();");
		} else if (isBackupProcessRunning == false && BackupDataHandler.isStoppedThread() == false) {
			isBackupProcessRunning = true;
			BackupDataHandler.setStopFlag(true);
      out.write("\n\t\t\talert(\"Backup Process will be aborted after the completion of ongoing 6hr backup\");\n");
			out.println("loadBackupCall();");
		} else {
			isBackupProcessRunning = false;
		}
      out.write("\n\t}\n\n\tfunction selectAll(x) {\n\t\tfor(var i=1,l=x.form.length; i<l; i++){\n\t\t\tif(x.form[i].type == 'checkbox' && x.form[0].checked==true){\n\t\t\t\tx.form[i].checked=true;\n\t\t\t}\n\t\t\telse{\n\t\t\t\tx.form[i].checked=false;\n\t\t\t}\n\t\t}\n\t}\n\n\tfunction DeSelectAll(x){\n\t\tfor(var i=1,l=x.form.length; i<l; i++){\n\t\t\tif(x.form[i].type == 'checkbox' && x.form[i].checked==false){\n\t\t\t\tx.form[0].checked=false;\n\t\t\t\tbreak;\n\t\t\t}\n\t\t}\n\t}\n\n\n\tfunction SelectAllCheckbox(stringDay){\n\t\tvar chk = document.getElementById(stringDay);\n\t\tif(chk.checked==false){\n\t\t\tfor(i=0;i<4;i++){\n\t\t\t\tvar chk1 = document.getElementById(stringDay+i);\n\t\t\t\tif(parseInt(chk1.name.substr(6))>0){\n\t\t\t\t\t\tchk1.disabled=false;\n\t\t\t\t}\n\t\t\t}\n\t\t\t\n\t\t}\n\n\n\t\tvar i;\n\t\tfor(i=0;i<4;i++){\n\t\t\tvar chk1 = document.getElementById(stringDay+i);\n\n\t\t\t\tif(chk.checked==true)\n\t\t\t\t\tchk1.disabled=true;\n\t\t}\n\t}\n\t\n\t\n</script>\n</head>\n<body>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n<div class=\"TB_window\" id=\"backuprestore\"></div>\n<div class=\"maincontent\" id=\"main_content\">\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp" + (("Date.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("device", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()), out, true);
      out.write(' ');
      out.write('\n');

 	String startdate = (String) session.getAttribute("startdate");
 	String enddate = (String) session.getAttribute("enddate");

      out.write("\n<div class=\"reporttitlebar\">\n<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Backup Management"));
      out.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>\n<div class=\"reporttimetitle\"><b>From:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("startdate"));
      out.write("</font>\n<br>\n<b>To:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("enddate"));
      out.write("</font>\n</div>\n<div class=\"restore\"><input align=right type=\"button\" name=\"restore\" onClick=\"openFiles('2')\"\n\tvalue=\"");
      out.print(TranslationHelper.getTranslatedMessge("Restore Files"));
      out.write("\" class=\"criButton\" style=\"height: 20px\" /></div>\n");
	
	File dstPath=new File(IViewPropertyReader.BackupDIR);
	if(dstPath.list().length!=0){

      out.write("\t\t\t\n<div class=\"backup\"><input align=right type=\"button\" name=\"backup\" onClick=\"openFiles('1')\" \n\tvalue=\"");
      out.print(TranslationHelper.getTranslatedMessge("Download Backup Files"));
      out.write("\" class=\"criButton\" style=\"height: 20px\" /> &nbsp;</div>\n");

	}

      out.write("\n</div>\t\n");

	if (session.getAttribute("statusCheck") != null) {

      out.write("\n\t\t<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\" class=\"TableData\" style=\"padding: 3px 0pt 0pt 3px;\">\n");

		if (session.getAttribute("statusCheck").equals("1")) {

      out.write("\n\t\t\t<tr>\n\t\t\t<td align=\"left\" class=\"posimessage\">\n\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Backup file created successfully, to download press \"Download Backup Files\" button"));
      out.write("</td>\n\t\t\t</tr>\n\n\t\t\t<script type=\"text/javascript\">\n\t\t\t\topenFiles('1');\n\t\t\t</script>\n\n");

		} else if (session.getAttribute("statusCheck").equals("2")) {

      out.write("\n\t\t\t<tr>\n\t\t\t<td align=\"left\" class=\"posimessage\">");
      out.print(session.getAttribute("fileName") + " " + TranslationHelper.getTranslatedMessge("deleted successfully"));
      out.write("</td>\n\t\t\t</tr>\n");

		} else if (session.getAttribute("statusCheck").equals("3")) {


			int loaded = RestoreDataHandler.getLoaded();
			int notloaded = RestoreDataHandler.getNotLoaded();
			if (loaded > 0) {

      out.write("\n\t\t\t<tr>\n\t\t\t\t<td align=\"left\" class=\"posimessage\">");
      out.print(loaded + TranslationHelper.getTranslatedMessge(" file(s) uploaded successfully"));
      out.write("</td>\n\t\t\t</tr>\n");

			}
			if (notloaded > 0) {

      out.write("\n\t\t\t<tr>\n\t\t\t\t<td align=\"left\" class=\"nagimessage\">");
      out.print(TranslationHelper.getTranslatedMessge("Uploading invalid file(s) is not valid"));
      out.write("</td>\n\t\t\t</tr>\n");
			}
			RestoreDataHandler.setLoaded(0);
			RestoreDataHandler.setNotLoaded(0);
		}else if (session.getAttribute("statusCheck").equals("4")) { 
      out.write("\n\t\t\t<tr>\n\t\t\t\t<td align=\"left\" class=\"nagimessage\">");
      out.print(TranslationHelper.getTranslatedMessge("Backup Not Successful"));
      out.write("</td>\n\t\t\t</tr>\t\t\t\n");
			
		}
		session.removeAttribute("statusCheck");

      out.write("\n\t</table>\n");

	}
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


      out.write("\n\n\n<div style=\"float: left; width: 100%\">\n<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"viewarchivedetail\">\n<input type=\"hidden\" id=\"indfilelist\" name=\"indexfilelist\" value=\"\" />\n<input type=\"hidden\" id=\"pageno\" name=\"pageno\" value=\"");
      out.print(strPageno);
      out.write("\" />\n<input type=\"hidden\" id=\"exctractlog\" name=\"extractrowlog\" value=\"0\" />\n<input type=\"hidden\" id=\"dstring\" name=\"daystring\" value=\"\" />\n<input type=\"hidden\" name=\"startdate\" value=\"");
      out.print(startdate);
      out.write("\" />\n<input type=\"hidden\" name=\"enddate\" value=\"");
      out.print(enddate);
      out.write("\" />\n<input type=\"hidden\" name=displaystartdate value=\"");
      out.print(formattedstartdate);
      out.write("\" />\n<input type=\"hidden\" name=displayenddate value=\"");
      out.print(formattedenddate);
      out.write("\" />\n<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.ARCHIEVE_LOAD_REQUEST);
      out.write("\" /> \n");


 	out.println("<script type=\"text/javascript\">iLastPage=" + iLastPage + "</script>");
 	if (iPageno > iLastPage) {
 		iPageno = iLastPage;
 		out.println("<script type=\"text/javascript\">iPageno=" + iPageno + "</script>");
 	}


      out.write("\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n\t<tr>\n\t\t<td align=\"left\">\n\t\t<table width=\"100%\">\n\t\t\n\t\t\n\t\t\t<tr>\n\t\t\t\t<td colspan=\"2\">\n\t\t\t\t<div class=\"content_head\" width=\"100%\">\n\t\t\t\t<div width=\"100%\" class=\"Con_nevi\">\n\t\t\t\t<table width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td align=\"left\" class=\"navigationfont\" width=\"200px\">\n\t\t\t\t\t\t<span style=\"float: left; margin-top: 1px;\"> ");
      out.print(TranslationHelper.getTranslatedMessge("Show"));
      out.write("&nbsp; </span>\n\t\t\t\t\t\t<span style=\"float: left\">\n\t\t\t\t\t\t<div id=\"sizelimit\" class=\"Combo_container\"  style=\"margin-bottom:3px;\"></div>\n\t\t\t\t\t\t</span> <span style=\"float: left; margin-top: 1px;\">&nbsp; ");
      out.print(TranslationHelper.getTranslatedMessge("days per page"));
      out.write(" </span></td>\n\t\t\t\t\t\t<script language=\"javascript\">\n\t\t\t\t\t\t\t\tsetComboContainer(\"sizelimit\",\"40px\",\"1\");\n\t\t\t\t\t\t\t\tinsertElements(\"sizelimit\",[\"5\",\"10\",\"15\",\"20\",\"25\"]);\n\t\t\t\t\t\t\t\tsetSelectedText(\"sizelimit\",");
      out.print(iLimit);
      out.write(");\n\t\t\t\t\t\t</script>\n\t\t\t\t\t\t<td class=\"navigationfont\" align=\"right\">\n\t\t\t\t\t\t<span style=\"float: right; margin-right: 10px;\">\n\t\t\t\t\t\t<input type='button' class='navibutton' value='Go' onClick=\"jumpPage()\" /> \t</span> \n\t\t\t\t\t\t<span style=\"float: right\">\n\t\t\t\t\t\t<input class=\"navitext\" id=\"gotopage\" size=\"5\" type=\"text\" style=\"width: 35px; margin-left: 5px; margin-right: 5px;\">\n\t\t\t\t\t\t</span>\n\t\t\t\t\t\t<span style=\"float: right; margin-top: 2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Go to page :"));
      out.write(" </span>\n\t\t\t\t\t\t<span style=\"float: right; margin-top: 2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n\t\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Page"));
      out.write("&nbsp;");
      out.print(iPageno);
      out.write("&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("of"));
      out.write("&nbsp;");
      out.print(iLastPage);
      out.write("\n\t\t\t\t\t\t</span>\n\t\t\t\t\t\t<span style=\"float: right\">\n\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/first.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('1')\"> \n\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/prev.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print((iPageno != 1) ? (iPageno - 1) : 1);
      out.write("')\">\n\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/next.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print((iPageno != iLastPage) ? (iPageno + 1) : iLastPage);
      out.write("')\">\n\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/last.bmp\" style=\"cursor: pointer;\" onClick=\"movePage('");
      out.print(iLastPage);
      out.write("')\">\n\t\t\t\t\t\t</span></td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t\n\t\t\t\n\t\t\t<tr>\n\t\t\t\t<td colspan=\"2\">\n");

				int hrs = 6;
				try {
					if (request.getParameter("hours") != null) {
						hrs = Integer.parseInt(request.getParameter("hours"));
					}
					if (hrs < 1 || hrs > 24) {
						hrs = 6;
					}
				} catch (Exception e) {
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

      out.write("\n\t\t\t\t<table class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n\t\t\t\t\t<tr height=\"25px\">\n\t\t\t\t\t\t<td class=\"tdhead\" style=\"padding-left: 10px\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Date"));
      out.write("</b></td>\n\t\t\t\t\t\t<td style=\"padding-left: 10px\" class=\"tdhead\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("File Details"));
      out.write("</b></td>\n\t\t\t\t\t\t<td align=\"center\" class=\"tdhead\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Total Size"));
      out.write("</b></td>\n\t\t\t\t\t</tr>\n");

					if ((24 % hrs) == 0) {
						noOfRows = (24 / hrs);
					} else {
						noOfRows = (24 / hrs) + 1;
					}
					int dayCont = 0;
					if (filelist != null && filelist.size() > 0) {
						fileHandlerBean = (FileHandlerBean) filelist.get(recordcount);
						recordcount++;
						if (IViewPropertyReader.IndexFileTimeStampUsed == 2) {
							timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp()) * 1000;
						} else {
							timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp()) * 1000;
						}
						oldTimestamp = timestamp;
						sDate = fmt.parse(newEndDate);
						eDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(timestamp)));
						msecDiff = sDate.getTime() - eDate.getTime();
						daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000)));
						for (int i = 0; i < daysDiff; i++) {
							dayCont++;
							now.setTime(sDate);
							now.add(Calendar.DATE, -i);
							old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));

      out.write("\n\t\t\t\t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";'>\n\t\t\t\t\t\t\t<td class=\"tddata\" align=\"center\">");
      out.print(old_date);
      out.write("</td>\n\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\" colspan=\"3\">&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+" "+old_date);
      out.write("</td>\n\t\t\t\t\t\t\t</tr>\n");

						}						

						while (true) {
							dayCont++;
							if (IViewPropertyReader.IndexFileTimeStampUsed == 2) {
								timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp()) * 1000;
							} else {
								timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp()) * 1000;
							}
							Date d = new Date(timestamp);
							current_date = (new SimpleDateFormat("yyyy/MM/dd")).format(d);
							stringDay = (new SimpleDateFormat("yyyyMMdd")).format(d);
							Date d1 = new Date(current_date);
							Date oldDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(oldTimestamp)));
							msecDiff = oldDate.getTime() - d1.getTime();
							daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000))) - 1;
							starttimestamp = d1.getTime() + (24 * 60 * 60 * 1000);
							endtimestamp = d1.getTime() + (24 * 60 * 60 * 1000);
							dayendtimestamp = d1.getTime();
							for (int i = 0; i < daysDiff; i++) {
								dayCont++;
								now.setTime(oldDate);
								now.add(Calendar.DATE, -1 * (i + 1));
								old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));

      out.write("\n\t\t\t\t\t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";'>\n\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"center\">");
      out.print(old_date);
      out.write("</td>\n\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\" colspan=\"3\">&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+ old_date);
      out.write("</td>\n\t\t\t\t\t\t\t\t</tr>\n");

							}

      out.write("\n\t\t\t\t\t\t\t<tr class=\"trlight\" onMouseOver='changeColor(\"1\",this,\"");
      out.print(dayCont);
      out.write("\");' onMouseOut='changeColor(\"2\",this,\"");
      out.print(dayCont);
      out.write("\");'>\n\t\t\t\t\t\t\t<td class=\"tddata\" style=\"padding-left: 10px\" align=\"center\">");
      out.print(current_date);
      out.write("</td>\n\t\t\t\t\t\t\t<td>\n\t\t\t\t\t\t\t<table id=\"");
      out.print(dayCont);
      out.write("\" onMouseOver=\"this.className='innerTableData2'\" onMouseOut=\"this.className='innerTableData1'\"\n\t\t\t\t\t\t\t\t class=\"innerTableData1\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n");

							filesize = 0;
							totalfilesize = 0;
							loadedFilesize = 0;
							boolean unloadFlag = false;
							String attribute = null;

							out.println("<tr><td class=tddata><input name=\"chkbox\""
									+ "\" id=\"" + stringDay + "\" type=\"checkbox\" value=\"" + stringDay 	+ ":00_23\" onclick=SelectAllCheckbox('"+stringDay+"')>"+TranslationHelper.getTranslatedMessge("Full Day Backup")+"</td></tr>"); 							
							
							int i=0;
							for (hrscount = 0; hrscount < 24; hrscount = hrscount+ hrs) {
								starttimestamp = endtimestamp;
								endtimestamp = starttimestamp - (hrs * 60 * 60 * 1000);
								isloadedval = 1;
								if (endtimestamp < dayendtimestamp) {
									endtimestamp = dayendtimestamp;
								}
								slotfilelist = "";
								String slotSDate = (new SimpleDateFormat("HH")).format(new Date(starttimestamp - 1000));
								String slotEDate = (new SimpleDateFormat("HH")).format(new Date(endtimestamp));
								while (true) {
									if ((starttimestamp > timestamp) && (timestamp >= endtimestamp)) {
										if (fileHandlerBean.getIsLoaded() == 0) {
											isloadedval = 0;
											filesize = filesize + fileHandlerBean.getFileSize();
										} else {
											loadedFilesize += fileHandlerBean.getFileSize();
										}
										if ("".equalsIgnoreCase(slotfilelist)) {
											slotfilelist = slotfilelist + fileHandlerBean.getAppID() + "@" + fileHandlerBean.getFileName();
										} else {
											slotfilelist = slotfilelist + "," + fileHandlerBean.getAppID() + "@" + fileHandlerBean.getFileName();
									 	}
										oldTimestamp = timestamp;
										if (recordcount < filelist.size()) {
											fileHandlerBean = (FileHandlerBean) filelist.get(recordcount);
											if (IViewPropertyReader.IndexFileTimeStampUsed == 2) {
												timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp()) * 1000;
											} else {
												timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp()) * 1000;
											}
											recordcount++;
										} else {
											timestamp = 0;
										}
									} else {
										break;
									}
								}
								if (filesize == 0) {
									attribute = "disabled";
								} else {
									attribute = "";
								}
								filesize = filesize + loadedFilesize;
								out.println("<tr class=\"innertrlight\"><td class=\"innertddata\" style=\"padding-left:5px\"><input name=\"chkbox"+filesize+"\""
									+ "\" id=\"" + stringDay + (i++) + "\" type=\"checkbox\" value=\"" + stringDay 	+ ":" + slotEDate + "_" + slotSDate + "\""
									+ (filesize == 0 ? "disabled" : "") + ">" + slotEDate + "_" + slotSDate + "hrs.log (" + "<font class=\"message\">"
									+ ByteInUnit.getBytesInUnit(filesize) + ")" + "</td></tr>"); 
								totalfilesize = totalfilesize + filesize;
								filesize = 0;
							}
							out.println("</table></td><td class=\"tddata\" align=\"center\">" + ByteInUnit.getBytesInUnit(totalfilesize)+"</td></tr>");

							if (recordcount >= filelist.size() && timestamp == 0) {
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
							now.add(Calendar.DATE, -1 * (i + 1));
							old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));

      out.write("\n\t\t\t\t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";'>\n\t\t\t\t\t\t\t<td class=\"tddata\" align=\"center\">");
      out.print(old_date);
      out.write("</td>\n\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\" colspan=\"3\">&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+" "+old_date.toString());
      out.write("</td>\n\t\t\t\t\t\t\t</tr>\n");

						}
					} else {
						out.println("<tr class=\"trlight\"><td class=\"tddata\" align=\"center\" colspan=\"4\" >"+TranslationHelper.getTranslatedMessge("No archive File is Available for loading between")+" "+newStartDate+" "+TranslationHelper.getTranslatedMessge("and")+" "+newEndDate+"</td></tr>");
					}
					out.println("</table>");

      out.write("\n\t\t\t\t\t</table>\n\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t\t<br />\n\t\t\t\t<br/>\n");
				if(filelist!=null && filelist.size()>0){ 
      out.write("\n\t\t\t\t\t<div align=center><input type=\"button\" name=\"backup\" onClick=\"BackupData()\"\n\t\t\t\t\t\tvalue=\"");
      out.print(TranslationHelper.getTranslatedMessge("Backup Now"));
      out.write("\" class=\"criButton\" style=\"height: 20px\" /></div> &nbsp;\n");
				} 
      out.write("\t\t\t\t\t\t\t\t\n\t\t\t\t<center>\t\t\t\t\t\t\t\n\t\t\t\t<div id=\"statusDivMain\" style=\"display: none;\">\n\t\t\t\t\t<div class=\"navigationfont\">\n\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/progress.gif\"></img>\n\t\t\t\t\t\tUnloading Archived Files</div>\n\t\t\t\t\t<div id=\"statusDiv\" class=\"navigationfont\"></div>\n\t\t\t\t</div>\n\t\t\t\t</center>\n\t\t\t\t\n\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t\t\n\t\t\t\t</form>\n\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t\n\t\t\t\t<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n\t\t\t\t<div class=\"TB_window\" id=\"deviceform\"></div>\n\t\t\t\t<div id=\"clickprocess\" style=\"z-index: 150; display: none; position: absolute; left: 250px; top: 200px; width: 50%; background-color: #EEEEEE;\">\n\t\t\t\t<table align=\"center\" width=\"100%\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td align=\"center\"> <img src=\"");
      out.print(request.getContextPath());
      out.write("/images/progress.gif\" /></td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td>\n\t\t\t\t\t\t\t<center><b> ");
      out.print(TranslationHelper.getTranslatedMessge("Process of loading index file is running.....Please wait...."));
      out.write("</b></center>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t\t</div>\n\n");

		if (isRestoreProcessRunning) {

      out.write("\n\t\t\t<form name=\"Restorebarform\" action=\"");
      out.print(request.getContextPath());
      out.write("/servlets/LoadDataManager\" method=\"POST\">\n\t\t\t<div id=\"progressbar\" class=\"progressbar\" style=\"z-index: 150; position: absolute; left: 250px; top: 200px; width: 50%; background-color: #EEEEEE;\">\n\t\t\t\t<table align=\"center\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td align=\"center\"><img alt=\"Loading\"\n\t\t\t\t\t\t\tsrc=\"");
      out.print(request.getContextPath());
      out.write("/images/progress.gif\" /></td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td><b>");
      out.print(TranslationHelper.getTranslatedMessge("Restoring, Please wait..."));
      out.write("</b></td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\t\t\t</form>\n");

		}
		else if (isBackupProcessRunning && BackupDataHandler.isStoppedThread() == false) {

      out.write("\n\t\t\t<form name=\"backupbarform\" action=\"");
      out.print(request.getContextPath());
      out.write("/servlets/LoadDataManager\" method=\"POST\">\n\t\t\t<div id=\"progressbar\" class=\"progressbar\" style=\"z-index: 150; position: absolute; left: 250px; top: 200px; width: 50%; background-color: #EEEEEE;\">\n\t\t\t\t<table align=\"center\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td align=\"center\"><img alt=\"Loading\"\n\t\t\t\t\t\t\tsrc=\"");
      out.print(request.getContextPath());
      out.write("/images/progress.gif\" /></td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td><b>");
      out.print(TranslationHelper.getTranslatedMessge("Taking backup, Please wait..."));
      out.write("</b></td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t\t<table align=\"center\" width=\"100\">\n\t\t\t\t\t<tr width=\"100\">\n\t\t\t\t\t\t<td width=\"100\" align=\"center\">\n\t\t\t\t\t\t\t<input type=\"button\" class=\"criButton\" value=\"Cancel\"\n\t\t\t\t\t\t\tonClick=\"location.href='");
      out.print(request.getContextPath());
      out.write("/webpages/backuprestore.jsp?backupstop=true'\" />\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\t\t\t\t\t\t\t\n\t\t\t</form>\n\t\n");

		}
	} catch (Exception e) {
		CyberoamLogger.appLog.debug("backuprestore.jsp.e " + e, e);
	}

      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n\n</body>\n</html>\n");
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
