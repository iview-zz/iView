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
<%@page import="org.cyberoam.iview.utility.*"%>
<%@page import="org.cyberoam.iview.beans.SearchDataBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.beans.ArchiveSearchParameter"%>
<%@page import="org.cyberoam.iview.beans.IndexFieldsBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	try{
		if(CheckSession.checkSession(request,response)<0){
			return;
		}
		
		if(request.getParameter("isSearch")!=null && "true".equalsIgnoreCase(request.getParameter("isSearch"))){
			ArchiveSearchParameter.setSessionObj(request);
		} else {
			session.removeAttribute("archievesearch");
		}
		//String tabNo = request.getParameter("tabno");
		/*if(tabNo == null || tabNo.equalsIgnoreCase("")){
			tabNo = "2";
		}*/
		ArchiveSearchParameter archiveSearchParameter = ArchiveSearchParameter.getSessionObj(request);
		
		//for dinemic archivelogs.jsp depending on categoryID		
		String categoryID = (String)session.getAttribute("categoryid");		
		ArrayList<IndexFieldsBean> indexFileList = IndexFieldsBean.getIndexFieldBeanListByCategoryID(categoryID);				
%>
<%@page import="org.cyberoam.iview.utility.DateDifference"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.beans.SearchIndexBean"%>
<%@page import="java.util.logging.ErrorManager"%><html>
<head>
<title><%=iViewConfigBean.TITLE%></title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/container.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/tabs.css">
<script src="<%=request.getContextPath()%>/javascript/combo.js"></script>
<script src="<%=request.getContextPath()%>/javascript/container.js"></script>
<script src="<%=request.getContextPath()%>/javascript/utilities.js"></script>
<style type="text/css">
.message{
	border: 1px solid #D9D9D9;
	margin: 3px 0 0 2px;
}
.message tr{
	background-color: #F1F1F1;
}
.message tr td{
	font-family: tahoma,arial,san-serif;
	font-size: 11px;
	padding: 3px;
	color: maroon;
	font-weight: bold;
}
</style>
<script type="text/javascript" language="javascript">
	
   	var http_request = false;
   	var childwindow;
	var fieldArray = new Array();
	var tablefieldArray = new Array();
	var criteriaArray = new Array("is","isn't","contains","starts with");
	var criteriaValueArray = new Array("=","!="," like '%"," like '");
	var numCriteriaArray = new Array("&gt;","&lt;",">=","<=");
	var numCriteriaValueArray = new Array(">","<",">=","<=");

	window.onload = function (evt) {
		setWidth();				
	};
	
	
	
			
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}
   	
	function submitData(url,lotsize,totalrecord,currentposition,criteria,tblname){
		
		var form = document.archivelogs;
		form.lotSize.value = lotsize;
		form.curPos.value = currentposition;
		form.submit();
	}
	function jumptopage(curPageNo){
		var pageno = document.getElementById("gotopage").value;
		if(pageno > 2147483647){
			alert("Please enter valid page number");
			return;
		}
		var lastpage = parseInt(document.archivelogs.lastpage.value);
		var form = document.archivelogs;
		if(false/*pageno == "" || isNaN(pageno) || pageno<1 || pageno>lastpage*/) {
			alert("<%=TranslationHelper.getTranslatedMessge("Please enter valid page no.")%>");
		} else if(curPageNo != pageno ) {

			var element = document.getElementById("Combo_selectsizelimit");
			var limit = element.innerHTML;
			var curPos = ((document.archivelogs.lotSize.value * pageno) - document.archivelogs.lotSize.value);
			submitData('<%=request.getContextPath()%>/webpages/archivelogs.jsp',limit,form.totalSize.value,curPos,form.criteria.value,form.tblname.value);
		} 
	}
	function showSearchingCriteria(){
		var objDiv = document.getElementById('searchdiv');
		if(objDiv.style.display == "none"){
			objDiv.style.display="";
		} else {
			objDiv.style.display="none";
		}
	}
	function hideSearchingCriteria(){
		var objDiv = document.getElementById('searchdiv');
		objDiv.style.display="none";
	}

	function URLEncode (clearString) {
  		var output = '';
  		var x = 0;
  		clearString = clearString.toString();
  		var regex = /(^[a-zA-Z0-9_.]*)/;
  		while (x < clearString.length) {
    		var match = regex.exec(clearString.substr(x));
    		if (match != null && match.length > 1 && match[1] != '') {
    			output += match[1];
      			x += match[1].length;
    		} else {
      			if (clearString[x] == ' ')
        			output += '+';
      			else {
        			var charCode = clearString.charCodeAt(x);
        			var hexVal = charCode.toString(16);
        			output += '%' + ( hexVal.length < 2 ? '0' : '' ) + hexVal.toUpperCase();
      			}
      			x++;
    		}
  		}
  		return output;
	}
	function changeImg(){
		var tempImg = document.archivelogs.searchCrit1.value;
		document.archivelogs.searchCrit1.value = document.getElementById("searchCrit").src;
		document.getElementById("searchCrit").src = tempImg;
		showSearchingCriteria();
	}

	function setComboContainer1(id,width,mainid) {
		var combo = document.getElementById(id);
		combo.onclick = function(){showComboBody(this.id)};
		combo.style.width = width;
		var newdiv = document.createElement("div");
		newdiv.className = "Combo_select";
		newdiv.id = "Combo_select"+id;
		newdiv.innerHTML = "Select item";
		newdiv.style.width = (parseInt(combo.style.width) - 20)+"px";
		combo.appendChild(newdiv);
		
		newdiv = document.createElement("div");
		newdiv.className = "Combo_button";
		newdiv.innerHTML="<input type=\"hidden\" id=\"comboFlag"+id+"\" value="+mainid+" />";
		newdiv.style.left=(parseInt(combo.style.width)-20)+"px";
		combo.appendChild(newdiv);
		newdiv = document.createElement("div");
		newdiv.id="Combo_body"+id;
		newdiv.className="hidden";
		combo.appendChild(newdiv);
	}
	function insertElements1(id,arr,totalSize,curPos,criteria,tblname){
		
		
		var flag = document.getElementById("comboFlag"+id).value;
		var ele = document.getElementById("Combo_body"+id);		
		for(var x=0 ; x< arr.length ;x++){
			newdiv = document.createElement("div");
			newdiv.className = "Combo_item_single";
			newdiv.id = "Combo_item"+id+"_"+x;						
			newdiv.onclick = function(e){
								var str = this.id;
								var index = str.lastIndexOf("_");
								var myid = str.substring(10,index);
								var pos = str.substring(index+1);																																														
								//submitData('<%=request.getContextPath()%>/webpages/archivelogs.jsp',document.getElementById('Combo_itemsizelimit_'+pos).innerHTML,totalSize,curPos,criteria,tblname);
					
								submitData('<%=request.getContextPath()%>/webpages/archivelogs.jsp',document.getElementById('Combo_itemsizelimit_'+pos).innerHTML,totalSize,0,criteria,tblname);
					
							}
			newdiv.innerHTML = arr[x];
			ele.appendChild(newdiv);
		}
		highlightdiv(id);
	}
	function setSelectedText1(id,text){
		document.getElementById("Combo_select"+id).innerHTML = text;
	}
