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

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.beans.*"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%
	try{
		if(CheckSession.checkSession(request,response) < 0) return;
		int categoryId;
		if(request.getParameter("category")==null){
			categoryId = Integer.parseInt(session.getAttribute("categoryid").toString());
		}else{
			categoryId = Integer.parseInt(request.getParameter("category"));
		}
		String strProfileId = request.getParameter("profileid");
		String header = "";
		int iProfileId = -1;
		int mode = ApplicationModes.ADD_REPORT_PROFILE;
		ReportGroupBean reportGroupBean = null;
		ArrayList currReportGroupRelList = null;
		ArrayList currReportIdList = null;
		ReportGroupRelationBean reportGroupRelationBean = null;
		boolean isEdit = false;
		if(strProfileId == null || strProfileId.equalsIgnoreCase("")){
			header = TranslationHelper.getTranslatedMessge("Add Custom View");
		}
		else {
			header = TranslationHelper.getTranslatedMessge("Edit Custom View");
			iProfileId = Integer.parseInt(strProfileId);
			reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(iProfileId);
			mode = ApplicationModes.UPDATE_REPORT_PROFILE;
			currReportGroupRelList = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportGroupBean.getReportGroupId()));
			currReportIdList = new ArrayList(currReportGroupRelList.size());
			for(int i=0; i<currReportGroupRelList.size(); i++){
				reportGroupRelationBean = (ReportGroupRelationBean)currReportGroupRelList.get(i); 
				currReportIdList.add(new Integer(reportGroupRelationBean.getReportId()));
			}
			isEdit = true;
		}
%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<html>
<head>
<TITLE><%=iViewConfigBean.TITLE%></TITLE>
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="/javascript/cyberoam.js"></script>
<script type="text/javascript">
var totalSel = 0;
function viewReports(reportgroupid){
	var img0 = document.getElementById('img0_'+reportgroupid);
	var img1 = document.getElementById('img1_'+reportgroupid);
	var row = document.getElementById('row_'+reportgroupid);
	var temp = img0.value;
	img0.value = img1.src;
	img1.src = temp;
	if(row.style.display == 'none' ){
		row.style.display = ''; 
	} else {
		row.style.display = 'none'; 
	}
}
function viewSubReports(reportgroupid){
	var img0 = document.getElementById('level2img0_'+reportgroupid);
	var img1 = document.getElementById('level2img1_'+reportgroupid);
	var row = document.getElementById('level2row_'+reportgroupid);
	var temp = img0.value;
	img0.value = img1.src;
	img1.src = temp;
	if(row.style.display == 'none' ){
		row.style.display = ''; 
	} else {
		row.style.display = 'none'; 
	}
}
function selectME(obj,id){
	elecount = document.getElementById("cnt_"+id).value;
	if(obj.checked == true){
		elecount++;
		totalSel++;
	}else{
		elecount--;
		totalSel--;
	}
	if(totalSel == 9){
		obj.checked = false;
		totalSel --;
		elecount--;
		alert("You can select only 8 reports");
		return;
	}
	if(elecount > 0){
		document.getElementById("star_"+id).style.visibility = "";
		document.getElementById("cntshow_"+id).innerHTML = "("+elecount+")";
	}else{
		document.getElementById("star_"+id).style.visibility = "hidden";
		document.getElementById("cntshow_"+id).innerHTML = "";
	}
	document.getElementById("cnt_"+id).value = elecount;
}
window.onload = function (evt) {
	//setWidth();				
}	
function setWidth(){
	var main_div = document.getElementById("main_content");	
	main_div.style.width = (document.body.clientWidth - 218);	
}
function validate(){
	nameReExp = new RegExp("^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$");
	if (document.managereportprofileform.profilename.value == ''){
		alert('<%=TranslationHelper.getTranslatedMessge("You must enter the View Name")%>');
		document.managereportprofileform.profilename.focus();
		return false;
	}else if (!nameReExp.test(document.managereportprofileform.profilename.value)){
		alert("<%=TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@', ' ' and '.' allowed in View Name")%>");
		document.managereportprofileform.profilename.focus();
		return false;
	}

	var cnt = 0; 
	for(i=0; i<document.managereportprofileform.reportid.length; i++){
		if(document.managereportprofileform.reportid[i].checked){
			cnt++;
		}
	}
	if(cnt==0){
		alert('<%=TranslationHelper.getTranslatedMessge("You must select atleast one report.")%>');
		return false;
	} else if(cnt > 8){
		alert('<%=TranslationHelper.getTranslatedMessge("maximum 8 reports are allowed in one View.")%>');
		return false;
	}
	<%if(isEdit){%>
		var con = confirm('<%=TranslationHelper.getTranslatedMessge("Are you sure you want to update Custom View?")%>');
	<%} else {%>
		var con = confirm('<%=TranslationHelper.getTranslatedMessge("Are you sure you want to add Custom View?")%>');
	<%}%>
	if(con){
		document.managereportprofileform.submit();
	}
}

