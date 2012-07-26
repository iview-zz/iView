package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.io.*;
import org.cyberoam.iview.utility.*;
import org.cyberoam.iview.utility.FileFilter;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;

public final class viewarchive_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


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
	
  private static java.util.List _jspx_dependants;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- ***********************************************************************\n*  Cyberoam iView - The Intelligent logging and reporting solution that \n*  provides network visibility for security, regulatory compliance and \n*  data confidentiality \n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\n*  \n*  This program is free software: you can redistribute it and/or modify \n*  it under the terms of the GNU General Public License as published by \n*  the Free Software Foundation, either version 3 of the License, or\n*  (at your option) any later version.\n*  \n*  This program is distributed in the hope that it will be useful, but \n*  WITHOUT ANY WARRANTY; without even the implied warranty of \n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \n*  General Public License for more details.\n*  \n*  You should have received a copy of the GNU General Public License \n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\n*  \n*  The interactive user interfaces in modified source and object code \n");
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n********************************************************************** -->\t\n\t\n\t\n\t\n\t\n\t\n\t\n\t\n\t");
      out.write('\n');
      out.write('	');
      out.write('	');

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
		
      out.write("\t\t\n\n<html>\n\t\t<head>\n\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\n\t\t<title>View Archive</title>\n\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\">\n\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\">\n\t\t<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/combo.js\"></script>\n\t\t<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></script>\n\t\t<SCRIPT SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ajax.js\"></SCRIPT>\n\t\t<script type=\"text/javascript\">\t\t\t\t\t\t\n\t\t\tfunction startup(evt) {\n\t\t\t\tsetWidth();\n\t\t\t\trefreshLog();\n\t\t\t\tsetcmbDevice();\n\t\t\t}\n\t\t\tfunction setWidth(){\t\t\t\t\n\t\t\t\tvar main_div = document.getElementById(\"main_content\");\n\t\t\t\tmain_div.style.width = (document.body.clientWidth - 218);\n\t\t\t}\n\t\t\tfunction onSelectDevice(){\t\t\t\t\n\t\t\t\tif(document.getElementById(\"cmbDevice\").selectedIndex==0){\n\t\t\t\t\talert(\"Please select Device\");\n\t\t\t\t\treturn false;\t\t\t\t\t\t\t\t\n\t\t\t\t}else{\n\t\t\t\t\tvar obj=document.getElementById(\"cmbDevice\");\n\t\t\t\t\tdocument.getElementById(\"device\").value=obj.options[obj.selectedIndex].value;\n\t\t\t\t}\n\t\t\t\tvar cmbTime=document.getElementById(\"cmbTime\");\n\t\t\t\tvar timeOut=document.getElementById(\"timeOut\");\n\t\t\t\ttimeOut.value=cmbTime.options[cmbTime.selectedIndex].value;\n\t\t\t\tdocument.getElementById(\"processFlag\").value=\"true\";\t\t\t\t\n\t\t\t\tdocument.getElementById(\"UpdateButton\").value=\"Stop Update\";\n\t\t\t\tdocument.getElementById(\"name\").value=\"\";\n\t\t\t\tdocument.getElementById(\"offset\").value=\"\";\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\tsetTimeout(\"refreshLog()\",timeOut.value*1000);\t\t\t\n");
      out.write("\t\t\t}\n\t\n\t\t\tfunction refreshLog(){\t\t\t\t\n\t\t\t\tif(document.getElementById(\"processFlag\").value==\"true\"){\t\n\t\t\t\t\tvar timeOut=document.getElementById(\"timeOut\");\n\t\t\t\t\tvar url=\"");
      out.print(request.getContextPath());
      out.write("\"+\"/webpages/viewarchive.jsp\";\t\t\t\n\t\t\t\t\tvar querystring=\"?device=\"+document.getElementById(\"device\").value;\n\t\t\t\t\tquerystring=querystring+\"&offset=\"+document.getElementById(\"offset\").value;\n\t\t\t\t\tquerystring=querystring+\"&name=\"+document.getElementById(\"name\").value;\n\t\t\t\t\tvar index=document.getElementById(\"limit\").selectedIndex;\t\t\t\n\t\t\t\t\tquerystring=querystring+\"&limit=\"+document.getElementById(\"limit\").options[index].value;\t\t\t\t\t\t\t\t\n\t\t\t\t\turl=url+querystring +\"&reqtype=ajax\";\t\t\t\t\t\t\t\t\t\n\t\t\t\t\tSimpleAJAXCall(url, addToList, \"post\", \"1\");\t\t\t\t\t\n\t\t\t\t\tsetTimeout(\"refreshLog()\",timeOut.value*1000);\t\t\t\t\t\t\t\t\n\t\t\t\t}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t}\n\t\n\t\t\tfunction addToList(xmlreq,id){\t\t\t\t\t\n\t\t\t\tdocument.getElementById(\"UpdateButton\").disabled=false;\t\n\t\t\t\tif(xmlreq!=null){\t\t\t\t\t\t\t\t\t\n\t\t\t\t\tvar rootobj=xmlreq.getElementsByTagName(\"root\");\t\t\t\t\t\n\t\t\t\t\tif(rootobj!=null){\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\tvar recordlist=rootobj.item(0).getElementsByTagName(\"record\");\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\tvar fileName=rootobj.item(0).getElementsByTagName(\"filename\");\t\t\t\t\t\t\n\t\t\t\t\t\tif(fileName.item(0)!=null){\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\tdocument.getElementById(\"name\").value=fileName.item(0).childNodes[0].data;\n\t\t\t\t\t\t}\n\t\t\t\t\t\tif(recordlist!=null && recordlist.length>0){\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tvar parentDiv =document.getElementById(\"archiveContent\");\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tvar childDiv=parentDiv.getElementsByTagName(\"div\");\t\t\t\t\t\n\t\t\t\t\t\t\tvar lengthDiv=childDiv.length;\n\t\t\t\t\t\t\tvar index=document.getElementById(\"limit\").selectedIndex;\n\t\t\t\t\t\t\tvar limit=document.getElementById(\"limit\").options[index].value;\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tif(lengthDiv+recordlist.length>limit){\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\tfor(i=0; i<lengthDiv && (i < lengthDiv+recordlist.length-limit); i++){\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\tparentDiv.removeChild(childDiv[0]);\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tfor(count=0;count<recordlist.length;count++){\n\t\t\t\t\t\t\t\tvar logobj= recordlist.item(count).getElementsByTagName(\"log\");\n\t\t\t\t\t\t\t\tvar offsetValue=recordlist.item(count).getElementsByTagName(\"offset\").item(0).childNodes[0].data;\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t\tvar newdiv =document.createElement(\"div\");\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\tnewdiv.innerHTML=logobj.item(0).childNodes[0].data;\n\t\t\t\t\t\t\t\tif(count%2==0){\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\tnewdiv.className=\"trdark\";\n\t\t\t\t\t\t\t\t}else{\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\tnewdiv.className=\"trlight\";\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\tparentDiv.appendChild(newdiv);\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\tdocument.getElementById(\"offset\").value=offsetValue;\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t}\t\t\t\t\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t}\n\t\t\t\n\t\t\tfunction setProcessFlag(btnObj){\t\t\t\t\t\t\t\n\t\t\t\tif(btnObj.value==\"Stop Update\"){\n\t\t\t\t\tbtnObj.value=\"Start Update\";\n\t\t\t\t\tdocument.getElementById(\"processFlag\").value=\"false\";\t\t\t\t\t\n\t\t\t\t}else if(btnObj.value==\"Start Update\" && document.getElementById(\"device\").value!=\"\"){\n\t\t\t\t\tbtnObj.value=\"Stop Update\";\t\t\t\t\t\n\t\t\t\t\tdocument.getElementById(\"processFlag\").value=\"true\";\n\t\t\t\t\tsetTimeout(\"refreshLog()\",100);\n\t\t\t\t}else if(btnObj.value==\"Start Update\" && document.getElementById(\"device\").value==\"\"){\n\t\t\t\t\talert(\"Please Select One Device...\");\n\t\t\t\t}\n\t\t\t}\n\n\t\t\tfunction setcmbDevice(){\n\t\t\t\tvar deviceValue=document.getElementById(\"device\").value;\n");
      out.write("\t\t\t\tvar obj=document.getElementById(\"cmbDevice\");\t\t\t\t\n\t\t\t\tif(deviceValue!=null && deviceValue!=\"\"){\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\tfor(i=0;i<obj.options.length;i++){\n\t\t\t\t\t\tif(obj.options[i].value==deviceValue){\n\t\t\t\t\t\t\tobj.selectedIndex=i;\n\t\t\t\t\t\t\tobj.selectedValue=deviceValue;\t\t\t\t\t\n\t\t\t\t\t\t\tbreak;\n\t\t\t\t\t\t}\t\t\t\t\t\n\t\t\t\t\t}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t}else{\n\t\t\t\t\tobj.selectedIndex=0;\n\t\t\t\t\tdocument.getElementById(\"device\").value=obj.options[obj.selectedIndex].value;\t\t\t\t\t\n\t\t\t\t}\n\t\t\t\tdocument.getElementById(\"UpdateButton\").disabled=true;\n\t\t\t\tvar cmbTime=document.getElementById(\"cmbTime\");\n\t\t\t\tvar timeOut=document.getElementById(\"timeOut\");\t\t\t\t\n\t\t\t\tif(timeOut!=null && timeOut.value!=\"\"){\n\t\t\t\t\tfor(i=0;i<cmbTime.options.length;i++){\n\t\t\t\t\t\tif(timeOut.value==cmbTime.options[i].value){\n\t\t\t\t\t\t\tcmbTime.selectedIndex=i;\n\t\t\t\t\t\t\tcmbTime.selectedValue=timeOut.value\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tbreak;\n\t\t\t\t\t\t}\t\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t}\n\n\t\t\tfunction refreshNow(){\t\t\t\t\t\t\t\t\n\t\t\t\tif(document.getElementById(\"device\").value!=\"\" || document.getElementById(\"device\").value!=\"-1\"){\n");
      out.write("\t\t\t\t\tdocument.getElementById(\"processFlag\").value=\"true\";\t\t\t\t\n\t\t\t\t\trefreshLog();\n\t\t\t\t\tdocument.getElementById(\"processFlag\").value=\"false\";\n\t\t\t\t}\t\t\t\t\n\t\t\t}\n\t\t\t\n\t\t</script>\n\t\t<style type=\"text/css\">\n\t\t\t.tdText{\n\t\t\t\tfont-family:Arial,Verdana,Helvetica,sans-serif;\n\t\t\t\tcolor:#313131;\n\t\t\t\tfont-size:11px;\n\t\t\t\tfont-weight:bold;\t\t\t\n\t\t\t}\n\t\t\t.headDiv{\t\t\t\n\t\t\t\t-moz-background-clip:border;\n\t\t\t\t-moz-background-inline-policy:continuous;\n\t\t\t\tbackground:transparent url(../images/navi_back.jpg) repeat scroll 0 0;\n\t\t\t\tborder:thin solid #E2E2E2;\t\t\t\n\t\t\t\tpadding:2px;\n\t\t\t\tfont-family:Arial,Verdana,Helvetica,sans-serif;\n\t\t\t\tcolor:#313131;\n\t\t\t\tfont-size:11px;\n\t\t\t\tfont-weight:bold;\t\t\t\t\n\t\t\t}\t\t\t\n\t\t\t.UpdateButton{\n\t\t\t\t\tBORDER-RIGHT: #999999 1px solid;\n\t\t\t\t\tBORDER-TOP: #999999 1px solid; \n\t\t\t\t\tMARGIN-TOP: 2px;\n\t\t\t\t\tFONT-WEIGHT: bold;\n\t\t\t\t\tFONT-SIZE: 11px; \n\t\t\t\t\tBACKGROUND: url(../images/btnbkgd.jpg); \n\t\t\t\t\tMARGIN-BOTTOM: 2px; \n\t\t\t\t\tBORDER-LEFT: #999999 1px solid; \n\t\t\t\t\tWIDTH: auto;\n\t\t\t\t\tCOLOR: rgb(58,78,87); \n\t\t\t\t\tBORDER-BOTTOM: #999999 1px solid;\n");
      out.write("\t\t\t\t\tFONT-FAMILY: arial; \n\t\t\t\t\tHEIGHT: 24px\n\t\t\t}\n\t\t\t.atag{\n\t\t\t\tcolor:rgb(35,136,199);\n\t\t\t}\n\t\t\t.selectBox{\n\t\t\t\tcolor:#2A576A;\n\t\t\t\tfont-size:11px;\n\t\t\t\tfont-weight:bold;\n\t\t\t\theight:20px;\n\t\t\t}\n\t\t</style>\n\t\t</head>\n\t\t<body>\t\t\t\n\t\t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("        \n    \t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("\n\t\t\t<div class=\"maincontent\" id=\"main_content\">\t\t\t\t\t\t\n\t\t\t<div class=\"reporttitlebar\">\n\t\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t\t<div class=\"reporttitle\">Live Logs</div>\t\t\t\n\t\t\t</div>\t\n\t\t\t<br/><br/>\n\t\t\t<form name=\"contentForm\" action=\"");
      out.print(request.getContextPath());
      out.write("/webpages/viewarchive.jsp\" method=\"get\">\t\t\t\t\t\t\t\n\t\t\t\t<div class=\"headDiv\">\n\t\t\t\t<b>Device Name:</b>\n\t\t\t\t&nbsp;&nbsp;\n\t\t\t\t<select id=\"cmbDevice\" class=\"selectBox\">\n\t\t\t\t\t<option value=\"-1\">Select Device</option>\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t");

					Iterator deviceIterator =DeviceBean.getAllDeviceBeanIterator();
					DeviceBean deviceBean=null;
					if(deviceIterator!=null){
						while(deviceIterator.hasNext()){							
							deviceBean=(DeviceBean)deviceIterator.next();
							if(deviceBean!=null)
								out.println("<option value="+deviceBean.getApplianceID()+">"+deviceBean.getName()+"</option>");						
						}
					}																		
				
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t</select>\n\t\t\t\t&nbsp;&nbsp;&nbsp;\n\t\t\t\t<b>Refresh Time:</b>\n\t\t\t\t&nbsp;&nbsp;\n\t\t\t\t<select id=\"cmbTime\" class=\"selectBox\">\n\t\t\t\t    <option value=\"3\">3 Sec.</option>\n\t\t\t\t    <option value=\"5\">5 Sec.</option>\n\t\t\t\t\t<option value=\"10\">10 Sec.</option>\n\t\t\t\t\t<option selected value=\"20\">20 Sec.</option>\n\t\t\t\t\t<option value=\"30\">30 Sec.</option>\n\t\t\t\t\t<option value=\"60\">1 Min.</option>\n\t\t\t\t\t<option value=\"120\">2 Min.</option>\n\t\t\t\t\t<option value=\"300\">5 Min.</option>\n\t\t\t\t</select>\n\t\t\t\t&nbsp;&nbsp;\n\t\t\t\t<input id=\"submitButton\" class=\"UpdateButton\" type=\"submit\" value=\"GO\" onclick=\"return onSelectDevice()\"></input>\n\t\t\t</div>\t\t\t\t\t\n\t\t\t<div class=\"headDiv\">\n\t\t\t\t<table>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<td class=\"tdText\">\n\t\t\t\t\t\t\tShow Last &nbsp;\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td>\n\t\t\t\t\t\t\t<select id=\"limit\" name=\"limit\" class=\"selectBox\">\n\t\t\t\t\t\t\t\t<option value=\"25\">25</option>\n\t\t\t\t\t\t\t\t<option value=\"50\">50</option>\n\t\t\t\t\t\t\t\t<option value=\"100\">100</option>\n\t\t\t\t\t\t\t</select>\n\t\t\t\t\t\t\t&nbsp;\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class=\"tdText\">\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tRecords.\n");
      out.write("\t\t\t\t\t\t\t&nbsp;&nbsp;\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td>\n\t\t\t\t\t\t\t<input id=\"UpdateButton\" class=\"UpdateButton\" type=\"button\"   value=\"");
      out.print(device==null?"Start Update":"Stop Update");
      out.write("\" onclick=\"setProcessFlag(this)\"></input>\n\t\t\t\t\t\t\t&nbsp;\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td>\n\t\t\t\t\t\t\t&nbsp;\n\t\t\t\t\t\t\t<input id=\"RefreshButton\" class=\"UpdateButton\" type=\"button\"   value=\"Refresh\" onclick=\"refreshNow()\"></input>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\t\t\t\t\t\t\t\t\t\n\t\t\t</div>\t\t\t\n\t\t\t");
				
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
			
      out.write("\n\t\t\t\t<input type=\"hidden\" name=\"offset\" id=\"offset\" value=\"-1\"></input>\n\t\t\t\t<input type=\"hidden\" name=\"name\" id=\"name\" value=\"\"></input>\t\t\t\t\t\t\n\t\t");

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
		
      out.write("\t\t\n\t\t</form>\t\t\t\n\t\t</div>\n\t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\t\t\n\t\t<script lang=\"javascript\">\n\t\t\tstartup(); \n\t\t</script>\t\t\t\t\t\n\t</body>\n</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
