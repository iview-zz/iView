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

package org.cyberoam.iview.authentication.beans;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.ReportGroupBean;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This class represents iView menu entity. 
 * @author Amit Maniar
 *
 */
public class IviewMenuBean {

	private int iIviewMenuId;
	private String strLabel = null;
	private String strLink = null;
	private String strTarget = null;
	private String strToolTip = null;

	/**
	 * Returns iView menu identifier.
	 * @return menu Id
	 */
	public int getIviewMenuId() {
		return iIviewMenuId;
	}

	/**
	 * Set iView menu identifier.
	 * @param IviewMenuId
	 */
	public void setIviewMenuId(int IviewMenuId) {
		iIviewMenuId = IviewMenuId;
	}

	/**
	 * Returns iView menu label.
	 * @return label
	 */
	public String getLabel() {
		return strLabel;
	}

	/**
	 * Set iView menu label.
	 */
	public void setLabel(String strLabel) {
		this.strLabel = strLabel;
	}

	/**
	 * Returns hyperlink of menu item to webpage.
	 * @return hyper link
	 */
	public String getLink() {
		return strLink;
	}

	/**
	 * Set hyperlink of menu item to webpage.
	 */
	public void setLink(String strLink) {
		this.strLink = strLink;
	}

	/**
	 * Returns iView menu target link.
	 * @return target link
	 */
	public String getTarget() {
		return strTarget;
	}

	/**
	 * Set iView menu target link.
	 */
	public void setTarget(String strTarget) {
		this.strTarget = strTarget;
	}

	/**
	 * Returns tool tip of iView menu.
	 * @return tooltip
	 */
	public String getToolTip() {
		return strToolTip;
	}

	/**
	 * Set tool tip of iView menu.
	 */
	public void setToolTip(String strToolTip) {
		this.strToolTip = strToolTip;
	}

