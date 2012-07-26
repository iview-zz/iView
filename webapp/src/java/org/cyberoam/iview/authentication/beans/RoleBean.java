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
import java.util.TreeMap;
import java.util.Iterator;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/***
 * This class represents User Role entity.
 * @author Narendra Shah
 */
public class RoleBean {

	private int iRoleId;
	private String strRoleName;
	private int iLevel;
	
	/**
	 * Super administrator role Id.
	 */
	public final static int SUPER_ADMIN_ROLE_ID = 1;
	
	/**
	 * Administrator role Id.
	 */
	public final static int ADMIN_ROLE_ID = 2;
	
	/**
	 * Viewer role Id.
	 */
	public final static int VIEWER_ROLE_ID = 3;
	
	/**
	 * {@link TreeMap} containing user role beans.
	 */
	private static TreeMap roleBeanMap = null ;
	
	/**
	 * Returns role id.
	 * @return role Id
	 */
	public int getRoleId() {
		return iRoleId;
	}

	/**
	 * Sets role id 
	 */
	public void setRoleId(int roleId) {
		iRoleId = roleId;
	}

	/**
	 * Returns role name of user. 
	 * @return user role name
	 */
	public String getRoleName() {
		return strRoleName;
	}

	/**
	 * Sets role name of user.
	 */
	public void setRoleName(String strRoleName) {
		this.strRoleName = strRoleName;
	}

	/**
	 * Returns role level of user.
	 * @return user role level
	 */
	public int getLevel(){
		return iLevel;
	}
	
	/**
	 * Sets role level of user.
	 */
	public void setLevel(int iLevel){
		this.iLevel=iLevel;
	}
	
	static{
		loadAll();
	}
	
	/**
	 * Obtains all records of user roles from database table  into roleBean {@link TreeMap}.
	 * @return true if all records loaded successfully.
	 */
	public static synchronized boolean loadAll(){
		if (roleBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		RoleBean roleBean = null;
		String strQuery=null;
		try {
			roleBeanMap = new TreeMap();
			strQuery="select roleid,rolename,level from tblrole order by roleid";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				roleBean= RoleBean.getBeanByResultSetWrapper(rsw);
				if (roleBean != null) {
					roleBeanMap.put(new Integer(roleBean.getRoleId()), roleBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->RoleBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->RoleBean : "+ e, e);
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
	 * Obtain {@link RoleBean} by {@link ResultSetWrapper}.
	 * @param rsw - result set wrapper
	 * @return user role entity
	 */
    public static RoleBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	RoleBean roleBean = new RoleBean();
    	try {
    		roleBean.setRoleId(rsw.getInt("roleid"));
    		roleBean.setRoleName(rsw.getString("rolename"));
    		roleBean.setLevel(rsw.getInt("level"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->RoleBean: " + e,e);
    	}
    	return roleBean;
    }
    
    /**
     * Obtain instance of {@link RoleBean} by roleId from roleBeanMap. 
     * @param primarykey - role Id
     * @return user role entity
     */
    public static RoleBean getRecordbyPrimarykey(int primarykey) {        
    	RoleBean roleBean=null;
        try {
        	if(roleBeanMap==null) {
        		loadAll();
        	}
        	roleBean=(RoleBean)roleBeanMap.get(new Integer(primarykey));
        	if(roleBean==null) {
        		roleBean=getSQLRecordByPrimaryKey(primarykey);
        		if(roleBean!=null) {
        			roleBeanMap.put(new Integer(roleBean.getRoleId()),roleBean);
        		}
        	}        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->RoleBean: " + e,e);
        }
        return roleBean;
    }
    
    /**
     * Obtain instance of {@link RoleBean} by roleId from roleBeanMap.
     * @param primarykey - role Id
     * @return user role entity
     */
    public static RoleBean getRecordbyPrimarykey(String primarykey) {
    	try {
    		return getRecordbyPrimarykey(Integer.parseInt(primarykey));
    	}catch(Exception e){
    		CyberoamLogger.repLog.debug("Role Bean primary key Parsing error : " +e, e);
    	}    	
    	return null;
    }
    
    /**
     * Obtain instance of {@link RoleBean} by roleId from database table.
     * @param primaryKey - role Id
     * @return user role entity
     */
    private static RoleBean getSQLRecordByPrimaryKey(int primaryKey){
		RoleBean roleBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select roleid,rolename,level from tblrole where roleid="+ primaryKey ;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				roleBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> RoleBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> RoleBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return roleBean;
	}
    
    /**
     * Obtains {@link TreeMap} of {@link RoleBean}.
     * @return treemap of user role entities
     */
    public static TreeMap getRoleBeanMap() {
        try {
              if(roleBeanMap==null) {
				loadAll();
              }			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getReportBeanMap()->RoleBean: " + e,e);
		}
		return roleBeanMap;
    }
    
    /**
     * Obtain {@link Iterator} of {@link RoleBean}.
     * @return iterator of user role entities
     */
    public static Iterator getRoleBeanIterator() {
       Iterator iterator=null;
       try {    	   
    	   	iterator=getRoleBeanMap().values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.sysLog.error("exception->getReportBeanIterator()->RoleBean: " + e,e);
       }
       return iterator;
    }
    
    /**
     * Returns string representation of role entity.
     */
    public String toString(){
    	String strString="";
    	strString="roleId="+getRoleId()+
    	"\trolename="+getRoleName();
    	return strString;
    }

}
