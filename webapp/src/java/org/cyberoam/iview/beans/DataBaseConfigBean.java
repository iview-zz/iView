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


import java.math.BigDecimal;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.ByteInUnit;
import org.cyberoam.iview.utility.GarnerManager;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This class represents database configuration entity.
 * @author Vishal Vala
 *
 */
public class DataBaseConfigBean {
	/**
	 * General Configuration related to iView are stored in this bean and tblconfigtable .
	 */
	private String keyName=null;
	private String value = null;
	private static TreeMap DataBaseConfigBeanMap=new TreeMap();

	/**
	 * Please insert constant key name here when you insert query in tbliviewconfig.
	 */
	public static final String  MaxNoTables24hr_web="MaxNoTables24hr_web";
	public static final String  MaxNoTables24hr_mail="MaxNoTables24hr_mail";
	public static final String  MaxNoTables24hr_deniedweb="MaxNoTables24hr_deniedweb";
	public static final String  MaxNoTables5min_event="MaxNoTables5min_event";
	public static final String  MaxNoTables24hr_ftp="MaxNoTables24hr_ftp";
	public static final String  MaxNoTables24hr_ips="MaxNoTables24hr_ips";
	public static final String  MaxNoTables24hr_im="MaxNoTables24hr_im";
	public static final String  MaxNoTables24hr_spam="MaxNoTables24hr_spam";
	public static final String  MaxNoTables24hr_virus="MaxNoTables24hr_virus";
	public static final String  MaxNoTables5min_vpn="MaxNoTables5min_vpn";
	
	public static final String  MaxNoTables24hr_blocked_deny="MaxNoTables24hr_blocked_deny";
	public static final String  MaxNoTables24hr_accept_top_host_user_rules_protogroup_application="MaxNoTables24hr_accept_top_host_user_rules_protogroup_application";
	public static final String  MaxNoTables5min_iusg="MaxNoTables5min_iusg";
	public static final String  MaxNoTables24hr_apch="MaxNoTables24hr_apch";
	public static final String  MaxNoTables24hr_usbc="MaxNoTables24hr_usbc";
	public static final String  MaxNoTables24hr_webr="MaxNoTables24hr_webr";
	public static final String  MaxNoTables24hr_update="MaxNoTables24hr_update";
	public static final String  MaxNoTables24hr_flnt="MaxNoTables24hr_flnt";
	public static final String  MaxNoTables24hr_apct="MaxNoTables24hr_apct";
	public static final String  MaxNoTables24hr_mscan="MaxNoTables24hr_mscan";
	public static final String  MaxNoTables24hr_fw="MaxNoTables24hr_fw";
	public static final String  MaxNoTables24hr_webs="MaxNoTables24hr_webs";
	
	public static final String  MaxNoTables24hr_netg="MaxNoTables24hr_netg";
	public static final String  MaxNoTables24hr_netgdnd="MaxNoTables24hr_netgdnd";
	public static final String  MaxNoTables24hr_netg_application="MaxNoTables24hr_netg_application";
	public static final String  MaxNoTables24hr_netg_ips="MaxNoTables24hr_netg_ips";
	public static final String  MaxNoTables24hr_netg_virus="MaxNoTables24hr_netg_virus";
	
	
	
	public static final String  MAX_TABLE_NO_FOR5MIN="MaxNoRotatedTablesFor5min";
	public static final String  MAX_TABLE_NO_FOR4HR="MaxNoRotatedTablesFor4hr";
	public static final String MAX_TABLE_NO_FOR12HR="MaxNoRotatedTablesFor12hr";
	public static final String MAX_TABLE_NO_FOR24HR="MaxNoRotatedTablesFor24hr";
	public static final String ARHIEVE_DATA="ArchieveData";

	/**
	 * Load the value initially
	 */
	static {
		loadAll();
	}

