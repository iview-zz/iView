package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.CheckSession;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.text.MessageFormat;
import java.util.Calendar;
import org.cyberoam.iview.beans.ReportGroupBean;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.ReportGroupRelationBean;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.authentication.beans.UserBean;
import org.cyberoam.iview.authentication.beans.RoleBean;
import java.util.Iterator;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.device.beans.DeviceTypeBean;
import org.cyberoam.iview.utility.iViewInfoClient;

public final class maindashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<html>\n");

	try {	
		if(CheckSession.checkSession(request,response) < 0) {
			return;
		}
		
		int categoryID=Integer.parseInt((String)session.getAttribute("categoryid"));
		int reportGroupID = ReportGroupBean.getMainDashboardReportGroupID(categoryID);
		ArrayList reportList = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportGroupID));
		int reportID = 0;
		if(reportList!= null && reportList.size()>0){
			reportID = ((ReportGroupRelationBean)reportList.get(0)).getReportId();
		}
		session.setAttribute("lastAccess",null);
		DeviceBean.checkForNewDevice();
		boolean isNewDeviceArrived = false;
		UserBean userBean = UserBean.getRecordbyPrimarykey((String)session.getAttribute("username"));
		Iterator deviceBeanItr = DeviceBean.getNewDeviceBeanIterator();
		if(deviceBeanItr.hasNext() && userBean.getRoleId() == RoleBean.SUPER_ADMIN_ROLE_ID  ){
			isNewDeviceArrived = true;
		}

      out.write("\n\n<head>\n\t<title>");
      out.print(iViewConfigBean.TITLE);
      out.write("</title>\n\t\n\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\t \n\t<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n\t<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script>\n\t<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></script>\n\t<script LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></script>\n\t<script LANGUAGE=\"Javascript\">\n\t\twindow.onload = function (evt) {\t\t\t\n\t\t\tsetWidth();\n\t\t}\n\t\tfunction addToList(deviceId){\n\t\t\tdocument.frmdevicemgt.deviceidlist.value += (deviceId + ',');\n\t\t}\n\t\n\t\tfunction submitForm(){\n\t\t\t\n\t\t\tvar deviceIdList = document.frmdevicemgt.deviceidlist.value;\n\t\t\tdeviceIdList = deviceIdList.substring(0,deviceIdList.lastIndexOf(','));\n\t\t\tdeviceIdList = deviceIdList.split(\",\");\n\t\t\tfor(var i=0; i<deviceIdList.length; i++){\n\t\t\t\tif(trim(document.getElementById(\"devicename\"+deviceIdList[i]).value) == ''){\n\t\t\t\t\talert(\"Please enter Device name.\");\n\t\t\t\t\tdocument.getElementById(\"devicename\"+deviceIdList[i]).focus();\n\t\t\t\t\treturn false;\n\t\t\t\t}\n\t\t\t\tif(document.getElementById(\"devicetype\"+deviceIdList[i]).selectedIndex == 0){\n\t\t\t\t\talert(\"Unknown Device Type is not allowed.\");\n\t\t\t\t\treturn false;\n\t\t\t\t}\n\t\t\t}\n\t\t\tif( confirm('Are you sure you want to save changes?') ){\n\t\t\t\tdocument.frmdevicemgt.submit();\n\t\t\t}\n\t\t}\n\t\t\t\t\n\t\tfunction setWidth(){\n\t\t\tvar main_div = document.getElementById(\"main_content\");\n");
      out.write("\t\t\tmain_div.style.width = (document.body.clientWidth - 218);\t\t\t\t\n\t\t}\n\t\t\n\t</script>\t\n</head>\n\n<body onload=\"setWidth()\" onresize=\"setWidth()\">\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write(' ');
      out.write('\n');
      out.write('	');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("\t\t\n\t\n\t<div class = \"maincontent\" id=\"main_content\">\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "Date.jsp" + (("Date.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("device", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("true", request.getCharacterEncoding()), out, true);
      out.write('\n');
      out.write('	');
      out.write('	');
 if(iViewInfoClient.message != null) { 
      out.write("\n\t\t\t<div style=\"color:red;padding-left:5px\">");
      out.print( iViewInfoClient.message);
      out.write("</div>\n\t\t");
} 
      out.write("\n\t\t<div class=\"reporttitlebar\">\t\t\t\n\t\t\t<div class=\"reporttitle\">\n\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Main Dashboard"));
      out.write("\n\t\t\t</div>\n\t\t\t<div class=\"reporttimetitle\">\n\t\t\t\t<b>From:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("startdate"));
      out.write("</font>\n\t\t\t\t</br><b>To:</b> <font class=\"reporttime\">");
      out.print(session.getAttribute("enddate"));
      out.write("</font> \n\t\t\t</div>\n\t\t\t<div class=\"pdflink\">\n\t\t\t\t<a id=\"pdfLinkForGroup\" onclick=\"getPDF('");
      out.print(reportID);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(reportGroupID );
      out.write("')\" >\n\t\t\t\t\t<img src=\"../images/PdfIcon.jpg\" class=\"pdflink\"></img>\n\t\t\t\t</a>\t\t\t\t\n\t\t\t</div>\t\t\t\n\t\t\t\n\t\t\t <div class=\"xlslink\"> \n\t\t\t\t<a id=\"xlsLinkForGroup\" onclick=\"getXLS('");
      out.print(reportID);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(reportGroupID );
      out.write("')\" >\n\t\t\t\t\t<img src=\"../images/csvIcon.jpg\" class=\"xlslink\"></img>\n\t\t\t\t</a>\t\t\t\t\n\t\t\t</div>\t\t\t\n\n\t\t</div>\t\n\n\t\t\n\t\t\t\t\n\t");

	ReportGroupRelationBean reportGroupRelationBean = null; 
	ReportGroupBean reportGroupBean = null;
	MessageFormat queryFormat = null;
	Object[] paramValues = null;
	reportList = null;
	StringTokenizer st = null;
	String timeFrame = null;
	//String paramName = null;
	String startDate = null;
	String endDate = null;
	String limit = null;
	//String title = null;
	String isColumned = "true";
	int order = 0;
	reportID = 0; 
	
	try {			
			reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
			reportList = reportGroupBean.getReportIdByReportGroupId(reportGroupID);

      out.write('\n');

			int lastRowOrder=1;
			CyberoamLogger.appLog.debug("reportList: " + reportList + "\treportList.size(): " + reportList.size());			
			for(int i=0;i<reportList.size();i++){
				reportGroupRelationBean=(ReportGroupRelationBean)reportList.get(i);			  
				reportID=reportGroupRelationBean.getReportId();									
				order=reportGroupRelationBean.getRowOrder();
				
				if(i % 2 == 0) {

      out.write("\n\t\t\t\t\t<div class=\"reportpair\">\n");

				}				
				if(order == 1){

      out.write("\n\t\t\t\t\t<div class=\"dashreport\">\n");

				}else{

      out.write("\t\n\t\t\t\t\t<div class=\"report\">\n");

				}

      out.write("\n\t\t\t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/webpages/dashboardreport.jsp?reportid=" +reportID +"&columned=" + isColumned + "&" + request.getQueryString(), out, true);
      out.write("\n\t\t\t\t</div>\n");

				if (i % 2 != 0) {

      out.write("\n\t    \t\t</div>\n");

               	}				
         	}
		} catch(Exception e) {
			CyberoamLogger.appLog.error("Exception occured in dashboardreportgroup.jsp: " + e, e);
		}

      out.write("\t\t\n\t\t\t\t</div>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write('\n');
      out.write('	');
      out.write('	');
 if(isNewDeviceArrived){ 
      out.write("\n\t\n\t<div id=\"TB_overlay\" class=\"TB_overlayBG\"></div>\n\t<div class=\"TB_window\" id=\"newdeviceform\" style=\"display:block;top: 100px\">\n\t<FORM method=\"POST\" name=\"frmdevicemgt\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\">\n\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.MANAGE_DEVICE);
      out.write("\">\n\t<input type=\"hidden\" name=\"deviceidlist\" value=\"\">\n\t<input type=\"hidden\" name=\"deviceid\" value=\"\">\n\t<table cellpadding=\"2\" cellspacing=\"0\" width=\"100%\" border=\"0\">\t\n\t\t<tr class=\"innerpageheader\">\n\t\t\t<td width=\"3%\">&nbsp;</td>\n\t\t\t<td class=\"contHead\">New Device(s) Found</td>\n\t\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleThickBox('2','newdeviceform')\" style=\"cursor: pointer;\">\n\t\t\t</td>\n\t\t</tr>\n\t</table>\n\t<div style=\"margin:5px\" align=\"center\">\n\t<div style=\"width:100%;border:1px solid #999999;\">\n\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"TableData\">\n\t<tr>\n\t\t<td class=\"tdhead\" width=\"30%\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Name"));
      out.write("</td>\n\t\t<td class=\"tdhead\" width=\"30%\">");
      out.print(TranslationHelper.getTranslatedMessge("IP Address"));
      out.write("</td>\n\t\t<td class=\"tdhead\" width=\"30%\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Type"));
      out.write("</td>\n\t\t<td class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Status"));
      out.write("</td>\n\t</tr>\n");

	
	DeviceBean deviceBean = null;
	int deviceCnt = 0;
	String rowStyle = "trdark";
	
	while(deviceBeanItr.hasNext()){
		deviceBean = (DeviceBean)deviceBeanItr.next();
		if(deviceBean==null ||  deviceBean.getDeviceStatus()!=DeviceBean.NEW)
			continue;
		deviceCnt++;
		out.println("<script>addToList("+deviceBean.getDeviceId()+")</script>");
		if(deviceCnt%2 == 0)
			rowStyle = "trdark";
		else 
			rowStyle = "trlight";

      out.write("\n\t<tr class=\"");
      out.print(rowStyle);
      out.write("\">\n\t\t<td class=\"tddata\"><input type=\"text\" id=\"devicename");
      out.print(deviceBean.getDeviceId());
      out.write("\" name=\"devicename");
      out.print(deviceBean.getDeviceId());
      out.write("\"></td>\n\t\t<td class=\"tddata\">");
      out.print(deviceBean.getIp() != null?deviceBean.getIp():"");
      out.write("</td>\n\t\t\n\t\t<td class=\"tddata\" align=\"center\">\n\t\t\t<select name=\"devicetype");
      out.print(deviceBean.getDeviceId());
      out.write("\" id=\"devicetype");
      out.print(deviceBean.getDeviceId());
      out.write("\">\n\t\t\t\t<option value=\"-1\" selected=\"selected\">UNKNOWN</option>\n");

				DeviceTypeBean deviceTypeBean = null;
				Iterator deviceTypeBeanItr = DeviceTypeBean.getDeviceTypeBeanIterator();
				while(deviceTypeBeanItr.hasNext()){
					deviceTypeBean = (DeviceTypeBean)deviceTypeBeanItr.next();
					if(deviceTypeBean!=null){

      out.write("\t\t\t\t\t<option value=\"");
      out.print( deviceTypeBean.getDeviceTypeId() );
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print( deviceTypeBean.getTypeName() );
      out.write("</option>\n");

					}
				}

      out.write("\t\t\t</select>\n\t\t</td>\n\t\t<td class=\"tddata\">\n\t\t\t<input type=\"radio\" name=\"devicestatus");
      out.print(deviceBean.getDeviceId());
      out.write("\" value=\"");
      out.print(DeviceBean.ACTIVE);
      out.write("\" checked=\"checked\"/>");
      out.print(TranslationHelper.getTranslatedMessge("Active"));
      out.write("&nbsp;&nbsp;\n\t\t\t<input type=\"radio\" name=\"devicestatus");
      out.print(deviceBean.getDeviceId());
      out.write("\" value=\"");
      out.print(DeviceBean.DEACTIVE);
      out.write("\" />");
      out.print(TranslationHelper.getTranslatedMessge("Deactive"));
      out.write(" &nbsp;&nbsp;\n\t\t</td>\n\t</tr>\n");

	}

      out.write("\n\t<tr><td colspan=\"4\">&nbsp;</td></tr>\n\t</table>\n\t</div>\n\t</div>\n\t<table align=\"center\">\n\t<tr>\n\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t<input class=\"criButton\" type=\"button\" name=\"Add\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Save"));
      out.write("\" onclick=\"submitForm()\" />\n\t\t</td>\n\t</tr>\n\t</table>\n\t\n</form>\n<script>\n\tgetWinSize(\"newdeviceform\");\n</script>\n\t\n\t</div>\n\t</div>\n");
  }
      out.write("\n\n\n</body>\n</html>\n");

		}
		catch(Exception e) {
		CyberoamLogger.appLog.error("Exception: " + e, e);
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
