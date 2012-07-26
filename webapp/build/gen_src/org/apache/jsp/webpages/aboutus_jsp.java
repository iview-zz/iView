package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.CheckSession;

public final class aboutus_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- ***********************************************************************\n*  Cyberoam iView - The Intelligent logging and reporting solution that \n*  provides network visibility for security, regulatory compliance and \n*  data confidentiality \n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\n*  \n*  This program is free software: you can redistribute it and/or modify \n*  it under the terms of the GNU General Public License as published by \n*  the Free Software Foundation, either version 3 of the License, or\n*  (at your option) any later version.\n*  \n*  This program is distributed in the hope that it will be useful, but \n*  WITHOUT ANY WARRANTY; without even the implied warranty of \n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \n*  General Public License for more details.\n*  \n*  You should have received a copy of the GNU General Public License \n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\n*  \n*  The interactive user interfaces in modified source and object code \n");
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n    ");

	try {
		if(CheckSession.checkSession(request,response)<0){
			return;
		}
	}catch(Exception ex){
		
	}
	
      out.write("\n<html>\n<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\n<title>About iView</title>\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script>\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></script>\n<style type=\"text/css\">\n\t#aTag{\n\t\tcolor:#07467C;\n\t}\n\t\n\tbody{\t\n\t\tfont-family: arial,san-serift,tahoma;\n\t\tfont-size: 13px;\n\t}\n\t.footerDiv{\n\t\tbackground-color:#f2f2f2;\n\t\tborder-style:solid;\n\t\tborder-width:2px;\n\t\tborder-color:rgb(201,214,223);\n\t\tborder-top-style:none;\n\t\twidth:98.5%;\n\t\twidth: expression(document.body.clientWidth-224);\n\t\theight: 130px;\n\t\tfloat: left;\n\t}\n\t.footerDivContent{\n\t\tfloat:left;\n\t\tmargin-left:20px;\n\t\tmargin-top:10px;\n\t\tpadding-left: 10px;\n\t\twidth : 95%;\t\t\n\t\tfont-family:arial,tahoma,san-serif;\n\t\tfont-size: 12px;\n\t}\n\t.contentDiv{\n\t\ttext-aligin:left;\t\t\n\t\tfloat:clear;\n\t\tpadding-left: 30px;\n\t\tpadding-top: 90px;\n\t\tpadding-right: 5px;\n\t\tborder:2px solid rgb(201,214,223);\n\t\tborder-top:0px solid;\n\t\twidth: 94%;\n\t\twidth: expression(document.body.clientWidth-224);\n\t\tfont-family:arial,tahoma,san-serif;\n\t\tfont-size: 12px;\n\t\tfloat:left;\n\t}\n\t.contentDivHeader{\t\t\n\t\tfont-family:arial,tahoma,san-serif;\n\t \tcolor: rgb(125,130,134);\n\t \tfont-size: 14px;\n\t\ttext-aligin:left;\n\t}\n\t.headerDivHeadText{\n");
      out.write("\t\tcolor:#32494f;\n\t\tfont-size:18px;\t\t\n\t\tborder-right: 2px;\n\t\tborder-right-color: #ccd5da;\n\t\tborder-right-style: solid;\n\t\tpadding-right: 10px;\n\t\tmargin-top: 20px;\n\t}\n\t.headerDivSubText{\n\t\tfont-size:15px;\n\t\tborder-right: 2px;\n\t\tborder-right-color: #ccd5da;\n\t\tborder-right-style: solid;\n\t\tpadding-right: 10px;\n\t\tcolor: rgb(55,56,58);\n\t}\n\t.headerDivContentText{\t\t\n\t\ttext-aligin:left;\n\t\tmargin-left:20px;\t\n\t\tmargin-top: 25px;\n\t\twidth: 55%;\n\t\tfloat:left;\n\t\tfont-family:\tarial,tahoma,san-serif;\n\t\tfont-size: 12px;\n\t \tcolor: rgb(55,56,58);\n\t \n\t\t\n\t}\n\t.headerDivHead{\n\t\tfloat:left;\n\t\tmargin-left:10px\n\t}\n\t.sep {\n\t\tbackground-color:#ccd5da;\n\t\theight: 30px;\n\t\twidth: 2px;\n\t}\n\t.pagefont {\n\t \tfont-family:\tArial Rounded MT Bold,Trebuchet MS,arial;\n\t \tcolor: rgb(150,174,180);\n\t \tfont-size: 12px;\n\t \t \n\t}\n</style>\n</head>\n<body>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("        \n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("        \t\n\t<div class=\"maincontent\" id=\"main_content\">\t\n\t<br/>\t\n\t\t<div >\n\t\t\t<div style=\"background-image: url(../images/lefttop.jpg); background-repeat: no-repeat; float: left; height: 90px; width: 4%;;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:rgb(201,214,223);\">&nbsp;</div>\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t \t\t\t\n\t\t\t<div style=\"background-image:url('../images/top_bg.jpg');background-repeat:repeat-x;height:90px;float:left;width:89%;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:rgb(201,214,223);\">\n\t\t\t\t<div class=\"headerDivHead\">\t\t\t\n\t\t\t\t\t<center>\n\t\t\t\t\t\t<div class=\"headerDivHeadText\"><b>About Cyberoam iView</b></div>\t\t\t\t\t\t\t\t \n\t\t\t\t \t\t<div class=\"headerDivSubText\">Intelligent Logging and Reporting</div>\n\t\t\t\t\t</center>\t\t\t\t  \n\t\t    \t</div>\t\t    \t\n\t\t    \t\n\t\t    \t<div class=\"headerDivContentText\">\n\t\t\t\t \tThe Intelligent logging and reporting solution that provides network visibility for security, regulatory compliance and data confidentiality.\n\t\t\t \t</div>\t\t\t\t\n\t\t\t</div>\n\t\t\t<div style=\"background-image:url('../images/righttop.jpg');background-repeat:no-repeat;float:left;margin-right: 0px;width:6%;height:90px;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:rgb(201,214,223);\">&nbsp;</div>\t\t\t\t\t\t\n");
      out.write("\t\t</div>\n\t\t<div class=\"contentDiv\">\n\t\t\t<div>\t\t\t\n\t\t\t\tCopyright &copy; 2009 Elitecore Technologies Ltd.\n\t\t\t</div>\n\t\t\t<br/>\t\t\t\n\t\t\tThis program is free software; you can redistribute it and/or modify it under the terms of\n\t\t\tthe GNU General Public License as published by the Free Software Foundation, either version 3\n\t\t\tof the License, or (at your option) any later version.  \t\t\t\n\t\t\t<br/>\n\t\t\t<br/>\t\t\t\n\t\t\tThis program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;\n\t\t\twithout even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n\t\t\tSee the GNU General Public License for more details.\t\t\t\n\t\t\t<br/>\n\t\t\t<br/>\t\t\t\n\t\t\tYou should have received a copy of the GNU General Public License along with this program.\n\t\t\tIf not, See <a id=\"aTag\" href=\"http://www.gnu.org/licenses/\" target=\"_blank\">http://www.gnu.org/licenses/</a>.  \t\t\t\n\t\t\t<br/>\n\t\t\t<br/>\n\t\t\tThe interactive user interfaces in modified source and object code versions of this program must display<br/>\n\t\t\tAppropriate Legal Notices, as required under Section 5 of the GNU General Public License version 3.\t\t\t\n");
      out.write("\t\t\t<br/>\n\t\t\t<br/>\t\t\t\n\t\t\tList of software used:\n\t\t\t<br/>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://gcc.gnu.org/\" target=\"_blank\">GNU C</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://tomcat.apache.org/\" target=\"_blank\">Apache Tomcat 5.5</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://java.sun.com/j2se/1.5.0/\" target=\"_blank\">JDK 1.5</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://www.postgresql.org/\" target=\"_blank\">PostgreSQL  8.4</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://www.cygwin.com/\" target=\"_blank\">Cygwin 1.5.25</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://www.jfree.org/jfreechart/\" target=\"_blank\">Jfreechart 1.0.13</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://logging.apache.org/log4j/1.2/index.html\" target=\"_blank\">Log4j 1.1</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://www.lowagie.com/iText/\" target=\"_blank\">iText 2.1.5</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://www.jfree.org/jcommon/\" target=\"_blank\">Jcommon-1.016</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://www.alphaworks.ibm.com/tech/xml4j\" target=\"_blank\">XML4j 2.0.15</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://java.sun.com/javase/technologies/desktop/javabeans/jaf/downloads/index.html\" target=\"_blank\">Activation 1.1</a>\n");
      out.write("\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://java.sun.com/products/javamail/\" target=\"_blank\">Java mail API 1.4.2</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://jdbc.postgresql.org/\" target=\"_blank\">Postgres JDBC 3</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://dynarch.com/mishoo/calendar.epl\" target=\"_blank\">DHTML Calendar 1.1.12.1</a>\n\t\t\t<br/>\n\t\t\t<a id=\"aTag\" href=\"http://www.dhtmlx.com/docs/products/dhtmlxGrid/\" target=\"_blank\">DhtmlxGrid 2.1</a>\n\t\t\t<br/>\n\t\t\t<br/>\n\t\t</div>\n\t\t\t\n\t\t<div class=\"footerDiv\">\n\t\n\t\t\t<div class=\"footerDivContent\">\n\t\t\t\tIn accordance with Section 7(b) of the GNU General Public License version 3, these Appropriate Legal Notices\n\t\t\t\tmust retain the display of the \"Cyberoam Elitecore Technologies Initiative\" logo.\n\t\t\t\t<div class=\"footerImageDiv\">\n\t\t\t\t\t<img src=\"../images/Cyberoam_Elitecore_Initiative_Logo.png\"></img>\n\t\t\t\t</div>\n\t\t\t\t<br/>\n\t\t\t\tCyberoam iView<sup>TM</sup> is the trademark of Elitecore Technologies Ltd.\n\t\t\t\t<br/>\n\t\t\t\t<a id=\"aTag\" href=\"http://www.elitecore.com\" target=\"_blank\">www.elitecore.com</a> | <a id=\"aTag\" href=\"http://www.cyberoam.com\" target=\"_blank\">www.cyberoam.com</a>\t\t\t\t\n");
      out.write("\t\t\t</div>\n\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t</div>\n\t\t\n\t</div>\n\t\t\t\n</body>\n</html>\n");
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
