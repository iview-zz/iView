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
 * This class represents graph entity.
 * @author Vishal Vala
 *
 */
public class GraphBean {

	public GraphBean() {
		super();
	}
	/**
	 * Properties of Bean
	 */
	private int graphId;
	private String title = null;
	private String subTitle = null;
	private String description = null;
	private int height;
	private int width;
	//private String backcolor = null;
	//private int chartId;
	private int chartType;
	private int xColumnId;
	private int yColumnId;
	private int zColumnId;
	private int graphFormatId;
	//private String showLegennd = null;
	//private String xLabelRotation = null;
	
	private static long lastAccessed = System.currentTimeMillis();
	private static TreeMap graphBeanMap = null ;
	
	static{
		loadAll();
	}

	/**
	 * Returns graph Id.
	 * @return the graphId
	 */
	public int getGraphId() {
		return graphId;
	}

	/**
	 * Sets graph Id.
	 * @param graphId the graphId to set
	 */
	public void setGraphId(int graphId) {
		this.graphId = graphId;
	}

	/**
	 * Returns title of graph.
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	
	/**
	 * Returns column Id from {@link ReportColumnBean} for X-axis of graph.
	 * @return the xColumnId
	 */
	public int getXColumnId() {
		return xColumnId;
	}

	/**
	 * Sets column Id from {@link ReportColumnBean} for X-axis of graph.
	 * @param columnId the xColumnId to set
	 */
	public void setXColumnId(int columnId) {
		xColumnId = columnId;
	}

	/**
	 * Returns column Id from {@link ReportColumnBean} for Y-axis of graph.
	 * @return the yColumnId
	 */
	public int getYColumnId() {
		return yColumnId;
	}

	/**
	 * Sets column Id from {@link ReportColumnBean} for Y-axis of graph.
	 * @param columnId the yColumnId to set
	 */
	public void setYColumnId(int columnId) {
		yColumnId = columnId;
	}

	/**
	 * Returns column Id from {@link ReportColumnBean} for Z-axis of graph.
	 * @return the zColumnId
	 */
	public int getZColumnId() {
		return zColumnId;
	}

	/**
	 * Sets column Id from {@link ReportColumnBean} for Z-axis of graph.
	 * @param columnId the zColumnId to set
	 */
	public void setZColumnId(int columnId) {
		zColumnId = columnId;
	}

	/**
	 * Returns format Id from {@link GraphFormatBean} for the graph.
	 * @return the graphFormatId
	 */
	public int getGraphFormatId() {
		return graphFormatId;
	}

	/**
	 * Sets format Id from {@link GraphFormatBean} for the graph.
	 * @param graphFormatId the graphFormatId to set
	 */
	public void setGraphFormatId(int graphFormatId) {
		this.graphFormatId = graphFormatId;
	}

	/**
	 * Sets title of graph.
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * Returns sub title of graph.
	 * @return the subTitle
	 */
	public String getSubTitle() {
		return subTitle;
	}

	/**
	 * Sets sub title of graph.
	 * @param subTitle the subTitle to set
	 */
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	/**
	 * Returns the description of graph.
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Sets the description of graph.
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * Returns the height of graph.
	 * @return the height
	 */
	public int getHeight() {
		return height;
	}

	/**
	 * Sets the height of graph.
	 * @param height the height to set
	 */
	public void setHeight(int height) {
		this.height = height;
	}

	/**
	 * Returns the width of graph.
	 * @return the width
	 */
	public int getWidth() {
		return width;
	}

	/**
	 * Sets the width of graph.
	 * @param width the width to set
	 */
	public void setWidth(int width) {
		this.width = width;
	}	
	
	/**
	 * Returns the type of chart.
	 * @return the chartType
	 */
	public int getChartType() {
		return chartType;
	}

	/**
	 * Sets the type of chart.
	 * @param chartType the chartType to set
	 */
	public void setChartType(int chartType) {
		this.chartType = chartType;
	}

