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
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This class represents Protocol Identifier (Application Identifier) entity.
 * @author Amit Maniar
 *
 */
public class ProtocolIdentifierBean {

	/**
	 * 
	 */
	private int id = -1;
	private int applicationNameId = -1;
	private int protocol  =-1;
	private int port = -1;
	private int type = -1;
	private int isDefault;
	
	/**
	 * Given application identifier is specified default in iView.
	 */
	public final static int ISDEFAULT = 0;
	/**
	 * Value of isDefault for modified ProtocolGroup Identifier
	 */
	public final static int UPDATED=2;
	/**
	 * Given application identifier is specified by user in iView.
	 */	
	public final static int CUSTOM = 2;
	/**
	 * Used if Application uses TCP data packet.
	 */
	public final static int TCP = 6;
	/**
	 * Used if Application uses UDP data packet.
	 */
	public final static int UDP = 17;
	/**
	 * Used if Application uses ICMP data packet.
	 */
	public final static int ICMP = 1;
	private static long lastAccessed = System.currentTimeMillis();
    
	/**
	 * Obtains instance of {@link ProtocolIdentifierBean} from {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static ProtocolIdentifierBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		ProtocolIdentifierBean protocolIdentifierBean = new ProtocolIdentifierBean();
    	try {
    		protocolIdentifierBean.setApplicationNameId(rsw.getInt("applicationnameid"));
    		protocolIdentifierBean.setId(rsw.getInt("id"));
    		protocolIdentifierBean.setProtocol(rsw.getInt("protocol"));
    		protocolIdentifierBean.setPort(rsw.getInt("port"));
    		protocolIdentifierBean.setType(rsw.getInt("type"));
    		protocolIdentifierBean.setIsDefault(rsw.getInt("isDefault"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("exception->getBeanByResultSetWrapper()->ProtocolIdentifierBean: " + e);
    	}
    	return protocolIdentifierBean;
    }

	/**
	 * Obtains instance of {@link ProtocolIdentifierBean} from SQL Record.
	 * @param primarykey
	 * @return
	 */
	public static ProtocolIdentifierBean getSQLRecordbyPrimarykey(int primarykey) {    		
		ProtocolIdentifierBean protocolIdentifierBean = null;  
	 	ResultSetWrapper rsw = null;
	 	SqlReader sqlReader = null;
	 	String sqlQuery=null;
	 	try{
	 	  	sqlReader=new SqlReader(false);
	 	  	sqlQuery="select id,applicationnameid,protocol,port,type from tblprotocolidentifier" +" where id="+primarykey;
	 	  	rsw=sqlReader.getInstanceResultSetWrapper(sqlQuery);
	 	  	if(rsw.next()){
	 	  		protocolIdentifierBean=ProtocolIdentifierBean.getBeanByResultSetWrapper(rsw);
	 	  	}	 	  	
	 	 }catch(Exception e) {
	 	 	CyberoamLogger.repLog.error("Exception->getSQLRecordByPrimaryKey()-> ProtocolIdentifierBean : " + e);
	 	 }finally{
		 	   try{
		 	    sqlReader.close();
		 	    rsw.close();
		 	   }catch(Exception e){}
		   }	 	  	 	 
	 	 return protocolIdentifierBean;
	}
	
