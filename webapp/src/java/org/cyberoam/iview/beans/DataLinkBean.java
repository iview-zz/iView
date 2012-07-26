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


import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This class represents data link entity. 
 * @author Narendra Shah
 *
 */
public class DataLinkBean {

	/**
	 * Properties of Bean
	 */
	private int dataLinkId;
	private String url;
	private boolean openInSameWindow;
	private String rswParameter = null;
	private String requestParameter = null;	
	
	private static TreeMap dataLinkBeanMap = null ;
	
	static{
		loadAll();
	}
	
	/**
	 * Returns data link Id.
	 * @return the dataLinkId
	 */
	public int getDataLinkId() {
		return dataLinkId;
	}
	
	/**
	 * Sets data link Id.
	 * @param dataLinkId
	 */
	public void setDataLinkId(int dataLinkId) {
		this.dataLinkId = dataLinkId;
	}
	
	/**
	 * Returns URL for link.
	 * @return  url
	 */
	public String getUrl() {
		return this.url;
	}
	
	/**
	 * Sets URL for link.
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	
	/**
	 * Returns window opening mode.<br>
	 * true for same window and false for new window.
	 * @return the window open mode. 
	 */
	public boolean getOpenInSameWindow() {
		return this.openInSameWindow;
	}
	
	/**
	 * Returns window opening mode.
	 * true for same window and false for new window.
	 * @return
	 */
	public boolean isOpenInSameWindow() {
		return this.openInSameWindow;
	}
	
	/**
	 * Sets window opening mode.
	 * true for same window and false for new window.
	 * @param openInSameWindow the openInSameWindow to set
	 */
	public void setOpenInSameWindow(boolean openInSameWindow) {
		this.openInSameWindow = openInSameWindow;
	}
	
	/**
	 * Returns the parameter to be used while linking.
	 * @return the requestParameter
	 */
	public String getRequestParameter() {
		return this.requestParameter;
	}
	/**
	 * Sets the parameter to be used while linking.
	 * @param requestParameter the requestParameter to set
	 */
	public void setRequestParameter(String requestParameter) {
		this.requestParameter = requestParameter;
	}
	
	/**
	 * Returns column name to be used while accessing value from {@link ResultSetWrapper}.
	 * @return the rswParameter
	 */
	public String getRswParameter() {
		return this.rswParameter;
	}
	
	/**
	 * Sets column name to be used while accessing value from {@link ResultSetWrapper}.
	 * @param rswParameter the rswParameter to set
	 */
	public void setRswParameter(String rswParameter) {
		this.rswParameter = rswParameter;
	}

