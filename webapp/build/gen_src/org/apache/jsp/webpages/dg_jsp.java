package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.audit.AuditLogHelper;
import java.text.SimpleDateFormat;
import org.cyberoam.iview.system.beans.MemoryUsageBean;
import org.cyberoam.iview.system.beans.CPUUsageBean;
import org.cyberoam.iview.utility.GarnerManager;
import org.cyberoam.iview.system.beans.DiskUsageBean;
import java.util.ArrayList;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.UdpPacketCapture;
import org.cyberoam.iview.utility.TroubleShoot;
import org.cyberoam.iview.system.utility.SystemInformation;
import org.cyberoam.iview.beans.iViewConfigBean;
import java.util.Date;
import java.text.DecimalFormat;

public final class dg_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

/*<!-- ***********************************************************************
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
*/
      out.write("\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n");

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

      out.write("\r\n\r\n<html>\r\n<head>\r\n<title>");
      out.print(iViewConfigBean.TITLE);
      out.write("</title>\r\n<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\r\n<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/grid.css\" />\r\n<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/tabs.css\" />\r\n<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" />\r\n<script language=\"Javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ajax.js\"></script>\r\n<script language=\"Javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/container.js\"></script>\r\n<script language=\"Javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/combo.js\"></script>\r\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/dhtmlxcommon.js\"></script>\r\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/dhtmlxgrid.js\"></script>\r\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/dhtmlxgridcell.js\"></script>\r\n<script src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/dhtmlxgrid_filter.js\"></script>\r\n<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></SCRIPT>\r\n<style type=\"text/css\" >@import url(");
      out.print(request.getContextPath());
      out.write("/css/calendar-blue.css);</style>\r\n<style type=\"text/css\" >@import url(");
      out.print(request.getContextPath());
      out.write("/css/configuration.css);</style>\r\n<style type=\"text/css\">@import url(");
      out.print(request.getContextPath());
      out.write("/css/newTheme.css);</style>\r\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/popup.css\">\r\n<script language=\"JavaScript\" src=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popup.js\"></script>\r\n\r\n<script LANGUAGE=\"Javascript\">\r\n\tvar timeflag;\r\n\twindow.onload = function (evt) {\r\n\t\tsetWidth();\t\t\t\t\r\n\t}\t\t\r\n\tfunction setWidth(){\r\n\t\tvar main_div = document.getElementById(\"main_content\");\t\r\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\r\n\t}\r\n\tfunction openViewLog(){\r\n\t\tdocument.getElementById(\"fileid\").value=\"garner\";\r\n\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/viewlog.jsp';\r\n\t\thandleThickBox(1,'troubleshoot',\"700\");\r\n\t\tsetTimeout(\"refreshlogs()\",500);\t\t\r\n\t}\r\n\r\n\tfunction openViewTomLog(){\r\n\t\tvar tomindex=document.getElementById(\"tomlogs\").selectedIndex;\r\n\t\tvar logtype=document.getElementById(\"tomlogs\").options[tomindex].value;\r\n\t\tif(logtype==\"tomapp\"){\r\n\t\t\tdocument.getElementById(\"fileid\").value=\"tomapp\";\r\n\t\t}\r\n\t\telse if(logtype==\"tomsys\"){\r\n\t\t\tdocument.getElementById(\"fileid\").value=\"tomsys\";\r\n\t\t}\r\n\t\telse if(logtype==\"tomaudit\"){\r\n\t\t\tdocument.getElementById(\"fileid\").value=\"tomaudit\";\r\n\t\t}\r\n\t\telse if(logtype==\"tomrep\"){\r\n\t\t\tdocument.getElementById(\"fileid\").value=\"tomrep\";\r\n\t\t}\r\n\t\telse if(logtype==\"tomcon\"){\r\n\t\t\tdocument.getElementById(\"fileid\").value=\"tomcon\";\r\n\t\t}\r\n\t\telse if(logtype==\"tomsql\"){\r\n\t\t\tdocument.getElementById(\"fileid\").value=\"tomsql\";\r\n\t\t}\r\n\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/viewlog.jsp';\r\n\t\thandleThickBox(1,'troubleshoot',\"700\");\r\n\t\tsetTimeout(\"refreshlogs()\",500);\t\t\r\n\t}\r\n\tfunction openShowTable()\t{\r\n\t\tdocument.getElementById(\"fileid\").value=\"rwtable\";\r\n\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/viewlog.jsp';\r\n\t\thandleThickBox(1,'troubleshoot',\"700\");\r\n\t\tsetTimeout(\"refreshlogs()\",500);\r\n\t}\r\n\tfunction openShowQueries()\t{\r\n\t\tdocument.getElementById(\"fileid\").value=\"showquery\";\r\n\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/viewlog.jsp';\r\n\t\thandleThickBox(1,'troubleshoot',\"700\");\r\n\t\tsetTimeout(\"refreshlogs()\",500);\r\n\t}\r\n\r\n\tfunction openShowPacket()\t{\t\t\r\n\t\tdocument.getElementById(\"fileid\").value=\"viewpacket\";\r\n\t\tvar url=\"");
      out.print(request.getContextPath());
      out.write("\"+\"/webpages/dg.jsp\";\t\t\t\t\t\t\r\n\t\turl=url+\"?reqtype=startudppacketcapture\";\t\t\t\t\t\t\t\t\r\n\t\tSimpleAJAXCall(url, startUpStatus, \"post\", \"1\");\r\n\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/viewlog.jsp';\r\n\t\thandleThickBox(1,'troubleshoot',\"700\");\r\n\t\tsetTimeout(\"setLimit()\",500);\r\n\t\tsetTimeout(\"refreshlogs()\",500);\r\n\t}\r\n\r\n\tfunction decidePacketLoad()\r\n\t{\r\n\t\t\tif(document.getElementById(\"statusbutton\").value==\"Stop Garner\"){\r\n\t\t\t\talert(\"Please Stop the Garner to enable Packet Viewer\");\r\n\t\t\t}\r\n\t\t\telse{\r\n\t\t\t\topenShowPacket();\r\n\t\t\t}\r\n\t}\t\r\n\r\n\tfunction startUpStatus(){\r\n\t\t\r\n\t}\r\n\tfunction setLimit()\r\n\t{\r\n\t\tdocument.getElementById(\"limit\").options[0].value=\"10\";\r\n\t\tdocument.getElementById(\"limit\").options[0].innerHTML=\"10\";\r\n\t\tdocument.getElementById(\"limit\").options[1].value=\"25\";\r\n\t\tdocument.getElementById(\"limit\").options[1].innerHTML=\"25\";\r\n\t\tdocument.getElementById(\"limit\").options[2].value=\"50\";\r\n\t\tdocument.getElementById(\"limit\").options[2].innerHTML=\"50\";\r\n\t\tdocument.getElementById(\"limit\").options[3].value=\"100\";\r\n\t\tdocument.getElementById(\"limit\").options[3].innerHTML=\"100\";\r\n\t}\r\n\tfunction refreshlogs()\t{\r\n\t\tvar fileid=document.getElementById(\"fileid\").value;\r\n\t\tif(fileid==\"garner\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Garner Logs\";\r\n");
      out.write("\t\t\t}\r\n\t\telse if(fileid==\"tomapp\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Tomcat Application Logs\";\r\n\t\t}\r\n\t\telse if(fileid==\"tomsys\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Tomcat System Logs\";\r\n\t\t}\r\n\t\telse if(fileid==\"tomaudit\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Tomcat Audit Logs\";\r\n\t\t}\r\n\t\telse if(fileid==\"tomcon\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Tomcat ConnectionPool Logs\";\r\n\t\t}\r\n\t\telse if(fileid==\"tomrep\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Tomcat Report Logs\";\r\n\t\t}\r\n\t\telse if(fileid==\"tomsql\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"SQL Query Logs\";\r\n\t\t}\r\n\t\telse if(fileid==\"rwtable\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Current Queued Tables\";\r\n\t\t}\r\n\t\telse if(fileid==\"showquery\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Running Queries\";\r\n\t\t}\r\n\t\telse if(fileid==\"viewpacket\"){\r\n\t\t\tdocument.getElementById(\"formtitle\").innerHTML=\"Live Packet Capture\";\r\n\t\t}\r\n\t\t\r\n\t\t\r\n\t\tvar timeindex=document.getElementById(\"refreshtime\").selectedIndex;\r\n");
      out.write("\t\tvar timeout=document.getElementById(\"refreshtime\").options[timeindex].value;\r\n\t\tvar limindex=document.getElementById(\"limit\").selectedIndex;\r\n\t\tvar lim=document.getElementById(\"limit\").options[limindex].value;\r\n\t\tvar searchkey=document.getElementById(\"searchkey\").value;\r\n\t\tvar url=\"");
      out.print(request.getContextPath());
      out.write("\"+\"/webpages/dg.jsp\";\t\t\r\n\t\tvar querystring=\"?limit=\"+lim;\t\r\n\t\tquerystring+=\"&fileid=\"+fileid;\t\r\n\t\tquerystring+=\"&searchkey=\"+searchkey;\t\t\t\t\t\t\r\n\t\turl=url+querystring +\"&reqtype=ajax\";\t\t\t\t\t\t\t\t\r\n\t\tvar time = parseInt(timeout) * 1000;\r\n\t\tSimpleAJAXCall(url, addToList, \"post\", \"1\");\r\n\t\ttimeflag=setTimeout(\"refreshlogs()\",time);\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t}\r\n\t\r\n\tfunction addToList(xmlreq,id)\t{\r\n\t\tif(xmlreq!=null){\t\t\t\t\t\t\t\t\t\r\n\t\t\tvar rootobj=xmlreq.getElementsByTagName(\"root\");\t\t\t\t\t\r\n\t\t\tif(rootobj!=null){\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\tvar recordlist=rootobj.item(0).getElementsByTagName(\"record\");\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\r\n\t\t\t\tif(recordlist!=null && recordlist.length>0){\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\tvar parentDiv =document.getElementById(\"archiveContent\");\t\t\r\n\t\t\t\t\tif(parentDiv!=null){\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\tvar childDiv=parentDiv.getElementsByTagName(\"div\");\t\t\t\t\t\r\n\t\t\t\t\t\tvar lengthDiv=childDiv.length;\r\n\t\t\t\t\t\tvar index=document.getElementById(\"limit\").selectedIndex;\r\n\t\t\t\t\t\tvar limit=document.getElementById(\"limit\").options[index].value;\r\n\t\t\t\t\t\tfor(i=0; i<lengthDiv;i++){\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\tparentDiv.removeChild(childDiv[0]);\t\t\t\r\n\t\t\t\t\t\t}\t\r\n\t\t\t\t\t\t\r\n\t\t\t\t\t\tfor(count=0;count<recordlist.length;count++){\r\n\t\t\t\t\t\t\tvar logobj= recordlist.item(count).getElementsByTagName(\"log\");\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\tvar newdiv =document.createElement(\"div\");\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\tnewdiv.innerHTML=logobj.item(0).childNodes[0].data;\r\n\t\t\t\t\t\t\tif(count%2==0){\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\tnewdiv.className=\"trdark\";\r\n\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\telse{\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\tnewdiv.className=\"trlight\";\r\n\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\tparentDiv.appendChild(newdiv);\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t}\t\r\n\t\t\t\t}\t\t\t\r\n\t\t\t}\r\n\t\t}\r\n\t}\r\n\t\t\t\t\r\n\tfunction clearlogs(){\r\n\t\tvar parentDiv =document.getElementById(\"archiveContent\");\t\t\t\t\t\t\t\t\t\t\t\r\n\t\tvar childDiv=parentDiv.getElementsByTagName(\"div\");\t\t\t\t\t\r\n\t\tvar lengthDiv=childDiv.length;\r\n\t\tfor(i=0; i<lengthDiv;i++){\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n\t\t\tparentDiv.removeChild(childDiv[0]);\t\t\t\r\n\t\t}\r\n\t}\r\n\t\r\n\tfunction stoplogs()\t{\r\n\t\tif(document.getElementById(\"stop\").value==\"Stop\")\t{\r\n\t\t\tclearTimeout(timeflag);\t\r\n\t\t\tdocument.getElementById(\"stop\").value=\"Start\";\r\n");
      out.write("\t\t\tdocument.getElementById(\"refresh\").disabled=true;\t\r\n\t\t}\r\n\t\telse\t{\r\n\t\t\tdocument.getElementById(\"stop\").value=\"Stop\";\r\n\t\t\tdocument.getElementById(\"refresh\").disabled=false;\r\n\t\t\trefreshlogs();\r\n\t\t}\r\n\t}\r\n\t\r\n\t\r\n\tfunction userRefresh()\t{\r\n\t\tif(document.getElementById(\"stop\").value!=\"Start\"){\r\n\t\t\tclearTimeout(timeflag);\r\n\t\t\trefreshlogs();\t\r\n\t\t}\t\r\n\t}\r\n\tfunction closeForm()\t{\r\n\t\tif(document.getElementById(\"fileid\").value==\"viewpacket\"){\r\n\t\t\tcloseclildwindow();\r\n\t\t}else{\r\n\t\t\tclearTimeout(timeflag);\r\n\t\t\thandleThickBox('2','troubleshoot');\r\n\t\t}\r\n\t}\r\n\tfunction closeclildwindow()\t{\r\n\t\tclearTimeout(timeflag);\r\n\t\tvar url=\"");
      out.print(request.getContextPath());
      out.write("\"+\"/webpages/dg.jsp\";\t\r\n\t\turl=url +\"?reqtype=stopudppacketcapture\";\r\n\t\tSimpleAJAXCall(url, finished, \"post\", \"1\");\r\n\t\talert(\"Please Start the Garner otherwise no logs will be parsed\");\r\n\t\thandleThickBox('2','troubleshoot');\r\n\t}\r\n\r\n\tfunction changeStatus(){\r\n\t\tvar url=\"");
      out.print(request.getContextPath());
      out.write("\"+\"/webpages/dg.jsp\";\t\r\n\t\r\n\t\tif(document.getElementById(\"statusbutton\").value==\"Stop Garner\"){\r\n\t\t\tdocument.getElementById(\"statusbutton\").value=\"Stopping....\";\r\n\t\t\tdocument.getElementById(\"statusbutton\").disabled=true;\r\n\t\t\turl=url+\"?reqtype=stopgarner\";\r\n\t\t}else{\r\n\t\t\tdocument.getElementById(\"statusbutton\").value=\"Starting...\";\r\n\t\t\tdocument.getElementById(\"statusbutton\").disabled=true;\r\n\t\t\turl=url+\"?reqtype=startgarner\";\r\n\t\t}\r\n\t\tSimpleAJAXCall(url, finished, \"post\", \"1\");\r\n\t}\r\n\tfunction finished(xmlreq,id){\r\n\t\tif(xmlreq!=null){\r\n\t\t\tvar rootobj=xmlreq.getElementsByTagName(\"result\");\r\n\t\t\tif(rootobj!=null){\r\n\t\t\t\tif(rootobj.item(0).childNodes[0].data==\"false\"){\r\n\t\t\t\t\tdocument.getElementById(\"garnerrunningstatus\").innerHTML = \"<font style='color:red'>Garner is Not Running</font>\";\r\n\t\t\t\t\tdocument.getElementById(\"statusbutton\").value=\"Start Garner\";\r\n\t\t\t\t\tdocument.getElementById(\"statusbutton\").disabled=false;\r\n\t\t\t\t}else{\r\n\t\t\t\t\tdocument.getElementById(\"garnerrunningstatus\").innerHTML = \"<font style='color:green'>Garner is Running</font>\";\r\n");
      out.write("\t\t\t\t\tdocument.getElementById(\"statusbutton\").value=\"Stop Garner\";\r\n\t\t\t\t\tdocument.getElementById(\"statusbutton\").disabled=false;\r\n\t\t\t\t}\r\n\t\t\t}\r\n\t\t}\t\r\n\t}\r\n\t\r\n</script>\r\n</head>\r\n<body>\r\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\r\n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("      \r\n\t<div class=\"maincontent\" id=\"main_content\">\r\n\t\r\n\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n\t\t\t<tr>\r\n\t\t\t\t<td align=\"left\">\r\n\t\t\t\t\t<table width=\"100%\">\r\n\t\t\t\t\t\t<tr>\t\r\n\t\t\t\t\t\t\t<td colspan=\"1\">\r\n\t\t\t\t\t\t\t\t<div class=\"reporttitlebar\">\r\n\t\t\t\t<div class=\"reporttitlebarleft\"></div>\r\n\t\t\t\t<div class=\"reporttitle\">System Information\r\n\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\r\n\t\t\t\t\t<a href=\"");
      out.print(request.getContextPath());
      out.write("/troubleshoot/ts");
      out.print(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
      out.write(".txt?choice=3\"><img class=\"xlslink\" src=\"../images/SaveIcon.png\" title=\"Download Troubleshoot.txt\"></a>\r\n\t\t\t\t</div>\r\n\t\t\t\t\t\t\r\n\t</div>\t\r\n\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\r\n\t\t\t\t\t\t<tr>\r\n\t\t\t\t\t\t\t<td colspan=\"1\">\r\n\t\t\t\t\t\t\t\t<table class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n\t\t\t\t\t\t\t\t\t<tr height=\"25px\">\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tdhead\" style=\"padding-left:10px\">&nbsp;</td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tdhead\" style=\"padding-left:10px\"><b>Used</b></td>\r\n\t\t\t\t\t\t\t\t\t\t<td style=\"padding-left:10px\" class=\"tdhead\"><b>Free</b></td>\r\n\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t</tr>\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t \t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\"><b>Memory</b></td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(new DecimalFormat(".##").format(memoryUsageBean.getMemoryInUse()/(1024*1024)) + " MB" );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(new DecimalFormat(".##").format(memoryUsageBean.getFreeMemory()/(1024*1024)) +" MB" );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\r\n\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\"><b>CPU</b></td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(100-cpuUsageBean.getIdlePercent()+"%" );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(cpuUsageBean.getIdlePercent()+"%" );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\r\n\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\"><b>Archive in Disk</b></td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(new DecimalFormat(".##").format((double)diskUsageBean.getUsedInArchive()/(1024*1024))+" GB" );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(new DecimalFormat(".##").format((double)diskUsageBean.getFreeInArchive()/(1024*1024))+" GB" );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\r\n\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\"><b>Database in Disk</b></td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(new DecimalFormat(".##").format((double)diskUsageBean.getUsedInData()/(1024*1024))+" GB" );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(new DecimalFormat(".##").format((double)diskUsageBean.getFreeInData()/(1024*1024))+" GB" );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t</table>\r\n\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t</table>\r\n\t\t\t\t</td>\r\n\t\t\t</tr>\r\n\t\t</table>\r\n\t</div>\r\n\t\t\r\n\t<div class=\"maincontent\">\r\n\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n\t\t\t<tr>\r\n\t\t\t\t<td align=\"left\">\r\n\t\t\t\t\t<table width=\"100%\">\r\n\t\t\t\t\t\t<tr>\t\r\n\t\t\t\t\t\t\t<td colspan=\"2\">\r\n\t\t\t\t\t\t\t\t<div class=\"content_head\" width=\"100%\">\r\n\t\t\t\t\t\t\t\t\t<div width=\"100%\" class=\"reporttitle\">\r\n\t\t\t\t\t\t\t\t\t\tSyslog(Garner) Information\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\r\n\t\t\t\t\t\t<tr>\r\n\t\t\t\t\t\t\t<td colspan=\"2\">\r\n\t\t\t\t\t\t\t\t<table class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n\t\t\t\t\t\t\t\t\t<tr height=\"25px\">\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tdhead\" style=\"padding-left:10px\"><b>Status</b></td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t \t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\" id=\"garnerrunningstatus\">\r\n\t\t\t\t\t\t\t\t\t");

										if(GarnerManager.getGarnerStatus()){
											out.println("<font style='color:green'>Garner is Running</font>");
										}else {
											out.println("<font style='color:red'>Garner is Not Running</font>");
										}
										
      out.write("\r\n\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t<div id=\"3\">\r\n\t\t\t\t\t\t\t\t\t\t<input align=\"right\" type=\"button\" style=\"height: 20px;\" class=\"criButton\" value=\"");
      out.print((status)?"Stop Garner":"Start Garner");
      out.write("\" onclick=\"changeStatus()\" id=\"statusbutton\">\r\n\t\t\t\t\t\t\t\t\t\t<input align=\"right\" type=\"button\" style=\"height: 20px;\" class=\"criButton\" value=\"View Logs\" onclick=\"openViewLog()\" name=\"viewlogs\">\r\n\t\t\t\t\t\t\t\t\t\t<input align=\"right\" type=\"button\" style=\"height: 20px;\" class=\"criButton\" value=\"Packet Capture\" onclick=\"decidePacketLoad()\" id=\"viewpacketbutton\"></div>\t\r\n\t\t\t\t\t\t\t\t\t</div>\t\r\n\t\t\t\t\t\t\t\t</table>\r\n\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t</table>\r\n\t\t\t\t</td>\r\n\t\t\t</tr>\r\n\t\t</table>\r\n\t</div>\r\n\t\r\n\t<div class=\"maincontent\">\r\n\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n\t\t\t<tr>\r\n\t\t\t\t<td align=\"left\">\r\n\t\t\t\t\t<table width=\"100%\">\r\n\t\t\t\t\t\t<tr>\t\r\n\t\t\t\t\t\t\t<td colspan=\"2\">\r\n\t\t\t\t\t\t\t\t<div class=\"content_head\" width=\"100%\">\r\n\t\t\t\t\t\t\t\t\t<div width=\"100%\" class=\"reporttitle\">\r\n\t\t\t\t\t\t\t\t\t\tTomcat Logs\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t<tr>\r\n\t\t\t\t\t\t\t<td colspan=\"2\">\r\n\t\t\t\t\t\t\t\t<table class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n\t\t\t\t\t\t\t\t\t<tr height=\"25px\">\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tdhead\" style=\"padding-left:10px\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<select name=\"tomlogs\" id=\"tomlogs\">\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"tomaudit\">Audit Logs</option>\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"tomapp\">Application Logs</option>\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"tomsys\">System Logs</option>\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"tomrep\">Report Logs</option>\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"tomcon\">ConnectionPool  Logs</option>\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"tomsql\">SqlQuery  Logs</option>\r\n\t\t\t\t\t\t\t\t\t\t\t</select>\r\n\t\t\t\t\t\t\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\r\n\t\t\t\t\t\t\t\t\t\t\t<input align=\"right\" type=\"button\" style=\"height: 20px;\" class=\"criButton\" value=\"View\" onclick=\"openViewTomLog()\" name=\"tomlogs\">\r\n\t\t\t\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t</table>\r\n\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t</table>\r\n\t\t\t\t</td>\r\n\t\t\t</tr>\r\n\t\t</table>\r\n\t</div>\r\n\t\r\n\t\r\n\t\r\n\t<div class=\"maincontent\">\r\n\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n\t\t\t<tr>\r\n\t\t\t\t<td align=\"left\">\r\n\t\t\t\t\t<table width=\"100%\">\r\n\t\t\t\t\t\t<tr>\t\r\n\t\t\t\t\t\t\t<td colspan=\"2\">\r\n\t\t\t\t\t\t\t\t<div class=\"content_head\" width=\"100%\">\r\n\t\t\t\t\t\t\t\t\t<div width=\"100%\" class=\"reporttitle\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\tDatabase Server\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\r\n\t\t\t\t\t\t<tr>\r\n\t\t\t\t\t\t\t<td colspan=\"2\">\r\n\t\t\t\t\t\t\t\t<table class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n\t\t\t\t\t\t\t\t\t<tr height=\"25px\">\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tdhead\" style=\"padding-left:10px\"><b>Total No. of connections</b></td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t \t\t\t\t<tr class=\"trlight\" onMouseOver='this.className=\"trlight1\";' onMouseOut='this.className=\"trlight\";' >\r\n\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\" align=\"left\">");
      out.print(new TroubleShoot().getTotalCon() );
      out.write("</td>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t\t<div id=\"3\">\r\n\t\t\t\t\t\t\t\t\t\t<input align=\"right\" type=\"button\" style=\"height: 20px;\" class=\"criButton\" value=\"Running Queries\" onclick=\"openShowQueries()\" name=\"run qury\">\r\n\t\t\t\t\t\t\t\t\t\t<input align=\"right\" type=\"button\" style=\"height: 20px;\" class=\"criButton\" value=\"Show Queue tables\" onclick=\"openShowTable()\" name=\"rw tables\">\r\n\t\t\t\t\t\t\t\t\t\t\r\n\t\t\t\t\t\t\t\t\t</div>\t\r\n\t\t\t\t\t\t\t\t</table>\r\n\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t</table>\r\n\t\t\t\t</td>\r\n\t\t\t</tr>\r\n\t\t</table>\r\n\t</div>\r\n\t\t<input type='hidden' name='fileid' id='fileid' value=\"\"></input>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\r\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\r\n<div class=\"TB_window\" id=\"troubleshoot\"></div>\r\n</body>\r\n");

	}catch(Exception e){
	CyberoamLogger.appLog.debug("dg.jsp"+e,e);
}
	
      out.write("\r\n</html>\r\n");
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
