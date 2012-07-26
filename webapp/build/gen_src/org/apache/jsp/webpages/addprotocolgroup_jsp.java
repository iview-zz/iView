package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.CheckSession;
import java.text.MessageFormat;
import java.util.*;
import org.cyberoam.iview.beans.ProtocolGroupBean;
import org.cyberoam.iview.beans.ApplicationNameBean;
import org.cyberoam.iview.beans.ProtocolIdentifierBean;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.utility.CheckSession;

public final class addprotocolgroup_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n");

	if(CheckSession.checkSession(request,response)<0)
		return;
		ApplicationNameBean applicationNameBean = null;
		LinkedHashMap applicationNameMap=null;
		Iterator applicationNameIterator=null;
		applicationNameMap=ApplicationNameBean.getApplicationNameBeanMap(ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP);
		if(applicationNameMap !=null && applicationNameMap.size() > 0){
		applicationNameIterator=applicationNameMap.values().iterator();
		}
		String pageHeader = TranslationHelper.getTranslatedMessge("Add");
		String desc="";
		boolean isUnassigned = false;
		String strProtocolGrpId=request.getParameter("protocolgroupid");
		int id=-1,iMode=ApplicationModes.ADD_PROTOCOL_GROUP;
		if(strProtocolGrpId != null){
			pageHeader = TranslationHelper.getTranslatedMessge("Edit");
			id = new Integer(strProtocolGrpId).intValue();
			ProtocolGroupBean protocolGroupBean = null;
			protocolGroupBean = ProtocolGroupBean.getSQLRecordbyPrimarykey(id);
			if(protocolGroupBean != null){
				isUnassigned = protocolGroupBean.getProtocolgroupId() == ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP;
				pageHeader+= " " + protocolGroupBean.getProtocolGroup();
				desc=protocolGroupBean.getDescription();
			}
			iMode = ApplicationModes.UPDATE_PROTOCOL_GROUP;
		}

      out.write("\n\n<HTML>\n<HEAD></HEAD>\n<BODY>\n\t<FORM method=\"POST\" name=\"frmAddProtocolGroup\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\">\n\t<input type=\"hidden\" name=\"appmode\" value =");
      out.print(iMode );
      out.write(">\n\t<input type=\"hidden\" name=\"id\" value=");
      out.print(id );
      out.write(">\n\t\n\t<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n\t<tr class=\"innerpageheader\">\n\t\t<td width=\"3%\">&nbsp;</td>\n\t\t<td class=\"contHead\">");
      out.print( pageHeader +" " + TranslationHelper.getTranslatedMessge("Application Group") );
      out.write("</td>\n\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleThickBox('2','protocolgrp')\" style=\"cursor: pointer;\">\n\t\t</td>\n\t</tr>\n</table>\n\t<tr>\n\t\t<td width=\"7%\">&nbsp;</td>\n\t\t<td>\n\t\t<div style=\"margin:5px\" align=\"center\">\n\t\t\t<div style=\"width:95%;border:1px solid #999999;\">\n\t\t\t<table cellspacing=\"2\" cellpadding=\"2\" border=\"0\" width=\"100%\" style=\"background:#FFFFFF;\">\n\t\t\t<tr>\n\t\t\t\t<td>\n\t\t\t\t\t<table cellspacing=\"2\" cellpadding=\"2\" border=\"0\" width=\"100%\" class=\"trContainer\">\n\t\t\t\t\t");

					if(strProtocolGrpId == null){
					
      out.write("\n\t\t\t\t\t<tr >\n\t\t\t\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Group Name") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t\t\t\t<td> <input size=\"29\" type=\"text\" name=\"protocolgroupname\" value=\"\" /></td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr >\n\t\t\t\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Description") );
      out.write("</td>\n\t\t\t\t\t\t<td >\n\t\t\t\t\t");
	
					} else {
					
      out.write("\n\t\t\t\t\t<tr >\n\t\t\t\t\t\t<td  class=\"textlabels\" style=\"width:35%\">");
      out.print( TranslationHelper.getTranslatedMessge("Description"));
      out.write("</td>\n\t\t\t\t\t\t<td  >\n\t\t\t\t\t");

					}
					
      out.write("\n\t\t\t\t\t\t\t<textarea rows=4 name=description cols=\"22\">");
      out.print((desc !=null && !"null".equalsIgnoreCase(desc))?desc:"" );
      out.write("</textarea>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr >\n\t\t\t\t\t\t<td colspan=\"2\" >\n\t\t\t\t\t\t\t<table cellspacing=\"3\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n\t\t\t\t\t\t\t<tr class=\"trContainer1\" ");
      out.print( isUnassigned?"colspan=\"3\"":"" );
      out.write(' ');
      out.print( isUnassigned?"align=\"center\"":"" );
      out.write(" >\n\t\t\t\t\t\t\t\t<td class=\"trContainer1\">");
      out.print( TranslationHelper.getTranslatedMessge("Unassigned Applications") );
      out.write("</td>\n\t\t\t\t\t");
 if(!isUnassigned) { 
      out.write("\n\t\t\t\t\t\t\t\t<td class=\"trContainer1\">&nbsp;</td>\n\t\t\t\t\t\t\t\t<td class=\"trContainer1\">");
      out.print( TranslationHelper.getTranslatedMessge("Selected Applications") );
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t\t\t");
 } 
      out.write("\n\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\t<tr class=\"trContainer\">\n\t\t\t\t\t\t\t\t<td class=\"trContainer1\" ");
      out.print( isUnassigned?"colspan=\"3\"":"" );
      out.write("  align=\"center\">\n\t\t\t\t\t\t\t\t\t<select style=\"width: 200px;\" size=\"10\" multiple=\"multiple\" name=\"availableapps\">\n\t\t\t\t");

							while(applicationNameIterator.hasNext()){
								applicationNameBean=(ApplicationNameBean)applicationNameIterator.next();
				
      out.write("\n\t\t\t\t\t\t\t\t\t\t<option value=\"");
      out.print(applicationNameBean.getApplicationNameId() );
      out.write('"');
      out.write('>');
      out.print(applicationNameBean.getApplicationName() );
      out.write("</option>\n\t\t\t\t");

					}
				
      out.write("\n\t\t\t\t\t\t\t\t\t</select>\n\t\t\t\t\t\t\t\t</td>\n\t\t\t\t");

					if(!isUnassigned){
				
      out.write("\t\t\t\t\n\t\t\t\t\t\t\t\t<td align=\"center\" class=\"trContainer1\">\n\t\t\t\t\t\t\t\t\t<input class=\"criButton\" type=\"button\" onClick=\"movelistitems('right')\" value=\"&nbsp;>&nbsp;\">\n\t\t\t\t\t\t\t\t\t<br>\n\t\t\t\t\t\t\t\t\t<input class=\"criButton\" type=\"button\" onClick=\"movelistitems('left')\" value=\"&nbsp;<&nbsp;\">\n\t\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t\t<td class=\"trContainer1\">\n\t\t\t\t\t\t\t\t\t<select style=\"width: 200px;\" size=\"10\" multiple=\"multiple\" name=\"selectedapps\">\n\t\t\t\t");

							applicationNameMap=ApplicationNameBean.getApplicationNameBeanMap(id);
							if(applicationNameMap !=null && applicationNameMap.size() > 0){
								applicationNameIterator=applicationNameMap.values().iterator();
							}
							while(applicationNameIterator.hasNext()){
								applicationNameBean=(ApplicationNameBean)applicationNameIterator.next();
				
      out.write("\n\t\t\t\t\t\t\t\t\t\t<option value=\"");
      out.print(applicationNameBean.getApplicationNameId() );
      out.write('"');
      out.write('>');
      out.print(applicationNameBean.getApplicationName() );
      out.write("</option>\n\t\t\t\t");
 } 
      out.write("\t\t\t\n\t\t\t\t\t\t\t\t\t</select>\n\t\t\t\t\t\t\t\t</td>\n\t\t\t\t");
 } 
      out.write("\t\t\t\t\n\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\t</table>\n\t\t\t\t\t\t</td>\t\t\n\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t<tr><td>&nbsp;</td></tr>\n\t\t\t</table>\n\t\t\t</div></div>\n\t\t<table align=\"center\">\t\n\t\t<tr>\n\t\t\t\t<td align=\"center\">\n\t\t\t\t\t<input class=\"criButton\" type=\"button\" onClick=\"return validateForm();\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Done") );
      out.write("\" name=\"ok\"/>\n\t\t\t\t\t&nbsp;&nbsp;\n\t\t\t\t\t<input class=\"criButton\" type=\"button\" onClick=\"handleThickBox('2','protocolgrp');\" value=\"");
      out.print( TranslationHelper.getTranslatedMessge("Cancel") );
      out.write("\" name=\"Cancel\"/>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t\t\n\t\t</table>\n\n\t\t<td width=\"7%\">&nbsp;</td>\n\t</tr>\n\t<tr><td colspan=\"3\">&nbsp;</td></tr>\n\t</table>\n</FORM>\n</BODY> \n</HTML>\n");
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
