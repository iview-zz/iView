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
import java.util.Iterator;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This class represents Application entity.
 * @author Narendra Shah
 */
public class ApplicationBean {

	private int iApplicationId;
	private String strApplicationName;
	private int iRoleId;
	private String strEqualCheck;
	private static TreeMap applicationBeanMap = null ;
	
	static{
		loadAll();
	}
	
	/**
	 * Get application identifier. 
	 * @return application Id 
	 */
	public int getApplicationId() {
		return iApplicationId;
	}
	/**
	 * Set application Identifier.
	 * @param applicationId
	 */
	public void setApplicationId(int applicationId) {
		iApplicationId = applicationId;
	}

	/**
	 * Get Application Name.
	 * @return application name.
	 */
	public String getApplicationName() {
		return strApplicationName;
	}

	/**
	 * Set Application Name.
	 * @param strApplicationName
	 */
	public void setApplicationName(String strApplicationName) {
		this.strApplicationName = strApplicationName;
	}

	/**
	 * Get user role identifier.
	 * @return role Id
	 */
	public int getRoleId() {
		return iRoleId;
	}

	/**
	 * Set user role identifier.
	 * @param roleId - user role
	 */
	public void setRoleId(int roleId) {
		iRoleId = roleId;
	}

	/**
	 * Get equal check.
	 * @return equal check
	 */
	public String getEqualCheck() {
		return strEqualCheck;
	}

	/**
	 * Set equal check
	 */
	public void setEqualCheck(String strEqualCheck) {
		this.strEqualCheck = strEqualCheck;
	}

	
	/**
	 * Loading cache for ApplicationBean
	 * @return true on successful loading else returns false
	 */
	public static synchronized boolean loadAll(){
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		ApplicationBean applicationBean = null;
		applicationBeanMap=new TreeMap();
		String strQuery="select appid,appname,equalcheck,roleid from tblapplication";
		try{
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);
			while(rsw.next()){
				applicationBean = getBeanByResultSetWrapper(rsw);
				CyberoamLogger.repLog.debug("ApplicationBean : "+ applicationBean);
				applicationBeanMap.put(applicationBean.getApplicationName(), applicationBean);
			}
			retStatus = true;
		}
		catch(Exception e){
			retStatus =false;
			CyberoamLogger.repLog.error("Exception->loadApplicationWithoutParameters()->ApplicationBean : "+ e, e);
		}finally{
			try {
				sqlReader.close();
				rsw.close();
			}catch (Exception e) {
				// TODO: handle exception
			}
		}
		return retStatus;
	}
	
	
	/***
	 * Returns instance of {@link ApplicationBean} from {@link ResultSetWrapper}.
	 * @param rsw - result set wrapper
	 * @return ApplicationBean
	 */
    public static ApplicationBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	ApplicationBean applicationBean = new ApplicationBean();
    	try {
    			applicationBean.setApplicationId(rsw.getInt("appid"));
    			applicationBean.setApplicationName(rsw.getString("appname"));
    			applicationBean.setEqualCheck(rsw.getString("equalcheck"));
    			applicationBean.setRoleId(rsw.getInt("roleid"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->ApplicationBean: " + e,e);
    	}
    	return applicationBean;
    }
    /**
     * Returns instance {@link ApplicationBean} from cache.
     * @param primaryKey - application Id
     * @return {@link ApplicationBean} instance which matches with the given Application.
     */
    public static ApplicationBean getRecordByPrimaryKey(String primaryKey){
    	return (ApplicationBean)applicationBeanMap.get(primaryKey);
    }
    /**
     * Returns {@link ApplicationBean} from database using query.
     * @param primaryKey - application Id
     * @return {@link ApplicationBean} object which matches with the given Application.
     */
    public static ApplicationBean getSQLRecordByPrimaryKey(String primaryKey){
		ApplicationBean applicationBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select appid,appname,equalcheck,roleid from tblapplication where appname = "+ StringMaker.makeString(primaryKey) ;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			if(rsw.next()){
				applicationBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> ApplicationBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> ApplicationBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){
			}
			try{
				rsw.close();
			}catch(Exception e){
			}
		}
		return applicationBean;
	}
    
    /**
     * Returns {@link Iterator} of all instances of {@link ApplicationBean}. 
     * @return iterator of applications
     */
	public static Iterator getApplicationBeanIterator() {
       Iterator iterator=null;
       try {    	   
    	   	iterator=applicationBeanMap.values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.sysLog.error("exception->getReportBeanIterator()->ApplicationBean: " + e,e);
       }
       return iterator;
    }
	
	/**
	 * Returns string representation of {@link ApplicationBean}. 
	 */
    public String toString(){
    	String strString="";
    	strString="appid="+getApplicationId()+
    	"\tappname="+getApplicationName() +
    	"\tequalcheck=" + getEqualCheck() +
    	"\troleid=" + getRoleId();
    	return strString;
    }
}
