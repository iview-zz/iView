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


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This class represents report group entity.
 * @author Narendra Shah
 *
 */

public class ReportGroupBean {

	/**
	 * List Of Properties
	 */
	private int reportGroupId;
	private String title;
	private String description;
	private String inputParams;
	private int groupType;
	private double menuOrder;
	private int categoryId;
	
	/**
	 * Group type which can not be edited or deleted by iView user.
	 */
	public static int STATIC_GROUP = 1;
	/**
	 * Group type which can be edited or deleted by iView user For e.g. Report Profile.
	 */
	public static int DYNAMIC_GROUP = 2;
	
	/**
	 * Group type which are going to be in trend reports.
	 */
	public static int TREND_GROUP = 3;
	
	/**
	 * Group type which are going to be in search reports.
	 */
	public static int SEARCH_GROUP  = 4;
	
	private static long lastAccessed = System.currentTimeMillis();
	private static TreeMap reportGroupBeanMap = null ;
	
	static{
		loadAll();
	}
	
	/**
	 * Returns report group Id.
	 * @return the reportGroupId
	 */
	public int getReportGroupId() {
		return reportGroupId;
	}

	/**
	 * Sets report group Id.
	 * @param reportGroupId the reportGroupId to set
	 */
	public void setReportGroupId(int reportGroupId) {
		this.reportGroupId = reportGroupId;
	}

	/**
	 * Returns report group title.
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * Sets report group title.
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * Returns report group description.
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Sets report group description.
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		if(description == null){
			this.description = "";	
		}else {
			this.description = description;
		}
	}
	
	/**
	 * Returns input parameters for given report group entity.
	 * @return
	 */
	public String getInputParams() {
		return inputParams;
	}

	/**
	 * Sets input parameters for given report group entity.
	 * @param inputParams
	 */
	public void setInputParams(String inputParams) {
		this.inputParams = inputParams;
	}

	/**
	 * Returns last accessed time stamp of report group entity.
	 * @return
	 */
	public static long getLastAccessed() {
		return lastAccessed;
	}

	/**
	 * Sets last accessed time stamp of report group entity.
	 * @param lastAccessed
	 */
	public static void setLastAccessed(long lastAccessed) {
		ReportGroupBean.lastAccessed = lastAccessed;
	}

	/**
	 * Returns type of report group entity.It can be either STATIC_GROUP or DYNAMIC_GROUP.
	 * @return
	 */
	public int getGroupType() {
		return groupType;
	}

	/**
	 * Sets type of report group entity.It can be either STATIC_GROUP or DYNAMIC_GROUP.
	 * @param groupType
	 */
	public void setGroupType(int groupType) {	
		this.groupType = groupType;
	}

	/**
	 * Returns menu order of report group entity.
	 * @return
	 */
	public double getMenuOrder() {
		return menuOrder;
	}

	/**
	 * Sets menu order of report group entity.
	 * @param menuOrder
	 */
	public void setMenuOrder(double menuOrder) {
		this.menuOrder = menuOrder;
	}
	
	/**
	 * Returns categoryId of report group entity.
	 * @return
	 */
	public int getCategoryId() {
		return categoryId;
	}

