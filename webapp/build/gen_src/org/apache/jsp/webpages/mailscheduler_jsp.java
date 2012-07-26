package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.beans.CategoryBean;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import java.util.ArrayList;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.beans.MailScheduleBean;
import java.util.Iterator;
import org.cyberoam.iview.beans.ReportGroupBean;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import org.cyberoam.iview.beans.CategoryReportGroupRelationBean;
import org.cyberoam.iview.beans.BookmarkGroupBean;
import org.cyberoam.iview.beans.BookmarkBean;

public final class mailscheduler_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n");

	if(CheckSession.checkSession(request,response) < 0) return;

	try{		
		String[] weekdays = {"","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
		String msg = "", msgType = "posimessage";
		String strAppMode = request.getParameter("appmode");
		String strStatus = request.getParameter("status");
		int iAppmode=-1 ,iStatus=-1;
				
		if(strAppMode != null && !strAppMode.equalsIgnoreCase("")){
			iAppmode = Integer.parseInt(strAppMode);
		}
		if(strStatus != null && !strAppMode.equalsIgnoreCase("")){
			iStatus = Integer.parseInt(strStatus);
		}
		if(iAppmode>-1){
			if(iAppmode == ApplicationModes.ADD_MAIL_SCHEDULER && iStatus > 0){
				msg = TranslationHelper.getTranslatedMessge("Report Notification Added Successfully.");
			}else if(iAppmode == ApplicationModes.ADD_MAIL_SCHEDULER && iStatus <= 0){
				msg = TranslationHelper.getTranslatedMessge("Error in Report Notification Adding.");
				msgType = "nagimessage";
			}else if(iAppmode == ApplicationModes.UPDATE_MAIL_SCHEDULER && iStatus > 0){
				msg = TranslationHelper.getTranslatedMessge("Report Notification Updated Successfully.");
				msgType = "posimessage";
			}else if(iAppmode == ApplicationModes.UPDATE_MAIL_SCHEDULER && iStatus <= 0){
				msg = TranslationHelper.getTranslatedMessge("Error in Report Notification Updating Adding.");
				msgType = "nagimessage";
			}else if(iAppmode == ApplicationModes.DELETE_MAIL_SCHEDULER && iStatus > 0){
				msg = iStatus +" "+TranslationHelper.getTranslatedMessge("Report Notification(s) Deleted Successfully.");
				msgType = "posimessage";
			}else if(iAppmode == ApplicationModes.DELETE_MAIL_SCHEDULER && iStatus <= 0){
				msg = TranslationHelper.getTranslatedMessge("Error in Report Notification Deleting.");
				msgType = "nagimessage";
			}
		}
		
		

      out.write("\n\n\n\n\n\n\n\n\n\n\n\n<html>\n<head>\n<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></script>\n<script language=\"JavaScript\"> \n\tre = /\\w{1,}/;\n\tuserNameCheck= /^\\w+(\\w+)*(\\.\\w+(\\w+)*)*$/ ;\n\twindow.onload = function (evt) {\n\t\tsetWidth();\t\n\t\tgetWinSize();\t\t\t\t\t\n\t}\t\n\n\tvar URL = \"\";\n\tvar deviceArr;\n\t\n\tvar dHourObj = null;\n\tvar dScheduleForObj = null;\n\tvar dFromHourObj = null;\n\tvar dToHourObj = null;\n\tvar objDateOfMonth = null;\n\tvar wHourObj = document.getElementById(\"whour\");\n\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n\tfunction dailyHourSelect() {\n\t\tdScheduleForObj = document.getElementById(\"dschedulefor\");\n\t\tif(dScheduleForObj.options[dScheduleForObj.selectedIndex].value==2) {\n\t\t\tsetDailyToFromHoursSelectBox();\n\t\t}\n\t}\n\tfunction dailyFromHourSelect() {\n\t\tdHourObj = document.getElementById(\"dhour\");\n\t\tdScheduleForObj = document.getElementById(\"dschedulefor\");\n\t\tdToHourObj = document.getElementById(\"dtohour\");\n\t\tdFromHourObj = document.getElementById(\"dfromhour\");\n\t\tdToHourObj.length=0;\n");
      out.write("\t\tif(dScheduleForObj.options[dScheduleForObj.selectedIndex].value==2) {\n\t\t\tvar i=0;\n\t\t\tfor(i=parseInt(dFromHourObj.options[dFromHourObj.selectedIndex].value) + 1;i<=dHourObj.options[dHourObj.selectedIndex].value;i++){\n\t\t\t\tvar optn = document.createElement(\"OPTION\");\n\t\t\t\toptn.text = pad2(i);\n\t\t\t\toptn.value = i;\n\t\t\t\tdToHourObj.options.add(optn);\n\t\t\t}\n\t\t\tdToHourObj.selectedIndex = dToHourObj.options.length-1;\n\t\t}else{\t\n\t\t\tvar selOption=0;\n\t\t\tfor(i=parseInt(dFromHourObj.options[dFromHourObj.selectedIndex].value) + 1;i<=24;i++){\n\t\t\t\tvar optn = document.createElement(\"OPTION\");\n\t\t\t\toptn.text = pad2(i);\n\t\t\t\toptn.value = i;\n\t\t\t\tdToHourObj.options.add(optn);\n\t\t\t\tselOption=i;\n\t\t\t}\n\t\t\tdToHourObj.selectedIndex = dToHourObj.options.length-1;\n\t\t}\n\t}\n\tfunction pad2(number) {\t   \n\t     return (number < 10 ? '0' : '') + number;\n\t}\t\n\tfunction dailyScheduleForSelect(){\n\t\t\n\t\tsetDailyToFromHoursSelectBox();\n\t}\n\tfunction setDailyToFromHoursSelectBox(){\n\t\t\n\t\tdHourObj = document.getElementById(\"dhour\");\n\t\tdScheduleForObj = document.getElementById(\"dschedulefor\");\n");
      out.write("\t\tdToHourObj = document.getElementById(\"dtohour\");\n\t\tdFromHourObj = document.getElementById(\"dfromhour\");\n\t\t\n\t\tif(dScheduleForObj.options[dScheduleForObj.selectedIndex].value==2) {\n\t\t\tdToHourObj.length=0;\n\t\t\tfor(var i=1;i<=dHourObj.options[dHourObj.selectedIndex].value;i++){\n\t\t\t\tvar optn = document.createElement(\"OPTION\");\n\t\t\t\toptn.text = pad2(i);\n\t\t\t\toptn.value = i;\n\t\t\t\tdToHourObj.options.add(optn);\n\t\t\t}\n\t\t\tdToHourObj.selectedIndex = dToHourObj.options.length-1;\n\t\t\tdFromHourObj.length=0;\n\t\t\tfor(var i=0;i<dHourObj.options[dHourObj.selectedIndex].value;i++){\n\t\t\t\tvar optn = document.createElement(\"OPTION\");\n\t\t\t\toptn.text = pad2(i);\n\t\t\t\toptn.value = i;\n\t\t\t\tdFromHourObj.options.add(optn);\n\t\t\t}\n\t\t}else{\n\t\t\tdFromHourObj.length=0;\n\t\t\tfor(var i=0;i<=23;i++){\n\t\t\t\tvar optn = document.createElement(\"OPTION\");\n\t\t\t\toptn.text = pad2(i);\n\t\t\t\toptn.value = i;\n\t\t\t\tdFromHourObj.options.add(optn);\n\t\t\t}\n\t\t\tdToHourObj.length=0;\n\t\t\tfor(var i=1;i<=24;i++){\n\t\t\t\tvar optn = document.createElement(\"OPTION\");\n\t\t\t\toptn.text = pad2(i);\n\t\t\t\toptn.value = i;\n");
      out.write("\t\t\t\tdToHourObj.options.add(optn);\n\t\t\t}\n\t\t\tdToHourObj.selectedIndex = dToHourObj.options.length-1;\t\t\t\n\t\t}\n\t}\n\tfunction selectall(){ \n\t\tvar form = document.manageform;\n\t\tvar eles = form.getElementsByTagName(\"input\");\n\t\tvar len = eles.length;\n\t\tfor(var i=0; i<len;i++){  \n\t\t\tif(eles[i].name == \"select\"){\n\t\t\t\tif (form.check1.checked )\t\n\t\t\t\t\teles[i].checked=true ; \n\t\t\t\telse\n\t\t\t\t\teles[i].checked=false ;\n\t\t\t}\n\t\t} \n\t}\n\tfunction showMonthlyDateStatus(){\n\t\tobjDateOfMonth = document.getElementById(\"mdate\");\n\t\tvar dateOfMonth = objDateOfMonth.options[objDateOfMonth.selectedIndex].value; \n\t\t\n\t\tif(dateOfMonth==29 || dateOfMonth==30 || dateOfMonth==31 ){\n\t\t\tdocument.getElementById(\"monthlyLastDayStatus\").style.display = \"block\";\n\t\t}else{\n\t\t\tdocument.getElementById(\"monthlyLastDayStatus\").style.display = \"none\";\n\t\t}\n\t}\n\tfunction showOnlyOnceDateStatus(){\n\t\tobjDateOfMonth = document.getElementById(\"odate\");\n\t\tvar dateOfMonth = objDateOfMonth.options[objDateOfMonth.selectedIndex].value; \n\t\t\n\t\tif(dateOfMonth==29 || dateOfMonth==30 || dateOfMonth==31 ){\n");
      out.write("\t\t\tdocument.getElementById(\"onlyOnceLastDayStatus\").style.display = \"block\";\n\t\t}else{\n\t\t\tdocument.getElementById(\"onlyOnceLastDayStatus\").style.display = \"none\";\n\t\t}\n\t}\n\tfunction changeStatus(){\n\t\tvar form = document.manageform;\n\t\tvar eles = form.getElementsByTagName(\"input\");\n\t\tvar len = eles.length;\n\t\tstatus = true;\n\t\tfor(var i=0; i<len;i++){  \n\t\t\tif(eles[i].name == \"select\"){\n\t\t\t\tif (!eles[i].checked ) {\n\t\t\t\t\tform.check1.checked = false;\n\t\t\t\t\tstatus = false;\t\n\t\t\t\t\tbreak;\t\n\t\t\t\t}\n\t\t\t}\n\t\t} \n\t\tif(status){\n\t\t\tform.check1.checked = true;\n\t\t}\n\t}\n\tfunction validateDelete(){\n\t\tvar elements = document.getElementsByName(\"select\");\n\t\tvar len = elements.length;\n\t\tflag = false ;\n\t\tfor( i=0;i<len ; i++ ){\n\t\t\tif(elements[i].name == \"select\"){\n\t\t\t\tif( elements[i].checked == true ){\n\t\t\t\t\tflag = true ;\n\t\t\t\t\tbreak;\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t\tif(!flag){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("You must select atleast one notification"));
      out.write("\");\n\t\t\treturn false;\n\t\t}\n\t\tvar con = confirm(\"");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to delete the selected Report Notification(s)?"));
      out.write("\");\n\t\tif (! con ){ \n\t\t\treturn false ;\n\t\t}\n\t\tdocument.manageform.submit();\n\t}\n\n\tfunction openAddScheduler(id){\t\t\n\t\t\n\t\tif(id == ''){\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/newmailscheduler.jsp';\t\t\t\n\t\t}else {\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/newmailscheduler.jsp?schedulerid='+id;\n\t\t}\n\t\thandleThickBox(1,'newshhedular',\"535\",\"10\");\n\t\t\n\t}\n\tfunction setFrequency(){\n\t\tdocument.getElementById(\"dailyContainer\").style.display = \"none\";\n\t\tdocument.getElementById(\"weeklyContainer\").style.display = \"none\";\n\t\tdocument.getElementById(\"monthlyContainer\").style.display = \"none\";\n\t\tdocument.getElementById(\"onlyonceContainer\").style.display = \"none\";\n\t\t\n\t\tif(document.getElementById(\"daily\").checked) {\n\t\t\tdocument.getElementById(\"dailyContainer\").style.display = \"block\";\n\t\t}else if(document.getElementById(\"weekly\").checked) {\n\t\t\tdocument.getElementById(\"weeklyContainer\").style.display = \"block\";\n\t\t}else if(document.getElementById(\"monthly\").checked) {\t\n\t\t\tdocument.getElementById(\"monthlyContainer\").style.display = \"block\";\n\t\t}else{\n\t\t\tdocument.getElementById(\"onlyonceContainer\").style.display = \"block\";\n\t\t}\n\t}\n\tfunction decideCombo(){\n\t\tvar choice = document.getElementsByName('rdchoice');\n\t\tvar rpgp = document.getElementById(\"reportgroup\");\n\t\tvar bookmark=document.getElementById(\"bookmarks\");\n");
      out.write("\t\tif(choice[0].checked){\n\t\t\tbookmark.disabled=true;\n\t\t\trpgp.disabled=false;\n\t\t}\n\t\telse{\n\t\t\tif(bookmark.length>0){\n\t\t\t\tbookmark.disabled=false;\n\t\t\t}\n\t\t\trpgp.disabled=true;\n\t\t}\n\t} \n\t\n\tfunction validateForm(mode){\n\t\tnameReExp = new RegExp(\"^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$\");\n\t\t//emailExp = /^(\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)*@\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)+,)*(\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)*@\\w+(\\-\\w+)*(\\.\\w+(\\-\\w+)*)),{0,1}$/ ;\n\t\temailExp = /^([\\w-\\.]+@[\\w-\\.]+[\\w],)*([\\w-\\.]+@[\\w-\\.]+[\\w])$/;\n\t\tform=document.addnewform;\n\t\tif (form.schedulername.value == ''){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the Report Name"));
      out.write("');\n\t\t\tform.schedulername.focus();\n\t\t\treturn false;\n\t\t}else if (!nameReExp.test(form.schedulername.value)){\n\t\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@', ' ' and '.' allowed in Report Name"));
      out.write("\");\n\t\t\tform.schedulername.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(form.toaddress.value == ''){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter email address"));
      out.write("');\n\t\t\tform.toaddress.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(!(emailExp.test(form.toaddress.value))){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("Invalid Email Address"));
      out.write("');\n\t\t\tform.toaddress.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif (form.reportgroup.value == ''){\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must select report group."));
      out.write("');\n\t\t\tform.reportgroup.value.focus();\n\t\t\treturn false;\n\t\t}\n\t\tif(form.selecteddevices.length == 0){\n\t\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must select atleast one device"));
      out.write("');\n\t\t\t\treturn false;\n\t\t}\n\t\tfor(i=0;i<form.selecteddevices.length;i++){\n\t\t\tform.selecteddevices.options[i].selected=true;\n\t\t}\n\t\tif(mode == ");
      out.print(ApplicationModes.ADD_MAIL_SCHEDULER);
      out.write(")\n\t\t\tcon = confirm(\"Are you sure you want to add the Report Notification?\");\n\t\telse \n\t\t\tcon = confirm(\"Are you sure you want to update the Report Notification?\");\n\t\treturn con;\n\t}//function validate form ends here\n\n\tfunction selectDevices(direction){\n\t\tvar src;\n\t\tvar dst;\n\t\tif(direction == 'right'){\n\t\t\tsrc = document.getElementById('availabledevices');\n\t\t\tdst = document.getElementById('selecteddevices');\n\t\t}else{\n\t\t\tdst = document.getElementById('availabledevices');\n\t\t\tsrc = document.getElementById('selecteddevices');\n\t\t}\n\t\t\n\t\tfor(i=src.length-1;i>=0;i--) {\n\t\t\tif(src[i].selected==true) {\n\t\t\t\tln=dst.length;\n\t\t\t\tdst.options[ln]=new Option(src.options[i].text,src.options[i].value,false,false);\n\t\t\t\tsrc.options[i]=null;\n\t\t\t}\n\t\t}\t\n\t}\n\tfunction getDevicesByCategoty()\n\t{\t\n\t\tvar id = document.getElementById(\"mailCategory\").value;\n\t\tvar availableDeviceEle = document.getElementById(\"availabledevices\");\n\t\tvar selectedDevicesEle = document.getElementById(\"selecteddevices\");\n\t\tvar reportGroupEle = document.getElementById(\"reportgroup\");\n");
      out.write("\t\tvar bookmarkEle = document.getElementById(\"bookmarks\");\n\t\tvar choice = document.getElementsByName('rdchoice');\n\t\tvar ctr=0;\n\n\t\tavailableDeviceEle.options.length = 0;\t\t\n\t\tselectedDevicesEle.options.length = 0;\n\t\treportGroupEle.options.length = 0;\n\t\tbookmarkEle.options.length=0;\n\n\t");

		ReportGroupBean reportGroupBean = null;
		ArrayList reportGrpIds;
		Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
		CategoryBean categoryBean= null;
		if(categoryBeanItr!=null){
			while(categoryBeanItr.hasNext()){	  		
				categoryBean = (CategoryBean)categoryBeanItr.next();
		
      out.write("\n\t\t\t\tif(id == ");
      out.print(categoryBean.getCategoryId());
      out.write("){\n\t\t\t\t\t\n\t\t\t\t\tctr=0;\t\n\t\t");
				
					DeviceBean deviceBean=null;
					String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryBean.getCategoryId());					
					if(deviceIds!= null && deviceIds.length > 0){
						for(int i=0;i<deviceIds.length;i++){
							deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceIds[i]));				
		
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tavailableDeviceEle.options[ctr++]=new Option('");
      out.print( deviceBean.getName());
      out.write('\'');
      out.write(',');
      out.print(deviceBean.getDeviceId());
      out.write(");\n\t\t\t\t\t\t\t\t\t        \t      \t\t\t\t\t\t\t\n\t\t");
				} 
					}
		
      out.write("\n\t\t\t\t\tctr=0;\t\t\n\t\t\t\t\t\n\t\t");

					reportGrpIds=CategoryReportGroupRelationBean.getReportgroupListByCategory(categoryBean.getCategoryId());
					for(int i=0;i<reportGrpIds.size();i++){
						reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(Integer.parseInt(reportGrpIds.get(i).toString()));
						if(reportGroupBean.getGroupType() == ReportGroupBean.STATIC_GROUP || reportGroupBean.getGroupType() == ReportGroupBean.DYNAMIC_GROUP){						
		
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\treportGroupEle.options[ctr++]=new Option('");
      out.print( reportGroupBean.getTitle());
      out.write('\'');
      out.write(',');
      out.print( reportGroupBean.getReportGroupId() );
      out.write(");\t\t\t\t\t\t\t\n\t\t");
				}
					}
					
      out.write("\n\t\t\t\t\tctr=0;\n\t\t\t\t\t");

					BookmarkBean bookmarkBean=null;
					Iterator bookmarkItr=null;
					bookmarkItr=BookmarkBean.getRecord("categoryid",categoryBean.getCategoryId()).values().iterator();
					if(!bookmarkItr.hasNext()){
						
      out.write("\n\t\t\t\t\t\tbookmarkEle.options[ctr++]=new Option('No Bookmarks Found',1);\n\t\t\t\t\t\tbookmarkEle.disabled=true;\n\t\t\t\t\t\tchoice[1].disabled=true;\n\t\t\t\t\t\tchoice[0].checked=\"checked\";\n\t\t\t\t\t\treportGroupEle.disabled=false;\n\t\t\t\t\t\t\n\t\t\t\t");

					}	
					else{
						while(bookmarkItr.hasNext()){
							bookmarkBean=(BookmarkBean)bookmarkItr.next();
						
      out.write("\n\t\t\t\t\t\t\tchoice[1].disabled=false;\n\t\t\t\t\t\t\tbookmarkEle.options[ctr++]=new Option('");
      out.print( bookmarkBean.getName());
      out.write('\'');
      out.write(',');
      out.print( bookmarkBean.getBookmarkId() );
      out.write(");\n\t\t\t");

						}
					
      out.write("\n\t\t\t\t\tdecideCombo();\t\n\t\t\t\t\t");
}
		
      out.write("\t\t\t\t\t\n\t\t\t\t}\t\t\t\n\t\t");

			}			
		}
		
      out.write("\n\t}\n\t\n\t\n</script>\n</head>\n<body >\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("  \n\t<div class=\"maincontent\" id=\"main_content\">\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Report Notification"));
      out.write("</div>\n\t\t</div>\n\t\t<br><br>\n\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"manageform\">\n\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.DELETE_MAIL_SCHEDULER);
      out.write("\">\n\t<input type=\"hidden\" name=\"scheduleid\" value=\"\">\n\t<table width=\"100%\" style=\"margin-bottom: 2px;\">\n\t<tr>\n\t\t<td align=\"left\" class=\"ButtonBack\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Add"));
      out.write("\" onClick=\"openAddScheduler('');\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete"));
      out.write("\" onclick =\"return validateDelete()\">\n\t\t</td>\n\t</tr>\n\t</table>\n\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" >\n\t<tr>\n\t\t<td>\n\t\t\t<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\" class=\"TableData\">\n");

	if(msg != null){

      out.write("\n\t\t\t<tr><td colspan=7 align=\"left\" class=\"");
      out.print(msgType );
      out.write('"');
      out.write('>');
      out.print(msg);
      out.write("</td></tr>\n");

	
	}

      out.write("\n\t\t\t<tr>\n\t\t\t\t<td align=\"center\" class=\"tdhead\"><input type=checkbox name=check1 onClick=\"selectall()\"></td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Name"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Report Group / Bookmark"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Device Name"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Email Frequency"));
      out.write("</td>\t\t\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("To Email Address"));
      out.write("</td>\n\t\t\t\t<td align=\"left\" class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Last Sent Time"));
      out.write("</td> \n\t\t\t</tr>\n");

	String rowStyle = "trdark"; // trlight
	boolean oddRow = false;
	Iterator mailSchedulerItr = null;
	MailScheduleBean mailScheduleBean = null;
	mailSchedulerItr = MailScheduleBean.getIterator();
	String reportGropuTitle = "";
	String deviceNameList = "";
	String toAddress = "";
	String lastSent = "";
	boolean isScheAvailable = mailSchedulerItr.hasNext();
	while(mailSchedulerItr.hasNext()){
		mailScheduleBean = (MailScheduleBean)mailSchedulerItr.next();
		oddRow = !oddRow;
		if(oddRow) 
			rowStyle = "trdark";
		else
			rowStyle = "trlight";
		if(!mailScheduleBean.getIsBookmark()){
			reportGropuTitle = ReportGroupBean.getRecordbyPrimarykey(mailScheduleBean.getReportGroupID()).getTitle();
		}
		else{
			reportGropuTitle=((BookmarkBean)BookmarkBean.getRecord("bookmarkid",mailScheduleBean.getReportGroupID()).values().iterator().next()).getName();
		}
		deviceNameList = mailScheduleBean.getDeviceName();
		toAddress = mailScheduleBean.getToaddress();
		lastSent = "2001-01-01 00:00:00".equalsIgnoreCase(mailScheduleBean.getLastsendtime())?"Not sent":mailScheduleBean.getLastsendtime();

      out.write("\n\t\t\t<tr class=\"");
      out.print( rowStyle );
      out.write("\">\n\t\t\t\t<td class=\"tddata\" align=\"center\" title=\"delete\"><input type=\"checkbox\" name=\"select\" onClick=\"changeStatus()\" value=\"");
      out.print( mailScheduleBean.getMailScheduleID() );
      out.write("\" ></td>\n\t\t\t\t<td class=\"tddata\"><a title=\"Edit Scheduler\" class=\"configLink\" href=\"#\" onclick=\"openAddScheduler('");
      out.print( mailScheduleBean.getMailScheduleID() );
      out.write("')\" >");
      out.print( mailScheduleBean.getScheduleName() );
      out.write("</a></td>\n\t\t\t\t<td class=\"tddata\" title=\"");
      out.print( reportGropuTitle );
      out.write('"');
      out.write('>');
      out.print( reportGropuTitle.length()>15?(reportGropuTitle.substring(0,15)+"..."):reportGropuTitle );
      out.write("</td>\n\t\t\t\t<td class=\"tddata\" title=\"");
      out.print( deviceNameList );
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print( deviceNameList.length()>15?(deviceNameList.substring(0,15)+"..."):deviceNameList );
      out.write("</td>\n\t\t\t\t<!-- \n\t\t\t\t\t<td class=\"tddata\">");
      out.print( mailScheduleBean.getScheduletype()==1?"Daily":(mailScheduleBean.getScheduletype()==2)?"On " + weekdays[mailScheduleBean.getDay()]:"on " );
      out.write("&nbsp;at&nbsp;");
      out.print( mailScheduleBean.getHours() + " hrs." );
      out.write("</td>\n\t\t\t\t-->\n\t\t\t\t<td class=\"tddata\">");
      out.print( mailScheduleBean.getScheduletype()==1?"Daily at " + mailScheduleBean.getHours() + " hrs.":mailScheduleBean.getScheduletype()==2?"On " + weekdays[mailScheduleBean.getDay()] + " at " + mailScheduleBean.getHours() + " hrs.":mailScheduleBean.getScheduletype()==3?"Monthly on " + mailScheduleBean.getDay() + " at " + mailScheduleBean.getHours() + " hrs.":"Only Once on " + mailScheduleBean.getDay() + " at " + mailScheduleBean.getHours() + " hrs." );
      out.write("</td>\n\t\t\t\t<td class=\"tddata\" title=\"");
      out.print( toAddress );
      out.write('"');
      out.write('>');
      out.print( toAddress.length()>15?(toAddress.substring(0,15)+"..."):toAddress );
      out.write("</td>\n\t\t\t\t<td class=\"tddata\">");
      out.print( lastSent );
      out.write("</td>\n\t\t\t</tr>\n");
 } 
		if(!isScheAvailable){

      out.write("\n\t\t<tr class=\"");
      out.print( rowStyle );
      out.write("\">\n\t\t\t<td class=\"tddata\" colspan=\"8\" align=\"center\">Report Notification(s) Not Available</td>\n\t\t</tr>\n");
 } 
      out.write("\n\t\t\t</table>\n\t\t</td>\n\t</tr>\n\t</table>\n\t</form>\n</div>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n<div class=\"TB_window\" id=\"newshhedular\"></div>\n</body>\n</html>\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in mailscheduler.jsp : "+e,e);
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
