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
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="org.cyberoam.iview.authentication.beans.IviewMenuBean" %>
<%@page import="org.cyberoam.iview.modes.ApplicationModes"%>
<%@page import="org.cyberoam.iview.authentication.beans.RoleBean"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iviewdb.utility.SqlReader"%>
<%@page import="org.cyberoam.iviewdb.utility.ResultSetWrapper"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="org.cyberoam.iview.beans.CategoryBean"%>
<%@page import="java.util.Iterator"%>

<html>
<head>
<%
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","no-store");
response.setDateHeader("Expires",0);
response.setHeader("Pragma","no-cache");
String categoryId=null;
 if(session.getAttribute("categoryid")!=null){	
		categoryId = (String)session.getAttribute("categoryid");	
	}
%>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<link href="../css/menu.css" rel="stylesheet" type="text/css" />
<link href="../css/newTheme.css" rel="stylesheet" type="text/css" />
<script src="../javascript/menu.js"></script>
<script src="../javascript/combo.js"></script>
</head>

    <div class="sidebar" id="sidebar">
     	<div class="imageheader">
			<div class="imageheader2">
    		</div>    		
  		</div>  	
  		<div align="center" >
  		<form name="frmcategory" action="<%=request.getContextPath()%>/iview" method="post">
  		  		 	  		   		 
  		<div id="categoryid" class="Combo_container" style="text-align:left;" ></div>
  		  			  		
  		<input type="hidden" name="appmode" value="<%=ApplicationModes.CATEGORY_CHANGE%>">
  		<input type="hidden" name="categoryid" value="">
  		</form>
  		</div>	  	  		
       <div class="sidemanu">         	
		<div  id = "menu_data" class="main_data"></div>		
		
		<%
			String iViewVersion=iViewConfigBean.getValueByKey("iviewversion");
			if(iViewVersion != null && !"".equalsIgnoreCase(iViewVersion)) {
		%>
		<br/>
		<div class="versionText" >
			<center>
				Version <br/>
				<%=iViewVersion%>
			</center>
		</div>
		<%
			}
		%>
		<%
			String menuItem = "";
			String lastAccess = "";
			if(request.getParameter("empty") != null){
				lastAccess = request.getParameter("empty");
				session.setAttribute("lastAccess",lastAccess);
			}else{
				if(session.getAttribute("lastAccess") != null)
					lastAccess = session.getAttribute("lastAccess").toString();
				else
					lastAccess = "";
			}
			
			int userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
			if(session.getAttribute("menudata")==null){
				menuItem = IviewMenuBean.getIviewMenu(userLevel,Integer.parseInt(session.getAttribute("categoryid").toString()));
				session.setAttribute("menudata",menuItem);
			}else
				menuItem = session.getAttribute("menudata").toString();
		%>		
		<script type="text/javascript">

		// category list add 
		function getDeviceListByCategory(value)
		{
			var categoryId = value;		
			document.frmcategory.categoryid.value = categoryId;
			document.frmcategory.submit();
		}
		var categoryList=new Array();
		<%   			
			Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
			CategoryBean categoryBean= null;
			while(categoryBeanItr.hasNext()){	  		
				categoryBean = (CategoryBean)categoryBeanItr.next();
				%>
				categoryList.push('<%=categoryBean.getCategoryName()+"|"+categoryBean.getCategoryId()%>');
				<%
  			}
  		%>
		var categoryID = <%=session.getAttribute("categoryid")%>;
		setComboBox("categoryid","198",1,"getDeviceListByCategory");
		insertAllElements("categoryid",categoryList);
		if(categoryID != "null"){
			selectComboItem("categoryid",getElementIndex("categoryid",categoryID));
		}
			
			var tmenuItems = [<%= menuItem%>];
			createNewMenu(tmenuItems,"<%=lastAccess%>");
			/*var lastA = "<%//=lastAccess%>";
			if(lastA != "")
				defaultDisplay(lastA);
			else
				defaultDisplay(lastA,'2');		*/


				
		</script>		
	   </div>
    </div>	

</html>
