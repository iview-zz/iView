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
package org.cyberoam.iview.beans;


import java.util.LinkedHashMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This class represents protocol group (Application group) entity.
 * @author Amit Maniar
 *
 */
public class ProtocolGroupBean {

	private int protocolgroupId = -1;
	private String protocolGroup  = null;
	private String description = null;
	private int isDefault;
	/**
	 * Protocol Group Id for unassigned Application name group.
	 */
	public final static int UNASSIGNED_PROTOCOL_GROUP=1;
	
	/**
	 * Value of isDefault for default ProtocolGroup
	 */
	public final static int ISDEFAULT=0;
	
	/**
	 * Value of isDefault for modified ProtocolGroup
	 */
	public final static int UPDATED=2;
	
	private static long lastAccessed = System.currentTimeMillis();

	/**
	 * Returns instance of {@link ProtocolGroupBean} from {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static ProtocolGroupBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		ProtocolGroupBean protocolGroupBean = new ProtocolGroupBean();
    	try {
    		protocolGroupBean.setProtocolgroupId(rsw.getInt("protocolgroupid"));
    		protocolGroupBean.setProtocolGroup(rsw.getString("protocolgroup"));
    		protocolGroupBean.setDescription(rsw.getString("description"));
    		protocolGroupBean.setIsDefault(rsw.getInt("isDefault"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("exception->getBeanByResultSetWrapper()->ProtocolGroupBean: " + e);
    	}
    	return protocolGroupBean;
    }

	/**
	 * Returns instance of {@link ProtocolGroupBean} created from SQL Record.
	 * @param primarykey
	 * @return
	 */
	public static ProtocolGroupBean getSQLRecordbyPrimarykey(int primarykey) {    		
		ProtocolGroupBean protocolGroupBean = null;  
	 	ResultSetWrapper rsw = null;
	 	SqlReader sqlReader = null;
	 	String sqlQuery=null;
	 	try{
	 	  	sqlReader=new SqlReader(false);
	 	  	sqlQuery="select protocolgroupid,protocolgroup,description,IsDefault from tblprotocolgroup" +" where protocolgroupid="+primarykey;
	 	  	rsw=sqlReader.getInstanceResultSetWrapper(sqlQuery);
	 	  	if(rsw.next()) {
	 	  		protocolGroupBean=ProtocolGroupBean.getBeanByResultSetWrapper(rsw);
	 	  	}	 	  	
	 	 }catch(Exception e) {
	 	 	CyberoamLogger.repLog.error("exception->getSQLRecordByPrimaryKey()-> ProtocolGroupBean : " + e);
	 	 	return null;
	 	 }finally{
		 	   try{
		 	    sqlReader.close();
		 	    rsw.close();
		 	   }catch(Exception e){}
		   }	 	  	 	 
	 	 return protocolGroupBean;
	}
	
