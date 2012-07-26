package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.authentication.beans.UserBean;
import org.cyberoam.iview.authentication.beans.RoleBean;

public final class pageheader_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n<input type=\"hidden\" id=\"refreshed\" value=\"no\"> \n<script type=\"text/javascript\">  \n\t\tif(navigator.userAgent.indexOf(\"Chrome\") != -1){\n\t\t\tvar e=document.getElementById(\"refreshed\"); \n\t\t\tif(e.value==\"no\"){\n\t\t\t\te.value=\"yes\"; \n\t\t\t}else{\n\t\t\t\te.value=\"no\";\n\t\t\t\tlocation.reload();\n\t\t\t}\n\t\t} \n</script>\n");

	try{
	StringBuffer jspPathName = null;
	if(request.getRequestURI() != null){
		jspPathName = new StringBuffer(request.getRequestURI());
	}
	String context = request.getContextPath();
	int index = jspPathName.toString().indexOf(context);
	jspPathName.delete(0,index+context.length()+1);
	jspPathName.delete(jspPathName.length()-4,jspPathName.length());

	int lastindex=jspPathName.toString().lastIndexOf("/");
	StringBuffer temp=new StringBuffer(jspPathName.toString());
	temp.delete(0,lastindex+1);
	String topic=temp.toString();
	int sessionTimeOutInterval = session.getMaxInactiveInterval();
	String helpURL="/onlinehelp/wwhelp/wwhimpl/api.htm?context=Online_help&topic="+topic;
	if(jspPathName.toString().equalsIgnoreCase("webpages/singlereport")){
		topic="reportid" +request.getParameter("reportid");
		
		//helpURL="/onlinehelp/reportid="+request.getParameter("reportid")+".html";	
	}else if(jspPathName.toString().equalsIgnoreCase("webpages/reportgroup")){
		//helpURL="/onlinehelp/reportgroupid="+request.getParameter("reportgroupid") +".html";
		topic="reportgroupid" +request.getParameter("reportgroupid");
	}
	helpURL="/onlinehelp/wwhelp/wwhimpl/api.htm?context=Online_help&topic="+topic;

      out.write("\n<!-- Including calendar and slide menu -->\n\n\n\n\n<script language=\"JavaScript\">\n\n<!--\n\ndocument.onhelp = onhelppage;\n\n\nvar countDownInterval=");
      out.print(sessionTimeOutInterval);
      out.write(";\nvar countDownTime=countDownInterval+1;\nfunction countDown(){\n\tcountDownTime--;\n\tif (countDownTime <=0){\n\t\tcountDownTime=countDownInterval;\n\t\tclearTimeout(counter);\n\t\ttop.location = \"");
      out.print(request.getContextPath());
      out.write("\" + \"/webpages/logout.jsp\";\n\t\treturn;\n\t}\n\tcounter=setTimeout(\"countDown()\", 1000);\n}\nfunction startit(){\n\tcountDown()\n}\nfunction onhelppage() {\n\twindow.open(\"");
      out.print(helpURL);
      out.write("\",'_person','width=850,height=650,screenX=10,screenY=10,titlebar=yes,scrollbars=yes,resizable=yes');\n    return false;\n}     \nfunction keyhandler(e) {\n\tisNetscape=(document.layers);\n\tif(isNetscape){ // for Netscape\n\t\teventChooser = keyStroke.which;\n\t}else if(e){ // for Mozilla\n\t\teventChooser = e.keyCode;\n\t}else{\t\t // for IE\n\t\teventChooser = event.keyCode;\n\t}\n    which = String.fromCharCode(eventChooser);\n    xCode=which.charCodeAt(0);\n    // If F2 is pressed \n\tif (xCode == 113){\n    \tlocation.href=\"");
      out.print(request.getContextPath());
      out.write("/webpages/mainpage.jsp\";\n\t}\n\t// If F10 is pressed \n\tif (xCode == 121){\n    \tlocation.href=\"");
      out.print(request.getContextPath());
      out.write("/webpages/maindashboard.jsp\";\n\t}\n\t// If F1 is pressed\n\tif (xCode == 112){\n\t\tonhelppage();\n\t}\n}       \n//-->\n</script>\n<link rel=\"SHORTCUT ICON\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n<div class=\"pageheader\" id=\"pageheader\">   \n\t<div class=\"header2\"></div>\n\t<div class=\"welcomenote\">Welcome, <b>");
      out.print((String)session.getAttribute("username") );
      out.write("</b></div>\n\t<div class=\"linkblock\">\n\t\t<div class=\"seperator\"></div>\n\t\t<div class=\"link\">\n\t\t\t<a href=\"logout.jsp\" title=\"Logout Current Session\">");
      out.print(TranslationHelper.getTranslatedMessge("Logout"));
      out.write("</a>\n\t\t</div>\n\t</div>\n\t<div class=\"linkblock\">\n\t\t<div class=\"seperator\"></div>\n\t\t<div class=\"link\">\n\t\t\t<a href=\"aboutus.jsp\">");
      out.print(TranslationHelper.getTranslatedMessge("About Us"));
      out.write("</a>\n\t\t</div>\n\t</div>\n\t<div class=\"linkblock\">\n\t\t<div class=\"seperator_small_line\"></div>\n\t\t<div class=\"link\">\n\t\t\t<a href=\"");
      out.print(helpURL );
      out.write("\" target=\"_blank\" >");
      out.print(TranslationHelper.getTranslatedMessge("Help"));
      out.write("</a>\n\t\t</div>\n\t</div>\n\t<div class=\"linkblock\">\n\t\t<div class=\"seperator\"></div>\n\t\t<div class=\"link\" style=\"margin-right:-5px;cursor:pointer;\"><img src=\"../images/home.png\" onclick=\"document.location.href='maindashboard.jsp'\" width=\"15px\" height=\"15px\"/></div>\n\t\t<div class=\"link\">\t\t\t\n\t\t\t<a href=\"maindashboard.jsp\">");
      out.print(TranslationHelper.getTranslatedMessge("Home"));
      out.write("</a>\n\t\t</div>\n\t</div>       \t\n</div>\n<script language=javascript>\n\tstartit();\n</script>\n");

	}catch(Exception e){
	CyberoamLogger.appLog.debug("pageheader.jsp.e:"+e,e);	
}

      out.write("\n\n\t \n");
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