	/**
	 * This method checks for application using given protocol with in given port number range.
	 * @param portStart
	 * @param portEnd
	 * @param protocol
	 * @return Application name that matches protocol and any port number with in given range.
	 */
	public static String checkForDuplicate(int portStart,int portEnd,int protocol){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
        String applicationName=null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			if(portEnd > 0){
				sqlQuery="select applicationname from tblapplicationname,tblprotocolidentifier where protocol="+protocol+" and port>="+portStart+" and port<="+portEnd+" and tblapplicationname.applicationnameid=tblprotocolidentifier.applicationnameid limit 5";
			}else{
				sqlQuery="select applicationname from tblapplicationname,tblprotocolidentifier where protocol="+protocol+" and port="+portStart+" and tblapplicationname.applicationnameid=tblprotocolidentifier.applicationnameid";
			}
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery,120);
			while(rsw.next()){ 
				applicationName=rsw.getString("applicationname")+",";
			}
			if(applicationName != null)
				applicationName=applicationName.substring(0,applicationName.lastIndexOf(","));
			CyberoamLogger.regLog.debug("ApplicationNames = "+applicationName);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->checkForDuplicate()->ProtocolIdentifierBean: " + e);
			return null;
		}finally{
			try {
				rsw.close();
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		return applicationName;
	}
	
	/**
	 * Inserts SQL Record of Application identifier into database table tblprotocolidentifier.
	 * @return
	 */
	public int insertRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="insert into tblprotocolidentifier(applicationnameid,protocol,port,type) values("+getApplicationNameId()+","+getProtocol()+","+getPort()+","+getType()+")";
			retStatus = sqlReader.executeInsertWithLastid(sqlQuery,"id");
			if (retStatus >= 0) {
					setId(retStatus);
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->insertRecord()->ProtocolIdentifierBean: " + e);
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
	 * Deletes SQL Record of Application identifier from database table tblprotocolidentifier.
	 * @return
	 */
	public int deleteRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="delete from tblprotocolidentifier where id="+getId();
			retStatus = sqlReader.executeUpdate(sqlQuery,120);
			if (retStatus >= 0) {
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->deleteRecord()->ProtocolIdentifierBean: " + e);
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
	 * Obtains all instances of {@link ProtocolIdentifierBean} from database table tblprotocolidentifier and stores into {@link LinkedHashMap}.
	 * @param applicationnameid
	 * @return
	 */
	public static LinkedHashMap getProtocolIdentifierBeanMap(int applicationnameid){
		LinkedHashMap protocolIdentifierBeanMap;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		String strQuery=null;
		ProtocolIdentifierBean protocolIdentifierBean = null;
		try{
			sqlReader = new SqlReader(false);
			protocolIdentifierBeanMap = new LinkedHashMap();
			strQuery = "select id,applicationnameid,protocol,port,type,isDefault from tblprotocolidentifier where applicationnameid="+applicationnameid+" order by protocol,port";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery,120);
			while(rsw.next()){
				protocolIdentifierBean=getBeanByResultSetWrapper(rsw);
				protocolIdentifierBeanMap.put(new Integer(protocolIdentifierBean.getId()),protocolIdentifierBean);
			}
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->getProtocolIdentifierBeanMap()->ProtocolIdentifierBean: " + e);
			return null;
		}finally{
			try{
				rsw.close();
				sqlReader.close();
			}catch(Exception e){}
		}
		return protocolIdentifierBeanMap;
	}
	/**
	 * Returns Application Id.
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * Sets Application identifier Id.
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Returns Application identifier name.
	 * @return the applicationNameId
	 */
	public int getApplicationNameId() {
		return applicationNameId;
	}

	/**
	 * Sets Application identifier name.
	 * @param applicationNameId the applicationNameId to set
	 */
	public void setApplicationNameId(int applicationNameId) {
		this.applicationNameId = applicationNameId;
	}

	/**
	 * Returns protocol used in Application identifier.
	 * @return the protocol
	 */
	public int getProtocol() {
		return protocol;
	}

	/**
	 * Sets protocol used in Application identifier.
	 * @param protocol the protocol to set
	 */
	public void setProtocol(int protocol) {
		this.protocol = protocol;
	}

	/**
	 * Returns port used in Application identifier.
	 * @return the port
	 */
	public int getPort() {
		return port;
	}

	/**
	 * Sets port used in Application identifier.
	 * @param port the port to set
	 */
	public void setPort(int port) {
		this.port = port;
	}

	/**
	 * Returns Application identifier type.This can be default or custom(User defined).
	 * @return the type
	 */
	public int getType() {
		return type;
	}

	/**
	 * Sets Application identifier type.This can be default or custom(User defined).
	 * @param type the type to set
	 */
	public void setType(int type) {
		this.type = type;
	}
	
	/**
	 * Returns the isDefault value of Application identifier
	 * @return the isDefault
	 */
	public int getIsDefault() {
		return isDefault;
	}
	
	/**
	 * Sets the isDefault value of Application identifier
	 * @param isDefault the isDefault to set
	 */
	public void setIsDefault(int isDefault) {
		this.isDefault = isDefault;
	}	

	/**
	 * Returns string representation of Application identifier.
	 */
	public String toString(){
		return "ProtocolIdentifierBean id :"+getId()
		+"\n applicationnameid :"+getApplicationNameId()
		+"\n protocol :"+getProtocol()
		+"\n port :"+getPort()
		+"\n type :"+getType();
	}
}
