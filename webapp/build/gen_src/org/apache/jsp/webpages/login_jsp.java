package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.authentication.modes.AuthConstants;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n");

	session.invalidate();

      out.write("\n\n\n<html>\n<head>\n<title>::: Welcome To iView - Please Login :::</title>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/login.css\" rel=\"stylesheet\" type=\"text/css\" />\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\n<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n<script language=\"JavaScript\" src=\"/javascript/utilities.js\"></script>\n<script language=\"JavaScript\">\n\nfunction loginValidation() {\n\t\n\t\tform = document.forms[0] ;\n\t\tform.action= '");
      out.print(request.getContextPath() + "/iview");
      out.write("';\n        if (form.username.value == \"\" ){\n                alert('");
      out.print( TranslationHelper.getTranslatedMessge("You must enter the Username") );
      out.write("');\n\t\t\t\tform.username.focus();\n                return false ;\n        } else if (form.password.value == \"\" ) {\n                alert('");
      out.print( TranslationHelper.getTranslatedMessge("You must enter the Password") );
      out.write("');\n\t\t\t\tform.password.focus();\n                return false ;\n        }\n        re = /\\w{1,}/;\n\t\tusernamere=/^[a-zA-Z0-9_\\.\\@\\- ]{1,60}$/;\n\t\tif (!(re.test(form.username.value))){\n\t\t\talert('");
      out.print( TranslationHelper.getTranslatedMessge("Please enter valid Username") );
      out.write("');\n      \t\tform.username.focus();\n     \t\treturn false; \n\t\t\t}\n\t\telse if (!(usernamere.test(form.username.value))){\n    \t\talert('");
      out.print( TranslationHelper.getTranslatedMessge("Only alpha numeric characters are allowed in Username") );
      out.write("');\n\t\t\tform.username.focus();\n     \t\treturn false; \n\t\t} \n\t\tform.mode.value='");
      out.print(ApplicationModes.LOGIN );
      out.write("';\n\n\t\tdocument.getElementById(\"bodyWidth\").value = document.body.clientWidth;\n}\n\n\n</script>\n</head>\n\n");

	String fontclass="arial12whitebold" ;
	String message="" ;
	String status = request.getParameter("status");
	if(status != null){
		int iStatus = Integer.parseInt(status);
		if(iStatus == AuthConstants.LOGIN_FAILED){
			fontclass="arial12redbold" ;
			message= TranslationHelper.getTranslatedMessge("Wrong username / password");
		} else if(iStatus == AuthConstants.DB_CONNECTION_FAILED){
			fontclass="arial12redbold" ;
			message= TranslationHelper.getTranslatedMessge("Database connection lost");
		}else if(iStatus == AuthConstants.UNAUTHORIZED_ACCESS){
			fontclass="arial12redbold" ;
			message= TranslationHelper.getTranslatedMessge("You are trying to access UnAuthorized Page");
		}
		
	}

      out.write("\n\n<body onLoad=\"document.forms[0].username.focus();\" align=\"center\">\n<FORM onSubmit=\"return loginValidation()\" ACTION='");
      out.print(request.getContextPath() + "/iview");
      out.write("' METHOD=POST>\n<input type=\"hidden\" name=\"login_username\" VALUE=\"\" >\n<input type=\"hidden\" name=\"secretkey\" VALUE=\"\" >\n<input type=\"hidden\" name=\"mode\" VALUE=\"\" >\n<INPUT TYPE=HIDDEN NAME=\"js_autodetect_results\" VALUE=\"SMPREF_JS_OFF\">\n<INPUT TYPE=HIDDEN NAME=\"just_logged_in\" value=1>\n<INPUT TYPE=hidden NAME=appmode VALUE='");
      out.print(ApplicationModes.LOGIN );
      out.write("' >\n<INPUT TYPE=hidden NAME=bodyWidth id=bodyWidth  VALUE=1024 >\n<div id=\"wrapper\">\n\t<div class=\"loginbkgd\">\n\t\t<div class=\"iviewlogo\"></div>\n\t\t<div class=\"tagline\">Intelligent Logging & Reporting</div>\n\t\t<div class=\"screens\"></div>\n\t\t<div class=\"errormsg\">");
      out.print(message);
      out.write("</div>\n\t\t<div id=\"loginform\">\n\t\t\t<table border=\"0\" cellpadding=\"1\" cellspacing=\"2\" width=230px>\n\t\t\t<form>\n\t\t\t<tr>\n\t\t\t\t<td height=\"40\" class=\"signin\">Sign In</td>\n\t\t\t</tr>\n\t\t\t<tr>\n              <td height=\"10\"></td>\n\t\t\t  </tr>\n\t\t\t<tr>\n\t\t\t\t<td><strong>");
      out.print( TranslationHelper.getTranslatedMessge("Username"));
      out.write("</strong></td>\n\t\t\t  </tr>\n\t\t\t<tr>\n\t\t\t  <td><input type=\"text\" class=\"inputbox\" name=\"username\" id=\"username\" /></td>\n\t\t\t  </tr>\n\t\t\t<tr>\n\t\t\t  <td height=\"10\"></td>\n\t\t\t  </tr>\n\t\t\t<tr>\n\t\t\t\t<td><strong>");
      out.print( TranslationHelper.getTranslatedMessge("Password"));
      out.write("</strong></td>\n\t\t\t  </tr>\n\t\t\t<tr>\n\t\t\t  <td><input type=\"password\" class=\"inputbox\" name=\"password\" id=\"password\" /></td>\n\t\t\t  </tr>\n\t\t\t<tr>\n              <td height=\"10\"></td>\n\t\t\t  </tr>\n\t\t\t<tr>\n\t\t\t\t<td><input type=\"image\" src=\"");
      out.print(request.getContextPath());
      out.write("/images/login.png\" border=\"0\"></td>\n\t\t\t  </tr>\n\t\t\t</form>\n\t\t\t</table>\n\t\t</div><!-- end of loginform -->\n\t</div><!-- end of loginbkgd -->\n</div><!-- end of wrapper -->\n<div class=\"footer\">&copy;&nbsp;&nbsp;Elitecore Technologies Ltd.<br> The Program is provided AS IS, without warranty. Licensed under <a target=\"_blank\" href=\"");
      out.print(request.getContextPath());
      out.write("/LICENSE.txt\">GPLv3</a>. This program is free software; you can redistribute it and/or modify it under the terms of the <a target=\"_blank\" href=\"");
      out.print(request.getContextPath());
      out.write("/LICENSE.txt\">GNU General Public License version 3</a> as published by the Free Software Foundation including the additional permission set forth in the source code header.</br><img style=\"cursor:pointer\" src=\"../images/InitiativeLogo.png\" onclick=\"window.open('http://www.cyberoam.com','blank')\"></img>\n\n</div>\n</form>\n\n</body>\n</html>\n\n");
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
