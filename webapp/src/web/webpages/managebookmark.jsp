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
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.modes.TabularReportConstants"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="java.util.*"%>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.beans.BookmarkGroupBean"%>
<%@page import="org.cyberoam.iview.beans.BookmarkBean"%>
<%@page import="org.cyberoam.iview.beans.CategoryBean"%>
<%
	try{
	if(CheckSession.checkSession(request,response)<0)
		return;
	String fontClass="";
	String strStatus="";
	if(session.getAttribute("status")!=null){
		 strStatus = session.getAttribute("status").toString();
		 session.removeAttribute("status");
	}
	
%>

<HTML>
<HEAD>
	<TITLE><%=iViewConfigBean.TITLE%></TITLE>
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<LINK rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reports.css" />
	<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/css/configuration.css" rel="stylesheet" type="text/css" />
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/protocolgroup.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/popupform.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/utilities.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/ipvalidation.js"></SCRIPT>
	<SCRIPT LANGUAGE="Javascript">
	
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}

		window.onload = function (evt) {
			setWidth();
			//getWinSize();			
		}		
		
	function openAddBookmarkGroup(){
			URL = '<%=request.getContextPath()%>/webpages/addBookmarkGroup.jsp';
			handleThickBox('1','bookmarkgroup','500');
	}
	function deleteBookmarkGroup(id,bookmarkgroup){
		var answer;
	    	answer=confirm("Are you sure to delete " + bookmarkgroup + " Bookmark group?");
	    if(answer){
	    	document.frmProtocolGroup.id.value=id;
	    	document.frmProtocolGroup.appmode.value=<%=ApplicationModes.DELETE_BOOKMARK_GROUP%>;	
			document.frmProtocolGroup.submit();
		}
	}
	function deleteBookmark(id,bookmark){
		var answer;
	    	answer=confirm("Are you sure to delete " + bookmark + " Bookmark ?");
	    if(answer){
	    	document.frmProtocolGroup.id.value=id;
	    	document.frmProtocolGroup.appmode.value=<%=ApplicationModes.DELETE_BOOKMARK%>;	
			document.frmProtocolGroup.submit();
		}
	}
	function checkBlankGroupname(){
		if(document.getElementByID("bmg_name").value==""){
			alert("Please Enter Group Name");
			return false;
		}
		return true;
	}
	

	</SCRIPT>
</HEAD>
<BODY>
<jsp:include page="menu.jsp" flush="true"></jsp:include>
<jsp:include page="pageheader.jsp" flush="true"></jsp:include>
<div class = "maincontent" id="main_content">
	<div class="reporttitlebar">
		<div class="reporttitlebarleft"></div>
		<div class="reporttitle">Bookmark Management</div>
	</div>
	<br /><br />
<%
	
	BookmarkGroupBean bookmarkGroupBean = null;
	BookmarkBean bookmarkBean = null;
	LinkedHashMap bookmarkGroupMap=null,bookmarkMap=null;
	Iterator bookmarkGroupIterator=null,bookmarkIterator=null;
	bookmarkGroupMap=BookmarkGroupBean.getRecord();

%>	
<FORM method="POST" name="frmProtocolGroup" action="<%=request.getContextPath()%>/iview">
<input type="hidden" name="id" value ="-1">
<input type="hidden" name="appmode" value ="-1">
<table width="100%" border="0" cellpadding="2" cellspacing="0" style="margin-bottom: 2px;margin-left:2px;">
	<tr>
		<td align="left" class="ButtonBack">
			<input class="criButton" type="button" onClick="openAddBookmarkGroup();" value="Add Bookmark Group">
		</td>
	</tr>
	</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top: 2px;margin-left:2px;">
 <%
	if(!"".equals(strStatus)){
%>
	<tr>
		<td class="posimessage" colspan="4">&nbsp;&nbsp;<%=strStatus%></td>
	</tr>
<%
	}
