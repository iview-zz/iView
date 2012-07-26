<!-- ***********************************************************************
*  Cyberoam iView - The Intelligent logging and reporting solution that 
*  provides network visibility for security, regulatory compliance and 
*  data confidentiality 
*  Copyright  (C ) 2009  Elitecore Technologies Ltd.
*  
*  This program is free software: you can redistribute it and/or modify 
*  it under the terms of the GNU General Public License as published by 
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*  
*  This program is distributed in the hope that it will be useful, but 
*  WITHOUT ANY WARRANTY; without even the implied warranty of 
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
*  General Public License for more details.
*  
*  You should have received a copy of the GNU General Public License 
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*  
*  The interactive user interfaces in modified source and object code 
*  versions of this program must display Appropriate Legal Notices, as 
*  required under Section 5 of the GNU General Public License version 3.
*  
*  In accordance with Section 7(b) of the GNU General Public License 
*  version 3, these Appropriate Legal Notices must retain the display of
*   the "Cyberoam Elitecore Technologies Initiative" logo.
*********************************************************************** -->

<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="org.cyberoam.iview.beans.FileHandlerBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.TimeZone"%>
<%@page import="org.cyberoam.iviewdb.helper.ConnectionPool"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.helper.LoadDataHandler"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.utility.IViewPropertyReader"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.utility.ByteInUnit"%>
<%@page import="org.cyberoam.iview.helper.BackupDataHandler"%>
<%@page import="org.cyberoam.iview.helper.RestoreDataHandler"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupRelationBean"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.authentication.beans.*"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
	try {
		if (CheckSession.checkSession(request, response) < 0) {
			return;
		}

		int iPageno = 1;
		String strPageno = request.getParameter("pageno");
		if (strPageno != null && !"".equalsIgnoreCase(strPageno)) {
			iPageno = Integer.parseInt(strPageno);
		}
		int iLimit = 5;
		String strLimit = request.getParameter("limit");
		if (strLimit != null) {
			iLimit = Integer.parseInt(strLimit);
		}

		// If request to extract row log otherwise null value
		String startrowlogfile = request.getParameter("startrowlogfile");
		String endrowlogfile = request.getParameter("endrowlogfile");
		if (startrowlogfile == null) {
			startrowlogfile = "";
		}
		if (endrowlogfile == null) {
			endrowlogfile = "";
		}

		boolean isBackupProcessRunning = false;
		if (!BackupDataHandler.isStopped()) {
			String backstop = request.getParameter("backupstop");
			if (backstop != null && "true".equalsIgnoreCase(backstop)) {
				BackupDataHandler.setStopFlag(true);
			} else {
				isBackupProcessRunning = true;
			}
		}

		if (BackupDataHandler.isStopped())
			isBackupProcessRunning = false;

//		session.setAttribute("statusCheck", request.getParameter("statusCheck"));
		
		boolean isRestoreProcessRunning = false;
		if (!RestoreDataHandler.isStopped()) {
			String restorestop = request.getParameter("restorestop");
			if (restorestop != null && "true".equalsIgnoreCase(restorestop)) {
				session.setAttribute("statusCheck","3");
				RestoreDataHandler.setStopFlag(true);
			} else {
				isRestoreProcessRunning = true;
			}
		}
		

		String formattedstartdate = request.getParameter("formattedstartdate");
		if (formattedstartdate == null || "NULL".equalsIgnoreCase(formattedstartdate) || "".equalsIgnoreCase(formattedstartdate)) {
			formattedstartdate = (new SimpleDateFormat("dd, MMM yyyy")).format(new Date());
		}
		String formattedenddate = request.getParameter("formattedenddate");
		if (formattedenddate == null || "NULL".equalsIgnoreCase(formattedenddate) || "".equalsIgnoreCase(formattedenddate)) {
			formattedenddate = (new SimpleDateFormat("dd, MMM yyyy")).format(new Date());
		}
		String qString = request.getQueryString();
		if (qString == null) {
			qString = "";
		}
%>

<html>
<head>
<title><%=iViewConfigBean.TITLE%></title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/tabs.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/container.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/configuration.css">
<script src="<%=request.getContextPath()%>/javascript/container.js"></script>
<script src="<%=request.getContextPath()%>/javascript/combo.js"></script>
<SCRIPT SRC="<%=request.getContextPath()%>/javascript/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/popupform.js"></SCRIPT>
<style type="text/css">
.loadButton {
	border: 0px;
	background: transparent;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	text-decoration: underline;
}

.loadButton1 {
	border: 0px;
	background: transparent;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	text-decoration: none;
}
</style>
<script type="text/javascript" language="javascript">
	var URL = "<%=request.getContextPath()%>/webpages/backuprestore.jsp?<%=qString%>";
	var iPageno = '<%=iPageno%>';
	var iLastPage = null;
	var http_request = false;
	var childwindow;
	var cnt = 0;
	var timerVal;
	var filenotfountcount = 0;
	var xmlHttp = null;
   
	window.onload = function (evt) {
		setWidth();			
		checkLoading();	
	}		
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}
	function changeColor(mode,element,inTable){
		if(mode == '1'){
			element.className="trlight1";
			document.getElementById(inTable).className = "innerTableData2";
		} else {
			element.className="trlight";
			document.getElementById(inTable).className = "innerTableData1";
		}
	}

	//Takes the backup of the checkboxes(6hours) selected and for selected devices for a particular day
   	function BackupData(){
		var filelisttmp="";
		var filelist="";		
		var ischeck=false;		
		var criteria="";

   		for(var j=0;j<viewarchivedetail.length;j++){ 
		   filelisttmp="";
		   if (viewarchivedetail[j].type == "checkbox") {
		     	if(viewarchivedetail[j].checked == true ){			     	
		     		if(!viewarchivedetail[j].disabled){
			     		ischeck	= true;
			     		if(filelist == ""){
		     				filelist = viewarchivedetail[j].value;
			     		}else{
			     			filelist = filelist + "," + viewarchivedetail[j].value;
			     		}
		    	 	}
		   		} 		   
			}
		}
		
		if(!ischeck){
			alert("<%=TranslationHelper.getTranslatedMessge("Select atleast one check box to take Backup")%>");		
			return false;
		}
		document.viewarchivedetail.indexfilelist.value = filelist;
		document.viewarchivedetail.appmode.value = "<%=ApplicationModes.ARCHIEVE_BACKUP_REQUEST%>";
		document.viewarchivedetail.submit();
		return true;
	}

	function dofilter(){
		location.href="/iview/webpages/backuprestore.jsp?startdate="+document.viewarchivedetail.startdate.value+"&enddate="+document.viewarchivedetail.enddate.value+"&formattedstartdate="+document.viewarchivedetail.displaystartdate.value+"&formattedenddate="+document.viewarchivedetail.displayenddate.value;
	}
	function createXMLHttpRequest(){
        if(typeof XMLHttpRequest != "undefined"){
	        xmlHttp = new XMLHttpRequest();
	    }
	    else if(typeof window.ActiveXObject != "undefined"){
	        try {
	            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP.4.0");
	        }
	        catch(e){
	            try {
	                xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	            }
	            catch(e){
	                try {
	                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	                }
	                catch(e){
	                    xmlHttp = null;
	                }
	            }
	        }
	    }
	    return xmlHttp;
	}
	function getTheContent(URL){
	    if(createXMLHttpRequest()){
			if("<%=endrowlogfile%>" == "" && "<%=startrowlogfile%>" == "" && cnt==0){
				cnt=1;
			}
			cnt++;
			xmlHttp.open("GET", URL+"?"+cnt++, true);
			xmlHttp.onreadystatechange = function() { contentIsReady(xmlHttp); };
			xmlHttp.send(null);
	    }
	}
	
	function contentIsReady(xmlHttp){
	    if(xmlHttp && xmlHttp.readyState == 4){
			alertContents(xmlHttp);
	        xmlHttp = null;
	    }
	}
	function closeWindow(){
	<%if ("yes".equalsIgnoreCase(request.getParameter("processrunning"))) {%>
		clearTimeout(timerVal);
		if("<%=endrowlogfile%>" == "" && "<%=startrowlogfile%>" == ""){
			//timerVal=setTimeout('functionCall()',2000);
			location.href='<%=request.getContextPath()%>/webpages/backuprestore.jsp?stop=yes&startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value;
		}else{
			document.progressbarform.startdate.value = document.viewarchivedetail.startdate.value
			document.progressbarform.enddate.value = document.viewarchivedetail.enddate.value
			document.progressbarform.submit();
		}
		return;
	<%} else {%>
		location.href='<%=request.getContextPath()%>/webpages/backuprestore.jsp?startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value;
	<%}%>
	}

	function doSomething() {
		timerVal=setTimeout('loadFunctionCall()',1000);
	}
	
	function replaceQueryString(url,param,value) {
		var re = new RegExp("([?|&])" + param + "=.*?(&|$)","i");
		if (url.match(re)) {
			return url.replace(re,'$1' + param + "=" + value + '$2');
		} else {
			return url + '&' + param + "=" + value;
		}
	}
	function selectCombo(id,index){
		ele = document.getElementById("Combo_item"+id+"_"+index);
		var limit = ele.innerHTML;
		URL = replaceQueryString(URL,'limit',limit);	
		document.location.href = URL;
	}
	function movePage(num){
		URL = replaceQueryString(URL,'pageno',num);	
		document.location.href = URL;
	}
	function  jumpPage(){
		var pageNo = document.getElementById("gotopage").value;
		if(pageNo == null || isNaN(pageNo) || pageNo < 1 || pageNo > iLastPage){
			alert("<%=TranslationHelper.getTranslatedMessge("Please enter valid page no.")%>");
		}else{
			URL = replaceQueryString(URL,'pageno',pageNo);	
			document.location.href = URL;
		}
	}
	function alertContents(http_request) {
		var regExp=/^[0-9]+$/
		if (http_request.readyState == 4) {
        	if (http_request.status == 200) {
           		if(http_request.responseText != -1){
					if(isNaN(http_request.responseText) == false){
						var obj=document.getElementById("first");
						var obj1=document.getElementById("second");
						var obj2=document.getElementById("data");
						var resWidth;
						if(http_request.responseText == 0 || http_request.responseText == '')
							resWidth = 1;
						else if(http_request.responseText == 100){
							closeWindow();		
							return;
						}
						else resWidth = http_request.responseText;
						obj2.innerHTML = '&nbsp;'+resWidth+'%';
						obj.width = resWidth + '%';
						obj1.width = (100 - resWidth) + '%';
						filenotfountcount=0;
					}
				}else{
					filenotfountcount++;
				}
				if(http_request.responseText == 100){	
					closeWindow();		
					return;			
				}
				if(filenotfountcount > 10){
					return;
				}
           		doSomething();
           } else {
               alert("<%=TranslationHelper.getTranslatedMessge("There is a problem with the request.")%> ");
           }
       }
    }
	
	function getResponse(xmlReq,id){		
		if(xmlReq!=null){			
			var rootObj=xmlReq.getElementsByTagName("root").item(0);
			var msgObj=rootObj.getElementsByTagName("msg").item(0);
			var statusObj=rootObj.getElementsByTagName("status").item(0);
			var data=msgObj.childNodes[0].data;
			var status=statusObj.childNodes[0].data;
			var divObj=document.getElementById("statusDivMain");
			divObj.style.display="block";
			var div=document.getElementById("statusDiv");
			div.innerHTML=data;			
			if(status==1){
				setTimeout("GetStatusValue()",500);
			}else{
				setTimeout("hideStatus()",3000);				
			}
		}			
	}
	
	function hideStatus(){
		var divObj=document.getElementById("statusDivMain");
		divObj.style.display="none";
		window.location.href='<%=request.getContextPath()%>/webpages/backuprestore.jsp';		
	}

	//opens the popup box depending upon the choice for backedup files and to restore files
	function openFiles(id){	
		var head=document.getElementById("contentheader");
		head.style.zIndex="111";
	
		if(id=='1'){			
			URL = '<%=request.getContextPath()%>/webpages/backupfiles.jsp';
		}
		else{
			URL = '<%=request.getContextPath()%>/webpages/restorefiles.jsp';
		}			
		
		handleThickBox(1,'backuprestore',500);		
		URL = '<%=request.getContextPath()%>/webpages/backuprestore.jsp?';	
	}
		
	//adds a row while uploading multiple files for restoration.
	function addRow() {
		var table = document.getElementById("tbldata");

		var row=document.createElement("TR");
		row.height="25px";
		row.id=table.rows.length+2;
	
		var cell1=document.createElement("TD");
		cell1.className="tddata";
		cell1.innerHTML="<input type='file' name='filename'>"
	
		var cell2=document.createElement("TD");
		cell2.className="tddata";
		cell2.innerHTML="<center><input type='button' onclick=deleteRow('" + row.id + "') class='loadButton' value='Delete'></center>"	
	
	    row.appendChild(cell1);	
		row.appendChild(cell2);	
	    table.appendChild(row);
	}

	//deletes a row from restorefiles page
	function deleteRow(rowIndex) {
		var table = document.getElementById("tbldata");
		var row = document.getElementById(rowIndex);	
		table.removeChild(row);
	}
	//to confirm the action of delete from the server containing the backedup files.
	function confirmAction(x) {
		var flag=0;
		for(var i=1,l=x.form.length; i<l; i++){
			if(x.form[i].type == 'checkbox' && x.form[i].checked==true){
				flag=1;
				break;
			}
		}
		if(flag==0){
			alert("Select atleast one file to delete");		
			return false;
		}
		if(confirm("Do you want to delete?")==true){    
	    	return true;
		}  
		else{
			return false;
		}  
	}

	function checkRestore(x){
		var restorebtn=document.getElementsByName("filename");
		for(var i=0;i<restorebtn.length; i++){				
			if(restorebtn[i].value!=""){
				return true;
			}
		}
		alert("No files selected to restore");
		return false;	 
	}	
	
	function loadBackupCall(){
		var overlay = document.getElementById("TB_overlay");
		overlay.style.display = '';
		cnt++;
<%		if (BackupDataHandler.isStoppedThread() == true) {
			isBackupProcessRunning = false;
				}%>
		if(createXMLHttpRequest()){
			cnt++;
			xmlHttp.open("GET", "<%=request.getContextPath()%>/AjaxController?givebackuptime=true&counter="+cnt, true);
			xmlHttp.onreadystatechange = function() { backupStatus(xmlHttp); }
			xmlHttp.send(null);
	    }
	}
      
	function backupStatus(xmlHttp){		
	    if(xmlHttp && xmlHttp.readyState == 4){
			//alertContents(xmlHttp);
			var regExp=/^[0-9]+$/
			if (xmlHttp.readyState == 4) {
        		if (xmlHttp.status == 200) {
           			if(xmlHttp.responseText != -1){
               			if(isNaN(xmlHttp.responseText) == false){
							//alert('##' + xmlHttp.responseText + '##');
							//if(cnt>=500){
							
							//} else 
							
							if(xmlHttp.responseText == 0){
								
								timerVal=setTimeout('loadBackupCall()',1000);
							}
							else {								
								location.href='<%=request.getContextPath()%>/webpages/backuprestore.jsp?statusCheck=1&backupstop=true';
								return;
							}
						}
					} else {
						alert("<%=TranslationHelper.getTranslatedMessge("There is a problem with the request.")%> ");
					}
       			}
	        	xmlHttp = null;
	    	}
		}
	}

		function loadRestoreCall(){
		var overlay = document.getElementById("TB_overlay");
		overlay.style.display = '';
		cnt++;
		
		if(createXMLHttpRequest()){
			cnt++;
			xmlHttp.open("GET", "<%=request.getContextPath()%>/AjaxController?giverestoretime=true&counter="+cnt, true);
			xmlHttp.onreadystatechange = function() { restoreStatus(xmlHttp); }
			xmlHttp.send(null);
	    }
	}
      
	function restoreStatus(xmlHttp){		
	    if(xmlHttp && xmlHttp.readyState == 4){
			//alertContents(xmlHttp);
			var regExp=/^[0-9]+$/
			if (xmlHttp.readyState == 4) {
        		if (xmlHttp.status == 200) {
           			if(xmlHttp.responseText != -1){
               			if(isNaN(xmlHttp.responseText) == false){
							//alert('##' + xmlHttp.responseText + '##');
							//if(cnt>=500){
							
							//} else 
							if(xmlHttp.responseText == 0){ 
								timerVal=setTimeout('loadRestoreCall()',1000);
							}else {
								location.href='<%=request.getContextPath()%>/webpages/backuprestore.jsp?statusCheck=3&restorestop=true';
								return;
							} 
						}
					} else {
						alert("<%=TranslationHelper.getTranslatedMessge("There is a problem with the request.")%> ");
					}
       			}
	        	xmlHttp = null;
	    	}
		}
	}
	
	function checkLoading(){
<%		if (isRestoreProcessRunning) {
			out.println("loadRestoreCall();");
		}
		else if (isBackupProcessRunning) {
			out.println("loadBackupCall();");
		} else if (isBackupProcessRunning == false && BackupDataHandler.isStoppedThread() == false) {
			isBackupProcessRunning = true;
			BackupDataHandler.setStopFlag(true);%>
			alert("Backup Process will be aborted after the completion of ongoing 6hr backup");
<%			out.println("loadBackupCall();");
		} else {
			isBackupProcessRunning = false;
		}%>
	}

	function selectAll(x) {
		for(var i=1,l=x.form.length; i<l; i++){
			if(x.form[i].type == 'checkbox' && x.form[0].checked==true){
				x.form[i].checked=true;
			}
			else{
				x.form[i].checked=false;
			}
		}
	}

	function DeSelectAll(x){
		for(var i=1,l=x.form.length; i<l; i++){
			if(x.form[i].type == 'checkbox' && x.form[i].checked==false){
				x.form[0].checked=false;
				break;
			}
		}
	}


	function SelectAllCheckbox(stringDay){
		var chk = document.getElementById(stringDay);
		if(chk.checked==false){
			for(i=0;i<4;i++){
				var chk1 = document.getElementById(stringDay+i);
				if(parseInt(chk1.name.substr(6))>0){
						chk1.disabled=false;
				}
			}
			
		}


		var i;
		for(i=0;i<4;i++){
			var chk1 = document.getElementById(stringDay+i);

				if(chk.checked==true)
					chk1.disabled=true;
		}
	}
	
	
