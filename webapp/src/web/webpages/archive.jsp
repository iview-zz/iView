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
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.helper.LoadDataHandler"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.utility.IViewPropertyReader"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.utility.ByteInUnit"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupRelationBean"%>
<%@page import="org.cyberoam.iview.device.beans.DeviceGroupBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cyberoam.iview.authentication.beans.*"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
try{
	if(CheckSession.checkSession(request,response)<0){
		return;
	}
	
	
	int iPageno = 1;
	String strPageno = request.getParameter("pageno");
	if(strPageno != null && !"".equalsIgnoreCase(strPageno)){
		iPageno = Integer.parseInt(strPageno);
	}
	int iLimit = 5;
	String strLimit = request.getParameter("limit");
	if(strLimit != null){
		iLimit = Integer.parseInt(strLimit);
	}
	// Terminating process if loading process completed or termination request
	if("yes".equalsIgnoreCase(request.getParameter("stop"))){
		CyberoamLogger.appLog.debug(" User request to terminate loading process ");
		
		LoadDataHandler.setStopFlag(1);
		if(!(LoadDataHandler.getProcessPercentComplete() == 100))
			LoadDataHandler.setProcessPercentComplete(99);
	}

	// If request to extract row log otherw.ise null value
	String startrowlogfile= request.getParameter("startrowlogfile");
	String endrowlogfile= request.getParameter("endrowlogfile");
	if(startrowlogfile == null){
		startrowlogfile="";
	}
	if(endrowlogfile == null){
		endrowlogfile="";
	}

	//Reading status if any loading process is currently running or not
	boolean isLoadingProcessRunning=false;
	if(LoadDataHandler.getStopFlag() == 0){
		CyberoamLogger.appLog.error(" Process is running "); 
		isLoadingProcessRunning=true;
	}
	
	String formattedstartdate=request.getParameter("formattedstartdate");
	if(formattedstartdate == null || "NULL".equalsIgnoreCase(formattedstartdate) || "".equalsIgnoreCase(formattedstartdate) ){
		formattedstartdate = (new SimpleDateFormat("dd, MMM yyyy")).format(new Date());
	}
	String formattedenddate=request.getParameter("formattedenddate");
	if(formattedenddate == null || "NULL".equalsIgnoreCase(formattedenddate) || "".equalsIgnoreCase(formattedenddate) ){
		formattedenddate=(new SimpleDateFormat("dd, MMM yyyy")).format(new Date());
	}
	String qString = request.getQueryString();
	if(qString == null){
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
<script src="<%=request.getContextPath()%>/javascript/combo.js"></script>
<script src="<%=request.getContextPath()%>/javascript/container.js"></script>
<SCRIPT SRC="<%=request.getContextPath()%>/javascript/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/popupform.js"></SCRIPT>
<style type="text/css">
.loadButton{
	border: 0px;
	background: transparent;
	font-family: Verdana,Arial,Helvetica,sans-serif; 
	font-size: 11px;
	text-decoration: underline;
}
.loadButton1{
	border: 0px;
	background: transparent;
	font-family: Verdana,Arial,Helvetica,sans-serif; 
	font-size: 11px;
	text-decoration: none;
}
</style>
<script type="text/javascript" language="javascript">
	var URL = "<%=request.getContextPath()%>/webpages/archive.jsp?<%=qString%>";
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
   	function LoadData(day){
		var filelist="";
		var dateList=""
		var ischeck=false;
		var processobj = document.getElementById("clickprocess");
		var overlay = document.getElementById("TB_overlay");
		if(<%=isLoadingProcessRunning%> || processobj.style.display==''){
			alert("<%=TranslationHelper.getTranslatedMessge("Loading Process Already Running")%>");
			return false;
		}
		var checkstmp = document.getElementsByName(day);
		for (var j = 0; j <  checkstmp.length; ++j) { 
		   if ( checkstmp[j].type == "checkbox") { 
		     	if(checkstmp[j].checked == true ){
		     		if(!checkstmp[j].disabled){
			     		ischeck	= true;
		     		}
		     		if(filelist == ""){
		     			filelist = checkstmp[j].value;
		     		}else{
			     		filelist = filelist + "," + checkstmp[j].value;
		     		}
		     		if(dateList == ""){
			     		if(j == 0)
		     				dateList = day+" 18_23"; 			     		
			     		else if(j == 1)
		     				dateList = day+" 12_17";
			     		else if(j == 2)
		     				dateList = day+" 06_11";
			     		else if(j == 3)
		     				dateList = day+" 00_05";
		     		}else{
		     			if(j == 0)
		     				dateList = dateList + "," + day+" 18_23"; 			     		
			     		else if(j == 1)
		     				dateList = dateList + "," + day+" 12_17";
			     		else if(j == 2)
		     				dateList = dateList + "," + day+" 06_11";
			     		else if(j == 3)
		     				dateList = dateList + "," + day+" 00_05";
		     		}	
		     	}
		   } 
		}
		if(!ischeck){
			alert("<%=TranslationHelper.getTranslatedMessge("Select atleast one check box to load data to search")%>");
			return false;
		}
		
		document.viewarchivedetail.extractrowlog.value = "1";
		processobj.style.display = '';
		overlay.style.display = '';
		document.viewarchivedetail.indexfilelist.value = filelist;
		document.viewarchivedetail.daystring.value = day;
		document.viewarchivedetail.checkeddate.value = dateList;
		document.viewarchivedetail.submit();		
		return true;
	}
	function dofilter(){
		location.href="/iview/webpages/archive.jsp?startdate="+document.viewarchivedetail.startdate.value+"&enddate="+document.viewarchivedetail.enddate.value+"&formattedstartdate="+document.viewarchivedetail.displaystartdate.value+"&formattedenddate="+document.viewarchivedetail.displayenddate.value;
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
			xmlHttp.onreadystatechange = function() { contentIsReady(xmlHttp); }
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
	<%if("yes".equalsIgnoreCase(request.getParameter("processrunning")) && isLoadingProcessRunning){%>
		clearTimeout(timerVal);
		if("<%=endrowlogfile%>" == "" && "<%=startrowlogfile%>" == ""){
			//timerVal=setTimeout('functionCall()',2000);					
			location.href='<%=request.getContextPath()%>/webpages/archive.jsp?stop=yes&startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value;
		}else{
			document.progressbarform.startdate.value = document.viewarchivedetail.startdate.value
			document.progressbarform.enddate.value = document.viewarchivedetail.enddate.value
			document.progressbarform.submit();
		}
		return;
	<%}else{%>
	location.href='<%=request.getContextPath()%>/webpages/archive.jsp?startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value;
	<%}%>
	}

	function doSomething() {
		timerVal=setTimeout('loadFunctionCall()',1000);
	}
	function loadFunctionCall(){
		var overlay = document.getElementById("TB_overlay");
		overlay.style.display = '';
		getTheContent('<%=request.getContextPath()%>/AjaxController?giveloadtime=true');		
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
						if(http_request.responseText == 0 || http_request.responseText == ''){
							resWidth = 1;
							obj2.innerHTML = '&nbsp;'+resWidth+'%';
							obj.width = resWidth + '%';
							obj1.width = (100 - resWidth) + '%';
							filenotfountcount=0;
						}						
						else if(http_request.responseText == 100){
							
							closeWindow();		
							return;
						}
						else{ 
							resWidth = http_request.responseText;
						obj2.innerHTML = '&nbsp;'+resWidth+'%';
						obj.width = resWidth + '%';
						obj1.width = (100 - resWidth) + '%';
						filenotfountcount=0;
					}
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
    
   	function unloadFile(dayStr){
		var url="<%=request.getContextPath()%>" + "/iview";
		var queryStr="?appmode="+"<%=ApplicationModes.WARMFILE_UNLOAD_REQUEST%>"		
		queryStr=queryStr+"&daystr="+dayStr;				
		url=url+queryStr;							
		SimpleAJAXCall(url,getResponse,"get",dayStr);		
		GetStatusValue();				
	}   
	function unloadAll(){
		var confirmation=confirm("Are you sure to unload all data?");		
		if(confirmation) {
			document.viewarchivedetail.appmode.value = "<%=ApplicationModes.WARMFILE_UNLOAD_ALL%>";
			document.viewarchivedetail.submit();
		}
		return;			
	}  
	function GetStatusValue(){					
		var url="<%=request.getContextPath()%>" + "/iview";
		var queryStr="?appmode="+"<%=ApplicationModes.WARMFILE_UNLOAD_REQUEST%>";			
		queryStr=queryStr+"&getstatus=true";
		url=url+queryStr;		
		SimpleAJAXCall(url,getResponse,"get",url);					
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
		//alert("<%=request.getQueryString()%>");
		window.location.href="<%=request.getContextPath()%>"+"/webpages/archive.jsp";		
	}

</script>
</head>
<body <%=(isLoadingProcessRunning)?"onload=\"loadFunctionCall();\"":""%> >
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include> 
<div class="maincontent" id="main_content">
<jsp:include page="Date.jsp" flush="true">
	<jsp:param name="device"	value="true"></jsp:param>
</jsp:include>
<%
		String 	startdate = (String)session.getAttribute("startdate");
		String enddate = (String)session.getAttribute("enddate");
%>
		<div class="reporttitlebar">
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Archived Files")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div class="reporttimetitle">
					<b>From:</b> <font class="reporttime"><%=session.getAttribute("startdate")%></font>
					</br><b>To:</b> <font class="reporttime"><%=session.getAttribute("enddate")%></font> 
			</div>
			<div class="unloadAll">	
				<input align="right" type="button" name="unloadAll"  onclick="unloadAll()" value="<%=TranslationHelper.getTranslatedMessge("Unload All")%>" class="criButton" style="height:20px"/>
				&nbsp;
			</div>
		</div>

<% 	
		if(request.getParameter("statusCheck")!=null) { %>
			<table cellpadding="0" cellspacing="0" width="100%" border="0" class="TableData" style="padding:3px 0pt 0pt 3px;">
<%			if(request.getParameter("statusCheck").equals("1")){ %> 
				<tr><td align="left" class="posimessage"><%= TranslationHelper.getTranslatedMessge("Unload all completed.")%></td></tr>
<%			} 
%>			</table>		
<%		}
%>



		<div style="float: left;width: 100%">
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
				<input type="hidden" name="categoryID" value="<%=(String)session.getAttribute("categoryid")%>" />
				<input type="hidden" name="checkeddate" value="" />

<%	
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
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td align="left">
						<table width="100%">
						<tr><td colspan="2">
								<div class="content_head" width="100%">
									<div width="100%" class="Con_nevi">
										<table width="100%" cellspacing="0" cellpadding="3">
										<tr>
											<td align="left" class="navigationfont" width="200px"><span style="float:left;margin-top:1px;"><%=TranslationHelper.getTranslatedMessge("Show")%>&nbsp;
												</span><span style="float:left">
												<div id="sizelimit" class="Combo_container" style="margin-bottom:3px;"></div>
												</span>
												<span style="float:left;margin-top:1px;">&nbsp;<%=TranslationHelper.getTranslatedMessge("days per page")%></span>
											</td>
											<script language="javascript">
												setComboContainer("sizelimit","40px","1");
												insertElements("sizelimit",["5","10","15","20","25"]);
												setSelectedText("sizelimit",<%=iLimit%>);
											</script>
											<td class="navigationfont" align="right">
											<span style="float:right;margin-right:10px;"><input type='button' class='navibutton' value='Go' onClick="jumpPage()" ></span>
											<span style="float:right"><input class="navitext" id="gotopage" size="5" type="text" style="width:35px;margin-left:5px;margin-right:5px;"></span>
											<span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("Go to page :")%></span>							
											<span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("Page")%>&nbsp;<%=iPageno%>&nbsp;<%=TranslationHelper.getTranslatedMessge("of")%>&nbsp;<%=iLastPage%></span>							
											<span style="float:right">
												<img src="<%=request.getContextPath()%>/images/first.bmp" style="cursor: pointer;" onClick="movePage('1')" >
												<img src="<%=request.getContextPath()%>/images/prev.bmp" style="cursor: pointer;" onClick="movePage('<%=(iPageno!=1)?(iPageno-1):1%>')" >
												<img src="<%=request.getContextPath()%>/images/next.bmp" style="cursor: pointer;" onClick="movePage('<%=(iPageno!=iLastPage)?(iPageno+1):iLastPage%>')" >								
												<img src="<%=request.getContextPath()%>/images/last.bmp" style="cursor: pointer;" onClick="movePage('<%=iLastPage%>')" >
											</span>							
											</td>
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
	try{
		if(request.getParameter("hours")!=null){
			hrs = Integer.parseInt(request.getParameter("hours"));
		}
		if(hrs < 1 || hrs > 24 ){
			hrs = 6;
		}
	}catch(Exception e){
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
					<td class="tdhead" style="padding-left:10px"><b><%=TranslationHelper.getTranslatedMessge("Date")%></b></td>
					<td style="padding-left:10px" class="tdhead"><b><%=TranslationHelper.getTranslatedMessge("File Details")%></b></td>
					<td align="center" class="tdhead"><b><%=TranslationHelper.getTranslatedMessge("Total Size")%></b></td>
					<td align="center" class="tdhead"><b><%=TranslationHelper.getTranslatedMessge("Action")%></b></td>
				</tr>
<%
	if((24%hrs) == 0){
		noOfRows=(24/hrs);
	}else{
		noOfRows=(24/hrs)+1;			
	}
	int dayCont = 0; 
	if(filelist != null && filelist.size() > 0){
		fileHandlerBean = (FileHandlerBean)filelist.get(recordcount);
		recordcount++;
		if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
			timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp())*1000;
		}else{
			timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp())*1000;
		}
		oldTimestamp = timestamp;
		
		sDate = fmt.parse(newEndDate);
		eDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(timestamp)));
		
		msecDiff = sDate.getTime() - eDate.getTime();  
		daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000)));
		
		for(int i=0; i<daysDiff ; i++){
			dayCont++;
			now.setTime(sDate);
			now.add(Calendar.DATE, -i);
			old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));
