package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.CheckSession;
import java.text.MessageFormat;
import java.util.*;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.beans.ProtocolIdentifierBean;
import org.cyberoam.iview.beans.ProtocolGroupBean;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.beans.ApplicationNameBean;

public final class addapplicationname_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n");

	if(CheckSession.checkSession(request,response)<0)
		return;
		ProtocolIdentifierBean protocolIdentifierBean = null;
		ProtocolGroupBean protocolGroupBean = null;
		LinkedHashMap protocolIdentifierBeanMap=null;
		Iterator protocolIdentifierBeanIterator=null;
		String pageHeader = TranslationHelper.getTranslatedMessge("Add");
		String selected="";
		String strAppNameId=request.getParameter("applicationnameid");
		int id=-1,protocolgroupid=ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP,iMode=ApplicationModes.ADD_APPLICATION;
		int mode = -1;
		if(request.getParameter("appmode") != null && request.getParameter("status") != null){
			mode = new Integer(request.getParameter("appmode").trim()).intValue();
			id = new Integer(request.getParameter("status")).intValue();
		}
		if(strAppNameId != null && !"null".equalsIgnoreCase(strAppNameId)){
			id = new Integer(strAppNameId).intValue();
		}
		
		String strMode=request.getParameter("appmode");
		String strStatus = request.getParameter("status");
		int appMode = -1,iStatus = 0;
		if(strMode !=null && !"null".equalsIgnoreCase(strMode)){
			appMode = new Integer(strMode).intValue();
		}
		if(strStatus !=null && !"null".equalsIgnoreCase(strStatus)){
			iStatus = new Integer(strStatus).intValue();
		}
		String message = "";
		if(appMode == ApplicationModes.DELETE_PROTOCOL_IDENTIFIER && iStatus > 0){
			message = TranslationHelper.getTranslatedMessge("Application Identifier deleted successfully.");
		}else if(appMode == ApplicationModes.DELETE_PROTOCOL_IDENTIFIER && iStatus < 0){
			message = TranslationHelper.getTranslatedMessge("Error in Application Identifier Deletion.");
		}else if(appMode == ApplicationModes.ADD_PROTOCOL_IDENTIFIER && iStatus > 0){
			message = TranslationHelper.getTranslatedMessge("Application Identifier added successfully.");
		}else if(appMode == ApplicationModes.ADD_PROTOCOL_IDENTIFIER && iStatus < 0){
			message = TranslationHelper.getTranslatedMessge("Error in Application Identifier Addition.");
		}
		if(request.getParameter("applicationname") != null && !"null".equalsIgnoreCase(request.getParameter("applicationname"))){
			String strApplicationName = request.getParameter("applicationname");
			message = TranslationHelper.getTranslatedMessge("Application Identifier already exists in") + " " + strApplicationName + ".";
		}
		
		if(id > 0){
			pageHeader = TranslationHelper.getTranslatedMessge("Edit");
			ApplicationNameBean applicationNameBean = null;
			applicationNameBean = ApplicationNameBean.getSQLRecordbyPrimarykey(id);
			if(applicationNameBean != null){
				pageHeader += " " + applicationNameBean.getApplicationName();
				protocolgroupid=applicationNameBean.getProtocolGroupId();
			}
			protocolIdentifierBeanMap=ProtocolIdentifierBean.getProtocolIdentifierBeanMap(id);
			if(protocolIdentifierBeanMap !=null && protocolIdentifierBeanMap.size() > 0){
				protocolIdentifierBeanIterator=protocolIdentifierBeanMap.values().iterator();
			}
			iMode=ApplicationModes.UPDATE_APPLICATION;
		}
		LinkedHashMap protocolGroupMap = ProtocolGroupBean.getProtocolGroupMap();
		Iterator protocolGroupIterator = protocolGroupMap.values().iterator();

      out.write("\n\n\n\n\n\n\n<HTML>\n<HEAD></HEAD>\n<BODY>\n\t<FORM method=\"POST\" name=\"frmAddProtocol\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\">\n\t<input type=\"hidden\" name=\"id\" value =");
      out.print(id );
      out.write(">\n\t<input type=\"hidden\" name=\"protocolidentifierid\" value=\"\">\n\t<input type=\"hidden\" name=\"appmode\" value=");
      out.print(iMode );
      out.write(">\n\t\n\t<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n\t<tr class=\"innerpageheader\">\n\t\t<td width=\"3%\">&nbsp;</td>\n\t\t<td class=\"contHead\">");
      out.print( pageHeader +" " + TranslationHelper.getTranslatedMessge("Application") );
      out.write("</td>\n\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleThickBox('2','application')\" style=\"cursor: pointer;\">\n\t\t</td>\n\t</tr>\n\t</table>\n\n\t<tr>\n\t\t<td width=\"7%\">&nbsp;</td>\n\t\t<td>\n\t\t\t<div style=\"margin:5px\" align=\"center\">\n\t\t\t<div style=\"width:95%;border:1px solid #999999;\">\n\t\t\t<table border=\"0\" cellpadding=\"2\" cellspacing=\"2\" width=\"100%\" class=\"trContainer\" style=\"background:#FFFFFF;\">\n\t\t\t");