</script>
</head>
<body>
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
<div class="TB_window" id="backuprestore"></div>
<div class="maincontent" id="main_content">
<jsp:include page="Date.jsp" flush="true">
<jsp:param name="device"	value="true"></jsp:param>
</jsp:include> 
<%
 	String startdate = (String) session.getAttribute("startdate");
 	String enddate = (String) session.getAttribute("enddate");
%>
<div class="reporttitlebar">
<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Backup Management")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div class="reporttimetitle"><b>From:</b> <font class="reporttime"><%=session.getAttribute("startdate")%></font>
<br>
<b>To:</b> <font class="reporttime"><%=session.getAttribute("enddate")%></font>
</div>
<div class="restore"><input align=right type="button" name="restore" onClick="openFiles('2')"
	value="<%=TranslationHelper.getTranslatedMessge("Restore Files")%>" class="criButton" style="height: 20px" /></div>
<%	
	File dstPath=new File(IViewPropertyReader.BackupDIR);
	if(dstPath.list().length!=0){
%>			
<div class="backup"><input align=right type="button" name="backup" onClick="openFiles('1')" 
	value="<%=TranslationHelper.getTranslatedMessge("Download Backup Files")%>" class="criButton" style="height: 20px" /> &nbsp;</div>
<%
	}
%>
</div>	
<%
	if (session.getAttribute("statusCheck") != null) {
%>
		<table cellpadding="0" cellspacing="0" width="100%" border="0" class="TableData" style="padding: 3px 0pt 0pt 3px;">
<%
		if (session.getAttribute("statusCheck").equals("1")) {
%>
			<tr>
			<td align="left" class="posimessage">
			<%=TranslationHelper.getTranslatedMessge("Backup file created successfully, to download press \"Download Backup Files\" button")%></td>
			</tr>

			<script type="text/javascript">
				openFiles('1');
			</script>

<%
		} else if (session.getAttribute("statusCheck").equals("2")) {
%>
			<tr>
			<td align="left" class="posimessage"><%=session.getAttribute("fileName") + " " + TranslationHelper.getTranslatedMessge("deleted successfully")%></td>
			</tr>
<%
		} else if (session.getAttribute("statusCheck").equals("3")) {


			int loaded = RestoreDataHandler.getLoaded();
			int notloaded = RestoreDataHandler.getNotLoaded();
			if (loaded > 0) {
%>
			<tr>
				<td align="left" class="posimessage"><%=loaded + TranslationHelper.getTranslatedMessge(" file(s) uploaded successfully")%></td>
			</tr>
<%
			}
			if (notloaded > 0) {
%>
			<tr>
				<td align="left" class="nagimessage"><%=TranslationHelper.getTranslatedMessge("Uploading invalid file(s) is not valid")%></td>
			</tr>
<%			}
			RestoreDataHandler.setLoaded(0);
			RestoreDataHandler.setNotLoaded(0);
		}else if (session.getAttribute("statusCheck").equals("4")) { %>
			<tr>
				<td align="left" class="nagimessage"><%=TranslationHelper.getTranslatedMessge("Backup Not Successful")%></td>
			</tr>			
<%			
		}
		session.removeAttribute("statusCheck");
%>
	</table>
<%
	}