%>
 				<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
					<td class="tddata" align="center"><%=old_date%></td>
					<td class="tddata" align="left" colspan="3">&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+" "+old_date%></td>
				</tr>
<%
		}		
		
		while(true){
			dayCont++;
			
			if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
				timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp())*1000;
			}else{
				timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp())*1000;
			}
	
			Date d = new Date(timestamp);
			current_date = (new SimpleDateFormat("yyyy/MM/dd")).format(d);
			stringDay = (new SimpleDateFormat("yyyyMMdd")).format(d);
			Date d1 = new Date(current_date);
	
			Date oldDate = new Date((new SimpleDateFormat("yyyy/MM/dd")).format(new Date(oldTimestamp)));
			
			msecDiff = oldDate.getTime() - d1.getTime();  
			daysDiff = ((int) (msecDiff / (24.0 * 60 * 60 * 1000)))-1;
			starttimestamp=d1.getTime() + (24*60*60*1000);
			endtimestamp=d1.getTime() + (24*60*60*1000);
			dayendtimestamp = d1.getTime();
		
			for(int i=0; i<daysDiff ; i++){
				dayCont++;
				now.setTime(oldDate);
				now.add(Calendar.DATE, -1*(i+1));
				old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));
%>
  				<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
					<td class="tddata" align="center"><%=old_date%></td>
					<td class="tddata" align="left" colspan="3">&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+ old_date%></td>
				</tr>
