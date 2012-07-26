package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.CheckSession;
import java.util.*;
import java.text.SimpleDateFormat;
import org.cyberoam.iview.authentication.beans.*;
import org.cyberoam.iview.utility.DateDifference;
import java.util.ArrayList;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.modes.TabularReportConstants;

public final class schedulebackuprestore_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n");

	if(CheckSession.checkSession(request,response) < 0) return;

	String startDate="";
	String endDate="";
	String ftpServer=null,ftpUserName=null,ftpPassword=null,backupfreq=null,lastbackupdatetime=null,hourtime=null;
	
 try{
 	ftpServer=iViewConfigBean.getValueByKey("FTPServerIP");
 	ftpUserName=iViewConfigBean.getValueByKey("FTPUserName");
 	ftpPassword=iViewConfigBean.getValueByKey("FTPPassword");
 	backupfreq=iViewConfigBean.getValueByKey("ScheduleBackupFrequency");
 	lastbackupdatetime=iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_LAST_BACKUP);
 	hourtime=iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_BACKUP_TIME);
 	
 	if("1".equals(backupfreq)){
 		if(!("".equals(lastbackupdatetime)) && lastbackupdatetime != null){
 			lastbackupdatetime=lastbackupdatetime.substring(0,4)+"-"+lastbackupdatetime.substring(4,6)+"-"+lastbackupdatetime.substring(6,8)+" "+hourtime;
 		}
	}
 	if(ftpServer == null || "".equalsIgnoreCase(ftpServer) || "null".equalsIgnoreCase(ftpServer)){
 		ftpServer = "";
	}
	if(ftpUserName== null || "".equalsIgnoreCase(ftpUserName) || "null".equalsIgnoreCase(ftpUserName)){
		ftpUserName = "";
	}
	if(ftpPassword== null || "".equalsIgnoreCase(ftpPassword) || "null".equalsIgnoreCase(ftpPassword)){
		ftpUserName = "";
	}
		
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
	String pmessage = "";
	String nmessage = "";
	if(iMode == ApplicationModes.SCHEDULE_BACKUP && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Configuration updated successfully.");
	} else if(iMode == ApplicationModes.SCHEDULE_BACKUP && iStatus == -1){
		nmessage = TranslationHelper.getTranslatedMessge("FTP ServerIP Not Valid.");
	}else if(iMode == ApplicationModes.SCHEDULE_BACKUP && iStatus == -2){
		nmessage = TranslationHelper.getTranslatedMessge("Username or Password Not Valid.");
	}else if(iMode == ApplicationModes.SCHEDULE_BACKUP && iStatus == -3){
		nmessage = TranslationHelper.getTranslatedMessge("FTP Server can not reachable");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -4){
		nmessage = TranslationHelper.getTranslatedMessge("Backup Files Could Not Found");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -1){
			nmessage = TranslationHelper.getTranslatedMessge("Restoration Not Done");	
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus > 0){
		pmessage = TranslationHelper.getTranslatedMessge("Restoration Successfully done");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -5){
		nmessage = TranslationHelper.getTranslatedMessge(" Error At Time of File Retrieve From FTP Please Check FTP Configuration And Try Again");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -6){
		nmessage = TranslationHelper.getTranslatedMessge("Some Zip Files Are Corrupted At Time Of Retrieve From FTP Please Try Again");
	}else if(iMode == ApplicationModes.RESTORE_REQUEST && iStatus == -7){
		nmessage = TranslationHelper.getTranslatedMessge("Please Update FTP Configuration ");
	}
	

      out.write("\r\n\r\n<html>\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\r\n<title>");
      out.print(iViewConfigBean.TITLE);
      out.write("</title>\r\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\r\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ipvalidation.js\"></script>\r\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/SearchData.js\"></script>\r\n<script type=\"text/javascript\" language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></script>\r\n<style type=\"text/css\" >@import url(");
      out.print(request.getContextPath());
      out.write("/css/calendar-blue.css);</style>\r\n<style type=\"text/css\" >@import url(");
      out.print(request.getContextPath());
      out.write("/css/configuration.css);</style>\r\n<style type=\"text/css\">@import url(");
      out.print(request.getContextPath());
      out.write("/css/newTheme.css);</style>\r\n<link rel=\"icon\" type=\"image/png\" href=\"");
      out.print(request.getContextPath());
      out.write("/images/iViewLogofave.png\"/>\r\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/popup.css\">\r\n<script language=\"JavaScript\" src=\"/javascript/cyberoam.js\"></script>\r\n<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popup.js\"></script>\r\n\r\n<script language=\"JavaScript\" src=\"/javascript/cyberoam.js\"></script>\r\n<script type=\"text/javascript\">\r\nwindow.onload = function (evt) {\r\n\tsetWidth();\r\n\tbackupfrequency();\r\n}\r\nfunction setWidth(){\r\n\tvar main_div = document.getElementById(\"main_content\");\t\r\n\tmain_div.style.width = (document.body.clientWidth - 229);\t\r\n}\r\n\r\nfunction handleThickBox(op,container,width,top){\r\n\tvar thickBox = document.getElementById('TB_overlay');\r\n\tvar containerBox = document.getElementById(container);\r\n\tif(top != undefined)\r\n\t\tcontainerBox.style.top = top;\r\n\tif(width != undefined)\r\n\t\tcontainerBox.style.width = width;\r\n\tif(op == 1){\t\t\t\r\n\t\tthickBox.style.display = '';\r\n\t\tcontainerBox.style.display = 'block';\r\n\t}else{\r\n\t\tthickBox.style.display = 'none';\r\n\t\tcontainerBox.style.display = 'none';\r\n\t\tcontainerBox.innerHTML = '';\r\n\t}\r\n}\r\n\r\nfunction getObj(name)\r\n{\r\n if (document.getElementById)\r\n\treturn document.getElementById(name);\r\n else if (document.all)\r\n\treturn document.all[name];\r\n else if (document.layers){\r\n");
      out.write("\t if (document.layers[name])\r\n\t\t return document.layers[name];\r\n\t else\r\n\t\t return document.layers.main.layers[name];\r\n  }\r\n}\r\n\r\nfunction toggleStep(hideStep,showStep,cTO,tabHide,tabShow,page)\r\n{\r\n\r\n\tvar cookieName = \"cTO_\"+page;\r\n\tvar hideObj=getObj(hideStep);\r\n\tvar showObj= getObj(showStep);\r\n\thideObj.style.display=\"none\";\r\n\tshowObj.style.display=\"block\";\r\n\tvar tabHideObj = getObj(tabHide);\r\n\tvar tabShowObj = getObj(tabShow);\r\n\r\n\tif(eval(tabHideObj) && eval(tabShowObj))\r\n\t{\r\n\t\ttabHideObj.className=\"calTabON\";\r\n\t\ttabShowObj.className=\"calTabOFF\";\r\n\t\tcreateCookie(cookieName,tabHide,1);\r\n\t}\r\n}\r\nfunction correctDigit(digits)\r\n{\r\n if(digits < 10)\r\n {\r\n\tvar result = \"0\"+digits;\r\n return result;\r\n }\r\n return digits;\r\n}\r\n\r\n\r\nfunction dateChanged(calendar)\r\n{\r\n if (calendar.dateClicked)\r\n {\r\n var y = calendar.date.getFullYear();\r\n var m = correctDigit(calendar.date.getMonth()+1);// integer, 0..11\r\n var d = correctDigit(calendar.date.getDate()); // integer, 1..31\r\n var hours = calendar.date.getHours();\r\n var mins = calendar.date.getMinutes();\r\n");
      out.write(" var secs = calendar.date.getSeconds();\r\n // redirect...\r\n var date = y+\"-\"+m+\"-\"+d;\r\n //alert(\"Date=\"+date);\r\n var startdate = y+\"-\"+m+\"-\"+d;\r\n var enddate = y+\"-\"+m+\"-\"+d;\r\n document.timeForm.startdate.value=startdate;\r\n document.timeForm.enddate.value=enddate;\r\n document.timeForm.DateRange.value=\"true\";\r\n document.timeForm.flushCache.value=\"true\";\r\n \r\n }\r\n}\r\n//This will validate the Custom selected Time using Calendar\r\nfunction passSelectedValues()\r\n{\r\n var start = document.timeForm.startdate;\r\n var end = document.timeForm.enddate;\r\n\r\n if(eval(\"document.timeForm.startdate\").value == '')\r\n {\r\n alert(\"Please enter the Start date\");\r\n start.focus();\r\n return false;\r\n }\r\n else if(eval(\"document.timeForm.enddate\").value == '')\r\n {\r\n alert(\"Please enter the End date\");\r\n end.focus();\r\n return false;\r\n }\r\n else\r\n {\r\n\t var time1 = document.timeForm.startdate.value;\r\n\t var time2 = document.timeForm.enddate.value;\r\n\t var dt1 = getDate(time1, 'Start Date');\r\n\t if(dt1 == false)\r\n\t {\r\n\t start.focus();\r\n\t return false;\r\n");
      out.write("\t }\r\n\r\n\t var dt2 = getDate(time2, 'End Date');\r\n\t if(dt2 == false)\r\n\t {\r\n\t end.focus();\r\n\t return false;\r\n\t }\r\n\t timeDiff = dt2 - dt1;\r\n\t if(timeDiff < 0)\r\n\t {\r\n\t\t alert(\"StartDate Can not Be Greater Than EndDate\");\r\n\t\t return false;\r\n\t }\r\n\t \r\n }\r\n\tvar con=confirm('");
      out.print(TranslationHelper.getTranslatedMessge("Are You Sure You Want To Restore "));
      out.write("');\r\n\tif(con == true){\r\n\t\thandleThickBox(1,'progressbar',\"500\");\r\n\t\treturn true;\r\n\t}else{\r\n\t\treturn false;\r\n\t}\r\n}\r\n\r\nfunction getWinSize(container) {\r\n\tif( typeof( window.innerWidth ) == 'number' ) {\t\t//Non-IE\r\n    \twinWidth = window.innerWidth;\r\n    \twinHeight = window.innerHeight;\r\n  \t} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {\r\n    \twinWidth = document.documentElement.clientWidth;\r\n    \twinHeight = document.documentElement.clientHeight;\r\n  \t} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {\r\n    \twinWidth = document.body.clientWidth;\t    \r\n    \twinHeight = document.body.clientHeight;\r\n  \t}\r\n\tif(document.getElementById(container)){\t\t\t\r\n\t\tdocument.getElementById(container).style.left = (winWidth - document.getElementById(container).offsetWidth)/2;\t\t\t\r\n\t\tif(parseInt(document.getElementById(container).style.left) > 232 || parseInt(document.getElementById(container).style.left) < 200){\t\t\t\r\n\t\t\tdocument.getElementById(container).style.left = \"232px\";\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t}\t\t\t\r\n\t\tif(document.getElementById(container).style.top == \"\")\r\n\t  \t\tdocument.getElementById(container).style.top = (winHeight - 50)/2 - document.getElementById(container).offsetHeight;\r\n\t  \tif(parseInt(document.getElementById(container).style.top) < 0){\r\n            document.getElementById(container).style.top = 50;\r\n\t  \t}\r\n\t}\r\n\tif(navigator.appName == \"Microsoft Internet Explorer\" ){\r\n\t\tdocument.body.scrollTop = \"0\";\r\n\t\tdocument.getElementById(container).style.right = parseInt(document.getElementById(container).style.left)+ document.getElementById(container).offsetWidth + \"px\";\r\n\t}\t\r\n}\r\n\r\nfunction getDate(str, FromTo)\r\n{\r\n startArray1 = new Array();\r\n date = new Date();\r\n\r\n var checkFormat = checkDateTimeFormat(str, FromTo);\r\n if(checkFormat == false)\r\n return false;\r\n\r\n /*timeArray = str.split(\" \");\r\n var startStr1 = timeArray[0];\r\n var startStr2 = timeArray[1];*/\r\n startArray1 = str.split(\"-\");\r\n var yr = startArray1[0];\r\n var mon = startArray1[1];\r\n var day = startArray1[2];\r\n \r\n if(day<1 || day>31 || mon<1 || mon>12 || yr<1 || yr<1980)\r\n");
      out.write(" {\r\n alert(\"Please enter a valid \"+FromTo+\"[YYYY-MM-DD]\");\r\n return false;\r\n }\r\n\r\n if((mon==2) && (day>29)) //checking of no. of days in february month\r\n {\r\n alert(\"Please enter a valid \"+FromTo+\"[YYYY-MM-DD]\");\r\n return false;\r\n }\r\n\r\n if((mon==2) && (day>28) && ((yr%4)!=0)) //leap year checking\r\n {\r\n alert(\"Please enter a valid \"+FromTo+\"[YYYY-MM-DD]\");\r\nreturn false;\r\n } \r\n\r\n date = new Date(yr, (mon-1), day);\r\n return date;\r\n}\r\n\r\nfunction checkDateTimeFormat(timeStr, fromto)\r\n{\r\n var dateTimeRe = /^(\\d{4})-(\\d{1,2})-(\\d{2})$/;\r\n var start = document.timeForm.startdate;\r\n var end = document.timeForm.enddate;\r\n\r\n\r\n if(!dateTimeRe.test(timeStr))\r\n {\r\n alert(\"Please enter a valid \"+fromto+\"[YYYY-MM-DD]\");\r\n return false;\r\n }else\r\n {\r\n return true;\r\n }\r\n\r\n}\r\nfunction createCookie(name,value,days)\r\n{\r\n if (days)\r\n {\r\n var date = new Date();\r\n date.setTime(date.getTime()+(days*24*60*60*1000));\r\n var expires = \"; expires=\"+date.toGMTString();\r\n }\r\n else var expires = \"\";\r\n document.cookie = name+\"=\"+value+expires+\"; path=/\";\r\n");
      out.write("}\r\n\r\nfunction readCookie(name)\r\n{\r\n var nameEQ = name + \"=\";\r\n var ca = document.cookie.split(';');\r\nfor(var i=0;i < ca.length;i++)\r\n {\r\n var c = ca[i];\r\n while (c.charAt(0)==' ') c = c.substring(1,c.length);\r\n if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);\r\n }\r\n return null;\r\n}\r\n\r\nfunction eraseCookie(name)\r\n{\r\n createCookie(name,\"\",-1);\r\n}\r\n\r\nfunction checkEnter(e)\r\n{\r\n var characterCode;\r\n if(e && e.which){\r\n characterCode = e.which;\r\n }else{\r\n characterCode = e.keyCode;\r\n }\r\n if(characterCode == 13){ passSelectedValues(); }\r\n}\r\nfunction syncDate(){\r\n\tvar dateTimeRe = /^(\\d{4})-(\\d{1,2})-(\\d{2})$/;\r\n \tvar start = document.timeForm.startdate.value;\r\n \tvar end = document.timeForm.enddate.value;\r\n \tif(eval(\"document.timeForm.enddate\").value == ''){\r\n \t\tdocument.getElementById('dateField1').value = document.timeForm.startdate.value;\r\n \t}\r\n \tif(!dateTimeRe.test(start))\r\n \t{\r\n \t\talert(\"Please enter a valid Start Date [YYYY-MM-DD]\");\r\n \t} else {\r\n \t\tvar dt1 = getDate(start, 'Start Date');\r\n");
      out.write(" \t\tvar dt2 = getDate(end, 'end Date');\r\n \t \tif(dt1 > dt2 ){\r\n \t\t\tdocument.getElementById('dateField1').value = document.timeForm.startdate.value;\r\n \t \t}\r\n \t \t\r\n \t}\r\n }\r\n \r\nfunction backupfrequency(){\r\n\t\r\n\tvar ftpserver= document.getElementById(\"ftpserverip\");\t\r\n\tvar ftppassword= document.getElementById(\"ftppassword\");\r\n\tvar ftpusername=document.getElementById(\"ftpusername\");\t\r\n\tif(document.backupform.backupfreq[0].checked){\r\n\t\tftpserver.disabled='disabled';\r\n\t\tftppassword.disabled='disabled';\r\n\t\tftpusername.disabled='disabled';\t\t\r\n\t}\t\r\n\tif(document.backupform.backupfreq[1].checked){\r\n\t\tftpserver.disabled='';\r\n\t\tftppassword.disabled='';\r\n\t\tftpusername.disabled='';\r\n\t}\t\r\n}\r\n\r\nfunction submitForm(){\r\n\tvar form=document.backupform;\r\n\tif(document.backupform.backupfreq[1].checked){\r\n\t\tif(form.ftpserverip.value ==''){\r\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter  FTP Server IP"));
      out.write("');\r\n\t\t\tform.ftpserverip.focus();\r\n\t\t\treturn false;\r\n\t\t}\r\n\t\tif(form.ftppassword.value == ''){\r\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter Password"));
      out.write("');\r\n\t\t\tform.ftppassword.focus();\r\n\t\t\treturn false;\r\n\t\t}\r\n\t\tif(form.ftpusername.value == ''){\r\n\t\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter username"));
      out.write("');\r\n\t\t\tform.ftpusername.focus();\r\n\t\t\treturn false;\r\n\t\t}\t\t\r\n\t}\r\n\tif(document.backupform.backupfreq[0].checked){\r\n\t\tform.ftpserverip.value = '';\r\n\t\tform.ftppassword.value = '';\r\n\t\tform.ftpusername.value = '';\r\n\t}\r\n\tvar con = confirm('");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to update configuration?"));
      out.write("');\r\n\treturn con;\r\n}\r\n\r\n\r\n</script>\r\n</head>\r\n<body>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("\r\n    \r\n    <div class=\"maincontent\" id=\"main_content\">    \r\n\t\t<div class=\"reporttitlebar\">\r\n\t\t\t<div class=\"reporttitlebarleft\"></div>\r\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Backup configuration"));
      out.write("</div>\r\n\t\t</div>\r\n\t\t<br><br>     \r\n\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"backupform\" onsubmit=\"return submitForm();\">\r\n\t<input type=hidden name=appmode value=\"");
      out.print(ApplicationModes.SCHEDULE_BACKUP);
      out.write("\">\r\n\t<table border=\"0\" width=\"50%\" cellpadding=\"2\" cellspacing=\"2\">\r\n\t");

	if(iMode==ApplicationModes.SCHEDULE_BACKUP){
		if(!"".equals(pmessage)){
		
      out.write("\r\n\t\t<tr>\r\n\t\t\t<td class=\"posimessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(pmessage);
      out.write("</td>\r\n\t\t</tr>\r\n\t\t");

		}
	
      out.write('\r');
      out.write('\n');
      out.write('	');

	if(!"".equals(nmessage)){
	
      out.write("\r\n\t<tr>\r\n\t\t<td class=\"nagimessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(nmessage);
      out.write("</td>\r\n\t</tr>\r\n\t");

	 }
		}
	
      out.write("\t\r\n\t\r\n\t<td>\r\n\t<table border=\"0\" cellpadding=\"2\" cellspacing=\"2\">\r\n\t\t\t<tr>\r\n\t\t\t\t<td class=\"textlabels\" >&nbsp;\r\n\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Backup Frequency"));
      out.write("\r\n\t\t\t\t</td>\r\n\t\t\t\t<td>\r\n\t\t\t\t  <input type=\"radio\"  name=\"backupfreq\" id=\"backupfreq\" onclick=\"backupfrequency()\" value=\"-1\"");
      out.print("-1".equals(backupfreq)?"checked='checked'":"");
      out.write("/>\r\n\t\t\t\t  <label>");
      out.print(TranslationHelper.getTranslatedMessge("Never"));
      out.write("</label>\r\n\t\t\t\t  <input type=\"radio\"  name=\"backupfreq\" id=\"backupfreq\" onclick=\"backupfrequency()\" value=\"1\"");
      out.print("1".equals(backupfreq)?"checked='checked'":"");
      out.write(" />\r\n\t\t\t\t  <label>");
      out.print(TranslationHelper.getTranslatedMessge("Daily"));
      out.write("</label>&nbsp;&nbsp;\r\n\t\t\t\t\t");

					if("1".equals(backupfreq) && !"".equals(lastbackupdatetime)){
					
      out.write("\t\r\n\t\t\t\t     <b><label>");
      out.print(TranslationHelper.getTranslatedMessge("Last Backup Taken On "+lastbackupdatetime));
      out.write("</label></b>\r\n\t\t\t\t\t");
 					
					}				
					
      out.write("\t\r\n\t\t\t\t  \r\n\t\t\t\t</td>\r\n\t\t\t</tr>\r\n\t\t\t<tr >\r\n\t\t\t\t<td class=\"textlabels\" >&nbsp;\r\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("FTP Server IP"));
      out.write("<font class=\"compfield\">*</font>\r\n\t\t\t\t</td>\r\n\t\t\t\t<td >\r\n\t\t\t\t\t<input type=\"text\" class=\"datafield\" name=\"ftpserverip\" id=\"ftpserverip\" value=\"");
      out.print(ftpServer);
      out.write("\" style=\"width:180px\"/>\r\n\t\t\t\t</td>\r\n\t\t\t</tr>\r\n\t\t\t<tr>\r\n\t\t\t\t<td class=\"textlabels\" width=\"50%\">&nbsp;\r\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("User Name"));
      out.write("<font class=\"compfield\">*</font>\r\n\t\t\t\t</td>\r\n\t\t\t\t<td ><input type=\"text\" class=\"datafield\" name=\"ftpusername\" id=\"ftpusername\" value=\"");
      out.print(ftpUserName);
      out.write("\" style=\"width:180px\" /></td>\r\n\t\t\t</tr>\r\n\t\t\t<tr >\r\n\t\t\t\t<td class=\"textlabels\" width=\"50%\">&nbsp;\r\n\t\t\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Password"));
      out.write("<font class=\"compfield\">*</font>\r\n\t\t\t\t</td>\r\n\t\t\t\t<td><input type=\"password\" class=\"datafield\" name=\"ftppassword\" id=\"ftppassword\"  value=\"");
      out.print(ftpPassword);
      out.write("\" style=\"width:180px\" /></td>\r\n\t\t\t</tr>\t\t\t\t\r\n\t\t    <tr>\r\n\t\t\t\t<td></td>\r\n\t\t\t\t<td align=\"left\">\t\r\n\t   \t\t\t<input class=\"criButton\" type=\"submit\" name=\"btnsubmit\" value=\"Save\"/>\r\n\t   \t\t\t</td>\r\n\t   \t</table>\r\n\t   \t   </td>\r\n\t   </table>\r\n\t</form>\r\n\t\t<div class=\"reporttitlebar\">\r\n\t\t\t<div class=\"reporttitlebarleft\"></div>\r\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Restore"));
      out.write("</div>\r\n\t\t</div>\r\n\t\t<br>\r\n\t\t<br>\r\n\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/calendar.js\"></script>\r\n\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/calendar-en.js\"></script>\r\n\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/calendar-setup.js\"></script>\r\n\t\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" name=\"timeForm\" method=\"post\" style=\"margin:0px;\" onsubmit=\"return passSelectedValues();\">\r\n\t\t<input type=hidden name=appmode value=\"");
      out.print(ApplicationModes.RESTORE_REQUEST);
      out.write("\">\r\n\t<div >\r\n\t\t<table border=\"0\" width=\"50%\" cellpadding=\"2\" cellspacing=\"2\">\r\n\t");

	if(iMode==ApplicationModes.RESTORE_REQUEST){
		if(!"".equals(pmessage)){
		
      out.write("\r\n\t\t<tr>\r\n\t\t\t<td class=\"posimessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(pmessage);
      out.write("</td>\r\n\t\t</tr>\r\n\t\t");

		}
	
      out.write('\r');
      out.write('\n');
      out.write('	');

	if(!"".equals(nmessage)){
	
      out.write("\r\n\t<tr>\r\n\t\t<td class=\"nagimessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(nmessage);
      out.write("</td>\r\n\t</tr>\r\n\t");

	 }
		}
	
      out.write("\t\r\n\t<td> \r\n\t <table border=\"0\" cellpadding=\"2\" cellspacing=\"2\">\r\n\t\t  \t<tbody style=\"border:none\">\r\n\t\t<tr align=\"right\" valign=\"middle\">\r\n\t\t\t<td class=\"textlabels\" >&nbsp; \r\n\t\t\t");
      out.print(TranslationHelper.getTranslatedMessge("Start Date"));
      out.write("</td>\r\n\t\t\t<td align=\"left\"> \r\n\t\t  \t\t<input name=\"startdate\" id=\"dateField\" class=\"datafield\" value='");
      out.print(startDate);
      out.write("' style=\"width:100px\" onKeyPress=\"checkEnter(event)\" type=\"text\"> <!--  onchange=\"syncDate();\">-->\r\n\t            <a href=\"javascript:;\">\r\n\t            \t<img src=\"../images/calendar.png\" id=\"startTrigger\" align=\"absmiddle\" border=\"0\" width=16px height=16px>\r\n\t            </a>\r\n\t\t\t\t<script type=\"text/javascript\">\r\n\t\t\t\t          var today = new Date();\r\n\t\t\t\t          today.setDate(today.getDate()-1);\r\n\t                      Calendar.setup({\r\n\t                       inputField     :    \"dateField\",     // id of the input field\r\n\t                       ifFormat       :    \"%Y-%m-%d\",      // format of the input field\r\n\t                       showsTime\t  :    false,\t\r\n\t                       button         :    \"startTrigger\",  // trigger for the calendar (button ID)\r\n\t                       timeFormat     :    \"24\",\r\n\t                       weekNumbers    :    false,\r\n\t                       align          :    \"B1\",           // alignment (defaults to \"Bl\")\r\n\t                       singleClick    :    true,\r\n\t                       timeFormatOnToday : 1,\r\n");
      out.write("\t                       dateStatusFunc :function (date) \r\n\t                       { \r\n\t                       return date.getTime() > today.getTime()&& date.getDate() != today.getDate();\r\n\t                       }\r\n\t                       });\r\n\t            </script>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t\t<tr align=\"right\" valign=\"middle\"> \r\n\t     \t<td class=\"textlabels\" >&nbsp; \r\n\t     \t");
      out.print(TranslationHelper.getTranslatedMessge("End Date"));
      out.write("</td>\r\n\t        <td  align=\"left\">\r\n\t        \t<input name=\"enddate\" id=\"dateField1\" class=\"datafield\" value='");
      out.print(endDate);
      out.write("' style=\"width:100px\" onKeyPress=\"checkEnter(event)\" type=\"text\">\r\n\t            <a href=\"javascript:;\">\r\n\t            \t<img src=\"../images/calendar.png\" id=\"startTrigger1\" align=\"absmiddle\" border=\"0\" width=\"16px\" heightL=\"16px\">\r\n\t\t\t\t</a>\r\n\t            <script type=\"text/javascript\">\r\n\t           \t\t var today = new Date();\r\n\t           \t\ttoday.setDate(today.getDate()-1);\r\n\t\t\t\t\t Calendar.setup({\r\n\t\t\t\t\t inputField     :    \"dateField1\",     // id of the input field\r\n                     ifFormat       :    \"%Y-%m-%d\",      // format of the input field\r\n                     showsTime\t    :    false,\r\n\t\t\t\t\t button         :    \"startTrigger1\",  // trigger for the calendar (button ID)\r\n\t\t\t\t\t timeFormat     :    \"24\",\r\n\t\t\t\t\t weekNumbers     :    false,\r\n\t\t\t\t\t align          :    \"Bl\",           // alignment (defaults to \"Bl\")\r\n\t\t\t\t\t singleClick    :    true,\r\n\t\t\t\t\t timeFormatOnToday : 0,\r\n\t\t\t\t\t dateStatusFunc :function (date)\r\n\t\t\t\t\t { \r\n\t\t\t\t\t return date.getTime() > today.getTime() && date.getDate() != today.getDate();\r\n");
      out.write("\t\t\t\t\t }\r\n\t\t\t\t\t });\r\n\t            </script> \r\n\t\t\t</td>           \r\n\t\t</tr> \r\n\t\t<tr> \r\n\t\t\t<td>&nbsp;</td>\r\n\t\t\t<td>&nbsp;</td>\r\n\t\t</tr> \r\n\t\t<tr>\r\n\t\t\t\t\r\n\t\t\t\t<td></td>\r\n\t\t\t\t<td>\r\n\t\t\t\t\t<input class=\"criButton\" type=\"submit\" name=\"Restorebtn\" value=\"Restore\">\t\t\t\r\n\t\t\t\t</td>\r\n\t\t\t\t\r\n\t\t</tr>     \r\n\t\t</tbody>\r\n\t\t</table>  \r\n\t\t</td>    \r\n\t</table>\r\n\t</div>\r\n\t</form>\t\r\n\t\t</div>\r\n\t\t\t\r\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\r\n\t<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\r\n\t<div id=\"progressbar\"  class=\"TB_window\" style=\"left: 250px; top: 200px;\">\r\n\t\t\t\t<table align=\"center\">\r\n\t\t\t\t\t<tr>\r\n\t\t\t\t\t\t<td align=\"center\"><img alt=\"Loading\"\r\n\t\t\t\t\t\t\tsrc=\"");
      out.print(request.getContextPath());
      out.write("/images/progress.gif\" /></td>\r\n\t\t\t\t\t</tr>\r\n\t\t\t\t\t<tr>\r\n\t\t\t\t\t\t<td><b>");
      out.print(TranslationHelper.getTranslatedMessge("Restoring, Please wait..."));
      out.write("</b></td>\r\n\t\t\t\t\t</tr>\r\n\t\t\t\t</table>\r\n\t\t\t</div>\t\r\n</body>\r\n</html>\r\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in ScheduleBackupRestore.jsp : "+e,e);
}

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