if(!"".equals(message)){ 
      out.write("\n\t\t\t\t<tr><td class=\"message\" colspan=\"2\">");
      out.print(message );
      out.write("</td></tr>\n\t\t\t\t<tr><td colspan=\"2\">&nbsp;</td></tr>\n\t\t\t");
 } 
      out.write("\t\n\n\t\t\t");

				if(!(id > 0)){
			
      out.write("\n\t\t\t<tr>\n\t\t\t\t<td  class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Application Name") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t\t<td>  <input type=\"text\" name=\"applicationname\" value=\"\" style=\"width:180px\" /></td>\n\t\t\t</tr>\n\t\t\t<tr >\n\t\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Application Group") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t\t<td >\n\t\t\t");
	} else {
			
      out.write("\n\t\t\t<tr >\n\t\t\t\t<td colspan=\"2\" align=\"left\" class=\"Buttonback\">\n\t\t\t\t\t<input class=\"criButton\" type=\"button\" name=\"\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Add Application Identifier") );
      out.write("\" onclick=\"openAddProtocolIdentifier('");
      out.print( id );
      out.write("');\">\n\t\t\t\t</td>\t\n\t\t\t</tr>\n\t\t\t<tr >\n\t\t\t\t<td  class=\"textlabels\" style=\"width:50%\">");
      out.print( TranslationHelper.getTranslatedMessge("Application Group") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t\t<td  >\n\t\t\t");
	
			}
			
      out.write("\n\t\t\t\t\t<select name=\"protocolgroup\" style=\"width:180px\">\n\t\t");

					while(protocolGroupIterator.hasNext()){
						protocolGroupBean =(ProtocolGroupBean)protocolGroupIterator.next();
		
      out.write("\t\t\t\n\t\t\t\t\t\t<option value=\"");
      out.print(protocolGroupBean.getProtocolgroupId() );
      out.write('"');
      out.write(' ');
      out.print((protocolGroupBean.getProtocolgroupId() == protocolgroupid)?"selected":"" );
      out.write('>');
      out.print(protocolGroupBean.getProtocolGroup() );
      out.write("</option>\n\t\t");
 } 
      out.write("\n\t\t\t\t\t</select>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t");
 
			if(id > 0){
		
      out.write("\n\t\t\t\n\t\t");

				if(protocolIdentifierBeanMap !=null && protocolIdentifierBeanMap.size() > 0){
		
      out.write("\n\t\t\t<tr >\n\t\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Application Identifiers") );
      out.write("</td>\n\t\t\t\t<td></td>\n\t\t\t</tr>\n\t\t\t<tr >\n\t\t\t\t<td colspan=\"2\" align=\"left\" >\n\t\t\t\t<div class=\"IdentDiv\">\n\t\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"trContainer\">\n\t\t");

					boolean firstRow = true;
					while(protocolIdentifierBeanIterator.hasNext()){
						protocolIdentifierBean=(ProtocolIdentifierBean)protocolIdentifierBeanIterator.next();
						String identifier="";
						if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.ICMP)
							identifier="icmp/"+protocolIdentifierBean.getPort();
						else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.TCP)
							identifier="tcp/"+protocolIdentifierBean.getPort();
						else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.UDP)
							identifier="udp/"+protocolIdentifierBean.getPort();

		
      out.write("\n\t\t\t<tr >\n\t\t\t\t<td class=\"textlabels\" style=\"width:50%\">");
      out.print(identifier );
      out.write("</td>\n\t\t\t\t<td align=\"left\">\n\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/false.gif\" title=\"Disable\" style=\"cursor:hand\" onclick=\"deleteProtocolIdentifier(");
      out.print(protocolIdentifierBean.getId() );
      out.write(',');
      out.write('\'');
      out.print(identifier );
      out.write("')\">\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t");
					firstRow = false;
					}
		
		
      out.write("\n\t\t\t\t\t</div>\n\t\t\t\t\t</table>\t\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t");

				}
			}
		
      out.write("\n\t\t\t</table>\n\t\t\t</div></div>\n\t\t\t<table align=\"center\">\n\t\t\t<tr>\n\t\t\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t\t\t<input class=\"criButton\" type=\"button\" onclick=\"return validateProtocolForm();\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Done") );
      out.write("\" name=\"ok\"/>\n\t\t\t\t\t&nbsp;&nbsp;\n\t\t\t\t\t<input class=\"criButton\" type=\"button\" onclick=\"handleThickBox('2','application');\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Cancel") );
      out.write("\" name=\"Cancel\" />\t\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t</table>\n\t\t</td>\n\t\t<td width=\"7%\">&nbsp;</td>\n\t</tr>\n\t<tr><td colspan=\"3\">&nbsp;</td></tr>\n\t</table>\n</BODY> \n</HTML>\n");
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
