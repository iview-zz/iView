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


import java.sql.SQLException;
import java.util.Iterator;
import java.util.TreeMap;
import java.util.ArrayList;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;




/**
 * This class represents report and column relation entity.
 * @author Narendra Shah
 *
 */
public class ReportColumnBean {

	/**
	 * Properties of Bean
	 */
	private int reportColumnId;
	private int reportId; 
	private String columnName = null;
	private String dbColumnName = null;
	private int isSortable;
	private int isSearchable;
	private int dataLinkId;
	private int columnFormat;
	private int alignment;
	private String tooltip;
	
	private static long lastAccessed = System.currentTimeMillis();
	private static TreeMap reportBeanMap = null ;
	private static TreeMap reportColumnBeanMap=null;
	
	static{
		loadAll();
	}

	/**
	 * Returns report and column relation Id.
	 * @return the reportColumnId
	 */
	public int getReportColumnId() {
		return reportColumnId;
	}
	
	/**
	 * Sets report and column relation Id.
	 * @param reportColumnId the reportColumnId to set
	 */
	public void setReportColumnId(int reportColumnId) {
		this.reportColumnId = reportColumnId;
	}
	
	/**
	 * Returns report Id.
	 * @return the reportId
	 */
	public int getReportId() {
		return reportId;
	}
	
	/**
	 * Sets report Id.
	 * @param reportId the reportId to set
	 */
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	
	/**
	 * Returns column name in report.
	 * @return the columnName
	 */
	public String getColumnName() {
		return TranslationHelper.getTranslatedMessge(columnName);
	}
	
	/**
	 * Sets column name in report.
	 * @param columnName the columnName to set
	 */
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	
	/**
	 * Returns column name used for report in database SQL Query.
	 * @return the dbColumnName
	 */
	public String getDbColumnName() {
		return dbColumnName;
	}
	
	/**
	 * Sets column name used for report in database SQL Query.
	 * @param dbColumnName the dbColumnName to set
	 */
	public void setDbColumnName(String dbColumnName) {
		this.dbColumnName = dbColumnName;
	}
	
	/**
	 * Returns flag which states whether column should be sorted or not.
	 * @return the isSortable
	 */
	public int getIsSortable() {
		return isSortable;
	}
	
	/**
	 * Sets flag which states whether column should be sorted or not.
	 * @param isSortable the isSortable to set
	 */
	public void setIsSortable(int isSortable) {
		this.isSortable = isSortable;
	}
	
	/**
	 * Returns flag which states whether search can be applied to this column or not.
	 * @return the isSearchable
	 */
	public int getIsSearchable() {
		return isSearchable;
	}
	
	/**
	 * Sets flag which states whether search can be applied to this column or not.
	 * @param isSearchable search flag value
	 */
	public void setIsSearchable(int isSearchable) {
		this.isSearchable = isSearchable;
	}
	/**
	 * Returns data link Id for given report and column relation.
	 * @return the dataLinkId
	 */
	public int getDataLinkId() {
		return dataLinkId;
	}
	
	/**
	 * Sets data link Id for given report and column relation.
	 * @param dataLinkId the dataLinkId to set
	 */
	public void setDataLinkId(int dataLinkId) {
		this.dataLinkId = dataLinkId;
	}
	
	/**
	 * Returns format to be used for given report column.
	 * @return the columnFormat
	 */
	public int getColumnFormat() {
		return columnFormat;
	}
	
	/**
	 * Sets format to be used for given report column.
	 * @param columnFormat the columnFormat to set
	 */
	public void setColumnFormat(int columnFormat) {
		this.columnFormat = columnFormat;
	}
	
	/**
	 * Returns alignment to be used for given report column.
	 * @return the alignment
	 */
	public int getAlignment() {
		return alignment;
	}
	
	/**
	 * Sets alignment to be used for given report column.
	 * @param alignment the alignment to set
	 */
	public void setAlignment(int alignment) {
		this.alignment = alignment;
	}
	
	/**
	 * Returns tooltip to be used for given report column.
	 * @return the tooltip
	 */
	public String getTooltip() {
		return tooltip;
	}
	
	/**
	 * Sets tooltip to be used for given report column.
	 * @param tooltip the tooltip to set
	 */
	public void setTooltip(String tooltip) {
		this.tooltip = tooltip;
	}
	