	/**
	 * Returns iterator of {@link IviewMenuBean} based on user level.<br>
	 * iView Menu is divided into four menu items.
	 * <br><ul>
	 * <li>Report Profile</li>
	 * <li>Reports</li>
	 * <li>System Configuration</li>
	 * <li>Search</li>
	 * </ul> 
	 * @param userlevel
	 * @return iterator of menu
	 */
	public static Iterator getIviewMenuIterator(int userlevel,int categoryId) {
		
		CyberoamLogger.appLog.debug("IviewMenuBean->CATEGORYID: " + categoryId);
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		IviewMenuBean iIviewMenuBean = null;
		String strQuery = null;
		TreeMap iIviewMenuMap = new TreeMap();
		Iterator itrIviewMenu = null;
		int groupid=-1;
		try {
			int i=0;
			strQuery = "select iviewmenuid,label,link,target,tooltip from tbldashboardmenu where rolelevel >= "+userlevel+" order by menuorder";
			ResultSetWrapper DashboardRsw = sqlReader.getInstanceResultSetWrapper(strQuery);
			while (DashboardRsw.next()) {
				iIviewMenuBean = IviewMenuBean.getBeanByResultSetWrapper(DashboardRsw);
				if (iIviewMenuBean != null) {
					iIviewMenuMap.put(new Integer(i++), iIviewMenuBean);
				}
			}
			
						
			iIviewMenuMap.put(new Integer(i++), IviewMenuBean.getBeanByString(i,"REPORTS"));
			strQuery = "select rg.reportgroupid as reportgroupid, rg.title as reportgrouptitle, r.title as reporttitle,r.reportid as reportid,rg.grouptype as grouptype,r.issinglereport as issingle from tblreportgroup rg," + 
				"tblreport r, tblreportgrouprel rel, tblreportgroup_category c where c.categoryid="+categoryId+"and c.reportgroupid=rg.reportgroupid and rg.reportgroupid = rel.reportgroupid and r.reportid = rel.reportid and (grouptype="+ReportGroupBean.STATIC_GROUP+
				" or grouptype="+ReportGroupBean.DYNAMIC_GROUP+ " or grouptype="+ReportGroupBean.TREND_GROUP+ "  ) order by grouptype asc,rg.menuorder,rg.reportgroupid,roworder"; 
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);
			 groupid=-1;
			boolean dynaGroup=false;
			boolean trendView=false;
			while (rsw.next()) {
				if(dynaGroup == false && rsw.getInt("grouptype")== ReportGroupBean.DYNAMIC_GROUP){
					iIviewMenuMap.put(new Integer(i++), IviewMenuBean.getBeanByString(i,"CUSTOM VIEWS"));
					//iIviewMenuMap.put(new Integer(i++), IviewMenuBean.getBeanByString(i,"REPORTS"));				
					dynaGroup=true;
				}  
				if(trendView == false && rsw.getInt("grouptype")== ReportGroupBean.TREND_GROUP){
					iIviewMenuMap.put(new Integer(i++), IviewMenuBean.getBeanByString(i,"TREND REPORTS"));
					//iIviewMenuMap.put(new Integer(i++), IviewMenuBean.getBeanByString(i,"REPORTS"));				
					trendView=true;
				}
				if(groupid!=rsw.getInt("reportgroupid")){
					iIviewMenuBean = IviewMenuBean.getBeanForReportGroup(i, rsw);
					if (iIviewMenuBean != null) {
						iIviewMenuMap.put(new Integer(i++), iIviewMenuBean);
					}
					groupid=rsw.getInt("reportgroupid");
				}
				iIviewMenuBean = IviewMenuBean.getBeanForReport(i,rsw);
				if (iIviewMenuBean != null) {
					iIviewMenuMap.put(new Integer(i++), iIviewMenuBean);
				}
			}
			
			//Description : Added Search Report Group Menu using the following code.
			//Category Id is used for displaying the Search Group in UTM Reports only.
			if(categoryId == 1){

				strQuery = "select rg.reportgroupid as reportgroupid, rg.title as reportgrouptitle, rg.description as description,rg.grouptype as grouptype from tblreportgroup rg where grouptype=" +ReportGroupBean.SEARCH_GROUP+" order by reportgroupid,menuorder";

				CyberoamLogger.repLog.debug("For Report ->strQuery: "	+ strQuery);
				rsw = sqlReader.getInstanceResultSetWrapper(strQuery);
			
				boolean searchView=false;
					
				while (rsw.next()) {
					if(searchView == false && rsw.getInt("grouptype")== ReportGroupBean.SEARCH_GROUP){
					iIviewMenuMap.put(new Integer(i++), IviewMenuBean.getBeanByString(i,"SEARCH"));
					searchView=true;
					}  
					if(groupid!=rsw.getInt("reportgroupid")){
						iIviewMenuBean = IviewMenuBean.getBeanForReportGroup(i, rsw);
						if (iIviewMenuBean != null) {
							iIviewMenuMap.put(new Integer(i++), iIviewMenuBean);
						}
						groupid=rsw.getInt("reportgroupid");
					}
				}
			}
			//Description: Search Report Ends Here

			strQuery="select bg.name as bgname,bk.name as bkname,bk.bookmarkgroupid as bkgroup,bk.url as bkurl,bk.description as bkdescription from tblbookmark bk,tblbookmarkgroup bg where bg.bookmarkgroupid=bk.bookmarkgroupid and bk.categoryid="+categoryId+"";
			rsw=sqlReader.getResultSetWrapper(strQuery);
			if(rsw.next()){
				iIviewMenuMap.put(new Integer(i++), IviewMenuBean.getBeanByString(i,"BOOKMARKS"));
				int bgid=-1;
				do{
					if(bgid!=rsw.getInt("bkgroup")){
						iIviewMenuBean=IviewMenuBean.getBeanForBookmarkGroup(i,rsw);
						if (iIviewMenuBean != null) {
							iIviewMenuMap.put(new Integer(i++), iIviewMenuBean);
						}
						bgid=rsw.getInt("bkgroup");
					}
					iIviewMenuBean = IviewMenuBean.getBeanForBookmark(i,rsw);
					if (iIviewMenuBean != null) {
						iIviewMenuMap.put(new Integer(i++), iIviewMenuBean);
					}
				}while(rsw.next());
			}
			if(categoryId == 1){
			strQuery = "select iviewmenuid,label,link,target,tooltip from tbliviewmenu where rolelevel >= "+userlevel+" order by menuorder";
			}else{
				strQuery = "select iviewmenuid,label,link,target,tooltip from tbliviewmenu where rolelevel >= "+userlevel+" and menuorder >= 1.00000 order by menuorder";
			}
			rsw = sqlReader.getInstanceResultSetWrapper(strQuery);
			while (rsw.next()) {
				iIviewMenuBean = IviewMenuBean.getBeanByResultSetWrapper(rsw);
				if (iIviewMenuBean != null) {
					iIviewMenuMap.put(new Integer(i++), iIviewMenuBean);
				}
			}

			itrIviewMenu = iIviewMenuMap.values().iterator();
		} catch (SQLException e) {
			CyberoamLogger.repLog.error(
					"Sqlexception->loadAll()->IviewMenuBean : " + e, e);
		} catch (Exception e) {
			CyberoamLogger.repLog.error(
					"Exception->loadAll()->IviewMenuBean : " + e, e);
		} finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
				
			}
		}
		return itrIviewMenu;
	}
	
	/**
	 * Obtain iViewMenuBean by {@link ResultSetWrapper}.
	 * @param rsw - ResultSetWrapper
	 * @return instance of iViewMenu
	 */
	public static IviewMenuBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		IviewMenuBean IviewMenuBean = new IviewMenuBean();
		try {
			IviewMenuBean.setIviewMenuId(rsw.getInt("iviewmenuid"));
			IviewMenuBean.setLabel(TranslationHelper.getTranslatedMessge(rsw.getString("label")));
			IviewMenuBean.setLink(rsw.getString("link"));
			IviewMenuBean.setTarget(rsw.getString("target"));
			IviewMenuBean.setToolTip(rsw.getString("tooltip"));
		} catch (Exception e) {
			CyberoamLogger.repLog.error(
					"Exception->getBeanByResultSetWrapper()->iviewMenuBean: "
							+ e, e);
		}
		return IviewMenuBean;
	}

	/**
	 * Obtains instance of iViewMenu for report group from id and {@link ResultSetWrapper}.
	 * @param id - report group Id
	 * @param rsw - result set wrapper
	 * @return iView menu entity
	 */
	public static IviewMenuBean getBeanForReportGroup(int id,ResultSetWrapper rsw) {
		IviewMenuBean IviewMenuBean = new IviewMenuBean();
		try {
			IviewMenuBean.setIviewMenuId(id);
			IviewMenuBean.setLabel("|"+TranslationHelper.getTranslatedMessge(rsw.getString("reportgrouptitle")));
			if(rsw.getInt("grouptype")== ReportGroupBean.DYNAMIC_GROUP){
				IviewMenuBean.setLink("reportgroup.jsp?reportgroupid="+rsw.getInt("reportgroupid"));
			}
			if(rsw.getInt("grouptype")== ReportGroupBean.SEARCH_GROUP){
				IviewMenuBean.setLink(rsw.getString("description"));
			}			
			IviewMenuBean.setTarget(null);
			IviewMenuBean.setToolTip(null);
		} catch (Exception e) {
			CyberoamLogger.repLog.error(
					"Exception->getBeanByResultSetWrapper()->iviewMenuBean: "
							+ e, e);
		}
		return IviewMenuBean;
	}
	
	/**
	 * Returns instance {@link IviewMenuBean} for report from Id and {@link ResultSetWrapper}. 
	 * @param id - report id
	 * @param rsw - result set wrapper
	 * @return iView menu entity
	 */
	public static IviewMenuBean getBeanForReport(int id,ResultSetWrapper rsw) {
		IviewMenuBean IviewMenuBean = new IviewMenuBean();
		try {
			IviewMenuBean.setIviewMenuId(id);
			IviewMenuBean.setLabel("||"+TranslationHelper.getTranslatedMessge(rsw.getString("reporttitle")));
			if(rsw.getInt("issingle") == 1){
				IviewMenuBean.setLink("reportgroup.jsp?reportgroupid="+rsw.getInt("reportid"));
			}else if (rsw.getInt("grouptype")== ReportGroupBean.TREND_GROUP){
				IviewMenuBean.setLink("singlereport.jsp?reportid="+rsw.getInt("reportid")+"&reportgroupid="+rsw.getInt("reportgroupid")+"&navigation=false");
			} 
			else {
				IviewMenuBean.setLink("singlereport.jsp?reportid="+rsw.getInt("reportid")+"&reportgroupid="+rsw.getInt("reportgroupid"));
			}
			IviewMenuBean.setTarget(null);
			IviewMenuBean.setToolTip(null);
		} catch (Exception e) {  
			CyberoamLogger.repLog.error(
					"Exception->getBeanByResultSetWrapper()->iviewMenuBean: "
							+ e, e);
		}
		return IviewMenuBean;
	}
	
	/**
	 * Obtains instance of iViewMenu for Bookmark group from id and {@link ResultSetWrapper}.
	 * @param id - iView menu Id
	 * @param rsw - result set wrapper
	 * @return iView menu entity
	 */
	
	public static IviewMenuBean getBeanForBookmarkGroup(int id,ResultSetWrapper rsw) {
		IviewMenuBean IviewMenuBean = new IviewMenuBean();
		try {
			IviewMenuBean.setIviewMenuId(id);
			IviewMenuBean.setLabel("|"+rsw.getString("bgname"));
			IviewMenuBean.setTarget(null);
			IviewMenuBean.setToolTip(null);
		} catch (Exception e) {
			CyberoamLogger.repLog.error(
					"Exception->getBeanForBookmarkGroup()->iviewMenuBean: "
							+ e, e);
		}
		return IviewMenuBean;
	}
	
	/**
	 * Obtains instance of iViewMenu for Bookmarks from id and {@link ResultSetWrapper}.
	 * @param id - iView menu Id
	 * @param rsw - result set wrapper
	 * @return iView menu entity
	 */
	
	public static IviewMenuBean getBeanForBookmark(int id,ResultSetWrapper rsw) {
		IviewMenuBean IviewMenuBean = new IviewMenuBean();
		try {
			IviewMenuBean.setIviewMenuId(id);
			IviewMenuBean.setLabel("||"+rsw.getString("bkname"));
			IviewMenuBean.setLink(rsw.getString("bkurl"));
			IviewMenuBean.setTarget(null);
			IviewMenuBean.setToolTip(rsw.getString("bkdescription"));
		} catch (Exception e) {
			CyberoamLogger.repLog.error(
					"Exception->getBeanForBookmark()->iviewMenuBean: "
							+ e, e);
		}
		return IviewMenuBean;
	}
	
	/**
	 * Returns instance of {@link IviewMenuBean} by Id and title.
	 * @param id - iView menu Id
	 * @param title - menu title
	 * @return iView menu entity
	 */
	public static IviewMenuBean getBeanByString(int id,String title) {
		IviewMenuBean IviewMenuBean = new IviewMenuBean();
		try {
			IviewMenuBean.setIviewMenuId(id);
			IviewMenuBean.setLabel(TranslationHelper.getTranslatedMessge(title));
			IviewMenuBean.setLink(null);
			IviewMenuBean.setTarget(null);
			IviewMenuBean.setToolTip(null);
		} catch (Exception e) {
			CyberoamLogger.repLog.error(
					"Exception->getBeanByResultSetWrapper()->iviewMenuBean: "
							+ e, e);
		}
		return IviewMenuBean;
	}
	
	/**
	 * Returns iViewMenu based on user level.
	 * @param userLevel - user role level
	 * @return iView menu
	 */
	public static String getIviewMenu(int userLevel,int categoryId){
		CyberoamLogger.appLog.debug("IviewMenuBean->CATEGORYID: " + categoryId);
		StringBuffer strRet = new StringBuffer("");
		Iterator itrIviewMenu = IviewMenuBean.getIviewMenuIterator(userLevel,categoryId);
		IviewMenuBean IviewMenuBean = null;
		while (itrIviewMenu.hasNext()) {
			try {
				IviewMenuBean = (IviewMenuBean) itrIviewMenu.next();
				strRet.append("[");
				strRet.append(getString(IviewMenuBean.getLabel())+ ",");
				if(IviewMenuBean.getLink() != null){
						strRet.append("\""+IviewMenuBean.getLink() + "\",");
				}else{
					strRet.append(getString(IviewMenuBean.getLink()) + ",");
				}
				strRet.append(getString(IviewMenuBean.getToolTip()) + ",");
				strRet.append("\"\",\"\",\"\",\"\",\"\",\"\",");
				strRet.append("],");
			} catch (Exception e) {
				CyberoamLogger.repLog.debug("Exception in IviewMenuBean.getMenuForJavascript->" + e, e);
			}
		}
		return strRet.toString();
	}

	/**
	 * Returns quoted string.
	 * @param strParam - string to be quoted
	 * @return iView menu
	 */
	private static String getString(String strParam) {
		String strRetVal;
		if (strParam == null) {
			strRetVal = "\"\"";
		} else {
			strRetVal = "\"" + strParam + "\"";
		}
		return strRetVal;
	}

	/**
	 * Returns string representation of {@link IviewMenuBean}.
	 */
	public String toString() {
		String strString = "";
		strString = "iviewmenuid=" + getIviewMenuId() + "\tlabel="
				+ getLabel() + "\tlink=" + getLink() + "\ttarget="
				+ getTarget() + "\ttooltip=" + getToolTip();

		return strString;
	}

}
