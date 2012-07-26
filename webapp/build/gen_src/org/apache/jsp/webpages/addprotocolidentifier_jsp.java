package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.beans.ProtocolIdentifierBean;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.mlm.TranslationHelper;

public final class addprotocolidentifier_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n");

	if(CheckSession.checkSession(request,response)<0)
		return;
	String strAppNameId=request.getParameter("applicationnameid");
	int applicationNameId = -1;
	if(strAppNameId != null){
		applicationNameId = new Integer(strAppNameId).intValue();
	}

      out.write("\n\n<html>\n<head></head>\n<body>\n\t<FORM method=\"POST\" name=\"frmProtocolIdentifier\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\">\n\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.ADD_PROTOCOL_IDENTIFIER );
      out.write("\" >\n\t<input type=\"hidden\" name=\"applicationnameid\" value=\"");
      out.print(applicationNameId );
      out.write("\" >\n\t<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n\t<tr class=\"innerpageheader\">\n\t\t<td width=\"3%\">&nbsp;</td>\n\t\t<td class=\"contHead\">");
      out.print( TranslationHelper.getTranslatedMessge("Add Application Identifier") );
      out.write("</td>\n\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleIdentifier()\" style=\"cursor: pointer;\">\n\t\t</td>\n\t</tr>\n\t</table>\n\t<tr><td colspan=\"3\">&nbsp;</td></tr>\n\t<tr>\n\t\t<td width=\"7%\">&nbsp;</td>\n\t\t<td>\n\t\t\t<div style=\"margin:5px\" align=\"center\">\n\t\t\t<div style=\"width:95%;border:1px solid #999999;\">\n\t\t\t<table cellspacing=\"2\" cellpadding=\"2\" border=\"0\" width=\"100%\" class=\"trContainer\" style=\"background:#FFFFFF;\">\n\t\t\t<tr>\n\t\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Application") );
      out.write("</td>\n\t\t\t\t<td >\n\t\t\t\t\t<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td style=\"width:50%\">\n\t\t\t\t\t\t\t<input type=\"radio\" checked name=\"rdoProtocol\" id=\"rdoProtocolTcp\" value=\"");
      out.print(ProtocolIdentifierBean.TCP );
      out.write("\">&nbsp;TCP&nbsp;\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td >\n\t\t\t\t\t\t\t<input type=\"radio\" name=\"rdoProtocol\" id=\"rdoProtocolUdp\" value=\"");
      out.print(ProtocolIdentifierBean.UDP );
      out.write("\">&nbsp;UDP&nbsp;\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Port Type") );
      out.write("</td>\n\t\t\t\t<td >\n\t\t\t\t\t<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td style=\"width:50%\">\n\t\t\t\t\t\t\t<input type=\"radio\" name=\"rdoPort\" id=\"rdoPort\" value=\"1\" onclick=\"onChangePortType();\" checked>&nbsp;Port&nbsp;\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td >\n\t\t\t\t\t\t\t<input type=\"radio\" name=\"rdoPort\" id=\"rdoPortRange\" value=\"2\" onclick=\"onChangePortType();\" >&nbsp;Port&nbsp;&nbsp;Range&nbsp;\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("From") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t\t<td ><input type=\"text\" name=\"txtFrom\" id=\"txtFrom\" value=\"\"></td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("To") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t\t<td ><input type=\"text\" name=\"txtTo\" id=\"txtTo\"  disabled value=\"\"></td>\n\t\t\t</tr>\n\t\t\t<tr><td colspan=\"2\">&nbsp;</td></tr>\n\t\t\t</table></div></div>\n\t\t\t<table align=\"center\">\n\t\t\t<tr>\n\t\t\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t\t\t<input class=\"criButton\" type=\"button\" onclick=\"return validateIdentifierForm();\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Done") );
      out.write("\" name=\"ok\"/>\n\t\t\t\t\t<input class=\"criButton\" type=\"button\" onclick=\"handleIdentifier();\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Cancel") );
      out.write("\" name=\"Cancel\"/>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t</table>\n\t\t\t\n\t\t\t</td>\n\t\t\t<td width=\"7%\">&nbsp;</td>\n\t\t</tr>\n\t\t<tr><td colspan=\"3\">&nbsp;</td></tr>\n\t\t</table>\n\t</form>\n</body> \n</html>\n");
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