	/**
	 * Inserts instance of {@link ProtocolGroupBean} into database.
	 * @return
	 */
	public int insertRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			retStatus=checkForDuplicate();
			if(retStatus != -4){
				sqlReader=new SqlReader(false);
				sqlQuery="insert into tblprotocolgroup(protocolgroup,description) values("+StringMaker.makeString(getProtocolGroup())+","+StringMaker.makeString(getDescription())+")";
				retStatus = sqlReader.executeInsertWithLastid(sqlQuery,"protocolgroupid");
				if (retStatus >= 0) {
						setProtocolgroupId(retStatus);
				}
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("exception->insertRecord()->ProtocolGroupBean: " + e);
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
	 * Updates instance of {@link ProtocolGroupBean} into database.
	 * @return
	 */
	public int updateRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;
		int isDefaultVal=1;
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			int currentVal=getSQLRecordbyPrimarykey(getProtocolgroupId()).getIsDefault();
			if(currentVal==ISDEFAULT || currentVal==UPDATED)
				isDefaultVal=UPDATED;
			sqlQuery="update tblprotocolgroup set protocolgroup="+StringMaker.makeString(getProtocolGroup())+",description="+StringMaker.makeString(getDescription())+",isDefault=" +isDefaultVal +" where protocolgroupid = "+getProtocolgroupId();
			retStatus = sqlReader.executeUpdate(sqlQuery,120);
			if (retStatus >= 0) {
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("exception->updateRecord()->ProtocolGroupBean: " + e);
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
	 * Deletes instance of {@link ProtocolGroupBean} into database.
	 * @return
	 */
	public int deleteRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="delete from tblprotocolgroup where protocolgroupid="+getProtocolgroupId();
			retStatus = sqlReader.executeUpdate(sqlQuery,120);
			if (retStatus >= 0) {
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->deleteRecord()->ProtocolGroupBean: " + e);
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
	 * This method checks for duplicate record into database.
	 * @return
	 */
	public int checkForDuplicate(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="select count(*) as count from tblprotocolgroup where protocolgroup="+StringMaker.makeString(getProtocolGroup());
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery,120);
			if (rsw.next() && rsw.getInt("count")>0){ 
				retStatus=-4;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->checkForDuplicate()->ProtocolGroupBean: " + e);
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
	 * Returns {@link LinkedHashMap} containing all instances of {@link ProtocolGroupBean}.
	 * Here all records will be retrieved from database.
	 * @return
	 */
	public static LinkedHashMap getProtocolGroupMap(){
		LinkedHashMap protocolGroupMap = new LinkedHashMap();
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		String strQuery=null;
		ProtocolGroupBean protocolGroupBean = null;
		try{
				sqlReader=new SqlReader(false);
				strQuery = "select protocolgroupid,protocolgroup,description,isDefault from tblprotocolgroup order by protocolgroup";
				rsw = sqlReader.getInstanceResultSetWrapper(strQuery,120);
				while(rsw.next()){
					protocolGroupBean=getBeanByResultSetWrapper(rsw);
					protocolGroupMap.put(new Integer(protocolGroupBean.getProtocolgroupId()), protocolGroupBean);
				}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->getProtocolGroupMap()->ProtocolGroupBean: " + e);
			return null;
		}finally{
			try{
				rsw.close();
				sqlReader.close();
			}catch(Exception e){}
		}
		return protocolGroupMap;
	}
	
	/**
	 * Returns name of Protocol Group.
	 * @return the protocolGroup
	 */
	public String getProtocolGroup() {
		return protocolGroup;
	}
	/**
	 * Sets name of Protocol Group.
	 * @param protocolGroup the protocolGroup to set
	 */
	public void setProtocolGroup(String protocolGroup) {
		this.protocolGroup = protocolGroup;
	}
	/**
	 * Returns description of Protocol Group.
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * Sets description of Protocol Group.
	 * @param description the description to set 
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * Returns Id of Protocol Group.
	 * @return the protocolgroupId
	 */
	public int getProtocolgroupId() {
		return protocolgroupId;
	}
	/**
	 * Sets Id of Protocol Group.
	 * @param protocolgroupId the protocolgroupId to set
	 */
	public void setProtocolgroupId(int protocolgroupId) {
		this.protocolgroupId = protocolgroupId;
	}		
	/**
	 * Returns isDefault value of Protocol Group.
	 * @return the protocolgroupId
	 */
	public int getIsDefault() {
		return isDefault;
	}
	/**
	 * Sets isDefault value of Protocol Group.
	 * @param protocolgroupId the protocolgroupId to set
	 */
	public void setIsDefault(int isDefault){
		this.isDefault=isDefault;
	}
	
	/**
	 * Returns string representation of {@link ProtocolGroupBean}.
	 */
	public String toString(){
		return "\n ProtocolGroupBean \n Protocol Group :"+getProtocolGroup()
		+"\n Description :"+getDescription()
		+"\n Protocolgroupid :"+getProtocolgroupId();
	}
}