	/**
	 * Loads all instances of report column relatin into {@link TreeMap}.
	 * @return
	 */
	public static synchronized boolean loadAll() {
		lastAccessed = System.currentTimeMillis();		
		if (reportBeanMap != null) {
			return true;
		}
		
		ArrayList reportColumns;
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		ReportColumnBean reportColumnBean = null;
		String strQuery=null;
		int reportid=-1;
		try {
			strQuery="select reportcolumnid,reportid,columnname,dbcolumnname,issortable,issearchable,datalinkid,columnformat,alignment,tooltip from tblreportcolumn order by reportid,reportcolumnid";
		 	rsw=sqlReader.getInstanceResultSetWrapper(strQuery);
			reportBeanMap = new TreeMap();
			reportColumnBeanMap=new TreeMap();
			if(rsw.next()){
				reportColumnBean = ReportColumnBean.getBeanByResultSetWrapper(rsw);
				reportid=reportColumnBean.getReportId();
				CyberoamLogger.repLog.debug("reportid="+reportid);	
				reportColumns = new ArrayList();
				while(rsw.next()){
					reportColumnBeanMap.put(new Integer(reportColumnBean.getReportColumnId()),reportColumnBean);
					reportColumns.add(reportColumnBean);
					reportColumnBean = ReportColumnBean.getBeanByResultSetWrapper(rsw);
					if(reportColumnBean.getReportId() != reportid){
						reportBeanMap.put(new Integer(reportid),reportColumns); 
						reportid=reportColumnBean.getReportId();
						reportColumns = new ArrayList();
					}
				}
				reportColumnBeanMap.put(new Integer(reportColumnBean.getReportColumnId()),reportColumnBean);
				reportColumns.add(reportColumnBean);
				reportBeanMap.put(new Integer(reportid),reportColumns); 
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->ReportColumnBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->ReportColumnBean : "+ e, e);
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
	 * Obtains instance of report column entity by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
    public static ReportColumnBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	ReportColumnBean reportColumnBean = new ReportColumnBean();
    	try {
    			reportColumnBean.setReportColumnId(rsw.getInt("reportcolumnid"));
    			reportColumnBean.setReportId(rsw.getInt("reportid"));
    			reportColumnBean.setColumnName(rsw.getString("columnname"));
    			reportColumnBean.setDbColumnName(rsw.getString("dbcolumnname"));
    			reportColumnBean.setIsSortable(rsw.getInt("issortable"));
    			reportColumnBean.setIsSearchable(rsw.getInt("issearchable"));
    			reportColumnBean.setDataLinkId(rsw.getInt("datalinkid"));
    			reportColumnBean.setColumnFormat(rsw.getInt("columnformat"));
    			reportColumnBean.setAlignment(rsw.getInt("alignment"));
    			reportColumnBean.setTooltip(rsw.getString("tooltip"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->ReportColumnBean: " + e,e);
    	}
    	return reportColumnBean;
    }

    /**
     * Obtains instance of report column entity from {@link TreeMap} by primary key of report and column relation.
     * @param reportColumnid
     * @return
     */
    public static ReportColumnBean getRecordByPrimaryKey(int reportColumnid) {
    	ReportColumnBean reportColumnBean=null;
    	if(reportColumnid <= 0) {
    		return null;
    	}
    	try {
    		reportColumnBean=(ReportColumnBean)reportColumnBeanMap.get(new Integer(reportColumnid));
    		if(reportColumnBean == null){
    			reportColumnBean=getSQLRecordByPrimaryKey(reportColumnid);
    		}
    	}catch(Exception e){
    		CyberoamLogger.repLog.error("Exception->getRecordByPrimarykey()->ReportColumnBean: " + e,e);
    	}
    	return reportColumnBean;
    }
    
    /**
     * Obtains instance of report column entity from {@link TreeMap} for given report Id and column Id.
     * @param reportid
     * @param reportColumnID
     * @return
     */
    public static ReportColumnBean getRecordByPrimaryKey(int reportid,int reportColumnID) {        
		lastAccessed = System.currentTimeMillis();
    	ReportColumnBean reportColumnBean=null;
    	try {
        	   if(reportBeanMap==null) {
               	loadAll();
               }
        	   ArrayList reportColumns=(ArrayList)reportBeanMap.get(new Integer(reportid));
        	   if(reportColumns != null){
	        	   for(int i=0;i<reportColumns.size();i++){
	        		   reportColumnBean=(ReportColumnBean)reportColumns.get(i);
	        		   if(reportColumnID == reportColumnBean.getReportColumnId()){
	        			   return reportColumnBean;
	        		   }
	        	   }
        	   }
        	   if(reportColumnBean==null) {
        		   reportColumnBean=getSQLRecordByPrimaryKey(reportColumnID);
        	   }        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->ReportColumnBean: " + e,e);
        }
        return reportColumnBean;
    }
    
    /**
     * Obtains all instance of report column entity into {@link ArrayList} for given report Id.
     * @param reportID
     * @return
     */
    public static ArrayList getReportColumnsByReportID(int reportID){
    	return (ArrayList)reportBeanMap.get(new Integer(reportID));
    }
    
    /**
     * Obtains instance of report column relation entity from database table tblreportcolumnrel.
     * @param primaryKey
     * @return
     */
    private static ReportColumnBean getSQLRecordByPrimaryKey(int primaryKey){
		lastAccessed = System.currentTimeMillis();
		ReportColumnBean reportColumnBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select reportcolumnid,reportid,columnname,dbcolumnname,issortable,issearchable,datalinkid,columnformat,alignment,tooltip from tblreportcolumn where reportcolumnid="+ primaryKey ;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				reportColumnBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> ReportColumnBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> ReportColumnBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return reportColumnBean;
	}
    
    /**
     * Returns {@link TreeMap} containing all instances of report column relation entity.
     * @return
     */
    public static TreeMap  getreportBeanMap() {
        try {
              if(reportBeanMap==null) {
				loadAll();
              }			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getreportBeanMap()->ReportColumnBean: " + e,e);
		}
		return reportBeanMap;
    }
    
    /**
     * Returns {@link Iterator} containing all instances of report column relation entity.
     * @return
     */
    public static Iterator getReportBeanColumnBeanIterator() {
       Iterator iterator=null;
       try {    	   
    	   	iterator=getreportBeanMap().values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.repLog.error("Exception->getReportBeanColumnBeanIterator()->ReportColumnBean: " + e,e);
       }
       return iterator;
    }
    
    /**
     * Returns string representation of report column relation entity. 
     */
    public String toString(){
		String strString="";
		strString="\n\t reportcolumnid="+getReportColumnId()
		+"\n\t reportid="+getReportId()
		+"\n\t columnname="+getColumnName()
		+"\n\t dbcolumnname="+getDbColumnName()
		+"\n\t issortable="+getIsSortable()
		+"\n\t issearchable="+getIsSearchable()
		+"\n\t datalinkid="+getDataLinkId()
		+"\n\t columnformat="+getColumnFormat()
		+"\n\t alignment="+getAlignment()
		+"\n\t tooltipcolumnid="+getTooltip();
		return strString;
	}
}
