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

package org.cyberoam.iview.beans;


import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;
import org.cyberoam.iview.search.IndexSearchBean;


/**
 * This class represents iView Configuration parameters.
 * @author Narendra Shah
 */
public class iViewConfigBean {
	/**
	 * General Configuration related to iView are stored in this bean and tbliviewconfig .
	 */
	private String keyName=null;
	private String value = null;
	private static TreeMap iviewConfigMap=new TreeMap();
	/*
	 * Please insert constant key name here when you insert query in tbliviewconfig.
	 */
	
	/**
	 * Title to be used on web page.
	 */
	public static String TITLE="iView";
	/**
	 * Language Id used for multiple language support.
	 */
	public static String LANGUAGE="languageid";
	/**
	 * IP address of SMTP mail server.
	 */
	public static final String MAILSERVERHOST = "MailServer";
	/**
	 * Port number used by SMTP mail server.
	 */
	public static final String MAILSERVERPORT = "MailServerPort";
	/**
	 * Flag to specify that SMTP authentication is required or not.
	 */
	public static final String AUTHENTICATIONFLAG = "SMTPAuthenticationFlag";
	/**
	 * User name to be used while communicating with SMTP mail server if authentication is required. 
	 */
	public static final String MAILSERVERUSERNAME = "MailServerUsername";
	/**
	 * Password to be used while communicating with SMTP mail server if authentication is required. 
	 */
	public static final String MAILSERVERPASSWORD = "MailServerPassword";
	/**
	 * From email address used while sending SMTP mail.
	 */
	public static final String MAIL_ADMIN_ID="MailAdminId";
	/**
	 * Name used with from email address used while sending SMTP mail.
	 */
	public static final String MAIL_ADMIN_NAME="MailAdminName";
	/**
	 * Archive Data Folder. 
	 */
	public static String ArchiveHome;
	/**
	 * iView Application Path.
	 */
	public static String iViewHome;
	/**
	 * Database home direcotory.
	 */
	public static String PostgresHome;
	/**
	 * Number of records to be kept into database for disk usage.
	 */
	public static final String NO_OF_DISK_USAGE_RECORD = "NoOfDiskUsageRecord";
	/**
	 * Sleep time for disk usage monitor.
	 */
	public static final String USAGE_MONITOR_SLEEP_TIME = "UsageMonitorSleepTime";
	/**
	 * Disk drive to be monitored.
	 */
	public static final String DISK_DRIVE = "DiskDrive";
	/**
	 * Percent of disk usage to be considered as low disk space.
	 */
	public static final String LOW_DISK_SPACE_PERCENT = "LowDiskSpacePercent";
	/**
	 * DHCP value to be enable or disable considered as dhcpchecksumval
	 */
	public static final String DHCP_CHECKSUM_VAL = "dhcpchecksumval";
	/**
	 * archive value to be enable or disable considered as webusagechecksumval.
	 */
	public static final String WEBUSAGE_CHECKSUM_VAL = "webusagechecksumval";
	/**
	 * archive value to be enable or disable considered as webusagechecksumval.
	 */
	public static final String INDEXFILES ="indexfiles";
	/**
	 * archive value to be enable or disable considered as webusagechecksumval.
	 */
	public static String IndexInfo;
	/**
	 * backup value of the last backup taken.
	 */
	public static final String SCHEDULED_LAST_BACKUP="ScheduledLastBackup";
	/**
	 * backup value of the next backup taken
	 */
	public static final String SCHEDULED_NEXT_BACKUP="ScheduledNextBackup";
	/**
	 * ftp username for the purpose of ftp login.
	 */
	public static final String FTP_USERNAME="FTPUserName";
	/**
	 * ftp password for the purpose of ftp login.
	 */
	public static final String FTP_PASSWORD="FTPPassword";
	/**
	 * ftp serverip for the purpose of ftp login.
	 */
	public static final String FTP_SERVERIP="FTPServerIP";
	/**
	 * schedule backup time at which backup will  taken.
	 */
	public static final String SCHEDULED_BACKUP_TIME="ScheduledBackupTime";
	/**
	 * schedule backup frequency like daily,never etc
	 */
	public static final String SCHEDULED_BACKUP_FREQUENCY="ScheduleBackupFrequency";
	/**
	 * Restore dir value.
	 */
	public static final String RESTORE="Restore";
	/**
	 * Backup Dir value.
	 */
	public static final String BACKUPDIR="Backup";
	/**
	 * FTP Backup Dir value.
	 */
	public static final String FTPBACKUPDIR="IviewBackup";
	
