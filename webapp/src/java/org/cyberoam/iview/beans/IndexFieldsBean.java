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
import java.util.ArrayList;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;
/**
 * This class defines fields for index file.
 * @author JaydattDesai 
 * 
 * */
public class IndexFieldsBean{
	
	private String indexName = null;
	private String guiIndexName = null;
	private String guiOrder = null;
	private boolean searchable = false;
	private String dataType = null;
	private String categoryID = null;
	
	private static TreeMap<String,ArrayList<IndexFieldsBean>> indexFieldsBeanMap = null ;
	
	static{
		loadAll();
	}
	/**
	 * Returns index name which is displayed on Webpage.
	 * @return 
	 */
	public String getGuiIndexName() {
		return guiIndexName;
	}
	/**
	 * Set index field name which is displayed on Webpage.
	 * @param guiIndexName
	 */
	public void setGuiIndexName(String guiIndexName) {
		this.guiIndexName = guiIndexName;
	}
	/**
	 * Returns category id
	 * @return categoryid 
	 */
	public String getCategoryID() {
		return categoryID;
	}
	/**
	 * Set category id 
	 * @param categoryID
	 */
	public void setCategoryID(String categoryID) {
		this.categoryID = categoryID;
	}
	/**
	 * Get index field
	 * @return indexname
	 */
	public String getIndexName() {
		return indexName;
	}
	/**
	 * Set index field
	 * @param indexName
	 */
	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}
	/**
	 * Get gui order 
	 * @return
	 */
	public String getGuiOrder() {
		return guiOrder;
	}
	/**
	 * set gui order.
	 * @param guiOrder
	 */
	public void setGuiOrder(String guiOrder) {
		this.guiOrder = guiOrder;
	}
	/**
	 * Is this column bean searchable 
	 * @return 
	 */
	public boolean isSearchable() {
		return searchable;
	}
	/**
	 * Set searchable flag for given bean
	 * @param searchable
	 */
	public void setSearchable(boolean searchable) {
		this.searchable = searchable;
	}
	/**
	 * Get data type for field 
	 * @return
	 */
	public String getDataType() {
		return dataType;
	}
	/**
	 * Set data type for field
	 * @param dataType
	 */
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	/**
	 * Cache all index fields by category id in map.
	 * @return
	 */
	public static synchronized boolean loadAll(){				
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		IndexFieldsBean indexFieldsBean = null;
		String strQuery=null;
		ArrayList<IndexFieldsBean> indexFieldsBeanList = null;
		String oldCategoryID = "";
		try {
			indexFieldsBeanMap = new TreeMap<String,ArrayList<IndexFieldsBean>>();
			strQuery="select * from tblindexfields order by categoryid,guiorder asc";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				indexFieldsBean = IndexFieldsBean.getBeanByResultSetWrapper(rsw);
				if(indexFieldsBean.getCategoryID().equals(oldCategoryID)){
					indexFieldsBeanList.add(indexFieldsBean);
				}else{
					if(indexFieldsBeanList != null && indexFieldsBeanList.size() > 0){
						indexFieldsBeanMap.put(oldCategoryID, indexFieldsBeanList);
						CyberoamLogger.repLog.debug("loaded data in loadAll() for categoryID "+oldCategoryID); 
					}
					indexFieldsBeanList = new ArrayList<IndexFieldsBean>();
					oldCategoryID = indexFieldsBean.getCategoryID();
					indexFieldsBeanList.add(indexFieldsBean);
				}				
			}
			if(indexFieldsBeanList != null && indexFieldsBeanList.size() > 0){
				indexFieldsBeanMap.put(oldCategoryID, indexFieldsBeanList);
				CyberoamLogger.repLog.debug("loaded data in loadAll() out of whilefor categoryID "+oldCategoryID); 
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
	 * Get index fields for given category.
	 * @param categoryID
	 * @return list of index fields bean.
	 */
	public static ArrayList<IndexFieldsBean> getIndexFieldBeanListByCategoryID(String categoryID) {        		
    	  return (ArrayList<IndexFieldsBean>)indexFieldsBeanMap.get(categoryID);
    }
	/**
	 * Get index field Bean object from rsw object
	 * @param rsw
	 * @return indexfieldbean
	 */
	public static IndexFieldsBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		IndexFieldsBean indexFieldsBean = new IndexFieldsBean();
    	try {
    		indexFieldsBean.setIndexName(rsw.getString("indexname"));    		
    		indexFieldsBean.setGuiIndexName(rsw.getString("guiindexname"));
    		indexFieldsBean.setGuiOrder(rsw.getString("guiorder"));
    		indexFieldsBean.setSearchable(rsw.getBoolean("issearchable"));
    		indexFieldsBean.setDataType(rsw.getString("datatype"));
    		indexFieldsBean.setCategoryID(rsw.getString("categoryid"));
    	}catch(Exception e) {
    		CyberoamLogger.appLog.error("Exception->getBeanByResultSetWrapper()->IndexFieldsBean: " + e,e);
    	}
    	return indexFieldsBean;
    }
}