	/**
	 * This method loads all database value to {@link TreeMap}.
	 */
	public static void loadAll(){
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		try {
			String query = "select key,value from tbldataconfig;";
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			iViewConfigBean iviewConfigBean=null;
			while(rsw.next()){
				DataBaseConfigBeanMap.put(rsw.getString("key"), rsw.getString("value"));
			}
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.loadAll.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
	}

	/**
	 * This return value for given key name from DataBaseConfigBean common configuration cache.
	 * @param keyName specifies the key name
	 * @return value returns the value for a given key
	 */
	public static String getValue(String keyName){
		return (String)DataBaseConfigBeanMap.get(keyName);
	}
		
	/**
	 * This function updates given value for given key
	 * @param keyName specifies key name
	 * @param value specifies key value
	 * @return update record status 
	 */
	public static int setValue(String keyName,String value){
		int updateValue=-1;
	    SqlReader sqlReader = null;
	    if(DataBaseConfigBean.getValue(keyName).equalsIgnoreCase(value) )
	       	return 1;
	    try{
	    	sqlReader = new SqlReader(false);
	        String update = null;
	        if(!value.equals(DataBaseConfigBean.getValue(keyName))) {
	        	update = "update tbldataconfig " + "set value = "+StringMaker.makeString(value) +
	        		" where key like "+ StringMaker.makeString(keyName);
	        	updateValue=sqlReader.executeUpdate(update,5);
				if (updateValue > 0){
					DataBaseConfigBeanMap.put(keyName, value);
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_web){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'web Surfing'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_mail){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Mail Logs'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_im){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'IM Logs'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_ftp){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'FTP Logs'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables5min_vpn){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'VPN Logs'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables5min_iusg){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Internet Usage'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_deniedweb){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Blocked Web Attempts'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_ips){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'IPS Attacks'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_spam){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Spam Logs'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_virus){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Virus Logs'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables5min_event){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Appliance Audit Logs'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_accept_top_host_user_rules_protogroup_application){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Application Logs'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_blocked_deny){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Blocked Attempt Logs'";
				}
				//For Access Gateway
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_fw){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Firewall Report'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_webs){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Web Usage Logs'";
				}
				//For EPS
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_usbc){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'USB Control'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_webr){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Web Report'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_update){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Update Data'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_flnt){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'File Antivirus'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_apct){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Application Control'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_mscan){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Email Scanning'";
				}
				//FOr Apache
				
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_apch){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Apache'";
				}
				//For Archieve
				if(keyName==DataBaseConfigBean.ARHIEVE_DATA){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'ArchieveData'";
				}
				//For Net Genie
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_netg){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'NetGenie Web Allow'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_netgdnd){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'NetGenie Web Denied'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_netg_application){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Netgenie Application Activtiy'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_netg_ips){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Netgenie IPS Attacks'";
				}
				if(keyName==DataBaseConfigBean.MaxNoTables24hr_netg_virus){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'Netgenie Virus Logs'";
				}
				if(keyName == DataBaseConfigBean.MAX_TABLE_NO_FOR5MIN) {
					update = "update tbldatastatus " + "set status = 0 where table_name = 'DetailTable'";
				} else if(keyName ==  DataBaseConfigBean.MAX_TABLE_NO_FOR4HR || keyName ==  DataBaseConfigBean.MAX_TABLE_NO_FOR24HR || 
						keyName ==  DataBaseConfigBean.MAX_TABLE_NO_FOR12HR){
					update = "update tbldatastatus " + "set status = 0 where table_name = 'SummaryTable'";
				}
				updateValue=sqlReader.executeUpdate(update,5);
				CyberoamLogger.repLog.error("update value : "+updateValue);
			} else {
				updateValue = 1;
	        }
	    }catch(Exception e){
	    	CyberoamLogger.repLog.error("Exception in updating DataBaseConfigBean record: " + e,e);
	    	updateValue = -1;
	    }finally{
	    	try{
	    		sqlReader.close();
	    	}catch(Exception e){}
	    }
	    return updateValue;
	}

	/**
	 * Returns the size of detail tables.
	 * @return
	 */
	public static String getDetailTablesSize() {
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		String size="";
		try {
			String query = "select pg_size_pretty(size) as size from tbldatastatus where table_name = 'DetailTable';";				
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			while(rsw.next()){
				size = rsw.getString("size");
			}					
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.getDetailTablesSize.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {}
		}
		return size;
	}

	/**
	 * Returns the size of summarized tables. 
	 * @return
	 */
	public static String getSummaryTablesSize() {
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		String size="";
		try {
			String query = "select pg_size_pretty(size) as size from tbldatastatus where table_name = 'SummaryTable';";				
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			while(rsw.next()){
				size = rsw.getString("size");
			}				
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.getSummaryTablesSize.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {}
		}
		return size;
	}
	
	/**
	 * Returns the indexed file size from tblfilelist.
	 * @return
	 */
	public static String getArchieveSize(){
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		String size="NA";
		long bytes; 
		try {
			String query = "select * from getsystemusage('diskusage') where usagetype in ('Used (Archive)','Used (Database+Archive)')";				
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			if(rsw.next()){
				bytes = rsw.getLong("usage");
				size = ByteInUnit.getBytesInUnit(bytes) + " (Drive Usage)";
			}
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.getStatus.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {}
		}
		return size;
	}

	/**
	 * Returns the module wise table size from procedure
	 * @return
	 * @ author Asha Koshti
	 */
	public static String getTablesSize(String prefix){
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		String size="NA";
		long bytes; 
		try {
			String query = "select * from tables_size('"+prefix+"') ";
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			if(rsw.next()){
				bytes = rsw.getLong("tables_size");
				size = ByteInUnit.getBytesInUnit(bytes) + " (Drive Usage)";
			}
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.getStatus.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {}
		}
		return size;
	}
	
	/**
	 * Returns the status of summary table.
	 * @return
	 */
	public static String getStatusSummary() {
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		String size="";
		try {
			String query = "select status from tbldatastatus where table_name = 'SummaryTable';";				
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			while(rsw.next()){
				size = rsw.getString("status");
			}				
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.getStatus.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {}
		}
		return size;
	}

	/**
	 * Returns the status of detail table.
	 * @return
	 */
	public static String getStatusDetail() {
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		String size="";
		try {
			String query = "select status from tbldatastatus where table_name = 'DetailTable';";				
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			while(rsw.next()) {
				size = rsw.getString("status");
			}				
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.getStatus.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {}
		}
		return size;
	}
	/**
	 * Returns the status of Specified table.
	 * @return
	 * @ author Asha Koshti
	 */
	public static String getSpecifiedTableStatus(String tblname) {
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		String status="";
		try {
			String query = "select status from tbldatastatus where table_name = '"+ tblname+"';";				
			rsw=sqlReader.getInstanceResultSetWrapper(query);
			while(rsw.next()){
				status = rsw.getString("status");
			}				
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.getStatus.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {}
		}
		return status;
	}
	
	/**
	 * Sets the status of data archiving mechanism.
	 * @return
	 */
	public static int setDataArchive(String value) {
		int returnStatus = 1;
		try {
			CyberoamLogger.appLog.info("DataBaseConfigBean=>setDataArchive()=>value"+value);
			String oldStatus = getValue(ARHIEVE_DATA);
			returnStatus = setValue(ARHIEVE_DATA, value);
			CyberoamLogger.appLog.info("DataBaseConfigBean=>setDataArchive()=>value:"+value);
			CyberoamLogger.appLog.info("DataBaseConfigBean=>setDataArchive()=>oldStatus:"+oldStatus);
			CyberoamLogger.appLog.info("DataBaseConfigBean=>setDataArchive()=>returnStatus:"+returnStatus);
			if(returnStatus>0 && !oldStatus.equalsIgnoreCase(value) && ("0".equalsIgnoreCase(oldStatus) || "0".equalsIgnoreCase(value))){
				CyberoamLogger.appLog.info("DataBaseConfigBean=>setDataArchive()=>Garner Restart called.");
				GarnerManager.restart();
				CyberoamLogger.appLog.info("DataBaseConfigBean=>setDataArchive()=>Garner Restart completed.");
			}
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("DataBaseConfigBean.setDataArchive.e: " + e,e);
			returnStatus = -1;
		}
		return returnStatus;
	}
}
