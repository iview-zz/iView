package org.cyberoam.iview.authentication.beans;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.CategoryBean;
import org.cyberoam.iview.device.beans.DeviceGroupBean;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;

/**
 * The class generated to create relation between userid, categoryid, deviceid and devicegroupid
 * The class cache all the relation between userid, categoryid, deviceid and deviceGroupid
 * @author Jaydatt Desai
 *
 */
public class UserCategoryDeviceRelBean {
	
	/**
	 * userCategoryDeviceRelBeanMap is a cached Tree map which defines all the relation between
	 * each user and its all the category and for all the devices and all device groups for that each category
	 */
	private static TreeMap<Integer,CategoryInner> userCategoryDeviceRelBeanMap = null;
	
	private int userDeviceRelId;
	private int userId;
	private String deviceId = null;
	private String deviceGroupId = null;		
	
	/**		
	 * @return userDeviceRelId
	 */
	public int getUserDeviceRelId() {
		return userDeviceRelId;
	}

	/**
	 * 
	 * @param userDeviceRelId
	 */
	public void setUserDeviceRelId(int userDeviceRelId) {
		this.userDeviceRelId = userDeviceRelId;
	}

	/**
	 * 
	 * @return userId
	 */
	public int getUserId() {
		return userId;
	}

	/**
	 * 
	 * @param userId
	 */
	public void setUserId(int userId) {
		this.userId = userId;
	}

	/**
	 * 
	 * @return deviceId
	 */
	public String getDeviceId() {
		return deviceId;
	}

	/**
	 * 
	 * @param deviceId
	 */
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	/**
	 * 
	 * @return deviceGroupId
	 */
	public String getDeviceGroupId() {
		return deviceGroupId;
	}

	/**
	 * 
	 * @param deviceGroupId
	 */
	public void setDeviceGroupId(String deviceGroupId) {
		this.deviceGroupId = deviceGroupId;
	}

	/**
	 * returns a cached treemap with all the relation between userid, categoryid, deviceid and devicegroups
	 * @return userCategoryDeviceRelBeanMap
	 */
	public static TreeMap<Integer,CategoryInner> getUserCategoryDeviceRelBeanMap() {
		try{
    		if(userCategoryDeviceRelBeanMap == null){
    			loadAll();
    		}
    		CyberoamLogger.repLog.error("getUserCategoryDeviceRelBeanMap() :UserCategoryDeviceRelBean Ends");
    	}catch (Exception e) {
			CyberoamLogger.repLog.error("Exception :getUserCategoryDeviceRelBeanMap() :UserCategoryDeviceRelBean"+e,e); 
		}
    	return userCategoryDeviceRelBeanMap;
	}

	/**
	 * set cached treemap with all the relation between userid, categoryid, deviceid and devicegroups
	 * @param userCategoryDeviceRelBeanMap
	 */
	public static void setUserCategoryDeviceRelBeanMap(TreeMap<Integer,CategoryInner> userCategoryDeviceRelBeanMap) {
		UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap = userCategoryDeviceRelBeanMap;
	}

	/**
	 * 
	 * inner class for defining relation between categoryid and the other Inner class DeviceInner 
	 * @author Jaydatt Desai
	 *
	 */
	private class CategoryInner{		
		TreeMap<Integer, DeviceInner> categoryMap = new TreeMap<Integer, DeviceInner>();				
		
		/**
		 * returns the Treemap with relation between category id  and the other inner class DeviceInner
		 * @param categoryID
		 * @return categoryMap
		 */
		DeviceInner getCategory(int categoryID){			
			return (DeviceInner)categoryMap.get(categoryID); 			
		}
		
		/**
		 * insert value for a new categoryId inside the categoryMap
		 * @param categoryID
		 * @param deviceInner
		 */
		void setCategory(int categoryID, DeviceInner deviceInner){
			categoryMap.put(categoryID, deviceInner);
		}
		
		/**
		 * Inner class for storing the device ids and device group ids for the all the users and their
		 * all the categories
		 * @author Jaydatt Desai
		 *
		 */
		private class DeviceInner{
			/**
			 * list of all the devices
			 */
			ArrayList<Integer> deviceList = null;
			/**
			 * list of all the device groups
			 */
			ArrayList<Integer> deviceGroupList = null;
			