	/**
	 * Load the value initially.
	 */
	static {
		try {
			loadAll();
			iViewHome=((String)iviewConfigMap.get("iViewHome")).replace('\\', '/');
			ArchiveHome=((String)iviewConfigMap.get("ArchiveHome")).replace('\\', '/');
			PostgresHome=((String)iviewConfigMap.get("PostgresHome")).replace('\\', '/');;
			IndexInfo=IndexSearchBean.getValueByKey("indexinfo");
			/**
			 * Path not ends with / then need to add / in path.
			 */
			if(!iViewHome.endsWith("/")) iViewHome += "/";
			if(!ArchiveHome.endsWith("/")) ArchiveHome += "/";
			if(!PostgresHome.endsWith("/")) PostgresHome += "/";
		}catch (Exception e) {
			CyberoamLogger.sysLog.debug("iViewConfigBean.init(iviewhome or archivehome or pghome not set).e:" +e,e);
		}
	}
	
	/**
	 * This method loads all iView key-value parameters to cache memory.
	 */
	public static void loadAll(){
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		try {
			String query = "select keyname,value from tbliviewconfig;";
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			iViewConfigBean iviewConfigBean=null;
			while(rsw.next()){
				iviewConfigMap.put(rsw.getString("keyname"), rsw.getString("value"));
			}			
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("iviewConfigBean.loadAll.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		
	}
	
	/**
	 * This return value for given key name from org.cyberoam.iview common configuration cache.
	 * @param keyName specifies the key name
	 * @return value returns the value for a given key
	 */
	public static String getValueByKey(String keyName){
		return (String)iviewConfigMap.get(keyName);
	}
	
	/**
	 * This function updates given value for given key
	 * @param keyName specifies key name
	 * @param value specifies key value
	 * @return update record status 
	 */
	 public static int updateRecord(String keyName,String value){
		int updateValue=-1;
	    SqlReader sqlReader = null;
	    if(value.equalsIgnoreCase(iViewConfigBean.getValueByKey(keyName)) )
        	return 1;
        try{
            sqlReader = new SqlReader(false);
            String update = null;    
            
            update = "update tbliviewconfig "+
            "set value = "+StringMaker.makeString(value) +
            " where keyname like "+ StringMaker.makeString(keyName);
            updateValue=sqlReader.executeUpdate(update,5);
			if (updateValue > 0){
				iviewConfigMap.put(keyName, value);
			}
        }catch(Exception e){
            CyberoamLogger.repLog.error("Exception in updating org.cyberoam.iview config record: " + e,e);
            updateValue = -1;
        }finally{
            try{
                sqlReader.close();
            }catch(Exception e){
            }
        }
        return updateValue;
	}
	/**
	 * This function is used to get key name
	 * @return return keyname
	 */
	public String getKeyName() {
		return keyName;
	}
	/**
	 * This function is used to set key name
	 * @param keyName specifies key name
	 */
	public void setKeyName(String keyName) {
		this.keyName = keyName;
	}
	/**
	 * This function is used to get key value
	 * @return return key value
	 */
	public String getValue() {
		return value;
	}
	/**
	 * This function is used to set key value
	 * @param keyName specifies key value
	 */
	public void setValue(String value) {
		this.value = value;
	}
}
