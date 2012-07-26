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

/**
 * 
 */
package org.cyberoam.iview.device.beans;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.UserCategoryDeviceRelBean;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;

/**
 * This class represents device group entity.
 * @author Vishal Vala
 *
 */
public class DeviceGroupBean {
	private int groupID;
	private String name;
	private String description;
	private int categoryID;
	
	private static TreeMap deviceGroupBeanMap = null ;
	
	static{
		loadAll();
	}
	
	/**
	 * Returns description of device group.
	 * @return
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Sets description of device group.
	 * @param description
	 */
	public void setDescription(String description) {
		if(description == null)
			description = "";
		this.description = description;
	}

	/**
	 * Returns device group Id.
	 * @return the groupID
	 */
	public int getGroupID() {
		return groupID;
	}

	/**
	 * Sets device group Id.
	 * @param groupID the groupID to set
	 */
	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}

	/**
	 * Returns device group's category Id.
	 * @return the categoryID
	 */
	public int getCategoryID() {
		return categoryID;
	}

	/**
	 * Sets device group's Category Id.
	 * @param categoryID the categoryID to set
	 */
	public void setCategoryID(int categoryID) {
		this.categoryID = categoryID;
	}
	/**
	 * Returns device group name.
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Sets device group name.
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * Returns {@link TreeMap} containing all instances of device group entity. 
	 * @return the deviceGroupBeanMap
	 */
	public static TreeMap getDeviceGroupBeanMap() {
		if(deviceGroupBeanMap==null)
			loadAll();
		return deviceGroupBeanMap;
	}

	/**
	 * Loads all instances of device group entities from database table into {@link TreeMap}.
	 * @return
	 */
	public static synchronized boolean loadAll(){
		if (deviceGroupBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		DeviceGroupBean deviceGroupBean = null;
		String strQuery=null;
		try {
			deviceGroupBeanMap = new TreeMap();
			strQuery="select groupid,name,descr,categoryid from tbldevicegroup order by name";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {								
				deviceGroupBean= DeviceGroupBean.getBeanByResultSetWrapper(rsw);								
				if (deviceGroupBean != null) {
					deviceGroupBeanMap.put(new Integer(deviceGroupBean.getGroupID()), deviceGroupBean);					
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->DeviceGroupBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->DeviceGroupBean : "+ e, e);
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
	
	/**
	 * Obtains instance of device group entity by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
    public static DeviceGroupBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	DeviceGroupBean deviceGroupBean = new DeviceGroupBean();
    	try {
    		deviceGroupBean.setGroupID(rsw.getInt("groupid"));
    		deviceGroupBean.setName(rsw.getString("name"));
    		deviceGroupBean.setDescription(rsw.getString("descr"));
    		deviceGroupBean.setCategoryID(rsw.getInt("categoryid"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->DeviceGroupBean: " + e,e);
    	}
    	return deviceGroupBean;
    }   

    /**
     * Obtains instance of device group entity by primary key from {@link TreeMap}.
     * @param primarykey
     * @return
     */
    public static DeviceGroupBean getRecordbyPrimarykey(int primarykey) {        
    	DeviceGroupBean deviceBean=null;
        try {
        	   if(deviceGroupBeanMap==null) {
               	loadAll();
               }
        	   deviceBean=(DeviceGroupBean)deviceGroupBeanMap.get(new Integer(primarykey));
        	   if(deviceBean==null) {
        		   deviceBean=getSQLRecordByPrimaryKey(primarykey);
        		   if(deviceBean!=null) {
        			   deviceGroupBeanMap.put(new Integer(deviceBean.getGroupID()),deviceBean);
        		   }
        	   }        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->DeviceGroupBean: " + e,e);
        }
        return deviceBean;
    }
    
    /**
     * Obtains instance of device group entity by primary key from SQL Record of database table.
     * @param primaryKey
     * @return
     */
    public static DeviceGroupBean getSQLRecordByPrimaryKey(int primaryKey){
		DeviceGroupBean deviceBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select groupid,name,descr,categoryid from tbldevicegroup where groupid="+ primaryKey;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				deviceBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> DeviceGroupBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> DeviceGroupBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return deviceBean;
	}
    
    /**
     * Returns {@link Iterator} containing all instances of device group entity.
     * @return
     */
    public static Iterator getDeviceGroupBeanIterator() {
       Iterator iterator=null;
       try {  	   
    	   	iterator=getDeviceGroupBeanMap().values().iterator();    		
       }catch(Exception e) {
    	   	CyberoamLogger.sysLog.error("exception->getDeviceGroupBeanIterator()->DeviceGroupBean: " + e,e);
       }
       return iterator;
    }
    /**
     * Returns {@link Iterator} containing all instances of device group entity by category.
     * @return
     */
    public static Iterator getDeviceGroupBeanIteratorByCategory(int categoryId) {
    	LinkedHashMap deviceGroupBeanTable = new LinkedHashMap();
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		DeviceGroupBean deviceGroupBean = null;
		String strQuery=null;
		try {			
			strQuery="select groupid,name,descr,categoryid from tbldevicegroup where categoryid="+categoryId+ " order by name";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				deviceGroupBean= DeviceGroupBean.getBeanByResultSetWrapper(rsw);
				if (deviceGroupBean != null) {					
					deviceGroupBeanTable.put(new Integer(deviceGroupBean.getGroupID()), deviceGroupBean);
				}
			}
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->DeviceGroupBean->getDeviceGroupBeanIteratorByCategory() : "+ e, e);			
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->DeviceGroupBean->getDeviceGroupBeanIteratorByCategory(): "+ e, e);
		} finally {
			rsw.close();
			sqlReader.close();			
		}	
		return deviceGroupBeanTable.values().iterator();
    }
    
    /**
     * Inserts SQL Record of device group entity into database table.
     */
    public int insertRecord(){
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="insert into tbldevicegroup (name,descr,categoryid) values (" + 
				StringMaker.makeString(getName())+ "," +
				StringMaker.makeString(getDescription())+","+
				getCategoryID()+
				")";  
			retStatus = sqlReader.executeInsertWithLastid(sqlQuery, "groupid");
			setGroupID(retStatus);			
			if (retStatus >= 0) {
					if(deviceGroupBeanMap == null){
						loadAll();
					}
					deviceGroupBeanMap.put(new Integer(getGroupID()),this);
					UserCategoryDeviceRelBean.insertRecordForDeviceGroupId(getGroupID());
			}
			CyberoamLogger.appLog.debug("insertRecord()->DeviceGroupBean->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->insertRecord()->DeviceGroupBean: " + e);
			return -1;
		}finally{
			try {
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
    
    /**
     * Updates SQL Record of device group entity into database table.
     * @return
     */
    public int updateRecord(){
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="update tbldevicegroup set name = "+StringMaker.makeString(getName()) + ",descr =  "+StringMaker.makeString(getDescription()) +" where groupid = " + getGroupID(); 
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			if (retStatus >= 0) {
				deviceGroupBeanMap.put(new Integer(getGroupID()),this);
			}
			CyberoamLogger.appLog.debug("updateRecord()->DeviceGroupBean->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->updateRecord()->DeviceGroupBean: " + e);
			return -1;
		}finally{
			try {
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
	
	/**
	 * Deletes SQL Record of device group entity from database table.
	 * @return
	 */
	public int deleteRecord(){
		SqlReader sqlReader = null;
		int deleteValue = -1;
		ArrayList deviceGroupRelationList = null;
		DeviceGroupRelationBean deviceGroupRelationBean = null;
		try{
			sqlReader = new SqlReader(false);
			String deleteQuery = null;
			deleteQuery = "DELETE from tbldevicegroup "+
						"WHERE groupid ="+ getGroupID();
			deleteValue=sqlReader.executeUpdate( deleteQuery,5);
			if(deviceGroupBeanMap == null){
				loadAll();
			}
			UserCategoryDeviceRelBean.deleteRecordForDeviceGroupId(getGroupID());
			deviceGroupBeanMap.remove(new Integer(getGroupID()));
			deviceGroupRelationList = DeviceGroupRelationBean.getRelationByGroupID(getGroupID());
			for(int i=0; i<deviceGroupRelationList.size(); i++){
				((DeviceGroupRelationBean)deviceGroupRelationList.get(i)).deleteRecord();
			}
			CyberoamLogger.appLog.error("deleteRecord()->DeviceGroupBean->retStatus: " + deleteValue);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteRecord()->DeviceGroupBean: " + e);
			deleteValue = -1;			
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){}
		}
		return deleteValue;
	}
	/**
	 * Returns string representation of device group entity.
	 */
	public String toString(){
    	String strString="";
    	strString="deviceId="+getGroupID()+
    	"\tname="+getName()+
    	"\tdesc="+getDescription();
    	return strString;
    }

}