	/**
	 * Sets categoryId of report group entity.
	 * @param menuOrder
	 */
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	/**
	 * Loads all instances of report group in {@link TreeMap}.
	 * @return
	 */
	public static synchronized boolean loadAll(){
		lastAccessed = System.currentTimeMillis();		
		if (reportGroupBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		ReportGroupBean reportGroupBean = null;
		String strQuery=null;
		try {
			reportGroupBeanMap = new TreeMap();
			//strQuery="select reportgroupid,title,description,inputparams,grouptype,menuorder from tblreportgroup order by reportgroupid";
			strQuery="select tblreportgroup.*,categoryid from tblreportgroup left join tblreportgroup_category on (tblreportgroup.reportgroupid = tblreportgroup_category.reportgroupid)";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				reportGroupBean= ReportGroupBean.getBeanByResultSetWrapper(rsw);
				if (reportGroupBean != null) {
					reportGroupBeanMap.put(new Integer(reportGroupBean.getReportGroupId()), reportGroupBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->ReportGroupBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->ReportGroupBean : "+ e, e);
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
	 * Obtains instance of report group by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static ReportGroupBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		ReportGroupBean reportGroupBean = new ReportGroupBean();
    	try {
    		reportGroupBean.setReportGroupId(rsw.getInt("reportgroupid"));
    		reportGroupBean.setTitle(rsw.getString("title"));
    		reportGroupBean.setDescription(rsw.getString("description"));
    		reportGroupBean.setInputParams(rsw.getString("inputparams"));
    		reportGroupBean.setGroupType(rsw.getInt("grouptype"));
    		reportGroupBean.setMenuOrder(rsw.getDouble("menuorder"));
    		reportGroupBean.setCategoryId(rsw.getInt("categoryid"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->ReportGroupBean: " + e,e);
    	}
    	return reportGroupBean;
    }
	
	/**
	 * Obtains instance of report group entity by primary key from {@link TreeMap}.
	 * @param primarykey
	 * @return
	 */
	public static ReportGroupBean getRecordbyPrimarykey(int primarykey) {        
		lastAccessed = System.currentTimeMillis();
		ReportGroupBean reportGroupBean=null;
        try {
        	   if(reportGroupBean==null) {
               	loadAll();
               }
        	   reportGroupBean=(ReportGroupBean)reportGroupBeanMap.get(new Integer(primarykey));
        	   if(reportGroupBean==null) {
        		   reportGroupBean=getSQLRecordByPrimaryKey(primarykey);
        		   if(reportGroupBean!=null) {
        			   reportGroupBeanMap.put(new Integer(reportGroupBean.getReportGroupId()),reportGroupBean);
        		   }
        	   }        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->ReportGroupBean: " + e,e);
        }
        return reportGroupBean;
    }
	
	/**
	 * Obtains report group Id of main dashboard from database.
	 * @return
	 */
	public static int getMainDashboardReportGroupID(int categoryid){
		lastAccessed = System.currentTimeMillis();
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		int reportGroupID = -1;
		try{
//			String sqlQuery = "select reportgroupid from tblreportgroup where description = 'Main Dashboard'";
			
			String sqlQuery="select tblreportgroup.reportgroupid from tblreportgroup,tblreportgroup_category where tblreportgroup.reportgroupid = tblreportgroup_category.reportgroupid and title='Main Dashboard' and categoryid = "+categoryid;
			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				reportGroupID = rsw.getInt("reportgroupid");
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getMainDashboardReportGroupID() -> ReportGroupBean: " + se, se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getMainDashboardReportGroupID() -> ReportGroupBean: " + e, e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return reportGroupID;
	}
	
	/**
	 * Obtains report group Id of dashboard from database.
	 * @return
	 */
	public static int getDashboardReportGroupID(){
		lastAccessed = System.currentTimeMillis();
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		int reportGroupID = -1;
		try{
			String sqlQuery = "select reportgroupid from tblreportgroup where description = 'Dashboard'";
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				reportGroupID = rsw.getInt("reportgroupid");
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getDashboardGroupID() -> ReportGroupBean: " + se, se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getDashboardGroupID() -> ReportGroupBean: " + e, e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return reportGroupID;
	}
	
	/**
	 * Obtains instance of report group by primary key from database table tblreportgroup.
	 * @param primaryKey
	 * @return
	 */
   public static ReportGroupBean getSQLRecordByPrimaryKey(int primaryKey){
		lastAccessed = System.currentTimeMillis();
		ReportGroupBean reportGroupBean = null; 
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			//String sqlQuery = "select reportgroupid,title,description,inputparams,grouptype,menuorder from tblreportgroup where reportgroupid="+ primaryKey ;
			String sqlQuery = "select a.reportgroupid,title,description,inputparams,grouptype,menuorder,categoryid from tblreportgroup a,tblreportgroup_category b where a.reportgroupid="+ primaryKey +" and a.reportgroupid=b.reportgroupid";
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				reportGroupBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> ReportGroupBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> ReportGroupBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return reportGroupBean;
	}
   
	/**
	 * Returns {@link TreeMap} containing all instances of report group. 
	 * @return
	 */
	public static TreeMap  getReportGroupBeanMap() {
        try {
              if(reportGroupBeanMap==null) {
				loadAll();
              }			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getReportGroupBeanMap()->ReportGroupBean: " + e,e);
		}
		return reportGroupBeanMap;
    }
	
	/**
	 * Returns {@link Iterator} containing all instances of report group.
	 * @return
	 */
    public static Iterator getReportGroupBeanIterator() {
       Iterator iterator=null;
       try {    	   
    	   	iterator=getReportGroupBeanMap().values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.repLog.error("Exception->getReportGroupBeanIterator()->ReportGroupBean: " + e,e);
       }
       return iterator;
    }
    
    /**
     * Returns {@link ArrayList} containing list of all instances of {@link ReportGroupRelationBean} related to given report group.
     * @param reportgroupid
     * @return
     */
    public ArrayList getReportIdByReportGroupId(int reportgroupid){
    	lastAccessed = System.currentTimeMillis();
		ArrayList reportIdList=null;
    	try{
    		reportIdList=(ArrayList)((TreeMap)ReportGroupRelationBean.getReportGroupRelationBeanMap()).get(new Integer(reportgroupid));
    	}catch(Exception e){
    		CyberoamLogger.repLog.error("Exception->getReportIdByReportGroupId()->ReportGroupBean: " + e,e);
    	}
    	return reportIdList;
    }
    
    /**
	 * Checks for duplicate report group based on title of report group.  
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
			sqlQuery="select count(*) as count from tblreportgroup where title="+StringMaker.makeString(getTitle());
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery,120);
			if (rsw.next() && rsw.getInt("count")>0){ 
				retStatus=-4;
			}
			CyberoamLogger.appLog.error("Exception->checkForDuplicate()->ReportGroupBean->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->checkForDuplicate()->ReportGroupBean->: " + e);
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
	 * Inserts SQL Record of report group entity into database table tblreport.
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
				sqlQuery="insert into tblreportgroup(title,description,inputparams,grouptype,menuorder) values("+StringMaker.makeString(getTitle())+","+StringMaker.makeString(getDescription())+","+StringMaker.makeString(getInputParams())+","+getGroupType()+",1)";
				retStatus = sqlReader.executeInsertWithLastid(sqlQuery,"reportgroupid");
				if (retStatus >= 0) {
						setReportGroupId(retStatus);
						if(reportGroupBeanMap != null){
							reportGroupBeanMap.put(new Integer(retStatus), this);
						}
				}
			}
			CyberoamLogger.appLog.debug("insertRecord()->ReportGroupBean->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->insertRecord()->ApplicationNameBean: " + e);
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
	 * Updates SQL Record of report group entity into database table tblreport.
	 * @return
	 */
	public int updateRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="update tblreportgroup set description= "+StringMaker.makeString(getDescription()) + " where reportgroupid = " + getReportGroupId(); 
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			if (retStatus >= 0) {
				reportGroupBeanMap.remove(new Integer(getReportGroupId()));
				reportGroupBeanMap.put(new Integer(getReportGroupId()),this);
				retStatus=1;
			}
			CyberoamLogger.appLog.debug("updateRecord()->ReportGroupBean->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->updateRecord()->ReportGroupBean: " + e);
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
	 * Deletes SQL Record of report group entity from database table tblreport.
	 * @return
	 */
	public int deleteRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			if(retStatus != -4){
				sqlReader=new SqlReader(false);
				sqlQuery = "delete from tblreportgroup where reportgroupid = " + getReportGroupId(); 
				retStatus = sqlReader.executeUpdate(sqlQuery,5);
				if (retStatus >= 0) {
					reportGroupBeanMap.remove(new Integer(getReportGroupId()));
					retStatus=1;
				}
			}
			CyberoamLogger.appLog.debug("updateRecord()->ReportGroupBean->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteRecord()->ReportGroupBean: " + e);
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
	 * Deletes SQL Record of all report group entities from database table tblreport based on given comma separated list of report group Ids.
	 * @param strProfileList
	 * @return
	 */
	public static int deleteAllRecord(String strProfileList){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			
			sqlReader=new SqlReader(false);
			sqlQuery = "delete from tblreportgroup where reportgroupid in (" + strProfileList +")"; 
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			if (retStatus >= 0) {
				String profileList[] = strProfileList.split(",");
				for(int i=0;i<profileList.length;i++){
					reportGroupBeanMap.remove(new Integer(profileList[i]));
				}
			}
			CyberoamLogger.appLog.debug("DeleteRecord()->ReportGroupBean->retStatus: " + retStatus);
		}catch(SQLException e){
			CyberoamLogger.appLog.error("Exception->deleteAllRecord()->ReportGroupBean: " + e);
			return -4;
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteAllRecord()->ReportGroupBean: " + e);
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
     * Returns string representation of report group entity.
     */
	public String toString(){
		String strString="";
		strString="\n\t reportgroupid="+getReportGroupId()
		+"\n\t title="+getTitle()
		+"\n\t description="+getDescription()
		+"\n\t inputparams="+getInputParams()
		+"\n\t grouptype="+getGroupType()
		+"\n\t menuorder="+getMenuOrder();
		return strString;
	}

}
