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

package org.cyberoam.iview.authentication.helper;


import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.authentication.beans.RoleBean;
import org.cyberoam.iview.authentication.beans.UserBean;
import org.cyberoam.iview.authentication.modes.AuthConstants;

/**
 * This helper class is used for serving login requests of user.
 * @author Narendra Shah
 *
 */
public class LoginHelper {
	
	/**
	 * Processes login request of user.
	 * @param request - HTTP request entity
	 * @param response - HTTP response entity
	 */
	public static void process(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession httpSession = request.getSession();
			String strUserName = request.getParameter("username");
			String strPassword = request.getParameter("password");
			if(strUserName != null){
				UserBean userBean =null;
				try {
					userBean = UserBean.authenticate(strUserName, strPassword);
				}catch (Exception e) {
					AuditLog.user.critical("User " + strUserName + " not authenticated due to database connection error", request);
					/** 
					 * Considering that if this exception occurs then database connection not found.
					 * It can be changed if needed.
					 */
					response.sendRedirect(request.getContextPath() + "/webpages/login.jsp?status=" + AuthConstants.DB_CONNECTION_FAILED);
				}
				if (userBean == null) {
					AuditLog.user.notice("User " + strUserName + " login failed", request);
					response.sendRedirect(request.getContextPath() + "/webpages/login.jsp?status=" + AuthConstants.LOGIN_FAILED);
				} else {
					Calendar today = Calendar.getInstance();
					int month=today.get(Calendar.MONTH)+1;
					int day=today.get(Calendar.DAY_OF_MONTH);
					String strmonth=null,strday=null;
					if(month < 10){
						strmonth="0"+Integer.toString(month);
					}else{
						strmonth=Integer.toString(month);
					}
					if(day < 10){
						strday="0"+Integer.toString(day);
					}else{
						strday=Integer.toString(day);
					}
					String strStartDate = today.get(Calendar.YEAR) + "-" + strmonth + "-" +strday+ " 00:00:00";
					
					String strEndDate = today.get(Calendar.YEAR) + "-" + strmonth + "-" +strday+ " 23:59:59";
					
					httpSession.setAttribute("username", userBean.getUserName());
					httpSession.setAttribute("roleid", new Integer(userBean.getRoleId()));
					httpSession.setAttribute("startdate", strStartDate);
					httpSession.setAttribute("enddate",strEndDate);
					httpSession.setAttribute("limit","5");
					//Default UTM devices are selected so categoryid is set to 1,1 is of UTM devices
					httpSession.setAttribute("categoryid","1");
					httpSession.setAttribute("bodyWidth", request.getParameter("bodyWidth"));
					AuditLog.user.info("User " + strUserName + " login successful", request);
					
					/*
					 * Appliace List is set from date.jsp
					 */
					
					userBean.updateLoginTime(userBean.getUserId(), new Date());
					/*if(DeviceBean.checkForNewDevice() > 0 && userBean.getRoleId() == RoleBean.SUPER_ADMIN_ROLE_ID  ){
						response.sendRedirect(request.getContextPath() + "/webpages/managedevice.jsp?alldevice=false");
					}*/
					response.sendRedirect(request.getContextPath() + "/webpages/maindashboard.jsp?empty=1_1");
				}
			}else{
				response.sendRedirect(request.getContextPath() + "/webpages/login.jsp?status=" + AuthConstants.LOGIN_FAILED);
			}
		} catch (Exception e) {
			CyberoamLogger.appLog.debug("Exception LoginHelper.process->" + e,e);
		}
	}
}
