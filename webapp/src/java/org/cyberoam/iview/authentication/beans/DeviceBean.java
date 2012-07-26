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

package org.cyberoam.iview.authentication.beans;


import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.MailScheduleBean;
import org.cyberoam.iview.device.beans.DeviceGroupRelationBean;
import org.cyberoam.iview.device.beans.DeviceTypeBean;
import org.cyberoam.iview.utility.GarnerManager;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/***
 * This class represents device entity.
 * @author Narendra Shah
 *
 */
public class DeviceBean {

	private int iDeviceId;
	private String strName;
	private String applianceID;
	private String description;
	private String strIp;
	private int deviceStatus;
	private int deviceType;
	static public int NEW = 0;
	static public int USER_DECISION = 1; // @deprecated
	static public int ACTIVE = 2;
	static public int DEACTIVE = 3;
	static public int NEW_ACTIVE = 4;
	static public int NEW_DEACTIVE = 5;
	 
	private static TreeMap deviceBeanMap = null ;
	public static TreeMap deviceCategoryMap = null ;
	private static ArrayList<DeviceBean> newDeviceBeanList = new ArrayList<DeviceBean>() ;
	
	/**
	 * Get device bean identifier. 
	 * @return device Id
	 */
	public int getDeviceId() {
		return iDeviceId;
	}

	/**
	 * Set device bean identifier. 
	 */
	public void setDeviceId(int deviceId) {
		iDeviceId = deviceId;
	}

	/**
	 * Get device bean Category identifier. 
	 * @return category ID
	 */
	public int getCategoryId() {
		return DeviceTypeBean.getRecordbyPrimarykey(this.getDeviceType()).getCategoryId();		
	}

	
	/**
	 * Get name of device.
	 * @return device name
	 */
	public String getName() {
		return strName;
	}

	/**
	 * Set name of device
	 * @param strName - device name
	 */
	public void setName(String strName) {
		/*if(strName == null)
			strName = getApplianceID();*/
		this.strName = strName;
	}

	/**
	 * Get IP Address of device.
	 * @return device IP address 
	 */
	public String getIp() {
		return strIp;
	}

	/**
	 * Set IP Address of device.
	 * @param strIp - device IP address
	 */
	public void setIp(String strIp) {
		if(strIp == null || "null".equalsIgnoreCase(strIp)   )
			strIp="";
		this.strIp = strIp;
	}
	
	public int getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(int deviceType) {
		this.deviceType = deviceType;
	}
	
	static{
		loadAll();
	}
	
