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


import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.AuditLogHelper;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.authentication.beans.IviewMenuBean;
import org.cyberoam.iview.authentication.beans.RoleBean;
import org.cyberoam.iview.authentication.helper.LoginHelper;
import org.cyberoam.iview.authentication.helper.UserHelper;
import org.cyberoam.iview.beans.ApplicationNameBean;
import org.cyberoam.iview.beans.DataBaseConfigBean;
import org.cyberoam.iview.beans.ProtocolGroupBean;
import org.cyberoam.iview.beans.ProtocolIdentifierBean;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.device.beans.DeviceGroupBean;
import org.cyberoam.iview.device.beans.DeviceGroupRelationBean;
import org.cyberoam.iview.helper.BackupDataHandler;
import org.cyberoam.iview.helper.BookmarkGroupHelper;
import org.cyberoam.iview.helper.BookmarkHelper;
import org.cyberoam.iview.helper.LoadDataHandler;
import org.cyberoam.iview.helper.MailSchedulerHelper;
import org.cyberoam.iview.helper.ProtocolGroupHelper;
import org.cyberoam.iview.helper.ReportProfileHelper;
import org.cyberoam.iview.helper.RestoreDataHandler;
import org.cyberoam.iview.helper.RestoreHandler;
import org.cyberoam.iview.helper.ScheduleBackupThread;
import org.cyberoam.iview.modes.ApplicationModes;

import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.utility.FTPFileManager;
import org.cyberoam.iview.utility.GarnerManager;
import org.cyberoam.iview.utility.MailSender;
import org.cyberoam.iview.utility.UdpPacketCapture;
import org.cyberoam.iview.utility.WarmFilesRotation;

/**
 * This servlet is used as central controller of iView web application. 
 * This manages configuration of iView.All HTTP requests will be served through this servlet. 
 * @author Narendra Shah
 * @author Vishal Vala
 * @author Amit Maniar
 *
 */
public class iViewController extends HttpServlet{
	
	/**
	 * This method is used to handle HTTP GET requests of iView.
	 */
	public void doGet(HttpServletRequest request,HttpServletResponse response){
		doPost(request, response);
	}
	
