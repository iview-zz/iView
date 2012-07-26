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


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.RoleBean;
import org.cyberoam.iview.authentication.beans.UserBean;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import org.cyberoam.iview.modes.ApplicationModes;

/**
 * Helper class for user insert update and delete.
 * @author Narendra Shah
 */
public class UserHelper {
	 
	/**
	 * Process given request and provide response for Insert, Update or Delete of user.
	 * Here request must contain appmode parameter as process flag.
	 * <br>Process flags are as follows.
	 * <u>
	 * <li>ApplicationModes.NEWUSER</li>
	 * <li>ApplicationModes.UPDATEUSER</li>
	 * <li>ApplicationModes.DELETEUSER</li>
	 * </u> 
	 * @param request
	 * @param response
	 */
	public static void process(HttpServletRequest request, HttpServletResponse response){
		int iAppMode = Integer.parseInt(request.getParameter("appmode"));
		UserBean userBean = null;
		String strName = null;
		String strEmail = null;
		String strUserName = null;
		switch(iAppMode){
		/**
		 * New User Creation event
		 */
		case ApplicationModes.NEWUSER:
			strName = request.getParameter("name");
			strUserName = request.getParameter("username");
			String strPassword = request.getParameter("passwd");
			strEmail = request.getParameter("email");
			int iRoleId = Integer.parseInt(request.getParameter("role"));
			String strSelDevice = request.getParameter("selecteddevices").toString();
			String retioFlag = request.getParameter("ratiodevicelist").toString();			
			String strSelDevices[] = strSelDevice.split(",");
			String strCreatedBy = request.getSession().getAttribute("username").toString();
			userBean = new UserBean();
			try{
				userBean.setName(strName);
				userBean.setUserName(strUserName);
				userBean.setPassword(strPassword);
				userBean.setEmail(strEmail);
				userBean.setRoleId(iRoleId);
				userBean.setCreatedBy(strCreatedBy);
				
				int retStatus = userBean.insertRecord();
				CyberoamLogger.appLog.debug("NewUserHelper.process retStatus ->" + retStatus);
				if(retStatus > 0){
					AuditLog.user.info("User "+ strUserName + " added successfully" , request);					
					UserCategoryDeviceRelBean userCategoryDeviceRelBean = null;						
					userCategoryDeviceRelBean = new UserCategoryDeviceRelBean();
						
					if("Device|1|0".equals(retioFlag)) {
						userCategoryDeviceRelBean.setDeviceId(strSelDevice);
						userCategoryDeviceRelBean.setDeviceGroupId("");
					} else if ("Device Group|1|0".equals(retioFlag)) {
						userCategoryDeviceRelBean.setDeviceId("");
						userCategoryDeviceRelBean.setDeviceGroupId(strSelDevice);						
					}
					userCategoryDeviceRelBean.setUserId(userBean.getUserId());
					userCategoryDeviceRelBean.insertRecordForUserId();					
					request.getSession().setAttribute("pmessage", "User " + userBean.getUserName()+ " has been created successfully.");
				}
				else{
					AuditLog.user.critical("User "+ strUserName + " add failed due to duplicate user name" , request);
					request.getSession().setAttribute("nmessage", "User with same name is already exists.");
				}
				response.sendRedirect(request.getContextPath() + "/webpages/manageuser.jsp");			
			}
			catch(Exception e){
				CyberoamLogger.appLog.debug("Exception in NewUserHelper.process()" + e,e);
			}		
			break;
		/**
		 * Delete User(s) event
		 */
		case ApplicationModes.DELETEUSER:
			try{
				String[] strUserNames = request.getParameterValues("usernames");
				userBean = null;
				int iRetStatus;
				int iUserDeleted = 0;
				for(int iIndex=0;iIndex< strUserNames.length;iIndex++){
					userBean = UserBean.getRecordbyPrimarykey(strUserNames[iIndex]);
					if(!userBean.getUserName().equals(request.getSession().getAttribute("username").toString())){
						iRetStatus = userBean.deleteRecord();
						if(iRetStatus > 0){
							AuditLog.user.info("User "+ strUserNames[iIndex] + " deleted successfully" , request);
						}else {
							AuditLog.user.critical("User "+ strUserNames[iIndex] + " delete failed" , request);
						}
							
						CyberoamLogger.appLog.debug("iRetStauts Delete User -> " + iRetStatus);
						if(iRetStatus != -1){
							iUserDeleted++;
						}
					}
				}
				request.getSession().setAttribute("pmessage", iUserDeleted + " Users Delete Successfully.");
				response.sendRedirect(request.getContextPath() + "/webpages/manageuser.jsp");
			}
			catch(Exception e){
				CyberoamLogger.appLog.debug("Exception in UserHelper.delete " + e,e);
			}
			break;
			
		/**
		 * User update event
		 */			
		case ApplicationModes.UPDATEUSER:
			try{
				strUserName = request.getParameter("username");
				
				strName = request.getParameter("name");
				strEmail = request.getParameter("email");
				strPassword = request.getParameter("passwd");
				iRoleId = Integer.parseInt(request.getParameter("role"));
				strSelDevice = request.getParameter("selecteddevices").toString();
				retioFlag = request.getParameter("ratiodevicelist").toString();
				String strNewSelDevices[] = strSelDevice.split(",");
				userBean = UserBean.getRecordbyPrimarykey(strUserName);
				if(userBean != null){
					UserCategoryDeviceRelBean userCategoryDeviceRelBean = null;

					if(RoleBean.SUPER_ADMIN_ROLE_ID != userBean.getRoleId()){
						UserCategoryDeviceRelBean.deleteRecordForUserId(userBean.getUserId());
					}
					userBean.setName(strName);
					userBean.setEmail(strEmail);
					if(strPassword!=null && !"".equalsIgnoreCase(strPassword)){
						userBean.setPassword(strPassword);
					}
					userBean.setRoleId(iRoleId);
					if(userBean.updateRecord() > 0){
						userCategoryDeviceRelBean = new UserCategoryDeviceRelBean();
						if(RoleBean.SUPER_ADMIN_ROLE_ID != userBean.getRoleId()){
							if("Device|1|0".equals(retioFlag)) {
								userCategoryDeviceRelBean.setDeviceId(strSelDevice);
								userCategoryDeviceRelBean.setDeviceGroupId("");
							} else if ("Device Group|1|0".equals(retioFlag)) {
								userCategoryDeviceRelBean.setDeviceId("");
								userCategoryDeviceRelBean.setDeviceGroupId(strSelDevice);																
							}
							userCategoryDeviceRelBean.setUserId(userBean.getUserId());
							userCategoryDeviceRelBean.insertRecordForUserId();
						}
						AuditLog.user.info("User "+ strName + " updated successfully" , request);
						request.getSession().setAttribute("pmessage", "User " + userBean.getUserName()+ " has been updated successfully.");
					}else{
						AuditLog.user.critical("User "+ strName + " update failed" , request);
						request.getSession().setAttribute("pmessage", "User "  + strName +" has not been updated.");
					}				
				}
				response.sendRedirect(request.getContextPath() + "/webpages/manageuser.jsp");
			}
			catch(Exception e){
				CyberoamLogger.appLog.debug("Exception in UserHelper.update -> " + e,e);
			}
			break;
		}
	}
}