String newStartDate = (String)session.getAttribute("startdate");
String newSDate = newStartDate;	
String newEndDate = (String)session.getAttribute("enddate") ;
String newEDate = newEndDate;
DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
DateFormat fmtwithtime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date sDate = fmt.parse(newStartDate);
Date eDate = fmt.parse(newEndDate);
long msecDiff = eDate.getTime() - sDate.getTime();  
int daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000))) + 1;
int daysInPage = daysDiff;
int iLastPage = (int)Math.ceil(((float)daysDiff/(float)iLimit));
out.println("<script type=\"text/javascript\">iLastPage="+iLastPage+"</script>");
if(iPageno > iLastPage){
	iPageno = iLastPage;
	out.println("<script type=\"text/javascript\">iPageno="+iPageno+"</script>");
}
DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Calendar now = Calendar.getInstance();

int numOfdays = (iPageno-1)*iLimit;

now.setTime(sdf.parse(newEndDate));
now.add(Calendar.DAY_OF_MONTH, (-1 * numOfdays));
newEndDate = String.valueOf(sdf.format(now.getTime()));

if(numOfdays+iLimit < (daysDiff)){
	newStartDate = newEndDate;
	now.setTime(sdf.parse(newStartDate));
	now.add(Calendar.DAY_OF_MONTH, (iLimit-1)*-1);
}else {
	now.setTime(sdf.parse(newStartDate));
}
newStartDate = String.valueOf(sdf.format(now.getTime()));

