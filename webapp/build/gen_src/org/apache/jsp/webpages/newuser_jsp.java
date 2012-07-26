package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.*;
import org.cyberoam.iview.*;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.authentication.beans.RoleBean;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.authentication.beans.UserBean;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import java.util.*;
import org.cyberoam.iview.utility.MultiHashMap;
import java.util.Iterator;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.device.beans.DeviceGroupBean;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.audit.CyberoamLogger;

public final class newuser_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<html>\n");

	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		boolean isUpdate = false;
		UserBean userBean = null;
		RoleBean roleBean = null;
		if(request.getParameter("username") != null){
	isUpdate = true;
	userBean = UserBean.getRecordbyPrimarykey(request.getParameter("username"));
		}
		String header = TranslationHelper.getTranslatedMessge(isUpdate==true?"Update User":"Add User");

      out.write("\n<head>\n<title>");
      out.print(iViewConfigBean.TITLE);
      out.write("</title>\n<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n\n</head>\n<body >\n<div>\n<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"registrationform\" onSubmit=\"return validateFrom();\">\n<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.NEWUSER);
      out.write("\">\n<table cellpadding=\"2\" cellspacing=\"0\" width=\"100%\" border=\"0\">\t\n\t<tr class=\"innerpageheader\">\n\t\t<td width=\"3%\">&nbsp;</td>\n\t\t<td class=\"contHead\">");
      out.print(header);
      out.write("</td>\n\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleThickBox('2','user')\" style=\"cursor: pointer;\">\n\t\t</td>\n\t</tr>\n</table>\n<div style=\"margin:5px\" align=\"center\">\n<div style=\"width:95%;border:1px solid #999999;\">\n\t<table cellpadding=\"2\" cellspacing=\"2\" width=\"100%\" align=\"center\" style=\"background:#FFFFFF;\">\n");

	if(session.getAttribute("message") != null){

      out.write("\n\t<tr><td colspan=\"2\" align=\"left\" class=\"message\">");
      out.print(session.getAttribute("message"));
      out.write("</td></tr>\n");

	session.removeAttribute("message");	
	}

      out.write("\n\t\n\t<tr >\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print(TranslationHelper.getTranslatedMessge("Name"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td ><input type=\"text\" name=\"name\" class=\"datafield\" style=\"width:180px\" maxlength=\"50\" value=\"");
      out.print(isUpdate==true?userBean.getName():"");
      out.write("\"></td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print(TranslationHelper.getTranslatedMessge("Username"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td ><input type=\"text\" name=\"username\" class=\"datafield\" style=\"width:180px\" maxlength=\"30\" value=\"");
      out.print(isUpdate==true?userBean.getUserName():"");
      out.write('"');
      out.write(' ');
      out.print(isUpdate==true?"disabled":"");
      out.write("></td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print(TranslationHelper.getTranslatedMessge("Password"));
      out.write("<font class=\"compfield\">");
      out.print( isUpdate?"":"*" );
      out.write("</font></td>\n\t\t<td ><input type=\"password\" name=\"passwd\" class=\"datafield\" style=\"width:180px\" maxlength=\"30\"  value=\"\" /></td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print(TranslationHelper.getTranslatedMessge("Confirm Password"));
      out.write("<font class=\"compfield\">");
      out.print( isUpdate?"":"*" );
      out.write("</font></td>\n\t\t<td ><input type=\"password\" name=\"confirmpasswd\" class=\"datafield\" style=\"width:180px\" maxlength=\"30\" value=\"\"></td>\n\t</tr>\n\t<tr>\n\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print(TranslationHelper.getTranslatedMessge("E-mail"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td ><input type=\"text\" name=\"email\" maxlength=\"100\" class=\"datafield\" style=\"width:180px\" value=\"");
      out.print(isUpdate==true?userBean.getEmail():"");
      out.write("\">\n\t</tr>\n\t<tr>\n\t\t<td class=\"textlabels\" style=\"height: 23px\" style=\"width:35%\">");
      out.print(TranslationHelper.getTranslatedMessge("Role"));
      out.write("</td>\n\t\t<td>\n\t\t\t<select name=\"role\" id=\"role\" size=\"1\" class=\"datafield\" style=\"width:180px\">\n");

	UserBean sessionUserBean = UserBean.getRecordbyPrimarykey(session.getAttribute("username").toString());
	Iterator itrRole = RoleBean.getRoleBeanIterator();
	if(isUpdate && userBean.getRoleId() == RoleBean.SUPER_ADMIN_ROLE_ID){
		roleBean = RoleBean.getRecordbyPrimarykey(RoleBean.SUPER_ADMIN_ROLE_ID);

      out.write("\n\t\t<option value=\"");
      out.print(roleBean.getRoleId());
      out.write('"');
      out.write('>');
      out.print(roleBean.getRoleName());
      out.write("</option>\n");

	} else {
		while(itrRole.hasNext()){
			roleBean = (RoleBean) itrRole.next();
			if(roleBean.getRoleId() > sessionUserBean.getRoleId() ) {
				if(isUpdate){

      out.write("\n\t\t\t\t<option value=\"");
      out.print(roleBean.getRoleId());
      out.write('"');
      out.write(' ');
      out.print(roleBean.getRoleId()==userBean.getRoleId()?"selected":"");
      out.write(' ');
      out.write('>');
      out.print(roleBean.getRoleName());
      out.write("</option>\n");

				} else {

      out.write("\n\t\t\t\t\t<option value=\"");
      out.print(roleBean.getRoleId());
      out.write('"');
      out.write('>');
      out.print(roleBean.getRoleName());
      out.write("</option>\n");

				}
			} else if(isUpdate && sessionUserBean.getRoleId() == roleBean.getRoleId() && sessionUserBean.getUserId() == userBean.getUserId()){

      out.write("\n\t\t\t<option value=\"");
      out.print(roleBean.getRoleId());
      out.write('"');
      out.write('>');
      out.print(roleBean.getRoleName());
      out.write("</option>\n");

			}
		}
	}

      out.write("\t\t\n\t\t\t</select>\n\t\t</td>\n\t</tr>\n");

	if(isUpdate==false){
		roleBean = RoleBean.getRecordbyPrimarykey(RoleBean.ADMIN_ROLE_ID);
	} else {
		roleBean = RoleBean.getRecordbyPrimarykey(userBean.getRoleId());
	}

      out.write("\t\n\t\t<tr id=\"deviceinfo\" style=\"display: ");
      out.print(roleBean.getRoleId()==RoleBean.SUPER_ADMIN_ROLE_ID?"none":"");
      out.write("\">\t\t\n\t\t\t<td class=\"textlabels\" style=\"width:35%\">");
      out.print(TranslationHelper.getTranslatedMessge("Select Device"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t\t<td>\n\t\t<div id=\"devicelist1\" style=\"float:left;\">\n \t\t\t<div class=\"grouptext\" id=\"devicelist\" style=\"height:20px;*height:20px;float:left;margin-right:2px;margin-top:4px\"></div>\n \t\t</div>\n \t\t\t</td>\n\t\t</tr>\n</table>\n</div>\n");

	String deviceListSel="";
	String deviceGroupListSel="";
	
	if(isUpdate){
		Iterator itrDevice = DeviceBean.getAllDeviceBeanIterator();
		DeviceBean deviceBean = null;
		while(itrDevice.hasNext()){
			deviceBean = (DeviceBean) itrDevice.next();
			if(UserCategoryDeviceRelBean.isRelationshipExistsWithDevice(userBean.getUserId(),deviceBean.getDeviceId())){
				deviceListSel += ""+deviceBean.getDeviceId()+",";	
			}
		}
		if(deviceListSel != "") {
			deviceListSel = deviceListSel.substring(0,(deviceListSel.length()-1));			
		}
		itrDevice = DeviceGroupBean.getDeviceGroupBeanIterator();
		DeviceGroupBean deviceGroupBean = null;
		
		while(itrDevice.hasNext()){
			deviceGroupBean = (DeviceGroupBean) itrDevice.next();				
			if(UserCategoryDeviceRelBean.isRelationshipExistsWithGroup(userBean.getUserId(),deviceGroupBean.getGroupID())){					
				deviceGroupListSel += ""+deviceGroupBean.getGroupID()+",";	
			}
		}
		if(deviceGroupListSel != "") {
			deviceGroupListSel = deviceGroupListSel.substring(0,(deviceGroupListSel.length()-1));			
		}
	}

      out.write("\n\t<table align=\"center\">\n\t\t<tr>\n\t\t\t<td colspan=\"2\">\n\t\t\t\t<input type=\"hidden\" id=\"selecteddevices\" name=\"selecteddevices\" value=");
      out.print(deviceListSel);
      out.write(" >\n\t\t\t\t<input type=\"hidden\" id=\"selectedgroups\" name=\"selectedgroups\" value=");
      out.print(deviceGroupListSel);
      out.write(" >\t\t\t\t\t\t\t\t\n\t\t\t\t<input type=\"hidden\" id=\"operation\" value=");
      out.print(isUpdate?"update":"Add");
      out.write(" >\n\t\t\t\t<input type=\"submit\" class=\"criButton\" name=\"confirm\" value=");
      out.print(TranslationHelper.getTranslatedMessge(isUpdate?"Update":"Add"));
      out.write(">\n\t\t\t\t<input type=\"button\" class=\"criButton\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Cancel"));
      out.write("\" onclick=\"handleThickBox('2','user')\">\n\t\t\t</td>\n\t\t</tr>\n\t</table>\n</form>\t\n</div>\n</body>\n</html>\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.error("ERROR in new user page :" + e,e);
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
