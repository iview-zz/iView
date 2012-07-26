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
package org.cyberoam.iview.helper;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.CategoryReportGroupRelationBean;
import org.cyberoam.iview.beans.MailScheduleBean;
import org.cyberoam.iview.beans.ReportGroupBean;
import org.cyberoam.iview.beans.ReportGroupRelationBean;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This helper class is used to manage report profiles into database table.
 * @author Amit Maniar
 *
 */
public class ReportProfileHelper {

    /**
	 * Checks for group type of custom view  
	 * @return
	 */
	public static int checkForCustomView(){
		String sqlQuery = null;		
		int retStatus = -1;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="select count(*) as count from TBLREPORTGROUP  where GROUPTYPE=2";
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery,120);
			if (rsw.next() && rsw.getInt("count")>0){ 
				retStatus=rsw.getInt("count");
			}
			CyberoamLogger.appLog.error("Exception->checkForDuplicate()->ReportProfilehelper->retStatus: " + retStatus);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->checkForDuplicate()->ReportProfilehelper->: " + e);
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
	 * This method inserts new report profile into database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int addReportProfile(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		int retStatus=-1;
		ReportGroupBean reportGroupBean = null;
		CategoryReportGroupRelationBean categoryReportGroupRelationBean = null;
		String reportProfileName = request.getParameter("profilename");
		try{
			CyberoamLogger.appLog.debug("addReportProfile() : CATEGORY " + request.getParameter("customViewCategory"));
			if(request.getParameter("customViewCategory")==null)
				return -1;
			
			reportGroupBean = new ReportGroupBean();
			String description = request.getParameter("profiledesc");
			String[] report = request.getParameterValues("reportid");
			reportGroupBean.setTitle(reportProfileName);
			reportGroupBean.setDescription(description);
			reportGroupBean.setGroupType(ReportGroupBean.DYNAMIC_GROUP);
			reportGroupBean.setInputParams("deviceid");
			reportGroupBean.setCategoryId(Integer.parseInt(request.getParameter("customViewCategory")));
			returnStatus = reportGroupBean.insertRecord();
			categoryReportGroupRelationBean = new CategoryReportGroupRelationBean();
			categoryReportGroupRelationBean.setReportGroupId(returnStatus);
			categoryReportGroupRelationBean.setCategoryId(Integer.parseInt(request.getParameter("customViewCategory")));
			retStatus=categoryReportGroupRelationBean.insertRecord();
			CyberoamLogger.appLog.debug("addReportProfile() : returnStatus " + returnStatus + " retStatus "+retStatus);
			if(returnStatus!=-4 && retStatus!=-1){
				ReportGroupRelationBean reportGroupRelationBean = new ReportGroupRelationBean();
				ArrayList reportGroupRelList = new ArrayList(report.length);
				int rowOrder = 2;
				for(int i=0; i<report.length; i++){
					if(i%2 == 0){
						rowOrder+=9;
					} else {
						rowOrder+=1;
					}
					reportGroupRelationBean = new ReportGroupRelationBean();
					reportGroupRelationBean.setReportGroupId(returnStatus);
					reportGroupRelationBean.setReportId(Integer.parseInt(report[i]));
					reportGroupRelationBean.setRowOrder(rowOrder);
					reportGroupRelationBean.insertRecord();
					reportGroupRelList.add(i,reportGroupRelationBean);
				}
				ReportGroupRelationBean.getReportGroupRelationBeanMap().put(new Integer(returnStatus), reportGroupRelList);
				CyberoamLogger.appLog.debug("addReportProfile() : arraylist : size " + reportGroupRelList.size());
			}
			if(request.getParameter("customViewCategory").toString().equals(request.getSession().getAttribute("categoryid").toString())){
				int status=checkForCustomView();
				if(status==-1){
					String lastAccess=request.getSession().getAttribute("lastAccess").toString();
					lastAccess=lastAccess.replace(lastAccess.substring(0,1),new Integer(Integer.parseInt(lastAccess.substring(0,1))+1).toString());
					request.getSession().setAttribute("lastAccess",lastAccess);
				}
				else{
					String lastAccess=request.getSession().getAttribute("lastAccess").toString();
					request.getSession().setAttribute("lastAccess",lastAccess);
				}
			}
				
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside addReportProfile() :ReportProfileHelper "+e,e);
			returnStatus = -1;
		}
		if(returnStatus>=0){
			AuditLog.report.info("Report profile " + reportProfileName + " added successfully", request);
		} else {
			AuditLog.report.info("Report profile " + reportProfileName + " addition failed", request);
		}
		return returnStatus;
	}
	