%>


<div style="float: left; width: 100%">
<form action="<%=request.getContextPath()%>/iview" method="post" name="viewarchivedetail">
<input type="hidden" id="indfilelist" name="indexfilelist" value="" />
<input type="hidden" id="pageno" name="pageno" value="<%=strPageno%>" />
<input type="hidden" id="exctractlog" name="extractrowlog" value="0" />
<input type="hidden" id="dstring" name="daystring" value="" />
<input type="hidden" name="startdate" value="<%=startdate%>" />
<input type="hidden" name="enddate" value="<%=enddate%>" />
<input type="hidden" name=displaystartdate value="<%=formattedstartdate%>" />
<input type="hidden" name=displayenddate value="<%=formattedenddate%>" />
<input type="hidden" name="appmode" value="<%=ApplicationModes.ARCHIEVE_LOAD_REQUEST%>" /> 
<%

 	out.println("<script type=\"text/javascript\">iLastPage=" + iLastPage + "</script>");
 	if (iPageno > iLastPage) {
 		iPageno = iLastPage;
 		out.println("<script type=\"text/javascript\">iPageno=" + iPageno + "</script>");
 	}

%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td align="left">
		<table width="100%">
		
		
			<tr>
				<td colspan="2">
				<div class="content_head" width="100%">
				<div width="100%" class="Con_nevi">
				<table width="100%" cellspacing="0" cellpadding="3">
					<tr>
						<td align="left" class="navigationfont" width="200px">
						<span style="float: left; margin-top: 1px;"> <%=TranslationHelper.getTranslatedMessge("Show")%>&nbsp; </span>
						<span style="float: left">
						<div id="sizelimit" class="Combo_container"  style="margin-bottom:3px;"></div>
						</span> <span style="float: left; margin-top: 1px;">&nbsp; <%=TranslationHelper.getTranslatedMessge("days per page")%> </span></td>
						<script language="javascript">
								setComboContainer("sizelimit","40px","1");
								insertElements("sizelimit",["5","10","15","20","25"]);
								setSelectedText("sizelimit",<%=iLimit%>);
						</script>
						<td class="navigationfont" align="right">
						<span style="float: right; margin-right: 10px;">
						<input type='button' class='navibutton' value='Go' onClick="jumpPage()" /> 	</span> 
						<span style="float: right">
						<input class="navitext" id="gotopage" size="5" type="text" style="width: 35px; margin-left: 5px; margin-right: 5px;">
						</span>
						<span style="float: right; margin-top: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<%=TranslationHelper.getTranslatedMessge("Go to page :")%> </span>
						<span style="float: right; margin-top: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<%=TranslationHelper.getTranslatedMessge("Page")%>&nbsp;<%=iPageno%>&nbsp;<%=TranslationHelper.getTranslatedMessge("of")%>&nbsp;<%=iLastPage%>
						</span>
						<span style="float: right">
						<img src="<%=request.getContextPath()%>/images/first.bmp" style="cursor: pointer;" onClick="movePage('1')"> 
						<img src="<%=request.getContextPath()%>/images/prev.bmp" style="cursor: pointer;" onClick="movePage('<%=(iPageno != 1) ? (iPageno - 1) : 1%>')">
						<img src="<%=request.getContextPath()%>/images/next.bmp" style="cursor: pointer;" onClick="movePage('<%=(iPageno != iLastPage) ? (iPageno + 1) : iLastPage%>')">
						<img src="<%=request.getContextPath()%>/images/last.bmp" style="cursor: pointer;" onClick="movePage('<%=iLastPage%>')">
						</span></td>
					</tr>
				</table>
				</div>
				</div>
				</td>
			</tr>
			
			
			<tr>
				<td colspan="2">
