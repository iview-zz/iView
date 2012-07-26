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
import java.util.TreeMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.PrepareQuery;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;




/**
 * This class represents report entity.
 * @author Narendra Shah
 *
 */
public class ReportBean {

	/**
	 * Properties Of Bean
	 */
	private int reportId;
	private String title = null;
	private String inputParams = null;
	private String query = null;
	private int graphId;
	private String defaultColumnForSort=null;
	private String defaultTitle = null;
	private String totalQuery = null;
	private int viewFormat;
	private static long lastAccessed = System.currentTimeMillis();
	private static TreeMap reportBeanMap = null ;
	private String tableName = null;
	private String minSetOfCol = null;
	private int isSingleReport;
	private int queryType;
	
	public int getQueryType(){
		return queryType;
	}
	
	public void setQueryType(int queryType){
		this.queryType = queryType;
	}
	/**
	 * Returns default title to be used for report.
	 * @return
	 */
	public String getDefaultTitle() {
		return defaultTitle;
	}
	
	/**
	 * Sets default title to be used for report.
	 * @param defaultTitle
	 */
	public void setDefaultTitle(String defaultTitle) {
		this.defaultTitle = defaultTitle;
	}
	
	static{
		loadAll();
	}
	
	/**
	 * @return the isSingleReport
	 */
	public int getIsSingleReport() {
		return isSingleReport;
	}

