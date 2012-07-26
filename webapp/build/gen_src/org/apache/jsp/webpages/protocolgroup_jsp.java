package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.utility.CheckSession;
import java.text.MessageFormat;
import java.util.*;
import org.cyberoam.iview.beans.ProtocolGroupBean;
import org.cyberoam.iview.beans.ApplicationNameBean;
import org.cyberoam.iview.beans.ProtocolIdentifierBean;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.mlm.TranslationHelper;

public final class protocolgroup_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

	try{
	if(CheckSession.checkSession(request,response)<0)
		return;
	String pmessage="";
	String nmessage="";
	String fontClass="";
	String strMode=request.getParameter("appmode");
	String strStatus = request.getParameter("status");
	int iMode = -1,iStatus = 0;
	if(strMode !=null && !"null".equalsIgnoreCase(strMode)){
		iMode = new Integer(strMode).intValue();
	}
	if(strStatus !=null && !"null".equalsIgnoreCase(strStatus)){
		iStatus = new Integer(strStatus).intValue();
	}
	if(iMode == ApplicationModes.ADD_PROTOCOL_GROUP && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application Group added successfully.");
	}else if(iMode == ApplicationModes.ADD_PROTOCOL_GROUP && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Application Group already exists.");
	}else if(iMode == ApplicationModes.ADD_PROTOCOL_GROUP && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Group Creation.");
	}else if(iMode == ApplicationModes.UPDATE_PROTOCOL_GROUP && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application Group updated successfully.");
	}else if(iMode == ApplicationModes.UPDATE_PROTOCOL_GROUP && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Group Updation.");
	}else if(iMode == ApplicationModes.DELETE_PROTOCOL_GROUP && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application Group deleted successfully.");
	}else if(iMode == ApplicationModes.DELETE_PROTOCOL_GROUP && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Group Deletion.");
	}else if(iMode == ApplicationModes.ADD_APPLICATION && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application added successfully.");
	}else if(iMode == ApplicationModes.ADD_APPLICATION && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Application already exists.");
	}else if(iMode == ApplicationModes.ADD_APPLICATION && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Creation.");
	}else if(iMode == ApplicationModes.UPDATE_APPLICATION && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application updated successfully.");
	}else if(iMode == ApplicationModes.UPDATE_APPLICATION && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Updation.");
	}else if(iMode == ApplicationModes.DELETE_APPLICATION && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Application deleted successfully.");
	}else if(iMode == ApplicationModes.DELETE_APPLICATION && iStatus < 0){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Application Deletion.");
	}

      out.write("\n<HTML>\n<HEAD>\n\t<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n\t<META http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n\t<LINK rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\" />\n\t<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n\t<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/protocolgroup.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ipvalidation.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\">\n\t\twindow.onload = function (evt) {\n\t\t\tsetWidth();\n\t\t\t//getWinSize();\n\t\t\tsetAppWin();\t\t\t\t\n\t\t}\t\t\n\t\tfunction setWidth(){\n\t\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t\t}\n\tfunction deleteProtocolGroup(id,protocolgroup){\n\t\tvar answer \n\t    \tanswer=confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure to delete"));
      out.write(" \" + protocolgroup + \" ");
      out.print(TranslationHelper.getTranslatedMessge("Application group?"));
      out.write("\");\n\t    if(answer){\n\t    \tdocument.frmProtocolGroup.id.value=id;\n\t    \tdocument.frmProtocolGroup.appmode.value=");
      out.print(ApplicationModes.DELETE_PROTOCOL_GROUP);
      out.write(";\t\n\t\t\tdocument.frmProtocolGroup.submit();\n\t\t}\n\t}\n\tfunction deleteApplicationName(id,applicationname){\n\t\tvar answer \n\t    \tanswer=confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure to delete"));
      out.write(" \" + applicationname + \" ");
      out.print(TranslationHelper.getTranslatedMessge("Application?"));
      out.write(" \");\n\t    if(answer){\n\t    \tdocument.frmProtocolGroup.id.value=id;\n\t    \tdocument.frmProtocolGroup.appmode.value=");
      out.print(ApplicationModes.DELETE_APPLICATION);
      out.write(";\t\n\t\t\tdocument.frmProtocolGroup.submit();\n\t\t}\n\t}\n\tfunction openAddProtocolGroup(id){\n\t\toldURL = URL;\n\t\tif(id == ''){\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addprotocolgroup.jsp';\n\t\t} else {\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addprotocolgroup.jsp?protocolgroupid='+id;\n\t\t}\n\t\thandleThickBox('1','protocolgrp','500');\n\t\t//top.sourceWindow=window.open(reqloc,'_person','width=570,height=480,titlebar=no,scrollbars=yes');\n\t}\n\tfunction openAddApplicationName(id){\n\t\toldURL = URL;\n\t\tif(id == '') {\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addapplicationname.jsp';\n\t\t} else {\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addapplicationname.jsp?applicationnameid='+id;\n\t\t}\n\t\thandleThickBox('1','application','450');\t\n\t\t//top.sourceWindow=window.open(reqloc,'_person','width=570,height=480,titlebar=no,scrollbars=yes');\n\t}\n\tfunction deleteProtocolIdentifier(id,identifier){\n\t\tvar answer \n\t    \tanswer=confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure to delete"));
      out.write(" \" + identifier + \"?\");\n\t    if(answer){\n\t    \tdocument.frmAddProtocol.protocolidentifierid.value=id;\n\t    \tdocument.frmAddProtocol.appmode.value=");
      out.print(ApplicationModes.DELETE_PROTOCOL_IDENTIFIER);
      out.write(";\t\n\t\t\tdocument.frmAddProtocol.submit();\n\t\t}\n\t}\n\tfunction openAddProtocolIdentifier(appid){\n\t\toldURL = URL;\n\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addprotocolidentifier.jsp?applicationnameid='+appid;\n\t\thandleThickBox('2','application');\n\t\thandleThickBox('1','applicationIdentifier','400');\n\t\t// top.sourceWindow=window.open(reqloc,'_person1','width=300,height=300,titlebar=no,scrollbars=yes');\n\t}\n\tfunction setAppWin(){\n\t");
