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

package org.cyberoam.iview.utility;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.ApplicationBean;
import org.cyberoam.iview.authentication.beans.RoleBean;


/***
 * This class checks the session of the user and also check whether he/she is
 * allowed to see the page from where the checkSession method is called
 * @author narendrashah
 *
 */
public class CheckSession {
	
	/***
	 * This method checks the session of user and also check wether he/she
	 * is allowed to see the page.
	 * 
	 * @param request - Request object of HttpServletRequest
	 * @param response - Response object of HttpServletResponse
	 * @throws IOException
	 * @throws ServletException
	 */
	public static int checkSession(HttpServletRequest request,HttpServletResponse response){
		try {			
			HttpSession httpSession = request.getSession(false);
			if(httpSession == null){
				//System.out.println("httpSession is null");
				response.sendRedirect(request.getContextPath() + "/webpages/login.jsp");
				return -1;
			}
			String userName =(String) httpSession.getAttribute("username");
			Integer iRoleId = (Integer)httpSession.getAttribute("roleid");
			
			String jspName = getApplicationName(request.getRequestURI());
			
			RoleBean userRoleBean = null;
			RoleBean appRoleBean = null;
			ApplicationBean appBean = null;
			
			//Checking User Session
			if(userName == null){
				//System.out.println("username is null");
				AuditLog.views.critical("Unknown User has tried to access unauthorized page name " + jspName, request);
				//request.getRequestDispatcher(request.getContextPath() + "/webpages/login.jsp").forward(request,response);
				response.sendRedirect(request.getContextPath() + "/webpages/login.jsp");
				return -1;
			}
			
			userRoleBean = RoleBean.getRecordbyPrimarykey(iRoleId.intValue());
					
			appBean = ApplicationBean.getRecordByPrimaryKey(jspName);
			if(appBean != null){
				appRoleBean = RoleBean.getRecordbyPrimarykey(appBean.getRoleId());
				if(userRoleBean.getLevel() > appRoleBean.getLevel()){
					AuditLog.views.critical("User has tried access unauthorized page name " + jspName, request);
					response.sendRedirect(request.getContextPath() + "/webpages/accessdenied.jsp");
					return -1;
				}
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("CheckSession.checkSession :e =>" +e,e);
		}
		return 1;
	}
	
	/***
	 * This method returns name of jsp/servlet without parameters 
	 * @param strURI - URI of the page
	 * @return Name of JSP/Servlet
	 */
	private static String getApplicationName(String strURI){
		int iIndex = strURI.lastIndexOf("/");
		return(strURI.substring(iIndex+1));
	}
}