			/**
			 * return arraylist of devices for a particular user and particular category 
			 * @return deviceList
			 */
			public ArrayList<Integer> getDeviceList() {
				return deviceList;
			}
			
			/**
			 * set arraylist of devices for a particular user and particular category
			 * @param deviceList
			 */
			public void setDeviceList(ArrayList<Integer> deviceList) {
				this.deviceList = deviceList;
			}
			
			/**
			 * return arraylist of device Groups for a particular user and particular category
			 * @return deviceGroupList
			 */
			public ArrayList<Integer> getDeviceGroupList() {
				return deviceGroupList;
			}
			
			/**
			 * set arraylist of device Groups for a particular user and particular category
			 * @param deviceGroupList
			 */
			public void setDeviceGroupList(ArrayList<Integer> deviceGroupList) {
				this.deviceGroupList = deviceGroupList;
			}
			
		}
	}
	
	/**
	 * static block execute for caching relation between user ids, category ids, device ids and device group ids 
	 */
	static{
		loadAll();
	}
	
	/**
	 * cache all the relation between user ids, category ids, device ids and device group ids in a Treemap 
	 * @return retStatus
	 */
	public static synchronized boolean loadAll(){
		if (userCategoryDeviceRelBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		UserCategoryDeviceRelBean userCategoryDeviceRelBean = null;
		String strQuery=null;
		try {						
			userCategoryDeviceRelBeanMap = new TreeMap<Integer,CategoryInner>();
			strQuery="select userdevicerelid,userid,deviceid,devicegroupid from tbluserdevicerel"; 
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);
			String deviceIds = null;
			String deviceId = null;
			
			String deviceGrpIds = null;
			String deviceGrpId = null;
			CategoryInner catInner = null;
			DeviceBean deviceBean = null;
			Iterator deviceBeanIt = null;
			ArrayList<Integer> deviceList = null;
			ArrayList<Integer> deviceGrpList = null;
			while (rsw.next()) {				
				userCategoryDeviceRelBean= UserCategoryDeviceRelBean.getBeanByResultSetWrapper(rsw);
				catInner = userCategoryDeviceRelBean.new CategoryInner();
				userCategoryDeviceRelBeanMap.put(userCategoryDeviceRelBean.getUserId(),catInner);
				if (userCategoryDeviceRelBean != null) {
					if(userCategoryDeviceRelBean.getDeviceId().equals("-1")){						
						deviceBeanIt = DeviceBean.getDeviceBeanIterator();						
						while(deviceBeanIt.hasNext()){
							deviceBean = (DeviceBean)deviceBeanIt.next();							
							int categoryId = deviceBean.getCategoryId();
							if(catInner.getCategory(categoryId) == null){
								CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
								catInner.setCategory(categoryId,deviceInner);
								deviceList = new ArrayList<Integer>();
								deviceList.add(deviceBean.getDeviceId());
								deviceInner.setDeviceList(deviceList);
								
								deviceGrpList = new ArrayList<Integer>();								
								deviceInner.setDeviceGroupList(deviceGrpList);
							}
							else{
								((CategoryInner.DeviceInner)catInner.getCategory(categoryId)).getDeviceList().add(deviceBean.getDeviceId());								
							}							
						}
						
						Iterator deviceGrpBeanIt = DeviceGroupBean.getDeviceGroupBeanIterator();
						DeviceGroupBean deviceGrpBean = null;
						while(deviceGrpBeanIt.hasNext()){
							deviceGrpBean = (DeviceGroupBean)deviceGrpBeanIt.next();							
							int categoryId = deviceGrpBean.getCategoryID();
							if(catInner.getCategory(categoryId) == null){
								CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
								catInner.setCategory(categoryId,deviceInner);
								ArrayList<Integer> deviceGroupList = new ArrayList<Integer>();
								deviceGroupList.add(deviceGrpBean.getGroupID());
								deviceInner.setDeviceGroupList(deviceGroupList);
								
								deviceList = new ArrayList<Integer>();
								deviceInner.setDeviceList(deviceList);
							}
							else{
								((CategoryInner.DeviceInner)catInner.getCategory(categoryId)).getDeviceGroupList().add(deviceGrpBean.getGroupID());
							}						
						}
						
						Iterator catIterator = CategoryBean.getAllCategoryIterator();
						int categoryItId;
						while(catIterator.hasNext()){
							categoryItId = ((CategoryBean)catIterator.next()).getCategoryId();
							if(catInner.getCategory(categoryItId) == null){
								CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
								catInner.setCategory(categoryItId,deviceInner);
							}
							
						}
					}else{
						deviceIds = userCategoryDeviceRelBean.getDeviceId();
						StringTokenizer deviceSt = new StringTokenizer(deviceIds,",");
						while(deviceSt.hasMoreTokens()){
							deviceId = deviceSt.nextToken();							
							int categoryId = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceId)).getCategoryId();							
							if(catInner.getCategory(categoryId) == null){
								CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
								catInner.setCategory(categoryId,deviceInner);
								deviceList = new ArrayList<Integer>();
								deviceList.add(Integer.parseInt(deviceId));
								deviceInner.setDeviceList(deviceList);
								
								deviceGrpList = new ArrayList<Integer>();								
								deviceInner.setDeviceGroupList(deviceGrpList);
							}
							else{
								((CategoryInner.DeviceInner)catInner.getCategory(categoryId)).getDeviceList().add(Integer.parseInt(deviceId));								
							}
						}
						
						deviceGrpIds = userCategoryDeviceRelBean.getDeviceGroupId();
						StringTokenizer deviceGrpSt = new StringTokenizer(deviceGrpIds,",");
						while(deviceGrpSt.hasMoreTokens()){
							deviceGrpId = deviceGrpSt.nextToken();
							int categoryId =((DeviceGroupBean)DeviceGroupBean.getDeviceGroupBeanMap().get(Integer.parseInt(deviceGrpId))).getCategoryID();
							if(catInner.getCategory(categoryId) == null){
								CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
								catInner.setCategory(categoryId,deviceInner);
								deviceGrpList = new ArrayList<Integer>();
								deviceGrpList.add(Integer.parseInt(deviceGrpId));
								deviceInner.setDeviceGroupList(deviceGrpList);
								
								deviceList = new ArrayList<Integer>();
								deviceInner.setDeviceList(deviceList);
							}
							else{
								((CategoryInner.DeviceInner)catInner.getCategory(categoryId)).getDeviceGroupList().add(Integer.parseInt(deviceGrpId));
							}
						}
					}
					
					Iterator catIterator = CategoryBean.getAllCategoryIterator();
					int categoryItId;
					while(catIterator.hasNext()){
						categoryItId = ((CategoryBean)catIterator.next()).getCategoryId();
						if(catInner.getCategory(categoryItId) == null){
							CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
							catInner.setCategory(categoryItId,deviceInner);
						}
						
					}
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.appLog.error("Sqlexception->loadAll()->UserCategoryDeviceRelBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception->loadAll()->UserCategoryDeviceRelBean : "+ e, e);
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
	 * Returns instance of UserDeviceCategoryBean by ResultSetWrapper
	 * @param rsw - ResultSetWrapper
	 * @return device entity
	 */
	public static UserCategoryDeviceRelBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		UserCategoryDeviceRelBean  userCategoryDeviceRelBean = new UserCategoryDeviceRelBean();
    	try {    		
    		userCategoryDeviceRelBean.setUserDeviceRelId(rsw.getInt("userdevicerelid"));
    		userCategoryDeviceRelBean.setUserId(rsw.getInt("userid"));
    		userCategoryDeviceRelBean.setDeviceId(rsw.getString("deviceid"));
    		userCategoryDeviceRelBean.setDeviceGroupId(rsw.getString("devicegroupid"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->UserCategoryDeviceRelBean: " + e,e);
    	}
    	return userCategoryDeviceRelBean;
    }	
	
	/**
	 * returns String array of device ids from userID and categoryId
	 * @param userID
	 * @param categoryID
	 * @return deviceIdArr
	 */
	public static String[] getDeviceIdListForUserCategory(int userID, int categoryID){
		String[] deviceIdArr = null;
		ArrayList<Integer> deviceList = ((CategoryInner.DeviceInner)((CategoryInner)userCategoryDeviceRelBeanMap.get(userID)).getCategory(categoryID)).getDeviceList();		
		if(deviceList != null && deviceList.size() > 0)
			deviceIdArr = UserCategoryDeviceRelBean.arrayListToStringArr(deviceList);		
		return deviceIdArr;
	}
	
	/**
	 * returns String array of device Group ids from userID and categoryId
	 * @param userID
	 * @param categoryID
	 * @return deviceGrpIdArr
	 */
	public static String[] getDeviceGroupIdListForUserCategory(int userID, int categoryID){
		String[] deviceGrpIdArr = null;
		ArrayList<Integer> deviceList = ((CategoryInner.DeviceInner)((CategoryInner)userCategoryDeviceRelBeanMap.get(userID)).getCategory(categoryID)).getDeviceGroupList();		
		if(deviceList != null && deviceList.size() > 0)
			deviceGrpIdArr = UserCategoryDeviceRelBean.arrayListToStringArr(deviceList);		
		return deviceGrpIdArr;
	}
	
	/**
	 * returns String array of device ids from userID
	 * @param userID
	 * @return userDeviceIdArr
	 */
	public static String[] getDeviceIdListForUser(int userID){
		TreeMap<Integer,CategoryInner.DeviceInner> catMap = ((CategoryInner)userCategoryDeviceRelBeanMap.get(userID)).categoryMap;
		Iterator<Integer> catKeyIt = catMap.keySet().iterator();
		ArrayList<Integer> deviceList = null;
		
		String[] userDeviceIdArr = null;
		ArrayList<Integer> userDeviceList = new ArrayList<Integer>();
		while(catKeyIt.hasNext()){
			deviceList = ((CategoryInner.DeviceInner)catMap.get(catKeyIt.next())).getDeviceList();
			if(deviceList != null){
				for(int tmp = 0 ; tmp<deviceList.size() ; tmp++){
					if(!userDeviceList.contains(deviceList.get(tmp)))
							userDeviceList.add(deviceList.get(tmp));
				}
			}
		}
		userDeviceIdArr = UserCategoryDeviceRelBean.arrayListToStringArr(userDeviceList);
		return userDeviceIdArr;
	}
	
	/**
	 * returns String array of device Group ids from userID
	 * @param userID
	 * @return
	 */
	public static String[] getDeviceGroupIdListForUser(int userID){
		TreeMap<Integer,CategoryInner.DeviceInner> catMap = ((CategoryInner)userCategoryDeviceRelBeanMap.get(userID)).categoryMap;
		Iterator<Integer> catKeyIt = catMap.keySet().iterator();
		ArrayList<Integer> deviceGroupList = null;
					
		String[] userDeviceGroupIdArr = null;
		ArrayList<Integer> userDeviceGroupList = new ArrayList<Integer>();
		while(catKeyIt.hasNext()){			
			deviceGroupList = ((CategoryInner.DeviceInner)catMap.get(catKeyIt.next())).getDeviceGroupList();
			if(deviceGroupList!=null){
				for(int tmp = 0 ; tmp<deviceGroupList.size() ; tmp++){
					if(!userDeviceGroupList.contains(deviceGroupList.get(tmp)))
							userDeviceGroupList.add(deviceGroupList.get(tmp));
				}
			}				
		}			
		userDeviceGroupIdArr = UserCategoryDeviceRelBean.arrayListToStringArr(userDeviceGroupList);
		return userDeviceGroupIdArr;
	}
    
	/**
	 * returns String array of device ids from categoryID
	 * @param categoryID
	 * 
	 */
	public static String[] getDeviceIdListForCategory(int categoryID){
		Iterator<Integer> userIdSet = userCategoryDeviceRelBeanMap.keySet().iterator();
		ArrayList<Integer> deviceList = null;
		ArrayList<Integer> totDeviceList = new ArrayList<Integer>();
		if(userIdSet != null)
			while(userIdSet.hasNext()){
				TreeMap<Integer,CategoryInner.DeviceInner> catMap = ((CategoryInner)userCategoryDeviceRelBeanMap.get(userIdSet.next())).categoryMap;
				if(catMap.containsKey(categoryID)){
					deviceList = ((CategoryInner.DeviceInner)catMap.get(categoryID)).getDeviceList();
					if(deviceList != null){
						for(int tmp = 0 ; tmp<deviceList.size() ; tmp++){
							if(!totDeviceList.contains(deviceList.get(tmp))){
								totDeviceList.add(deviceList.get(tmp));
							}
						}						
					}
				}
			}		
		return arrayListToStringArr(totDeviceList);
	}
	
	/**
	 * returns String array of device group ids from categoryID
	 * @param categoryID
	 * 
	 */
	public static String[] getDeviceGroupIdListForCategory(int categoryID){
		Iterator<Integer> userIdSet = userCategoryDeviceRelBeanMap.keySet().iterator();
		ArrayList<Integer> deviceGrpList = null;
		ArrayList<Integer> totDeviceGrpList = new ArrayList<Integer>();
		if(userIdSet != null)
			while(userIdSet.hasNext()){
				TreeMap<Integer,CategoryInner.DeviceInner> catMap = ((CategoryInner)userCategoryDeviceRelBeanMap.get(userIdSet.next())).categoryMap;
				if(catMap.containsKey(categoryID)){
					deviceGrpList = ((CategoryInner.DeviceInner)catMap.get(categoryID)).getDeviceGroupList();
					if(deviceGrpList != null){
						for(int tmp = 0 ;tmp<deviceGrpList.size() ; tmp++){
							if(!totDeviceGrpList.contains(deviceGrpList.get(tmp))){
								totDeviceGrpList.add(deviceGrpList.get(tmp));
							}						
						}
					}
				}
			}		
		return arrayListToStringArr(totDeviceGrpList);
	}
	
	/**
     * Delete SQL Record from database table.
     * @return positive integer on success
     */
    public static int deleteRecordForUserId(int userId){    	
		SqlReader sqlReader = null;
		int deleteValue = -1;
		
		try{
			sqlReader = new SqlReader(false);
			String deleteQuery = null;
			deleteQuery = "DELETE from tbluserdevicerel "+
						"WHERE userid ="+ userId;
			
			deleteValue=sqlReader.executeUpdate( deleteQuery,5);
			if (deleteValue >= 0){
				if(userCategoryDeviceRelBeanMap != null){
					userCategoryDeviceRelBeanMap.remove(userId);
				}else{
					loadAll();
					userCategoryDeviceRelBeanMap.remove(userId);
				}
			}
			CyberoamLogger.appLog.debug("exception in userCategoryDeviceRelBeanMap-> " + userCategoryDeviceRelBeanMap);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception in deleting from memory in liveuserbean " +e,e);
			deleteValue = -1;			
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){}
		}
		return deleteValue;
	}
    /**
     * Inserts SQL record into database table.
     * @return positive integer on success
     */
    public int insertRecordForUserId(){
        CyberoamLogger.appLog.debug("insert UserDeviceRel called ...");
        String insert = null;
        int insertValue=-1;
        SqlReader sqlReader = null;
        try{
            sqlReader = new SqlReader(false);
            insert ="insert into tbluserdevicerel "+
            	"(userid,deviceid,devicegroupid) values ("+ 
            	getUserId() + ",'" + getDeviceId() + "','" + getDeviceGroupId() + "')";
            insertValue = sqlReader.executeInsertWithLastid(insert,"userdevicerelid");
            CyberoamLogger.appLog.info("ID after insert : "+insertValue);
            if (insertValue != 0){
				setUserDeviceRelId(insertValue);
				if (UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap == null ){					
					UserCategoryDeviceRelBean.loadAll();					
				}

				CategoryInner catInner = new CategoryInner();
				userCategoryDeviceRelBeanMap.put(getUserId(),catInner);
				
				String deviceId;
				ArrayList<Integer> deviceList = null;
				ArrayList<Integer> deviceGrpList = null;
				String deviceIds = getDeviceId();
				StringTokenizer deviceSt = new StringTokenizer(deviceIds,",");
				while(deviceSt.hasMoreTokens()){
					deviceId = deviceSt.nextToken();
					int categoryId = DeviceBean.getRecordbyPrimarykey(Integer.parseInt(deviceId)).getCategoryId();					
					if(catInner.getCategory(categoryId) == null){
						CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
						catInner.setCategory(categoryId,deviceInner);
						deviceList = new ArrayList<Integer>();
						deviceList.add(Integer.parseInt(deviceId));
						deviceInner.setDeviceList(deviceList);
						
						deviceGrpList = new ArrayList<Integer>();								
						deviceInner.setDeviceGroupList(deviceGrpList);
					}
					else{
						((CategoryInner.DeviceInner)catInner.getCategory(categoryId)).getDeviceList().add(Integer.parseInt(deviceId));								
					}
				}
				
				String deviceGrpId;
				String deviceGrpIds = getDeviceGroupId();
				StringTokenizer deviceGrpSt = new StringTokenizer(deviceGrpIds,",");
				while(deviceGrpSt.hasMoreTokens()){
					deviceGrpId = deviceGrpSt.nextToken();
					int categoryId =((DeviceGroupBean)DeviceGroupBean.getDeviceGroupBeanMap().get(Integer.parseInt(deviceGrpId))).getCategoryID();
					if(catInner.getCategory(categoryId) == null){
						CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
						catInner.setCategory(categoryId,deviceInner);
						deviceGrpList = new ArrayList<Integer>();
						deviceGrpList.add(Integer.parseInt(deviceGrpId));
						deviceInner.setDeviceGroupList(deviceGrpList);
						
						deviceList = new ArrayList<Integer>();
						deviceInner.setDeviceList(deviceList);
					}
					else{
						((CategoryInner.DeviceInner)catInner.getCategory(categoryId)).getDeviceGroupList().add(Integer.parseInt(deviceGrpId));
					}
				}
			
				Iterator catIterator = CategoryBean.getAllCategoryIterator();
				int categoryItId;
				while(catIterator.hasNext()){
					categoryItId = ((CategoryBean)catIterator.next()).getCategoryId();
					if(catInner.getCategory(categoryItId) == null){
						CategoryInner.DeviceInner deviceInner = catInner.new DeviceInner();
						catInner.setCategory(categoryItId,deviceInner);
					}
					
				}
			}
        }catch(Exception e){
            CyberoamLogger.appLog.error("Got an exception while inserting record " + this + e,e);
            insertValue = -1;
        }finally{
            try{
                sqlReader.close();
            }catch(Exception e){}
        }
        return insertValue;
    }
    
    
    /**
     * insert device ids inside the cached TreeMap
     * @param deviceId
     * @return retStat
     */
    public static int insertRecordForDeviceId(int deviceId){
    	int retStat = 0;    	    			
		ArrayList<Integer> deviceList = null;
						
		int categoryId = DeviceBean.getRecordbyPrimarykey(deviceId).getCategoryId();		
		
		deviceList = ((CategoryInner.DeviceInner)((CategoryInner)UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap.get(1)).categoryMap.get(categoryId)).getDeviceList();
		if(null == deviceList){
			deviceList = new ArrayList<Integer>();
			((CategoryInner.DeviceInner)((CategoryInner)UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap.get(1)).categoryMap.get(categoryId)).setDeviceList(deviceList);
		}
		deviceList.add(deviceId);
		retStat = 1;		
    	
    	return retStat;
    }
    
    /**
     * delete deviceId from cached TreeMap
     * @param deviceId
     * @return retStat
     */
    public static int deleteRecordForDeviceId(int deviceId){
    	int retStat = 0;    	    	
    	DeviceBean deviceBean = DeviceBean.getRecordbyPrimarykey(deviceId);
    	if(null == deviceBean)
    		return 1;
		ArrayList<Integer> deviceList = null;								
		
		deviceList = ((CategoryInner.DeviceInner)((CategoryInner)UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap.get(1)).categoryMap.get(deviceBean.getCategoryId())).getDeviceList();
		deviceList.remove(new Integer(deviceId));
		retStat = 1;		
    	
    	return retStat;
    }
    
    /**
     * insert deviceGroupId inside the cached TreeMap 
     * @param deviceGroupId
     * @return retStat
     */
    public static int insertRecordForDeviceGroupId(int deviceGroupId){
    	int retStat = 0;    	    	    			    	
		ArrayList<Integer> deviceGroupList = null;
				
		int categoryId =((DeviceGroupBean)DeviceGroupBean.getDeviceGroupBeanMap().get(deviceGroupId)).getCategoryID();
		deviceGroupList = ((CategoryInner.DeviceInner)((CategoryInner)UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap.get(1)).categoryMap.get(categoryId)).getDeviceGroupList();
		if(null == deviceGroupList){
			deviceGroupList = new ArrayList<Integer>();
			((CategoryInner.DeviceInner)((CategoryInner)UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap.get(1)).categoryMap.get(categoryId)).setDeviceGroupList(deviceGroupList);
		}
		deviceGroupList.add(deviceGroupId);
		retStat = 1;
		
    	
    	return retStat;
    }
    
    /**
     * delete deviceGroupId from cached TreeMap
     * @param deviceGroupId
     * @return retStat
     */
    public static int deleteRecordForDeviceGroupId(int deviceGroupId){
    	int retStat = 0;    	    	
    	if(!DeviceGroupBean.getDeviceGroupBeanMap().containsKey(deviceGroupId))
    		return 1;
		ArrayList<Integer> deviceGroupList = null;
				
		int categoryId =((DeviceGroupBean)DeviceGroupBean.getDeviceGroupBeanMap().get(deviceGroupId)).getCategoryID();
		deviceGroupList = ((CategoryInner.DeviceInner)((CategoryInner)UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap.get(1)).categoryMap.get(categoryId)).getDeviceGroupList();
		deviceGroupList.remove(new Integer(deviceGroupId));
		retStat = 1;		
    	
    	return retStat;
    }

    /**
     * check if relation exist between userid and deviceid 
     * @param userId
     * @param deviceId
     * @return isExist
     */
    public static boolean isRelationshipExistsWithDevice(int userId, int deviceId){
    	boolean isExist = false;
    	if(userId == 1){
    		return true;
    	}
    	String[] deviceList = UserCategoryDeviceRelBean.getDeviceIdListForUser(userId);
    	for(int i=0 ; i<deviceList.length ; i++){
    		if(Integer.parseInt(deviceList[i]) == deviceId){
    			isExist = true;
    			break;
    		}
    	}
    	return isExist;
    }
    
    /**
     * check if relation exist between userid and deviceGroupid
     * @param userId
     * @param deviceGroupId
     * @return isExist
     */
    public static boolean isRelationshipExistsWithGroup(int userId, int deviceGroupId){
    	boolean isExist = false;
    	if(userId == 1){
    		return true;
    	}
    	String[] deviceGroupList = UserCategoryDeviceRelBean.getDeviceGroupIdListForUser(userId);
    	for(int i=0 ; i<deviceGroupList.length ; i++){
    		if(Integer.parseInt(deviceGroupList[i]) == deviceGroupId){
    			isExist = true;
    			break;
    		}
    	}
    	return isExist;
    }

    /**
     * update device id in cache for the given categoryId
     * @param deviceId
     * @param categoryId
     */
    public static void updateForDeviceId(int deviceId, int categoryId){
    	Iterator<Integer> userIdIt = UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap.keySet().iterator();
    	int userId;
    	TreeMap<Integer,CategoryInner.DeviceInner> catMap;
    	Iterator<Integer> catMapIt;    	
    	CategoryInner catInner = null;
    	int catId;
    	while(userIdIt.hasNext()){
    		userId = userIdIt.next();
    		if(!UserCategoryDeviceRelBean.isRelationshipExistsWithDevice(userId, deviceId)){
    			continue;
    		}
    		catInner = (CategoryInner)UserCategoryDeviceRelBean.userCategoryDeviceRelBeanMap.get(userId);
    		catMap = catInner.categoryMap;
    		catMapIt = catMap.keySet().iterator();
    		while(catMapIt.hasNext()){
    			catId = catMapIt.next();
    			if(catId != categoryId){
    				ArrayList<Integer> deviceList = ((CategoryInner.DeviceInner)catMap.get(catId)).getDeviceList();
    				if(deviceList != null && deviceList.contains(deviceId))
    					deviceList.remove(new Integer(deviceId));
    			}
    			else{    				
    				ArrayList<Integer> deviceList = ((CategoryInner.DeviceInner)catMap.get(catId)).getDeviceList();
    				if(deviceList == null){
    					deviceList = new ArrayList<Integer>();
    					((CategoryInner.DeviceInner)catMap.get(catId)).setDeviceList(deviceList);
    				}
    				if(deviceList != null && !deviceList.contains(deviceId))
    					deviceList.add(new Integer(deviceId));    				
    			}    			    			
    		}    		
    	}
    }
    
    /**
     * converts arrayList to String Array
     * @param arrList
     * @return deviceIdArr
     */
	public static String[] arrayListToStringArr(ArrayList<Integer> arrList){
		if(arrList == null){
			return null;
		}
		String[] deviceIdArr = new String[arrList.size()];
		for(int i=0; i<arrList.size() ; i++){
			deviceIdArr[i] = String.valueOf(arrList.get(i));
		}
		return deviceIdArr;
	}
		
}