function getReportGroup(){
	var ele = document.getElementById("reportList");
	var id = document.getElementById("customViewCategory").value;

	// deleting rows
	while(ele.rows.length>1){
		document.all.reportList.deleteRow(ele.rows.length-1);			
	}
	
<%
	Iterator allCategoryBeanItr = CategoryBean.getAllCategoryIterator();  
	CategoryBean allCategoryBean= null;
	while(allCategoryBeanItr.hasNext()){	  		
		allCategoryBean = (CategoryBean)allCategoryBeanItr.next();
%>
		if(id == <%=allCategoryBean.getCategoryId()%>){
		var rowStyle = "trdark";	
		var oddRow = 1;
				
<%			//ArrayList reportGroupBeanList = CategoryBean.getReportGroupIdByCategoryId(allCategoryBean.getCategoryId());
			ArrayList<Integer> reportGroupBeanList = CategoryReportGroupRelationBean.getReportgroupListByCategory(allCategoryBean.getCategoryId());			
			reportGroupBean = null;
			ArrayList reportGroupRelationList = null;
			ReportBean reportBean = null;
	
			int tblCount=0;
			int recordCount=0;			
			if(reportGroupBeanList!=null && reportGroupBeanList.size()>0){				
				for(;recordCount<reportGroupBeanList.size();recordCount++){					
					reportGroupBean = ReportGroupBean.getSQLRecordByPrimaryKey(reportGroupBeanList.get(recordCount));
					if(reportGroupBean.getGroupType() == ReportGroupBean.STATIC_GROUP){
						reportGroupRelationList = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportGroupBean.getReportGroupId()));
%>						
						if(oddRow==0){					
							rowStyle = "trdark";					
						}else{				
							rowStyle = "trlight";
						}
						oddRow=1-oddRow;


						row1 = ele.insertRow(-1);
						row1.className = rowStyle;
						cell1 = row1.insertCell(-1);
						cell1.className = "tddata";
						cell1.innerHTML = "<center><input type='hidden' id='img0_<%=reportGroupBean.getReportGroupId()%>' value='<%=request.getContextPath()%>/images/collapse.gif' /> 	<img id='img1_<%=reportGroupBean.getReportGroupId()%>' onclick='viewReports(<%=reportGroupBean.getReportGroupId()%>)'  src='<%=request.getContextPath()%>/images/inactiveexpand.gif' style='cursor: pointer;' />"

						
												
						cell1 = row1.insertCell(-1);
						cell1.id = "desc_<%=reportGroupBean.getReportGroupId()%>";
						cell1.className = "tddata";
						cell1.innerHTML = "<div style='float:left;'><%=reportGroupBean.getTitle()%>&nbsp;</div><div id='star_<%=reportGroupBean.getReportGroupId()%>' style='visibility:hidden;float:left;'><font class='compfield'>*&nbsp;</font></div> <div id='cntshow_<%=reportGroupBean.getReportGroupId()%>' ></div>"						
											
						row1 = ele.insertRow(-1);
						row1.id = "row_<%=reportGroupBean.getReportGroupId()%>";
						row1.style.display="none";

						
												
						cell1 = row1.insertCell(-1);
						cell1.className = "tddata";
						cell1.innerHTML = "<input type='hidden' id='cnt_<%=reportGroupBean.getReportGroupId()%>' value ='0' >"
										
						cell1 = row1.insertCell(-1);
						cell1.className = "tddata";	
						cell1.innerHTML = "<table id='tblinner<%=tblCount%>' border='0' cellpadding='0' cellspacing='0' width='100%'>";

						var innerTable = document.getElementById("tblinner<%=tblCount%>");
						
						var j=0;
						<%
						tblCount++;
						boolean isChecked = false;
						
						for(int i=0; i<reportGroupRelationList.size(); i++){
							reportGroupRelationBean = (ReportGroupRelationBean)reportGroupRelationList.get(i);
							reportBean = ReportBean.getRecordbyPrimarykey(reportGroupRelationBean.getReportId());
							if(reportBean.getIsSingleReport() == 1){%>
							row1 = innerTable.insertRow(-1);
						
						if(j==0){
							row1.className="trdark";
						}							
						else{
							row1.className="trlight";
						}
						j=1-j;
						cell1 = row1.insertCell(-1);
						cell1.className = "tddata";
						cell1.style.align="center";
						cell1.innerHTML = "<center><input type='hidden' id='level2img0_<%=reportBean.getReportId()%>' value='<%=request.getContextPath()%>/images/collapse.gif' /> <img id='level2img1_<%=reportBean.getReportId()%>' onclick='viewSubReports(<%=reportBean.getReportId()%>)'  src='<%=request.getContextPath()%>/images/inactiveexpand.gif' style='cursor: pointer;' />"
					
						
						cell1 = row1.insertCell(-1);
						cell1.id = "level2desc_<%=reportBean.getReportId()%>";
						cell1.className = "tddata";
						cell1.innerHTML = "<div style='float:left;'><%=reportBean.getTitle()%>&nbsp;</div><div id='level2star_<%=reportBean.getReportId()%>' style='visibility:hidden;float:left;'><font class='compfield'>*&nbsp;</font></div> <div id='level2cntshow_<%=reportBean.getReportId()%>' ></div>"
						
						row1 = innerTable.insertRow(-1);
						row1.id = "level2row_<%=reportBean.getReportId()%>";
						row1.style.display="none";
						
						
						cell1 = row1.insertCell(-1);
						cell1.className = "tddata";
						cell1.innerHTML = "<input type='hidden' id='level2cnt_<%=reportBean.getReportId()%>' value ='0' >"
										
						cell1 = row1.insertCell(-1);
						cell1.className = "tddata";	
						cell1.innerHTML = "<table id='level2tblinner<%=tblCount%>' border='0' cellpadding='0' cellspacing='0' width='100%'>";
						var level2innerTable = document.getElementById("level2tblinner<%=tblCount%>");
						
						<%
						tblCount++;
						ArrayList reportGroupRelationList2Level = null;								
						reportGroupRelationList2Level = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportBean.getReportId()));
						for(int i2level=0; i2level<reportGroupRelationList2Level.size(); i2level++){
							reportGroupRelationBean = (ReportGroupRelationBean)reportGroupRelationList2Level.get(i2level);
							reportBean = ReportBean.getRecordbyPrimarykey(reportGroupRelationBean.getReportId());
							if(currReportIdList != null){
								isChecked = currReportIdList.contains(new Integer(reportBean.getReportId()));
							}
							
							%>
							row1 = level2innerTable.insertRow(-1);
							<%if((i2level+i)%2==0)
							{
							%>
							row1.className="trdark";
							<%}else{%>
								row1.className="trlight";
							<%}%>
							
							cell1 = row1.insertCell(-1);
							cell1.className = "tddata";
							cell1.style.width="5%";
							cell1.style.align="center";
							cell1.innerHTML="<input type='checkbox' id='chk_<%=reportGroupBean.getReportGroupId()%>_<%=i%>' name='reportid'<%=(isChecked)?"checked":""%> value='<%=reportBean.getReportId()%>' onclick='selectME(this,<%=reportGroupBean.getReportGroupId()%>)'>"
							
							cell1 = row1.insertCell(-1);							
							cell1.className = "tddata";
							cell1.innerHTML = "<%=reportBean.getTitle()%>";
							<%if(isChecked){%>
							
							<%}
						}
						}
						else{
							if(currReportIdList != null){
								isChecked = currReportIdList.contains(new Integer(reportBean.getReportId()));
							}
%>
							row1 = innerTable.insertRow(-1);

							if(j==0){
								row1.className="trdark";
							}							
							else{
								row1.className="trlight";
							}
							j=1-j;
					
							cell1 = row1.insertCell(-1);
							cell1.className = "tddata";
							cell1.style.width="5%";
							cell1.innerHTML="<center><input type='checkbox' id='chk_<%=reportGroupBean.getReportGroupId()%>_<%=i%>' name='reportid'<%=(isChecked)?"checked":""%> value='<%=reportBean.getReportId()%>' onclick='selectME(this,<%=reportGroupBean.getReportGroupId()%>)'>"
							
							cell1 = row1.insertCell(-1);							
							cell1.className = "tddata";
							cell1.innerHTML = "<%=reportBean.getTitle()%>";
							

							<%	if(isChecked){  %>		
												
							selectME(document.getElementById("chk_<%=reportGroupBean.getReportGroupId()%>_<%=i%>"),<%=reportGroupBean.getReportGroupId()%>);
							
						
							<%		 			}
						}						
						}		
				}											
			}
		} %>

	}
