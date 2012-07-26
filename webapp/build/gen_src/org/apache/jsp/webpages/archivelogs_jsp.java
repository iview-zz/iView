package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.net.*;
import java.io.*;
import org.cyberoam.iview.utility.*;
import org.cyberoam.iview.beans.SearchDataBean;
import java.text.SimpleDateFormat;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.ArchiveSearchParameter;
import org.cyberoam.iview.beans.IndexFieldsBean;
import org.cyberoam.iview.utility.DateDifference;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.beans.SearchIndexBean;
import java.util.logging.ErrorManager;

public final class archivelogs_jsp extends org.apache.jasper.runtime.HttpJspBase
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
		
		if(request.getParameter("isSearch")!=null && "true".equalsIgnoreCase(request.getParameter("isSearch"))){
			ArchiveSearchParameter.setSessionObj(request);
		} else {
			session.removeAttribute("archievesearch");
		}
		//String tabNo = request.getParameter("tabno");
		/*if(tabNo == null || tabNo.equalsIgnoreCase("")){
			tabNo = "2";
		}*/
		ArchiveSearchParameter archiveSearchParameter = ArchiveSearchParameter.getSessionObj(request);
		
		//for dinemic archivelogs.jsp depending on categoryID		
		String categoryID = (String)session.getAttribute("categoryid");		
		ArrayList<IndexFieldsBean> indexFileList = IndexFieldsBean.getIndexFieldBeanListByCategoryID(categoryID);				

      out.write("\n\n\n\n<html>\n<head>\n<title>");
      out.print(iViewConfigBean.TITLE);
      out.write("</title>\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\">\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/combo.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></script>\n<style type=\"text/css\">\n.message{\n\tborder: 1px solid #D9D9D9;\n\tmargin: 3px 0 0 2px;\n}\n.message tr{\n\tbackground-color: #F1F1F1;\n}\n.message tr td{\n\tfont-family: tahoma,arial,san-serif;\n\tfont-size: 11px;\n\tpadding: 3px;\n\tcolor: maroon;\n\tfont-weight: bold;\n}\n</style>\n<script type=\"text/javascript\" language=\"javascript\">\n\t\n   \tvar http_request = false;\n   \tvar childwindow;\n\tvar fieldArray = new Array();\n\tvar tablefieldArray = new Array();\n\tvar criteriaArray = new Array(\"is\",\"isn't\",\"contains\",\"starts with\");\n\tvar criteriaValueArray = new Array(\"=\",\"!=\",\" like '%\",\" like '\");\n\tvar numCriteriaArray = new Array(\"&gt;\",\"&lt;\",\">=\",\"<=\");\n\tvar numCriteriaValueArray = new Array(\">\",\"<\",\">=\",\"<=\");\n\n\twindow.onload = function (evt) {\n\t\tsetWidth();\t\t\t\t\n\t};\n\t\n\t\n\t\n\t\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n   \t\n\tfunction submitData(url,lotsize,totalrecord,currentposition,criteria,tblname){\n");
      out.write("\t\t\n\t\tvar form = document.archivelogs;\n\t\tform.lotSize.value = lotsize;\n\t\tform.curPos.value = currentposition;\n\t\tform.submit();\n\t}\n\tfunction jumptopage(curPageNo){\n\t\tvar pageno = document.getElementById(\"gotopage\").value;\n\t\tif(pageno > 2147483647){\n\t\t\talert(\"Please enter valid page number\");\n\t\t\treturn;\n\t\t}\n\t\tvar lastpage = parseInt(document.archivelogs.lastpage.value);\n\t\tvar form = document.archivelogs;\n\t\tif(false/*pageno == \"\" || isNaN(pageno) || pageno<1 || pageno>lastpage*/) {\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Please enter valid page no."));
      out.write("\");\n\t\t} else if(curPageNo != pageno ) {\n\n\t\t\tvar element = document.getElementById(\"Combo_selectsizelimit\");\n\t\t\tvar limit = element.innerHTML;\n\t\t\tvar curPos = ((document.archivelogs.lotSize.value * pageno) - document.archivelogs.lotSize.value);\n\t\t\tsubmitData('");
      out.print(request.getContextPath());
      out.write("/webpages/archivelogs.jsp',limit,form.totalSize.value,curPos,form.criteria.value,form.tblname.value);\n\t\t} \n\t}\n\tfunction showSearchingCriteria(){\n\t\tvar objDiv = document.getElementById('searchdiv');\n\t\tif(objDiv.style.display == \"none\"){\n\t\t\tobjDiv.style.display=\"\";\n\t\t} else {\n\t\t\tobjDiv.style.display=\"none\";\n\t\t}\n\t}\n\tfunction hideSearchingCriteria(){\n\t\tvar objDiv = document.getElementById('searchdiv');\n\t\tobjDiv.style.display=\"none\";\n\t}\n\n\tfunction URLEncode (clearString) {\n  \t\tvar output = '';\n  \t\tvar x = 0;\n  \t\tclearString = clearString.toString();\n  \t\tvar regex = /(^[a-zA-Z0-9_.]*)/;\n  \t\twhile (x < clearString.length) {\n    \t\tvar match = regex.exec(clearString.substr(x));\n    \t\tif (match != null && match.length > 1 && match[1] != '') {\n    \t\t\toutput += match[1];\n      \t\t\tx += match[1].length;\n    \t\t} else {\n      \t\t\tif (clearString[x] == ' ')\n        \t\t\toutput += '+';\n      \t\t\telse {\n        \t\t\tvar charCode = clearString.charCodeAt(x);\n        \t\t\tvar hexVal = charCode.toString(16);\n        \t\t\toutput += '%' + ( hexVal.length < 2 ? '0' : '' ) + hexVal.toUpperCase();\n");
      out.write("      \t\t\t}\n      \t\t\tx++;\n    \t\t}\n  \t\t}\n  \t\treturn output;\n\t}\n\tfunction changeImg(){\n\t\tvar tempImg = document.archivelogs.searchCrit1.value;\n\t\tdocument.archivelogs.searchCrit1.value = document.getElementById(\"searchCrit\").src;\n\t\tdocument.getElementById(\"searchCrit\").src = tempImg;\n\t\tshowSearchingCriteria();\n\t}\n\n\tfunction setComboContainer1(id,width,mainid) {\n\t\tvar combo = document.getElementById(id);\n\t\tcombo.onclick = function(){showComboBody(this.id)};\n\t\tcombo.style.width = width;\n\t\tvar newdiv = document.createElement(\"div\");\n\t\tnewdiv.className = \"Combo_select\";\n\t\tnewdiv.id = \"Combo_select\"+id;\n\t\tnewdiv.innerHTML = \"Select item\";\n\t\tnewdiv.style.width = (parseInt(combo.style.width) - 20)+\"px\";\n\t\tcombo.appendChild(newdiv);\n\t\t\n\t\tnewdiv = document.createElement(\"div\");\n\t\tnewdiv.className = \"Combo_button\";\n\t\tnewdiv.innerHTML=\"<input type=\\\"hidden\\\" id=\\\"comboFlag\"+id+\"\\\" value=\"+mainid+\" />\";\n\t\tnewdiv.style.left=(parseInt(combo.style.width)-20)+\"px\";\n\t\tcombo.appendChild(newdiv);\n\t\tnewdiv = document.createElement(\"div\");\n");
      out.write("\t\tnewdiv.id=\"Combo_body\"+id;\n\t\tnewdiv.className=\"hidden\";\n\t\tcombo.appendChild(newdiv);\n\t}\n\tfunction insertElements1(id,arr,totalSize,curPos,criteria,tblname){\n\t\t\n\t\t\n\t\tvar flag = document.getElementById(\"comboFlag\"+id).value;\n\t\tvar ele = document.getElementById(\"Combo_body\"+id);\t\t\n\t\tfor(var x=0 ; x< arr.length ;x++){\n\t\t\tnewdiv = document.createElement(\"div\");\n\t\t\tnewdiv.className = \"Combo_item_single\";\n\t\t\tnewdiv.id = \"Combo_item\"+id+\"_\"+x;\t\t\t\t\t\t\n\t\t\tnewdiv.onclick = function(e){\n\t\t\t\t\t\t\t\tvar str = this.id;\n\t\t\t\t\t\t\t\tvar index = str.lastIndexOf(\"_\");\n\t\t\t\t\t\t\t\tvar myid = str.substring(10,index);\n\t\t\t\t\t\t\t\tvar pos = str.substring(index+1);\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t//submitData('");
      out.print(request.getContextPath());
      out.write("/webpages/archivelogs.jsp',document.getElementById('Combo_itemsizelimit_'+pos).innerHTML,totalSize,curPos,criteria,tblname);\n\t\t\t\t\t\n\t\t\t\t\t\t\t\tsubmitData('");
      out.print(request.getContextPath());
      out.write("/webpages/archivelogs.jsp',document.getElementById('Combo_itemsizelimit_'+pos).innerHTML,totalSize,0,criteria,tblname);\n\t\t\t\t\t\n\t\t\t\t\t\t\t}\n\t\t\tnewdiv.innerHTML = arr[x];\n\t\t\tele.appendChild(newdiv);\n\t\t}\n\t\thighlightdiv(id);\n\t}\n\tfunction setSelectedText1(id,text){\n\t\tdocument.getElementById(\"Combo_select\"+id).innerHTML = text;\n\t}\n</script>\n<!-- script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script-->\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/SearchData.js\"></script>\n</head>\n<body>\n\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \n<div class=\"maincontent\" id=\"main_content\">\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp" + (("Date.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("device", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()), out, true);
      out.write('\n');

	String dataValue=null;
	int intLotSize=10;
	int intDisplayRowLog=0;
	long longTotalRecordCount=0;
	long longCurrentRecordPosition=0;
	String msg=request.getParameter("flag");
	String query = " where";
	String tblname="tblindex"+(new SimpleDateFormat("yyyyMMdd")).format(DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd hh:mm:ss"));
	if(tblname == null){
		tblname="";
	}
	
	String strLotSize= request.getParameter("lotSize");
	String strCurrentRecordPosition = request.getParameter("curPos");
	String strCriteria = request.getParameter("criteria");
	String indexCriteria = request.getParameter("indexCriteria");	
	
	String message = "";
	Date startDateDt = DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd hh:mm:ss");
	Date endDateDt = DateDifference.stringToDate((String)session.getAttribute("enddate"),"yyyy-MM-dd hh:mm:ss");
	
	HashMap<String,String> criteriaList = new HashMap<String,String>();
	
	if(PrepareQuery.calculateDifference(startDateDt,endDateDt) > 0){
		message = "Start Date and End Date are different. Logs for " + (new SimpleDateFormat("yyyy-MM-dd")).format(DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd"));
		message += " date are displayed.";		
		
		criteriaList.put("upload_datetimeStart",">=,"+(String)session.getAttribute("startdate")); 
		criteriaList.put("upload_datetimeEnd","<=,"+(new SimpleDateFormat("yyyy-MM-dd")).format(DateDifference.stringToDate((String)session.getAttribute("enddate"),"yyyy-MM-dd")) + " 23:59:59");
	} else {		
		criteriaList.put("upload_datetimeStart",">=,"+(String)session.getAttribute("startdate")); 
		criteriaList.put("upload_datetimeEnd","<=,"+(String)session.getAttribute("enddate"));
	}	
	
	criteriaList.put("device_name","=,"+(String)session.getAttribute("appliancelist"));
	criteriaList.put("indexCriteria",indexCriteria);	
	//longTotalRecordCount = SearchDataBean.getTotalRecordCount(tblname,query);
	if(longTotalRecordCount < 0){
		longTotalRecordCount = 0;
	}
	if(strLotSize != null){
		URLDecoder.decode(strLotSize);
		intLotSize = Integer.parseInt(strLotSize);
		if(intLotSize < 5){
			intLotSize=5;
		}
	}
	if(strCurrentRecordPosition != null){
		longCurrentRecordPosition = Long.parseLong(strCurrentRecordPosition);
		if(longCurrentRecordPosition < 0){
			longCurrentRecordPosition=0;
		}
	}
	long iTotalpage = (long)Math.ceil((double)longTotalRecordCount/(double)intLotSize);
	if(iTotalpage<=0){
		iTotalpage = 1;
	}

	if(request.getParameter("advSearch") != null && request.getParameter("advSearch").equals("true"))
		longCurrentRecordPosition = 0;
	criteriaList.put("limit","=,"+intLotSize);
	criteriaList.put("offset","=,"+longCurrentRecordPosition);
	criteriaList.put("categoryID","=,"+categoryID);
	
	String [] columnArray=null;
	boolean nextFlag = false;
	ArrayList recordArray = null;
	if(indexCriteria == null || indexCriteria.equals("null"))
		recordArray = SearchIndexBean.getDateRangeData(criteriaList);
	else
		recordArray = SearchIndexBean.getSearchData(criteriaList);

	
	if(recordArray.size() == intLotSize + 1)
	{
		nextFlag = true;
		recordArray.remove(recordArray.size() - 1);
	}
		

      out.write("\n\n<div style=\"float: left;width: 100%;margin-top: 5px;\">\n<form name=\"archivelogs\" action=\"");
      out.print(request.getContextPath());
      out.write("/webpages/archivelogs.jsp\" method=\"POST\">\n<input type=\"hidden\" name=\"curPos\" value=\"");
      out.print(longCurrentRecordPosition);
      out.write("\" />\n<input type=\"hidden\" name=\"lotSize\" value=\"");
      out.print(intLotSize);
      out.write("\" />\n<input type=\"hidden\" name=\"totalSize\" value=\"");
      out.print(longTotalRecordCount);
      out.write("\" />\n<input type=\"hidden\" name=\"lastpage\" value=\"");
      out.print(iTotalpage);
      out.write("\" />\n<input type=\"hidden\" name=\"tblname\" value=\"");
      out.print(tblname);
      out.write("\" />\n<input type=\"hidden\" name=\"advSearch\"/>\n<input type=\"hidden\" name=\"isSearch\" value=\"");
      out.print( request.getParameter("isSearch")!=null && "true".equalsIgnoreCase(request.getParameter("isSearch"))?"true":"false" );
      out.write("\" />\n<input type=\"hidden\" name=\"andorvalue\" value=\"");
      out.print((archiveSearchParameter==null || archiveSearchParameter.getAndOrValue()==null)?" AND ":archiveSearchParameter.getAndOrValue());
      out.write("\" />\n<input type=\"hidden\" name=\"criteria\" value=\"");
      out.print((archiveSearchParameter==null || archiveSearchParameter.getCriteria()==null)?"":archiveSearchParameter.getCriteria());
      out.write("\" />\n<input type=\"hidden\" name=\"indexCriteria\" value=\"");
      out.print(request.getParameter("indexCriteria"));
      out.write("\" />\n\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"padding-top: 0px\">\n<tr>\n\t<td align=\"left\">\n\n\t\t\t\t\n\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"margin: 3px 0 0 2px;\">\n\t\t\t\t<tr>\n\t\t\t\t\t<td>\n\t\t\t\t\t\t<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n\t\t\t\t\t\t<tr class=\"tabhead\">\n\t\t\t\t\t\t\t<div class=\"reporttitlebar\">\n\t\t\t\t\t\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t\t\t\t\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Raw Logs"));
      out.write("</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\n\t\t\t\t\t\t</table>\n\t\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t\t<tr>\n\t\t\t\t\t<td>\n\t\t\t\t\t\t<div class=\"content_head\">\n\t\t\t\t\t\t\t<table width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n\t\t\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t\t\t<td align=\"left\" class=\"navigationfont\" width=\"200px\"><span style=\"float:left;margin-top:1px;\">");
      out.print(TranslationHelper.getTranslatedMessge("Show"));
      out.write("&nbsp;\n\t\t\t\t\t\t\t\t\t\t</span><span style=\"float:left\"><div id=\"sizelimit\" class=\"Combo_container\" style=\"margin-bottom:3px;\"></div>\n\t\t\t\t\t\t\t\t\t\t</span><span style=\"float:left;margin-top:1px;\">&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("results per page"));
      out.write("</span>\n\t\t\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t\t\t<!--  <td><a id=\"xlsLinkForArchive\" href=\"\" onclick=\"getXLSFile(");
      out.print(intLotSize);
      out.write(',');
      out.print(longCurrentRecordPosition);
      out.write(',');
      out.write('\'');
      out.print(tblname);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(strCriteria);
      out.write("',URLEncode('");
      out.print(indexCriteria);
      out.write("'))\"> \n\t\t\t\t\t\t\t\t\t\t<img src=\"../images/csvIcon.jpg\" class=\"xlslink\"></img>\n\t\t\t\t\t\t\t\t\t\t</a>\n\t\t\t\t\t\t\t\t\t</td>-->\n\t\t\t\t\t\t\t\t\t<script language=\"javascript\">\n\t\t\t\t\t\t\t\t\t\tsetComboContainer1(\"sizelimit\",\"40px\",\"1\");\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\tinsertElements1(\"sizelimit\",[\"5\",\"10\",\"15\",\"20\",\"25\",\"50\",\"100\",\"500\",\"1000\"],\"");
      out.print(longTotalRecordCount);
      out.write('"');
      out.write(',');
      out.write('"');
      out.print(longCurrentRecordPosition);
      out.write('"');
      out.write(',');
      out.write('"');
      out.print((archiveSearchParameter==null || archiveSearchParameter.getCriteria()==null)?"":archiveSearchParameter.getCriteria());
      out.write('"');
      out.write(',');
      out.write('"');
      out.print(tblname);
      out.write("\");\n\t\t\t\t\t\t\t\t\t\tsetSelectedText1(\"sizelimit\",\"");
      out.print(intLotSize);
      out.write("\");\n\t\t\t\t\t\t\t\t\t</script>\n\t\t\t\t\t\t\t\t\t<td class=\"navigationfont\" align=\"right\">\n\t\t\t\t\t\t\t\t\t<span style=\"float:right;margin-right:10px;\"><input type='button' class='navibutton' value='Go' onClick=\"jumptopage(");
      out.print((longCurrentRecordPosition/intLotSize)+1);
      out.write(");\"\" ></span>\n\t\t\t\t\t\t\t\t\t<span style=\"float:right\"><input class=\"navitext\" id=\"gotopage\" size=\"5\" type=\"text\" style=\"width:35px;margin-left:5px;margin-right:5px;\"></span>\n\t\t\t\t\t\t\t\t\t<span style=\"float:right;margin-top:2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("Go to page :"));
      out.write("</span>\n\t\t\t\t\t\t\t\t\t<!-- dont remove below line, this is to display total no. of recored and its replacement is next to it-->\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t<!--span style=\"float:right;margin-top:2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("Page"));
      out.write("&nbsp;");
      out.print((longCurrentRecordPosition/intLotSize)+1);
      out.write("&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("of"));
      out.write("&nbsp;");
      out.print(iTotalpage);
      out.write("</span-->\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t<span style=\"float:right;margin-top:2px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("Page"));
      out.write("&nbsp;");
      out.print((longCurrentRecordPosition/intLotSize)+1);
      out.write("</span>\n\t\t\t\t\t\t\t\t\t<span style=\"float:right\">\n\t\t\t\t\t\t\t\t\t\t<!-- dont remove below line, it is to move to first records  -->\n\t\t\t\t\t\t\t\t\t\t<!--img src=\"../images/first.bmp\" style=\"cursor: pointer;\" onClick=\"submitData('");
      out.print(request.getContextPath());
      out.write("/webpages/archivelogs.jsp','");
      out.print(intLotSize);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(longTotalRecordCount);
      out.write("','0','");
      out.print("");
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(tblname);
      out.write("');\" -->\n\t\t\t\t\t\t\t\t\t\t");

											if((longCurrentRecordPosition-intLotSize) >= 0){
										
      out.write("\n\t\t\t\t\t\t\t\t\t\t<img src=\"../images/prev.bmp\" style=\"cursor: pointer;\" onClick=\"submitData('");
      out.print(request.getContextPath());
      out.write("/webpages/archivelogs.jsp','");
      out.print(intLotSize);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(longTotalRecordCount);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(longCurrentRecordPosition-intLotSize);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print("");
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(tblname);
      out.write("');\" >\n\t\t\t\t\t\t\t\t\t\t");

											} else {
										
      out.write("\n\t\t\t\t\t\t\t\t\t\t<img src=\"../images/prev.bmp\" style=\"cursor: pointer;\" onClick=\"\" >\n\t\t\t\t\t\t\t\t\t\t");

											}
										
      out.write("\n\t\t\t\t\t\t\t\t\t\t");

											if(nextFlag/*(longTotalRecordCount-longCurrentRecordPosition) > intLotSize*/){
										
      out.write("\n\t\t\t\t\t\t\t\t\t\t<img src=\"../images/next.bmp\" style=\"cursor: pointer;\" onClick=\"submitData('");
      out.print(request.getContextPath());
      out.write("/webpages/archivelogs.jsp','");
      out.print(intLotSize);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(longTotalRecordCount);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(longCurrentRecordPosition+intLotSize);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print("");
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(tblname);
      out.write("');\" >\n\t\t\t\t\t\t\t\t\t\t");

											} else {
										
      out.write("\n\t\t\t\t\t\t\t\t\t\t<img src=\"../images/next.bmp\" style=\"cursor: pointer;\" onClick=\"\" >\n\t\t\t\t\t\t\t\t\t\t");

											}
										
      out.write("\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t<!-- dont remove below line, it is to move to last records  -->\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t</span>\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t\t</tr>\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t</table>\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t<div id=\"content1\" class=\"content_act\" style=\"width:100%\">\n\t\t\t\t\t\t\t<table class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n");
 
	if(recordArray != null){
	boolean oddLine = true;
	if(recordArray.size() == 0){		
		String errMessage = "No data found";
		if(SearchIndexBean.getMessage().equals("Java heap space")){
			SearchIndexBean.setMessage("");
			errMessage = "search limit exceed, please reduce search results.";
		}

      out.write("\t\t\n\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\"' onMouseOut='this.className=\"trlight\"' height=\"20px\">\n\t\t<td class=\"tddata\" align=\"center\" colspan=\"");
      out.print(indexFileList.size()-2);
      out.write('"');
      out.write('>');
      out.print(errMessage);
      out.write("</td>\t\t\n\t</tr>\n");
 	}
	for(int recordcount=0;recordcount<recordArray.size();recordcount++){
		if(oddLine){

      out.write("\n\n\t\t\t\t\t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\"' onMouseOut='this.className=\"trlight\"' height=\"20px\">\n");

	} else {

      out.write("\t\t\n\t\t\t\t\t\t\t\t<tr class=\"trdark\" onMouseOver='this.className=\"trdark1\"' onMouseOut='this.className=\"trdark\"' height=\"20px\">\n");

	}	
		oddLine = !(oddLine);
		dataValue=(String)recordArray.get(recordcount);
		
		columnArray=dataValue.split(" ");
		
		for(int columncount=0;columncount<columnArray.length-1;columncount++){
			
			if(columnArray != null ){
					
				String str=columnArray[columncount];

      out.write("\n\t\t\n\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">\n\t\t\t\t\t\t\t\t\t\t");
      out.print(str.length() > 50 ? str.subSequence(0,50)+"...":str);
      out.write("\n\t\t\t\t\t\t\t\t\t\t");
      out.print((columncount==0)?"</nobr>":"");
      out.write("\n\t\t\t\t\t\t\t\t\t</td>\n");

			} else {

      out.write("\n\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"center\">-</td>\n");

	}
		}

      out.write("\n\t\t\t\t\t\t\t\t</tr>\n");

	}
}else{

      out.write("\n\t\t\t\t\t\t\t\t<tr class=\"trdark\"><td class=\"tddata\" colspan=\"10\" align=\"center\">");
      out.print(TranslationHelper.getTranslatedMessge("No Logs Avaiable"));
      out.write("</td></tr>\n");

	}

      out.write("\n\t\t\t\t\t\t\t</table>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\n\t\n\t\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</td>\n\t\t</tr>\n\t\t</table>\n\t\n\n</div>\n</form>\n</div>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n\n</body>\n");

	} catch(Exception e) {
		CyberoamLogger.appLog.debug("Archiveogs=>"+e,e);
		out.println("Error : "+e);
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