<%
				int hrs = 6;
				try {
					if (request.getParameter("hours") != null) {
						hrs = Integer.parseInt(request.getParameter("hours"));
					}
					if (hrs < 1 || hrs > 24) {
						hrs = 6;
					}
				} catch (Exception e) {
					hrs = 6;
				}
				
				String criteria = "";
				try{
					if(request.getParameter("criteria")!=null){
						criteria = request.getParameter("criteria");
					}
				}catch(Exception e){
					criteria = "";
				}
				
				ArrayList filelist = null;
				if(!session.getAttribute("appliancelist").toString().equals("")){	
					criteria = " where  appid in (" +(String)session.getAttribute("appliancelist") +")";
					filelist = FileHandlerBean.getFileList(criteria,"",newStartDate,newEndDate);
				}	
				
				long starttimestamp = 0;
				long endtimestamp = 0;
				String current_date = "";
				String old_date = "";
				long filesize = 0;
				long loadedFilesize = 0;
				long totalfilesize = 0;
				long dayendtimestamp = 0;
				long timestamp;
				long oldTimestamp;
				int hrscount = 0;
				int recordcount = 0;
				int isloadedval = 1;
				int allindexfileloaded = 1;
				int noOfRows = 0;
				String slotfilelist = "";
				String fileName = "";
				String stringDay = "";
				FileHandlerBean fileHandlerBean = null;
				DecimalFormat df = new DecimalFormat("0.###");
