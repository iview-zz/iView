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

<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<input type="hidden" id="refreshed" value="no"> 
<script type="text/javascript">  
		if(navigator.userAgent.indexOf("Chrome") != -1){
			var e=document.getElementById("refreshed"); 
			if(e.value=="no"){
				e.value="yes"; 
			}else{
				e.value="no";
				location.reload();
			}
		} 
</script>
<%
	try{
	StringBuffer jspPathName = null;
	if(request.getRequestURI() != null){
		jspPathName = new StringBuffer(request.getRequestURI());
	}
	String context = request.getContextPath();
	int index = jspPathName.toString().indexOf(context);
	jspPathName.delete(0,index+context.length()+1);
	jspPathName.delete(jspPathName.length()-4,jspPathName.length());

	int lastindex=jspPathName.toString().lastIndexOf("/");
	StringBuffer temp=new StringBuffer(jspPathName.toString());
	temp.delete(0,lastindex+1);
	String topic=temp.toString();
	int sessionTimeOutInterval = session.getMaxInactiveInterval();
	String helpURL="/onlinehelp/wwhelp/wwhimpl/api.htm?context=Online_help&topic="+topic;
	if(jspPathName.toString().equalsIgnoreCase("webpages/singlereport")){
		topic="reportid" +request.getParameter("reportid");
		
		//helpURL="/onlinehelp/reportid="+request.getParameter("reportid")+".html";	
	}else if(jspPathName.toString().equalsIgnoreCase("webpages/reportgroup")){
		//helpURL="/onlinehelp/reportgroupid="+request.getParameter("reportgroupid") +".html";
		topic="reportgroupid" +request.getParameter("reportgroupid");
	}
	helpURL="/onlinehelp/wwhelp/wwhimpl/api.htm?context=Online_help&topic="+topic;
%>
<!-- Including calendar and slide menu -->


<%@page import="org.cyberoam.iview.authentication.beans.UserBean"%>
<%@page import="org.cyberoam.iview.authentication.beans.RoleBean"%>
<script language="JavaScript">

<!--

document.onhelp = onhelppage;


var countDownInterval=<%=sessionTimeOutInterval%>;
var countDownTime=countDownInterval+1;
function countDown(){
	countDownTime--;
	if (countDownTime <=0){
		countDownTime=countDownInterval;
		clearTimeout(counter);
		top.location = "<%=request.getContextPath()%>" + "/webpages/logout.jsp";
		return;
	}
	counter=setTimeout("countDown()", 1000);
}
function startit(){
	countDown()
}
function onhelppage() {
	window.open("<%=helpURL%>",'_person','width=850,height=650,screenX=10,screenY=10,titlebar=yes,scrollbars=yes,resizable=yes');
    return false;
}     
function keyhandler(e) {
	isNetscape=(document.layers);
	if(isNetscape){ // for Netscape
		eventChooser = keyStroke.which;
	}else if(e){ // for Mozilla
		eventChooser = e.keyCode;
	}else{		 // for IE
		eventChooser = event.keyCode;
	}
    which = String.fromCharCode(eventChooser);
    xCode=which.charCodeAt(0);
    // If F2 is pressed 
	if (xCode == 113){
    	location.href="<%=request.getContextPath()%>/webpages/mainpage.jsp";
	}
	// If F10 is pressed 
	if (xCode == 121){
    	location.href="<%=request.getContextPath()%>/webpages/maindashboard.jsp";
	}
	// If F1 is pressed
	if (xCode == 112){
		onhelppage();
	}
}       
//-->
</script>
<link rel="SHORTCUT ICON" type="image/png" href="<%=request.getContextPath()%>/images/iViewLogofave.png"/>
<div class="pageheader" id="pageheader">   
	<div class="header2"></div>
	<div class="welcomenote">Welcome, <b><%=(String)session.getAttribute("username") %></b></div>
	<div class="linkblock">
		<div class="seperator"></div>
		<div class="link">
			<a href="logout.jsp" title="Logout Current Session"><%=TranslationHelper.getTranslatedMessge("Logout")%></a>
		</div>
	</div>
	<div class="linkblock">
		<div class="seperator"></div>
		<div class="link">
			<a href="aboutus.jsp"><%=TranslationHelper.getTranslatedMessge("About Us")%></a>
		</div>
	</div>
	<div class="linkblock">
		<div class="seperator_small_line"></div>
		<div class="link">
			<a href="<%=helpURL %>" target="_blank" ><%=TranslationHelper.getTranslatedMessge("Help")%></a>
		</div>
	</div>
	<div class="linkblock">
		<div class="seperator"></div>
		<div class="link" style="margin-right:-5px;cursor:pointer;"><img src="../images/home.png" onclick="document.location.href='maindashboard.jsp'" width="15px" height="15px"/></div>
		<div class="link">			
			<a href="maindashboard.jsp"><%=TranslationHelper.getTranslatedMessge("Home")%></a>
		</div>
	</div>       	
</div>
<script language=javascript>
	startit();
</script>
<%
	}catch(Exception e){
	CyberoamLogger.appLog.debug("pageheader.jsp.e:"+e,e);	
}
%>

	 