<%
			}
%>
				<tr class="trlight" onMouseOver='changeColor("1",this,"<%=dayCont%>");' onMouseOut='changeColor("2",this,"<%=dayCont%>");'>
					<td class="tddata" style="padding-left:10px" align="center"><%=current_date%></td>
					<td>
						<table id="<%=dayCont%>" onMouseOver="this.className='innerTableData2'" onMouseOut="this.className='innerTableData1'" class="innerTableData1" width="100%" cellspacing="0" cellpadding="0">
<%
			filesize=0;
			totalfilesize=0;
			loadedFilesize = 0;
			boolean unloadFlag=false;
			String attribute=null;
			for(hrscount=0;hrscount<24;hrscount=hrscount+hrs){		
				starttimestamp=endtimestamp;
				endtimestamp = starttimestamp - (hrs*60*60*1000);
				isloadedval=1;
				if(endtimestamp < dayendtimestamp){
					endtimestamp=dayendtimestamp;
				}
				slotfilelist="";
				
				String slotSDate = (new SimpleDateFormat("HH")).format(new Date(starttimestamp-1000));
				String slotEDate = (new SimpleDateFormat("HH")).format(new Date(endtimestamp));
				
				while(true){ 
					if((starttimestamp > timestamp) && (timestamp >= endtimestamp)){
						if(fileHandlerBean.getIsLoaded() == 0){
							isloadedval=0;
							filesize = filesize+fileHandlerBean.getFileSize();
						} else {
							loadedFilesize += fileHandlerBean.getFileSize();
						}
						if("".equalsIgnoreCase(slotfilelist)){
							slotfilelist = slotfilelist + fileHandlerBean.getAppID()+"@"+ fileHandlerBean.getFileName();
						}else{
							slotfilelist = slotfilelist + "," + fileHandlerBean.getAppID()+"@"+ fileHandlerBean.getFileName();
						}
						oldTimestamp = timestamp;
						if(recordcount < filelist.size()){	
							fileHandlerBean = (FileHandlerBean)filelist.get(recordcount);
							if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
								timestamp = Long.parseLong(fileHandlerBean.getFileEventTimestamp())*1000;
							}else{
								timestamp = Long.parseLong(fileHandlerBean.getFileCreationTimestamp())*1000;
							}
							recordcount++;
						}else{
							timestamp=0;
						}
					}else{
						break;
					}
				}
				if(isloadedval == 0){
					allindexfileloaded=0;
				}
				if(isloadedval==1 && filesize!=0 && loadedFilesize!=0){
					attribute="checked disabled";
					unloadFlag=true;
				}else{
					attribute="";
				}
					
				if(filesize==0 && loadedFilesize==0){
					attribute="disabled";
				}else{
					attribute="";
				}
				out.println("<tr class=\"innertrlight\"><td class=\"innertddata\" style=\"padding-left:5px\"><input name=\""+stringDay+"\" id=\""+stringDay+"\" type=\"checkbox\" value=\""+slotfilelist+"\""+ ((isloadedval==1 && filesize==0 && loadedFilesize!=0) ?"checked disabled":"")+((filesize==0 && loadedFilesize==0)?"disabled":"") +"> "+ slotEDate + "_"+ slotSDate +"hrs.log ("+((filesize==0 && loadedFilesize!=0)?ByteInUnit.getBytesInUnit(loadedFilesize):ByteInUnit.getBytesInUnit(filesize))+") "+((loadedFilesize!=0 && filesize!=0)?"<font class=\"message\">"+ByteInUnit.getBytesInUnit(loadedFilesize)+" Loaded...</font>":"")+"</td></tr>");		
				totalfilesize = totalfilesize + filesize + loadedFilesize;
				filesize = 0;
				loadedFilesize = 0;
			}
			out.println("</table></td><td class=\"tddata\" align=\"center\">"+ ByteInUnit.getBytesInUnit(totalfilesize)+"</td>");
			out.println("<td class=\"tddata\" align=\"center\">");
			
			if(allindexfileloaded==0){
				out.println("<input type=\"button\" class=\"loadButton\" onmouseover=\"this.className = 'loadButton1'\" onmouseout=\"this.className = 'loadButton'\" value=\"Load\" onclick=\"LoadData('"+stringDay+"');\" />"+"<br>");
				//out.println("<a href=\"javascript:;\" onclick=\"LoadData('"+stringDay+"');\">"+TranslationHelper.getTranslatedMessge("Load")+"</a><br>");		
			}else{
			
			//if(unloadFlag==true){
				out.println("<span style='text-decoration:underline;cursor:pointer;' onclick=unloadFile('"+(new SimpleDateFormat("yyyyMMdd")).format(d)+"')>"+TranslationHelper.getTranslatedMessge("Unload")+"</span><br>");
			}
			out.println("<a href=\""+request.getContextPath()+"/webpages/archivelogs.jsp?startdate="+(new SimpleDateFormat("yyyy-MM-dd")).format(d)+" 00:00:00&enddate="+(new SimpleDateFormat("yyyy-MM-dd")).format(d)+" 23:59:59\">"+TranslationHelper.getTranslatedMessge("Raw Log")+"</a><br>");
			//out.println("<a href=\""+request.getContextPath()+"/webpages/archivelogs.jsp?tblname=tblindex"+stringDay+"\">"+TranslationHelper.getTranslatedMessge("Search")+"</a></td></tr>");	
			if(recordcount >= filelist.size() && timestamp==0){
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
			now.add(Calendar.DATE, -1*(i+1));
			old_date = String.valueOf((new SimpleDateFormat("yyyy/MM/dd")).format(now.getTime()));
%>
 			<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
				<td class="tddata" align="center"><%=old_date%></td>
				<td class="tddata" align="left" colspan="3">&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("No archive File is Available for loading ")+" "+old_date.toString()%></td>
			</tr>
<%
		}	
	}else{
		out.println("<tr class=\"trlight\"><td class=\"tddata\" align=\"center\" colspan=\"4\" >"+TranslationHelper.getTranslatedMessge("No archive File is Available for loading between")+" "+newStartDate+" "+TranslationHelper.getTranslatedMessge("and")+" "+newEndDate+"</td></tr>");
	}
	out.println("</table>");