%>
				<table class="TableData" width="100%" cellspacing="0" cellpadding="0">
					<tr height="25px">
						<td class="tdhead" style="padding-left: 10px"><b><%=TranslationHelper.getTranslatedMessge("Date")%></b></td>
						<td style="padding-left: 10px" class="tdhead"><b><%=TranslationHelper.getTranslatedMessge("File Details")%></b></td>
						<td align="center" class="tdhead"><b><%=TranslationHelper.getTranslatedMessge("Total Size")%></b></td>
					</tr>
<%
					if ((24 % hrs) == 0) {
						noOfRows = (24 / hrs);
					} else {
						noOfRows = (24 / hrs) + 1;
					}
					int dayCont = 0;
					if (filelist != null && filelist.size() > 0) {
						fileHandlerBean = (FileHandlerBean) filelist.get(recordcount);
						recordcount++;
						if (IViewPropertyReader.IndexFileTimeStampUsed == 2) {
							timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp()) * 1000;
						} else {
							timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp()) * 1000;
						}
						oldTimestamp = timestamp;
						sDate = fmt.parse(newEndDate);
						eDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(timestamp)));
						msecDiff = sDate.getTime() - eDate.getTime();
						daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000)));
						for (int i = 0; i < daysDiff; i++) {
							dayCont++;
							now.setTime(sDate);
							now.add(Calendar.DATE, -i);
							old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));