	/**
	 * Load all instances of active devices.  
	 * @return true on success else returns false
	 */
	public static synchronized boolean loadAll(){
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		DeviceBean deviceBean = null;
		String strQuery=null;
		try {
			deviceBeanMap = new TreeMap();
			deviceCategoryMap=new TreeMap();
			strQuery="select deviceid,name,descr,ip,appid,devicestatus,devicetype from tbldevice" 
				+" where devicestatus in (2,3) order by name,devicetype";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				deviceBean= DeviceBean.getBeanByResultSetWrapper(rsw);
				if (deviceBean != null) {
					deviceBeanMap.put(new Integer(deviceBean.getDeviceId()), deviceBean);
					deviceCategoryMap.put(deviceBean.getApplianceID(), deviceBean.getCategoryId());
				}
			}
			DeviceBean.checkForNewDevice();
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->DeviceBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->DeviceBean : "+ e, e);
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
	 * Returns instance of device bean by ResultSetWrapper
	 * @param rsw - ResultSetWrapper
	 * @return device entity
	 */
    public static DeviceBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	DeviceBean deviceBean = new DeviceBean();
    	try {
    			deviceBean.setDeviceId(rsw.getInt("deviceid"));
    			deviceBean.setApplianceID(rsw.getString("appid"));
    			deviceBean.setName(rsw.getString("name"));
    			deviceBean.setDescription(rsw.getString("descr"));
    			deviceBean.setIp(rsw.getString("ip"));
    			deviceBean.setDeviceStatus(rsw.getInt("devicestatus"));
    			deviceBean.setDeviceType(rsw.getInt("devicetype"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->DeviceBean: " + e,e);
    	}
    	return deviceBean;
    }
    
    /**
     * Returns device bean by device identifier.
     * This also calls loadAll() if map of deviceBean not loaded.
     * @param primarykey - device Id
     * @return device entity
     */
    public static DeviceBean getRecordbyPrimarykey(int primarykey) {        
    	DeviceBean deviceBean=null;
        try {
        	   if(deviceBeanMap==null) {
               	loadAll();
               }
        	   deviceBean=(DeviceBean)deviceBeanMap.get(new Integer(primarykey));
        	   if(deviceBean==null) {
        		   deviceBean=getSQLRecordByPrimaryKey(primarykey);        			   
        	   }        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->DeviceBean: " + e,e);
        }
        return deviceBean;
    }
    
    
        
    /**
     * Returns device bean by device identifier from database.
     * @param primaryKey - device Id
     * @return device entity
     */
    public static DeviceBean getSQLRecordByPrimaryKey(int primaryKey){
		DeviceBean deviceBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select deviceid,name,descr,ip,appid,devicestatus,devicetype from tbldevice where deviceid="+ primaryKey;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				deviceBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> DeviceBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> DeviceBean: " + primaryKey + e,e);
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
     * Returns TreeMap of DeviceBean.
     */
    public static TreeMap getDeviceBeanMap() {
        try {
              if(deviceBeanMap==null) {
				loadAll();
              }			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getReportBeanMap()->DeviceBean: " + e,e);
		}
		return deviceBeanMap;
    }
    
    /**
     * Returns TreeMap of newDeviceBean.
     */
    public static ArrayList<DeviceBean> getNewDeviceBeanList() {
		return newDeviceBeanList;
    }
    
    /**
     * Returns iterator of DeviceBeanMap.
     * @return iterator of active devices
     */
    public static Iterator getDeviceBeanIterator() {
       Iterator iterator=null;
       try {    	   
    	   	iterator=getDeviceBeanMap().values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.sysLog.error("exception->getReportBeanIterator()->DeviceBean: " + e,e);
       }
       return iterator;
    }    
    /**
     * Check whether new device is available or not.
     * @return positive number if new device found else negative number will be returned
     */
    public static int checkForNewDevice(){
        String sqlQuery = null;		
		int retStatus = 0;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		DeviceBean deviceBean = null;
		boolean isNewAppliance = false;
		try{
			sqlReader=new SqlReader(false);
			newDeviceBeanList.clear();
			sqlQuery="select deviceid,name,descr,ip,appid,devicestatus,devicetype from tbldevice where devicestatus in (" 
					+ NEW + "," + NEW_ACTIVE + "," + NEW_DEACTIVE + ")";
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery,120);
			while(rsw.next()){
				deviceBean = getBeanByResultSetWrapper(rsw);
				CyberoamLogger.appLog.info("DeviceBean->checkForNewDevice()->: "+deviceBean);
				if(deviceBean!=null){
					if(deviceBean.getDeviceStatus() == NEW) {
						retStatus++;
						newDeviceBeanList.add(deviceBean);
					} else if(deviceBean.getDeviceStatus() == NEW_ACTIVE){
						deviceBean.setDeviceStatus(ACTIVE);
						deviceBean.updateRecord();
						isNewAppliance = true;
					} else if(deviceBean.getDeviceStatus() == NEW_DEACTIVE){
						deviceBean.setDeviceStatus(DEACTIVE);
						deviceBean.updateRecord();
					}
				}
			}
			if(isNewAppliance){
				CyberoamLogger.appLog.info("NEW_ACTIVE device found.Calling garner restart......");
				writeActiveFile();
				writeIPAddressFile();
				GarnerManager.restart();
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->checkForNewDevice()->DeviceBean->: " + e);
			return -1;
		}finally{
			try {
				rsw.close();
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		CyberoamLogger.appLog.error("checkForNewDevice()->DeviceBean->retStatus: " + retStatus);
		return retStatus;
	}
    /**
     * Get iterator of all deviceBean instances.
     * @return iterator of all devices 
     */
    public static Iterator getAllDeviceBeanIterator() {
    	/*LinkedHashMap deviceBeanTable = new LinkedHashMap();
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		DeviceBean deviceBean = null;
		String strQuery=null;
		try {			
			strQuery="select deviceid,name,descr,ip,appid,devicestatus,devicetype from tbldevice order by devicestatus";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				deviceBean= DeviceBean.getBeanByResultSetWrapper(rsw);
				if (deviceBean != null) {
					deviceBeanTable.put(new Integer(deviceBean.getDeviceId()), deviceBean);
				}
			}			
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->DeviceBean : "+ e, e);			
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->DeviceBean : "+ e, e);			
		} finally {
				rsw.close();
				sqlReader.close();			
		}	
		return deviceBeanTable.values().iterator();
		*/
    	if(deviceBeanMap == null ) loadAll();
    	return deviceBeanMap.values().iterator();
    }
    
    /**
     * Get iterator of all NewdeviceBean instances.
     * @return iterator of all new devices 
     */
    
    public static Iterator getNewDeviceBeanIterator() {
    	return getNewDeviceBeanList().iterator();
    }
    
    /**
     * clears newDeviceBeanMap
     */
    
    public void clearNewDeviceBeanList() {
    	newDeviceBeanList.clear();	
    }
    
    /**
     * Returns string representation of device entity.
     */
    @Override
	public String toString(){
    	String strString="";
    	strString="deviceId="+getDeviceId()+
    	"\tname="+getName()+
    	"\tdesc="+getDescription()+
    	"\tip="+getIp()+
    	"\tapplianceid="+getApplianceID()+
    	"\tdevicestatus="+getDeviceStatus()+
    	"\tdevicetype="+getDeviceType();
    	
    	return strString;
    }
    
    /**
     * Check whether device with same name or appliance identifier exist or not.
     * @param deviceId
     * @return positive integer if duplicate available else return negative integer
     */
    public int checkForDuplicate(int deviceId){
        String sqlQuery = null;		
		int retStatus = -1;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			CyberoamLogger.appLog.info("checkForDuplicate()->DeviceBean->deviceId:"+deviceId+" DeviceStatus:"+getDeviceStatus());
			if(deviceId == -1){sqlQuery = "select count(*) as count from tbldevice where " + 
                "name=" + StringMaker.makeString(getName()) + 
                " or ( appid=" + StringMaker.makeString(getApplianceID()) + " and appid != 'new')";
			} else {
				sqlQuery = "select count(*) as count from tbldevice where deviceid!=" + deviceId +
                " and ( name=" + StringMaker.makeString(getName()) +
                " or ( appid=" + StringMaker.makeString(getApplianceID()) + 
                " and appid != 'new'))";
			}

			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery,120);
			if (rsw.next() && rsw.getInt("count")>0){ 
				retStatus=-4;
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->checkForDuplicate()->DeviceBean: " + e);
			return -4;
		}finally{
			try {
				rsw.close();
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		return retStatus;
	}

    /**
     * Update device record into database table.
     * @return
     */
	public int updateRecord(){
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			retStatus = checkForDuplicate(getDeviceId());
			if(retStatus != -4){
				sqlReader=new SqlReader(false);
				boolean isApplianceIDAvailable=DeviceTypeBean.getRecordbyPrimarykey(this.getDeviceType()).getIsAppId();
				if(!isApplianceIDAvailable) {
					String typeName=DeviceTypeBean.getRecordbyPrimarykey(getDeviceType()).getTypeName();
					if(typeName.length() > 10) {
						setApplianceID(getIp() + typeName.substring(0, 10));
					}else {
						setApplianceID(getIp() + typeName);
					}
					CyberoamLogger.appLog.debug("Update device Setting appliance for garner for category except 1:" + getApplianceID() );
				}
				sqlQuery="update tbldevice set name = " + StringMaker.makeString(getName()) + 
					",descr =  " + StringMaker.makeString(getDescription()) + 
					",devicestatus = " + getDeviceStatus() +
					", ip= " + StringMaker.makeString(getIp()) +
					",appid = " + StringMaker.makeString(getApplianceID()) +
					",devicetype = " + getDeviceType() +
					" where deviceid = " + getDeviceId(); 
				retStatus = sqlReader.executeUpdate(sqlQuery,5);
				if (retStatus >= 0) {
					deviceBeanMap.put(new Integer(getDeviceId()),this);	
					deviceCategoryMap.put(getApplianceID(), getCategoryId());
					CyberoamLogger.appLog.debug("DeviceId: "+getDeviceId()+" categortyid: "+getCategoryId());
					UserCategoryDeviceRelBean.updateForDeviceId(getDeviceId(),getCategoryId());
					CyberoamLogger.appLog.debug("DeviceBean->Updation");
				}
			}
			CyberoamLogger.appLog.debug("updateRecord()->DeviceBean->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->updateRecord()->DeviceBean: " + e,e);
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
	 * Insert new device record into database table.
	 * @return
	 */
	public int insertRecord(){
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			retStatus = checkForDuplicate(-1);
			if(retStatus != -4){
				sqlReader=new SqlReader(false);
				boolean isApplianceIDAvailable=DeviceTypeBean.getRecordbyPrimarykey(this.getDeviceType()).getIsAppId();
				if(!isApplianceIDAvailable) {
					String typeName=DeviceTypeBean.getRecordbyPrimarykey(getDeviceType()).getTypeName();
					if(typeName.length() > 10) {
						setApplianceID(getIp() + typeName.substring(0, 10));
					}else {
						setApplianceID(getIp() + typeName);
					}
					CyberoamLogger.appLog.debug("Insert device Setting appliance for garner for category except 1:" + getApplianceID() );
				}
				sqlQuery="insert into tbldevice (name,descr,ip,appid,devicestatus,devicetype) values (" + 
					StringMaker.makeString(getName())+ "," +
					StringMaker.makeString(getDescription()) + "," +
					StringMaker.makeString(getIp()) + "," +
					StringMaker.makeString(getApplianceID()) + "," + 
					getDeviceStatus() +	"," + 
					getDeviceType() +
					")";  
				retStatus = sqlReader.executeInsertWithLastid(sqlQuery, "deviceid");
				if (retStatus >= 0) {
					setDeviceId(retStatus);
					if(deviceBeanMap == null){
						loadAll();
					}
					deviceBeanMap.put(getDeviceId(),this);
					UserCategoryDeviceRelBean.insertRecordForDeviceId(getDeviceId());						
				}
			}
			CyberoamLogger.appLog.debug("insertRecord()->DeviceBean->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->insertRecord()->DeviceBean: " + e,e);
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
	 * Delete all device record whose comma separated identifier list passed to function.
	 * @param deviceList
	 * @return positive integer if all devices are deleted
	 */
	public static int deleteAllRecord(String deviceList){
		SqlReader sqlReader = null;
		int deleteValue = -1;
		try{
			sqlReader = new SqlReader(false);
			String deleteQuery = null;
			String deviceIds[] = deviceList.split(",");
			
			for(int i = 0; i < deviceIds.length ; i++ ){
				if(DeviceGroupRelationBean.getRelationByDeviceID(Integer.parseInt(deviceIds[i])).size() != 0)
					return -4;
				if(MailScheduleBean.isDeviceDependent(deviceIds[i]))
					return -5;
				//if(UserDeviceRelBean.isDeviceDependent(deviceIds[i]))
				Iterator itrUser = UserBean.getUserBeanIterator();		
				while(itrUser.hasNext()){				
					int userid = ((UserBean)itrUser.next()).getUserId();
					if(userid!=1){						
						boolean tmp = UserCategoryDeviceRelBean.isRelationshipExistsWithDevice(userid, Integer.parseInt(deviceIds[i]));						
						if(tmp== true){						
							return -6;
						}
					}
				}				
			}
			
			deleteQuery = "DELETE from tbldevice "+"WHERE deviceid in ("+ deviceList +")";			
			deleteValue=sqlReader.executeUpdate( deleteQuery,5);
			
			if(deviceBeanMap == null){
				loadAll();
			}else if (deleteValue >= 0){
				for(int i=0;i<deviceIds.length;i++){
					UserCategoryDeviceRelBean.deleteRecordForDeviceId(new Integer(deviceIds[i]));
					deviceBeanMap.remove(new Integer(deviceIds[i]));
				}
			}
			CyberoamLogger.appLog.error("deleteRecord()->DeviceBean->retStatus: " + deleteValue);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteRecord()->DeviceBean: " + e,e);
			deleteValue = -1;			
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){}
		}
		return deleteValue;
	}
	
	/**
	 * Get appliance identifier of device.
	 * @return appliance Id
	 */
	public String getApplianceID() {
		return applianceID;
	}

	/**
	 * Set appliance identifier of device.
	 */
	public void setApplianceID(String applianceID) {
		if(applianceID == null)
			applianceID = "";
		this.applianceID = applianceID;
	}

	/**
	 * Get description of device.
	 * @return description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Set description of device.
	 */
	public void setDescription(String description) {
		if(description == null)
			description = "";
		this.description = description;
	}

	/**
	 * Get current status of device.
	 * @return device status
	 */
	public int getDeviceStatus() {
		return deviceStatus;
	}

	/**
	 * Set current status of device.
	 */
	public void setDeviceStatus(int deviceStatus) {
		this.deviceStatus = deviceStatus;
	}
	
	/**
	 * Write Appliance Ids of all active devices into file.
	 * @return positive integer on success
	 */
	public static int writeActiveFile(){
		FileWriter fileWriter = null;
		Iterator deviceBeanItr = null;
		DeviceBean deviceBean = null;
		int returnStatus = 0;
		StringBuffer activeList=new StringBuffer("");
		try{
			deviceBeanItr = getAllDeviceBeanIterator();
			boolean isNewLine=false;
			while(deviceBeanItr.hasNext()){
				deviceBean = (DeviceBean) deviceBeanItr.next();
				if(deviceBean.deviceStatus == ACTIVE){
					activeList.append(isNewLine?"\n":"");
					if(deviceBean.getApplianceID()!=null && !"new".equalsIgnoreCase(deviceBean.getApplianceID())){
						activeList.append(deviceBean.getApplianceID());
					} else {
						activeList.append(deviceBean.getIp());
					}
					isNewLine=true;
				}
			}
			CyberoamLogger.appLog.debug("Writing active file.");
			fileWriter = new FileWriter(IViewPropertyReader.GarnerHOME+"conf/"+IViewPropertyReader.ActiveDeviceFile,false);
			fileWriter.write(activeList.toString());
			fileWriter.close();
			returnStatus = 1;
		}catch(IOException e){
			CyberoamLogger.appLog.debug("IOException->writeActiveFile()->DeviceBean->e : " + e);
		}catch(Exception e){	
			CyberoamLogger.appLog.debug("Exception->writeActiveFile()->DeviceBean->e : " + e);			
		}
		return returnStatus;
	}
	
	/**
	 * Write Appliance Ids of all inactive devices into file.
	 * @return positive integer on success
	 */
	public static int writeInActiveFile(){
		FileWriter fileWriter = null;
		Iterator deviceBeanItr = null;
		DeviceBean deviceBean = null;
		int returnStatus = 0;
		try{
			deviceBeanItr = getAllDeviceBeanIterator();
			StringBuffer inactiveList=new StringBuffer("");
			boolean isNewLine=false;
			while(deviceBeanItr.hasNext()){
				deviceBean = (DeviceBean) deviceBeanItr.next();
				if(deviceBean.deviceStatus == DEACTIVE){
					inactiveList.append(isNewLine?"\n":"");
					if(deviceBean.getApplianceID()!=null && !"new".equalsIgnoreCase(deviceBean.getApplianceID())){
						inactiveList.append(deviceBean.getApplianceID());
						isNewLine=true;
					}
				}
			}
			CyberoamLogger.appLog.debug("Writing inactive file.");
			fileWriter = new FileWriter(IViewPropertyReader.GarnerHOME+"conf/"+IViewPropertyReader.InActiveDeviceFile,false);
			fileWriter.write(inactiveList.toString());
			fileWriter.close();
			returnStatus = 1;
		}catch(IOException e){
			CyberoamLogger.appLog.debug("IOException->writeInActiveFile()->DeviceBean->e : " + e);
		}catch(Exception e){	
			CyberoamLogger.appLog.debug("Exception->writeInActiveFile()->DeviceBean->e : " + e);			
		}
		return returnStatus;
	}

	/**
	 * Write IP Address of all devices into file.
	 * @return positive integer on success
	 */
	public static int writeIPAddressFile(){
		FileWriter fileWriter = null;
		Iterator deviceBeanItr = null;
		DeviceBean deviceBean = null;
		DeviceTypeBean deviceTypeBean = null;
		ArrayList IPAddressArrList = new ArrayList();
		int returnStatus = 0;
		StringBuffer IPAddressList=new StringBuffer("");
		try{
			deviceBeanItr = getAllDeviceBeanIterator();
			String applianceID=null;
			boolean duplicate=false;
			while(deviceBeanItr.hasNext()){
				deviceBean = (DeviceBean) deviceBeanItr.next();
				if(deviceBean!=null && deviceBean.getIp()!=null && 
						!"".equalsIgnoreCase(deviceBean.getIp().trim()) && 
						!"null".equalsIgnoreCase(deviceBean.getIp())){
					
					deviceTypeBean = DeviceTypeBean.getRecordbyPrimarykey(DeviceBean.getRecordbyPrimarykey(deviceBean.getDeviceId()).getDeviceType());
					if(IPAddressArrList.contains(deviceBean.getIp())){ 
						duplicate=true;	
					}else {
						duplicate=false;
						IPAddressArrList.add(deviceBean.getIp());
					}
					/**
					 * Field order
					 * 1. IPaddress
					 * 2. Category
					 * 3. Devicetype
					 * 4. Appliance id or ipaddress if new
					 * 5. Device status 
					 * 6. Duplicate ip or not (value true:false)
					 */
					IPAddressList.append(deviceBean.getIp().trim() + " " + 
							deviceTypeBean.getCategoryId() + " " + 
							deviceTypeBean.getTypeName().trim() + " " + 
							(deviceBean.getApplianceID().equalsIgnoreCase("new")?deviceBean.getIp():deviceBean.getApplianceID().trim()) + " " +
							deviceBean.getDeviceStatus() +  " " + 
							duplicate + " " +							
							"\n");
					
					
				}
			}
			CyberoamLogger.appLog.debug("Writing IP Address file.");
			fileWriter = new FileWriter(IViewPropertyReader.GarnerHOME+"conf/"+IViewPropertyReader.DeviceIPAddressListFile,false);
			fileWriter.write(IPAddressList.toString());
			fileWriter.close();
			IPAddressArrList.clear();
			returnStatus = 1;
		}catch(IOException e){
			CyberoamLogger.appLog.debug("IOException->writeIPAddressFile()->DeviceBean->e : " + e);
		}catch(Exception e){	
			CyberoamLogger.appLog.debug("Exception->writeIPAddressFile()->DeviceBean->e : " + e);			
		}
		return returnStatus;
	}

	/**
	 * Set relation between user and selected device list.
	 * @param request
	 */
	public static void setDeviceListForUser(HttpServletRequest request) {
		HttpSession session = request.getSession(true);	
		try {			
			int categoryId = Integer.parseInt(session.getAttribute("categoryid").toString());
			String appIdList = "";
			DeviceBean deviceBean = null;
			UserBean userBean=UserBean.getRecordbyPrimarykey((String)session.getAttribute("username"));			
			String[] arrAppIdlist = null;
			int userId = userBean.getUserId();
			if ("true".equalsIgnoreCase(request.getParameter("isdevicegroup"))) {				
				CyberoamLogger.appLog.info("DeviceBean=>setDeviceListForUser()=>isdevicegroup:"+request.getParameter("isdevicegroup"));
				session.setAttribute("isdevicegroup", request.getParameter("isdevicegroup"));
				session.setAttribute("devicegrouplist", request.getParameter("devicegrouplist"));

				if (request.getParameter("devicegrouplist").equalsIgnoreCase("-1")) {
					String strDeviceList[] = UserCategoryDeviceRelBean.getDeviceIdListForUserCategory(userId, categoryId);
					if(strDeviceList != null && strDeviceList.length > 0){
						for (int i = 0; i < strDeviceList.length; i++)
							appIdList += "'" + DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList[i])).getApplianceID() + "',";
					}else{
						String strDeviceId[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryId);
						if(strDeviceId != null && strDeviceId.length > 0){
							for(int i=0;i<strDeviceId.length;i++){
								appIdList += "'" + DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList[i])).getApplianceID() + "',";
							}
						}
					}				
				} else {					
					arrAppIdlist = request.getParameter("devicegrouplist").split(",");
					ArrayList deviceGroupRelList = null;
					for (int i = 0; i < arrAppIdlist.length; i++) {
						deviceGroupRelList = DeviceGroupRelationBean.getRelationByGroupID((Integer.parseInt(arrAppIdlist[i])));
						for (int j = 0; j < deviceGroupRelList.size(); j++) {
							DeviceGroupRelationBean deviceGroupRelationBean = (DeviceGroupRelationBean) deviceGroupRelList.get(j);
							deviceBean = DeviceBean.getRecordbyPrimarykey(deviceGroupRelationBean.getDeviceID());
							if (deviceBean != null) {
								appIdList += "'" + deviceBean.getApplianceID() + "',";
							}
						}
					}
					appIdList += "'" + deviceBean.getApplianceID() + "'";
				}
				if (!appIdList.equalsIgnoreCase("")) {
					appIdList = appIdList.substring(0, appIdList.lastIndexOf(","));
			}
			session.setAttribute("appliancelist", appIdList);			
		} else if (!(request.getParameter("devicelist") == null || request.getParameter("devicelist").equalsIgnoreCase(""))) {		
			CyberoamLogger.appLog.info("DeviceBean=>setDeviceListForUser()=>devicelist:"+request.getParameter("devicelist"));			
			session.setAttribute("isdevicegroup", request.getParameter("isdevicegroup"));
			if (request.getParameter("devicelist").equalsIgnoreCase("-1")) {				
				String strDeviceList[] = UserCategoryDeviceRelBean.getDeviceIdListForUserCategory(userId, categoryId);
				if(strDeviceList != null && strDeviceList.length > 0){
					for (int i = 0; i < strDeviceList.length; i++){
						appIdList += "'" + DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList[i])).getApplianceID() + "',";
					}
				}else {
					String strDeviceId[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryId);
					if(strDeviceId != null && strDeviceId.length > 0){
						for(int i=0;i<strDeviceId.length;i++){
							appIdList += "'" + DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList[i])).getApplianceID() + "',";
						}
					}
				}
				if (!appIdList.equalsIgnoreCase("")) {
					appIdList = appIdList.substring(0, appIdList.lastIndexOf(","));
				}								
			} else {
				session.setAttribute("devicelist", request.getParameter("devicelist"));
				session.setAttribute("devicegrouplist", "null");
				arrAppIdlist = request.getParameter("devicelist").split(",");
				for (int i = 0; i < arrAppIdlist.length - 1; i++) {
					deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(arrAppIdlist[i]));
					appIdList += "'" + deviceBean.getApplianceID() + "',";
				}
				deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(arrAppIdlist[arrAppIdlist.length - 1]));
				appIdList += "'" + deviceBean.getApplianceID() + "'";
			}
			session.setAttribute("appliancelist", appIdList);		
		} else if (request.getParameter("deviceid") != null) {		
			CyberoamLogger.appLog.info("DeviceBean=>setDeviceListForUser()=>deviceid:"+request.getParameter("deviceid"));
			/**
			 * Special case for device level dashboard.
			 */
			deviceBean = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(request.getParameter("deviceid")));
			if(deviceBean != null){
				session.setAttribute("appliancelist", "'" + deviceBean.applianceID + "'");
				session.setAttribute("devicelist", request.getParameter("deviceid"));
			}
			
		} else if (session.getAttribute("devicelist") == null) {			
			CyberoamLogger.appLog.info("DeviceBean=>setDeviceListForUser()=>devicelist:"+request.getParameter("devicelist"));						
			String strDeviceList[] = UserCategoryDeviceRelBean.getDeviceIdListForUserCategory(userId, categoryId);
			if(strDeviceList != null && strDeviceList.length > 0){
				for (int i = 0; i < strDeviceList.length; i++){
					appIdList += "'" + DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceList[i])).getApplianceID() + "',";
				}
			}
			else {			
				String strDeviceId[] = UserCategoryDeviceRelBean.getDeviceIdListForCategory(categoryId);
				if(strDeviceId != null && strDeviceId.length > 0){
					for(int i=0;i<strDeviceId.length;i++){
						appIdList += "'" + DeviceBean.getRecordbyPrimarykey(Integer.parseInt(strDeviceId[i])).getApplianceID() + "',";
					}
				}
			}			
			if (!appIdList.equalsIgnoreCase("")) {						
				appIdList = appIdList.substring(0, appIdList.lastIndexOf(","));				
			}
			session.setAttribute("devicelist", "-1");
			session.setAttribute("appliancelist", appIdList);			
		}
		} catch (Exception e) {
			CyberoamLogger.appLog.debug("DeviceBean.setDeviceListForUser.e" + e, e);
		}
	}
}
