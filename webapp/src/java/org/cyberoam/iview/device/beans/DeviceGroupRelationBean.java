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
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This class represents device group relation entity.
 * @author Vishal Vala
 *
 */
public class DeviceGroupRelationBean {


	private int relationID;
	private int groupID;
	private int deviceID;
	
	private static TreeMap deviceGroupRelBeanMap = null ;
	
	static{
		loadAll();
	}
	
	/**
	 * Returns device and device group relation Id.
	 * @return the relationID
	 */
	public int getRelationID() {
		return relationID;
	}

	/**
	 * Sets device and device group relation Id.
	 * @param relationID the relationID to set
	 */
	public void setRelationID(int relationID) {
		this.relationID = relationID;
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
	 * Returns device Id.
	 * @return the deviceID
	 */
	public int getDeviceID() {
		return deviceID;
	}

	/**
	 * Sets device Id.
	 * @param deviceID the deviceID to set
	 */
	public void setDeviceID(int deviceID) {
		this.deviceID = deviceID;
	}
	
	/**
	 * Loads all instances of device group relation entities into {@link TreeMap} from database table.
	 * @return
	 */
	public static synchronized boolean loadAll(){
		if (deviceGroupRelBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		DeviceGroupRelationBean deviceGroupRelBean = null;
		String strQuery=null;
		try {
			deviceGroupRelBeanMap = new TreeMap();
			strQuery="select devicegroupid,groupid,deviceid from tbldevicegrouprel order by groupid";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				deviceGroupRelBean= DeviceGroupRelationBean.getBeanByResultSetWrapper(rsw);
				if (deviceGroupRelBean != null) {
					deviceGroupRelBeanMap.put(new Integer(deviceGroupRelBean.getRelationID()), deviceGroupRelBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->DeviceGroupRelationBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->DeviceGroupRelationBean : "+ e, e);
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
	 * This method checks whether relationship between given device group and device exists or not.
	 * @param groupId
	 * @param deviceId
	 * @return true if there exists relationship.
	 */
	public static boolean isRelationExists(int groupId,int deviceId) {
		boolean retValue = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);		
		String strQuery=null;
		try {
			
			strQuery="select count(*) as count from tbldevicegrouprel where deviceid = " + deviceId + " and groupId=" + groupId;
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			rsw.next();
			if(rsw.getInt("count") > 0){
				retValue = true;
			}
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->DeviceGroupRelationBean->isRelationExist() : "+ e, e);
			
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->DeviceGroupRelationBean->isRelationExist() : "+ e, e);
			
		} finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return retValue;
	}
	
	/**
	 * Returns {@link ArrayList} containing all instances of device group relation entities based on given device group.
	 * @param groupID
	 * @return
	 */
	public static ArrayList getRelationByGroupID(int groupID){
		Iterator deviceGroupItr=deviceGroupRelBeanMap.values().iterator();
		ArrayList arrList=new ArrayList();
		DeviceGroupRelationBean deviceGroupRelBean=null;
		while(deviceGroupItr.hasNext()){
			deviceGroupRelBean=(DeviceGroupRelationBean)deviceGroupItr.next();
			if(groupID == deviceGroupRelBean.getGroupID()){
				arrList.add(deviceGroupRelBean);
			}				
		}	
		return arrList;
	}
	
	/**
	 * Returns {@link ArrayList} containing all instances of device group relation entities based on given device.
	 * @param deviceID
	 * @return
	 */
	public static ArrayList getRelationByDeviceID(int deviceID){
		Iterator deviceGroupItr=deviceGroupRelBeanMap.values().iterator();
		ArrayList arrList=new ArrayList();
		DeviceGroupRelationBean deviceGroupRelBean=null;
		while(deviceGroupItr.hasNext()){
			deviceGroupRelBean=(DeviceGroupRelationBean)deviceGroupItr.next();
			if(deviceID == deviceGroupRelBean.getDeviceID()){
				arrList.add(deviceGroupRelBean);
			}				
		}
		return arrList;
	}
	
	/**
	 * Obtains instance of device group relation entity by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static DeviceGroupRelationBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	DeviceGroupRelationBean deviceGroupRelBean = new DeviceGroupRelationBean();
    	try {
    		deviceGroupRelBean.setRelationID(rsw.getInt("devicegroupid"));
    		deviceGroupRelBean.setGroupID(rsw.getInt("groupid"));
    		deviceGroupRelBean.setDeviceID(rsw.getInt("deviceid"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->DeviceGroupRelationBean: " + e,e);
    	}
    	return deviceGroupRelBean;
    }
    
	/**
	 * Obtains instance of device group relation entity by primary key from database table.
	 * @param primaryKey
	 * @return
	 */
    public static DeviceGroupRelationBean getSQLRecordByPrimaryKey(int primaryKey){
		DeviceGroupRelationBean deviceGroupRelBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select devicegroupid,groupid,deviceid from tbldevicegrouprel where devicegroupid="+ primaryKey;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				deviceGroupRelBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> DeviceGroupRelationBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> DeviceGroupRelationBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return deviceGroupRelBean;
	}
    
    /**
     * Inserts SQL Record containing instance of device group relation entity into database table.
     * @return
     */
    public int insertRecord(){
        CyberoamLogger.repLog.debug("insert DeviceGroupRel called ...");
        String insert = null;
        int insertValue=-1;
        SqlReader sqlReader = null;
        try{
            sqlReader = new SqlReader(false);
            
            insert ="insert into tbldevicegrouprel "+
            "(groupid,deviceid) values ("+ 
            getGroupID() + "," + getDeviceID() + ")";
            
            insertValue = sqlReader.executeInsertWithLastid(insert,"devicegroupid");
            CyberoamLogger.repLog.info("ID after insert : "+insertValue);
            
			if (insertValue != 0){
				setRelationID(insertValue);
				if (DeviceGroupRelationBean.deviceGroupRelBeanMap != null ){
					DeviceGroupRelationBean.deviceGroupRelBeanMap.put(new Integer(getRelationID()),this);
				}else{
					DeviceGroupRelationBean.loadAll();
					DeviceGroupRelationBean.deviceGroupRelBeanMap.put(new Integer(getRelationID()),this);
				}
			}
        }catch(Exception e){
            CyberoamLogger.repLog.error("Got an exception while inserting record " + this + e,e);
            insertValue = -1;
        }finally{
            try{
                sqlReader.close();
            }catch(Exception e){}
        }
        return insertValue;
    }
    
    /**
     * Updates SQL Record containing instance of device group relation entity into database table.
     * @return
     */
    public int updateRecord(){
        int updateValue=-1;
        String update = null;
        SqlReader sqlReader = null;
        try{
            sqlReader = new SqlReader(false);
            
            update = "update tbldevicegrouprel "+
	            "set deviceid = "+getDeviceID() +","+
	            "groupid = " + getGroupID() + 
	            " where devicegroupid=" + getRelationID();
            updateValue=sqlReader.executeUpdate(update,5);
			if (updateValue > 0){
				if ( DeviceGroupRelationBean.deviceGroupRelBeanMap != null ){
					DeviceGroupRelationBean.deviceGroupRelBeanMap.put(new Integer(getRelationID()),this);
				}
			}			
        }catch(Exception e){
            CyberoamLogger.repLog.error("Exception in updating record: " + e,e);
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
     * Deletes SQL Record containing instance of device group relation entity from database table. 
     * @return
     */
    public int deleteRecord(){
		SqlReader sqlReader = null;
		int deleteValue = -1;
		try{
			sqlReader = new SqlReader(false);
			String deleteQuery = null;
			deleteQuery = "DELETE from tbldevicegrouprel "+
						"WHERE devicegroupid ="+ getRelationID();
			deleteValue=sqlReader.executeUpdate( deleteQuery,5);
			if (deleteValue >= 0){
				if(deviceGroupRelBeanMap != null){
					deviceGroupRelBeanMap.remove(new Integer(getRelationID()));
				}else{
					loadAll();
					deviceGroupRelBeanMap.remove(new Integer(getRelationID()));
				}
			}
			CyberoamLogger.repLog.debug("exception in deviceGroupRelBeanMap-> " + deviceGroupRelBeanMap);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception in deleting from memory in liveuserbean " +e,e);
			deleteValue = -1;			
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){}
		}
		return deleteValue;
	}
    
    public static Iterator getDeviceGroupRelIterator() {
    	if(deviceGroupRelBeanMap == null){
    		loadAll();
    	}
    	return deviceGroupRelBeanMap.values().iterator();
	}
    
    /**
     * Returns string representation of device group relation entity.
     */
    public String toString(){
    	String strString="";
    	strString="devicegroupid="+getRelationID()+
    	"\tgroupid="+getGroupID() + 
    	"\tdeviceid="+getDeviceID();
    	
    	return strString;
    }

}
