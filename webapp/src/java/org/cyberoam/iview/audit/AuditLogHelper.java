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

package org.cyberoam.iview.audit;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.service.http.HttpRequestAdapter;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;



/**
 * This helper class is used for audit logging of iView.
 * @author Narendra Shah
 *
 */
public class AuditLogHelper {
	
	/**
	 * Return Audit logs between given start date and end date from tblauditlog. 
	 * @param startDate - starting Date
	 * @param endDate - ending Date
	 * @param offset - offset of record
	 * @param limit - limit of records
	 * @return ResultSetWrapper containing audit logs
	 */
	public static ResultSetWrapper getLogs(HttpServletRequest request){
		int offset=0, limit=15;
		String where = "where";
		where += " actiontime >= "+StringMaker.makeString(request.getSession().getAttribute("startdate").toString());
		where += " and actiontime <= "+StringMaker.makeString(request.getSession().getAttribute("enddate").toString());
		if (request.getParameter("severity") != null 
				&& (!"".equalsIgnoreCase(request.getParameter("severity")))
				&& (!"-1".equalsIgnoreCase(request.getParameter("severity")))){
	    	where += " and severity = "+Integer.parseInt(request.getParameter("severity"));
	    }
		if (request.getParameter("category") != null
				&& (!"".equalsIgnoreCase(request.getParameter("category")))
				&& (!"-1".equalsIgnoreCase(request.getParameter("category")))){
	    	where += " and categoryid = "+Integer.parseInt(request.getParameter("category"));
	    }
	    if (request.getParameter("offset") != null && (!"".equalsIgnoreCase(request.getParameter("offset")))){
	    	offset = Integer.parseInt(request.getParameter("offset"));
	    }
	    if (request.getParameter("logLimit") != null && (!"".equalsIgnoreCase(request.getParameter("logLimit")))){
	    	limit = Integer.parseInt(request.getParameter("logLimit"));
	    }
	    SqlReader sqlReader=null;
		ResultSetWrapper rsw=null;
		String sqlQry = "";
		try {
			sqlReader=new SqlReader();
			sqlQry = "select * from tblauditlog "+where+" order by actiontime desc limit "+limit+" offset "+offset;
			rsw=sqlReader.getInstanceResultSetWrapper(sqlQry);
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("Exception->AuditHelper->getLogs.e:" +e, e);
		}finally {
			try {
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return rsw;
	}
	
	/**
	 * Returns number of records between given start date and end date from tblauditlog.
	 * @param startDate - starting Date
	 * @param endDate - ending Date
	 * @return number of logs
	 */
	public static int getNumOfLogs(String startDate, String endDate){
		SqlReader sqlReader=null;
		ResultSetWrapper rsw=null;
		String sqlQry = "";
		int cnt = 0;
		try {
			sqlReader=new SqlReader();
			sqlQry = "select count(*) from tblauditlog where actiontime >= " + StringMaker.makeString(startDate) +" and actiontime <= "+ StringMaker.makeString(endDate);
			rsw=sqlReader.getInstanceResultSetWrapper(sqlQry);
			if (rsw.next()){ 
				cnt = rsw.getInt("count");
			}
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("Exception->AuditHelper->getNumOfLogs.e:" +e, e);
			cnt = 0;
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return cnt;
	}
	
	/**
	 * Returns XML1.0 text containing records of audit logs.
	 * Each XML will contain one &lt;rows&gt; tag which contains total_count attribute for number of records where
	 * &lt;rows&gt; will contain multiple &lt;row&gt; tag for each record of audit log.
	 * each &lt;row&gt; will contain &lt;cell&gt; containing different fields
	 * @param rsw - ResultSetWrapper
	 * @return XML String
	 */
	public static String generateXML(ResultSetWrapper rsw) {
		StringBuffer strXML = new StringBuffer();
		String retStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
		int cnt=0;
		String[] severity = {"Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Info", "Debug"}; 
		String[] category = {"Mail", "User", "Device", "Application", "Views", "Data", "Archive", "Report"};
		try{ 
		    while (rsw.next()) {
		    	cnt++;
		    	strXML.append("<row id='" + rsw.getInt("logid") + "'>");
		    	strXML.append("<cell>" + rsw.getString("actiontime") + "</cell>");
		    	strXML.append("<cell>" + category[rsw.getInt("categoryid")] + "</cell>");
		    	strXML.append("<cell>" + severity[rsw.getInt("severity")] + "</cell>");
		    	strXML.append("<cell>" + rsw.getString("message") + "</cell>");
		    	strXML.append("<cell>" + rsw.getString("username") + "</cell>");
		    	strXML.append("<cell>" + rsw.getString("ipaddress") + "</cell>");
		    	strXML.append("</row>");
		    }
		    strXML.append("</rows>");
		    retStr += "<rows total_count='" + cnt + "' pos='0'>" + strXML.toString();
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("Exception->AuditHelper->generateXML:e"+e,e);
		}finally {
			try {
				rsw.close();
			} catch (Exception e) {
			}
		}
		return retStr;
	}
}
