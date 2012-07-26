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
********************************************************************** -->	
	
	<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	    pageEncoding="ISO-8859-1"%>
	<%@page import="java.util.*"%>
	<%@page import="java.io.*" %>
	<%@page import="org.cyberoam.iview.utility.*" %>
	<%@page import="org.cyberoam.iview.utility.FileFilter" %>
	<%@page import="org.cyberoam.iview.audit.CyberoamLogger"%>
	<%!
		public String getFileName(File hotDir){
			String []fileList=null;
			String fileName=null;	
			if(hotDir!=null && hotDir.exists()){
				fileList=hotDir.list(new FileFilter(IViewPropertyReader.RowLogFileFilterRegExp));
				if(fileList!=null && fileList.length>1){
					long time=0,fileTime=0;
					for(int i=0;i<fileList.length;i++){
						if(fileList[i].endsWith(".log")){																				
							fileTime=Long.parseLong(fileList[i].substring(fileList[i].indexOf("_")+1,fileList[i].indexOf("_",fileList[i].indexOf("_")+1)));
							if(fileTime>time){
								fileName=fileList[i];
							}										
						}									
					}
				}else{
					if(fileList[0].endsWith(".log"))
						fileName=fileList[0];	
				}
			}			
			return fileName;
		}
	%>
		<%
			try{
				String device=null,temp;
				String selectedfilename=null;
				String reqType=null;
				String fileSep=System.getProperty("file.separator");
				long offset=-1,limit=50;
				CyberoamLogger.sysLog.info("Request Received");
				
				if(CheckSession.checkSession(request,response)<0){
					return;
				}

				if(request.getParameter("device")!=null && !request.getParameter("device").equals("")){
					device=request.getParameter("device");
				}			

				if(request.getParameter("name")!=null && !request.getParameter("name").equals("")){
					selectedfilename=request.getParameter("name");			
				}

				if(request.getParameter("offset")!=null && !request.getParameter("offset").equals("")){
					offset=Long.parseLong(request.getParameter("offset"));			
				}					

				if(request.getParameter("limit")!=null){					
					limit=Integer.parseInt(request.getParameter("limit"));
				}
				CyberoamLogger.sysLog.info("Device: " + device);
				CyberoamLogger.sysLog.info("Offset: " + offset);
				CyberoamLogger.sysLog.info("Filename: " +selectedfilename);
				if(request.getParameter("reqtype")!=null && !request.getParameter("reqtype").equals("")){
					reqType=request.getParameter("reqtype");
					if(reqType!=null && reqType.equalsIgnoreCase("ajax")){
						response.setContentType("text/xml");
						CyberoamLogger.sysLog.info("Ajax Request Received");
						out.println("<root>");						
						File inFile=new File(IViewPropertyReader.ArchieveDIR+ device + fileSep + "hot" + fileSep + selectedfilename);
						RandomAccessFile liveArchiveFile=null;
						CyberoamLogger.sysLog.info("Old Using FileName: " + selectedfilename);												
						if(inFile!=null && inFile.exists()){													
							String  content;
							liveArchiveFile=new RandomAccessFile(inFile,"r");
							long pos=offset;							
							int data=0;
							while(true){
								liveArchiveFile.seek(pos);								
								data=liveArchiveFile.read();						
								if(data==10 || data==13){									
									break;	
								}else if(data==-1){
									out.println("</root>");										
									liveArchiveFile.close();									
									return;
								}
								else{
									
									pos--;
								}
							}	
						}else{											
							selectedfilename=getFileName(new File(IViewPropertyReader.ArchieveDIR + device + fileSep + "hot" + fileSep));
							CyberoamLogger.sysLog.info("Finding New File: " + selectedfilename);
							if(selectedfilename!=null){
								liveArchiveFile=new RandomAccessFile(new File(IViewPropertyReader.ArchieveDIR + device + fileSep + "hot" + fileSep +selectedfilename),"r");							
							}else{
								out.println("</root>");
								return;
							}
						}
						
						String line=null;
						int count=0;
						if(liveArchiveFile!=null){
							CyberoamLogger.sysLog.info("Current Using FileName: " + selectedfilename);
							while((line=liveArchiveFile.readLine())!=null && count<limit){																							
								out.println("<record>");								
								out.println("<log>");
								line = line.replace("&","&amp;");
								line = line.replace("<","&lt;");
								line = line.replace(">","&gt;");
								out.println(line); 
								out.println("</log>");
								out.println("<offset>");
								offset=liveArchiveFile.getFilePointer();
								out.println(offset);
								out.println("</offset>");
								out.println("</record>");
								count++;
							}	
						}
						out.println("<filename>");
						out.println(selectedfilename);						
						out.println("</filename>");
						liveArchiveFile.close();						
						out.println("</root>");		
						CyberoamLogger.sysLog.info("</root>");
					}						
					return;
				}
		%>		

<%@page import="org.cyberoam.iview.authentication.beans.DeviceBean"%><html>
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>View Archive</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reports.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/container.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/tabs.css">
		<script src="<%=request.getContextPath()%>/javascript/combo.js"></script>
		<script src="<%=request.getContextPath()%>/javascript/utilities.js"></script>
		<SCRIPT SRC="<%=request.getContextPath()%>/javascript/ajax.js"></SCRIPT>
		<script type="text/javascript">						
			function startup(evt) {
				setWidth();
				refreshLog();
				setcmbDevice();
			}
			function setWidth(){				
				var main_div = document.getElementById("main_content");
				main_div.style.width = (document.body.clientWidth - 218);
			}
			function onSelectDevice(){				
				if(document.getElementById("cmbDevice").selectedIndex==0){
					alert("Please select Device");
					return false;								
				}else{
					var obj=document.getElementById("cmbDevice");
					document.getElementById("device").value=obj.options[obj.selectedIndex].value;
				}
				var cmbTime=document.getElementById("cmbTime");
				var timeOut=document.getElementById("timeOut");
				timeOut.value=cmbTime.options[cmbTime.selectedIndex].value;
				document.getElementById("processFlag").value="true";				
				document.getElementById("UpdateButton").value="Stop Update";
				document.getElementById("name").value="";
				document.getElementById("offset").value="";											
				setTimeout("refreshLog()",timeOut.value*1000);			
			}
	
			function refreshLog(){				
				if(document.getElementById("processFlag").value=="true"){	
					var timeOut=document.getElementById("timeOut");
					var url="<%=request.getContextPath()%>"+"/webpages/viewarchive.jsp";			
					var querystring="?device="+document.getElementById("device").value;
					querystring=querystring+"&offset="+document.getElementById("offset").value;
					querystring=querystring+"&name="+document.getElementById("name").value;
					var index=document.getElementById("limit").selectedIndex;			
					querystring=querystring+"&limit="+document.getElementById("limit").options[index].value;								
					url=url+querystring +"&reqtype=ajax";									
					SimpleAJAXCall(url, addToList, "post", "1");					
					setTimeout("refreshLog()",timeOut.value*1000);								
				}																
			}
	
			function addToList(xmlreq,id){					
				document.getElementById("UpdateButton").disabled=false;	
				if(xmlreq!=null){									
					var rootobj=xmlreq.getElementsByTagName("root");					
					if(rootobj!=null){																
						var recordlist=rootobj.item(0).getElementsByTagName("record");											
						var fileName=rootobj.item(0).getElementsByTagName("filename");						
						if(fileName.item(0)!=null){														
							document.getElementById("name").value=fileName.item(0).childNodes[0].data;
						}
						if(recordlist!=null && recordlist.length>0){																	
							var parentDiv =document.getElementById("archiveContent");													
							var childDiv=parentDiv.getElementsByTagName("div");					
							var lengthDiv=childDiv.length;
							var index=document.getElementById("limit").selectedIndex;
							var limit=document.getElementById("limit").options[index].value;																						
							if(lengthDiv+recordlist.length>limit){															
								for(i=0; i<lengthDiv && (i < lengthDiv+recordlist.length-limit); i++){													
									parentDiv.removeChild(childDiv[0]);																			
								}
							}																																																	
							
							for(count=0;count<recordlist.length;count++){
								var logobj= recordlist.item(count).getElementsByTagName("log");
								var offsetValue=recordlist.item(count).getElementsByTagName("offset").item(0).childNodes[0].data;																			
								var newdiv =document.createElement("div");						
									newdiv.innerHTML=logobj.item(0).childNodes[0].data;
								if(count%2==0){									
									newdiv.className="trdark";
								}else{									
									newdiv.className="trlight";
								}
								parentDiv.appendChild(newdiv);															
								document.getElementById("offset").value=offsetValue;									
							}																				
						}				
					}
				}
			}
			
			function setProcessFlag(btnObj){							
				if(btnObj.value=="Stop Update"){
					btnObj.value="Start Update";
					document.getElementById("processFlag").value="false";					
				}else if(btnObj.value=="Start Update" && document.getElementById("device").value!=""){
					btnObj.value="Stop Update";					
					document.getElementById("processFlag").value="true";
					setTimeout("refreshLog()",100);
				}else if(btnObj.value=="Start Update" && document.getElementById("device").value==""){
					alert("Please Select One Device...");
				}
			}

			function setcmbDevice(){
				var deviceValue=document.getElementById("device").value;
				var obj=document.getElementById("cmbDevice");				
				if(deviceValue!=null && deviceValue!=""){																	
					for(i=0;i<obj.options.length;i++){
						if(obj.options[i].value==deviceValue){
							obj.selectedIndex=i;
							obj.selectedValue=deviceValue;					
							break;
						}					
					}															
				}else{
					obj.selectedIndex=0;
					document.getElementById("device").value=obj.options[obj.selectedIndex].value;					
				}
				document.getElementById("UpdateButton").disabled=true;
				var cmbTime=document.getElementById("cmbTime");
				var timeOut=document.getElementById("timeOut");				
				if(timeOut!=null && timeOut.value!=""){
					for(i=0;i<cmbTime.options.length;i++){
						if(timeOut.value==cmbTime.options[i].value){
							cmbTime.selectedIndex=i;
							cmbTime.selectedValue=timeOut.value														
							break;
						}	
					}
				}
			}

			function refreshNow(){								
				if(document.getElementById("device").value!="" || document.getElementById("device").value!="-1"){
					document.getElementById("processFlag").value="true";				
					refreshLog();
					document.getElementById("processFlag").value="false";
				}				
			}
			
		</script>
		<style type="text/css">
			.tdText{
				font-family:Arial,Verdana,Helvetica,sans-serif;
				color:#313131;
				font-size:11px;
				font-weight:bold;			
			}
			.headDiv{			
				-moz-background-clip:border;
				-moz-background-inline-policy:continuous;
				background:transparent url(../images/navi_back.jpg) repeat scroll 0 0;
				border:thin solid #E2E2E2;			
				padding:2px;
				font-family:Arial,Verdana,Helvetica,sans-serif;
				color:#313131;
				font-size:11px;
				font-weight:bold;				
			}			
			.UpdateButton{
					BORDER-RIGHT: #999999 1px solid;
					BORDER-TOP: #999999 1px solid; 
					MARGIN-TOP: 2px;
					FONT-WEIGHT: bold;
					FONT-SIZE: 11px; 
					BACKGROUND: url(../images/btnbkgd.jpg); 
					MARGIN-BOTTOM: 2px; 
					BORDER-LEFT: #999999 1px solid; 
					WIDTH: auto;
					COLOR: rgb(58,78,87); 
					BORDER-BOTTOM: #999999 1px solid;
					FONT-FAMILY: arial; 
					HEIGHT: 24px
			}
			.atag{
				color:rgb(35,136,199);
			}
			.selectBox{
				color:#2A576A;
				font-size:11px;
				font-weight:bold;
				height:20px;
			}
		</style>
		</head>
		<body>			
			<jsp:include page="menu.jsp" flush="true"></jsp:include>        
    		<jsp:include page="pageheader.jsp" flush="true"></jsp:include>
			<div class="maincontent" id="main_content">						
			<div class="reporttitlebar">
				<div class="reporttitlebarleft"></div>
				<div class="reporttitle">Live Logs</div>			
			</div>	
			<br/><br/>
			<form name="contentForm" action="<%=request.getContextPath()%>/webpages/viewarchive.jsp" method="get">							
				<div class="headDiv">
				<b>Device Name:</b>
				&nbsp;&nbsp;
				<select id="cmbDevice" class="selectBox">
					<option value="-1">Select Device</option>																
				<%
					Iterator deviceIterator =DeviceBean.getAllDeviceBeanIterator();
					DeviceBean deviceBean=null;
					if(deviceIterator!=null){
						while(deviceIterator.hasNext()){							
							deviceBean=(DeviceBean)deviceIterator.next();
							if(deviceBean!=null)
								out.println("<option value="+deviceBean.getApplianceID()+">"+deviceBean.getName()+"</option>");						
						}
					}																		
				%>																					
				</select>
				&nbsp;&nbsp;&nbsp;
				<b>Refresh Time:</b>
				&nbsp;&nbsp;
				<select id="cmbTime" class="selectBox">
				    <option value="3">3 Sec.</option>
				    <option value="5">5 Sec.</option>
					<option value="10">10 Sec.</option>
					<option selected value="20">20 Sec.</option>
					<option value="30">30 Sec.</option>
					<option value="60">1 Min.</option>
					<option value="120">2 Min.</option>
					<option value="300">5 Min.</option>
				</select>
				&nbsp;&nbsp;
				<input id="submitButton" class="UpdateButton" type="submit" value="GO" onclick="return onSelectDevice()"></input>
			</div>					
			<div class="headDiv">
				<table>
					<tr>
						<td class="tdText">
							Show Last &nbsp;
						</td>
						<td>
							<select id="limit" name="limit" class="selectBox">
								<option value="25">25</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							&nbsp;
						</td>
						<td class="tdText">							
							Records.
							&nbsp;&nbsp;
						</td>
						<td>
							<input id="UpdateButton" class="UpdateButton" type="button"   value="<%=device==null?"Start Update":"Stop Update"%>" onclick="setProcessFlag(this)"></input>
							&nbsp;
						</td>
						<td>
							&nbsp;
							<input id="RefreshButton" class="UpdateButton" type="button"   value="Refresh" onclick="refreshNow()"></input>
						</td>
					</tr>
				</table>									
			</div>			
			<%				
				File archiveDir=null;
				int count=0;		
				archiveDir=new File(IViewPropertyReader.ArchieveDIR);
				if(archiveDir!=null){
					if(device!=null && !device.equals("")){														
						String fileName=null;
						File hotDir=new File(IViewPropertyReader.ArchieveDIR+ device + fileSep + "hot");										
						if(hotDir!=null && hotDir.exists()){							
							fileName=getFileName(hotDir);
							File inFile=null;																									
							if(fileName !=null && fileName.indexOf(".log")!=-1){							
								inFile=new File(IViewPropertyReader.ArchieveDIR+ device + fileSep + "hot" + fileSep + fileName);				
								selectedfilename=fileName;
								if(inFile!=null && inFile.exists()){
									String  content;
									int decreament=3;
									RandomAccessFile liveArchiveFile=new RandomAccessFile(inFile,"r");
									long pos=liveArchiveFile.length();
									offset=pos;
									String line=null;
									int data=0;												
									ArrayList logList=new ArrayList();
									for(int j=0;j<limit;j++){					
										while(true){								
											liveArchiveFile.seek(pos);
											data=liveArchiveFile.read();				
											if(data==10 || data==13){
												pos=pos-decreament;
												break;
											}else{
												pos--;
											}			
											if(pos<0)
												break;											
											liveArchiveFile.seek(pos);
										}
										if(pos<0){
											liveArchiveFile.seek(0);
											line=liveArchiveFile.readLine();									
											if(line!=null && !line.equalsIgnoreCase("")){
												logList.add(line);												
											}	
											break;
										}																				
										line=liveArchiveFile.readLine();									
										if(line!=null && !line.equalsIgnoreCase("") && j!=0){
											logList.add(line);												
										}else{ 											
											limit++;
										}										
									}														
									liveArchiveFile.close();
									
									out.println("<div id='archiveContent' style='height:75%;width:100%;overflow:scroll;overflow-X:hidden'>");
									count=1;
									for(int j=logList.size()-1;j>-1;j--,count++){																					
										if(j%2==0){			
											out.println("<div id=" + count  + " class='trlight'>");
										}else{												
											out.println("<div id=" + count  + " class='trdark'>");
										}																												
										out.println(logList.get(j));
										out.println("</div>");
									}									
									out.println("</div>");									
								}
							}
						}					
					}					
					CyberoamLogger.sysLog.info("Device: " + device);
					CyberoamLogger.sysLog.info("Offset: " + offset);
					CyberoamLogger.sysLog.info("Filename: " +selectedfilename);
				}
				if(device==null){
					out.println("<input type='hidden' name='device' id='device' value=''></input>");
					out.println("<input type='hidden' name='processFlag' id='processFlag' value='false'></input>");
				}else{
					out.println("<input type='hidden' name='device' id='device' value='"+device+"'></input>");
					out.println("<input type='hidden' name='processFlag' id='processFlag' value='true'></input>");
				}				
				if(offset==-1){
			%>
				<input type="hidden" name="offset" id="offset" value="-1"></input>
				<input type="hidden" name="name" id="name" value=""></input>						
		<%
				}else{
					out.println("<input type='hidden' name='offset' id='offset' value='" + offset+"'></input>");
					out.println("<input type='hidden' name='name' id='name' value='"+selectedfilename+"'></input>");
				}
				if(request.getParameter("timeOut")!=null){
					String timeOut=request.getParameter("timeOut");
					out.println("<input type='hidden' name='timeOut' id='timeOut' value='"+timeOut+"'></input>");
				}else{
					out.println("<input type='hidden' name='timeOut' id='timeOut' value='20'></input>");
				}
			}catch(Exception ex){
				CyberoamLogger.sysLog.error("Exception in viewarchive.jsp -- >" + ex.getMessage());				
			}		
		%>		
		</form>			
		</div>
		<jsp:include page="pagefooter.jsp" flush="true"></jsp:include>		
		<script lang="javascript">
			startup(); 
		</script>					
	</body>
</html>