%>
							<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";'>
							<td class="tddata" align="center"><%=old_date%></td>
							<td class="tddata" align="left" colspan="3">&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+" "+old_date%></td>
							</tr>
<%
						}						

						while (true) {
							dayCont++;
							if (IViewPropertyReader.IndexFileTimeStampUsed == 2) {
								timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp()) * 1000;
							} else {
								timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp()) * 1000;
							}
							Date d = new Date(timestamp);
							current_date = (new SimpleDateFormat("yyyy/MM/dd")).format(d);
							stringDay = (new SimpleDateFormat("yyyyMMdd")).format(d);
							Date d1 = new Date(current_date);
							Date oldDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(oldTimestamp)));
							msecDiff = oldDate.getTime() - d1.getTime();
							daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000))) - 1;
							starttimestamp = d1.getTime() + (24 * 60 * 60 * 1000);
							endtimestamp = d1.getTime() + (24 * 60 * 60 * 1000);
							dayendtimestamp = d1.getTime();
							for (int i = 0; i < daysDiff; i++) {
								dayCont++;
								now.setTime(oldDate);
								now.add(Calendar.DATE, -1 * (i + 1));
								old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));
%>
								<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";'>
								<td class="tddata" align="center"><%=old_date%></td>
								<td class="tddata" align="left" colspan="3">&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+ old_date%></td>
								</tr>
<%
							}
%>
							<tr class="trlight" onMouseOver='changeColor("1",this,"<%=dayCont%>");' onMouseOut='changeColor("2",this,"<%=dayCont%>");'>
							<td class="tddata" style="padding-left: 10px" align="center"><%=current_date%></td>
							<td>
							<table id="<%=dayCont%>" onMouseOver="this.className='innerTableData2'" onMouseOut="this.className='innerTableData1'"
								 class="innerTableData1" width="100%" cellspacing="0" cellpadding="0">
<%
							filesize = 0;
							totalfilesize = 0;
							loadedFilesize = 0;
							boolean unloadFlag = false;
							String attribute = null;

							out.println("<tr><td class=tddata><input name=\"chkbox\""
									+ "\" id=\"" + stringDay + "\" type=\"checkbox\" value=\"" + stringDay 	+ ":00_23\" onclick=SelectAllCheckbox('"+stringDay+"')>"+TranslationHelper.getTranslatedMessge("Full Day Backup")+"</td></tr>"); 							
							
							int i=0;
							for (hrscount = 0; hrscount < 24; hrscount = hrscount+ hrs) {
								starttimestamp = endtimestamp;
								endtimestamp = starttimestamp - (hrs * 60 * 60 * 1000);
								isloadedval = 1;
								if (endtimestamp < dayendtimestamp) {
									endtimestamp = dayendtimestamp;
								}
								slotfilelist = "";
								String slotSDate = (new SimpleDateFormat("HH")).format(new Date(starttimestamp - 1000));
								String slotEDate = (new SimpleDateFormat("HH")).format(new Date(endtimestamp));
								while (true) {
									if ((starttimestamp > timestamp) && (timestamp >= endtimestamp)) {
										if (fileHandlerBean.getIsLoaded() == 0) {
											isloadedval = 0;
											filesize = filesize + fileHandlerBean.getFileSize();
										} else {
											loadedFilesize += fileHandlerBean.getFileSize();
										}
										if ("".equalsIgnoreCase(slotfilelist)) {
											slotfilelist = slotfilelist + fileHandlerBean.getAppID() + "@" + fileHandlerBean.getFileName();
										} else {
											slotfilelist = slotfilelist + "," + fileHandlerBean.getAppID() + "@" + fileHandlerBean.getFileName();
									 	}
										oldTimestamp = timestamp;
										if (recordcount < filelist.size()) {
											fileHandlerBean = (FileHandlerBean) filelist.get(recordcount);
											if (IViewPropertyReader.IndexFileTimeStampUsed == 2) {
												timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp()) * 1000;
											} else {
												timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp()) * 1000;
											}
											recordcount++;
										} else {
											timestamp = 0;
										}
									} else {
										break;
									}
								}
								if (filesize == 0) {
									attribute = "disabled";
								} else {
									attribute = "";
								}
								filesize = filesize + loadedFilesize;
								out.println("<tr class=\"innertrlight\"><td class=\"innertddata\" style=\"padding-left:5px\"><input name=\"chkbox"+filesize+"\""
									+ "\" id=\"" + stringDay + (i++) + "\" type=\"checkbox\" value=\"" + stringDay 	+ ":" + slotEDate + "_" + slotSDate + "\""
									+ (filesize == 0 ? "disabled" : "") + ">" + slotEDate + "_" + slotSDate + "hrs.log (" + "<font class=\"message\">"
									+ ByteInUnit.getBytesInUnit(filesize) + ")" + "</td></tr>"); 
								totalfilesize = totalfilesize + filesize;
								filesize = 0;
								loadedFilesize=0;
							}
							out.println("</table></td><td class=\"tddata\" align=\"center\">" + ByteInUnit.getBytesInUnit(totalfilesize)+"</td></tr>");

							if (recordcount >= filelist.size() && timestamp == 0) {
								break;
							}
						}

						Date oldDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(oldTimestamp)));
						int diff=0;
						if(iLastPage != iPageno & (daysInPage%iLimit)!=0) {
							diff=iLimit-dayCont;
						}else{
							diff=daysInPage-dayCont;
						}			
						for(int i=0; i<diff ; i++){
							now.setTime(oldDate);
							now.add(Calendar.DATE, -1 * (i + 1));
							old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));