	/**
	 * Loads all data link records into  {@link TreeMap} of {@link DataLinkBean}.
	 * @return
	 */
	public static synchronized boolean loadAll(){
		if (dataLinkBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		DataLinkBean dataLinkBean = null;
		String strQuery=null;
		try {
			dataLinkBeanMap = new TreeMap();
			strQuery="select datalinkid,url,openinsamewindow,rswparameter,requestparameter from tbldatalink order by datalinkid";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);
			while (rsw.next()) {
				dataLinkBean= DataLinkBean.getBeanByResultSetWrapper(rsw);
				if (dataLinkBean != null) {
					dataLinkBeanMap.put(new Integer(dataLinkBean.getDataLinkId()), dataLinkBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->DataLinkBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->DataLinkBean : "+ e, e);
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
	 * Returns instance of {@link DataLinkBean} by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static DataLinkBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		DataLinkBean dataLinkBean = new DataLinkBean();
    	try {
    		dataLinkBean.setDataLinkId(rsw.getInt("datalinkid"));
    		dataLinkBean.setUrl(rsw.getString("url"));
    		dataLinkBean.setOpenInSameWindow(rsw.getBoolean("openinsamewindow"));
    		dataLinkBean.setRswParameter(rsw.getString("rswparameter"));
    		dataLinkBean.setRequestParameter(rsw.getString("requestparameter"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->DataLinkBean: " + e,e);
    	}
    	return dataLinkBean;
    }
	
	/**
	 * Obtains instance of {@link DataLinkBean} by data link id from cache.
	 * @param primarykey
	 * @return
	 */
	public static DataLinkBean getRecordbyPrimarykey(int primarykey) {        
		DataLinkBean dataLinkBean = null;
		if(primarykey <= 0){
			return null;
		}
        try {
        	if(dataLinkBeanMap==null) {
               	loadAll();
        	}
        	dataLinkBean=(DataLinkBean) dataLinkBeanMap.get(new Integer(primarykey));
        	if(dataLinkBean==null) {
        		dataLinkBean=getSQLRecordByPrimaryKey(primarykey);
        		if(dataLinkBean!=null) {
        			dataLinkBeanMap.put(new Integer(dataLinkBean.getDataLinkId()),dataLinkBean);
        		}
        	}        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->DataLinkBean: " + e,e);
        }
        return dataLinkBean;
    }
	
	/**
	 * Obtains instance of {@link DataLinkBean} by data link id from database.
	 * @param primaryKey
	 * @return
	 */
    private static DataLinkBean getSQLRecordByPrimaryKey(int primaryKey){
		DataLinkBean dataLinkBean = null; 
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select datalinkid,url,openinsamewindow,rswparameter,requestparameter from tbldatalink where datalinkid="+ primaryKey ;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				dataLinkBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> DataLinkBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> DataLinkBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return dataLinkBean;
	}
    
    /**
     * Returns {@link TreeMap} containing all instances of {@link DataLinkBean}. 
     * @return
     */
	public static TreeMap getDataLinkBeanMap() {
        try {
              if(dataLinkBeanMap==null) {
				loadAll();
              }			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getDataLinkBeanMap()->DataLinkBean: " + e,e);
		}
		return dataLinkBeanMap;
    }
	
	/**
	 * Returns {@link Iterator} containing all instances of {@link DataLinkBean}.
	 * @return
	 */
    public static Iterator getDataLinkBeanIterator() {
       Iterator iterator=null;
       try {    	   
    	   	iterator=getDataLinkBeanMap().values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.repLog.error("Exception->getDataLinkBeanIterator()->DataLinkBean: " + e,e);
       }
       return iterator;
    }
    
    /**
     * Returns string representation of {@link DataLinkBean}.
     */
	public String toString(){
		String strString ="";
		strString="\n\t datalinkid="+getDataLinkId()
		+"\n\t url="+getUrl()
		+"\n\t openinsamewindow="+getOpenInSameWindow()
		+"\n\t rswparameter="+getRswParameter()
		+"\n\t requestparameter="+getRequestParameter();
		return strString;
	}
	
	/**
	 * Generates URL string based on data link and its parameters.
	 * @param rsw
	 * @param request
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String generateURL(ResultSetWrapper rsw,HttpServletRequest request) {
		StringBuffer url = new StringBuffer();		
		String token = null;
		try {			
			url.append(request.getContextPath() + getUrl());
			StringTokenizer parameters = new StringTokenizer(getRswParameter(),",");
			while(parameters.hasMoreTokens()){
				token = parameters.nextToken();
				if(rsw.getString(token) != null) {
					if(url.indexOf("?") <=0 )
						url.append("?");
					else url.append("&");
					url.append(token);
					url.append("=");
					url.append(URLEncoder.encode(rsw.getString(token),"UTF-8"));
				}
			}
			parameters = new StringTokenizer(getRequestParameter(),",");
			while(parameters.hasMoreTokens()){
				token = parameters.nextToken();
				if(request.getParameter(token) != null){
					if(url.indexOf("?") <=0 )
						url.append("?");
					else url.append("&");
					url.append(token);
					url.append("=");
					url.append(URLEncoder.encode(request.getParameter(token),"UTF-8")); 
				}
			}
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getgenerateURL()->DataLinkBean: " + e,e);
		}		
		return url.toString();
	}
	
	/** Description: Generate url for chart has been overrideen and the old method is kept as it is. 
	 *  It will be used in scenarios when we have multiple values with comma like(ruleid,porto_group)in rswparameter column in tbldatalink table.
	 *  For URL, we should be use value of rswparameter from tbldatalink table.
	 */
	public String generateURLForChart(ResultSetWrapper rsw,HttpServletRequest request) {
		StringBuffer url = new StringBuffer();		
		String token = null;
		try {			
			url.append(request.getContextPath() + getUrl());
			StringTokenizer parameters = new StringTokenizer(getRswParameter(),",");	
			while(parameters.hasMoreTokens()){
				token = parameters.nextToken();
				if(rsw.getString(token) != null) {
					if(url.indexOf("?") <=0 )
						url.append("?");
					else url.append("&amp;");
					url.append(token);
					url.append("=");
					url.append(URLEncoder.encode((rsw.getString(token)).equalsIgnoreCase("N/A") ?"":(rsw.getString(token)),"UTF-8"));
				}
			}
			parameters = new StringTokenizer(getRequestParameter(),",");
			while(parameters.hasMoreTokens()){
				token = parameters.nextToken();
				if(request.getParameter(token) != null){
					if(url.indexOf("?") <=0 )
						url.append("?");
					else url.append("&amp;");
					url.append(token);
					url.append("=");
					url.append(URLEncoder.encode((request.getParameter(token)).equalsIgnoreCase("N/A") ?"":(request.getParameter(token)),"UTF-8"));					
				}
			}
			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getgenerateURLForChart()->DataLinkBean: " + e,e);
		}		
		return url.toString();
	}
	/**
	 * Generates URL for chart string based on data link and its parameters.
	 * @param request
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String generateURLForChart(HttpServletRequest request) {
		StringBuffer url = new StringBuffer();		
		String token = null;
		try {			
			url.append(request.getContextPath() + getUrl());
			StringTokenizer parameters = new StringTokenizer(getRswParameter(),",");				
			parameters = new StringTokenizer(getRequestParameter(),",");
			while(parameters.hasMoreTokens()){
				token = parameters.nextToken();
				if(request.getParameter(token) != null){
					if(url.indexOf("?") <=0 )
						url.append("?");
					else url.append("&amp;");
					url.append(token);
					url.append("=");
					url.append(URLEncoder.encode(request.getParameter(token),"UTF-8")); 
				}
			}
			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getgenerateURLForChart()->DataLinkBean: " + e,e);
		}		
		return url.toString();
	}


}

