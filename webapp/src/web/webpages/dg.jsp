<%/*<!-- ***********************************************************************
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
*/%>
<%@page import="org.cyberoam.iview.audit.AuditLogHelper"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.cyberoam.iview.system.beans.MemoryUsageBean"%>
<%@page import="org.cyberoam.iview.system.beans.CPUUsageBean"%>
<%@page import="org.cyberoam.iview.utility.GarnerManager"%>
<%@page import="org.cyberoam.iview.system.beans.DiskUsageBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.cyberoam.iview.utility.CheckSession"%>
<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
<%@page import="org.cyberoam.iview.utility.UdpPacketCapture"%>
<%@page import="org.cyberoam.iview.utility.TroubleShoot"%>
<%@page import="org.cyberoam.iview.system.utility.SystemInformation"%>
<%@page import="org.cyberoam.iview.beans.iViewConfigBean"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>

<%
	if(CheckSession.checkSession(request,response)<0)
		return;
	ArrayList logcontainer=null;
	boolean status=false;	
	boolean packetflag=false;
	boolean isfiltered=false;
try{
	String logLimit = request.getParameter("limit");
	String searchkey = request.getParameter("searchkey");
	int ilogLimit = 10;
	if(logLimit!=null && (!"null".equalsIgnoreCase(logLimit)) && (!"".equalsIgnoreCase(logLimit))){
		ilogLimit = Integer.parseInt(logLimit);
	}
	String reqType=null;
	String log="";
	String fileid="";
	int size=0;
	if(request.getParameter("reqtype")!=null && !request.getParameter("reqtype").equals("")){
		reqType=request.getParameter("reqtype");
		if(reqType!=null && reqType.equalsIgnoreCase("ajax")){
			fileid=request.getParameter("fileid");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Pragma","no-cache");
			response.setHeader("Cache-Control","no-store");
			out.println("<root>");	
			if(fileid.equalsIgnoreCase("viewpacket")){
				CyberoamLogger.sysLog.info("Request for logs");
				logcontainer=UdpPacketCapture.getLogList();
				packetflag=true;
				if(ilogLimit<logcontainer.size()){
					size=ilogLimit;
				}
				else{
					size=logcontainer.size();
				}
				
			}
			else{
				logcontainer=new TroubleShoot().getResponse(ilogLimit,fileid,searchkey.trim());
				size=logcontainer.size();
			}
			if(size<=0)			{
				out.println("<record>");								
				out.println("<log>");
				out.println("No logs Found"); 
				out.println("</log>");
				out.println("</record>");	
				out.println("</root>");
				return;
			}
			for(int i=0;i<size;i++){
				
				if(packetflag){
					if(searchkey!=null && !searchkey.equals("")){
						if((logcontainer.get(i).toString().toLowerCase()).contains(searchkey.trim().toLowerCase())){
							isfiltered=true;
							log="filtered:  "+logcontainer.get(i).toString();
						}
						else{
							log="";
						}
					}
					else
					{
						isfiltered=true;
						log=logcontainer.get(i).toString();
					}
					
				}
				else{
						isfiltered=true;
						log=logcontainer.get(i).toString();
				}
				if(log!=null && !log.equals("")){
					out.println("<record>");								
					out.println("<log>");
					log = log.replace("&","&amp;");
					log = log.replace("<","&lt;");
					log = log.replace(">","&gt;");
					out.println(log); 
					out.println("</log>");
					out.println("</record>");	
				}
			}
			if(isfiltered==false){
				out.println("<record>");								
				out.println("<log>");
				out.println("No logs Found for given search keyword"); 
				out.println("</log>");
				out.println("</record>");	
			}
			out.println("</root>");
		return;
		}
		if(reqType!=null && reqType.equalsIgnoreCase("startgarner")){
			response.setContentType("text/xml");
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Pragma","no-cache");
			response.setHeader("Cache-Control","no-store");
			CyberoamLogger.sysLog.info("Request of start garner");				
			GarnerManager.start();
			out.print("<result>");
		
			out.print(GarnerManager.getGarnerStatus());
			out.println("</result>");
			return;
		}
		if(reqType!=null && reqType.equalsIgnoreCase("stopgarner"))	{
			//stop garner
			//start packet capture
			response.setContentType("text/xml");
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Pragma","no-cache");
			response.setHeader("Cache-Control","no-store");
			CyberoamLogger.sysLog.info("Request from user to stop garner");
			GarnerManager.stop();
			out.print("<result>");
			
			out.print(GarnerManager.getGarnerStatus());
			out.println("</result>");
			return;
		}
		if(reqType!=null && reqType.equalsIgnoreCase("stopudppacketcapture")){
			response.setContentType("text/xml");
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Pragma","no-cache");
			response.setHeader("Cache-Control","no-store");
			UdpPacketCapture.stopCapture();
			out.print("<result>");
			out.print(GarnerManager.getGarnerStatus());
			out.println("</result>");
			return;
		}
		if(reqType!=null && reqType.equalsIgnoreCase("startudppacketcapture")){
			CyberoamLogger.sysLog.info("Request for start packet capture");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Pragma","no-cache");
			response.setHeader("Cache-Control","no-store");
			UdpPacketCapture.startCapture();
			out.print("<result>");
			out.print(GarnerManager.getGarnerStatus());
			out.println("</result>");
			return;
		}
	}
	if(GarnerManager.getGarnerStatus()){
			status=true;
	}else{
		status=false;
	}
	MemoryUsageBean memoryUsageBean=TroubleShoot.getMemoryUsage();
	CPUUsageBean cpuUsageBean=SystemInformation.getCPUUsage();
	DiskUsageBean diskUsageBean=SystemInformation.getDiskUsage();
%>

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
<SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/javascript/popupform.js"></SCRIPT>
<style type="text/css" >@import url(<%=request.getContextPath()%>/css/calendar-blue.css);</style>
<style type="text/css" >@import url(<%=request.getContextPath()%>/css/configuration.css);</style>
<style type="text/css">@import url(<%=request.getContextPath()%>/css/newTheme.css);</style>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/popup.css">
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/popup.js"></script>

<script LANGUAGE="Javascript">
	var timeflag;
	window.onload = function (evt) {
		setWidth();				
	}		
	function setWidth(){
		var main_div = document.getElementById("main_content");	
		main_div.style.width = (document.body.clientWidth - 217);	
	}
	function openViewLog(){
		document.getElementById("fileid").value="garner";
		URL = '<%=request.getContextPath()%>/webpages/viewlog.jsp';
		handleThickBox(1,'troubleshoot',"700");
		setTimeout("refreshlogs()",500);		
	}

	function openViewTomLog(){
		var tomindex=document.getElementById("tomlogs").selectedIndex;
		var logtype=document.getElementById("tomlogs").options[tomindex].value;
		if(logtype=="tomapp"){
			document.getElementById("fileid").value="tomapp";
		}
		else if(logtype=="tomsys"){
			document.getElementById("fileid").value="tomsys";
		}
		else if(logtype=="tomaudit"){
			document.getElementById("fileid").value="tomaudit";
		}
		else if(logtype=="tomrep"){
			document.getElementById("fileid").value="tomrep";
		}
		else if(logtype=="tomcon"){
			document.getElementById("fileid").value="tomcon";
		}
		else if(logtype=="tomsql"){
			document.getElementById("fileid").value="tomsql";
		}
		URL = '<%=request.getContextPath()%>/webpages/viewlog.jsp';
		handleThickBox(1,'troubleshoot',"700");
		setTimeout("refreshlogs()",500);		
	}
	function openShowTable()	{
		document.getElementById("fileid").value="rwtable";
		URL = '<%=request.getContextPath()%>/webpages/viewlog.jsp';
		handleThickBox(1,'troubleshoot',"700");
		setTimeout("refreshlogs()",500);
	}
	function openShowQueries()	{
		document.getElementById("fileid").value="showquery";
		URL = '<%=request.getContextPath()%>/webpages/viewlog.jsp';
		handleThickBox(1,'troubleshoot',"700");
		setTimeout("refreshlogs()",500);
	}

	function openShowPacket()	{		
		document.getElementById("fileid").value="viewpacket";
		var url="<%=request.getContextPath()%>"+"/webpages/dg.jsp";						
		url=url+"?reqtype=startudppacketcapture";								
		SimpleAJAXCall(url, startUpStatus, "post", "1");
		URL = '<%=request.getContextPath()%>/webpages/viewlog.jsp';
		handleThickBox(1,'troubleshoot',"700");
		setTimeout("setLimit()",500);
		setTimeout("refreshlogs()",500);
	}

	function decidePacketLoad()
	{
			if(document.getElementById("statusbutton").value=="Stop Garner"){
				alert("Please Stop the Garner to enable Packet Viewer");
			}
			else{
				openShowPacket();
			}
	}	

	function startUpStatus(){
		
	}
	function setLimit()
	{
		document.getElementById("limit").options[0].value="10";
		document.getElementById("limit").options[0].innerHTML="10";
		document.getElementById("limit").options[1].value="25";
		document.getElementById("limit").options[1].innerHTML="25";
		document.getElementById("limit").options[2].value="50";
		document.getElementById("limit").options[2].innerHTML="50";
		document.getElementById("limit").options[3].value="100";
		document.getElementById("limit").options[3].innerHTML="100";
	}
	function refreshlogs()	{
		var fileid=document.getElementById("fileid").value;
		if(fileid=="garner"){
			document.getElementById("formtitle").innerHTML="Garner Logs";
			}
		else if(fileid=="tomapp"){
			document.getElementById("formtitle").innerHTML="Tomcat Application Logs";
		}
		else if(fileid=="tomsys"){
			document.getElementById("formtitle").innerHTML="Tomcat System Logs";
		}
		else if(fileid=="tomaudit"){
			document.getElementById("formtitle").innerHTML="Tomcat Audit Logs";
		}
		else if(fileid=="tomcon"){
			document.getElementById("formtitle").innerHTML="Tomcat ConnectionPool Logs";
		}
		else if(fileid=="tomrep"){
			document.getElementById("formtitle").innerHTML="Tomcat Report Logs";
		}
		else if(fileid=="tomsql"){
			document.getElementById("formtitle").innerHTML="SQL Query Logs";
		}
		else if(fileid=="rwtable"){
			document.getElementById("formtitle").innerHTML="Current Queued Tables";
		}
		else if(fileid=="showquery"){
			document.getElementById("formtitle").innerHTML="Running Queries";
		}
		else if(fileid=="viewpacket"){
			document.getElementById("formtitle").innerHTML="Live Packet Capture";
		}
		
		
		var timeindex=document.getElementById("refreshtime").selectedIndex;
		var timeout=document.getElementById("refreshtime").options[timeindex].value;
		var limindex=document.getElementById("limit").selectedIndex;
		var lim=document.getElementById("limit").options[limindex].value;
		var searchkey=document.getElementById("searchkey").value;
		var url="<%=request.getContextPath()%>"+"/webpages/dg.jsp";		
		var querystring="?limit="+lim;	
		querystring+="&fileid="+fileid;	
		querystring+="&searchkey="+searchkey;						
		url=url+querystring +"&reqtype=ajax";								
		var time = parseInt(timeout) * 1000;
		SimpleAJAXCall(url, addToList, "post", "1");
		timeflag=setTimeout("refreshlogs()",time);															
	}
	
	function addToList(xmlreq,id)	{
		if(xmlreq!=null){									
			var rootobj=xmlreq.getElementsByTagName("root");					
			if(rootobj!=null){																
				var recordlist=rootobj.item(0).getElementsByTagName("record");											
				
				if(recordlist!=null && recordlist.length>0){																	
					var parentDiv =document.getElementById("archiveContent");		
					if(parentDiv!=null){										
						var childDiv=parentDiv.getElementsByTagName("div");					
						var lengthDiv=childDiv.length;
						var index=document.getElementById("limit").selectedIndex;
						var limit=document.getElementById("limit").options[index].value;
						for(i=0; i<lengthDiv;i++){													
							parentDiv.removeChild(childDiv[0]);			
						}	
						
						for(count=0;count<recordlist.length;count++){
							var logobj= recordlist.item(count).getElementsByTagName("log");																				
							var newdiv =document.createElement("div");						
								newdiv.innerHTML=logobj.item(0).childNodes[0].data;
							if(count%2==0){									
								newdiv.className="trdark";
							}
							else{									
								newdiv.className="trlight";
							}
							parentDiv.appendChild(newdiv);														
															
						}																				
					}	
				}			
			}
		}
	}
				
	function clearlogs(){
		var parentDiv =document.getElementById("archiveContent");											
		var childDiv=parentDiv.getElementsByTagName("div");					
		var lengthDiv=childDiv.length;
		for(i=0; i<lengthDiv;i++){													
			parentDiv.removeChild(childDiv[0]);			
		}
	}
	
	function stoplogs()	{
		if(document.getElementById("stop").value=="Stop")	{
			clearTimeout(timeflag);	
			document.getElementById("stop").value="Start";
			document.getElementById("refresh").disabled=true;	
		}
		else	{
			document.getElementById("stop").value="Stop";
			document.getElementById("refresh").disabled=false;
			refreshlogs();
		}
	}
	
	
	function userRefresh()	{
		if(document.getElementById("stop").value!="Start"){
			clearTimeout(timeflag);
			refreshlogs();	
		}	
	}
	function closeForm()	{
		if(document.getElementById("fileid").value=="viewpacket"){
			closeclildwindow();
		}else{
			clearTimeout(timeflag);
			handleThickBox('2','troubleshoot');
		}
	}
	function closeclildwindow()	{
		clearTimeout(timeflag);
		var url="<%=request.getContextPath()%>"+"/webpages/dg.jsp";	
		url=url +"?reqtype=stopudppacketcapture";
		SimpleAJAXCall(url, finished, "post", "1");
		alert("Please Start the Garner otherwise no logs will be parsed");
		handleThickBox('2','troubleshoot');
	}

	function changeStatus(){
		var url="<%=request.getContextPath()%>"+"/webpages/dg.jsp";	
	
		if(document.getElementById("statusbutton").value=="Stop Garner"){
			document.getElementById("statusbutton").value="Stopping....";
			document.getElementById("statusbutton").disabled=true;
			url=url+"?reqtype=stopgarner";
		}else{
			document.getElementById("statusbutton").value="Starting...";
			document.getElementById("statusbutton").disabled=true;
			url=url+"?reqtype=startgarner";
		}
		SimpleAJAXCall(url, finished, "post", "1");
	}
	function finished(xmlreq,id){
		if(xmlreq!=null){
			var rootobj=xmlreq.getElementsByTagName("result");
			if(rootobj!=null){
				if(rootobj.item(0).childNodes[0].data=="false"){
					document.getElementById("garnerrunningstatus").innerHTML = "<font style='color:red'>Garner is Not Running</font>";
					document.getElementById("statusbutton").value="Start Garner";
					document.getElementById("statusbutton").disabled=false;
				}else{
					document.getElementById("garnerrunningstatus").innerHTML = "<font style='color:green'>Garner is Running</font>";
					document.getElementById("statusbutton").value="Stop Garner";
					document.getElementById("statusbutton").disabled=false;
				}
			}
		}	
	}
	
</script>
</head>
<body>
	<jsp:include page="menu.jsp" flush="true"></jsp:include>
    <jsp:include page="pageheader.jsp" flush="true"></jsp:include>      
	<div class="maincontent" id="main_content">
	
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td align="left">
					<table width="100%">
						<tr>	
							<td colspan="1">
								<div class="reporttitlebar">
				<div class="reporttitlebarleft"></div>
				<div class="reporttitle">System Information
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="<%=request.getContextPath()%>/troubleshoot/ts<%=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())%>.txt?choice=3"><img class="xlslink" src="../images/SaveIcon.png" title="Download Troubleshoot.txt"></a>
				</div>
						
	</div>	
							</td>
							
							
						</tr>
						
						<tr>
							<td colspan="1">
								<table class="TableData" width="100%" cellspacing="0" cellpadding="0">
									<tr height="25px">
										<td class="tdhead" style="padding-left:10px">&nbsp;</td>
										<td class="tdhead" style="padding-left:10px"><b>Used</b></td>
										<td style="padding-left:10px" class="tdhead"><b>Free</b></td>
										
									</tr>									
					 				<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
										<td class="tddata" align="left"><b>Memory</b></td>
										<td class="tddata" align="left"><%=new DecimalFormat(".##").format(memoryUsageBean.getMemoryInUse()/(1024*1024)) + " MB" %></td>
										<td class="tddata" align="left"><%=new DecimalFormat(".##").format(memoryUsageBean.getFreeMemory()/(1024*1024)) +" MB" %></td>
									</tr>
									<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
									
										<td class="tddata" align="left"><b>CPU</b></td>
										<td class="tddata" align="left"><%=100-cpuUsageBean.getIdlePercent()+"%" %></td>
										<td class="tddata" align="left"><%=cpuUsageBean.getIdlePercent()+"%" %></td>
									</tr>
									<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
									
										<td class="tddata" align="left"><b>Archive in Disk</b></td>
										<td class="tddata" align="left"><%=new DecimalFormat(".##").format((double)diskUsageBean.getUsedInArchive()/(1024*1024))+" GB" %></td>
										<td class="tddata" align="left"><%=new DecimalFormat(".##").format((double)diskUsageBean.getFreeInArchive()/(1024*1024))+" GB" %></td>
									</tr>
									<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
									
										<td class="tddata" align="left"><b>Database in Disk</b></td>
										<td class="tddata" align="left"><%=new DecimalFormat(".##").format((double)diskUsageBean.getUsedInData()/(1024*1024))+" GB" %></td>
										<td class="tddata" align="left"><%=new DecimalFormat(".##").format((double)diskUsageBean.getFreeInData()/(1024*1024))+" GB" %></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
		
	<div class="maincontent">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td align="left">
					<table width="100%">
						<tr>	
							<td colspan="2">
								<div class="content_head" width="100%">
									<div width="100%" class="reporttitle">
										Syslog(Garner) Information
									</div>
								</div>
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								<table class="TableData" width="100%" cellspacing="0" cellpadding="0">
									<tr height="25px">
										<td class="tdhead" style="padding-left:10px"><b>Status</b></td>
									</tr>
					 				<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
										<td class="tddata" align="left" id="garnerrunningstatus">
									<%
										if(GarnerManager.getGarnerStatus()){
											out.println("<font style='color:green'>Garner is Running</font>");
										}else {
											out.println("<font style='color:red'>Garner is Not Running</font>");
										}
										%>
										
										</td>
									</tr>
									
									<div id="3">
										<input align="right" type="button" style="height: 20px;" class="criButton" value="<%=(status)?"Stop Garner":"Start Garner"%>" onclick="changeStatus()" id="statusbutton">
										<input align="right" type="button" style="height: 20px;" class="criButton" value="View Logs" onclick="openViewLog()" name="viewlogs">
										<input align="right" type="button" style="height: 20px;" class="criButton" value="Packet Capture" onclick="decidePacketLoad()" id="viewpacketbutton"></div>	
									</div>	
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="maincontent">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td align="left">
					<table width="100%">
						<tr>	
							<td colspan="2">
								<div class="content_head" width="100%">
									<div width="100%" class="reporttitle">
										Tomcat Logs
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<table class="TableData" width="100%" cellspacing="0" cellpadding="0">
									<tr height="25px">
										<td class="tdhead" style="padding-left:10px">
											<select name="tomlogs" id="tomlogs">
													<option value="tomaudit">Audit Logs</option>
													<option value="tomapp">Application Logs</option>
													<option value="tomsys">System Logs</option>
													<option value="tomrep">Report Logs</option>
													<option value="tomcon">ConnectionPool  Logs</option>
													<option value="tomsql">SqlQuery  Logs</option>
											</select>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input align="right" type="button" style="height: 20px;" class="criButton" value="View" onclick="openViewTomLog()" name="tomlogs">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	
	
	
	<div class="maincontent">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td align="left">
					<table width="100%">
						<tr>	
							<td colspan="2">
								<div class="content_head" width="100%">
									<div width="100%" class="reporttitle">
										Database Server
									</div>
								</div>
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								<table class="TableData" width="100%" cellspacing="0" cellpadding="0">
									<tr height="25px">
										<td class="tdhead" style="padding-left:10px"><b>Total No. of connections</b></td>
									</tr>
					 				<tr class="trlight" onMouseOver='this.className="trlight1";' onMouseOut='this.className="trlight";' >
										<td class="tddata" align="left"><%=new TroubleShoot().getTotalCon() %></td>
									</tr>
									<div id="3">
										<input align="right" type="button" style="height: 20px;" class="criButton" value="Running Queries" onclick="openShowQueries()" name="run qury">
										<input align="right" type="button" style="height: 20px;" class="criButton" value="Show Queue tables" onclick="openShowTable()" name="rw tables">
										
									</div>	
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
		<input type='hidden' name='fileid' id='fileid' value=""></input>
<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>
<div id="TB_overlay" class="TB_overlayBG" style="display: none;"></div>
<div class="TB_window" id="troubleshoot"></div>
</body>
<%
	}catch(Exception e){
	CyberoamLogger.appLog.debug("dg.jsp"+e,e);
}
	%>
</html>