%>
							<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";'>
							<td class="tddata" align="center"><%=old_date%></td>
							<td class="tddata" align="left" colspan="3">&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+" "+old_date.toString()%></td>
							</tr>
<%
						}
					} else {
						out.println("<tr class=\"trlight\"><td class=\"tddata\" align=\"center\" colspan=\"4\" >"+TranslationHelper.getTranslatedMessge("No archive File is Available for loading between")+" "+newStartDate+" "+TranslationHelper.getTranslatedMessge("and")+" "+newEndDate+"</td></tr>");
					}
					out.println("</table>");
%>
					</table>
					</td>
					</tr>
				</table>
				<br />
				<br/>
<%				if(filelist!=null && filelist.size()>0){ %>
					<div align=center><input type="button" name="backup" onClick="BackupData()"
						value="<%=TranslationHelper.getTranslatedMessge("Backup Now")%>" class="criButton" style="height: 20px" /></div> &nbsp;
<%				} %>								
				<center>							
				<div id="statusDivMain" style="display: none;">
					<div class="navigationfont">
						<img src="<%=request.getContextPath()%>/images/progress.gif"></img>
						Unloading Archived Files</div>
					<div id="statusDiv" class="navigationfont"></div>
				</div>
				</center>
				
				</td>
				</tr>
				</table>
				</td>
				</tr>
				</table>
				
				</form>
				</div>
				</div>
				
				<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
				<div class="TB_window" id="deviceform"></div>
				<div id="clickprocess" style="z-index: 150; display: none; position: absolute; left: 250px; top: 200px; width: 50%; background-color: #EEEEEE;">
				<table align="center" width="100%">
					<tr>
						<td align="center"> <img src="<%=request.getContextPath()%>/images/progress.gif" /></td>
					</tr>
					<tr>
						<td>
							<center><b> <%=TranslationHelper.getTranslatedMessge("Process of loading index file is running.....Please wait....")%></b></center>
						</td>
					</tr>
				</table>
				</div>

<%
		if (isRestoreProcessRunning) {
%>
			<form name="Restorebarform" action="<%=request.getContextPath()%>/servlets/LoadDataManager" method="POST">
			<div id="progressbar" class="progressbar" style="z-index: 150; position: absolute; left: 250px; top: 200px; width: 50%; background-color: #EEEEEE;">
				<table align="center">
					<tr>
						<td align="center"><img alt="Loading"
							src="<%=request.getContextPath()%>/images/progress.gif" /></td>
					</tr>
					<tr>
						<td><b><%=TranslationHelper.getTranslatedMessge("Restoring, Please wait...")%></b></td>
					</tr>
				</table>
			</div>
			</form>
<%
		}
		else if (isBackupProcessRunning && BackupDataHandler.isStoppedThread() == false) {
%>
			<form name="backupbarform" action="<%=request.getContextPath()%>/servlets/LoadDataManager" method="POST">
			<div id="progressbar" class="progressbar" style="z-index: 150; position: absolute; left: 250px; top: 200px; width: 50%; background-color: #EEEEEE;">
				<table align="center">
					<tr>
						<td align="center"><img alt="Loading"
							src="<%=request.getContextPath()%>/images/progress.gif" /></td>
					</tr>
					<tr>
						<td><b><%=TranslationHelper.getTranslatedMessge("Taking backup, Please wait...")%></b></td>
					</tr>
				</table>
				<table align="center" width="100">
					<tr width="100">
						<td width="100" align="center">
							<input type="button" class="criButton" value="Cancel"
							onClick="location.href='<%=request.getContextPath()%>/webpages/backuprestore.jsp?backupstop=true'" />
						</td>
					</tr>
				</table>
			</div>
							
			</form>
	
<%
		}
	} catch (Exception e) {
		CyberoamLogger.appLog.debug("backuprestore.jsp.e " + e, e);
	}
%>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>

</body>
</html>