	/**
	 * Loads all instances of graph into {@link TreeMap}.
	 * @return
	 */
	public static synchronized boolean loadAll(){
		lastAccessed = System.currentTimeMillis();		
		if (graphBeanMap != null) {
			return true;
		}
		boolean retStatus = false;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		GraphBean graphBean = null;
		String strQuery=null;
		try {
			graphBeanMap = new TreeMap();
			strQuery="select graphid,title,subtitle,description,height,width,charttype,xcolumnid,ycolumnid,zcolumnid,graphformatid from tblgraph order by graphid";
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);		
			while (rsw.next()) {
				graphBean= graphBean.getBeanByResultSetWrapper(rsw);
				if (graphBean != null) {
					graphBeanMap.put(new Integer(graphBean.getGraphId()), graphBean);
				}
			}
			retStatus = true;
		} catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->GraphBean : "+ e, e);
			retStatus = false;
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->GraphBean : "+ e, e);
			retStatus = false;
		} finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
				CyberoamLogger.repLog.error("GraphBean.e :"+e,e);
			}
		}
		return retStatus;
	}
	
	/**
	 * Obtains instance of {@link GraphBean} by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static GraphBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	GraphBean graphBean = new GraphBean();
    	try {
    		graphBean.setGraphId(rsw.getInt("graphid"));
    		graphBean.setTitle(rsw.getString("title"));
    		graphBean.setSubTitle(rsw.getString("subtitle"));
    		graphBean.setDescription(rsw.getString("description"));
    		graphBean.setHeight(rsw.getInt("height"));
    		graphBean.setWidth(rsw.getInt("width"));
    		graphBean.setChartType(rsw.getInt("charttype"));
    		graphBean.setXColumnId(rsw.getInt("xcolumnid"));
    		graphBean.setYColumnId(rsw.getInt("ycolumnid"));
    		graphBean.setZColumnId(rsw.getInt("zcolumnid"));
    		graphBean.setGraphFormatId(rsw.getInt("graphformatid"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->GraphBean: " + e,e);
    	}
    	return graphBean;
    }
	
	/**
	 * Obtains instance of {@link GraphBean} from graphBeanMap.
	 * @param primarykey
	 * @return
	 */
	public static GraphBean getRecordbyPrimarykey(int primarykey) {        
		lastAccessed = System.currentTimeMillis();
		GraphBean graphBean=null;
        try {
        	   if(graphBeanMap==null) {
               	loadAll();
               }
        	   graphBean=(GraphBean)graphBeanMap.get(new Integer(primarykey));
        	   if(graphBean==null) {
        		   graphBean=getSQLRecordByPrimaryKey(primarykey);
        		   if(graphBean!=null) {
        			   graphBeanMap.put(new Integer(graphBean.getGraphId()),graphBean);
        		   }
        	   }        	
        }catch(Exception e) {
        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->GraphBean: " + e,e);
        }
        return graphBean;
    }
	
	/**
	 * Obtains instance of {@link GraphBean} from tblgraph.
	 * @param primaryKey
	 * @return
	 */
    private static GraphBean getSQLRecordByPrimaryKey(int primaryKey){
		lastAccessed = System.currentTimeMillis();
		GraphBean graphBean = null;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		try{
			String sqlQuery = "select graphid,title,subtitle,description,height,width,charttype,xcolumnid,ycolumnid,zcolumnid,graphformatid from tblgraph where graphid="+ primaryKey ;			
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery);
			
			if(rsw.next()){
				graphBean=getBeanByResultSetWrapper(rsw);
			}
		}catch(SQLException se){
			CyberoamLogger.repLog.error("SQLException ->getSQLRecordByPrimaryKey() -> GraphBean: " + primaryKey + se,se);
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception ->getSQLRecordByPrimaryKey() -> GraphBean: " + primaryKey + e,e);
		}finally{
			try{
				sqlReader.close();
				rsw.close();
			}catch(Exception e){
			}
		}
		return graphBean;
	}
    
    /**
     * Returns {@link TreeMap} containing all instances of {@link GraphBean}.
     * @return
     */
	public static TreeMap  getGraphBeanMap() {
        try {
              if(graphBeanMap==null) {
				loadAll();
              }			
		}catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->getGraphBeanMap()->GraphBean: " + e,e);
		}
		return graphBeanMap;
    }
	
	/**
	 * Returns {@link Iterator} containing all instances of {@link GraphBean}.
	 * @return
	 */
    public static Iterator getGraphBeanIterator() {
       Iterator iterator=null;
       try {    	   
    	   	iterator=getGraphBeanMap().values().iterator();    	   
       }catch(Exception e) {
    	   	CyberoamLogger.sysLog.error("exception->getGraphBeanIterator()->GraphBean: " + e,e);
       }
       return iterator;
    }
    
    /**
     * Returns string representation of {@link GraphBean}.
     */
    public String toString(){
    	String strString="";
    	strString="\n\t graphid="+getGraphId()
    	+"\n\t title="+getTitle()
    	+"\n\t subtitle="+getSubTitle()
    	+"\n\t description="+getDescription()
    	+"\n\t height="+getHeight()
    	+"\n\t width="+getWidth()    	
    	+"\n\t charttype="+getChartType()
    	+"\n\t xcolumnid="+getXColumnId()
    	+"\n\t ycolumnid="+getYColumnId()
    	+"\n\t zcolumnid="+getZColumnId()
    	+"\n\t graphformatid="+getGraphFormatId();
    	return strString;
    }
}
