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

import java.util.Properties;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Category;
import org.apache.log4j.PropertyConfigurator;
  
/**
 * This class is used for logging different events into log files.
 * This class uses log4j API.
 * @author Narendra Shah
 *
 */
public class CyberoamLogger {

	/**
	 * For general log.
	 */
	public static Category genLog = Category.getInstance(CyberoamLogger.class.getName());
	/**
	 * For application log.
	 */
	public static Category appLog = Category.getInstance(CyberoamLogger.class.getName() + ".APPLOG");
	/**
	 * For system log.
	 */
	public static Category sysLog = Category.getInstance(CyberoamLogger.class.getName() + ".SYSLOG");
	/**
	 * For registration log.
	 */
	public static Category regLog = Category.getInstance(CyberoamLogger.class.getName() + ".REGLOG");
	/**
	 * For report log.
	 */
	public static Category repLog = Category.getInstance(CyberoamLogger.class.getName() + ".REPLOG");
	/**
	 * For server log.
	 */
	public static Category sqlLog = Category.getInstance(CyberoamLogger.class.getName() + ".SQLLOG");
	/**
	 * For audit log.
	 */
	public static Category auditlog = Category.getInstance(CyberoamLogger.class.getName() + ".AUDITLOG");
	
	/**
	 * For connection pool log.
	 */
	public static Category connectionPoolLog = Category.getInstance(CyberoamLogger.class.getName() + ".CONNECTIONPOOLLOG");
	
	static {
		try{
			BasicConfigurator.configure();
			Properties properties = new Properties();
			properties.load((new CyberoamLogger()).getClass().getClassLoader().getResourceAsStream("cyberoamlogger.properties"));
			PropertyConfigurator.configure(properties);
			
			CyberoamLogger.appLog.setAdditivity(false);
			CyberoamLogger.sysLog.setAdditivity(false);
			CyberoamLogger.regLog.setAdditivity(false);
			CyberoamLogger.repLog.setAdditivity(false);
			CyberoamLogger.sqlLog.setAdditivity(false);
			CyberoamLogger.auditlog.setAdditivity(false);
			CyberoamLogger.connectionPoolLog.setAdditivity(false);
			
			
			CyberoamLogger.genLog.info("This is general log");
			CyberoamLogger.appLog.info("This is application log");
			CyberoamLogger.sysLog.info("This is system log");
			CyberoamLogger.regLog.info("This is registration log");
			CyberoamLogger.repLog.info("This is report log");
			CyberoamLogger.sqlLog.info("This is SQL query log");
			CyberoamLogger.auditlog.info("This is audit log");
			CyberoamLogger.connectionPoolLog.info("This is connnection pool log");
		}catch(Exception e){
			System.out.println("Exception in intializing logger: " + e);
			e.printStackTrace();			
		}
	}	
}