</script>
<!-- script src="<%=request.getContextPath()%>/javascript/container.js"></script-->
<script type="text/javascript" language="JavaScript" src="<%=request.getContextPath()%>/javascript/SearchData.js"></script>
</head>
<body>

<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>        
<div class="maincontent" id="main_content">
<jsp:include page="Date.jsp" flush="true">
	<jsp:param name="device"	value="true"></jsp:param>
</jsp:include>
<%
	String dataValue=null;
	int intLotSize=10;
	int intDisplayRowLog=0;
	long longTotalRecordCount=0;
	long longCurrentRecordPosition=0;
	String msg=request.getParameter("flag");
	String query = " where";
	String tblname="tblindex"+(new SimpleDateFormat("yyyyMMdd")).format(DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd hh:mm:ss"));
	if(tblname == null){
		tblname="";
	}
	
	String strLotSize= request.getParameter("lotSize");
	String strCurrentRecordPosition = request.getParameter("curPos");
	String strCriteria = request.getParameter("criteria");
	String indexCriteria = request.getParameter("indexCriteria");	
	
	String message = "";
	Date startDateDt = DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd hh:mm:ss");
	Date endDateDt = DateDifference.stringToDate((String)session.getAttribute("enddate"),"yyyy-MM-dd hh:mm:ss");
	
	HashMap<String,String> criteriaList = new HashMap<String,String>();
	
	if(PrepareQuery.calculateDifference(startDateDt,endDateDt) > 0){
		message = "Start Date and End Date are different. Logs for " + (new SimpleDateFormat("yyyy-MM-dd")).format(DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd"));
		message += " date are displayed.";		
		
		criteriaList.put("upload_datetimeStart",">=,"+(String)session.getAttribute("startdate")); 
		criteriaList.put("upload_datetimeEnd","<=,"+(new SimpleDateFormat("yyyy-MM-dd")).format(DateDifference.stringToDate((String)session.getAttribute("enddate"),"yyyy-MM-dd")) + " 23:59:59");
	} else {		
		criteriaList.put("upload_datetimeStart",">=,"+(String)session.getAttribute("startdate")); 
		criteriaList.put("upload_datetimeEnd","<=,"+(String)session.getAttribute("enddate"));
	}	
	
	criteriaList.put("device_name","=,"+(String)session.getAttribute("appliancelist"));
	criteriaList.put("indexCriteria",indexCriteria);	
	//longTotalRecordCount = SearchDataBean.getTotalRecordCount(tblname,query);
	if(longTotalRecordCount < 0){
		longTotalRecordCount = 0;
	}
	if(strLotSize != null){
		URLDecoder.decode(strLotSize);
		intLotSize = Integer.parseInt(strLotSize);
		if(intLotSize < 5){
			intLotSize=5;
		}
	}
	if(strCurrentRecordPosition != null){
		longCurrentRecordPosition = Long.parseLong(strCurrentRecordPosition);
		if(longCurrentRecordPosition < 0){
			longCurrentRecordPosition=0;
		}
	}
	long iTotalpage = (long)Math.ceil((double)longTotalRecordCount/(double)intLotSize);
	if(iTotalpage<=0){
		iTotalpage = 1;
	}

	if(request.getParameter("advSearch") != null && request.getParameter("advSearch").equals("true"))
		longCurrentRecordPosition = 0;
	criteriaList.put("limit","=,"+intLotSize);
	criteriaList.put("offset","=,"+longCurrentRecordPosition);
	criteriaList.put("categoryID","=,"+categoryID);
	
	String [] columnArray=null;
	boolean nextFlag = false;
	ArrayList recordArray = null;
	if(indexCriteria == null || indexCriteria.equals("null"))
		recordArray = SearchIndexBean.getDateRangeData(criteriaList);
	else
		recordArray = SearchIndexBean.getSearchData(criteriaList);

	
	if(recordArray.size() == intLotSize + 1)
	{
		nextFlag = true;
		recordArray.remove(recordArray.size() - 1);
	}
		
%>

<div style="float: left;width: 100%;margin-top: 5px;">
<form name="archivelogs" action="<%=request.getContextPath()%>/webpages/archivelogs.jsp" method="POST">
<input type="hidden" name="curPos" value="<%=longCurrentRecordPosition%>" />
<input type="hidden" name="lotSize" value="<%=intLotSize%>" />
<input type="hidden" name="totalSize" value="<%=longTotalRecordCount%>" />
<input type="hidden" name="lastpage" value="<%=iTotalpage%>" />
<input type="hidden" name="tblname" value="<%=tblname%>" />
<input type="hidden" name="advSearch"/>
<input type="hidden" name="isSearch" value="<%= request.getParameter("isSearch")!=null && "true".equalsIgnoreCase(request.getParameter("isSearch"))?"true":"false" %>" />
<input type="hidden" name="andorvalue" value="<%=(archiveSearchParameter==null || archiveSearchParameter.getAndOrValue()==null)?" AND ":archiveSearchParameter.getAndOrValue()%>" />
<input type="hidden" name="criteria" value="<%=(archiveSearchParameter==null || archiveSearchParameter.getCriteria()==null)?"":archiveSearchParameter.getCriteria()%>" />
<input type="hidden" name="indexCriteria" value="<%=request.getParameter("indexCriteria")%>" />

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="padding-top: 0px">
<tr>
	<td align="left">

				
				<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin: 3px 0 0 2px;">
				<tr>
					<td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr class="tabhead">
							<div class="reporttitlebar">
								<div class="reporttitlebarleft"></div>
									<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Raw Logs")%></div>
							</div>
								
								
						</tr>
						
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<div class="content_head">
							<table width="100%" cellspacing="0" cellpadding="3">
								<tr>
									<td align="left" class="navigationfont" width="200px"><span style="float:left;margin-top:1px;"><%=TranslationHelper.getTranslatedMessge("Show")%>&nbsp;
										</span><span style="float:left"><div id="sizelimit" class="Combo_container" style="margin-bottom:3px;"></div>
										</span><span style="float:left;margin-top:1px;">&nbsp;<%=TranslationHelper.getTranslatedMessge("results per page")%></span>
									</td>
									<!--  <td><a id="xlsLinkForArchive" href="" onclick="getXLSFile(<%=intLotSize%>,<%=longCurrentRecordPosition%>,'<%=tblname%>','<%=strCriteria%>',URLEncode('<%=indexCriteria%>'))"> 
										<img src="../images/csvIcon.jpg" class="xlslink"></img>
										</a>
									</td>-->
									<script language="javascript">
										setComboContainer1("sizelimit","40px","1");										
										insertElements1("sizelimit",["5","10","15","20","25","50","100","500","1000"],"<%=longTotalRecordCount%>","<%=longCurrentRecordPosition%>","<%=(archiveSearchParameter==null || archiveSearchParameter.getCriteria()==null)?"":archiveSearchParameter.getCriteria()%>","<%=tblname%>");
										setSelectedText1("sizelimit","<%=intLotSize%>");
									</script>
									<td class="navigationfont" align="right">
									<span style="float:right;margin-right:10px;"><input type='button' class='navibutton' value='Go' onClick="jumptopage(<%=(longCurrentRecordPosition/intLotSize)+1%>);"" ></span>
									<span style="float:right"><input class="navitext" id="gotopage" size="5" type="text" style="width:35px;margin-left:5px;margin-right:5px;"></span>
									<span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("Go to page :")%></span>
									<!-- dont remove below line, this is to display total no. of recored and its replacement is next to it-->									
									<!--span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("Page")%>&nbsp;<%=(longCurrentRecordPosition/intLotSize)+1%>&nbsp;<%=TranslationHelper.getTranslatedMessge("of")%>&nbsp;<%=iTotalpage%></span-->									
									<span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=TranslationHelper.getTranslatedMessge("Page")%>&nbsp;<%=(longCurrentRecordPosition/intLotSize)+1%></span>
									<span style="float:right">
										<!-- dont remove below line, it is to move to first records  -->
										<!--img src="../images/first.bmp" style="cursor: pointer;" onClick="submitData('<%=request.getContextPath()%>/webpages/archivelogs.jsp','<%=intLotSize%>','<%=longTotalRecordCount%>','0','<%=""%>','<%=tblname%>');" -->
										<%
											if((longCurrentRecordPosition-intLotSize) >= 0){
										%>
										<img src="../images/prev.bmp" style="cursor: pointer;" onClick="submitData('<%=request.getContextPath()%>/webpages/archivelogs.jsp','<%=intLotSize%>','<%=longTotalRecordCount%>','<%=longCurrentRecordPosition-intLotSize%>','<%=""%>','<%=tblname%>');" >
										<%
											} else {
										%>
										<img src="../images/prev.bmp" style="cursor: pointer;" onClick="" >
										<%
											}
										%>
										<%
											if(nextFlag/*(longTotalRecordCount-longCurrentRecordPosition) > intLotSize*/){
										%>
										<img src="../images/next.bmp" style="cursor: pointer;" onClick="submitData('<%=request.getContextPath()%>/webpages/archivelogs.jsp','<%=intLotSize%>','<%=longTotalRecordCount%>','<%=longCurrentRecordPosition+intLotSize%>','<%=""%>','<%=tblname%>');" >
										<%
											} else {
										%>
										<img src="../images/next.bmp" style="cursor: pointer;" onClick="" >
										<%
											}
										%>				
										<!-- dont remove below line, it is to move to last records  -->						
										
									</span>							
									</td>
								</tr>								
								</table>
							
						</div>
						<div id="content1" class="content_act" style="width:100%">
							<table class="TableData" width="100%" cellspacing="0" cellpadding="3">
<% 
	if(recordArray != null){
	boolean oddLine = true;
	if(recordArray.size() == 0){		
		String errMessage = "No data found";
		if(SearchIndexBean.getMessage().equals("Java heap space")){
			SearchIndexBean.setMessage("");
			errMessage = "search limit exceed, please reduce search results.";
		}
%>		
	<tr class="trlight" onMouseOver='this.className="trlight1"' onMouseOut='this.className="trlight"' height="20px">
		<td class="tddata" align="center" colspan="<%=indexFileList.size()-2%>"><%=errMessage%></td>		
	</tr>
<% 	}
	for(int recordcount=0;recordcount<recordArray.size();recordcount++){
		if(oddLine){
%>

								<tr class="trlight" onMouseOver='this.className="trlight1"' onMouseOut='this.className="trlight"' height="20px">
<%
	} else {
%>		
								<tr class="trdark" onMouseOver='this.className="trdark1"' onMouseOut='this.className="trdark"' height="20px">
<%
	}	
		oddLine = !(oddLine);
		dataValue=(String)recordArray.get(recordcount);
		
		columnArray=dataValue.split(" ");
		
		for(int columncount=0;columncount<columnArray.length-1;columncount++){
			
			if(columnArray != null ){
					
				String str=columnArray[columncount];
%>
		
									<td class="tddata" align="left">
										<%=str.length() > 50 ? str.subSequence(0,50)+"...":str%>
										<%=(columncount==0)?"</nobr>":""%>
									</td>
<%
			} else {
%>
									<td class="tddata" align="center">-</td>
<%
	}
		}
%>
								</tr>
<%
	}
}else{
%>
								<tr class="trdark"><td class="tddata" colspan="10" align="center"><%=TranslationHelper.getTranslatedMessge("No Logs Avaiable")%></td></tr>
<%
	}
%>
							</table>
						</div>
						
	
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	

</div>
</form>
</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>

</body>
<%
	} catch(Exception e) {
		CyberoamLogger.appLog.debug("Archiveogs=>"+e,e);
		out.println("Error : "+e);
	}
%>
</html>
