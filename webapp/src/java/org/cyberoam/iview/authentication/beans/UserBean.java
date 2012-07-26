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


import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/***
 * This class represents user entity.
 * @author Narendra Shah
 *
 */
public class UserBean {

	private int iUserId;
	private String strName;
	private String strUserName;
	private String strPassword;
	private int iRoleId;
	private String strCreatedBy;
	private String strEmail;
	private Date dateLastLoginTime;
	
	private static TreeMap userBeanMap = null ;
	
	/**
	 * Returns userId.
	 * @return user Id
	 */
	public int getUserId() {
		return iUserId;
	}
	
	/**
	 * Sets userId.
	 * @param uerId - user Id
	 */
	public void setUserId(int userId) {
		iUserId = userId;
	}
	
	/**
	 * Returns name of user.
	 * @return name of user
	 */
	public String getName() {
		return strName;
	}
	
	/**
	 * Sets name of user.
	 * @param strName - name of user
	 */
	public void setName(String strName) {
		this.strName = strName;
	}
	
	/**
	 * Returns name of parent user who has created this user.
	 * @return name of parent user
	 */
	public String getCreatedBy() {
		return strCreatedBy;
	}
	
	/**
	 * Sets name of parent user.
	 * @param strCreatedBy - name of parent user
	 */
	public void setCreatedBy(String strCreatedBy) {
		this.strCreatedBy = strCreatedBy;
	}
	
	/**
	 * Returns email address of user.
	 * @return user's email address
	 */
	public String getEmail() {
		return strEmail;
	}
	
	/**
	 * Sets email address of user.
	 * @param strEmail - user's email address
	 */
	public void setEmail(String strEmail) {
		this.strEmail = strEmail;
	}
	
	/**
	 * Returns last login time of user.
	 * @return last login time
	 */
	public Date getLastLoginTime() {
		return dateLastLoginTime;
	}
	
	/**
	 * Sets last login time of user.
	 * @param dateLastLoginTime - last login time
	 */
	public void setLastLoginTime(Date dateLastLoginTime) {
		this.dateLastLoginTime = dateLastLoginTime;
	}
	
	/**
	 * Returns username of user.
	 * @return username
	 */
	public String getUserName() {
		return strUserName;
	}
	
	/**
	 * Sets username of user.
	 * @param strUserName - username
	 */
	public void setUserName(String strUserName) {
		this.strUserName = strUserName;
	}
	
	/**
	 * Returns password of user.
	 * @return password
	 */
	public String getPassword() {
		return strPassword;
	}
	
	/**
	 * Sets password of user.
	 * @param strPassword - password
	 */
	public void setPassword(String strPassword) {
		this.strPassword = strPassword;
	}
	
	/**
	 * Returns roleId of user.
	 * @return role Id
	 */
	public int getRoleId() {
		return iRoleId;
	}
	
	/**
	 * Sets roleId of user.
	 * @param roleId - role Id
	 */
	public void setRoleId(int roleId) {
		iRoleId = roleId;
	}
	
	static{
		loadAll();
	}
	