boolean isManageApp = false;
		if(iMode == ApplicationModes.DELETE_PROTOCOL_IDENTIFIER && iStatus > 0){
			isManageApp = true;
		}else if(iMode == ApplicationModes.DELETE_PROTOCOL_IDENTIFIER && iStatus < 0){
			isManageApp = true;
		}else if(iMode == ApplicationModes.ADD_PROTOCOL_IDENTIFIER && iStatus > 0){
			isManageApp = true;
		}else if(iMode == ApplicationModes.ADD_PROTOCOL_IDENTIFIER && iStatus < 0){
			isManageApp = true;
		}else if(request.getParameter("applicationname") != null && !"null".equalsIgnoreCase(request.getParameter("applicationname"))){
			isManageApp = true;
		}
		if(isManageApp){
      out.write("\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addapplicationname.jsp?' + '");
      out.print(request.getQueryString());
      out.write("';\n\t\t\thandleThickBox('1','application');\n\t");
}
      out.write("\n\t}\n\tfunction resetToDefault(){\n\t\tvar con=confirm('Are you sure you want to reset all Application Group-Application-Identifier to default ?');\n\t\tif(con){\n\t\t\tdocument.frmProtocolGroup.appmode.value=");
      out.print(ApplicationModes.RESET_PROTOCOL);
      out.write(";\t\n\t\t\tdocument.frmProtocolGroup.submit();\n\t\t}\t\n\t}\n\tfunction handleIdentifier(){\n\t\thandleThickBox('2','applicationIdentifier');\n\t\tURL = oldURL;\n\t\tsubmitForm('application');\n\t\tdocument.getElementById('applicationIdentifier').style.display = 'none';\n\t\thandleThickBox('1','application');\n\t}\n\t</SCRIPT>\n</HEAD>\n<BODY>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("\n<div class = \"maincontent\" id=\"main_content\">\n\t<div class=\"reporttitlebar\">\n\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Application Groups"));
      out.write("</div>\n\t</div>\n\t<br /><br />\n");

	ProtocolGroupBean protocolGroupBean = null;
	ApplicationNameBean applicationNameBean = null;
	ProtocolIdentifierBean protocolIdentifierBean = null;
	LinkedHashMap protocolGroupMap=null,applicationNameMap=null,protocolIdentifierBeanMap=null;
	Iterator protocolGroupIterator=null,applicationNameIterator=null,protocolIdentifierBeanIterator=null;
	protocolGroupMap = ProtocolGroupBean.getProtocolGroupMap();

      out.write("\t\n<FORM method=\"POST\" name=\"frmProtocolGroup\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\">\n<input type=\"hidden\" name=\"id\" value =\"-1\">\n<input type=\"hidden\" name=\"appmode\" value =\"-1\">\n<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"margin-bottom: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td align=\"left\" class=\"ButtonBack\">\n\t\t\t<input class=\"criButton\" type=\"button\" onClick=\"openAddApplicationName('');\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Add Application"));
      out.write("\">\n\t\t\t<input class=\"criButton\" type=\"button\" onClick=\"openAddProtocolGroup('');\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Add Application Group"));
      out.write("\">\n\t\t\t<input class=\"criButton\" type=\"button\" onClick=\"resetToDefault('');\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Reset to Default"));
      out.write("\">\n\t\t</td>\n\t</tr>\n\t</table>\n<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 2px;margin-left:2px;\">\n ");

	if(!"".equals(pmessage)){

      out.write("\n\t<tr>\n\t\t<td class=\"posimessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(pmessage);
      out.write("</td>\n\t</tr>\n");

	}

      out.write('\n');

	if(!"".equals(nmessage)){

      out.write("\n\t<tr>\n\t\t<td class=\"nagimessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(nmessage);
      out.write("</td>\n\t</tr>\n");

	}

      out.write("\n\t<tr>\n\t\t<td>\n\t\t\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"TableData\">\n\t\t\t<tr>\n\t\t\t\t<td class=\"tdhead\">&nbsp;</td>\n\t\t\t\t<td class=\"tdhead\" width=\"20%\">");
      out.print(TranslationHelper.getTranslatedMessge("Application Groups"));
      out.write("</td>\n\t\t\t\t<td class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Description"));
      out.write("</td>\n\t\t\t\t<td class=\"tdhead\" width=\"8%\" align=\"center\">");
      out.print(TranslationHelper.getTranslatedMessge("Delete"));
      out.write("</td>\n\t\t\t</tr>\n\t\t\t");

				if(protocolGroupMap != null && protocolGroupMap.size() > 0){
						protocolGroupIterator = protocolGroupMap.values().iterator();
						int grpCounter = 0;
						String rowStyle = "";
						String tdStyle="";
						String astyle="";
						while(protocolGroupIterator.hasNext()){
							grpCounter++;							
							if(grpCounter%2 == 0)
									rowStyle = "trdark";
								else
									rowStyle = "trlight";
							protocolGroupBean=(ProtocolGroupBean)protocolGroupIterator.next();
							if(protocolGroupBean.getIsDefault()==ProtocolGroupBean.ISDEFAULT){
								tdStyle="tddata";
								astyle="";
							}else{
								tdStyle="tddatablue";
								astyle="style=color:#2388C7;";
							}
			
      out.write("\n\t\t\t\t\t\t<tr class=\"");
      out.print(rowStyle);
      out.write("\">\n\t\t\t\t\t\t\t<td class=\"tddata\" align=\"center\" width=\"5%\">\n\t\t\t\t\t\t\t\t<input type=\"hidden\" id=\"");
      out.print("0_1_"+ grpCounter);
      out.write("\" value=\"");
      out.print(request.getContextPath());
      out.write("/images/collapse.gif\" />\n\t\t\t\t\t\t\t\t<img id=\"");
      out.print("1_1_"+ grpCounter);
      out.write("\" src=\"");
      out.print(request.getContextPath());
      out.write("/images/inactiveexpand.gif\" onClick=\"changeImg(this.id);\" style=\"cursor: pointer;\" />\n\t\t\t\t\t\t\t</td>\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t<td class=\"");
      out.print(tdStyle);
      out.write("\">\n\t\t\t\t\t\t\t\t<a  ");
      out.print(astyle);
      out.write(" href=\"#\" ");
      out.print(astyle);
      out.write(" title=\"");
      out.print(protocolGroupBean.getDescription());
      out.write("\" onClick=\"openAddProtocolGroup('");
      out.print(protocolGroupBean.getProtocolgroupId());
      out.write("');\" > ");
      out.print(protocolGroupBean.getProtocolGroup());
      out.write(" </A>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class=\"");
      out.print(tdStyle);
      out.write('"');
      out.write('>');
      out.print(protocolGroupBean.getDescription()==null?" ":protocolGroupBean.getDescription());
      out.write("</td>\n\t\t\t\t\t\t\t");

								if(protocolGroupBean.getProtocolgroupId() == ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP){
							
      out.write("\n\t\t\t\t\t\t\t\t<td class=\"");
      out.print(tdStyle);
      out.write("\" align=\"center\">&nbsp;</td>\n\t\t\t\t\t\t\t");

								} else {
							
      out.write("\n\t\t\t\t\t\t\t\t<td class=\"");
      out.print(tdStyle);
      out.write("\" align=\"center\"><img src=\"");
      out.print(request.getContextPath());
      out.write("/images/false.gif\" title=\"Disable\" onClick=\"deleteProtocolGroup(");
      out.print(protocolGroupBean.getProtocolgroupId());
      out.write(' ');
      out.write(',');
      out.write('\'');
      out.print(protocolGroupBean.getProtocolGroup());
      out.write("')\" ></td>\n\t\t\t\t\t\t\t");

								}
							
      out.write("\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t<tr class=\"trlight\" id=\"1_");
      out.print(grpCounter);
      out.write("_0\" style=\"display: none;\">\n\t\t\t\t\t\t\t<td class=\"tddata\">&nbsp;</td>\n\t\t\t\t\t\t\t<td colspan=\"2\" class=\"tddata\">\n\t\t\t\t\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n\t\t\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t\t\t<td class=\"tdhead\">&nbsp;</td>\n\t\t\t\t\t\t\t\t\t<td class=\"tdhead\" colspan=\"2\">");
      out.print(TranslationHelper.getTranslatedMessge("Application"));
      out.write("</td>\n\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t");

							applicationNameMap=ApplicationNameBean.getApplicationNameBeanMap(protocolGroupBean.getProtocolgroupId());
										if(applicationNameMap !=null && applicationNameMap.size() > 0){
											applicationNameIterator=applicationNameMap.values().iterator();
											int protoCounter = 0;
											String protoRowStyle = "";
											String ptdStyle="";
											String pastyle="";
											while(applicationNameIterator.hasNext()){
												protoCounter++;
												if(protoCounter%2 == 0)
													protoRowStyle = "trdark";
												else
													protoRowStyle = "trlight";
												applicationNameBean=(ApplicationNameBean)applicationNameIterator.next();
												if(applicationNameBean.getIsDefault()==ApplicationNameBean.ISDEFAULT){
													ptdStyle="tddata";
													pastyle="";
												}else{
													ptdStyle="tddatablue";
													pastyle="style=color:#2388C7;";
												}
												
						
      out.write("\n\t\t\t\t\t\t\t\t<tr class=\"");
      out.print(protoRowStyle);
      out.write("\">\n\t\t\t\t\t\t\t\t\t<td class=\"");
      out.print(ptdStyle);
      out.write("\" align=\"center\" width=\"5%\">\n\t\t\t\t\t\t\t\t\t\t<input type=\"hidden\" id=\"0_2_");
      out.print(grpCounter + "_" + protoCounter);
      out.write("\" value=\"");
      out.print(request.getContextPath());
      out.write("/images/collapse.gif\" />\n\t\t\t\t\t\t\t\t\t\t<img id=\"1_2_");
      out.print(grpCounter + "_" + protoCounter);
      out.write("\" src=\"");
      out.print(request.getContextPath());
      out.write("/images/inactiveexpand.gif\" onClick=\"changeImg(this.id);\" style=\"cursor: pointer;\" />\n\t\t\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t\t\t<td class=\"");
      out.print(ptdStyle);
      out.write("\"><A ");
      out.print(pastyle);
      out.write(" href=\"#\" onClick=\"openAddApplicationName('");
      out.print(applicationNameBean.getApplicationNameId());
      out.write("')\" >");
      out.print(applicationNameBean.getApplicationName());
      out.write(" </A></td>\n\t\t\t\t\t\t\t\t\t<td class=\"");
      out.print(ptdStyle);
      out.write("\" width=\"8%\" align=\"center\"><img src=\"");
      out.print(request.getContextPath());
      out.write("/images/false.gif\" title=\"Disable\" onClick=\"deleteApplicationName( ");
      out.print(applicationNameBean.getApplicationNameId());
      out.write(' ');
      out.write(',');
      out.write('\'');
      out.print(applicationNameBean.getApplicationName());
      out.write(" ')\"></td>\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\t\t<tr class=\"trdark\" id=\"2_");
      out.print(grpCounter + "_" + protoCounter);
      out.write("_0\" style=\"display: none;\">\n\t\t\t\t\t\t\t\t\t<td class=\"tddata\" colspan=\"3\">\n\t\t\t\t\t\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"TableData\">\n\t\t\t\t\t\t");

							protocolIdentifierBeanMap = ProtocolIdentifierBean.getProtocolIdentifierBeanMap(applicationNameBean.getApplicationNameId());
												if(protocolIdentifierBeanMap !=null && protocolIdentifierBeanMap.size() > 0){
													protocolIdentifierBeanIterator=protocolIdentifierBeanMap.values().iterator();
													String protocolIdentifierTdStyle="";
													while(protocolIdentifierBeanIterator.hasNext()){
														protocolIdentifierBean=(ProtocolIdentifierBean)protocolIdentifierBeanIterator.next();
														if(protocolIdentifierBean.getIsDefault()!=ProtocolIdentifierBean.ISDEFAULT) {
															protocolIdentifierTdStyle="tddatablue";
														}else{
															protocolIdentifierTdStyle="tddata";
														}
														String identifier="";
														if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.ICMP)
															identifier="icmp/"+protocolIdentifierBean.getPort();
														else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.TCP)
															identifier="tcp/"+protocolIdentifierBean.getPort();
														else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.UDP)
															identifier="udp/"+protocolIdentifierBean.getPort();
						
      out.write("\n\t\t\t\t\t\t\t\t\t<tr class=\"trlight\">\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" width=\"5%\">&nbsp;</td>\n\t\t\t\t\t\t\t\t\t\t<td class=\"");
      out.print(protocolIdentifierTdStyle);
      out.write('"');
      out.write('>');
      out.print(identifier);
      out.write("</td>\n\t\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t");

							}
												} else {
						
      out.write("\n\t\t\t\t\t\t\t\t\t<tr class=\"trlight\">\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" width=\"5%\">&nbsp;</td>\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\">");
      out.print(TranslationHelper.getTranslatedMessge("No Identifiers"));
      out.write("</td>\n\t\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t");

							}
						
      out.write("\n\t\t\t\t\t\t\t\t\t</table>\n\t\t\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t");

							}
										}
						
      out.write("\n\t\t\t\t\t\t\t</table>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td>&nbsp;</td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\n\t\t\t\t");

											}
												}else{
										
      out.write("\n\t\t\t\t\t<td colspan=\"2\">");
      out.print(TranslationHelper.getTranslatedMessge("No Application Group exists."));
      out.write("</td></tr>\n\t\t\t\t");

				}
				
      out.write("\n\t\t\t</table>\n\t\t</td>\n\t</tr>\n</table>\n</FORM>\n</div>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n<div id=\"protogrp2\" class=\"protoGrp\" style=\"display: none;\" ></div>\n<div class=\"TB_window\" id=\"protocolgrp\"></div>\n<div class=\"TB_window\" id=\"application\"></div>\n<div class=\"TB_window\" id=\"applicationIdentifier\"></div>\n</BODY> \n</HTML>\n");

	} catch(Exception e){
		CyberoamLogger.appLog.info("Exception in protocolgroup.jsp");
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
