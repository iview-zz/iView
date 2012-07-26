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
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;




/**
 * This class represents graph format entity.
 * @author Vishal Vala
 *
 */
public class GraphFormatBean {

	/**
	 * Properties of Bean
	 */
	private static long lastAccessed = System.currentTimeMillis();
	private static TreeMap graphFormatBeanMap = null ;
	
	private int graphFormatId;
	private String graphFormat = null;	
	
	static {
		loadAll();
	}
	
	/**
	 * Loads all instances of graph format into {@link TreeMap} of {@link GraphFormatBean}.
	 * @return
	 */
	public static synchronized boolean loadAll() {
		
		lastAccessed = System.currentTimeMillis();		
		if (graphFormatBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		GraphFormatBean graphFormatBean = null;
		String strQuery = null;
		
		try {
			graphFormatBeanMap = new TreeMap();
			strQuery="select graphformatid, graphformat from tblgraphformat";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				graphFormatBean = GraphFormatBean.getBeanByResultSetWrapper(rsw);
				if (graphFormatBean != null) {
					graphFormatBeanMap.put(new Integer(graphFormatBean.getGraphFormatId()), graphFormatBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->GraphFormatBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->GraphFormatBean : "+ e, e);
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
	 * Obtains instance of {@link GraphFormatBean} by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	private static GraphFormatBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	GraphFormatBean graphFormatBean = new GraphFormatBean();
    	try {
    		graphFormatBean.setGraphFormatId(rsw.getInt("graphformatid"));
    		graphFormatBean.setGraphFormat(rsw.getString("graphformat"));    		
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->GraphFormatBean: " + e,e);
    	}
    	return graphFormatBean;
    }
	
	/**
	 * Obtains instance of {@link GraphFormatBean} from {@link TreeMap} of graph format.
	 * @param primarykey
	 * @return
	 */
	public static GraphFormatBean getRecordbyPrimarykey(int primarykey) {        
		lastAccessed = System.currentTimeMillis();
		GraphFormatBean graphFormatBean=null;
        try {
    	   if(graphFormatBeanMap == null) {
    		   loadAll();
           }
    	   graphFormatBean=(GraphFormatBean)graphFormatBeanMap.get(new Integer(primarykey));
    	   if(graphFormatBean == null) {
    		   graphFormatBean = getSQLRecordByPrimaryKey(primarykey);
    		   if(graphFormatBean != null) {
    			   graphFormatBeanMap.put(new Integer(graphFormatBean.getGraphFormatId()),graphFormatBean);
    		   }
    	   }        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->GraphFormatBean: " + e,e);
        }
        return graphFormatBean;
    }
	
	/**
	 * Obtains instance of {@link GraphFormatBean} by SQL Record from tblgraphformat.
	 * @param primaryKey
	 * @return
	 */
    private static GraphFormatBean getSQLRecordByPrimaryKey(int primaryKey){
		lastAccessed = System.currentTimeMillis();
		GraphFormatBean graphFormatBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select graphformatid, graphformat from tblgraphformat where graphformatid=" + primaryKey ;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				graphFormatBean = getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> GraphFormatBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> GraphFormatBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return graphFormatBean;
	}
    
    /**
     * Returns {@link TreeMap} containing all instances of {@link GraphFormatBean}.
     * @return
     */
	public static TreeMap getGraphBeanMap() {
        try {
          if(graphFormatBeanMap==null) {
			loadAll();
          }			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getGraphBeanMap()->GraphFormatBean: " + e,e);
		}
		return graphFormatBeanMap;
    }
	
	/**
	 * Returns {@link Iterator} containing all instances of {@link GraphFormatBean}.
	 * @return
	 */
    public static Iterator getGraphBeanIterator() {
       Iterator iterator = null;
       try {    	   
    	   	iterator = getGraphBeanMap().values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.repLog.error("exception->getGraphBeanIterator()->GraphFormatBean: " + e,e);
       }
       return iterator;
    }    
    
    /**
     * Returns graph format Id.
	 * @return the graphFormatId
	 */
	public int getGraphFormatId() {
		return graphFormatId;
	}

	/**
	 * Sets graph format Id.
	 * @param graphFormatId the graphFormatId to set
	 */
	public void setGraphFormatId(int graphFormatId) {
		this.graphFormatId = graphFormatId;
	}

	/**
	 * Returns format of graph.
	 * @return the graphFormat
	 */
	public String getGraphFormat() {
		return graphFormat;
	}

	/**
	 * Sets format of graph.
	 * @param graphFormat the graphFormat to set
	 */
	public void setGraphFormat(String graphFormat) {
		this.graphFormat = graphFormat;
	}
	
	/**
	 * Returns {@link TreeMap} containing all attributes of given graph format.<br>
	 * All attributes will be stored as comma separated into database.
	 * @return
	 */
	public TreeMap getAttributes() {
		TreeMap treeMap = null;
		StringTokenizer st = null;
		String attribute = null;
		String key = null;
		String value = null;
		int index = 0;
		try {
			treeMap = new TreeMap();
			if(graphFormat != null && !"".equals(graphFormat)) {
				st = new StringTokenizer(graphFormat, ",");
				while(st.hasMoreTokens()) {
					attribute = st.nextToken();
					if(attribute != null && !"".equals(attribute)) {
						index = attribute.indexOf("=");
						key = attribute.substring(0, index);
						value = attribute.substring(index + 1);
						treeMap.put(key, value);
					}
				}
			}
		} catch (Exception e) {
			CyberoamLogger.repLog.error("exception->getGraphBeanIterator()->GraphFormatBean: " + e,e);
		}
		return treeMap;
	}

	/**
	 * Returns string representation of {@link GraphFormatBean}.
	 */
	public String toString(){
    	String strString = "\nGraphFormat(\ngraphFormatId="+getGraphFormatId()
    		+ "\n graphFormat=" + getGraphFormat() + ")\n";
    	return strString;
    }
}



	