%>

	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="TableData">
			<tr>
				<td class="tdhead">&nbsp;</td>
				<td class="tdhead" width="20%">Bookmark Groups</td>
				<td class="tdhead" width="8%" align="center">Delete</td>
			</tr>
			<%
			if(bookmarkGroupMap != null && bookmarkGroupMap.size() > 0){
						bookmarkGroupIterator=bookmarkGroupMap.values().iterator();
						int grpCounter = 0;
						String rowStyle = "";
						String tdStyle="";
						String astyle="";
						while(bookmarkGroupIterator.hasNext()){
							grpCounter++;							
							if(grpCounter%2 == 0)
									rowStyle = "trdark";
								else
									rowStyle = "trlight";
								
								tdStyle="tddata";
								astyle="";
								bookmarkGroupBean=(BookmarkGroupBean)bookmarkGroupIterator.next();
			%>
						<tr class="<%=rowStyle%>">
							<td class="tddata" align="center" width="5%">
								<input type="hidden" id="<%="0_1_"+ grpCounter%>" value="<%=request.getContextPath()%>/images/collapse.gif" />
								<img id="<%="1_1_"+ grpCounter%>" src="<%=request.getContextPath()%>/images/inactiveexpand.gif" onClick="changeImg(this.id);" style="cursor: pointer;" />
							</td>								
							<td class="<%=tdStyle%>">
								<div  <%=astyle%>> <%=bookmarkGroupBean.getName()%> </div>
							</td>
							<% if(bookmarkGroupBean.getBookmarkGroupID()!=1){%>
							<td class="<%=tdStyle%>" align="center">
									<img src="<%=request.getContextPath()%>/images/false.gif" title="Disable" onClick="deleteBookmarkGroup(<%=bookmarkGroupBean.getBookmarkGroupID()%> ,'<%=bookmarkGroupBean.getName()%>')" >
							</td>
							<%} %>
							
							
						</tr>
						
							
								
								
						<%
							bookmarkMap=BookmarkBean.getRecord("bookmarkgroupid",bookmarkGroupBean.getBookmarkGroupID());
										if(bookmarkMap!=null && bookmarkMap.size()>0){
											bookmarkIterator=bookmarkMap.values().iterator();
											%>
											<tr class="trlight" id="1_<%=grpCounter%>_0" style="display: none;">
											<td class="tddata">&nbsp;</td>
											<td colspan="2" class="tddata" style="padding-left:0px;padding-right:0px">
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td class="tdhead">Bookmarks</td>												
												<td class="tdhead">Category</td>
												<td class="tdhead" colspan="2">Description</td>
												
											</tr>
										<%
											int protoCounter = 0;
											String protoRowStyle = "";
											String ptdStyle="";
											String pastyle="";
											while(bookmarkIterator.hasNext()){
												bookmarkBean=(BookmarkBean)bookmarkIterator.next();
												protoCounter++;
												if(protoCounter%2 == 0)
													protoRowStyle = "trdark";
												else
													protoRowStyle = "trlight";
												
													ptdStyle="tddata";
													pastyle="";										
										%>
								<tr class="<%=protoRowStyle%>">
									
									<td class="<%=ptdStyle%>" width="25%"><div <%=pastyle%>><%=bookmarkBean.getName()%> </div></td>
									<td class="<%=ptdStyle%>" width="10%"><div <%=pastyle%>><%=(CategoryBean.getRecordByPrimaryKey(bookmarkBean.getCategoryId())).getCategoryName() %></div></td>
									<%String description=bookmarkBean.getDescription(); 		
									%>
									<td class="<%=ptdStyle%>"><div <%=pastyle%> title="<%=description%>"><%=description.length()>60?description.substring(0,60)+"...":description %></div></td>
									<td class="<%=ptdStyle%>" width="8%" align="center"><img src="<%=request.getContextPath()%>/images/false.gif" title="Disable" onClick="deleteBookmark(<%=bookmarkBean.getBookmarkId() %>,'<%=bookmarkBean.getName()%>')"></td>							
								</tr>
	
						<%
							}
						%>
									</table>
									</td>
									</tr>
						<%
							}
										
						%>	
						
						
				<%
					}%>
						</table>
						</td>
						<td>&nbsp;</td>
					</tr>
								
			
			<%}else{}	
			%>
			
</table>
</FORM>
</div>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
<div class="TB_window" id="bookmarkgroup"></div>

</BODY> 
</HTML>
<%
	} catch(Exception e){
		CyberoamLogger.appLog.info("Exception in managebookmark.jsp"+e);
	}
%>