	/**
	 * Loads all records of user into {@link TreeMap} of {@link UserBean} from database table.
	 * @return true if all entries loaded successfully
	 */
	public static synchronized boolean loadAll(){
		if (userBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		UserBean userBean = null;
		String strQuery=null;
		try {
			strQuery="select userid,name,username,password,createdby,email,lastlogintime,roleid from tbluser order by roleid";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);
			userBeanMap = new TreeMap();
			while (rsw.next()) {
				userBean= UserBean.getBeanByResultSetWrapper(rsw);
				if (userBean != null) {
					userBeanMap.put(userBean.getUserName(), userBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->UserBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->UserBean : "+ e, e);
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
     * Obtains instance of {@link UserBean} by {@link ResultSetWrapper}.
     * @param rsw - result set wrapper
     * @return user entity
     */
    public static UserBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	UserBean userBean = new UserBean();
    	try {
    			userBean.setUserId(rsw.getInt("userid"));
    			userBean.setUserName(rsw.getString("username"));
    			userBean.setPassword(rsw.getString("password"));
    			userBean.setRoleId(rsw.getInt("roleid"));
    			userBean.setCreatedBy(rsw.getString("createdby"));
    			userBean.setEmail(rsw.getString("email"));
    			if(rsw.getTimestamp("lastlogintime") != null){
    				userBean.setLastLoginTime(rsw.getTimestamp("lastlogintime"));
    			}else {
    				userBean.setLastLoginTime(null);
    			}
    			userBean.setName(rsw.getString("name"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->UserBean: " + e,e);
    	}
    	return userBean;
    }
    
    /**
     * Obtains instance of {@link UserBean} by userId from userBeanMap.
     * @param primarykey - user Id
     * @return user entity
     */
    public static UserBean getRecordbyPrimarykey(String primarykey) {        
    	UserBean userBean=null;
        try {
        	   if(userBeanMap==null) {
               	loadAll();
               }
        	   CyberoamLogger.appLog.debug("UserBean.userBeanMap->" + userBeanMap);
        	   CyberoamLogger.appLog.debug("UserBean.primary key->" + primarykey);
        	   userBean=(UserBean)userBeanMap.get(primarykey);
        	   if(userBean==null) {
        		   
        		   userBean=getSQLRecordByPrimaryKey(primarykey);
        		   if(userBean!=null) {
        			   userBeanMap.put(userBean.getUserName(),userBean);
        		   }
        	   }        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->UserBean: " + e,e);
        }
        return userBean;
    }
    
    /**
     * Authenticates user using username and password.
     * @param strUserName - username
     * @param strPassword - password
     * @return User entity on success else returns null
     */
    public static UserBean authenticate(String strUserName, String strPassword){
    	UserBean userBean = null;
    	userBean = (UserBean)userBeanMap.get(strUserName);
    	if(userBean != null){
    		if(!userBean.getPassword().equals(strPassword)){
    			userBean = null;
    		}
    	}
    	return userBean;
    }
    
    /**
     * Obtains instance of {@link UserBean} from database table using primary key.
     * @param primaryKey - user Id
     * @return user entity
     */
    private static UserBean getSQLRecordByPrimaryKey(String primaryKey){
		UserBean userBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select userid,name,username,password,createdby,email,lastlogintime,roleid from tbluser where username='"+ primaryKey + "'";			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				userBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> UserBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> UserBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return userBean;
	}
    
    /**
     * Obtains {@link Iterator} of instances of {@link UserBean} from userBeanMap.
     * @return user entity iterator
     */
    public static Iterator getUserBeanIterator() {
       Iterator iterator=null;
       try {   
    	   if(userBeanMap==null) {
				loadAll();
             }
    	   	iterator=userBeanMap.values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.sysLog.error("exception->getReportBeanIterator()->UserBean: " + e,e);
       }
       return iterator;
    }
    
    /**
     * Insert SQL record into database table.
     * @return  positive integer on success
     */
    public int insertRecord(){
        CyberoamLogger.repLog.debug("insert User called ...");
        String insert = null;
        int insertValue=-1;
        SqlReader sqlReader = null;
        try{
            sqlReader = new SqlReader(false);
            
            insert ="insert into tbluser "+
            "(name,username,password,createdby,email,lastlogintime,roleid) values"+ 
            "(" + StringMaker.makeString(strName) + "," + StringMaker.makeString(strUserName) + "," +
            StringMaker.makeString(strPassword) + "," + StringMaker.makeString(strCreatedBy) + "," +
            StringMaker.makeString(strEmail) + ",null," +
            iRoleId + ")";
            
            insertValue = sqlReader.executeInsertWithLastid(insert,"userid");
            CyberoamLogger.repLog.info("ID after insert : "+insertValue);
            
			if (insertValue != 0){
				setUserId(insertValue);
				if (UserBean.userBeanMap != null ){
					UserBean.userBeanMap.put(getUserName(),this);
				}else{
					UserBean.loadAll();
					UserBean.userBeanMap.put(getUserName(),this);
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
        CyberoamLogger.repLog.debug("insert record.userBeanMap-> " + userBeanMap.toString());
        return insertValue;
    }
    
    /**
     * Update SQL record into database table.
     * @return positive integer on success
     */
    public int updateRecord(){
        int updateValue=-1;
        String update = null;
        SqlReader sqlReader = null;
        try{
            sqlReader = new SqlReader(false);
            
            update = "update tbluser "+
            "set name = "+StringMaker.makeString(getName()) +","+
            "username = "+StringMaker.makeString(getUserName()) +","+
            "password = " + StringMaker.makeString(getPassword()) + "," +
            "createdby = "+StringMaker.makeString(getCreatedBy()) +","+
            "email = " + StringMaker.makeString(getEmail()) + "," + 
            "roleid = " + getRoleId() +
            " where userId="+ getUserId();
            updateValue=sqlReader.executeUpdate(update,5);
			if (updateValue > 0){
				if (UserBean.userBeanMap != null ){
					UserBean.userBeanMap.put(getUserName(),this);
				}
			}
			
			CyberoamLogger.repLog.debug("update record -> userBeanMap" + userBeanMap.toString());
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
	 * Delete record of user from database table.
	 * @return positive integer on success
	 */
	public int deleteRecord(){
		SqlReader sqlReader = null;
		int deleteValue = -1;
		try{
			sqlReader = new SqlReader(false);
			String deleteQuery = null;
			deleteQuery = "DELETE from tbluser "+"WHERE userid ="+ getUserId();
			deleteValue=sqlReader.executeUpdate( deleteQuery,5);
			if (deleteValue >= 0){
				if(userBeanMap != null){
					userBeanMap.remove(getUserName());
				}else{
					loadAll();
					userBeanMap.remove(getUserName());
				}
				UserCategoryDeviceRelBean.deleteRecordForUserId(getUserId());
			}
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
    
	/**
     * Update SQL record into database table.
     * @return positive integer on success
     */
    public int updateLoginTime(int userId, Date loginTime){
        int updateValue=-1;
        String update = null;
        SqlReader sqlReader = null;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try{
            sqlReader = new SqlReader(false);
            
            update = "update tbluser set "+
            "lastlogintime = " + StringMaker.makeString(simpleDateFormat.format(loginTime)) + 
            " where userId="+ userId;
            updateValue=sqlReader.executeUpdate(update,5);
            if (updateValue > 0){
				if (UserBean.userBeanMap != null ){
					this.setLastLoginTime(loginTime);
					UserBean.userBeanMap.put(getUserName(),this);
				}
			}
        }catch(Exception e){
            CyberoamLogger.appLog.error("Exception in updating login record: " + e,e);
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
	 * Returns string representation of user entity.
	 */
    public String toString(){
    	String strString="";
    	strString="userId="+getUserId()+
    	"\tusername="+getUserName()+
    	"\tpassword="+getPassword()+
    	"\troleid="+getRoleId();
       	return strString;
    }
}
