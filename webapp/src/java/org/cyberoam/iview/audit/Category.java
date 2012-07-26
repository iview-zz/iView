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

package org.cyberoam.iview.audit;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This class provides facility to audit log iView operations.
 * @author Narendra Shah
 *  
 */

public class Category{
	
	/**
	 * Severity constant for emergency events.
	 */
	public static final int EMERGENCY = 0;
	/**
	 * Severity constant for alerts.
	 */
	public static final int ALERT = 1;
	/**
	 * Severity constant for critical events.
	 */
	public static final int CRITICAL = 2;
	/**
	 * Severity constant for errors.
	 */
	public static final int ERROR = 3;
	/**
	 * Severity constant for warnings.
	 */
	public static final int WARNING = 4;
	/**
	 * Severity constant for notices.
	 */
	public static final int NOTICE = 5;
	/**
	 * Severity constant for informative messages.
	 */
	public static final int INFO = 6;
	/**
	 * Severity constant for events that can be debug.
	 */
	public static final int DEBUG = 7;
	
	
	/**
	 * Define the category value for audit log entity
	 */
	private final int category;
	/**
	 * Define the category value for audit log entity. 
	 * @param category
	 */
	public Category(int category){
		this.category=category;
	}
	/**
	 * Log as emergency event.
	 * @param message Audit message 
	 * @param request used for getting usernmae and ipaddress of client user.
	 */
	public void emergency(String message,HttpServletRequest request){
		this.log(EMERGENCY,message, request);
	}
	/**
	 * Log as alert. 
	 * @param message Audit message 
	 * @param request used for getting usernmae and ipaddress of client user.
	 */
	public void alert(String message,HttpServletRequest request){
		this.log(ALERT,message, request);
	}
	/**
	 * Log as critical event. 
	 * @param message Audit message 
	 * @param request used for getting usernmae and ipaddress of client user.
	 */
	public void critical(String message,HttpServletRequest request){
		this.log(CRITICAL,message, request);
	}
	/**
	 * Log as error.
	 * @param message Audit message 
	 * @param request used for getting usernmae and ipaddress of client user.
	 */
	public void error(String message,HttpServletRequest request){
		this.log(ERROR,message, request);
	}
	/**
	 * Log as warning. 
	 * @param message Audit message 
	 * @param request used for getting usernmae and ipaddress of client user.
	 */
	public void warning(String message,HttpServletRequest request){
		this.log(WARNING,message, request);
	}
	/**
	 * Log as notice. 
	 * @param message Audit message 
	 * @param request used for getting usernmae and ipaddress of client user.
	 */
	public void notice(String message,HttpServletRequest request){
		this.log(NOTICE,message, request);
	}
	/**
	 * Log as informative message. 
	 * @param message Audit message 
	 * @param request used for getting usernmae and ipaddress of client user.
	 */
	public void info(String message,HttpServletRequest request){
		this.log(INFO,message, request);
	}
	/**
	 * Log as debug. 
	 * @param message Audit message 
	 * @param request used for getting usernmae and ipaddress of client user.
	 */
	public void debug(String message,HttpServletRequest request){
		this.log(DEBUG,message, request);
	}
	/**
	 * Log the given parameter in audit log database.
	 * @param severity
	 * @param message
	 * @param request
	 */
	private void log(int severity,String message,HttpServletRequest request){
		String userName="NA";
		String ipAddress="NA";
		if(request != null ){
			if(request.getSession(false) != null ){
				userName=(String)request.getSession(false).getAttribute("username");
				if("".equalsIgnoreCase(userName) || "null".equalsIgnoreCase(userName) || userName == null){
					userName="NA";
				}
			}
			ipAddress=request.getRemoteAddr();			
		}
		SqlReader sqlReader = null;
		String insertQuery=null;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try{
            sqlReader = new SqlReader(false);
            
            insertQuery = "insert into tblauditlog " +
            	"(actiontime,message,severity,username,ipaddress,categoryid) values (" +
            	StringMaker.makeString(simpleDateFormat.format(Calendar.getInstance().getTime())) + "," +
            	StringMaker.makeString(message) + "," + 
            	severity + "," +
            	StringMaker.makeString(userName) + "," + 
            	StringMaker.makeString(ipAddress) +  "," +
            	category + ")";
            
            
            sqlReader.executeInsertWithLastid(insertQuery,"logid");
        }catch(Exception e){
            CyberoamLogger.sysLog.error("MailScheduleBean.e:" + e,e);
        }finally{
                sqlReader.close();
            
        }
	}
}