%>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br/>
<center>
	<div id="statusDivMain" style="display:none;">
		<div class="navigationfont">			
			<img src="<%=request.getContextPath()%>/images/progress.gif"></img>
			Unloading Archived Files
		</div>
		<div id="statusDiv" class="navigationfont">			
		</div>		
	</div>
</center>
</form>
</div>
</div>
<%
String display = "none";
if("yes".equalsIgnoreCase(request.getParameter("stop"))){%>
<%
	display = "";
} 
%>
<div id="TB_overlay" class="TB_overlayBG" style="display: <%=display%>;"></div>
<div class="TB_window" id="deviceform"></div> 
<div id="clickprocess" style="z-index:150;display: none;position: absolute;left: 250px;top: 200px;width:50%;background-color:#EEEEEE;">
	<table align="center" width="100%">
	<tr>
		<td align="center">
			<img src="<%=request.getContextPath()%>/images/progress.gif"/>
		</td>
	</tr>
	<tr>
		<td><center><b><%=TranslationHelper.getTranslatedMessge("Process of loading archive file is running.....Please wait....")%></b></center></td>
	</tr>
	</table>
</div>

<%
		if(isLoadingProcessRunning){
			
%>
			<div id="indexDiv">
			<form name="progressbarform" action="<%=request.getContextPath()%>/servlets/LoadDataManager" method="POST">
				<input type="hidden" name="startrowlogfile" value="<%=startrowlogfile%>">
				<input type="hidden" name="endrowlogfile" value="<%=endrowlogfile%>">
				<input type="hidden" name="startdate" value="<%=newStartDate%>">
				<input type="hidden" name="enddate" value="<%=newEndDate%>">
				<div class="progressbar" style="z-index:150;position: absolute;left: 250px;top: 200px;width:50%;background-color: #EEEEEE;">
					<table align="center" width="100%">
					<tr>
						<td colspan="3"><center><b>
<%
						if("yes".equalsIgnoreCase(request.getParameter("processrunning"))){
							if(LoadDataHandler.getRunningProcessFlag()==2){
%>
								<%=TranslationHelper.getTranslatedMessge("Extracting row file(s), Please wait...")%>
<%
							}else{
%>
								<%=TranslationHelper.getTranslatedMessge("Loading index files, Please wait...")%>
<%
								}
						}else{
%>
							<%=TranslationHelper.getTranslatedMessge("Loading Process is Already running Please Wait...") + "<br>"%>
<%
						}
%>
						</b></center>
						</td>
					</tr>
					<tr>
						<td width="25%" align="right"><img alt="Loading" src="<%=request.getContextPath()%>/images/loader.gif" /></td>
						<td>
							<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 2px solid #999999;">
							<tr>
								<td id="first" height="15px" width="0%" style="background-color: #96AEBE;"></td>
								<td id="second" height="15px" width="100%" style="background-color: #E8EDF1;"></td>
							</tr>
							</table>
						</td>
						<td id="data" width="25%" align="left">&nbsp;&nbsp;0%</td>
					</tr>
					</table>
					<table align="center" width="100">
					<tr width="100">
						<td width="100" align="center">
							<input type="button" class="criButton" value="Cancel" onClick="location.href='<%=request.getContextPath()%>/webpages/archive.jsp?stop=yes&startdate='+document.viewarchivedetail.startdate.value+'&enddate='+document.viewarchivedetail.enddate.value"/>
						</td>
					</tr>
					</table>
				</div>
			</form>
			</div>
<%
		}
	} catch(Exception e){
		CyberoamLogger.appLog.debug("archive.jsp.e " +e,e);
	}
%>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div class="TB_window" id="deviceform"></div> 
<script type="text/javascript">
<%
	if("yes".equalsIgnoreCase(request.getParameter("stop"))){
	/*	while(LoadDataHandler.getCommit() == 0)	
			Thread.sleep(1000);*/	
%>		
		document.getElementById("TB_overlay").style.display = 'none';	
<%
	}
%>
</script>
</body>
</html>
