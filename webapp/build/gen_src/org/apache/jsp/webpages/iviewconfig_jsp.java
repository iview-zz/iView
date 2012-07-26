package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.beans.*;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.audit.CyberoamLogger;

public final class iviewconfig_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n");

	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		//int curLanguageId = Integer.parseInt(iViewConfigBean.getValueByKey(iViewConfigBean.LANGUAGE));
		String serverHost = "";
		String serverPort = "";
		String fromEmail = "";
		int curSMTPAuthID = 0;
		String dispName = "";
		String username = "";
		
		String testConfig = (String)session.getAttribute("testConfig");
		if(testConfig==null || "".equalsIgnoreCase(testConfig) || "null".equalsIgnoreCase(testConfig)){
	serverHost = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERHOST);
	serverPort = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERPORT);
	fromEmail = iViewConfigBean.getValueByKey(iViewConfigBean.MAIL_ADMIN_ID);
	curSMTPAuthID = Integer.parseInt(iViewConfigBean.getValueByKey(iViewConfigBean.AUTHENTICATIONFLAG));
	dispName = iViewConfigBean.getValueByKey(iViewConfigBean.MAIL_ADMIN_NAME);
	username = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERUSERNAME);
		} else {
	String[] testConfigData = testConfig.split(",");
	serverHost = testConfigData[0];
	serverPort = testConfigData[1];
	fromEmail = testConfigData[2];
	curSMTPAuthID = Integer.parseInt(testConfigData[3]);
	dispName = testConfigData[4];
	if(curSMTPAuthID == 1)
		username = testConfigData[5];
	session.removeAttribute("testConfig");
		}
		if(dispName == null || "".equalsIgnoreCase(dispName) || "null".equalsIgnoreCase(dispName)){
	dispName = "";
		}
		if(username == null || "".equalsIgnoreCase(username) || "null".equalsIgnoreCase(username)){
	username = "";
		}
		String appmode = request.getParameter("appmode");
		int iMode = -1;
		if(appmode != null && !"null".equalsIgnoreCase(appmode)){
	iMode = Integer.parseInt(appmode);
		}
		String strStatus = request.getParameter("status");
		int iStatus = -1;
		if(strStatus != null && !"null".equalsIgnoreCase(strStatus)){
	iStatus = Integer.parseInt(strStatus);
		}
		String pmessage = "";
		String nmessage = "";
		if(iMode == ApplicationModes.UPDATE_CONFIGURATION && iStatus > 0){
	pmessage = TranslationHelper.getTranslatedMessge("Configuration updated successfully.");
		} else if(iMode == ApplicationModes.UPDATE_CONFIGURATION && iStatus <= 0){
	nmessage = TranslationHelper.getTranslatedMessge("Error in Configuration updation.");
		} else if(iMode == ApplicationModes.SEND_TEST_MAIL && iStatus >= 0){
	pmessage = TranslationHelper.getTranslatedMessge("Test mail sent successfully.");
		} else if(iMode == ApplicationModes.SEND_TEST_MAIL && iStatus < 0){
	nmessage = TranslationHelper.getTranslatedMessge("Error sending test mail.");
		}

      out.write("\n\n\n<html>\n<head>\n<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ipvalidation.js\"></script>\n<script type=\"text/javascript\">\n\twindow.onload = function (evt) {\n\t\tsetWidth();\n\t\tsetAuth(document.manageconfig.smtpAuth);\n\t\tsetWinSize('testip');\n\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\n\t}\n\tfunction setAuth(smtpAuth){\n\t\tif(smtpAuth.checked){\n\t\t\tdocument.manageconfig.username.disabled = '';\n\t\t\tdocument.manageconfig.password.disabled = '';\n\t\t} else {\n\t\t\tdocument.manageconfig.username.disabled = 'disabled';\n\t\t\tdocument.manageconfig.password.disabled = 'disabled';\n\t\t}\n\t}\n\tfunction submitForm(isTestMail){\n\t\tre = /\\w{1,}/;\n\t\tvar reExp = /^[a-zA-Z0-9][a-zA-Z0-9_.@]*$/;\n\t\temailExp = /^\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)*@\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)+$/ ;\n\t\tform = document.manageconfig;\n\t\tform.appmode.value = '");
      out.print(ApplicationModes.UPDATE_CONFIGURATION);
      out.write("';\n\t\tif(!isValidIP(form.serverip.value)){\n\t\t\tif(isTestMail)\n\t\t\t\thandleThickBox('2','testip');\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("Please Enter valid IP Address."));
      out.write("');\n\t\t\treturn false;\n\t\t}\n\t\tif(!isValidPort(form.serverport.value)){\n\t\t\tif(isTestMail)\n\t\t\t\thandleThickBox('2','testip');\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("Please Enter valid Server Port."));
      out.write("');\n\t\t\treturn false;\n\t\t}\n\t\tif(form.fromemail.value == ''){\n\t\t\tif(isTestMail)\n\t\t\t\thandleThickBox('2','testip');\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter email address"));
      out.write("');\n\t\t\tform.fromemail.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(!(emailExp.test(form.fromemail.value))){\n\t\t\tif(isTestMail)\n\t\t\t\thandleThickBox('2','testip');\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("Invalid Email Address"));
      out.write("');\n\t\t\tform.fromemail.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(form.smtpAuth.checked){\n\t\t\tif (!(re.test(form.username.value))){\n\t\t\t\tif(isTestMail)\n\t\t\t\t\thandleThickBox('2','testip');\n\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Username"));
      out.write("');\n\t\t\t\tform.username.focus();\n\t\t\t\treturn false;\n\t\t\t}else if (!(reExp.test(form.username.value))){\n\t\t\t\tif(isTestMail)\n\t\t\t\t\thandleThickBox('2','testip');\n\t\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@' and '.' allowed in username"));
      out.write("\");\n\t\t\t\tform.username.focus();\n\t\t\t\treturn false;\n\t\t\t}\n\t\t\tif (form.password.value == ''){\n\t\t\t\tif(isTestMail)\n\t\t\t\t\thandleThickBox('2','testip');\n\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Password"));
      out.write("');\n\t\t\t\tform.password.focus();\n\t\t\t\treturn false;\n\t\t\t}\n\t\t}\n\t\tif(isTestMail){\n\t\t\treturn true;\n\t\t} else {\n\t\t\tvar con = confirm('");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to update configuration?"));
      out.write("');\n\t\t\treturn con;\n\t\t}\n\t}\n\tfunction sendTestMail(){\n\t\tif(form.testEmail.value == ''){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter email address for test"));
      out.write("');\n\t\t\tform.testEmail.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(!(emailExp.test(form.testEmail.value))){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("Invalid Email Address for test"));
      out.write("');\n\t\t\tform.testEmail.focus();\n\t\t\treturn false;\n\t\t}\n\t\tdocument.manageconfig.appmode.value = '");
      out.print(ApplicationModes.SEND_TEST_MAIL);
      out.write("';\n\t\tdocument.manageconfig.submit();\n\t}\n\tfunction handleThickBox(op,container){\n\t\tvar thickBox = document.getElementById('TB_overlay');\n\t\tvar containerBox = document.getElementById(container);\n\t\tif(op == 1 && submitForm(true)){\n\t\t\tthickBox.style.display = '';\n\t\t\tcontainerBox.style.display = 'block';\n\t\t}else{\n\t\t\tthickBox.style.display = 'none';\n\t\t\tcontainerBox.style.display = 'none';\n\t\t}\n\t}\n\tfunction setWinSize(container){\n\t\tif( typeof( window.innerWidth ) == 'number' ) {\t\t//Non-IE\n\t\t   \twinWidth = window.innerWidth;\n\t\t   \twinHeight = window.innerHeight;\n\t\t} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {\n\t\t   \twinWidth = document.documentElement.clientWidth;\n\t\t   \twinHeight = document.documentElement.clientHeight;\n\t\t} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {\n\t\t   \t//IE 4 compatible\n\t\t   \twinWidth = document.body.clientWidth;\n\t\t   \twinHeight = document.body.clientHeight;\n\t\t}\n\t\tdocument.getElementById(container).style.left = (winWidth - 450)/2;\n");
      out.write("  \t\tdocument.getElementById(container).style.top = '50px';\n  \t}\n</script>\n</head>\n<body>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\n\n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("\n\n    <div class=\"maincontent\" id=\"main_content\">\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Mail server configuration"));
      out.write("</div>\n\t\t</div>\n\t\t<br><br>\n\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"manageconfig\" onsubmit=\"return submitForm(false)\">  \n\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.UPDATE_CONFIGURATION);
      out.write("\" >\n\t<table border=\"0\" width=\"100%\" cellpadding=\"2\" cellspacing=\"2\">\n");

	if(!"".equals(pmessage)){

      out.write("\n\t<tr>\n\t\t<td class=\"posimessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(pmessage);
      out.write("</td>\n\t</tr>\n");

	}

      out.write('\n');

	if(!"".equals(nmessage)){

      out.write("\n\t<tr>\n\t\t<td class=\"nagemessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(nmessage);
      out.write("</td>\n\t</tr>\n");

	}

      out.write("\n\t<td >\n\t\t\t<table border=\"0\" cellpadding=\"2\" cellspacing=\"2\">\n\t\t\t<tr >\n\t\t\t\t<td class=\"textlabels\" >&nbsp;\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Mail Server IP"));
      out.write("&nbsp;-&nbsp;");
      out.print(TranslationHelper.getTranslatedMessge("Port"));
      out.write("<font class=\"compfield\">*</font>\n\t\t\t\t</td>\n\t\t\t\t<td >\n\t\t\t\t\t<input type=\"text\" class=\"datafield\" name=\"serverip\" value=\"");
      out.print(serverHost);
      out.write("\" style=\"width:180px\"/>&nbsp;-&nbsp;<input type=\"text\" class=\"datafield\" size=\"5\" name=\"serverport\" value=\"");
      out.print(serverPort);
      out.write("\" />\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td class=\"textlabels\" width=\"50%\">&nbsp;\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Display Name"));
      out.write("\n\t\t\t\t</td>\n\t\t\t\t<td ><input type=\"text\" class=\"datafield\" name=\"dispname\" value=\"");
      out.print(dispName);
      out.write("\" style=\"width:180px\" /></td>\n\t\t\t</tr>\n\t\t\t<tr >\n\t\t\t\t<td class=\"textlabels\" width=\"50%\">&nbsp;\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("From Email Address"));
      out.write("<font class=\"compfield\">*</font>\n\t\t\t\t</td>\n\t\t\t\t<td><input type=\"text\" class=\"datafield\" name=\"fromemail\" value=\"");
      out.print(fromEmail);
      out.write("\" style=\"width:180px\" /></td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td class=\"textlabels\" width=\"50%\">&nbsp;\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("SMTP Authentication"));
      out.write("\n\t\t\t\t</td>\n\t\t\t\t<td align=\"left\"><input type=\"checkbox\" class=\"datafield\" name=\"smtpAuth\" value=\"");
      out.print(curSMTPAuthID);
      out.write('"');
      out.write(' ');
      out.print(curSMTPAuthID==1?"checked=\"checked\"":"");
      out.write("  onclick=\"setAuth(this)\" /></td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td class=\"textlabels\" width=\"50%\">&nbsp;\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Username"));
      out.write("<font class=\"compfield\">*</font>\n\t\t\t\t</td>\n\t\t\t\t<td><input type=\"text\" class=\"datafield\" name=\"username\" value=\"");
      out.print(username);
      out.write("\" style=\"width:180px\"/></td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td class=\"textlabels\" width=\"50%\">&nbsp;\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Password"));
      out.write("<font class=\"compfield\">*</font>\n\t\t\t\t</td>\n\t\t\t\t<td ><input type=\"password\" class=\"datafield\" name=\"password\" value=\"\"  title=\"For security reasons old password can not be displayed.\" style=\"width:180px\"/></td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td></td>\n\t\t\t\t<td align=\"left\">\n\t\t\t\t\t<input class=\"criButton\" type=\"submit\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Save"));
      out.write("\" />\n\t\t\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Send Test Mail"));
      out.write("\" onclick=\"handleThickBox('1','testip')\" />\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t</table>\n\t\t</td>\n\t</table>\n\t</div>\n\t<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n\t<div class=\"TB_window\" id=\"testip\" style=\"width: 350px;\">\n\t<div>\n\t\t<table width=\"100%\" cellspacing=\"0\" cellpadding=\"2\" border=\"0\">\t\n\t\t<tr class=\"innerpageheader\">\n\t\t\t<td width=\"3%\"> </td>\n\t\t\t<td class=\"contHead\">Send Test Mail to</td>\n\t\t\t<td align=\"right\" style=\"padding-right: 5px; padding-top: 2px;\" colspan=\"3\">\n\t\t\t\t<img height=\"15\" width=\"15\" style=\"cursor: pointer;\" onclick=\"handleThickBox('2','testip')\" src=\"../images/close.jpg\"/>\n\t\t\t</td>\n\t\t</tr>\n\t\t</table>\n\t\t<div align=\"center\" style=\"margin: 5px;\">\n\t\t\t<div style=\"border: 1px solid rgb(153, 153, 153); width: 95%;\">\n\t\t\t\t<table width=\"100%\" cellspacing=\"2\" cellpadding=\"2\" border=\"0\" style=\"background: rgb(255, 255, 255) none repeat scroll 0% 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;\">\n\t\t\t\t<tr>\n\t\t\t\t\t<td style=\"width: 100px;\" class=\"textlabels\">To Address<font class=\"compfield\">*</font></td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" size=\"25\" class=\"datafield\" name=\"testEmail\"/></td>\n\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\t\t</div>\n\t\t<table align=\"center\">\n\t\t<tr>\n\t\t\t<td align=\"center\" colspan=\"2\">\n\t\t\t\t<input type=\"button\" value=\"Send\" name=\"confirm\" class=\"criButton\" onclick=\"sendTestMail()\" />\n\t\t\t\t<input type=\"button\" onclick=\"handleThickBox('2','testip')\" value=\"Cancel\" class=\"criButton\"/>\n\t\t\t</td>\n\t\t</tr>\n\t\t</table>\n\t</div>\n\t</div>\n\t</form>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n</body>\n</html>\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in iviewconfig.jsp : "+e,e);
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
