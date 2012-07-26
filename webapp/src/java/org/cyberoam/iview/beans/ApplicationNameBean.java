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


import java.util.LinkedHashMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This class represents Application Name entity.
 * @author Amit Maniar
 *
 */
public class ApplicationNameBean {

	private int applicationNameId = -1;
	private String applicationName = null;
	private int protocolGroupId  = -1;
	private int type  = -1;
	private int isDefault;
	
	/**
	 * Value of isDefault for default Application
	 */
	public final static int ISDEFAULT=0;
	
	/**
	 * Value of isDefault for modified Application
	 */
	public final static int UPDATED=2;
	
	/**
	 * Custom Applications are defined by user.
	 */
	public final static int CUSTOM = 2;

	/**
	 * Returns the name of Application.
	 * @return
	 */
	public String getApplicationName() {
		return applicationName;
	}
	
	/**
	 * Sets the name of Application.
	 * @param applicationName
	 */
	public void setApplicationName(String applicationName) {
		this.applicationName = applicationName;
	}
	
	/**
	 * Returns the Application name Id. 
	 * @return
	 */
	public int getApplicationNameId() {
		return applicationNameId;
	}

	/**
	 * Sets the Application name Id.
	 * @param applicationNameId
	 */
	public void setApplicationNameId(int applicationNameId) {
		this.applicationNameId = applicationNameId;
	}

	/**
	 * Returns Application group Id.
	 * @return
	 */
	public int getProtocolGroupId() {
		return protocolGroupId;
	}

	/**
	 * Sets Id of Application group.
	 * @param protocolGroupId
	 */
	public void setProtocolGroupId(int protocolGroupId) {
		this.protocolGroupId = protocolGroupId;
	}

	/**
	 * Returns the type of Application.
	 * <br>Here Application type can be DEFAULT or CUSTOM.
	 * @return
	 */
	public int getType() {
		return type;
	}

	/**
	 * Sets the type of Application.
	 * <br>Here Application type can be DEFAULT or CUSTOM.
	 * @param type
	 */
	public void setType(int type) {
		this.type = type;
	}
	

	/**
	 * @return the isDefault value of Application
	 */
	public int getIsDefault() {
		return isDefault;
	}

	/**
	 * @param isDefault set the isDefault value of Application
	 */
	public void setIsDefault(int isDefault) {
		this.isDefault = isDefault;
	}

	/**
	 * Obtains instance of application name entity by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static ApplicationNameBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		ApplicationNameBean applicationNameBean = new ApplicationNameBean();
    	try {
    		applicationNameBean.setApplicationNameId(rsw.getInt("applicationnameid"));
    		applicationNameBean.setApplicationName(rsw.getString("applicationname"));
    		applicationNameBean.setProtocolGroupId(rsw.getInt("protocolgroupid"));
    		applicationNameBean.setType(rsw.getInt("type"));
    		applicationNameBean.setIsDefault(rsw.getInt("isDefault"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("exception->getBeanByResultSetWrapper()->ApplicationNameBean: " + e);
    	}
    	return applicationNameBean;
    }

	/**
	 * Obtains instance of application name entity by SQL Record.
	 * @param primarykey
	 * @return
	 */
	public static ApplicationNameBean getSQLRecordbyPrimarykey(int primarykey) {    		
		ApplicationNameBean applicationNameBean = null;  
	 	ResultSetWrapper rsw = null;
	 	SqlReader sqlReader = null;
	 	String sqlQuery=null;
	 	try{
	 	  	sqlReader=new SqlReader(false);
	 	  	sqlQuery="select applicationnameid,applicationname,protocolgroupid,type,IsDefault from tblapplicationname" +" where applicationnameid="+primarykey;
	 	  	rsw=sqlReader.getInstanceResultSetWrapper(sqlQuery);
	 	  	if(rsw.next()) {
	 	  		applicationNameBean=ApplicationNameBean.getBeanByResultSetWrapper(rsw);
	 	  	}	 	  	
	 	 }catch(Exception e) {
	 	 	CyberoamLogger.repLog.error("Exception->getSQLRecordByPrimaryKey()-> ApplicationNameBean : " + e);
	 	 }finally{
		 	   try{
		 	    sqlReader.close();
		 	    rsw.close();
		 	   }catch(Exception e){}
		   }	 	  	 	 
	 	 return applicationNameBean;
	}
	
