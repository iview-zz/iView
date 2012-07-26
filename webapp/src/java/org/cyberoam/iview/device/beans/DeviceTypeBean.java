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

package org.cyberoam.iview.device.beans;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


public class DeviceTypeBean {

	private int iDeviceTypeId;
	private String strTypeName;
	private int iCategoryId;
	private boolean isAppId;
	
	private static TreeMap deviceTypeMap = null ;
	
	public int getDeviceTypeId() {
		return iDeviceTypeId;
	}
	
	public void setDeviceTypeId(int iDeviceTypeId) {
		this.iDeviceTypeId = iDeviceTypeId;
	}
	public String getTypeName() {
		return strTypeName;
	}
	public void setTypeName(String strTypeName) {
		this.strTypeName = strTypeName;
	}
	public int getCategoryId() {
		return iCategoryId;
	}
	
	public void setCategoryId(int iCategoryId) {
		this.iCategoryId = iCategoryId;
	}
	
	public boolean getIsAppId() {
		return isAppId;
	}
	
	public void setIsAppId(boolean isAppId) {
		this.isAppId = isAppId;
	}
	
	static{
		loadAll();
	}
	
	public static synchronized boolean loadAll(){
		if (deviceTypeMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		DeviceTypeBean deviceTypeBean = null;
		String strQuery=null;
		try {
			deviceTypeMap = new TreeMap();
			strQuery="select devicetypeid,typename,categoryid,isappid from tbldevicetype";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				deviceTypeBean = DeviceTypeBean.getBeanByResultSetWrapper(rsw);
				if (deviceTypeBean != null) {
					deviceTypeMap.put(new Integer(deviceTypeBean.getDeviceTypeId()), deviceTypeBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.appLog.error("Sqlexception->loadAll()->DeviceTypeBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception->loadAll()->DeviceTypeBean : "+ e, e);
			retStatus = false;
		} finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
	
	public static DeviceTypeBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		DeviceTypeBean deviceTypeBean = new DeviceTypeBean();
    	try {    		    		
    		deviceTypeBean.setDeviceTypeId(rsw.getInt("devicetypeid"));
    		deviceTypeBean.setTypeName(rsw.getString("typename"));
    		deviceTypeBean.setCategoryId(rsw.getInt("categoryid"));
    		deviceTypeBean.setIsAppId(rsw.getBoolean("isappid"));
    	}catch(Exception e) {
    		CyberoamLogger.appLog.error("Exception->getBeanByResultSetWrapper()->DeviceTypeBean: " + e,e);
    	}
    	return deviceTypeBean;
    }
	
	public static DeviceTypeBean getRecordbyPrimarykey(int primarykey) {        
		DeviceTypeBean deviceTypeBean = null;
        try {
        	if(deviceTypeMap==null) {
        		loadAll();
        	}
        	deviceTypeBean=(DeviceTypeBean)deviceTypeMap.get(new Integer(primarykey));
        	   if(deviceTypeBean==null) {
        		   deviceTypeBean=getSQLRecordByPrimaryKey(primarykey);
        		   if(deviceTypeBean!=null) {
        			   deviceTypeMap.put(new Integer(deviceTypeBean.getDeviceTypeId()),deviceTypeBean);
        		   }
        	   }        	
        }catch(Exception e) {
        	CyberoamLogger.appLog.error("Exception->getRecordbyPrimarykey()->DeviceTypeBean: " + e,e);
        }
        return deviceTypeBean;
    }
	
	public static DeviceTypeBean getSQLRecordByPrimaryKey(int primaryKey){
		DeviceTypeBean deviceTypeBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select devicetypeid,typename,categoryid,isappid from tbldevicetype where devicetypeid="+ primaryKey;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				deviceTypeBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.appLog.error("SQLException ->getSQLRecordByPrimaryKey() -> DeviceTypeBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception ->getSQLRecordByPrimaryKey() -> DeviceTypeBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return deviceTypeBean;
	}
		

	public static DeviceTypeBean getSQLRecordByCategory(int categoryid){
		DeviceTypeBean deviceTypeBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select devicetypeid,typename,categoryid,isappid from tbldevicetype where categoryid="+ categoryid;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				deviceTypeBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.appLog.error("SQLException ->getSQLRecordByCategory() -> DeviceTypeBean: " + categoryid + se,se);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception ->getSQLRecordByCategory() -> DeviceTypeBean: " + categoryid + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return deviceTypeBean;
	}
	
	public static TreeMap getDeviceTypeBeanMap() {
        try {
        	if(deviceTypeMap==null) {
        		loadAll();
        	}			
		}catch(Exception e) {
			CyberoamLogger.appLog.error("Exception->getDeviceTypeBeanMap()->DeviceTypeBean: " + e,e);
		}
		return deviceTypeMap;
    }
	
	public static Iterator getDeviceTypeBeanIterator() {
		Iterator iterator=null;
		DeviceTypeBean deviceTypeBean=null;
		try {		
			iterator=getDeviceTypeBeanMap().values().iterator();   			
		}catch(Exception e) {
			CyberoamLogger.appLog.error("exception->getDeviceTypeBeanIterator()->DeviceTypeBean: " + e,e);
		}
		return iterator;
	}
}