	/**
	 * This method is used to handle HTTP POST requests of iView.
	 */
	public void doPost(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession(false);
		try {			
			if(request.getParameter("appmode") == null) 
				response.sendRedirect(request.getContextPath() + "");
			int mode=Integer.parseInt(request.getParameter("appmode"));
			if(mode != ApplicationModes.LOGIN){
				if(CheckSession.checkSession(request, response) < 0){ 
					return ;
				}
			}
			CyberoamLogger.regLog.debug("iView MODE :"+mode);
			int returnStatus = -1;
			ProtocolGroupBean protocolGroupBean = null;
			ApplicationNameBean applicationNameBean = null;
			switch(mode){
				case ApplicationModes.LOGIN:
					LoginHelper.process(request, response);
					break;
				case ApplicationModes.NEWUSER:
					UserHelper.process(request, response);
					break;
				case ApplicationModes.DELETEUSER:
					UserHelper.process(request, response);
					break;
				case ApplicationModes.UPDATEUSER:
					UserHelper.process(request, response);
					break;
				case ApplicationModes.ADD_PROTOCOL_GROUP:
					returnStatus = ProtocolGroupHelper.addProtocolGroup(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.UPDATE_PROTOCOL_GROUP:
					returnStatus = ProtocolGroupHelper.updateProtocolGroup(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.DELETE_PROTOCOL_GROUP:
					returnStatus = ProtocolGroupHelper.deleteProtocolGroup(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.ADD_APPLICATION:
					returnStatus = ProtocolGroupHelper.addProtocol(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.UPDATE_APPLICATION:
					returnStatus = ProtocolGroupHelper.updateProtocol(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.DELETE_APPLICATION:
					returnStatus = ProtocolGroupHelper.deleteProtocol(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.ADD_PROTOCOL_IDENTIFIER:
					String strFrom = null,strTo=null,strProtocol,strapplicationNameId,strApplicationName = null;;
					int iFromValue=-1,iToValue=-1,iProtocol=-1,applicationNameId=-1;
					strFrom=request.getParameter("txtFrom");
					strTo=request.getParameter("txtTo");
					strProtocol=request.getParameter("rdoProtocol");
					strapplicationNameId=request.getParameter("applicationnameid");
					if(strFrom != null && !"null".equalsIgnoreCase(strFrom)){
						strFrom=strFrom.trim();
						iFromValue = new Integer(strFrom);
					}
					if(strTo != null && !"null".equalsIgnoreCase(strTo)){
						strTo=strTo.trim();
						iToValue = new Integer(strTo);
					}
					if(strProtocol != null && !"null".equalsIgnoreCase(strProtocol)){
						strProtocol=strProtocol.trim();
						iProtocol = new Integer(strProtocol);
					}
					if(strapplicationNameId != null && !"null".equalsIgnoreCase(strapplicationNameId)){
						strapplicationNameId=strapplicationNameId.trim();
						applicationNameId = new Integer(strapplicationNameId);
					}
					strApplicationName = ProtocolIdentifierBean.checkForDuplicate(iFromValue, iToValue, iProtocol);
					if(strApplicationName == null){
						returnStatus = ProtocolGroupHelper.addProtocolIdentifier(request, response);
						response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus+"&applicationnameid="+applicationNameId);
					}else{
						response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus+"&applicationname="+strApplicationName+"&applicationnameid="+applicationNameId);
					}
					break;
				case ApplicationModes.UPDATE_PROTOCOL_IDENTIFIER:
					returnStatus = ProtocolGroupHelper.updateProtocolIdentifier(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus+"&applicationnameid="+request.getParameter("applicationnameid"));
					break;
				case ApplicationModes.DELETE_PROTOCOL_IDENTIFIER:
					returnStatus = ProtocolGroupHelper.deleteProtocolIdentifier(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus+"&applicationnameid="+request.getParameter("id")+"&parentwindow=refresh");
					break;	
				case ApplicationModes.RESET_PROTOCOL:
					returnStatus = ProtocolGroupHelper.resetApplication(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/protocolgroup.jsp?appmode="+mode+"&status="+returnStatus+"&parentwindow=refresh");
					break;
				case ApplicationModes.ARCHIEVE_LOAD_REQUEST:
					LoadDataHandler.process(request, response);
					break;
				case ApplicationModes.ADD_REPORT_PROFILE:
					int categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					returnStatus = ReportProfileHelper.addReportProfile(request, response);
					int userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
					String menuItem = IviewMenuBean.getIviewMenu(userLevel,categoryId);
					session.setAttribute("menudata",menuItem);
					response.sendRedirect(request.getContextPath()+"/webpages/reportprofile.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.UPDATE_REPORT_PROFILE:
					categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					returnStatus = ReportProfileHelper.updateReportProfile(request, response);
					userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
					menuItem = IviewMenuBean.getIviewMenu(userLevel,categoryId);
					session.setAttribute("menudata",menuItem);
					
					response.sendRedirect(request.getContextPath()+"/webpages/reportprofile.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.DELETE_REPORT_PROFILE:
					categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					returnStatus = ReportProfileHelper.deleteReportProfile(request, response);
					userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
					menuItem = IviewMenuBean.getIviewMenu(userLevel,categoryId);
					session.setAttribute("menudata",menuItem);
					response.sendRedirect(request.getContextPath()+"/webpages/reportprofile.jsp?appmode="+mode+"&status="+returnStatus);
					break;	
				case ApplicationModes.UPDATE_CONFIGURATION:
					returnStatus = -1;
					//String strLanguageId = request.getParameter("languageid");
					String strSMTPServerIP = request.getParameter("serverip");
					String strSMTPServerPort = request.getParameter("serverport");
					String strMailDispName = request.getParameter("dispname");
					String strEmailAddress = request.getParameter("fromemail");
					String strSMTPAuthFlag = request.getParameter("smtpAuth");
					String strMailUsername = request.getParameter("username");
					String strMailPassword = request.getParameter("password");
					
					returnStatus=iViewConfigBean.updateRecord(iViewConfigBean.MAILSERVERHOST, strSMTPServerIP);
					returnStatus=iViewConfigBean.updateRecord(iViewConfigBean.MAILSERVERPORT, strSMTPServerPort);
					if(strMailDispName == null || "null".equalsIgnoreCase(strMailDispName)){
						strMailDispName = "";
					}
					returnStatus=iViewConfigBean.updateRecord(iViewConfigBean.MAIL_ADMIN_NAME, strMailDispName);
					returnStatus=iViewConfigBean.updateRecord(iViewConfigBean.MAIL_ADMIN_ID, strEmailAddress);
					if(strSMTPAuthFlag == null || "null".equalsIgnoreCase(strSMTPAuthFlag) || "".equalsIgnoreCase(strSMTPAuthFlag)){
						strSMTPAuthFlag = "0";
						strMailUsername = "";
						strMailPassword = "";
					} else {
						strSMTPAuthFlag = "1";
					}
					returnStatus=iViewConfigBean.updateRecord(iViewConfigBean.AUTHENTICATIONFLAG, strSMTPAuthFlag);
					returnStatus=iViewConfigBean.updateRecord(iViewConfigBean.MAILSERVERUSERNAME, strMailUsername);
					returnStatus=iViewConfigBean.updateRecord(iViewConfigBean.MAILSERVERPASSWORD, strMailPassword);
					if(returnStatus > 0){
						if("0".equalsIgnoreCase(strSMTPAuthFlag)){
							AuditLog.mail.info("SMTP server IP:Port " + strSMTPServerIP + ":" + strSMTPServerPort + " has been set", request);
						} else {
							AuditLog.mail.info("SMTP server IP:Port " + strSMTPServerIP + ":" + strSMTPServerPort + " with username " + strMailUsername + " has been set", request);
						}
					} else {
						if("0".equalsIgnoreCase(strSMTPAuthFlag)){
							AuditLog.mail.critical("SMTP server IP:Port " + strSMTPServerIP + ":" + strSMTPServerPort + " setting faild", request);
						} else {
							AuditLog.mail.critical("SMTP server IP:Port " + strSMTPServerIP + ":" + strSMTPServerPort + " with username " + strMailUsername + " setting faild", request);
						}
					}
					response.sendRedirect(request.getContextPath()+"/webpages/iviewconfig.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.MANAGE_DEVICE:
					returnStatus = -1;
					int oldStatus = -1;
					int oldType=-1;
					String deviceIdList = request.getParameter("deviceidlist");
					boolean rewriteFile=false;
					DeviceBean deviceBean=null;
					if(deviceIdList!=null && !"".equalsIgnoreCase(deviceIdList) && !"null".equalsIgnoreCase(deviceIdList)){
						String[] arrDeviceList = null;
						arrDeviceList = deviceIdList.split(",");
						StringBuffer deviceNames = new StringBuffer("");
						for(int i=0; i<arrDeviceList.length; i++){
							deviceBean = DeviceBean.getSQLRecordByPrimaryKey(Integer.parseInt(arrDeviceList[i]));
							oldStatus = deviceBean.getDeviceStatus();
							oldType=deviceBean.getDeviceType();
							deviceBean.setDeviceStatus(Integer.parseInt(request.getParameter("devicestatus" + arrDeviceList[i])));
							
							
							if(request.getParameter("devicetype"+arrDeviceList[i])!=null){
								deviceBean.setDeviceType(Integer.parseInt(request.getParameter("devicetype" + arrDeviceList[i])));
							}
							if(request.getParameter("devicename" + arrDeviceList[i]) != null && !"".equalsIgnoreCase(request.getParameter("devicename" + arrDeviceList[i]))){
								deviceBean.setName(request.getParameter("devicename" + arrDeviceList[i]));
							}
							CyberoamLogger.appLog.debug("CRController->Manage Device->DeviceBean:"+i+": " + deviceBean.toString());
							returnStatus = deviceBean.updateRecord();
							if(returnStatus<0){
								AuditLog.device.error("Device update for " + deviceBean.getName() + " failed.", request);
								response.sendRedirect(request.getContextPath() + "/webpages/managedevice.jsp?appmode="+mode+"&status="+returnStatus);
								return;
							}
							deviceNames.append(deviceBean.getName()+",");
							if((deviceBean.getDeviceStatus()==DeviceBean.ACTIVE || deviceBean.getDeviceStatus()==DeviceBean.DEACTIVE) &&
									(oldStatus != deviceBean.getDeviceStatus() || oldType != deviceBean.getDeviceType())){
								deviceNames.append(deviceBean.getName()+",");
								rewriteFile=true;
							}
						}
						if(deviceNames.length()>0 && deviceNames.lastIndexOf(",")==deviceNames.length()-1){
							AuditLog.device.info("Device Status for " + deviceNames.substring(0, deviceNames.length()-1) + " updated.", request);
						} else {
							AuditLog.device.info("Device Status for " + deviceNames + " updated.", request);							
						}
					} else {
						String deviceid = request.getParameter("deviceid");
						String deviceType=null;
						deviceType=request.getParameter("devicetype");
						if(deviceid!=null || !deviceid.equalsIgnoreCase("")){
							deviceBean = DeviceBean.getSQLRecordByPrimaryKey(Integer.parseInt(deviceid));
							oldStatus = deviceBean.getDeviceStatus();
							oldType=deviceBean.getDeviceType();
							deviceBean.setName(request.getParameter("devicename"));
							deviceBean.setDescription(request.getParameter("description"));
							deviceBean.setIp(request.getParameter("ip"));
							deviceBean.setDeviceStatus(Integer.parseInt(request.getParameter("devicestatus")));
							
							if(deviceType!=null){
								deviceBean.setDeviceType(Integer.parseInt(deviceType));
							}
							CyberoamLogger.appLog.debug("CRController->Manage Device->DeviceBean : " + deviceBean.toString());
							returnStatus = deviceBean.updateRecord();
							if(returnStatus<0){
								AuditLog.device.error("Device update for " + deviceBean.getName() + " failed.", request);
								response.sendRedirect(request.getContextPath() + "/webpages/managedevice.jsp?appmode="+mode+"&status="+returnStatus);
								return;
							}
							AuditLog.device.info("Device " + deviceBean.getName() + " updated.", request);
							if(returnStatus>0 && (deviceBean.getDeviceStatus()==DeviceBean.ACTIVE || deviceBean.getDeviceStatus()==DeviceBean.DEACTIVE) 
									&& (oldStatus != deviceBean.getDeviceStatus() || oldType != deviceBean.getDeviceType())){
								rewriteFile=true;
							}
						}	
					}
					if(rewriteFile){
						returnStatus=DeviceBean.writeActiveFile();
						returnStatus=DeviceBean.writeInActiveFile();
						returnStatus=DeviceBean.writeIPAddressFile();
						GarnerManager.restart();						
					}
					deviceBean.clearNewDeviceBeanList();
					response.sendRedirect(request.getContextPath() + "/webpages/managedevice.jsp?appmode="+mode+"&status="+returnStatus);
					break;	
				case ApplicationModes.NEW_DEVICE:
					returnStatus = -1;
					String applianceID = request.getParameter("applianceid");
					String devicename = request.getParameter("devicename");
					String description = request.getParameter("description");
					String devicestatus = request.getParameter("devicestatus");
					String ipAddress=request.getParameter("ip");
					String deviceType=request.getParameter("devicetype");
					deviceBean = new DeviceBean();
					deviceBean.setApplianceID(applianceID);
					deviceBean.setName(devicename);
					deviceBean.setIp(ipAddress);
					deviceBean.setDescription(description);
					deviceBean.setDeviceStatus(Integer.parseInt(devicestatus));
					deviceBean.setDeviceType(Integer.parseInt(deviceType));
					returnStatus =  deviceBean.insertRecord();
					if(returnStatus > 0){
						
						if(deviceBean.getDeviceStatus()==DeviceBean.ACTIVE){
							AuditLog.device.info("Active Device " + devicename + " is added.", request);
							returnStatus=DeviceBean.writeActiveFile();
							returnStatus=DeviceBean.writeIPAddressFile();
							GarnerManager.restart();
							if("-1".equalsIgnoreCase((String)session.getAttribute("devicelist"))){
								session.removeAttribute("appliancelist");
								session.removeAttribute("devicelist");
							}
								
						} else if(deviceBean.getDeviceStatus()==DeviceBean.DEACTIVE){
							AuditLog.device.info("Deactive Device " + devicename + " is added.", request);
							returnStatus=DeviceBean.writeInActiveFile();
							returnStatus=DeviceBean.writeIPAddressFile();
							GarnerManager.restart();
						}else {
							AuditLog.device.info("Device " + devicename + " is added.", request);
						}
					}
					response.sendRedirect(request.getContextPath() + "/webpages/managedevice.jsp?appmode="+mode+"&status="+returnStatus);
					break;	
				case ApplicationModes.DELETE_DEVICE:
					returnStatus = -1;
					String deviceIds[] = request.getParameterValues("select");
					String deviceList = "";
					int active=0,deactive=0;
					StringBuffer deviceNames=new StringBuffer("");
					for(int i=0;i<deviceIds.length;i++){
						deviceBean = DeviceBean.getSQLRecordByPrimaryKey(Integer.parseInt(deviceIds[i]));
						if(deviceBean.getDeviceStatus()==DeviceBean.ACTIVE)
							active =1;
						else
							deactive = 1;
						
						deviceList += deviceBean.getDeviceId()+ ",";
						deviceNames.append(deviceBean.getName() +",");
					}
					
					deviceList = deviceList.substring(0,deviceList.length()-1);
					returnStatus =  DeviceBean.deleteAllRecord(deviceList);
					if(returnStatus<0){
						AuditLog.device.error("Device(s) "  + deviceNames.subSequence(0,deviceNames.length() -1) + " are not deleted.", request);
						response.sendRedirect(request.getContextPath() + "/webpages/managedevice.jsp?appmode="+mode+"&status="+returnStatus);
						return;
					}
					AuditLog.device.info("Device(s) "  + deviceNames.subSequence(0,deviceNames.length() -1) + " are deleted.", request);
					if(active == 1) {
						returnStatus=DeviceBean.writeActiveFile();
						returnStatus=DeviceBean.writeIPAddressFile();
					}
					if(deactive == 1) {
						returnStatus=DeviceBean.writeInActiveFile();
						returnStatus=DeviceBean.writeIPAddressFile();
					}
					GarnerManager.restart();
					if(returnStatus > 0)
						returnStatus = deviceIds.length;
					response.sendRedirect(request.getContextPath() + "/webpages/managedevice.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.UPDATE_DATABASE_CONFIGURATION:
					int dbConfFlag=0;
					returnStatus = -1;
					
					String archieveLimit= request.getParameter("archieve_limit");
					returnStatus = DataBaseConfigBean.setDataArchive(archieveLimit);
					if(returnStatus > 0){
						if(DataBaseConfigBean.getValue(DataBaseConfigBean.ARHIEVE_DATA).equalsIgnoreCase("0"))
							AuditLog.data.info("Archieve Log configuration disabled", request);
						else if(DataBaseConfigBean.getValue(DataBaseConfigBean.ARHIEVE_DATA).equalsIgnoreCase("-1"))
							AuditLog.data.info("Archieve Log configuration set to forever", request);
						else
							AuditLog.data.info("Archieve Log configuration updated to " + archieveLimit + " days", request);
					}
					categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					if(categoryId==1)
					{
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_web").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_web"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_web",request.getParameter("MaxNoTables24hr_web"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
	
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_mail").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_mail"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_mail",request.getParameter("MaxNoTables24hr_mail"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
	
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_ftp").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_ftp"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_ftp",request.getParameter("MaxNoTables24hr_ftp"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
	
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_deniedweb").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_deniedweb"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_deniedweb",request.getParameter("MaxNoTables24hr_deniedweb"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
	
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_ips").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_ips"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_ips",request.getParameter("MaxNoTables24hr_ips"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
	
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_spam").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_spam"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_spam",request.getParameter("MaxNoTables24hr_spam"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
	
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_virus").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_virus"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_virus",request.getParameter("MaxNoTables24hr_virus"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
	
						if(!DataBaseConfigBean.getValue("MaxNoTables5min_event").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_event"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables5min_event",request.getParameter("MaxNoTables24hr_event"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
	
						if(!DataBaseConfigBean.getValue("MaxNoTables5min_vpn").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_vpn"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables5min_vpn",request.getParameter("MaxNoTables24hr_vpn"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}	
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_im").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_im"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_im",request.getParameter("MaxNoTables24hr_im"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables5min_iusg").equalsIgnoreCase(request.getParameter("MaxNoTables5min_iusg"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables5min_iusg",request.getParameter("MaxNoTables5min_iusg"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_accept_top_host_user_rules_protogroup_application").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_accept_top_host_user_rules_protogroup_application"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_accept_top_host_user_rules_protogroup_application",request.getParameter("MaxNoTables24hr_accept_top_host_user_rules_protogroup_application"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_blocked_deny").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_blocked_deny"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_blocked_deny",request.getParameter("MaxNoTables24hr_blocked_deny"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
					}
					else if(categoryId==2)
					{
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_fw").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_fw"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_fw",request.getParameter("MaxNoTables24hr_fw"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_webs").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_webs"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_webs",request.getParameter("MaxNoTables24hr_webs"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
					}
					else if(categoryId==3)
					{
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_usbc").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_usbc"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_usbc",request.getParameter("MaxNoTables24hr_usbc"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_webr").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_webr"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_webr",request.getParameter("MaxNoTables24hr_webr"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_update").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_update"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_update",request.getParameter("MaxNoTables24hr_update"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_flnt").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_flnt"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_flnt",request.getParameter("MaxNoTables24hr_flnt"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_apct").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_apct"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_apct",request.getParameter("MaxNoTables24hr_apct"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_mscan").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_mscan"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_mscan",request.getParameter("MaxNoTables24hr_mscan"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
					}
					else if(categoryId==4)
					{
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_apch").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_apch"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_apch",request.getParameter("MaxNoTables24hr_apch"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
					}
					else if(categoryId==5)
					{
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_netg").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_netg"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_netg",request.getParameter("MaxNoTables24hr_netg"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_netgdnd").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_netgdnd"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_netgdnd",request.getParameter("MaxNoTables24hr_netgdnd"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_netg_application").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_netg_application"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_netg_application",request.getParameter("MaxNoTables24hr_netg_application"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_netg_virus").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_netg_virus"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_netg_virus",request.getParameter("MaxNoTables24hr_netg_virus"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
						if(!DataBaseConfigBean.getValue("MaxNoTables24hr_netg_ips").equalsIgnoreCase(request.getParameter("MaxNoTables24hr_netg_ips"))){
							returnStatus=DataBaseConfigBean.setValue("MaxNoTables24hr_netg_ips",request.getParameter("MaxNoTables24hr_netg_ips"));
							if(returnStatus == -1){
								dbConfFlag=1;
							}
						}
					}
					if(dbConfFlag==1){
						returnStatus=-1;
					}
					response.sendRedirect(request.getContextPath()+"/webpages/configdatabase.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.ADD_MAIL_SCHEDULER:
					returnStatus = MailSchedulerHelper.addMailScheduler(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/mailscheduler.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.UPDATE_MAIL_SCHEDULER:
					returnStatus = MailSchedulerHelper.updateMailScheduler(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/mailscheduler.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.DELETE_MAIL_SCHEDULER:
					returnStatus = MailSchedulerHelper.deleteMailScheduler(request, response);
					response.sendRedirect(request.getContextPath()+"/webpages/mailscheduler.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.GET_AUDIT_LOGS:
					String XMLResponse = AuditLogHelper.generateXML(AuditLogHelper.getLogs(request));
					response.getWriter().write(XMLResponse);
					break;
				case ApplicationModes.NEW_DEVICE_GROUP:
					returnStatus = -1;
					String groupName = request.getParameter("grpname");
					description = request.getParameter("description");
					String strSelDevice = request.getParameter("selecteddevice").toString();
					CyberoamLogger.appLog.info("string:->"+strSelDevice);
					String strSelDevices[] = strSelDevice.split(",");
					int groupId = 0;
					DeviceGroupBean deviceGroupBean = new DeviceGroupBean();
					DeviceGroupRelationBean deviceGroupRelationBean = new DeviceGroupRelationBean();
					deviceGroupBean.setName(groupName);
					deviceGroupBean.setDescription(description);
					deviceGroupBean.setCategoryID(Integer.parseInt(request.getParameter("catId")));
					returnStatus = deviceGroupBean.insertRecord();					
					groupId = deviceGroupBean.getGroupID();
					if(returnStatus > 0) {						
						for(int i=0;i<strSelDevices.length;i++) {
							
							deviceGroupRelationBean = new DeviceGroupRelationBean();							
							deviceGroupRelationBean.setGroupID(groupId);
							deviceGroupRelationBean.setDeviceID(Integer.parseInt(strSelDevices[i]));							
							deviceGroupRelationBean.insertRecord();							
						}
						request.getSession().setAttribute("pmessage", "Device Group " + groupName + " is added.");
						AuditLog.device.info("Device Group " + groupName + " is added.", request);
					} else{						
						AuditLog.device.critical("Device Group "+ groupName + " add failed due to duplicate Device Group Name" , request);
						request.getSession().setAttribute("nmessage", "Device Group " + groupName + " is already exists.");
					}				

					response.sendRedirect(request.getContextPath()+"/webpages/managedevicegroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;
					
				case ApplicationModes.UPDATE_DEVICE_GROUP:
					returnStatus = -1;
					groupName = request.getParameter("grpname");
					description = request.getParameter("description");
					strSelDevice = request.getParameter("selecteddevice").toString();
					strSelDevices = strSelDevice.split(",");
					groupId = Integer.parseInt(request.getParameter("groupid"));;
					deviceGroupBean = DeviceGroupBean.getRecordbyPrimarykey(groupId);
					deviceGroupRelationBean = new DeviceGroupRelationBean();
					ArrayList deviceListArray = null;
					deviceGroupBean.setName(groupName);
					deviceGroupBean.setDescription(description);					
					returnStatus = deviceGroupBean.updateRecord();					
					if(returnStatus >= 0){
						deviceListArray = DeviceGroupRelationBean.getRelationByGroupID(groupId);						
						for(int i = 0;i< deviceListArray.size();i++) {
							deviceGroupRelationBean = (DeviceGroupRelationBean) deviceListArray.get(i);							
							deviceGroupRelationBean.deleteRecord();
						}
					}
					if(returnStatus >= 0) {						
						for(int i=0;i<strSelDevices.length;i++) {	
							deviceGroupRelationBean = new DeviceGroupRelationBean();
							deviceGroupRelationBean.setGroupID(groupId);
							deviceGroupRelationBean.setDeviceID(Integer.parseInt(strSelDevices[i]));
							deviceGroupRelationBean.insertRecord();
						}
						request.getSession().setAttribute("pmessage", "Device Group " + groupName + " is updated.");
						AuditLog.device.info("Device Group " + groupName + " is updated.", request);
					} 
					response.sendRedirect(request.getContextPath()+"/webpages/managedevicegroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;	
				case ApplicationModes.DELETE_DEVICE_GROUP:
					returnStatus = -1;
					int failedDeletion = 0;
					String deviceGroupIds[] = request.getParameterValues("devicegroupids");
					String deviceGroupList = "";
					
					for(int i=0;i<deviceGroupIds.length;i++){
						deviceGroupBean = DeviceGroupBean.getSQLRecordByPrimaryKey(Integer.parseInt(deviceGroupIds[i]));
						returnStatus = deviceGroupBean.deleteRecord();
						if(returnStatus==-4)
							failedDeletion++;
					}
					if((deviceGroupIds.length-failedDeletion)>0){
						request.getSession().setAttribute("pmessage", (deviceGroupIds.length-failedDeletion) +" Device Group(s) deleted.");
						AuditLog.device.info((deviceGroupIds.length-failedDeletion) +" Device Group(s) deleted.", request);	
					}
					if(failedDeletion>0){
						request.getSession().setAttribute("nmessage", failedDeletion +" Device Group(s) related with user.");
						AuditLog.device.error(" Deletion of "+failedDeletion+" Device Group(s) failed due to relation with user.", request);
					}
					response.sendRedirect(request.getContextPath()+"/webpages/managedevicegroup.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.SEND_TEST_MAIL:
					returnStatus = -1;
					CyberoamLogger.appLog.info("Sending Test Mail.");
					String strTestEmailAddress = request.getParameter("testEmail");
					strSMTPServerIP = request.getParameter("serverip");
					strSMTPServerPort = request.getParameter("serverport");
					strMailDispName = request.getParameter("dispname");
					strEmailAddress = request.getParameter("fromemail");
					strSMTPAuthFlag = request.getParameter("smtpAuth");
					strMailUsername = request.getParameter("username");
					strMailPassword = request.getParameter("password");
					String strSubject = "Test mail from iView";
					String strMsgBody = "This is a test mail generated by iView for testing <b>\"Mail Configuration\"</b> feature.<br/>" +
										"Please do not reply to this email.";
					if(strSMTPAuthFlag == null || "null".equalsIgnoreCase(strSMTPAuthFlag) || "".equalsIgnoreCase(strSMTPAuthFlag)){
						strSMTPAuthFlag = "0";
						strMailUsername = "";
						strMailPassword = "";
					} else {
						strSMTPAuthFlag = "1";
					}
					session.setAttribute("testConfig", strSMTPServerIP+","+strSMTPServerPort+","+strEmailAddress+","+strSMTPAuthFlag+","+strMailDispName+","+strMailUsername);
					MailSender mailSender = new MailSender(strSMTPServerIP, strSMTPServerPort, strEmailAddress, strTestEmailAddress, strSubject, strMsgBody, strSMTPAuthFlag, strMailUsername, strMailPassword);
					mailSender.setSmtpDisplayName(strMailDispName);
					returnStatus = mailSender.send();
					response.sendRedirect(request.getContextPath()+"/webpages/iviewconfig.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.WARMFILE_UNLOAD_REQUEST:					
					String dayStr=request.getParameter("daystr");
					CyberoamLogger.sysLog.info("Request for UnLoad: " + dayStr);
					CyberoamLogger.sysLog.info("App List from Session: -- > " + session.getAttribute("appliancelist"));
					if(session.getAttribute("appliancelist")!=null && dayStr!=null && request.getParameter("getstatus")==null){
						CyberoamLogger.sysLog.info("Calling Method");
						String appIdList=session.getAttribute("appliancelist").toString();
						String categoryID = (String)session.getAttribute("categoryid");
						WarmFilesRotation.startThread(appIdList, dayStr, categoryID, response);
					}else if(request.getParameter("getstatus")!=null){
						CyberoamLogger.sysLog.info("Ajax Status Request");
						WarmFilesRotation.getTaskStatus(response);
					}
					break;
				case ApplicationModes.ARCHIEVE_BACKUP_REQUEST:
					BackupDataHandler.process(request, response);
					break;
				case ApplicationModes.ARCHIEVE_RESTORE_REQUEST:
					RestoreDataHandler.process(request, response);					
					break;	
				case ApplicationModes.WARMFILE_UNLOAD_ALL:		
					String categoryID = (String)session.getAttribute("categoryid");;
					WarmFilesRotation.unLoadAll(categoryID);
					response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?statusCheck=1");
					break;
				case ApplicationModes.CATEGORY_CHANGE:				
					session.setAttribute("devicelist", null);	
					session.setAttribute("isdevicegroup",null);
					session.setAttribute("categoryid", request.getParameter("categoryid"));
					categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
					menuItem = IviewMenuBean.getIviewMenu(userLevel,categoryId);
					session.setAttribute("menudata",menuItem);
					response.sendRedirect(request.getContextPath()+"/webpages/maindashboard.jsp?empty=1_1");
					break;
				case ApplicationModes.NEWBOOKMARK:
					BookmarkHelper.process(request, response);
					categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
					menuItem = IviewMenuBean.getIviewMenu(userLevel,categoryId);
					session.setAttribute("menudata",menuItem);
					break;
				case ApplicationModes.DELETE_BOOKMARK:
					BookmarkHelper.process(request, response);
					categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
					menuItem = IviewMenuBean.getIviewMenu(userLevel,categoryId);
					session.setAttribute("menudata",menuItem);
					break;
				case ApplicationModes.NEWBOOKMARKGROUP:
					BookmarkGroupHelper.process(request, response);
					categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
					menuItem = IviewMenuBean.getIviewMenu(userLevel,categoryId);
					session.setAttribute("menudata",menuItem);
					break;
				case ApplicationModes.DELETE_BOOKMARK_GROUP:
					BookmarkGroupHelper.process(request, response);
					categoryId=Integer.parseInt(session.getAttribute("categoryid").toString());
					userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
					menuItem = IviewMenuBean.getIviewMenu(userLevel,categoryId);
					session.setAttribute("menudata",menuItem);
					break;
				case ApplicationModes.CHECKSUM_REQUEST:
					returnStatus=-1;
					String strdhcpchecksumval=request.getParameter("dhcpchecksum");
					String strarchivechecksumval=request.getParameter("webusagechecksum");
					returnStatus=iViewConfigBean.updateRecord("dhcpchecksumval",strdhcpchecksumval);
					returnStatus=iViewConfigBean.updateRecord("webusagechecksumval",strarchivechecksumval);
					GarnerManager.restart();
					response.sendRedirect(request.getContextPath()+"/webpages/Checksum.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.GARNER_PORT_CHANGE:
					returnStatus=-1;
					
					String portval=request.getParameter("garnerport");
					if(!(iViewConfigBean.getValueByKey("GarnerPort").equals(request.getParameter("garnerport")))){
						try{
						returnStatus=UdpPacketCapture.checkudpport(portval);
						}catch(Exception e)
						{
							returnStatus=-2;
						}
						if(returnStatus!=-2){
						  returnStatus=iViewConfigBean.updateRecord("GarnerPort",portval);
						  GarnerManager.restart();
						}
					}			
					else
						returnStatus=1;					
					response.sendRedirect(request.getContextPath()+"/webpages/garnerport.jsp?appmode="+mode+"&status="+returnStatus);
					break;	
				case ApplicationModes.SCHEDULE_BACKUP:
					returnStatus=-1;
					int flag=0;
					String ftpusername=null,ftppassword=null,ftpserver=null,backupfreq=null;
					ftpusername=request.getParameter("ftpusername");
					ftppassword=request.getParameter("ftppassword");
					ftpserver  =request.getParameter("ftpserverip");
					backupfreq =request.getParameter("backupfreq");
					iViewConfigBean.updateRecord(iViewConfigBean.SCHEDULED_BACKUP_FREQUENCY,backupfreq);
					if("-1".equals(backupfreq)){
						flag=1;
						ftpusername="";
						ftppassword="";
						ftpserver="";
						flag=1;
						returnStatus=1;
					}else{
					  if(ftpusername!=null && ftppassword!=null && ftpserver !=null){
						  FTPFileManager ftp=new FTPFileManager();
						 returnStatus=ftp.login(ftpusername, ftppassword, ftpserver, true);
					  }
					  if(returnStatus>0){
					    returnStatus=1;
					    flag=1;
					  }
					}	  
						if(flag==1){
						  iViewConfigBean.updateRecord(iViewConfigBean.FTP_USERNAME,ftpusername);
						  iViewConfigBean.updateRecord(iViewConfigBean.FTP_PASSWORD,ftppassword);
						  iViewConfigBean.updateRecord(iViewConfigBean.FTP_SERVERIP,ftpserver);
						}					  	  
					ScheduleBackupThread.startBackupThread();
					response.sendRedirect(request.getContextPath()+"/webpages/schedulebackuprestore.jsp?appmode="+mode+"&status="+returnStatus);
					break;
				case ApplicationModes.RESTORE_REQUEST:
					String startDate=request.getParameter("startdate");
					String endDate=request.getParameter("enddate");
					
					String ftpuname=null,ftppwd=null,ftpserver1=null,backupfreq1=null; 
					ftpuname=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_USERNAME);
					ftppwd=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_PASSWORD);
					ftpserver1=iViewConfigBean.getValueByKey(iViewConfigBean.FTP_SERVERIP);
					backupfreq1=iViewConfigBean.getValueByKey(iViewConfigBean.SCHEDULED_BACKUP_FREQUENCY);
					if("1".equals(backupfreq1)){
						if(!"".equals(ftpuname)&& !"".equals(ftppwd)&& !"".equals(ftpserver1)){	
							if(startDate != null && endDate !=null){
								startDate=startDate.replaceAll("-","");
								endDate=endDate.replaceAll("-","");
								RestoreHandler.process(request, response, startDate, endDate);
							//if(returnStatus >0){
							//	CyberoamLogger.appLog.debug("iViewController Restore successfully done ");
							//}
							//}else{
							//	returnStatus=-1;
							//}
							}else{
								returnStatus=-7;
							}
					   }
					}else{
						returnStatus=-7;
						response.sendRedirect(request.getContextPath()+"/webpages/schedulebackuprestore.jsp?appmode="+mode+"&status="+returnStatus);
					}				
					break;	
					
				default:
					System.out.println("Default Mode");
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("CRController.doPost.e:" + e,e );
		}
	}
} 

