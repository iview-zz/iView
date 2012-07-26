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

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;

/**
 * This bean handle all Category information.
 * category will be We stored in table named tblcategory.
 * @author Shikha Shah
 */

public class CategoryBean {
	private int categoryID;
	private String categoryName;

	private static TreeMap<Integer,CategoryBean> categoryBeanMap = null ;
	
	/**
	 * Returns categoryID.
	 * @return
	 */
	public int getCategoryId() {
		return categoryID;
	}
	
	/**
	 * Sets category ID.
	 * @param categoryID
	 */
	public void setCategoryId(int categoryid) {
		this.categoryID = categoryid;
	}
	
	/**
	 * Returns category name.
	 */
	public String getCategoryName() {
		return categoryName;
	}
	
	/**
	 * Sets category name.
	 * @param categoryname
	 */
	public void setCategoryName(String categoryname) {
		this.categoryName = categoryname;
	}
	
	static{
		loadAll();
	}
	
	/**
	 * Load all instances of categories.  
	 * @return true on success else returns false
	 */
	public static synchronized boolean loadAll(){
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		CategoryBean categoryBean = null;
		String strQuery=null;
		try {
			categoryBeanMap = new TreeMap();
			strQuery="select * from tblcategory order by categoryid";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				categoryBean= CategoryBean.getBeanByResultSetWrapper(rsw);
				if (categoryBean != null) {
					categoryBeanMap.put(new Integer(categoryBean.getCategoryId()), categoryBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->CategoryBean->loadAll() : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->CategoryBean->loadAll() : "+ e, e);
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
	 * Get record by primary key
	 */
	public static CategoryBean getRecordByPrimaryKey(int categoryID){
		return categoryBeanMap.get(categoryID);
	}
	/**
	 * Returns instance of {@link CategoryBean} by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static CategoryBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	CategoryBean CategoryBean = new CategoryBean();
    	try {
    		CategoryBean.setCategoryId(rsw.getInt("categoryid"));
    		CategoryBean.setCategoryName(rsw.getString("categoryname").trim());
    	}catch(Exception e) {
    		CyberoamLogger.appLog.error("Exception->getBeanByResultSetWrapper()->CategoryBean: " + e,e);
    	}
    	return CategoryBean;
    }

	/**
	 * Returns string representation of {@link CategoryBean}.
	 */
	public String toString(){
		return "CategoryId="+categoryID+
			"\n\t categoryname="+categoryName;
	}

	/**
	 * Returns {@link TreeMap} containing all instances of category.
	 * @return
	 */	
	public static TreeMap getCategoryBeanMap(){
    	try{
    		if(categoryBeanMap == null){
    			loadAll();
    		}
    	}catch (Exception e) {
			CyberoamLogger.repLog.error("Exception :getCategoryBeanMap() : CategoryBean"+e,e); 
		}
    	return categoryBeanMap;
    }
    
    /**
     * Returns {@link Iterator} containing all instances of category.
     * @return
     */
    public static Iterator getAllCategoryIterator(){
    	Iterator iterator=null;
		try{
			iterator = getCategoryBeanMap().values().iterator();
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->getReportGroupRelationBeanIterator()->ReportGroupRelationBean :"+e,e);
		}
		return iterator;
    }   
    
}
