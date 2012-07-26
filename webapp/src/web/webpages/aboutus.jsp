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

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
    <%
	try {
		if(CheckSession.checkSession(request,response)<0){
			return;
		}
	}catch(Exception ex){
		
	}
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>About iView</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
<link href="<%=request.getContextPath()%>/css/container.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/javascript/container.js"></script>
<script src="<%=request.getContextPath()%>/javascript/popupform.js"></script>
<style type="text/css">
	#aTag{
		color:#07467C;
	}
	
	body{	
		font-family: arial,san-serift,tahoma;
		font-size: 13px;
	}
	.footerDiv{
		background-color:#f2f2f2;
		border-style:solid;
		border-width:2px;
		border-color:rgb(201,214,223);
		border-top-style:none;
		width:98.5%;
		width: expression(document.body.clientWidth-224);
		height: 130px;
		float: left;
	}
	.footerDivContent{
		float:left;
		margin-left:20px;
		margin-top:10px;
		padding-left: 10px;
		width : 95%;		
		font-family:arial,tahoma,san-serif;
		font-size: 12px;
	}
	.contentDiv{
		text-aligin:left;		
		float:clear;
		padding-left: 30px;
		padding-top: 90px;
		padding-right: 5px;
		border:2px solid rgb(201,214,223);
		border-top:0px solid;
		width: 94%;
		width: expression(document.body.clientWidth-224);
		font-family:arial,tahoma,san-serif;
		font-size: 12px;
		float:left;
	}
	.contentDivHeader{		
		font-family:arial,tahoma,san-serif;
	 	color: rgb(125,130,134);
	 	font-size: 14px;
		text-aligin:left;
	}
	.headerDivHeadText{
		color:#32494f;
		font-size:18px;		
		border-right: 2px;
		border-right-color: #ccd5da;
		border-right-style: solid;
		padding-right: 10px;
		margin-top: 20px;
	}
	.headerDivSubText{
		font-size:15px;
		border-right: 2px;
		border-right-color: #ccd5da;
		border-right-style: solid;
		padding-right: 10px;
		color: rgb(55,56,58);
	}
	.headerDivContentText{		
		text-aligin:left;
		margin-left:20px;	
		margin-top: 25px;
		width: 55%;
		float:left;
		font-family:	arial,tahoma,san-serif;
		font-size: 12px;
	 	color: rgb(55,56,58);
	 
		
	}
	.headerDivHead{
		float:left;
		margin-left:10px
	}
	.sep {
		background-color:#ccd5da;
		height: 30px;
		width: 2px;
	}
	.pagefont {
	 	font-family:	Arial Rounded MT Bold,Trebuchet MS,arial;
	 	color: rgb(150,174,180);
	 	font-size: 12px;
	 	 
	}
</style>
</head>
<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>        
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>        	
	<div class="maincontent" id="main_content">	
	<br/>	
		<div >
			<div style="background-image: url(../images/lefttop.jpg); background-repeat: no-repeat; float: left; height: 90px; width: 4%;;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:rgb(201,214,223);">&nbsp;</div>
																				 			
			<div style="background-image:url('../images/top_bg.jpg');background-repeat:repeat-x;height:90px;float:left;width:89%;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:rgb(201,214,223);">
				<div class="headerDivHead">			
					<center>
						<div class="headerDivHeadText"><b>About Cyberoam iView</b></div>								 
				 		<div class="headerDivSubText">Intelligent Logging and Reporting</div>
					</center>				  
		    	</div>		    	
		    	
		    	<div class="headerDivContentText">
				 	The Intelligent logging and reporting solution that provides network visibility for security, regulatory compliance and data confidentiality.
			 	</div>				
			</div>
			<div style="background-image:url('../images/righttop.jpg');background-repeat:no-repeat;float:left;margin-right: 0px;width:6%;height:90px;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:rgb(201,214,223);">&nbsp;</div>						
		</div>
		<div class="contentDiv">
			<div>			
				Copyright &copy; 2009 Elitecore Technologies Ltd.
			</div>
			<br/>			
			This program is free software; you can redistribute it and/or modify it under the terms of
			the GNU General Public License as published by the Free Software Foundation, either version 3
			of the License, or (at your option) any later version.  			
			<br/>
			<br/>			
			This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.			
			<br/>
			<br/>			
			You should have received a copy of the GNU General Public License along with this program.
			If not, See <a id="aTag" href="http://www.gnu.org/licenses/" target="_blank">http://www.gnu.org/licenses/</a>.  			
			<br/>
			<br/>
			The interactive user interfaces in modified source and object code versions of this program must display<br/>
			Appropriate Legal Notices, as required under Section 5 of the GNU General Public License version 3.			
			<br/>
			<br/>			
			List of software used:
			<br/>
			<br/>
			<a id="aTag" href="http://gcc.gnu.org/" target="_blank">GNU C</a>
			<br/>
			<a id="aTag" href="http://tomcat.apache.org/" target="_blank">Apache Tomcat 5.5</a>
			<br/>
			<a id="aTag" href="http://java.sun.com/j2se/1.5.0/" target="_blank">JDK 1.5</a>
			<br/>
			<a id="aTag" href="http://www.postgresql.org/" target="_blank">PostgreSQL  8.4</a>
			<br/>
			<a id="aTag" href="http://www.cygwin.com/" target="_blank">Cygwin 1.5.25</a>
			<br/>
			<a id="aTag" href="http://www.jfree.org/jfreechart/" target="_blank">Jfreechart 1.0.13</a>
			<br/>
			<a id="aTag" href="http://logging.apache.org/log4j/1.2/index.html" target="_blank">Log4j 1.1</a>
			<br/>
			<a id="aTag" href="http://www.lowagie.com/iText/" target="_blank">iText 2.1.5</a>
			<br/>
			<a id="aTag" href="http://www.jfree.org/jcommon/" target="_blank">Jcommon-1.016</a>
			<br/>
			<a id="aTag" href="http://www.alphaworks.ibm.com/tech/xml4j" target="_blank">XML4j 2.0.15</a>
			<br/>
			<a id="aTag" href="http://java.sun.com/javase/technologies/desktop/javabeans/jaf/downloads/index.html" target="_blank">Activation 1.1</a>
			<br/>
			<a id="aTag" href="http://java.sun.com/products/javamail/" target="_blank">Java mail API 1.4.2</a>
			<br/>
			<a id="aTag" href="http://jdbc.postgresql.org/" target="_blank">Postgres JDBC 3</a>
			<br/>
			<a id="aTag" href="http://dynarch.com/mishoo/calendar.epl" target="_blank">DHTML Calendar 1.1.12.1</a>
			<br/>
			<a id="aTag" href="http://www.dhtmlx.com/docs/products/dhtmlxGrid/" target="_blank">DhtmlxGrid 2.1</a>
			<br/>
			<br/>
		</div>
			
		<div class="footerDiv">
	
			<div class="footerDivContent">
				In accordance with Section 7(b) of the GNU General Public License version 3, these Appropriate Legal Notices
				must retain the display of the "Cyberoam Elitecore Technologies Initiative" logo.
				<div class="footerImageDiv">
					<img src="../images/Cyberoam_Elitecore_Initiative_Logo.png"></img>
				</div>
				<br/>
				Cyberoam iView<sup>TM</sup> is the trademark of Elitecore Technologies Ltd.
				<br/>
				<a id="aTag" href="http://www.elitecore.com" target="_blank">www.elitecore.com</a> | <a id="aTag" href="http://www.cyberoam.com" target="_blank">www.cyberoam.com</a>				
			</div>
			
												
		</div>
		
	</div>
			
</body>
</html>
