package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.beans.iViewConfigBean;
import java.util.Iterator;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.device.beans.DeviceTypeBean;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;

public final class managedevice_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n");

	try{
	if(CheckSession.checkSession(request,response)<0)
		return;
	DeviceBean.checkForNewDevice();	
	
	boolean allDevices = true;
	String pmessage = "";
	String nmessage = "";
	if(request.getParameter("alldevice") != null && "false".equalsIgnoreCase(request.getParameter("alldevice"))){
		allDevices = false;
	}
	String[] statusImg = new String[6];
	statusImg[0] = "new.jpg";
	statusImg[1] = "user.jpg";
	statusImg[2] = statusImg[4] = "true.gif";
	statusImg[3] = statusImg[5] = "false.gif";
	
	String[] rowTitle = new String[6];
	rowTitle[0] = TranslationHelper.getTranslatedMessge("New Device Discoverd");
	rowTitle[1] = TranslationHelper.getTranslatedMessge("Pending Decision by User");
	rowTitle[2] = rowTitle[4] = TranslationHelper.getTranslatedMessge("Active Device");
	rowTitle[3] = rowTitle[5] = TranslationHelper.getTranslatedMessge("Deactive Device");
	
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
	if(iMode == ApplicationModes.MANAGE_DEVICE && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Device updated successfully.");
	}else if(iMode == ApplicationModes.MANAGE_DEVICE && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Duplicate devicename or appliance ID");
	}else if(iMode == ApplicationModes.MANAGE_DEVICE){
		nmessage = TranslationHelper.getTranslatedMessge("Error in device updation.");
	}else if(iMode == ApplicationModes.NEW_DEVICE && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Device added successfully.");
	}else if(iMode == ApplicationModes.NEW_DEVICE && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Duplicate device name or appliance ID or device with same IP Address and Device Type.");
	}else if(iMode == ApplicationModes.NEW_DEVICE){
		nmessage = TranslationHelper.getTranslatedMessge("Error in device addition.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE && iStatus > 0){
		pmessage = iStatus + " " + TranslationHelper.getTranslatedMessge("Device deleted successfully.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Device relation exist with Device Group.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE && iStatus == -5){
		nmessage = TranslationHelper.getTranslatedMessge("Device relation exist with Report Notification.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE && iStatus == -6){
		nmessage = TranslationHelper.getTranslatedMessge("Device relation exist with User.");
	}else if(iMode == ApplicationModes.DELETE_DEVICE){
		nmessage = TranslationHelper.getTranslatedMessge("Error in Device deletion.");
	}

      out.write("\n\n\n\n\n\n\n\n\n\n<HTML>\n<HEAD>\n\t<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n\t<META http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n\t<LINK rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\" />\n\t<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n\t<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ipvalidation.js\"></SCRIPT>\n<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\">\n\t\tvar deviceid = '';\n\t\twindow.onload = function (evt) {\n\t\t\tsetWidth();\n\t\t}\t\t\n\t\tfunction setWidth(){\n\t\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t\t}\n\t\t\n\t\tfunction submitForm(){\n\t\t\tvar devIdList = document.frmdevicemgt.deviceidlist;\n\t\t\tdevIdList.value = devIdList.value.substring(0,devIdList.value.lastIndexOf(','));\n\t\t\tif(confirm('");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to save changes?"));
      out.write("')){\n\t\t\t\tdocument.frmdevicemgt.submit();\n\t\t\t}\n\t\t}\n\t\t\n\t\tfunction addToList(deviceId){\n\t\t\tdocument.frmdevicemgt.deviceidlist.value += (deviceId + ',');\n\t\t}\n\t\t\n\t\tfunction selectall(){\n\t\t\tvar chk = document.getElementById(\"check1\");\n\t\t\tvar checkstmp = document.getElementsByName(\"select\");\n\t\t\tvar i;\n\t\t\tfor(i=0;i<checkstmp.length;i++){\n\t\t\t\tif(chk.checked==true){\n\t\t\t\t\tcheckstmp[i].checked=true;\n\t\t\t\t}\n\t\t\t\telse{\n\t\t\t\t\tcheckstmp[i].checked=false;\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\n\n\t\tfunction deselectall(){\n\t\t\tvar chk = document.getElementById(\"check1\");\n\t\t\tvar checkstmp = document.getElementsByName(\"select\");\n\t\t\tvar i;\n\t\t\tfor(i=0;i<checkstmp.length;i++){\n\t\t\t\tif(checkstmp[i].checked==false){\n\t\t\t\t\tchk.checked=false;\n\t\t\t\t\tbreak;\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t\t\n\t\tfunction validateDelete(){\n\t\t\telements = document.frmdevicemgt.select;\n\t\t\tflag = false ;\n\t\t\tif(elements.length == undefined){\n\t\t\t\tflag = true;\n\t\t\t} else\n\t\t\t\tfor( i=0;i<elements.length ; i++ ){\n\t\t\t\t\tif( elements[i].checked == true ){\n\t\t\t\t\t\tflag = true ;\n\t\t\t\t\t\tbreak;\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\tif(!flag){\n\t\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("You must select atleast one device"));
      out.write("\");\n\t\t\t\treturn false;\n\t\t\t}\n\t\t\tvar con = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected Devices(s)?"));
      out.write("\");\n\t\t\tif (! con ){ \n\t\t\t\treturn false ;\n\t\t\t}\n\t\t\tdocument.frmdevicemgt.appmode.value = '");
      out.print(ApplicationModes.DELETE_DEVICE);
      out.write("';\n\t\t\tdocument.frmdevicemgt.submit();\n\t\t}\n\t\tfunction openAddDevice(id){\n\t\t\tif(id == ''){\n\t\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/editdevice.jsp';\n\t\t\t} else {\n\t\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/editdevice.jsp?deviceid='+id;\n\t\t\t}\n\t\t\thandleThickBox(1,'deviceform',\"500\");\n\t\t}\n\t\tfunction validateForm(){\n\t\t\tform = document.frmeditdevice;\n\t\t\treExp = new RegExp(\"^[0-9a-zA-Z][0-9a-zA-Z_.@]*$\");\n\t\t\tnameReExp = new RegExp(\"^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$\");\n\t\t\t\n\t\t\tif(form.appmode.value == ");
      out.print(ApplicationModes.NEW_DEVICE);
      out.write("){\n\t\t\t\tif (trim(document.frmeditdevice.applianceid.value) == ''){\n\t\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Appliance ID"));
      out.write("');\n\t\t\t\t\tform.applianceid.focus();\n\t\t\t\t\treturn false;\n\t\t\t\t}\n\t\t\t\tif(!isValidIP(form.ip.value)){\n\t\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("Please Enter valid IP Address."));
      out.write("');\n\t\t\t\t\treturn false;\n\t\t\t\t}\n\t\t\t}\n\t\t\tif (document.frmeditdevice.devicename.value == ''){\n\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Device Name"));
      out.write("');\n\t\t\t\tdocument.frmeditdevice.devicename.focus();\n\t\t\t\treturn false;\n\t\t\t}else if (!nameReExp.test(document.frmeditdevice.devicename.value)){\n\t\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("alpha numeric characters, '_', '-', '@', ' ' and '.' allowed in Device Name"));
      out.write(" \");\n\t\t\t\tdocument.frmeditdevice.devicename.focus();\n\t\t\t\treturn false;\n\t\t\t}\n\t\t\tif(form.appmode.value == ");
      out.print(ApplicationModes.NEW_DEVICE);
      out.write("){\n\t\t\t\tcon = confirm(\"Are you sure you want to add the device?\");\n\t\t\t} else {\n\t\t\t\tcon = confirm(\"Are you sure you want to update the device?\");\n\t\t\t}\n\t\t\treturn con;\n\t\t}\n\t\tfunction deleteDevice(devId){\n\t\t\tform = document.frmdevicemgt;\n\t\t\tvar con = confirm('");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to delete device?"));
      out.write("');\n\t\t\tif (con){\n\t\t\t\tform.appmode.value = '");
      out.print(ApplicationModes.DELETE_DEVICE);
      out.write("';\n\t\t\t\tform.deviceid.value = devId;\n\t\t\t\tform.submit();\n\t\t\t}\n\t\t}\n\t</SCRIPT>\n</HEAD>\n<BODY>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      out.write('	');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp" + (("pageheader.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("setdevice", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("false", request.getCharacterEncoding()), out, true);
      out.write("\n\t\n\t<div class=\"maincontent\" id=\"main_content\">\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Management"));
      out.write("</div>\n\t\t</div>\n\t<br /><br />\n\t<FORM method=\"POST\" name=\"frmdevicemgt\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\">\n\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.MANAGE_DEVICE);
      out.write("\">\n\t<input type=\"hidden\" name=\"deviceidlist\" value=\"\">\n\t<input type=\"hidden\" name=\"deviceid\" value=\"\">\n\t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"margin-bottom: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td align=\"left\" class=\"ButtonBack\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Add"));
      out.write("\" onClick=\"openAddDevice('');\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete"));
      out.write("\" onclick=\"return validateDelete()\">\n\t\t</td>\n\t</tr>\n\t</table>\n\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td>\n\t\t\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"TableData\">\n\t");

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

      out.write("\n\t\n\t\t\t<tr>\n\t\t\t\t<td align=\"center\" class=\"tdhead\"><input type=checkbox name=check1 id=\"check1\" onClick=\"selectall()\"></td>\n\t\t\t\t<td class=\"tdhead\" align=\"center\" width=\"6%\">");
      out.print(TranslationHelper.getTranslatedMessge("Current Status"));
      out.write("</td>\n\t\t\t\t<td class=\"tdhead\" width=\"30%\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Name"));
      out.write("</td>\n\t\t\t\t<td class=\"tdhead\" width=\"30%\">");
      out.print(TranslationHelper.getTranslatedMessge("IP Address"));
      out.write("</td>\n\t\t\t\t<td class=\"tdhead\" width=\"30%\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Type"));
      out.write("</td>\n\t\t\t\t<td class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Status"));
      out.write("</td>\n\t\t\t\t\n\t\t\t</tr>\n");

	Iterator newdeviceBeanItr=DeviceBean.getNewDeviceBeanIterator();
	Iterator deviceBeanItr = DeviceBean.getAllDeviceBeanIterator();
	DeviceBean deviceBean = null;
	int deviceCnt = 0;
	String rowStyle = "trdark";
	if(newdeviceBeanItr.hasNext()){
		while(newdeviceBeanItr.hasNext()){
		deviceBean = (DeviceBean)newdeviceBeanItr.next();
		if(!allDevices && deviceBean.getDeviceStatus()!=DeviceBean.NEW)
			continue;
		deviceCnt++;
		out.println("<script>addToList("+deviceBean.getDeviceId()+")</script>");
		if(deviceCnt%2 == 0)
	rowStyle = "trdark";
		else 
	rowStyle = "trlight";

      out.write("\n\t\t\t<tr class=\"");
      out.print(rowStyle);
      out.write("\" title=\"");
      out.print(rowTitle[deviceBean.getDeviceStatus()]);
      out.write("\">\n\t\t\t\t<td class=\"tddata\" align=\"center\" title=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete Device"));
      out.write("\"><!-- <img src=\"");
      out.print(request.getContextPath() + "/images/delete.bmp");
      out.write("\" onclick=\"deleteDevice('");
      out.print(deviceBean.getDeviceId());
      out.write("')\" width=\"25px\" height=\"20px\"/> -->\n\t\t\t\t<input type=\"checkbox\" name=\"select\" value=\"");
      out.print(deviceBean.getDeviceId());
      out.write("\" >\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\" align=\"center\">\n\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath() + "/images/" + statusImg[deviceBean.getDeviceStatus()]);
      out.write("\" height=\"15\" width=\"15\" />\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\"><a class=\"configLink\" href=\"#\" onclick=\"openAddDevice('");
      out.print(deviceBean.getDeviceId());
      out.write("')\" >");
      out.print(deviceBean.getName()==null || deviceBean.getName().equals("") ? "N/A" : deviceBean.getName());
      out.write("</a></td>\n\t\t\t\t<td class=\"tddata\">");
      out.print(deviceBean.getIp() != null?deviceBean.getIp():"");
      out.write("</td>\n\t\t\t\t<td class=\"tddata\" align=\"center\">\n\t\t\t\t\t<select name=\"devicetype");
      out.print(deviceBean.getDeviceId());
      out.write('"');
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
      out.print( (deviceBean.getDeviceType()==deviceTypeBean.getDeviceTypeId())?"selected=\"selected\"":"" );
      out.write(' ');
      out.write('>');
      out.print( deviceTypeBean.getTypeName() );
      out.write("</option>\n");

					}
				}

      out.write("\t\t\t\t\t</select>\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\">\n\t\t\t\t\t<input type=\"radio\" name=\"devicestatus");
      out.print(deviceBean.getDeviceId());
      out.write("\" value=\"");
      out.print(DeviceBean.ACTIVE);
      out.write('"');
      out.write(' ');
      out.print(deviceBean.getDeviceStatus()==DeviceBean.ACTIVE || deviceBean.getDeviceStatus()==DeviceBean.NEW ?"checked=\"checked\"":"");
      out.write("  /> ");
      out.print(TranslationHelper.getTranslatedMessge("Active"));
      out.write("&nbsp;&nbsp;\n\t\t\t\t\t<input type=\"radio\" name=\"devicestatus");
      out.print(deviceBean.getDeviceId());
      out.write("\" value=\"");
      out.print(DeviceBean.DEACTIVE);
      out.write('"');
      out.write(' ');
      out.print(deviceBean.getDeviceStatus()==DeviceBean.DEACTIVE?"checked=\"checked\"":"");
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print(TranslationHelper.getTranslatedMessge("Deactive"));
      out.write(" &nbsp;&nbsp;\n\t\t\t\t</td>\n\t\t\t\t\n\t\t\t</tr>\n");

	
		}	
	}
	while(deviceBeanItr.hasNext()){
		deviceBean = (DeviceBean)deviceBeanItr.next();
		if(!allDevices && deviceBean.getDeviceStatus()!=DeviceBean.NEW)
			continue;
		deviceCnt++;
		out.println("<script>addToList("+deviceBean.getDeviceId()+")</script>");
		if(deviceCnt%2 == 0)
	rowStyle = "trdark";
		else 
	rowStyle = "trlight";

      out.write("\n\t\t\t<tr class=\"");
      out.print(rowStyle);
      out.write("\" title=\"");
      out.print(rowTitle[deviceBean.getDeviceStatus()]);
      out.write("\">\n\t\t\t\t<td class=\"tddata\" align=\"center\" title=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete Device"));
      out.write("\"><!-- <img src=\"");
      out.print(request.getContextPath() + "/images/delete.bmp");
      out.write("\" onclick=\"deleteDevice('");
      out.print(deviceBean.getDeviceId());
      out.write("')\" width=\"25px\" height=\"20px\"/> -->\n\t\t\t\t<input type=\"checkbox\" name=\"select\" value=\"");
      out.print(deviceBean.getDeviceId());
      out.write("\"  onclick=\"deselectall()\">\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\" align=\"center\">\n\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath() + "/images/" + statusImg[deviceBean.getDeviceStatus()]);
      out.write("\" height=\"15\" width=\"15\" />\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\"><a class=\"configLink\" href=\"#\" onclick=\"openAddDevice('");
      out.print(deviceBean.getDeviceId());
      out.write("')\" >");
      out.print(deviceBean.getName()==null || deviceBean.getName().equals("") ? "N/A" : deviceBean.getName());
      out.write("</a></td>\n\t\t\t\t<td class=\"tddata\">");
      out.print(deviceBean.getIp() != null?deviceBean.getIp():"");
      out.write("</td>\n\t\t\t\t<td class=\"tddata\" align=\"center\">\n\t\t\t\t\t<select name=\"devicetype");
      out.print(deviceBean.getDeviceId());
      out.write("\" disabled='disabled'>\n");

				DeviceTypeBean deviceTypeBean = null;
				Iterator deviceTypeBeanItr = DeviceTypeBean.getDeviceTypeBeanIterator();
				while(deviceTypeBeanItr.hasNext()){
					deviceTypeBean = (DeviceTypeBean)deviceTypeBeanItr.next();
					if(deviceTypeBean!=null){

      out.write("\t\t\t\t\t<option value=\"");
      out.print( deviceTypeBean.getDeviceTypeId() );
      out.write('"');
      out.write(' ');
      out.print( (deviceBean.getDeviceType()==deviceTypeBean.getDeviceTypeId())?"selected=\"selected\"":"" );
      out.write(' ');
      out.write('>');
      out.print( deviceTypeBean.getTypeName() );
      out.write("</option>\n");

					}
				}

      out.write("\t\t\t\t\t</select>\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\">\n\t\t\t\t\t<input type=\"radio\" name=\"devicestatus");
      out.print(deviceBean.getDeviceId());
      out.write("\" value=\"");
      out.print(DeviceBean.ACTIVE);
      out.write('"');
      out.write(' ');
      out.print(deviceBean.getDeviceStatus()==DeviceBean.ACTIVE || deviceBean.getDeviceStatus()==DeviceBean.NEW ?"checked=\"checked\"":"");
      out.write("  /> ");
      out.print(TranslationHelper.getTranslatedMessge("Active"));
      out.write("&nbsp;&nbsp;\n\t\t\t\t\t<input type=\"radio\" name=\"devicestatus");
      out.print(deviceBean.getDeviceId());
      out.write("\" value=\"");
      out.print(DeviceBean.DEACTIVE);
      out.write('"');
      out.write(' ');
      out.print(deviceBean.getDeviceStatus()==DeviceBean.DEACTIVE?"checked=\"checked\"":"");
      out.write(' ');
      out.write('/');
      out.write('>');
      out.print(TranslationHelper.getTranslatedMessge("Deactive"));
      out.write(" &nbsp;&nbsp;\n\t\t\t\t</td>\n\t\t\t\t\n\t\t\t</tr>\n");

	}
	if(deviceCnt == 0){

      out.write("\n\t\t<tr class=\"trdark\">\n\t\t\t<td class=\"tddata\" colspan=\"5\" align=\"center\">");
      out.print(TranslationHelper.getTranslatedMessge("Device(s) Not Available"));
      out.write("</td>\n\t\t</tr>\n\t\t</table>\n\t\t</td>\n\t</tr>\n");
	} else { 	
      out.write("\n</table>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td>&nbsp;</td>\n\t</tr>\n\t<tr>\n\t\t<td align=\"center\"><input class=\"criButton\" type=\"button\" name=\"Add\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Save"));
      out.write("\" onclick=\"submitForm()\" /></td>\n\t</tr>\n");
	}
	} catch(Exception e){
		CyberoamLogger.appLog.debug("ManageDevice.jsp=>exception:"+e,e);
		
	}
	
	
      out.write("\n\t\n\t</table>\n\t</form>\n\t</div>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n<div class=\"TB_window\" id=\"deviceform\"></div>\n\t\n</body>\n</html>\n");
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