<%
	}
%>			
}


</script>
</head>
<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>  
	<div class="maincontent" id="main_content">
		<div class="reporttitlebar">
			<div class="reporttitlebarleft"></div>
			<div class="reporttitle"><%=TranslationHelper.getTranslatedMessge("Custom View")%></div>
		</div>
		<br><br>
		
<%		
		if(strProfileId == null || strProfileId.equalsIgnoreCase("")){
			header = TranslationHelper.getTranslatedMessge("Add Custom View");
		}
		else {
			header = TranslationHelper.getTranslatedMessge("Edit Custom View");
			iProfileId = Integer.parseInt(strProfileId);
			reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(iProfileId);
			mode = ApplicationModes.UPDATE_REPORT_PROFILE;
			currReportGroupRelList = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportGroupBean.getReportGroupId()));
			currReportIdList = new ArrayList(currReportGroupRelList.size());
			for(int i=0; i<currReportGroupRelList.size(); i++){
				reportGroupRelationBean = (ReportGroupRelationBean)currReportGroupRelList.get(i); 
				currReportIdList.add(new Integer(reportGroupRelationBean.getReportId()));
			}
			isEdit = true;
		}		
%>

	<form action="<%=request.getContextPath()%>/iview" method="post" name="managereportprofileform" >
	<input type="hidden" name="appmode" value="<%=mode%>" >
	<input type="hidden" name="profileid" value="<%=(isEdit)?reportGroupBean.getReportGroupId():""%>" >
	<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin-bottom: 2px;margin-left:2px;">
	<tr>
		<td class="tdhead" colspan="2"><%=header%></td>
	</tr>
	<tr class="trdark">
		<td class="tddata" width="35%"><%=TranslationHelper.getTranslatedMessge("Custom View Name :")%> </td>
		<td class="tddata"><input type="text" class="datafield" value="<%=(isEdit)?reportGroupBean.getTitle():""%>" name="profilename" <%=(isEdit)?"readonly='readonly'":""%>></td>
	</tr>
	<tr class="trdark">
		<td class="tddata"><%=TranslationHelper.getTranslatedMessge("Custom View Description :")%> </td>
		<td class="tddata">
			<textarea class="datafield" name="profiledesc"><%=((isEdit && reportGroupBean.getDescription()!=null)?reportGroupBean.getDescription():"")%></textarea>
		</td>
	</tr>
	<tr class="trdark">
		<td class="tddata"><%=TranslationHelper.getTranslatedMessge("Category Type :")%> </td>
		<td class="tddata">
		<select id="customViewCategory" name="customViewCategory" style='width:27%' <%=(isEdit?"disabled=true":"")%> onchange='getReportGroup()'>
 
  		<%   			
  			Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
  			CategoryBean categoryBean= null;
  			while(categoryBeanItr.hasNext()){
  				categoryBean = (CategoryBean)categoryBeanItr.next();			
				if(categoryBean.getCategoryId()== categoryId){ %>   				
  					<option value='<%=categoryBean.getCategoryId()%>' selected ><%=categoryBean.getCategoryName()%></option>  				
  				<% }else{ %>  				  				
     				
  					<option value='<%=categoryBean.getCategoryId()%>'><%=categoryBean.getCategoryName()%></option>  				
  		<% 		}
  				}
  		%>
  		</select>
		</td>
	</tr>
	<tr class="trdark">
		<td class="tddata" ><%=TranslationHelper.getTranslatedMessge("Select Report :")%> </td>
		<td class="helpfont"><%=TranslationHelper.getTranslatedMessge("You can select 8 reports")%></td>
	</tr>
	<tr class="trdark">
		<td class="tddata" colspan="2" align="center">
			<table id="reportList" width="75%" border="0" cellpadding="0" cellspacing="0" class="TableData">
			
			<tr>
				<td class="tdhead">&nbsp;</td>
				<td class="tdhead"><%=TranslationHelper.getTranslatedMessge("Report Groups")%></td>
			</tr>

			<script>
				getReportGroup();
			</script>
			
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge((isEdit)?"Update":"Add")%>" onclick="validate()">
			<input class="criButton" type="button" value="<%=TranslationHelper.getTranslatedMessge("Cancel")%>" onclick="location.href='<%= request.getContextPath() %>/webpages/reportprofile.jsp'">
		</td>
	</tr>
	</table>
	</form>
	</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
</body>
</html>
<%
	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in reportprofile.jsp : "+e,e);
}
%>
