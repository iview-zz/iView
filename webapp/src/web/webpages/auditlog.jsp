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

<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%
	try{
	if(CheckSession.checkSession(request,response)<0)
		return;
	String logOffset = request.getParameter("logOffset");
	int iLogOffset = 0;
	if(logOffset!=null && (!"null".equalsIgnoreCase(logOffset)) && (!"".equalsIgnoreCase(logOffset))){
		iLogOffset = Integer.parseInt(logOffset);
	}
	String logLimit = request.getParameter("logLimit");
	int ilogLimit = 15;
	if(logLimit!=null && (!"null".equalsIgnoreCase(logLimit)) && (!"".equalsIgnoreCase(logLimit))){
		ilogLimit = Integer.parseInt(logLimit);
	}
%>
<%@page import="org.cyberoam.iview.audit.AuditLogHelper"%>
<html>
<head>
<title><%=iViewConfigBean.TITLE%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reports.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/grid.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tabs.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/container.css" />
<script language="Javascript" src="<%=request.getContextPath()%>/javascript/ajax.js"></script>
<script language="Javascript" src="<%=request.getContextPath()%>/javascript/container.js"></script>
<script language="Javascript" src="<%=request.getContextPath()%>/javascript/combo.js"></script>
<script src="<%=request.getContextPath()%>/javascript/dhtmlxcommon.js"></script>
<script src="<%=request.getContextPath()%>/javascript/dhtmlxgrid.js"></script>
<script src="<%=request.getContextPath()%>/javascript/dhtmlxgridcell.js"></script>
<script src="<%=request.getContextPath()%>/javascript/dhtmlxgrid_filter.js"></script>
<script>
	var mygrid;
	var arrCat = new Array("Mail", "User", "Device", "Application", "Views", "Data", "Archive", "Report");
	var arrSev = new Array("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Info", "Debug");

	var gridQString = "<%=request.getContextPath()%>/iview?offset="+<%=iLogOffset%>+"&logLimit="+<%=ilogLimit%>+"&appmode="+<%=ApplicationModes.GET_AUDIT_LOGS%>+"&severity=-1&category=-1";
	var URL = "<%=request.getContextPath()%>/webpages/auditlog.jsp?<%=request.getQueryString()==null?"":request.getQueryString()%>";
	window.onload = function (evt) {
		setWidth();
		doInitGrid();
	}		
	function setWidth(){
		var main_div = document.getElementById("main_content");
		main_div.style.width = (document.body.clientWidth - 215);
	}
	function replaceQueryString(url,param,value) {
		var re = new RegExp("([?|&])" + param + "=.*?(&|$)","i");
		if (url.match(re)) {
			return url.replace(re,'$1' + param + "=" + value + '$2');
		} else {
			return url + '&' + param + "=" + value;
		}
	}
	function doInitGrid(){
		mygrid = new dhtmlXGridObject('auditlog_grid');
		mygrid.setImagePath("<%=request.getContextPath()%>/images/grid_images/");
		mygrid.setHeader("Event Time,Category,Severity,Message,Username,IP Address");
		mygrid.setInitWidths("125,100,100,*,100,100");
		mygrid.setColAlign("center,left,left,left,left,left,left");
		mygrid.setSkin("light");
		mygrid.setColSorting("str,str,str,str,str,str");
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
		mygrid.enableAutoHeigth(true,"1000");
		mygrid.init();
		mygrid.loadXML(gridQString, function(){
			mygrid.attachHeader(",<div id='categ_flt'></div>,<div id='sever_flt'></div>,#text_filter,#text_filter,#text_filter");
			var categFlt = document.getElementById("categ_flt").appendChild(document.getElementById("categ_flt_box").childNodes[0]);
			var severFlt = document.getElementById("sever_flt").appendChild(document.getElementById("sever_flt_box").childNodes[0]);
			populateSelect(severFlt, arrSev);
			populateSelect(categFlt, arrCat);
			mygrid.setSizes();
		});
	}
	//filter grid contnet based on values of two filter fields
    function filterBy(){
        var severVal = document.getElementById("sever_flt").childNodes[0].value;
        var categVal = document.getElementById("categ_flt").childNodes[0].value;
        gridQString = replaceQueryString(gridQString,"severity",severVal);
        gridQString = replaceQueryString(gridQString,"category",categVal);
        mygrid.clearAll();
        mygrid.loadXML(gridQString);
    }
    function populateSelect(selObj, arrEle){
        selObj.options.add(new Option("All","-1"));
        for(i=0; i<arrEle.length; i++ ){
        	selObj.options.add(new Option(arrEle[i],i));
        }
    }
    function setPage(ele){
    	URL = replaceQueryString(URL,'logLimit',ele.value);
    	location.href = URL;
    }
    function selectCombo(id,index){
		ele = document.getElementById("Combo_item"+id+"_"+index);
		var limit = ele.innerHTML;
		URL = replaceQueryString(URL,'logLimit',limit);
    	location.href = URL;
    }
	
    function movePage(pageNum , totalPages){
    	if(pageNum <= 0)
    		pageNum = 1;
    	else if(pageNum > totalPages)
    		pageNum = totalPages;
    	pageNum = ((parseInt(pageNum)-1)*<%=ilogLimit%>);
    	URL = replaceQueryString(URL,'logOffset',pageNum);
    	location.href = URL;
    }
    function jumpPage(totalPages){
		var pageNo = document.getElementById("gotopage").value;
		if(pageNo == null || isNaN(pageNo) || pageNo < 1 || pageNo > totalPages){ //<%//=numOfPages%>
			alert("<%=TranslationHelper.getTranslatedMessge("Please enter valid page no.")%>");
		}else{
			movePage(pageNo,totalPages);	
		}
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>        
	<div class="maincontent" id="main_content">
		<jsp:include page="Date.jsp" flush="true"></jsp:include>
		<div class="reporttitlebar">
			<div class="reporttitle">Audit Logs</div>
			<div class="reporttimetitle">
					<b>From:</b><font class="reporttime"><%=session.getAttribute("startdate")%></font>
					</br><b>To:</b><font class="reporttime"><%=session.getAttribute("enddate")%></font> 
			</div> 
		</div>
		<%
		int numOfLogs = AuditLogHelper.getNumOfLogs(session.getAttribute("startdate").toString(), session.getAttribute("enddate").toString());
		int numOfPages = 0;
		if(numOfLogs%ilogLimit == 0)
			numOfPages =(numOfLogs/ilogLimit);
		else
			numOfPages =(numOfLogs/ilogLimit)+1;
		int curPage = (iLogOffset/ilogLimit)+1;
		%>
		<table cellpadding="0" cellspacing="2" width="100%" border="0">
		<tr>	
			<td>
				<div class="content_head" width="100%">
					<div width="100%" class="Con_nevi">
						<table width="100%" cellspacing="0" cellpadding="3">

						<tr>
							<td align="left" class="navigationfont" width="200px"><span style="float:left;margin-top:1px;"><%=TranslationHelper.getTranslatedMessge("Show")%>&nbsp;
								</span><span style="float:left"><div id="sizelimit" class="Combo_container" style="margin-bottom:3px;"></div>
								</span><span style="float:left;margin-top:1px;">&nbsp;<%=TranslationHelper.getTranslatedMessge("results per page")%></span>
							</td>
							<script language="javascript">
								setComboContainer("sizelimit","40px","1");
								insertElements("sizelimit",["15","20","25"]);
								setSelectedText("sizelimit",<%=ilogLimit%>);
							</script>
							<td class="navigationfont" align="right">
							<span style="float:right;margin-right:10px;"><input type='button' class='navibutton' value='Go' onClick="jumpPage('<%=numOfPages %>')"" ></span>
							<span style="float:right"><input class="navitext" id="gotopage" size="5" type="text" style="width:35px;margin-left:5px;margin-right:5px;"></span>
							<span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("Go to page :")%></span>
							<span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page&nbsp;<%=curPage%>&nbsp;of&nbsp;<%=numOfPages%></span>
							<span style="float:right">
								<img src="<%=request.getContextPath()%>/images/first.bmp" style="cursor: pointer;" onClick="movePage('1','<%=numOfPages %>')" >
								<img src="<%=request.getContextPath()%>/images/prev.bmp" style="cursor: pointer;" onClick="movePage('<%=curPage-1%>','<%=numOfPages %>')" >
								<img src="<%=request.getContextPath()%>/images/next.bmp" style="cursor: pointer;" onClick="movePage('<%=curPage+1%>','<%=numOfPages %>')" >
								<img src="<%=request.getContextPath()%>/images/last.bmp" style="cursor: pointer;" onClick="movePage('<%=numOfPages%>','<%=numOfPages %>')" >
							</span>							
							</td>
						</tr>
						</table>
					</div>
				</div>
			</td>
		</tr>
		<tr><td><div id="auditlog_grid" style="width:100%;height:350px;"></div></td></tr>
		</table>
	</div>
	<div style="display:none">
		<div id="sever_flt_box"><select style="width:90%" onclick="(arguments[0]||window.event).cancelBubble=true;" onchange="filterBy()"></select></div>
		<div id="categ_flt_box"><select style="width:90%" onclick="(arguments[0]||window.event).cancelBubble=true;" onchange="filterBy()"></select></div>
	</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
</body>
<%
	}catch(Exception e){
	CyberoamLogger.appLog.debug("auditlog.jsp"+e,e);
}
%>
</html>