	/**
	 * This method updates report profile into database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int updateReportProfile(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1;
		ReportGroupBean reportGroupBean = null;
		String reportProfileName = "";
		try{
			reportGroupBean = new ReportGroupBean();
			String reportProfileId = request.getParameter("profileid");
			String description = request.getParameter("profiledesc");
			String[] report = request.getParameterValues("reportid");
			reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(Integer.parseInt(reportProfileId));
			reportProfileName = reportGroupBean.getTitle();
			reportGroupBean.setReportGroupId(Integer.parseInt(reportProfileId));
			reportGroupBean.setDescription(description);
			reportGroupBean.setGroupType(ReportGroupBean.DYNAMIC_GROUP);
			reportGroupBean.setInputParams("deviceid");
			returnStatus = reportGroupBean.updateRecord();
			CyberoamLogger.appLog.debug("updateReportProfile() : returnStatus " + returnStatus);
			
			if(returnStatus != -4){
				ReportGroupRelationBean reportGroupRelationBean = new ReportGroupRelationBean();
				reportGroupRelationBean.setReportGroupId(reportGroupBean.getReportGroupId());
				returnStatus = reportGroupRelationBean.deleteRecord();
				
				ArrayList reportGroupRelList = new ArrayList();
				int rowOrder = 2;
				for(int i=0; i<report.length; i++){
					if(i%2 == 0){
						rowOrder+=9;
					} else {
						rowOrder+=1;
					}
					reportGroupRelationBean = new ReportGroupRelationBean();
					reportGroupRelationBean.setReportGroupId(reportGroupBean.getReportGroupId());
					reportGroupRelationBean.setReportId(Integer.parseInt(report[i]));
					reportGroupRelationBean.setRowOrder(rowOrder);
					CyberoamLogger.appLog.debug("updateReportProfile()->reportGroupRelBean : " + reportGroupRelationBean);
					reportGroupRelationBean.insertRecord();
					CyberoamLogger.appLog.debug("updateReportProfile()-> reportGrouprelBean" + reportGroupRelationBean.toString());
					reportGroupRelList.add(reportGroupRelationBean);
				}
				ReportGroupRelationBean.getReportGroupRelationBeanMap().put(new Integer(reportGroupBean.getReportGroupId()), reportGroupRelList);
			}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside updateReportProfile() :ReportProfileHelper "+e,e);
			returnStatus = -1;
		}
		if(returnStatus>=0){
			AuditLog.report.info("Report profile " + reportProfileName + " updated successfully", request);
		} else {
			AuditLog.report.info("Report profile " + reportProfileName + " updation failed", request);
		}
		return returnStatus;
	}
	
	/**
	 * This method deletes report profile from database table.
	 * @param request
	 * @param response
	 * @return
	 */
	public static int deleteReportProfile(HttpServletRequest request,HttpServletResponse response){
		int returnStatus = -1,recDeleted = -1;
		String reportProfileIds[] = request.getParameterValues("select");
		try{
			String reportProfileList="";
			for(int i=0;i<reportProfileIds.length;i++){
				reportProfileList += reportProfileIds[i]+ ",";
			}
			reportProfileList = reportProfileList.substring(0,reportProfileList.length()-1);
			
			//getting mail schedule ids of the reportgroup ids.
			String mailDeleted=MailScheduleBean.getMailScheduleForViews(reportProfileList);
			recDeleted=MailScheduleBean.deleteAllRecord(mailDeleted);
			CyberoamLogger.appLog.debug("deletemailschedule() from tblmailschedule: returnStatus " + recDeleted);
			
			recDeleted = CategoryReportGroupRelationBean.deleteAllRecordByReportGroupId(reportProfileList);
			CyberoamLogger.appLog.debug("deleteReportProfile() from categoryreportgrouprelation: returnStatus " + recDeleted);
			recDeleted = ReportGroupBean.deleteAllRecord(reportProfileList);
			CyberoamLogger.appLog.debug("deleteReportProfile() from reportgroup : returnStatus " + recDeleted);			
			if(recDeleted >= 0){
				returnStatus = ReportGroupRelationBean.deleteAllRecord(reportProfileList);
				CyberoamLogger.appLog.debug("deleteReportGroupRelation() : returnStatus " + returnStatus);
				if(returnStatus > 0)
					returnStatus = reportProfileIds.length;				
			}			
			ArrayList<Integer> reports=CategoryReportGroupRelationBean.getReportgroupListByCategory(Integer.parseInt(request.getSession().getAttribute("categoryid").toString()));
			ReportGroupBean reportGroupBean=null;
			int cnt=0;
			if(reports!=null && reports.size()>0){			
				for(int i=0;i<reports.size();i++){
					//reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(Integer.parseInt(reports.get(i).toString()));					
					reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reports.get(i));
					if(reportGroupBean.getGroupType() == ReportGroupBean.DYNAMIC_GROUP){						
						cnt++;
					}
				}				
			}			
			if(cnt==0){
				String lastAccess=request.getSession().getAttribute("lastAccess").toString();
				lastAccess=lastAccess.replace(lastAccess.substring(0,1),new Integer(Integer.parseInt(lastAccess.substring(0,1))-1).toString());
				request.getSession().setAttribute("lastAccess",lastAccess);				
			}
			
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception inside deleteReportProfile() :ReportProfileHelper "+e,e);
			AuditLog.report.debug("Report profile deletion failed due to " + e.getMessage(), request);
			return -1;
		}
		if(recDeleted == reportProfileIds.length){
			AuditLog.report.info(recDeleted + " report profiles deleted", request);
		} else {
			AuditLog.report.info(recDeleted + " report profile(s) deleted successfully", request);
			AuditLog.report.critical((reportProfileIds.length-recDeleted) + " report profile(s) deleted successfully", request);
		}
		return recDeleted;
	}
}
