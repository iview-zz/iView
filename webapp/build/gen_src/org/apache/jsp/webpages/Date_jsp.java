package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import org.cyberoam.iview.authentication.beans.*;
import org.cyberoam.iview.utility.DateDifference;
import org.cyberoam.iview.device.beans.DeviceGroupRelationBean;
import org.cyberoam.iview.device.beans.DeviceGroupBean;
import java.util.ArrayList;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.modes.TabularReportConstants;

public final class Date_jsp extends org.apache.jasper.runtime.HttpJspBase
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
	
try {	
	int categoryid = Integer.parseInt(session.getAttribute("categoryid").toString());
	
	DeviceBean deviceBean = null;
	UserBean userBean=UserBean.getRecordbyPrimarykey((String)session.getAttribute("username"));
	int userId = userBean.getUserId();
	
	String isDeviceSel = request.getParameter("device");	
	boolean isDeviceSelection = false;
	
	if(isDeviceSel!=null && "true".equalsIgnoreCase(isDeviceSel)) {
		isDeviceSelection = true;
	}
	
	boolean isShowtime=false;
	String strshowtime=request.getParameter("showtime");
	if ( strshowtime!= null && !"".equals(strshowtime)){
		isShowtime=Boolean.parseBoolean(strshowtime);
		CyberoamLogger.appLog.debug("check the show time value date.jsp :" + request.getParameter("showtime")+"bval"+isShowtime);
	}	
	
	
	
	/**
	*If category wise devices are there then and then only show "Select device" menu. 
	*/		
	CyberoamLogger.appLog.info("DATE.JSP::userid ="+userId+"categoryid=="+categoryid);
	String deviceIds[] = UserCategoryDeviceRelBean.getDeviceIdListForUserCategory(userId,categoryid);
	if(deviceIds!= null && deviceIds.length > 0)
		isDeviceSelection = true;
	else
		isDeviceSelection = false;
		
	String startDate = request.getParameter("startdate");
	String endDate = request.getParameter("enddate");
	
	if(startDate != null){
		CyberoamLogger.appLog.debug("Setting Start Date :" + startDate);
		session.setAttribute("startdate",startDate);
	}
	if(endDate != null){
		CyberoamLogger.appLog.debug("Setting End Date :" + endDate);
		session.setAttribute("enddate",endDate);
	}
	
	Date dateTemp=null;
	String []startDateTemp=new String[2];
	if(session.getAttribute("startdate") != null){
		dateTemp=DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd HH:mm:ss");
		if(isShowtime){
			startDate=DateDifference.dateToString(dateTemp);
		}else{			
			startDateTemp=(DateDifference.dateToString(dateTemp)).split(" ");
			startDate=startDateTemp[0];	  
		}
	}
	dateTemp=null;
	String []endDateTemp=new String[2];
	if(session.getAttribute("enddate") != null){
		dateTemp=DateDifference.stringToDate((String)session.getAttribute("enddate"),"yyyy-MM-dd HH:mm:ss");
		if(isShowtime){
			    endDate=DateDifference.dateToString(dateTemp);
			}else{
				endDateTemp=(DateDifference.dateToString(dateTemp)).split(" ");
				endDate=endDateTemp[0];		    
			 }
	}
	
	
	String limit=request.getParameter("limit");
	if(limit != null){
		session.setAttribute("limit",limit);
	}else if(session.getAttribute("limit") != null){
		limit =(String)session.getAttribute("limit");
	}else {
		limit = Integer.toString(TabularReportConstants.DEFAULT_LIMIT);
		session.setAttribute("limit",limit);
	}	
	
	DeviceBean.setDeviceListForUser(request);
	String strDeviceList = "";
	String selectedDeviceGroup = (String)session.getAttribute("devicegrouplist");
	

      out.write("\n\n\n\n\n\n\n<html>\n\n<head>\t\n\t<style type=\"text/css\" >@import url(");
      out.print(request.getContextPath());
      out.write("/css/calendar-blue.css);</style>\n\t<style type=\"text/css\" >@import url(");
      out.print(request.getContextPath());
      out.write("/css/configuration.css);</style>\n\t<style type=\"text/css\">@import url(");
      out.print(request.getContextPath());
      out.write("/css/newTheme.css);</style>\n\t<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\n\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/popup.css\">\n\t<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popup.js\"></script>\n\t\n<script language=\"JavaScript\">\n\t\n\tvar deviceList = null;\n\tvar isShowtimejs=false;\n\tisShowtimejs=");
      out.print(isShowtime);
      out.write(";\n\t\n\t\n\tfunction showHideDeviceInfo(){\n\t\tvar role = document.getElementById('role');\n\t\tvar selIndex = role.selectedIndex;\n\t\tif(role.options[selIndex].text == 'Admin'){\n\t\t\tdocument.getElementById('deviceinfo').style.display='none';\n\t\t}else{\n\t\t\tdocument.getElementById('deviceinfo').style.display='';\n\t\t}\n\t}\n\n\tfunction selectDevices(direction){\n\t\tvar src;\n\t\tvar dst;\n\t\tif(direction == 'right'){\n\t\t\tsrc = document.getElementById('availabledevices');\n\t\t\tdst = document.getElementById('selecteddevices');\n\t\t}else{\n\t\t\tdst = document.getElementById('availabledevices');\n\t\t\tsrc = document.getElementById('selecteddevices');\n\t\t}\n\t\t\n\t\tfor(i=src.length-1;i>=0;i--) {\n\t\t\tif(src[i].selected==true) {\n\t\t\t\tln=dst.length;\n\t\t\t\tdst.options[ln]=new Option(src.options[i].text,src.options[i].value,false,false);\n\t\t\t\tsrc.options[i]=null;\n\t\t\t}\n\t\t}\t\n\t}\n\tfunction getRecord(id){\n\t\tif(id==\"Device\"){\n\t\t\treturn data = deviceListJS;\n\t\t}\n\t\tif(id==\"Device Group\"){\n\t\t\treturn data = devicdGroupListJS;\n\t\t}\n\t}\n</script>\n</head>\n<body>\n<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/calendar.js\"></script>\n<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/calendar-en.js\"></script>\n<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/calendar-setup.js\"></script>\n<div style=\"float: right;\" id=\"calendar-container\"></div>\n\n<div style=\"z-index:99999;position:absolute;top:0px;left:0px;float:left\" id=\"temp\"></div>\n<script type=\"text/javascript\">\nvar deviceList = '';\nvar isAllDevice = true;\n\nfunction getObj(name)\n{\n if (document.getElementById)\n\treturn document.getElementById(name);\n else if (document.all)\n\treturn document.all[name];\n else if (document.layers){\n\t if (document.layers[name])\n\t\t return document.layers[name];\n\t else\n\t\t return document.layers.main.layers[name];\n  }\n}\n\nfunction toggleStep(hideStep,showStep,cTO,tabHide,tabShow,page)\n{\n\n\tvar cookieName = \"cTO_\"+page;\n\tvar hideObj=getObj(hideStep);\n\tvar showObj= getObj(showStep);\n\thideObj.style.display=\"none\";\n\tshowObj.style.display=\"block\";\n\tvar tabHideObj = getObj(tabHide);\n\tvar tabShowObj = getObj(tabShow);\n\n\tif(eval(tabHideObj) && eval(tabShowObj))\n\t{\n\t\ttabHideObj.className=\"calTabON\";\n\t\ttabShowObj.className=\"calTabOFF\";\n\t\tcreateCookie(cookieName,tabHide,1);\n\t}\n}\n\n\nfunction correctDigit(digits)\n");
      out.write("{\n if(digits < 10)\n {\n\tvar result = \"0\"+digits;\n return result;\n }\n return digits;\n}\n\n\nfunction dateChanged(calendar)\n{\n if (calendar.dateClicked)\n {\n var y = calendar.date.getFullYear();\n var m = correctDigit(calendar.date.getMonth()+1);// integer, 0..11\n var d = correctDigit(calendar.date.getDate()); // integer, 1..31\n var hours = calendar.date.getHours();\n var mins = calendar.date.getMinutes();\n var secs = calendar.date.getSeconds();\n // redirect...\n var date = y+\"-\"+m+\"-\"+d+\" \"+hours+\":\"+mins+\":\"+secs;\n //alert(\"Date=\"+date);\n var startdate = y+\"-\"+m+\"-\"+d+\" 00:00:00\";\n var enddate = y+\"-\"+m+\"-\"+d+\" 23:59:59\";\n document.timeForm.startdate.value=startdate;\n document.timeForm.enddate.value=enddate;\n document.timeForm.DateRange.value=\"true\";\n document.timeForm.flushCache.value=\"true\";\n addAdditionalParameters(startdate,enddate,\"true\");\n }\n}\n//This will validate the Custom selected Time using Calendar\nfunction passSelectedValues()\n{\n var start = document.timeForm.startdate;\n var end = document.timeForm.enddate;\n");
      out.write("\n if(eval(\"document.timeForm.startdate\").value == '')\n {\n alert(\"Please enter the Start date\");\n start.focus();\n return false;\n }\n else if(eval(\"document.timeForm.enddate\").value == '')\n {\n alert(\"Please enter the End date\");\n end.focus();\n return false;\n }\n else\n {\n\t var time1 = document.timeForm.startdate.value;\n\t var time2 = document.timeForm.enddate.value;\n\t if(!isShowtimejs){\n\t\t time1=time1+\" 00:00:00\";\n\t\t time2=time2+\" 23:59:59\";\n\t }\n\t var dt1 = getDate(time1, 'Start Date');\n\t if(dt1 == false)\n\t {\n\t start.focus();\n\t return false;\n\t }\n\n\t var dt2 = getDate(time2, 'End Date');\n\t if(dt2 == false)\n\t {\n\t end.focus();\n\t return false;\n\t }\n\t timeDiff = dt2 - dt1;\n\t if(timeDiff < 0)\n\t {\n\t \tvar temp = time1;\n\t \ttime1 = time2;\n\t \ttime2 = temp;\n\t \t\n\t \tif(!isShowtimejs){\n\t\t\t var timearr1=new Array();\n\t\t\t timearr1=time1.split(\" \");\n\t\t     time1=timearr1[0]+\" 00:00:00\";\n\t\t     var timearr2=new Array();\n\t\t     timearr2=time2.split(\" \");\n\t\t     time2=timearr2[0]+\" 23:59:59\";\n\t\t}\n\t }\n\t /* Adding check to find difference between Start Date & End Date\n");
      out.write("\t\tshould not be more than 3.5 years\n\t */\n\t var diff_date = dt2 - dt1;\n\t var num_years = diff_date/31536000000;\n\t var num_months = (diff_date % 31536000000)/2628000000;\n\t var num_days = ((diff_date % 31536000000) % 2628000000)/86400000;\n\n\t if(num_years >= 3 && num_months >= 6){\n\t\talert(\"Date interval should not be more than 3.5 years\");\n\t\tstart.focus();\n\t\treturn false;\n\t }\n }\n document.timeForm.flushCache.value=\"true\";\n document.timeForm.DateRange.value=\"true\";\n addAdditionalParameters(time1,time2,\"true\");\n}\nfunction addAdditionalParameters(start,end,range,timeFrame)\n{\n var queryStr = window.parent.location.href;\n var delimiter = \"?\";\n //this will contain the final href ... safer-side(??) assign the current href\n var finalHref = queryStr;\n var questionMarkIndex = queryStr.indexOf(\"?\");\n if( questionMarkIndex > 0 ){\n var myQueryStr = queryStr.substring(0,questionMarkIndex+1);\n var parameters = queryStr.substring(questionMarkIndex+1,queryStr.length);\n var parameters_splitted = parameters.split(\"&\");\n var restQueryString = new Array();\n");
      out.write(" var counter = 0;\n for(i=0; i< parameters_splitted.length; i++){\n\t var temp = parameters_splitted[i];\n\t var hashIndex = temp.indexOf(\"#\");\n\t temp = (hashIndex > 0)?(temp.substring(0,hashIndex)):(temp);\n\t var tempSplitted = temp.split(\"=\");\n\t if((tempSplitted.length == 2)){\n\t var _key = tempSplitted[0];\n\t if( (_key == \"startdate\") || (_key == \"enddate\") || (_key ==\"DateRange\") || (_key == \"timeFrame\") ||(_key == \"flushCache\")||(_key == \"enddate\")){ continue;}\n\t else{ restQueryString[counter++] = temp; }\n}\n }\n myQueryStr = myQueryStr + restQueryString.join(\"&\");\n delimiter = \"\";\n var params = document.timeForm.additionalParams.value;\n var splittedParams = params.split(\"&\");\n var toAppend = new Array();\n var marker = 0;\n for(num=0; num<splittedParams.length; num++){\n\t var temp = splittedParams[num];\n\t var tempSplitted = temp.split(\"=\");\n\t if( tempSplitted.length == 2 ){\n\t var searchFor = tempSplitted[0]+\"=\";\n\t if( queryStr.indexOf( searchFor ) < 0 ){ toAppend[marker++] = temp; }\n\t }\n }\n if( marker >= 0 ){\n var appendStr = toAppend.join(\"&\");\n");
      out.write(" finalHref = myQueryStr+\"&\"+appendStr;\n }\n }\n //simply append the time criteria and additional parameters if any ...\n var timeString = delimiter+\"flushCache=true\";\n if( range == \"false\" ){ timeString = timeString +\"&DateRange=false&timeFrame=\"+timeFrame; }\n else{ timeString = timeString +\"&DateRange=true&startdate=\"+start+\"&enddate=\"+end; }\n finalHref = finalHref + timeString;\n if(document.getElementById(\"devicelist\")){\n\t isDeviceGroup=\"false\";\n \tdeviceList = getCheckedIds(\"devicelist\");\n \tif(deviceList == \"\"){\n\t\tdeviceList=\"-1\";\n\t}\n\t\n \tif(getCheckedValues(\"devicelist\",\"popupratio\"+\"devicelist\").toString().indexOf(\"Device Group\") != -1){\n\t\t isDeviceGroup=\"true\";\n\t\t finalHref = replaceQueryString(finalHref,'devicegrouplist',deviceList);\n\t\t finalHref = clearQueryStringParam(finalHref,'deviceid');\n\t\t finalHref = clearQueryStringParam(finalHref,'devicelist');\n\t}else {\n\t\t finalHref = replaceQueryString(finalHref,'devicelist',deviceList);\n\t\t finalHref = clearQueryStringParam(finalHref,'deviceid');\n\t\t finalHref = clearQueryStringParam(finalHref,'devicegrouplist');\n");
      out.write("\t}\n\tfinalHref = replaceQueryString(finalHref,\"isdevicegroup\",isDeviceGroup);\n\tfinalHref = finalHref.replace(\"&&\",\"&\");\n\t\n }\n window.parent.location.href = finalHref;\n}\nfunction getDate(str, FromTo)\n{\n timeArray = new Array();\n startArray1 = new Array();\n startArray2 = new Array();\n date = new Date();\n\n var checkFormat = checkDateTimeFormat(str, FromTo);\n if(checkFormat == false)\n return false;\n\n timeArray = str.split(\" \");\n var startStr1 = timeArray[0];\n var startStr2 = timeArray[1];\n startArray1 = startStr1.split(\"-\");\n var yr = startArray1[0];\n var mon = startArray1[1];\n var day = startArray1[2];\n startArray2 = startStr2.split(\":\");\n var hr = startArray2[0];\n var min = startArray2[1];\n\n if(day<1 || day>31 || mon<1 || mon>12 || yr<1 || yr<1980)\n {\n alert(\"Please enter a valid \"+FromTo+\"[YYYY-MM-DD HH:MM:SS]\");\n return false;\n }\n\n if((mon==2) && (day>29)) //checking of no. of days in february month\n {\n alert(\"Please enter a valid \"+FromTo+\"[YYYY-MM-DD HH:MM:SS]\");\n return false;\n }\n\n if((mon==2) && (day>28) && ((yr%4)!=0)) //leap year checking\n");
      out.write(" {\n alert(\"Please enter a valid \"+FromTo+\"[YYYY-MM-DD HH:MM:SS]\");\nreturn false;\n }\n\n if(hr<0 || hr>23 || min<0 || min>59)\n {\n alert(\"Please enter a valid \"+FromTo+\"[YYYY-MM-DD HH:MM:SS]\");\n return false;\n }\n\n date = new Date(yr, (mon-1), day, hr, min);\n return date;\n}\n\nfunction checkDateTimeFormat(timeStr, fromto)\n{\n var dateTimeRe = /^(\\d{4})-(\\d{1,2})-(\\d{2}) (\\d{2}):(\\d{2}):(\\d{2})$/;\n var start = document.timeForm.startdate;\n var end = document.timeForm.enddate;\n\n\n if(!dateTimeRe.test(timeStr))\n {\n alert(\"Please enter a valid \"+fromto+\"[YYYY-MM-DD HH:MM:SS]\");\n return false;\n }else\n {\n return true;\n }\n\n}\n\nfunction setPeriod()\n{\n document.timeForm.DateRange.value=\"false\";\n document.timeForm.flushCache.value=\"true\";\n var index = document.timeForm.timeFrame.selectedIndex;\n var timeFrame = document.timeForm.timeFrame.options[index].value;\n document.timeForm.startdate.value='';\n document.timeForm.enddate.value='';\n addAdditionalParameters('','',\"false\",timeFrame);\n}\n\nfunction createCookie(name,value,days)\n{\n if (days)\n");
      out.write(" {\n var date = new Date();\n date.setTime(date.getTime()+(days*24*60*60*1000));\n var expires = \"; expires=\"+date.toGMTString();\n }\n else var expires = \"\";\n document.cookie = name+\"=\"+value+expires+\"; path=/\";\n}\n\nfunction readCookie(name)\n{\n var nameEQ = name + \"=\";\n var ca = document.cookie.split(';');\nfor(var i=0;i < ca.length;i++)\n {\n var c = ca[i];\n while (c.charAt(0)==' ') c = c.substring(1,c.length);\n if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);\n }\n return null;\n}\n\nfunction eraseCookie(name)\n{\n createCookie(name,\"\",-1);\n}\n\nfunction checkEnter(e)\n{\n var characterCode;\n if(e && e.which){\n characterCode = e.which;\n }else{\n characterCode = e.keyCode;\n }\n if(characterCode == 13){ passSelectedValues(); }\n}\nfunction syncDate(){\n\tvar dateTimeRe = /^(\\d{4})-(\\d{1,2})-(\\d{2}) (\\d{2}):(\\d{2}):(\\d{2})$/;\n \tvar start = document.timeForm.startdate.value;\n \tvar end = document.timeForm.enddate.value;\n \tif(!isShowtimejs){\n\t\t start=start+\" 00:00:00\";\n\t\t end=end+\" 23:59:59\";\n\t }\n \tif(!dateTimeRe.test(start))\n");
      out.write(" \t{\n \t\talert(\"Please enter a valid Start Date [YYYY-MM-DD HH:MM:SS]\");\n \t} else {\n \t\tvar dt1 = getDate(start, 'Start Date');\n \t\tvar dt2 = getDate(end, 'end Date');\n \t \tif(dt1 > dt2){\n \t\t\tvar pos = start.toString().indexOf(' ');\n \t\t\tdocument.getElementById('dateField1').value = start.substring(0,pos);\n \t \t}\n \t}\n\t\n}\ndeviceList = '';\nisAllDevice = true;\nfunction checkDeviceList(devList){\n\tif(isAllDevice){\n\t\tfor(i=1; i<devList.length; i++){\n\t\t\tif(devList[i].selected){\n\t\t\t\tdevList[0].selected = false;\n\t\t\t\tisAllDevice = false;\n\t\t\t\tbreak;\n\t\t\t}\n\t\t}\n\t}else{\n\t\tif(devList[0].selected){\n\t\t\tfor(i=1; i<devList.length; i++){\n\t\t\t\tdevList[i].selected = false;\n\t\t\t\tisAllDevice = true;\n\t\t\t}\n\t\t}\n\t}\n}\nfunction createDeviceList(devList){\n\tdeviceList = '';\n\tif(!isAllDevice){\n\t\tfor(i=0; i<devList.length; i++){\n\t\t\tif(devList[i].selected){\n\t\t\t\tdeviceList += (devList[i].value + ',');\n\t\t\t}\n\t\t}\n\t\tdeviceList = deviceList.substring(0,deviceList.lastIndexOf(','));\n\t}else{\n\t\tdeviceList = '-1';\n\t}\n}\nfunction replaceQueryString(url,param,value) {\n");
      out.write("\tvar re = new RegExp(\"([?|&])\" + param + \"=.*?(&|$)\",\"i\");\n\tif (url.match(re)) {\n\t\treturn url.replace(re,'$1' + param + \"=\" + value + '$2');\n\t} else {\n\t\treturn url + '&' + param + \"=\" + value;\n\t}\n}\nfunction clearQueryStringParam(url,param) {\n\tvar re = new RegExp(\"([?|&])\" + param + \"=.*?(&|$)\",\"i\");\n\tif (url.match(re)) {\n\t\treturn url.replace(re,'$1' + '$2');\n\t}else {\n\t\treturn url;\n\t}\n}\n\n</script>\n<div id=\"contentheader\" class=\"contentheader\" style=\"z-index:2;\">\n\t<div class = \"left\"> </div>\n    <form name=\"timeForm\" method=\"post\" style=\"margin: 0px;\">\n    \t<input name=\"additionalParams\" value=\"flushCache=true\" type=\"hidden\">\n");
 if(isDeviceSelection){ 
      out.write("\n\t\t<div id=\"devicelist1\" style=\"float:left;\">\t\n\t\t\t<div title=\"");
      out.print( (String)session.getAttribute("appliancelist") );
      out.write("\" class=\"grouptext\" id=\"devicelist\" style=\"background: url('../images/select_device_button.jpg');height:42px;*height:40px;float:left;margin-right:2px;margin-top:4px\"></div>\n\t\t</div>\n");
 } 
      out.write('\n');
      out.write('\n');

	String deviceList2="";
	String deviceGroupList="";
	
	if(isDeviceSelection){
		
		strDeviceList = (String)session.getAttribute("devicelist");
	
		
		String strDeviceList2[] = UserCategoryDeviceRelBean.getDeviceIdListForUserCategory(userId,categoryid);
		if(strDeviceList2 != null && strDeviceList2.length > 0){
			for(int i = 0;i < strDeviceList2.length ;i++){						
				deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList2[i]));
				deviceList2 += "\""+deviceBean.getName()+"|"+deviceBean.getDeviceId()+"\",";				
			}
		}
	
		DeviceGroupBean deviceGroupBean = null;
		String strDeviceGroupList[] = UserCategoryDeviceRelBean.getDeviceGroupIdListForUserCategory(userId,categoryid);
		if(strDeviceGroupList != null && strDeviceGroupList.length > 0){
			for(int i = 0;i < strDeviceGroupList.length ;i++){						
				deviceGroupBean = DeviceGroupBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceGroupList[i]));						
				deviceGroupList += "\""+deviceGroupBean.getName()+"|"+deviceGroupBean.getGroupID()+"\",";				
				}
		}	
		
		if(!"".equals(deviceList2))
			deviceList2 = "[" + deviceList2.substring(0,deviceList2.length()-1) + "]";
		else
			deviceList2 = "[" + deviceList2 + "]";		
		
		if(!"".equals(deviceGroupList))
			deviceGroupList = "[" + deviceGroupList.substring(0,deviceGroupList.length()-1) + "]";
		else 
			deviceGroupList = "[" + deviceGroupList + "]";		
	}else{
		deviceList2 ="[]";
		deviceGroupList = "[]";		
	}
	

      out.write("\n\t\n<script language=\"JavaScript\">\t\n\tdeviceListJS = ");
      out.print(deviceList2);
      out.write(";\n\tdevicdGroupListJS = ");
      out.print(deviceGroupList);
      out.write(";\n</script>\n\n\t<div id=\"timeDiv\">\n\t\t<div style=\"float:left;background:url('../images/date_border_left.jpg') no-repeat;width:3px;height:42px;*height:40px;\"></div>\n\t\t<div style=\"float:right;background:url('../images/date_border_right.jpg');width:3px;height:42px;*height:40px;\"></div>\n\t    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"190px\" style=\"margin:3px\">\n\t  \t<tbody style=\"border:none\">\n\t\t<tr align=\"right\" valign=\"middle\">\n\t\t\t<td class=\"bodyTextTitle\" nowrap=\"nowrap\">");
      out.print(TranslationHelper.getTranslatedMessge("Start Date"));
      out.write(" </td>\n\t\t\t<td class=\"bodyText\" align=\"left\" height=\"16px\" width=\"120px\" nowrap=\"nowrap\"> \n\t\t  \t\t<input name=\"startdate\" id=\"dateField\" class=\"txtbox\" value='");
      out.print(startDate);
      out.write("' onKeyPress=\"checkEnter(event)\" type=\"text\" onchange=\"syncDate();\">\n\t            <a href=\"javascript:;\">\n\t            \t<img src=\"../images/calendar.png\" id=\"startTrigger\" align=\"absmiddle\" border=\"0\" width=16px height=16px>\n\t            </a>\n\t\t\t\t<script type=\"text/javascript\">\n\t\t\t\tvar showtimeval=false;\n\t\t           var ifformatval=\"%Y-%m-%d\";\n\t\t           if(isShowtimejs){\n\t\t            \tshowtimeval=true;\n\t\t            \tifformatval=\"%Y-%m-%d %H:%M:%S\";\n\t\t            }  \n\t            \tvar today = new Date();\n\t                      Calendar.setup({\n\t                       inputField     :    \"dateField\",     // id of the input field\n\t                       ifFormat       :    ifformatval,      // format of the input field\n\t                       showsTime\t  :    showtimeval,\t\n\t                       button         :    \"startTrigger\",  // trigger for the calendar (button ID)\n\t                       timeFormat     :    \"24\",\n\t                       weekNumbers    :    false,\n\t                       align          :    \"B1\",           // alignment (defaults to \"Bl\")\n");
      out.write("\t                       singleClick    :    true,\n\t                       timeFormatOnToday : 1,\n\t                       dateStatusFunc :function (date) \n\t                       { \n\t                       return date.getTime() > today.getTime() && date.getDate() != today.getDate();\n\t                       }\n\t                       });\n\t            </script>\n\t\t\t</td>\n\t\t</tr>\n\t\t<tr align=\"right\" valign=\"middle\"> \n\t     \t<td class=\"bodyTextTitle\" nowrap=\"nowrap\">");
      out.print(TranslationHelper.getTranslatedMessge("End Date"));
      out.write(" </td>\n\t        <td class=\"bodyText\" align=\"left\" height=\"16\" width=120px nowrap=\"nowrap\">\n\t        \t<input name=\"enddate\" id=\"dateField1\" class=\"txtbox\" value='");
      out.print(endDate);
      out.write("' onKeyPress=\"checkEnter(event)\" type=\"text\">\n\t            <a href=\"javascript:;\">\n\t            \t<img src=\"../images/calendar.png\" id=\"startTrigger1\" align=\"absmiddle\" border=\"0\" width=\"16px\" heightL=\"16px\">\n\t\t\t\t</a>\n\t            <script type=\"text/javascript\">\n\t            var showtimeval=false;\n\t            var ifformatval=\"%Y-%m-%d\";\n\t            if(isShowtimejs){\n\t            \tshowtimeval=true;\n\t            \tifformatval=\"%Y-%m-%d %H:%M:%S\";\n\t             } \n\t\t\t\t\t var today = new Date();\n\t\t\t\t\t Calendar.setup({\n\t\t\t\t\t inputField     :    \"dateField1\",     // id of the input field\n\t\t\t\t\t ifFormat       :   ifformatval,      // format of the input field\n\t\t\t\t\t showsTime\t   :    showtimeval,\t\n\t\t\t\t\t button         :    \"startTrigger1\",  // trigger for the calendar (button ID)\n\t\t\t\t\t timeFormat     :    \"24\",\n\t\t\t\t\t weekNumbers     :    false,\n\t\t\t\t\t align          :    \"Bl\",           // alignment (defaults to \"Bl\")\n\t\t\t\t\t singleClick    :    true,\n\t\t\t\t\t timeFormatOnToday : 0,\n\t\t\t\t\t dateStatusFunc :function (date)\n\t\t\t\t\t { \n");
      out.write("\t\t\t\t\t return date.getTime() > today.getTime() && date.getDate() != today.getDate();\n\t\t\t\t\t }\n\t\t\t\t\t });\n\t            </script> \n\t\t\t</td>           \n\t\t</tr>       \n\t\t</tbody>\n\t\t</table>      \n\t</div>\n\t<div style=\"float:left;\">\n\t\t<input name=\"button\" onClick=\"passSelectedValues();\" class=\"gobutton\" type=\"button\">\n\t\t<input name=\"DateRange\" type=\"hidden\"> \n\t\t<input name=\"flushCache\" type=\"hidden\">\t\t   \n\t</div>      \n\t</form>\n</div>\n<script language=\"JavaScript\">\n\tvar cTO = readCookie(\"cTO_null\");\n\tgetObj(\"calendar-container\").style.display=\"none\";\n\tgetObj(\"timeDiv\").style.display=\"block\";\n\tfunction callme(id)\n\t{\n\t\t if(id==\"r\") {\n\t\t toggleStep('calendar-container','timeDiv','r','r','c','null')\n\t\t }\n\t\t else if(id==\"c\"){\n\t\t toggleStep('timeDiv','calendar-container','c','c','r','null');\n\t\t } \n\t}\n\t\n\t var today = new Date();\n\t Calendar.setup(\n\t {\n\t flat : \"calendar-container\", // ID of the parent element\n\t flatCallback : dateChanged, // our callback function\n\t date:'");
      out.print(startDate);
      out.write("', \n\t timeFormat : \"12\",\n\t weekNumbers : false,\n\t mytab : true,\n\t dateStatusFunc :function (date)\n\t {\n\t return date.getTime() > today.getTime() && date.getDate() != today.getDate();\n\t }\n\t }\n\t );\n\t\n\t");
	if(isDeviceSelection){
			CyberoamLogger.appLog.info("selectedDeviceGroup:::"+selectedDeviceGroup+"strDeviceList:::"+strDeviceList);
			if(session.getAttribute("isdevicegroup") !=null && "true".equalsIgnoreCase((String)session.getAttribute("isdevicegroup"))  ) {
      out.write("\n\t\t\t\tcreatePopUp(\"devicelist\",[\"Device|1|0\",\"Device Group|1|0\"],\"Device Group\",");
      out.print("[\""+selectedDeviceGroup+"\"]");
      out.write(");\n\t");
	 	
			}else { 
	
      out.write("\t\t\t\n\t\t\t\t\tcreatePopUp(\"devicelist\",[\"Device|1|0\",\"Device Group|1|0\"],\"Device\",");
      out.print("[\""+strDeviceList+"\"]");
      out.write(");\t\n\t");
				
			}	
	
      out.write("\n\t\n\tvar okButton = document.getElementById(\"btn1devicelist\");\n\tif(document.all){\n\t\tokButton.onclick = function () { passSelectedValues(); };\n\t} else {\n\t\tokButton.setAttribute(\"onclick\",\"passSelectedValues();\");\n\t}\n\t\t\n\t\tmyDashbordPopup(\"devicelist\",\"45\");\n\t");
	}else {
			deviceList2 = "[]";
			deviceGroupList = "[]";
		}
		
      out.write("\n\t\n\t</script>\n\n</body>\n</html>\n");

	}catch(Exception e){
	CyberoamLogger.appLog.error("date.jsp:"+e,e);
}

      out.write("   \n");
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
