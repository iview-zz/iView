package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.authentication.beans.RoleBean;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.utility.CheckSession;
import java.util.*;
import org.cyberoam.iview.utility.MultiHashMap;
import java.util.Iterator;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.device.beans.DeviceTypeBean;

public final class editdevice_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n<html>\n");

	if(CheckSession.checkSession(request,response) < 0) return;
	try{
		boolean isUpdate = false;
		DeviceBean deviceBean = null;
		if(request.getParameter("deviceid") != null && !request.getParameter("deviceid").equalsIgnoreCase("")){
			isUpdate = true;
			deviceBean = DeviceBean.getSQLRecordByPrimaryKey(Integer.parseInt(request.getParameter("deviceid")));
		}
		String header = TranslationHelper.getTranslatedMessge(isUpdate==true?"Update Device":"Add Device");

      out.write("\n<body>\n<div>\n<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"frmeditdevice\" onsubmit=\"return validateForm();\" >\n\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(isUpdate?ApplicationModes.MANAGE_DEVICE:ApplicationModes.NEW_DEVICE);
      out.write("\">\n\t<input type=\"hidden\" name=\"deviceid\" value=\"");
      out.print(isUpdate?deviceBean.getDeviceId():"");
      out.write("\">\n\t<table cellpadding=\"2\" cellspacing=\"0\" width=\"100%\" border=\"0\">\t\n\t\t<tr class=\"innerpageheader\">\n\t\t\t<td width=\"3%\">&nbsp;</td>\n\t\t\t<td class=\"contHead\">");
      out.print(header);
      out.write("</td>\n\t\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleThickBox('2','deviceform')\" style=\"cursor: pointer;\">\n\t\t\t</td>\n\t\t</tr>\n\t</table>\n\t<div style=\"margin:5px\" align=\"center\">\n\t<div style=\"width:95%;border:1px solid #999999;\">\n\t<table cellpadding=\"2\" cellspacing=\"2\" width=\"100%\" border=\"0\" style=\"background:#FFFFFF;\">\n\t<tr >\n\t\t<td class=\"textlabels\" style=\"width:100px;\" >");
      out.print(TranslationHelper.getTranslatedMessge("Device ID"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td ><input type=\"text\" name=\"applianceid\" class=\"datafield\" size=\"38\" value=\"");
      out.print(isUpdate?deviceBean.getApplianceID():"");
      out.write('"');
      out.write(' ');
      out.print(isUpdate?"disabled=\"disabled\"":"");
      out.write(" /></td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Name"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td ><input type=\"text\" name=\"devicename\" class=\"datafield\" maxlength=\"50\" value=\"");
      out.print((isUpdate&&deviceBean.getName()!=null)?deviceBean.getName():"");
      out.write("\" size=\"38\" ></td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\">");
      out.print(TranslationHelper.getTranslatedMessge("IP Address"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td ><input type=\"text\" name=\"ip\" class=\"datafield\" size=\"38\" value=\"");
      out.print(isUpdate && deviceBean.getIp() != null?deviceBean.getIp():"");
      out.write("\" /></td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Type"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td>\n\t\t\t\n\t\t\t<select name=\"devicetype\" ");
      out.print(((isUpdate && deviceBean.getDeviceStatus()!=0)?"disabled=disabled":""));
      out.write('>');
      out.write('\n');

				DeviceTypeBean deviceTypeBean = null;
				Iterator deviceTypeBeanItr = DeviceTypeBean.getDeviceTypeBeanIterator();
				while(deviceTypeBeanItr.hasNext()){
					deviceTypeBean = (DeviceTypeBean)deviceTypeBeanItr.next();
					if(deviceTypeBean!=null){

      out.write("\t\t\t\t\t<option value=\"");
      out.print( deviceTypeBean.getDeviceTypeId() );
      out.write('"');
      out.write(' ');
      out.print( (isUpdate && deviceBean.getDeviceType()==deviceTypeBean.getDeviceTypeId())?"selected=\"selected\"":"" );
      out.write(' ');
      out.write('>');
      out.print( deviceTypeBean.getTypeName() );
      out.write("</option>\n");

					}
				}

      out.write("\t\t\t</select>\n\t\t</td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\">");
      out.print(TranslationHelper.getTranslatedMessge("Description"));
      out.write("</td>\n\t\t<td>\n\t\t\t<textarea rows=\"5\" cols=\"35\" class=\"datafield\" name=\"description\">");
      out.print(isUpdate?deviceBean.getDescription():"");
      out.write("</textarea>\n\t\t</td>\n\t</tr>\n\t<tr >\n\t\t<td class=\"textlabels\"  style=\"height: 23px\">");
      out.print(TranslationHelper.getTranslatedMessge("Status"));
      out.write("<font class=\"compfield\">*</font></td>\n\t\t<td >\n\t\t\t<select name=\"devicestatus\" size=\"1\" class=\"datafield\">\t\t\n\t\t\t");
	if(isUpdate){ 
      out.write("\n\t\t\t\t<option value=\"");
      out.print(DeviceBean.ACTIVE);
      out.write('"');
      out.write(' ');
      out.print(deviceBean.getDeviceStatus()==DeviceBean.NEW || deviceBean.getDeviceStatus()==DeviceBean.ACTIVE?"selected=\"selected\"":"");
      out.write('>');
      out.print(TranslationHelper.getTranslatedMessge("Active"));
      out.write("</option>\n\t\t\t\t<option value=\"");
      out.print(DeviceBean.DEACTIVE);
      out.write('"');
      out.write(' ');
      out.print(deviceBean.getDeviceStatus()!=DeviceBean.DEACTIVE?"":"selected=\"selected\"");
      out.write(' ');
      out.write('>');
      out.print(TranslationHelper.getTranslatedMessge("Deactive"));
      out.write("</option>\t\t\t\t\n\t\t\t\n\t\t\t");
}else{ 
      out.write("\n\t\t\t\t<option value=\"");
      out.print(DeviceBean.ACTIVE);
      out.write("\" selected=\"selected\">");
      out.print(TranslationHelper.getTranslatedMessge("Active"));
      out.write("</option>\n\t\t\t\t<option value=\"");
      out.print(DeviceBean.DEACTIVE);
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print(TranslationHelper.getTranslatedMessge("Deactive"));
      out.write("</option>\t\t\t\t\n\t\t\t");
}
			
      out.write("\n\t\t\t</select>\n\t\t</td>\n\t</tr>\n\t<tr><td colspan=\"2\">&nbsp;</td></tr>\n</table>\n</div>\n</div>\n\t<table align=\"center\">\n\t<tr>\n\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t<input type=\"submit\" class=\"criButton\" name=\"confirm\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge(isUpdate?"Update":"Add"));
      out.write("\" >\n\t\t\t<input type=\"button\" class=\"criButton\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Cancel"));
      out.write("\" onclick=\"handleThickBox('2','deviceform')\">\n\t\t</td>\n\t</tr>\n\t</table>\n</form>\t\n</div>\n</body>\n</html>\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.error("ERROR in edit device page :" + e,e);
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
