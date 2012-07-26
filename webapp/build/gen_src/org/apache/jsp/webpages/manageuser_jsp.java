package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import org.cyberoam.iview.utility.*;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.authentication.beans.UserBean;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.authentication.beans.RoleBean;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import java.text.SimpleDateFormat;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.device.beans.DeviceGroupBean;
import org.cyberoam.iview.device.beans.DeviceGroupRelationBean;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;

public final class manageuser_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

	if(CheckSession.checkSession(request,response) < 0) return;
	try{		
		String userName=(String)session.getAttribute("username");
		int roleID=UserBean.getRecordbyPrimarykey(userName).getRoleId();	
		DeviceBean deviceBean = null;
		int userId = UserBean.getRecordbyPrimarykey(userName).getUserId();
				
		String deviceList="[";
		String strDeviceList[] = UserCategoryDeviceRelBean.getDeviceIdListForUser(userId);				
		if(strDeviceList != null && strDeviceList.length > 0){
			for(int i = 0; i<strDeviceList.length; i++){
				deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList[i]));
				if(deviceBean !=null)
					deviceList += "\""+deviceBean.getName()+"|"+deviceBean.getDeviceId()+"\",";
			}
		}
		
		DeviceGroupBean deviceGroupBean = null;
		String deviceGroupList="[";
		String strDeviceGroupList[] = UserCategoryDeviceRelBean.getDeviceGroupIdListForUser(userId);
		if(strDeviceGroupList != null && strDeviceGroupList.length > 0){
			for(int i = 0; i<strDeviceGroupList.length; i++){
				deviceGroupBean = DeviceGroupBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceGroupList[i]));				
				if(deviceGroupBean !=null)
					deviceGroupList += "\""+deviceGroupBean.getName()+"|"+deviceGroupBean.getGroupID()+"\",";
			}
		}
		
		if(!"[".equals(deviceList))
			deviceList = deviceList.substring(0,deviceList.length()-1) + "]";
		else 
			deviceList = deviceList + "]";
		
		if(!"[".equals(deviceGroupList))
			deviceGroupList = deviceGroupList.substring(0,deviceGroupList.length()-1) + "]";
		else 
			deviceGroupList = deviceGroupList + "]";		

      out.write("\n<html>\n<head>\n<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/popup.css\">\n<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popup.js\"></script>\n<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></script>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script language=\"JavaScript\"> \n\tvar deviceList = null;\n\twindow.onload = function (evt) {\n\t\tsetWidth();\t\t\t\t\n\t}\t\n\tvar URL = \"\";\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 218);\t\n\t}\n\tre = /\\w{1,}/;\t\n\t\n\tfunction selectall(obj){ \n\t\tvar chk = document.getElementById(\"check1\");\n\t\tvar checkstmp = document.getElementsByName(\"usernames\");\n\t\tvar i;\n\t\tfor(i=0;i<checkstmp.length;i++){\n\t\t\tif(chk.checked==true){\n\t\t\t\tcheckstmp[i].checked=true;\n\t\t\t}\n\t\t\telse{\n\t\t\t\tcheckstmp[i].checked=false;\n\t\t\t}\n\t\t}\n\t} \n\n\tfunction deselectall(){\n\t\tvar chk = document.getElementById(\"check1\");\n\t\tvar checkstmp = document.getElementsByName(\"usernames\");\n\t\tvar i;\n\t\tfor(i=0;i<checkstmp.length;i++){\n\t\t\tif(checkstmp[i].checked==false){\n\t\t\t\tchk.checked=false;\n\t\t\t\tbreak;\n\t\t\t}\n\t\t}\n\t}\n\t\n\tfunction validateDelete(){\n\t\telements = document.manageactiveusers.elements;\n\t\tflag = false ;\n\t\tfor( i=0,j=elements.length ; i < j ; i++ ){\n");
      out.write("\t\t\tif(elements[i].name == \"usernames\"){\n\t\t\t\tif( elements[i].checked == true ){\n\t\t\t\t\tflag = true ;\n\t\t\t\t\tbreak;\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t\tif(!flag){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("You must select atleast one user"));
      out.write("\");\n\t\t\treturn false;\n\t\t}\n\t\tvar con = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected User(s)?"));
      out.write("\");\n\t\tif (! con ){ \n\t\t\treturn false ;\n\t\t}\n\t\tdocument.manageactiveusers.submit();\n\t}\n\t\n\tfunction openAddUser(id){\n\t\tdeviceListJS = ");
      out.print(deviceList);
      out.write(";\n\t\tdevicdGroupListJS = ");
      out.print(deviceGroupList);
      out.write(";\t\t\n\t\tif(id == ''){\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/newuser.jsp';\n\t\t} else {\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/newuser.jsp?username='+id;\n\t\t}\n\t\thandleThickBox(1,'user','450',\"10\");\n\t}\n\tfunction inituser(){\n\t\tvar\tselval = document.getElementById(\"selecteddevices\").value;\n\t\tvar selgroupval = document.getElementById(\"selectedgroups\").value;\n\t\tif(selval != \"\"){\n\t\t\tselval = selval.split(\",\");\n\t\t\tcreatePopUp(\"devicelist\",[\"Device|1|0\",\"Device Group|1|0\"],'Device',selval);\n\t\t} else if(selgroupval != \"\") {\n\t\t\tselgroupval = selgroupval.split(\",\");\n\t\t\tcreatePopUp(\"devicelist\",[\"Device|1|0\",\"Device Group|1|0\"],'Device Group',selgroupval);\n\t\t}else{\n\t\t\tcreatePopUp(\"devicelist\",[\"Device|1|0\",\"Device Group|1|0\"]);\n\t\t} \n\t}\n\tre = /\\w{1,}/;\n\tuserNameCheck= /^\\w+(\\w+)*(\\.\\w+(\\w+)*)*$/ ;\n\t\n\tfunction validateFrom(){\n\t\treExp = new RegExp(\"^[0-9a-zA-Z][0-9a-zA-Z_.@]*$\");\n\t\tnameReExp = new RegExp(\"^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$\");\n\t\temailExp = /^\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)*@\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)+$/ ;\n\t\tform=document.registrationform;\n\t\tvar isUpdate = false;\n\t\tif(document.getElementById(\"operation\").value == 'update'){\n\t\t\tisUpdate = true;\n");
      out.write("\t\t}\n\t\tif (document.registrationform.name.value == ''){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Name"));
      out.write("');\n\t\t\tdocument.registrationform.name.focus();\n\t\t\treturn false;\n\t\t}else if (!nameReExp.test(document.registrationform.name.value)){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Name"));
      out.write("\");\n\t\t\tdocument.registrationform.name.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(isUpdate == false){\n\t\t\tif (!(re.test(document.registrationform.username.value))){\n\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Username"));
      out.write("');\n\t\t\t\tdocument.registrationform.username.focus();\n\t\t\t\treturn false;\n\t\t\t}else if (!reExp.test(document.registrationform.username.value)){\n\t\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@' and '.' allowed in username"));
      out.write("\");\n\t\t\t\tdocument.registrationform.username.focus();\n\t\t\t\treturn false;\n\t\t\t}\n\t\t\tif (document.registrationform.passwd.value == ''){\n\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Password"));
      out.write("');\n\t\t\t\tdocument.registrationform.passwd.focus();\n\t\t\t\treturn false;\n\t\t\t}\n\t\t\tif (document.registrationform.passwd.value != document.registrationform.confirmpasswd.value){\n\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("The passwords you typed do not match"));
      out.write("');\n\t\t\t\tdocument.registrationform.confirmpasswd.focus();\n\t\t\t\treturn false;\n\t\t\t}\n\t\t}\n\t\tif(document.registrationform.email.value == ''){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter email address"));
      out.write("');\n\t\t\tdocument.registrationform.email.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(!(emailExp.test(document.registrationform.email.value))){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("Invalid Email Address"));
      out.write("');\n\t\t\tdocument.registrationform.email.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(document.registrationform.role.value != ");
      out.print( RoleBean.SUPER_ADMIN_ROLE_ID );
      out.write("){\n\t\t\tvar selecteddevice = getCheckedIds(\"devicelist\");\n\t\t\tif(selecteddevice == ''){\n\t\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Select atleast one device."));
      out.write("\");\n\t\t\t\treturn false;\t\t\t\n\t\t\t}else {\n\t\t\t\tdocument.getElementById(\"selecteddevices\").value = selecteddevice;\n\t\t\t}\n\t\t}\n\t\t\n\t\tif(isUpdate == true){\n\t\t\tform.appmode.value = '");
      out.print(ApplicationModes.UPDATEUSER);
      out.write("';\n\t\t\tcon = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to update User information?"));
      out.write("\");\n\t\t} else {\n\t\t\tcon = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to add the User?"));
      out.write("\");\n\t\t}\n\t\tif(con){\n\t\t\tdocument.registrationform.username.disabled = false;\n\t\t}\n\t\treturn con;\n\t}//function validate form ends here\n\n\tfunction showHideDeviceInfo(){\n\t\tvar role = document.getElementById('role');\n\t\tvar selIndex = role.selectedIndex;\n\t\tif(role.options[selIndex].text == 'Admin'){\n\t\t\tdocument.getElementById('deviceinfo').style.display='none';\n\t\t}else{\n\t\t\tdocument.getElementById('deviceinfo').style.display='';\n\t\t}\n\t}\n\n\tfunction selectDevices(direction){\n\t\tvar src;\n\t\tvar dst;\n\t\tif(direction == 'right'){\n\t\t\tsrc = document.getElementById('availabledevices');\n\t\t\tdst = document.getElementById('selecteddevices');\n\t\t}else{\n\t\t\tdst = document.getElementById('availabledevices');\n\t\t\tsrc = document.getElementById('selecteddevices');\n\t\t}\n\t\t\n\t\tfor(i=src.length-1;i>=0;i--) {\n\t\t\tif(src[i].selected==true) {\n\t\t\t\tln=dst.length;\n\t\t\t\tdst.options[ln]=new Option(src.options[i].text,src.options[i].value,false,false);\n\t\t\t\tsrc.options[i]=null;\n\t\t\t}\n\t\t}\t\n\t}\n\tfunction getRecord(id){\n\t\tif(id==\"Device\"){\n\t\t\treturn data = deviceListJS;\n");
      out.write("\t\t}\n\t\tif(id==\"Device Group\"){\n\t\t\treturn data = devicdGroupListJS;\n\t\t}\n\t}\n\t\t\n</script>\n</head>\n<body>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("  \n\t<div class=\"maincontent\" id=\"main_content\">\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("User Management"));
      out.write("</div>\n\t\t</div>\n\t\t<br /><br />\n\t\t\n\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=post name=manageactiveusers >\n\t<input type=hidden name=appmode value=\"");
      out.print(ApplicationModes.DELETEUSER);
      out.write("\">\n\t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"margin-bottom: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td align=\"left\" class=\"ButtonBack\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Add"));
      out.write("\" onClick=\"openAddUser('');\">\n\t\t\t<input class=\"criButton\" type=button value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete"));
      out.write("\" onClick=\"return validateDelete();\">\n\t\t</td>\n\t</tr>\n\t</table>\n\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td>\n\t\t\t<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\" class=\"TableData\">\n");

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

      out.write("\n\t\t\t<tr>\n\t\t\t\t<td align=\"center\" class=\"tdhead\"><input type=checkbox name=\"check1\" id=\"check1\" onClick=\"selectall(this)\"></td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Username"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Name"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Role"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Email"));
      out.write("</td>\t\t\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Created By"));
      out.write("</td> \n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Last Login Time"));
      out.write("</td>\n\t\t\t</tr>\n");

	Iterator itrUser = UserBean.getUserBeanIterator();
	UserBean userBean = null;
	RoleBean roleBean = null;
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy h:mm:ss a");
	boolean oddRow = false;
	String rowStyle = "trdark";
	while(itrUser.hasNext()){
		oddRow = !oddRow;
		if(oddRow)
			rowStyle = "trdark";
		else
			rowStyle = "trlight";
		userBean = (UserBean) itrUser.next();
		
		if(roleID != RoleBean.SUPER_ADMIN_ROLE_ID && !userName.equalsIgnoreCase(userBean.getUserName()) && userBean.getRoleId() != RoleBean.VIEWER_ROLE_ID)		
			continue;
		
			

      out.write("\n\t\t\t<tr class=\"");
      out.print( rowStyle );
      out.write('"');
      out.write('>');
      out.write('\n');

		if(userBean.getUserId() == 1 || userBean.getUserName().equals(session.getAttribute("username").toString())){

      out.write("\n\t\t\t\t<td class=\"tddata\" align=\"center\"><input type=checkbox disabled=\"disabled\" name=userIds value=\"");
      out.print(userBean.getUserId());
      out.write("\" ></td>\n");

		}else{

      out.write("\n\t\t\t\t<td class=\"tddata\" align=\"center\"><input type=checkbox id=\"usernames\" name=usernames value=\"");
      out.print(userBean.getUserName());
      out.write("\" onclick=\"deselectall()\"></td>\n");
		} 
      out.write("\n\t\t\t\t<td class=\"tddata\">\n\t\t\t\t\t<a title=\"Edit User\" class=\"configLink\" href=\"#\" onclick=\"openAddUser('");
      out.print(userBean.getUserName() );
      out.write("')\" >");
      out.print(userBean.getUserName() );
      out.write("</a>\n\t\t\t\t</td>\n\t\t\t\t<td class=\"tddata\">");
      out.print(userBean.getName() );
      out.write("</td>\n\t\t\n");

		roleBean = RoleBean.getRecordbyPrimarykey(userBean.getRoleId());

      out.write("\n\t\t\t\t<td class=\"tddata\">");
      out.print(roleBean.getRoleName() );
      out.write("</td>\n\t\t\t\t<td class=\"tddata\">");
      out.print(userBean.getEmail() );
      out.write("</td>\n\t\t\t\t<td class=\"tddata\">");
      out.print(userBean.getCreatedBy() );
      out.write("</td>\n\t\t\t\t<td class=\"tddata\">");
      out.print(userBean.getLastLoginTime() == null ? "--NA--":simpleDateFormat.format(userBean.getLastLoginTime()) );
      out.write("</td>\n\t\t\t</tr>\n");
	
	}	
      out.write("\n\t\t\t</table>\n\t\t</td>\n\t</tr>\n\t</table>\n\t</form>\n</div>\t\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n<div class=\"TB_window\" id=\"user\"></div>\n</body>\n</html>\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.debug("manageuser.jsp : "+e,e);
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
