package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.authentication.beans.RoleBean;
import org.cyberoam.iview.modes.ApplicationModes;
import java.util.Iterator;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.device.beans.DeviceGroupBean;
import org.cyberoam.iview.device.beans.DeviceGroupRelationBean;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import org.cyberoam.iview.beans.CategoryBean;
import java.util.ArrayList;
import org.cyberoam.iview.audit.CyberoamLogger;

public final class managedevicegroup_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<html>\n<head>\n");

	if(CheckSession.checkSession(request,response) < 0) return;
	try{
	

      out.write('\n');

		int catId=Integer.parseInt(session.getAttribute("categoryid").toString());		
		DeviceBean deviceBean = null;
		String deviceList="[";
		
		String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(Integer.parseInt(session.getAttribute("categoryid").toString()));
		
		if(deviceIds!= null && deviceIds.length > 0){
			for(int i=0;i<deviceIds.length;i++){
				deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));				
				deviceList += "\""+deviceBean.getName()+"|"+deviceBean.getDeviceId()+"\",";
			}
			deviceList = deviceList.substring(0,deviceList.length()-1);
		}
		
		deviceList += "]";		
	
      out.write("\n\t\n\n<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/popup.css\">\n<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popup.js\"></script>\n<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></script>\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script language=\"JavaScript\" src=\"/javascript/cyberoam.js\"></script>\n<script language=\"JavaScript\"> \n\twindow.onload = function (evt) {\n\t\tsetWidth();\t\t\t\t\n\t}\t\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 220);\t\n\t}\n\t\n\t\n\tfunction openAddDeviceGroup(id,deviceList){\n\t\tdeviceListJS = ");
      out.print(deviceList);
      out.write(";\n\t\tif(id == ''){\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/newdevicegroup.jsp';\n\t\t} else {\t\t\t\n\n\t\t\tvar devList= deviceList.split(\",\");\n\t\t\tdeviceListJS=devList;\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/newdevicegroup.jsp?devicegroupname='+id;\n\t\t}\n\t\thandleThickBox(1,'devicegroup','450');\n\t\t//top.sourceWindow=window.open(reqloc,'_person','width=570,height=480,titlebar=no,scrollbars=yes');\n\t}\n\t\n\tfunction initdevicegroup(){\n\t\tvar selval = document.getElementById(\"selecteddevice\").value;\n\t\tif(selval != \"\"){\n\t\t\tselval = selval.split(\",\");\n\t\t\tcreatePopUp(\"devicelist\",[\"Device|1|0\"],'Device',selval);\n\t\t}else{\n\t\t\tcreatePopUp(\"devicelist\",[\"Device|1|0\"]);\n\t\t} \n\t}\n\n\tfunction showHideDeviceInfo(){\n\t\tvar role = document.getElementById('role');\n\t\tvar selIndex = role.selectedIndex;\n\t\tif(role.options[selIndex].text == 'Admin'){\n\t\t\tdocument.getElementById('deviceinfo').style.display='none';\n\t\t}else{\n\t\t\tdocument.getElementById('deviceinfo').style.display='';\n\t\t}\n\t}\n\n\tfunction selectall(){\n\t\tvar chk = document.getElementById(\"check1\");\n\t\tvar checkstmp = document.getElementsByName(\"devicegroupids\");\n\t\tvar i;\n\t\tfor(i=0;i<checkstmp.length;i++){\n\t\t\tif(chk.checked==true){\n\t\t\t\tcheckstmp[i].checked=true;\n\t\t\t}\n\t\t\telse{\n\t\t\t\tcheckstmp[i].checked=false;\n");
      out.write("\t\t\t}\n\t\t}\n\t}\n\n\tfunction deselectall(){\n\t\tvar chk = document.getElementById(\"check1\");\n\t\tvar checkstmp = document.getElementsByName(\"devicegroupids\");\n\t\tvar i;\n\t\tfor(i=0;i<checkstmp.length;i++){\n\t\t\tif(checkstmp[i].checked==false){\n\t\t\t\tchk.checked=false;\n\t\t\t\tbreak;\n\t\t\t}\n\t\t}\n\t}\n\n\tfunction validateFrom(){\n\t\treExp = new RegExp(\"^[0-9a-zA-Z][0-9a-zA-Z_.@]*$\");\n\t\tnameReExp = new RegExp(\"^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$\");\n\t\temailExp = /^\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)*@\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)+$/ ;\n\t\tform=document.registrationform;\n\t\tvar isUpdate = false;\n\t\t\n\t\tif(document.getElementById(\"operation\").value == 'update'){\n\t\t\tisUpdate = true;\n\t\t}\n\t\t\n\t\tif (document.registrationform.grpname.value == ''){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Device Group Name"));
      out.write("');\n\t\t\tdocument.registrationform.grpname.focus();\n\t\t\treturn false;\n\t\t}else if (!nameReExp.test(document.registrationform.name.value)){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Device Group Name"));
      out.write("\");\n\t\t\tdocument.registrationform.name.focus();\n\t\t\treturn false;\n\t\t}\n\t\t\n \n\t\t//if(document.registrationform.role.value != '");
      out.print(RoleBean.ADMIN_ROLE_ID);
      out.write("' ){\n\t\tvar selecteddevice = getCheckedIds(\"devicelist\");\n\t\tif(selecteddevice == ''){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Select atleast one device."));
      out.write("\");\n\t\t\treturn false;\t\t\t\n\t\t}else {\n\t\t\tdocument.getElementById(\"selecteddevice\").value = selecteddevice;\n\t\t}\n\t\t//}\n\t\tif(isUpdate == true){\n\t\t\tform.appmode.value = '");
      out.print(ApplicationModes.UPDATE_DEVICE_GROUP);
      out.write("';\n\t\t\tcon = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to update the Device Group?"));
      out.write("\");\n\t\t}else {\n\t\t\tcon = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to add the Device Group?"));
      out.write("\");\n\t\t}\n\t\treturn con;\n\t}//function validate form ends here\n\t\n\tfunction selectDevices(direction){\n\t\tvar src;\n\t\tvar dst;\n\t\tif(direction == 'right'){\n\t\t\tsrc = document.getElementById('availabledevices');\n\t\t\tdst = document.getElementById('selecteddevices');\n\t\t}else{\n\t\t\tdst = document.getElementById('availabledevices');\n\t\t\tsrc = document.getElementById('selecteddevices');\n\t\t}\n\t\t\n\t\tfor(i=src.length-1;i>=0;i--) {\n\t\t\tif(src[i].selected==true) {\n\t\t\t\tln=dst.length;\n\t\t\t\tdst.options[ln]=new Option(src.options[i].text,src.options[i].value,false,false);\n\t\t\t\tsrc.options[i]=null;\n\t\t\t}\n\t\t}\t\n\t}\n\t\n\tfunction getRecord(id){\n\t\tif(id==\"Device\"){\n\t\t\treturn data = deviceListJS;\n\t\t}\n\t}\n\t\n\tfunction validateDelete(){\n\t\telements = document.managedevicegroup.elements;\n\t\tflag = false ;\n\t\tfor( i=0,j=elements.length ; i < j ; i++ ){\n\t\t\tif(elements[i].name == \"devicegroupids\"){\n\t\t\t\tif( elements[i].checked == true ){\n\t\t\t\t\tflag = true ;\n\t\t\t\t\tbreak;\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t\tif(!flag){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("You must select atleast one Device Group"));
      out.write("\");\n\t\t\treturn false;\n\t\t}\n\t\tvar con = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected Device Group(s)?"));
      out.write("\");\n\t\tif (! con ){ \n\t\t\treturn false ;\n\t\t}\n\t\tdocument.managedevicegroup.submit();\n\t}\n\t\n\tfunction getDevicesByCategory()\n\t{\n\t\tvar id=document.getElementById(\"catId\").value;\n\t\tvar selval=document.getElementById(\"devicelist\");\n\t\tvar div=document.getElementById(\"popupdevicelist\").parentNode;\n\t\tvar olddiv=document.getElementById(\"popupdevicelist\");\n\t\tdiv.removeChild(olddiv);\t\t\n\t\tselval.innerHTML=\"\";\t\t\t\n\t\t\n\t\tvar devList;\n\t\tvar cnt;\n");

		Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
		CategoryBean categoryBean= null;
		while(categoryBeanItr.hasNext()){	
			categoryBean = (CategoryBean)categoryBeanItr.next();

      out.write("\n\t\t\tif(id == ");
      out.print(categoryBean.getCategoryId());
      out.write("){\n\t\t\t\t\t\t\t\n\t\t\t\tdevList=new Array();\n\t\t\t\tcnt=0;\n");
				
				deviceIds = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryBean.getCategoryId());									
				if(deviceIds!= null && deviceIds.length > 0){
					for(int i=0;i<deviceIds.length;i++){
						deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));					

      out.write("\n\t\t\t\t\t\tdevList[cnt++] = \"");
      out.print(deviceBean.getName());
      out.write('|');
      out.print(deviceBean.getDeviceId());
      out.write('"');
      out.write(';');
      out.write('\n');
				
					}					
				}

      out.write("\n\t\t\t}\t\t\t\t\t\t\t\n");
		} 	
      out.write("\t\n\t\tdeviceListJS = devList;\n\t\tinitdevicegroup();\t\t\t\t\t\n\t}\n\n</script>\n</head>\n<body>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("\n<div class = \"maincontent\" id=\"main_content\">\n\t<div class=\"reporttitlebar\">\t\n\t\t<div class=\"reporttitlebarleft\"></div>\t\t\t\t\n\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Group Management"));
      out.write("</div>\t\t\t\n\t</div>\t\t\n\t<br><br>\t\n\t\n\t\t\n\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=post name=managedevicegroup >\n\t\n\t<input type=hidden name=appmode value=");
      out.print(ApplicationModes.DELETE_DEVICE_GROUP);
      out.write(">\n\t\n\t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"margin-bottom: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td align=\"left\" class=\"ButtonBack\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Add"));
      out.write("\" onClick=\"openAddDeviceGroup('');\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete"));
      out.write("\" onClick=\"return validateDelete();\">\n\t\t</td>\n\t</tr>\n\t</table>\n\t\n\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td>\n\t\t\t<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\" class=\"TableData\">\n");

	if(session.getAttribute("pmessage") != null){

      out.write("\n\t\t\t<tr><td colspan=7 align=\"left\" class=\"posimessage\">");
      out.print(session.getAttribute("pmessage"));
      out.write("</td></tr>\n");

	session.removeAttribute("pmessage");
	}

      out.write('\n');

	if(session.getAttribute("nmessage") != null){

      out.write("\n\t\t\t<tr><td colspan=7 align=\"left\" class=\"nagimessage\">");
      out.print(session.getAttribute("nmessage"));
      out.write("</td></tr>\n");

	session.removeAttribute("nmessage");
	}

      out.write("\n\t\t\t<tr>\n\t\t\t\t<td align=\"center\" class=\"tdhead\"><input type=checkbox id=\"check1\" name=\"check1\" onClick=\"selectall()\"></td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Group"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Description"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Name(s)"));
      out.write("</td>\n\t\t\t</tr>\n\t\t\t\n");

				Iterator itrDeviceGroup = DeviceGroupBean.getDeviceGroupBeanIterator();
				DeviceGroupBean deviceGroupBean = null;
				DeviceGroupRelationBean deviceGroupRelationBean = new DeviceGroupRelationBean();
				ArrayList deviceListArray = null;			
				String strDeviceList = "";
				int deviceGrpNum = 0;
				boolean oddRow = false;
				String rowStyle = "trdark";
				
				while(itrDeviceGroup.hasNext()){
					deviceGrpNum++;
					oddRow = !oddRow;
					if(oddRow)
						rowStyle = "trdark";
					else
						rowStyle = "trlight";				
					
					strDeviceList = "";
					deviceGroupBean = (DeviceGroupBean) itrDeviceGroup.next();
					catId=deviceGroupBean.getCategoryID();
										
					deviceBean = null;
					deviceList="";					
					deviceIds = UserCategoryDeviceRelBean.getDeviceIdListForCategory(catId);					
					if(deviceIds!= null && deviceIds.length > 0){												
						for(int i=0;i<deviceIds.length;i++){							
							deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));						
							deviceList += deviceBean.getName()+"|"+deviceBean.getDeviceId()+",";							
						}
						deviceList = deviceList.substring(0,deviceList.length()-1);						
					}			
					
					deviceListArray = DeviceGroupRelationBean.getRelationByGroupID(deviceGroupBean.getGroupID());
									
					for(int i = 0;i< deviceListArray.size();i++) {					
						deviceGroupRelationBean = (DeviceGroupRelationBean) deviceListArray.get(i);
						strDeviceList += DeviceBean.getRecordbyPrimarykey(deviceGroupRelationBean.getDeviceID()).getName() + ",";
					}
					
			
      out.write("\n\t\t\t\t<tr class=\"");
      out.print(rowStyle);
      out.write("\">\n\t\t\t\t\t<td align=\"center\" class=\"tddata\" ><input type=checkbox name=\"devicegroupids\" value=\"");
      out.print(deviceGroupBean.getGroupID());
      out.write("\" onClick=\"deselectall()\" ></td>\n\t\t\t\t\t<td align=\"left\" class=\"tddata\">\n\t\t\t\t\t<a title=\"Edit Device Group\" class=\"configLink\" href=\"#\" onclick=openAddDeviceGroup('");
      out.print(deviceGroupBean.getGroupID());
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(deviceList);
      out.write("') >");
      out.print(deviceGroupBean.getName());
      out.write("</a>\t\t\t\t\n\t\t\t\t\t</td>\t\t\t\t\n\t\t\t\t\t<td align=\"left\" class=\"tddata\"> ");
      out.print(deviceGroupBean.getDescription());
      out.write(" </td>\n\t\t\t\t\t<td align=\"left\" class=\"tddata\">");
      out.print(strDeviceList!=""?strDeviceList.substring(0,(strDeviceList.length()-1)):"");
      out.write("</td>\n\t\t\t\t</tr>\n\t\t\t\t");

					} 
				if(deviceGrpNum == 0){

      out.write("\n\t\t\t\t<tr class=\"trdark\">\n\t\t\t\t\t<td class=\"tddata\" colspan=\"4\" align=\"center\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Group(s) Not Available"));
      out.write("</td>\n\t\t\t\t</tr>\n");
				}	
      out.write("\n\t\t\t\t</table>\n\t\t</td>\n\t</tr>\n\t</table>\n\t\n\t</form>\t\t\n</div>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n<div class=\"TB_window\" id=\"devicegroup\"></div>\n</body>\n</html>\n\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in managedevicegroup.jsp : "+e,e);
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