	/**
	 * Inserts SQL Record into tblapplicationname.
	 * @return positive integer if record inserted else returns negative integer.
	 */
	public int insertRecord(){
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			retStatus=checkForDuplicate();
			if(retStatus != -4){
				sqlReader=new SqlReader(false);
				sqlQuery="insert into tblapplicationname(applicationname,protocolgroupid,type) values("+StringMaker.makeString(getApplicationName())+","+getProtocolGroupId()+","+getType()+")";
				retStatus = sqlReader.executeInsertWithLastid(sqlQuery,"applicationnameid");
				if (retStatus >= 0) {
						setApplicationNameId(retStatus);
				}
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->insertRecord()->ApplicationNameBean: " + e);
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
	 * Updates SQL Record into tblapplicationname. 
	 * @return positive integer if record updated else returns negative integer.
	 */
	public int updateRecord(){
        String sqlQuery = null;		
		int retStatus = -1;	
		int isDefaultVal=1;
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			int currentVal=getSQLRecordbyPrimarykey(getApplicationNameId()).getIsDefault();
			if(currentVal==ISDEFAULT || currentVal==UPDATED)
				isDefaultVal=UPDATED;				
			sqlQuery="update tblapplicationname set protocolgroupid="+getProtocolGroupId()+",type="+getType()+",isDefault=" + isDefaultVal +" where applicationnameid="+getApplicationNameId();
			retStatus = sqlReader.executeUpdate(sqlQuery,120);
			if (retStatus >= 0) {
					retStatus = 1;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->updateRecord()->ApplicationNameBean: " + e);
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
	 * Deletes SQL Record from tblapplicationname.
	 * @return positive integer if record deleted else returns negative integer.
	 */
	public int deleteRecord(){
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="delete from tblapplicationname where applicationnameid="+getApplicationNameId();
			retStatus = sqlReader.executeUpdate(sqlQuery,120);
			if (retStatus >= 0) {
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->deleteRecord()->ApplicationNameBean: " + e);
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
	 * Checks for duplicate record based on application name.
	 * @return positive integer if duplicate record not found else returns negative integer.
	 */
	public int checkForDuplicate(){
        String sqlQuery = null;		
		int retStatus = -1;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="select count(*) as count from tblapplicationname where applicationname="+StringMaker.makeString(getApplicationName());
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery,120);
			if (rsw.next() && rsw.getInt("count")>0){ 
				retStatus=-4;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->checkForDuplicate()->ApplicationNameBean: " + e);
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
	 * Updates SQL Record into tblapplicationname.
	 * <br>This method sets relationship between Application group and Application name.
	 * @param protocolGroupId
	 * @param applicationnameid
	 * @return
	 */
	public static int manageProtocolGroup(int protocolGroupId,int applicationnameid){
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="update tblapplicationname set protocolgroupid="+protocolGroupId+" where applicationnameid="+applicationnameid;
			retStatus = sqlReader.executeUpdate(sqlQuery,120);
			if (retStatus >= 0) {
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->manageProtocolGroup()->ApplicationNameBean: " + e);
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
	 * Updates SQL Record into tblapplicationname.
	 * <br>This method sets relationship between Application group and given list of Application name.
	 * @param protocolGroupId
	 * @param applicationNameList
	 * @return
	 */
	public static int manageProtocolGroup(int protocolGroupId,String applicationNameList){
        String sqlQuery = null;
        int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="update tblapplicationname set protocolgroupid="+protocolGroupId+" where applicationnameid in ("+applicationNameList + ")";
			retStatus = sqlReader.executeUpdate(sqlQuery,120);
			if (retStatus >= 0) {
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->manageProtocolGroup()->ApplicationNameBean: " + e);
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
	 * Obtains {@link LinkedHashMap} for all instances of {@link ApplicationNameBean} from tblapplicationname.
	 * @param protocolgroupid
	 * @return {@link LinkedHashMap}
	 */
	public static LinkedHashMap getApplicationNameBeanMap(int protocolgroupid){
		LinkedHashMap applicationNameMap;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		String strQuery=null;
		ApplicationNameBean applicationNameBean = null;
		try{
			sqlReader = new SqlReader(false);
			applicationNameMap = new LinkedHashMap();
			strQuery = "select applicationnameid,applicationname,protocolgroupid,type,IsDefault from tblapplicationname where protocolgroupid="+protocolgroupid+" order by applicationname";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery,120);
			while(rsw.next()){
				applicationNameBean=getBeanByResultSetWrapper(rsw);
				applicationNameMap.put(new Integer(applicationNameBean.getApplicationNameId()),applicationNameBean);
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->getApplicationNameBeanMap()->ApplicationNameBean: " + e);
			return null;
		}finally{
			try{
				rsw.close();
				sqlReader.close();
			}catch(Exception e){}
		}
		return applicationNameMap;
	}
	
	/**
	 * Returns string representation of Application name.
	 */
	public String toString(){
		return "\n ApplicationNameBean \n Application Name :"+getApplicationName()
		+ "\n ProtocolGroupId :"+getProtocolGroupId()
		+"\n Type :"+getType()
		+"\n applicationNameId : "+getApplicationNameId();
	}
}
