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
package org.cyberoam.iview.helper;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.ApplicationNameBean;
import org.cyberoam.iview.beans.ProtocolGroupBean;
import org.cyberoam.iview.beans.ProtocolIdentifierBean;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This helper class is used to manage Protocol Group (Application Group) into database.
 * @author Amit Maniar
 *
 */
public class ProtocolGroupHelper {

	/**
	 * This method is used to insert Protocol Group (Application Group) into database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int addProtocolGroup(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ProtocolGroupBean protocolGroupBean = null;
		try{
			protocolGroupBean = new ProtocolGroupBean();
			String protocolgroup = request.getParameter("protocolgroupname");
			String description = request.getParameter("description");
			protocolGroupBean.setDescription(description);
			protocolGroupBean.setProtocolGroup(protocolgroup);
			returnStatus = protocolGroupBean.insertRecord();
			if(returnStatus > 0) {
				AuditLog.application.info("Application Group " + protocolgroup + " is Added", request);
			}
			if(returnStatus != -4)
				returnStatus = manageProtocol(request, response, protocolGroupBean.getProtocolgroupId());
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside addProtocolGroup() :ProtocolGroupHelper "+e,e);			
			returnStatus = -1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to update Protocol Group (Application Group) into database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int updateProtocolGroup(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ProtocolGroupBean protocolGroupBean = null;
		try{
			String protocolGroupId = request.getParameter("id");
			int id = -1;
			if(protocolGroupId != null && !"null".equalsIgnoreCase(protocolGroupId)){
				protocolGroupId=protocolGroupId.trim();
				id= new Integer(protocolGroupId).intValue();
			}
			protocolGroupBean=ProtocolGroupBean.getSQLRecordbyPrimarykey(id);
			if(protocolGroupBean != null){
				String description = request.getParameter("description");
				protocolGroupBean.setDescription(description);
				returnStatus = protocolGroupBean.updateRecord();
				if(returnStatus > 0) {
					AuditLog.application.info("Application Group " + protocolGroupBean.getProtocolGroup()  + " is updated", request);
				}
				returnStatus = manageProtocol(request, response, id);
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside updateProtocolGroup() :ProtocolGroupHelper "+e,e);
			returnStatus = -1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to delete Protocol Group (Application Group) from database table. 
	 * @param request
	 * @param response
	 * @return
	 */
	public static int deleteProtocolGroup(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ProtocolGroupBean protocolGroupBean = null;
		LinkedHashMap applicationNameMap = null;
		String applicationNameList = "";
		try{
			String protocolGroupId = request.getParameter("id");
			int id = -1;
			if(protocolGroupId != null && !"null".equalsIgnoreCase(protocolGroupId)){
				protocolGroupId=protocolGroupId.trim();
				id= new Integer(protocolGroupId).intValue();
			}
			applicationNameMap = ApplicationNameBean.getApplicationNameBeanMap(id);
			if(applicationNameMap != null){
				Iterator iterator = applicationNameMap.values().iterator();
				ApplicationNameBean applicationNameBean = null;
				int applicationCnt = 0;
				while(iterator.hasNext()){
					applicationNameBean=(ApplicationNameBean)iterator.next();
					if(applicationNameBean.getProtocolGroupId() == id)
						applicationNameList += String.valueOf(applicationNameBean.getApplicationNameId()) + (",");
				}
			}
			if(!applicationNameList.equalsIgnoreCase("")){
				applicationNameList =applicationNameList.substring(0, applicationNameList.lastIndexOf(","));
			}
			CyberoamLogger.appLog.debug("deleteProtocolGroup() : Application Name Id List : " + applicationNameList);
			returnStatus=ApplicationNameBean.manageProtocolGroup(ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP,applicationNameList);
			protocolGroupBean=ProtocolGroupBean.getSQLRecordbyPrimarykey(id);
			if(protocolGroupBean != null){
				returnStatus = protocolGroupBean.deleteRecord();
				if(returnStatus > 0) {
					AuditLog.application.info("Application Group " + protocolGroupBean.getProtocolGroup()  + " is Deleted", request);
				}
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside deleteProtocolGroup() :ProtocolGroupHelper "+e,e);
			returnStatus = -1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to insert Protocol (Application) into database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int addProtocol(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ApplicationNameBean applicationNameBean = null;
		ProtocolGroupBean protocolGroupBean = null;
		try{
			String applicationName=request.getParameter("applicationname");
			String protocolGroup = request.getParameter("protocolgroup");
			int protocolGroupId = -1;
			if(protocolGroup != null && !"null".equalsIgnoreCase(protocolGroup)){
				protocolGroup=protocolGroup.trim();
				protocolGroupId= new Integer(protocolGroup).intValue();
			}
			applicationNameBean = new ApplicationNameBean();
			applicationNameBean.setApplicationName(applicationName);
			applicationNameBean.setProtocolGroupId(protocolGroupId);
			applicationNameBean.setType(ApplicationNameBean.CUSTOM);
			returnStatus = applicationNameBean.insertRecord();
			if(returnStatus > 0) {
				protocolGroupBean=ProtocolGroupBean.getSQLRecordbyPrimarykey(protocolGroupId);
				AuditLog.application.info("Application " + applicationName + " is Added in Appication Group " + protocolGroupBean.getProtocolGroup() , request);
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside addProtocol() :ProtocolGroupHelper "+e,e);
			returnStatus=-1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to manage Protocol (Application) into database table.
	 * @param request
	 * @param response
	 * @param protocolGroupId
	 * @return
	 */
	public static int manageProtocol(HttpServletRequest request,HttpServletResponse response,int protocolGroupId){
		int returnStatus = 1;
		try{
			String[] applicationNames = request.getParameterValues("selectedapps");
			ArrayList selectedList = new ArrayList();
			String newAppList = "";
			String oldAppList = "";
			LinkedHashMap protoMap=ApplicationNameBean.getApplicationNameBeanMap(protocolGroupId);
			Iterator protoKeyIterator = protoMap.keySet().iterator();
			Integer appID=null;
			for(int i=0;i<applicationNames.length;i++){
				appID=new Integer(applicationNames[i]);
				selectedList.add(appID);
				if(!protoMap.containsKey(appID)){
					CyberoamLogger.appLog.debug("Application ID[" + i + "] : " +applicationNames[i]);
					newAppList += applicationNames[i] ;
					if(i != applicationNames.length -1)
						newAppList+=",";
					continue;
				}
			
			}
			CyberoamLogger.appLog.debug("New IDS" +newAppList);
			Integer nextOldID=null;
			while(protoKeyIterator.hasNext()){
				nextOldID=(Integer)protoKeyIterator.next();
				if(!selectedList.contains(nextOldID)){
					oldAppList+=nextOldID + ",";
				}
			}
			CyberoamLogger.appLog.debug("OLD IDS" +oldAppList);
			if(!newAppList.equalsIgnoreCase("")){
				returnStatus = ApplicationNameBean.manageProtocolGroup(protocolGroupId,newAppList);
			}
			if(!oldAppList.equalsIgnoreCase("")){
				oldAppList = oldAppList.substring(0, oldAppList.lastIndexOf(","));
				returnStatus = ApplicationNameBean.manageProtocolGroup(ProtocolGroupBean.UNASSIGNED_PROTOCOL_GROUP,oldAppList);
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside manageProtocol() :ProtocolGroupHelper "+e,e);
			returnStatus=-1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to update Protocol (Application) into database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int updateProtocol(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ApplicationNameBean applicationNameBean = null;
		ProtocolGroupBean protocolGroupBean = null;
		try{
			String applicationNameId=request.getParameter("id");
			int id = -1;
			if(applicationNameId != null && !"null".equalsIgnoreCase(applicationNameId)){
				applicationNameId=applicationNameId.trim();
				id= new Integer(applicationNameId).intValue();
			}
			String protocolGroup = request.getParameter("protocolgroup");
			int protocolGroupId = -1;
			if(protocolGroup != null && !"null".equalsIgnoreCase(protocolGroup)){
				protocolGroup=protocolGroup.trim();
				protocolGroupId= new Integer(protocolGroup).intValue();
			}
			applicationNameBean =ApplicationNameBean.getSQLRecordbyPrimarykey(id);
			if(applicationNameBean != null){
				applicationNameBean.setProtocolGroupId(protocolGroupId);
				returnStatus = applicationNameBean.updateRecord();
			}
			if(returnStatus > 0) {
				protocolGroupBean=ProtocolGroupBean.getSQLRecordbyPrimarykey(protocolGroupId);
				AuditLog.application.info("Application " + applicationNameBean.getApplicationName() + " is updated in Appication Group " + protocolGroupBean.getProtocolGroup() , request);
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside updateProtocol() :ProtocolGroupHelper "+e,e);
			returnStatus = -1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to delete Protocol (Application) from database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int deleteProtocol(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ApplicationNameBean applicationNameBean = null;
		LinkedHashMap protocolIdentifierBeanMap = null;
		ProtocolIdentifierBean protocolIdentifierBean = null;
		try{
			String applicationNameId=request.getParameter("id");
			int id = -1;
			if(applicationNameId != null && !"null".equalsIgnoreCase(applicationNameId)){
				id= new Integer(applicationNameId).intValue();
			}
			protocolIdentifierBeanMap = ProtocolIdentifierBean.getProtocolIdentifierBeanMap(id);
			if(protocolIdentifierBeanMap != null){
				Iterator iterator = protocolIdentifierBeanMap.values().iterator();
				while(iterator.hasNext()){
					protocolIdentifierBean=(ProtocolIdentifierBean)iterator.next();
					returnStatus=protocolIdentifierBean.deleteRecord();
				}
			}
			applicationNameBean =ApplicationNameBean.getSQLRecordbyPrimarykey(id);
			if(applicationNameBean != null){
				returnStatus = applicationNameBean.deleteRecord();
			}
			if(returnStatus > 0) {
				AuditLog.application.info("Application " + applicationNameBean.getApplicationName() + " is deleted", request);
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside deleteProtocol() :ProtocolGroupHelper "+e,e);
			returnStatus = -1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to insert Protocol Identifier (Application Identifier) into database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int addProtocolIdentifier(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ProtocolIdentifierBean protocolIdentifierBean = null;
		try{
			String strFrom = null,strTo=null,strProtocol,strapplicationNameId;
			ApplicationNameBean applicationNameBean = null;
			String identifierForAuditLog = "";
			int iFromValue=-1,iToValue=-1,iProtocol=-1,applicationNameId=-1;
			strFrom=request.getParameter("txtFrom");
			strTo=request.getParameter("txtTo");
			strProtocol=request.getParameter("rdoProtocol");
			strapplicationNameId=request.getParameter("applicationnameid");
			if(strFrom != null && !"null".equalsIgnoreCase(strFrom)){
				strFrom=strFrom.trim();
				iFromValue = new Integer(strFrom);
			}
			if(strTo != null && !"null".equalsIgnoreCase(strTo)){
				strTo=strTo.trim();
				iToValue = new Integer(strTo);
			}
			if(strProtocol != null && !"null".equalsIgnoreCase(strProtocol)){
				strProtocol=strProtocol.trim();
				iProtocol = new Integer(strProtocol);
			}
			if(strapplicationNameId != null && !"null".equalsIgnoreCase(strapplicationNameId)){
				strapplicationNameId=strapplicationNameId.trim();
				applicationNameId = new Integer(strapplicationNameId);
			}
			
			if(iToValue > iFromValue){
				for(int i=iFromValue;i<=iToValue;i++){
					protocolIdentifierBean = new ProtocolIdentifierBean();
					protocolIdentifierBean.setApplicationNameId(applicationNameId);
					protocolIdentifierBean.setPort(i);
					protocolIdentifierBean.setProtocol(iProtocol);
					protocolIdentifierBean.setType(ProtocolIdentifierBean.CUSTOM);
					returnStatus=protocolIdentifierBean.insertRecord();
				}
			}else{
				protocolIdentifierBean = new ProtocolIdentifierBean();
				protocolIdentifierBean.setApplicationNameId(applicationNameId);
				protocolIdentifierBean.setPort(iFromValue);
				protocolIdentifierBean.setProtocol(iProtocol);
				protocolIdentifierBean.setType(ProtocolIdentifierBean.CUSTOM);
				returnStatus=protocolIdentifierBean.insertRecord();
			}
			
			if(returnStatus > 0) {
				if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.TCP)
					identifierForAuditLog="tcp";
				else if(protocolIdentifierBean.getProtocol() == ProtocolIdentifierBean.UDP)
					identifierForAuditLog="udp";			
				identifierForAuditLog = identifierForAuditLog + " port " + iFromValue + (iToValue>iFromValue?  " to " +  iToValue : "") ;
				
				applicationNameBean =ApplicationNameBean.getSQLRecordbyPrimarykey(applicationNameId);
				AuditLog.application.info("Application Identifier " + identifierForAuditLog + " is added in Application" + applicationNameBean.getApplicationName() , request);
			}
			
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside addProtocolIdentifier() :ProtocolGroupHelper "+e,e);
			returnStatus=-1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to update Protocol Identifier (Application Identifier) into database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int updateProtocolIdentifier(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		try{
			
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside updateProtocolIdentifier() :ProtocolGroupHelper "+e,e);
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to delete Protocol Identifier (Application Identifier) from database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int deleteProtocolIdentifier(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ApplicationNameBean applicationNameBean = null;
		ProtocolIdentifierBean protocolIdentifierBean = null;
		try{
			String strId=request.getParameter("protocolidentifierid");
			CyberoamLogger.appLog.debug("ProtocolIdentifierId :"+strId);
			int id = -1;
			if(strId != null && !"null".equalsIgnoreCase(strId)){
				strId = strId.trim();
				id= new Integer(strId).intValue();
			}
			protocolIdentifierBean =ProtocolIdentifierBean.getSQLRecordbyPrimarykey(id);
			if(protocolIdentifierBean != null){
				returnStatus = protocolIdentifierBean.deleteRecord();
			}
			
			if(returnStatus > 0) {
				applicationNameBean =ApplicationNameBean.getSQLRecordbyPrimarykey(protocolIdentifierBean.getApplicationNameId());
				AuditLog.application.info("Application Identifier is deleted from Application" + applicationNameBean.getApplicationName() , request);
			}
			
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside deleteProtocolIdentifier() :ProtocolGroupHelper "+e,e);
			returnStatus = -1;
		}
		return returnStatus;
	}
	
	/**
	 * This method is used to reset Protocol Group(Application Group),Protocol(Application) and 
	 * Protocol Identifier(Application Identifier) information into database table.
	 * <br>Here default settings will be applied into database.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int resetApplication(HttpServletRequest request,HttpServletResponse response){
		int returnStatus=-2;
		SqlReader sqlReader=new SqlReader();
		try {
			String query;
			/**
			 * Delete all protocol related infomration.
			 */
		
			
			query="delete from tblprotocolgroup;";
			sqlReader.executeUpdate(query,180);
			query="delete from tblprotocolidentifier;";
			sqlReader.executeUpdate(query,180);
			query="delete from tblapplicationname;";
			sqlReader.executeUpdate(query,180);
			/**
			 * Copy defalut values to tables.
			 */
			
			query="alter sequence tblprotocolgroup_protocolgroupid_seq start with 1;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			query="alter sequence tblapplicationname_applicationnameid_seq start with 1;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			query="alter sequence tblprotocolidentifier_id_seq start with 1;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			
			query="insert into  tblprotocolgroup select * from  tblprotocolgroup_default;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			query="insert into  tblprotocolidentifier select * from  tblprotocolidentifier_default;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			query="insert into tblapplicationname select * from tblapplicationname_default ;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			
			query="alter sequence tblprotocolgroup_protocolgroupid_seq start with 100;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			query="alter sequence tblapplicationname_applicationnameid_seq start with 1000;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			query="alter sequence tblprotocolidentifier_id_seq start with 3000;";
			returnStatus=sqlReader.executeUpdate(query, 180);
			AuditLog.application.info("Application Groups,Applications and Application Identifiers are reset to Default" , request);
			returnStatus=0;
		}catch (Exception e) {
			returnStatus=-2;
			CyberoamLogger.appLog.debug("ApplicationGroupHelper.resetApplication:" + e,e);
		}
		return returnStatus;
	}
}