	/**
	 * @param isSingleReport the isSingleReport to set
	 */
	public void setIsSingleReport(int isSingleReport) {
		this.isSingleReport = isSingleReport;
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
	 * Returns report title.
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	
	/**
	 * Sets report title.
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * Returns parameters used in report.
	 * @return the inputParams
	 */
	public String getInputParams() {
		return inputParams;
	}
	
	/**
	 * Sets parameters used in report.
	 * @param inputParams the inputParams to set
	 */
	public void setInputParams(String inputParams) {
		this.inputParams = inputParams;
	}
	
	/**
	 * Returns SQL query for report.
	 * @return the query
	 */
	public String getQuery() {
		return query;
	}
	
	/**
	 * Sets SQL query for report.
	 * @param query the query to set
	 */
	public void setQuery(String query) {
		this.query = query;
	}
	
	/**
	 * Returns graph Id used for report.
	 * @return the graphId
	 */
	public int getGraphId() {
		return graphId;
	}
	
	/**
	 * Sets graph Id used for report.
	 * @param graphId the graphId to set
	 */
	public void setGraphId(int graphId) {
		this.graphId = graphId;
	}
	
	
	/**
	 * Returns format Id used for report.
	 * @return the formatId
	 */
	public int getReportFormatId() {
		return viewFormat;
	}

	/**
	 * Sets format Id used for report.
	 * @param formatId the formatId to set
	 * if(formatId == 2) display only table data
	 * if(formatId == 3) display only graph
	 * else both
	 */
	  private void setReportFormatId(int formatId) {
		  this.viewFormat = formatId;
	}
	
	/**
	 * Returns column name used for sorting data in report.
	 * @return the defaultColumnForSort
	 */
	public String getDefaultColumnForSort() {
		return defaultColumnForSort;
	}
	
	 /* Sets column name used for sorting data in report.
	 * @param defaultColumnForSort the defaultColumnForSort to set
	 */
	public void setDefaultColumnForSort(String defaultColumnForSort) {
		this.defaultColumnForSort = defaultColumnForSort;
	}
	/**
	 * Returns SQL Query that can give total number of records of report.
	 * @return SQL Query
	 */
	public String getTotalQuery() {
		return totalQuery;
	}
	/**
	 * Sets SQL Query that can give total number of records of report.
	 * @param totalQuery SQL Query
	 */
	public void setTotalQuery(String totalQuery) {
		if(totalQuery==null || "null".equalsIgnoreCase(totalQuery) || "".equalsIgnoreCase(totalQuery.trim())){
			//For Few Queries which have multiple widgets have there queries blank in the database
			//so for those queries 
			if(this.getQuery()==null)
				return;
			this.totalQuery = this.getQuery().toLowerCase();
			if(this.totalQuery.lastIndexOf("order by") != -1){
				this.totalQuery = this.totalQuery.substring(0, this.totalQuery.lastIndexOf("order by"));
			}
			this.totalQuery= "select count(*) from (" + this.totalQuery + ") as test";
		}else{
			this.totalQuery = totalQuery;			
		}
	}
	/**
	 * Sets Table Name used from which this report display data
	 * @param tableName 
	 */
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	/**
	 * Returns Table Name from which this report display data.
	 * @return TableName
	 */
	public String getTableName() {
		return tableName;
	}
	
	/**
	 * Sets minimus Set of Col used for report
	 * @param Minimum set of columns
	 */
	public void setMinSetOfCol(String minSetOfCol) {
		this.minSetOfCol = minSetOfCol;
	}
	/**
	 * Returns Minimum set of Columns used for report 
	 * @return minSetOfCol
	 */
	public String getMinSetOfCol() {
		return minSetOfCol;
	}
	
	/**
	 * Loads all instances of report entity into {@link TreeMap}.
	 * @return
	 */
	public static synchronized boolean loadAll(){
		lastAccessed = System.currentTimeMillis();		
		if (reportBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		ReportBean reportBean = null;
		String strQuery=null;
		try {
			reportBeanMap = new TreeMap();
			strQuery="SELECT a.reportid , b.title as defaultgrouptitle,a.title,a.inputparams,a.query,a.totalquery,a.reportformatid,a.graphid,a.defaultcolumnforsort ,a.tablename,a.minSetOfCol,a.issinglereport,a.querytype  " +
					"FROM tblreport a,tblreportgroup b,tblreportgrouprel c where a.reportid = c.reportid and b.grouptype =1 and b.reportgroupid = c.reportgroupid";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				reportBean= ReportBean.getBeanByResultSetWrapper(rsw);
				if (reportBean != null) {
					reportBeanMap.put(new Integer(reportBean.getReportId()), reportBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->ReportBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->ReportBean : "+ e, e);
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
	 * Obtains instance of {@link ReportBean} by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
    public static ReportBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	ReportBean reportBean = new ReportBean();
    	try {
    		reportBean.setReportId(rsw.getInt("reportid"));
    		reportBean.setTitle(rsw.getString("title"));
    		reportBean.setInputParams(rsw.getString("inputparams"));
    		reportBean.setQuery(rsw.getString("query"));
    		reportBean.setGraphId(rsw.getInt("graphid"));
    		reportBean.setReportFormatId(rsw.getInt("reportformatid"));
    		reportBean.setDefaultColumnForSort(rsw.getString("defaultcolumnforsort"));
    		reportBean.setDefaultTitle(rsw.getString("defaultgrouptitle"));
    		reportBean.setTotalQuery(rsw.getString("totalquery"));
    		reportBean.setIsSingleReport(rsw.getInt("issinglereport"));
    		reportBean.setTableName(rsw.getString("tablename")) ;
    		reportBean.setMinSetOfCol(rsw.getString("minSetOfCol")) ;
    		reportBean.setQueryType(rsw.getInt("querytype"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->ReportBean: " + e,e);
    	}
    	return reportBean;
    }
    
    /**
     * Obtains instance of report from {@link TreeMap} by given primary key.
     * @param primarykey
     * @return
     */
    public static ReportBean getRecordbyPrimarykey(int primarykey) {        
		lastAccessed = System.currentTimeMillis();
    	ReportBean reportBean=null;
        try {
        	   if(reportBeanMap==null) {
               	loadAll();
               }
        	   reportBean=(ReportBean)reportBeanMap.get(new Integer(primarykey));
        	   if(reportBean==null) {
        		   reportBean=getSQLRecordByPrimaryKey(primarykey);
        		   if(reportBean!=null) {
        			   reportBeanMap.put(new Integer(reportBean.getReportId()),reportBean);
        		   }
        	   }        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->ReportBean: " + e,e);
        }
        return reportBean;
    }
    
    /**
     * Obtains instance of report from {@link TreeMap} by given primary key.
     * @param primarykey
     * @return
     */
    public static ReportBean getRecordbyPrimarykey(String primarykey) {
    	try {
    		return getRecordbyPrimarykey(Integer.parseInt(primarykey));
    	}catch(Exception e){
    		CyberoamLogger.repLog.debug("Report Bean primary key Parsing error : " +e, e);
    	}    	
    	return null;
    }
    
    /**
     * Obtains instance of report from database table by given primary key.
     * @param primaryKey
     * @return
     */
    private static ReportBean getSQLRecordByPrimaryKey(int primaryKey){
		lastAccessed = System.currentTimeMillis();
		ReportBean reportBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select reportid,title,title as defaultgrouptitle,inputparams,query,totalquery,reportformatid,graphid,defaultcolumnforsort,tablename,minsetofcol,issinglereport,QUERYTYPE from tblreport where reportid="+ primaryKey ;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				reportBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> ReportBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> ReportBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return reportBean;
	}
    
    /**
     * Obtains {@link TreeMap} containing all instances of report entity.
     * @return
     */
    public static TreeMap getReportBeanMap() {
        try {
              if(reportBeanMap==null) {
				loadAll();
              }			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getReportBeanMap()->ReportBean: " + e,e);
		}
		return reportBeanMap;
    }
    
    /**
     * Obtains {@link Iterator} containing all instances of report entity.
     * @return
     */
    public static Iterator getReportBeanIterator() {
       Iterator iterator=null;
       try {    	   
    	   	iterator=getReportBeanMap().values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.sysLog.error("exception->getReportBeanIterator()->ReportBean: " + e,e);
       }
       return iterator;
    }
    
    /**
     * Returns string representation of report entity.
     */
    public String toString(){
    	String strString="";
    	strString="reportId="+getReportId()+
    	"\ttitle="+getTitle()+
    	"\tinputparams="+getInputParams()+
    	"\tquery="+getQuery()+
    	"\tgraphid="+getGraphId()+
    	"\tviewformat="+getReportFormatId()+
    	"\tdefaultcolumnforsort="+getDefaultColumnForSort()+
    	"\ttotalquery="+getTotalQuery()+
    	"\tdefaulttitle="+getDefaultTitle()+
    	"\ttablename="+getTableName()+
    	"\tminSetOfCol="+getMinSetOfCol()+
    	"\tissinglereport="+getIsSingleReport()+
    	"\tquerytype="+getQueryType();
    	return strString;
    }
    
    /**
     * This method returns total number of records for current report and given parameters in HTTP request entity.
     * @return number of records
     */
    public Long getNumberOfRecords(String searchQuery, String totalQry){
    	long numOfRecords = -1;
    	ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
    	try{
    		if( searchQuery != null && !"".equalsIgnoreCase(searchQuery)){
				totalQry = totalQry.replaceFirst("where", "where "+ searchQuery +" and");
			}
    		try {
				rsw = sqlReader.getInstanceResultSetWrapper(totalQry);
			} catch (org.postgresql.util.PSQLException e) {
				if(totalQry.indexOf("5min_ts_20") > -1) {
					totalQry = totalQry.substring(0,totalQry.indexOf("5min_ts_20")) + "4hr" +totalQry.substring(totalQry.indexOf("5min_ts_20") + 16,totalQry.length());
					rsw = sqlReader.getInstanceResultSetWrapper(totalQry);
				} else {
					CyberoamLogger.appLog.error("Exeption in ReportBean"+e,e );
				}
			} catch (Exception e) {
				CyberoamLogger.appLog.error("Exeption in ReportBean"+e,e );
				rsw.close();
			}
    		
    		if (rsw.next()) {
    			numOfRecords = rsw.getLong("count");
			}
    	}catch(Exception e){
    		CyberoamLogger.appLog.debug("Exception=>ReportBean=>getNumberOfRecords() e:"+e,e);
    		numOfRecords = -1;
    	} finally {
    		sqlReader.close();
    		rsw.close();
    	}
    	return new Long(numOfRecords);
    }
    /**
     * Returns last accessed time stamp of report entity.
     * @return
     */
    public static long getLastAccessed() {
		return lastAccessed;
	}
    
    /**
     * Sets last accessed time stamp of report entity.
     * @param lastAccessed
     */
	public static void setLastAccessed(long lastAccessed) {
		ReportBean.lastAccessed = lastAccessed;
	}
	
}
