/* ***********************************************************************
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
*************************************************************************/

package org.cyberoam.iview.servlets;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.authentication.beans.UserBean;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import org.cyberoam.iview.charts.Chart;
import org.cyberoam.iview.device.beans.DeviceGroupRelationBean;

/**
 * This servlet is used to handle AJAX requests of iView web application.
 * @author Atit Shah
 *
 */
public class PdfGenerator extends HttpServlet {
	
	/**
	 * This method is used to handle HTTP GET requests. 
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		doPost(request, response);
	}
	
	/**
	 * This method is used to handle HTTP POST requests.
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{							
		
		String startDate=null,endDate=null,limit="10",offset=null,applianceList=null,mode=null;
		String []deviceList=null;
		int reportGroupID=-1;
		int reportID=-1;
		int [] diviceIDs;				
		ServletOutputStream out=null;
		try {									
			if(request.getParameter("pdfdata")!=null)
				mode=(String)request.getParameter("pdfdata");
			if(mode.equalsIgnoreCase("group")) {
				limit="5";				
			}else{
				reportID=Integer.parseInt(request.getParameter("reportid"));
			}
			HttpSession session=request.getSession();
			String isDeviceGroup = (String)session.getAttribute("isdevicegroup");
			String deviceGroup = (String)session.getAttribute("devicegroup");
			if(isDeviceGroup != null && isDeviceGroup.equalsIgnoreCase("false") && session.getAttribute("devicelist")!=null && ((String)session.getAttribute("devicelist")).equals("-1")==false) {
				CyberoamLogger.appLog.info("*******Device List from Session******"+session.getAttribute("devicelist"));
				deviceList=((String)session.getAttribute("devicelist")).split(",");
			}else if(isDeviceGroup != null && isDeviceGroup.equalsIgnoreCase("true")){
				String[] arrAppIdlist = ((String)session.getAttribute("devicegrouplist")).split(",");
				ArrayList deviceGroupRelList = null;
				DeviceBean deviceBean =null;
				String deviceIDList="";
				for (int i = 0; i < arrAppIdlist.length; i++) {
					deviceGroupRelList = DeviceGroupRelationBean.getRelationByGroupID((Integer.parseInt(arrAppIdlist[i])));
					for (int j = 0; j < deviceGroupRelList.size(); j++) {
						DeviceGroupRelationBean deviceGroupRelationBean = (DeviceGroupRelationBean) deviceGroupRelList.get(j);
						deviceBean = DeviceBean.getRecordbyPrimarykey(deviceGroupRelationBean.getDeviceID());
						if (deviceBean != null) {
							deviceIDList += deviceBean.getDeviceId() + ",";
						}
					}
				}
				if(deviceIDList.equalsIgnoreCase("") && deviceIDList.charAt(deviceIDList.length()-1) == ',' ){
					deviceIDList = deviceIDList.substring(0, deviceIDList.length()-1);
				}
				deviceList = deviceIDList.split(",");
			}
			else {								
				deviceList = UserCategoryDeviceRelBean.getDeviceIdListForUser(UserBean.getRecordbyPrimarykey((String)session.getAttribute("username")).getUserId());
				CyberoamLogger.appLog.info("***Device List from Bean***"+deviceList);			
			}			
			diviceIDs=new int[deviceList.length];
			for(int i=0;i<deviceList.length;i++) 
				diviceIDs[i]=Integer.parseInt(deviceList[i]);
			if(request.getParameter("reportgroupid")!=null)
				reportGroupID=Integer.parseInt(request.getParameter("reportgroupid"));
			if(session.getAttribute("startdate")!=null)
				startDate=(String)session.getAttribute("startdate");
			if(session.getAttribute("enddate")!=null)
				endDate=(String)session.getAttribute("enddate");
			if(request.getParameter("limit")!=null && Integer.parseInt(request.getParameter("limit"))>10)
				limit=request.getParameter("limit");
			if(request.getParameter("offset")!=null)
				offset=request.getParameter("offset");			
			if(session.getAttribute("appliancelist")!=null)
				applianceList=(String)session.getAttribute("appliancelist");
			CyberoamLogger.appLog.info("Mode: "+mode);
			CyberoamLogger.appLog.info("Report Group Id: "+reportGroupID);
			CyberoamLogger.appLog.info("Start Date: "+startDate);
			CyberoamLogger.appLog.info("End Date: "+endDate);
			CyberoamLogger.appLog.info("Limit: " + limit);
			CyberoamLogger.appLog.info("Offset: 	"  +offset);
			CyberoamLogger.appLog.info("Appliance List: " +applianceList);
			CyberoamLogger.appLog.info("Device List: " +diviceIDs.length);			
			CyberoamLogger.appLog.info("***Getting Output Stream***");
			out=response.getOutputStream();
			CyberoamLogger.appLog.info("***Chart Generartion***");
			if(reportID==-1)
				Chart.generatePDFReportGroup(response.getOutputStream(), reportGroupID, applianceList, startDate, endDate, limit,diviceIDs,request,null);
			else
				Chart.generatePDFReport(response.getOutputStream(), reportID, applianceList, startDate, endDate, limit,diviceIDs,request,reportGroupID,null);
			CyberoamLogger.appLog.info("***Chart Generartion Finish***");			
		}catch(Exception ex){
			CyberoamLogger.appLog.info("***Chart Generartion Exception***" + ex.getMessage());
			try {
				out.flush();
				out.close();
				CyberoamLogger.appLog.info(ex.getMessage());
			}catch(Exception e) {}
			
		}
		
	}
}
