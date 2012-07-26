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

package org.cyberoam.iview.utility;

import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.beans.DataBaseConfigBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.modes.TabularReportConstants;

/**
 * This utility class is used to prepare SQL query for reports.
 * @author Narendra Shah
 *
 */
public class PrepareQuery {
	String totalQuery=null; 
	String query=null;

	/**
	 * Returns prepared query.
	 */
	public String getQuery() {
		return query;
	}
	/**
	 * Returns SQL Query that can give total number of records for given report.
	 */
	public String getTotalQuery() {
		return totalQuery;
	}
	/**
	 * Default constructor.
	 */
	public PrepareQuery(){}
	/**
	 * Constructor which initializes report entity and HTTP request entity.
	 * @param reportBean
	 * @param req
	 */
	public PrepareQuery(ReportBean reportBean,HttpServletRequest req){
		getQuery(reportBean,req);
	}

	/**
	 * This method prepares SQL query from given report entity and HTTP request entity.
	 * @param reportBean
	 * @param req
	 * @return
	 */
	public String getQuery(ReportBean reportBean,HttpServletRequest req){
		String timestamp[]= new String[2];
		int flag=0,tblindex=-1;;
		try {
			
			HttpSession sess = req.getSession(false);
			StringTokenizer stToken = new StringTokenizer(reportBean.getInputParams(),",");
			Object[] paramValues =null;
			paramValues = new Object[stToken.countTokens()];
			for(int i=0;stToken.hasMoreTokens();i++){				
				String paramName = stToken.nextToken();
				if("tbl".equalsIgnoreCase(paramName)){
					String startDate=null;
					String endDate=null;
				
					if(sess.getAttribute("startdate")== null || ((String)sess.getAttribute("startdate")).equals("")){
						startDate = req.getParameter("startdate");
					}else{
						startDate = (String)sess.getAttribute("startdate");
					}
					
					if((sess.getAttribute("enddate")== null) || ((String)sess.getAttribute("enddate")).equals("")){
						endDate = req.getParameter("enddate");
					}else{
						endDate = (String)sess.getAttribute("enddate");
					}
					
					if(startDate != null && endDate != null){
						String startDatearray[]=startDate.split(" ");
						String endDatearray[]=endDate.split(" ");
						Date currentDate=new Date();
						String strcurdate=DateDifference.dateToStringMysqlSmallFormat(currentDate);
						
						if(strcurdate.equals(startDatearray[0]) && (strcurdate.equals(endDatearray[0]))){ 
							timestamp[0] ="_5min";						
							timestamp[1]=null;
						}else if((strcurdate.equals(endDatearray[0]))){
							timestamp[0]="_24hr";
							timestamp[1]="_5min";
						}else{
							timestamp[0] ="_24hr";						
							timestamp[1]= null;
						}
										
						
					}else{
						timestamp[0]="_5min";
					}
					
					if(reportBean.getTableName()!=null && !"".equalsIgnoreCase(reportBean.getTableName().trim())){
						if((reportBean.getTableName().indexOf(',') > 0) || timestamp[1]!=null){
						String strQuery = "";
						String unionQuery = "";					
						
						for(int j=0;j<timestamp.length;j++){
							StringTokenizer rowTokens =  new StringTokenizer(reportBean.getTableName().trim(),",");
							for(int r=0;rowTokens.hasMoreTokens();r++){								
								String tableName = rowTokens.nextToken();								
								String colList = reportBean.getMinSetOfCol();
									if(timestamp[j]!=null){
									strQuery = " select " + colList + ", " + r + " as tmpfield from " + tableName+timestamp[j] + " where \"5mintime\" >='" + startDate + "' and \"5mintime\" < '" +  endDate + "' ";
									if("".equals(unionQuery))
										unionQuery = strQuery ;
									else
										unionQuery = unionQuery + " UNION ALL "  + strQuery ;
									}
								}
							}		
								paramValues[i]= " ( " + unionQuery + " ) as tmp ";
							
						}
						else{
							paramValues[i]=reportBean.getTableName().trim()+timestamp[0] ;
						}
						
					}
					else
					{
						paramValues[i]=timestamp[0];	
						
						if(reportBean.getQuery().startsWith("select * from get") && timestamp[1]!=null){
							if(reportBean.getQuery().startsWith("select * from getdash")) {
								paramValues[i]="both";
								flag=0; 
							}else {
							flag=1;
							tblindex=i;
						}
					}
					}					
					
				}else if("orderby".equalsIgnoreCase(paramName)){					
					if(req.getParameter(paramName)==null || "".equals(req.getParameter(paramName))){
						paramValues[i] = reportBean.getDefaultColumnForSort();
					}else{
						paramValues[i]=req.getParameter(paramName);
					}
				}else if("enddate".equalsIgnoreCase(paramName)){
					if(sess!=null){
						if((sess.getAttribute("enddate")== null) || ((String)sess.getAttribute("enddate")).equals("")){
							paramValues[i] = req.getParameter("enddate");
						}else{
							paramValues[i] = sess.getAttribute("enddate");
						}
					}else {
							paramValues[i] = req.getParameter("enddate");
					}
				}else if("startdate".equalsIgnoreCase(paramName)){
					if(sess!=null){
						if(sess.getAttribute("startdate")== null || ((String)sess.getAttribute("startdate")).equals("")){
							paramValues[i] = req.getParameter("startdate");
						}else{
							paramValues[i] = sess.getAttribute("startdate");
						} 
					}else {
							paramValues[i] = req.getParameter("startdate");
					}									
				}else if("ordertype".equalsIgnoreCase(paramName)){
					if(req.getParameter(paramName)==null || "".equals(req.getParameter(paramName))){
						paramValues[i] = "desc";
					}else{
						paramValues[i]=req.getParameter(paramName);
					}					
				}else if("limit".equalsIgnoreCase(paramName)){
					
					if(req.getParameter(paramName)!=null && !"".equals(req.getParameter(paramName))){
						paramValues[i]=req.getParameter(paramName);
					}else if(sess.getAttribute("limit") != null){
						paramValues[i]=sess.getAttribute("limit");
					}else {
						paramValues[i]=Integer.toString(TabularReportConstants.DEFAULT_LIMIT);
					}
				}else if("offset".equalsIgnoreCase(paramName)){
					if(req.getParameter(paramName)!=null && !"".equals(req.getParameter(paramName))){
						paramValues[i]=req.getParameter(paramName);
					}else if(sess.getAttribute("offset") != null) {
						paramValues[i]=sess.getAttribute("offset");
					} 
					else {
						paramValues[i]=Integer.toString(TabularReportConstants.DEFAULT_OFFSET);
					}
				}else if("appid".equalsIgnoreCase(paramName)){
					if (sess.getAttribute("appliancelist") != null || "null".equals(sess.getAttribute("appliancelist"))) {
						paramValues[i]=sess.getAttribute("appliancelist");
					}
					if("".equals(paramValues[i])){
						paramValues[i]="''";
					}
				}				
				else{
					if(req.getParameter(paramName)!=null && !"".equalsIgnoreCase(req.getParameter(paramName))){
						paramValues[i]=req.getParameter(paramName).trim().replaceAll("'", "''");
					} else {
						paramValues[i]="";
					}
					
				}
			}
			MessageFormat queryFormat=null;			
			if(reportBean.getReportId()==1002 && timestamp[1]!=null){
				queryFormat = new MessageFormat(reportBean.getMinSetOfCol());
			    query = queryFormat.format(paramValues);
				totalQuery="select count(*) from ( "+query+" )as tmp";
			}
			else{
			queryFormat = new MessageFormat(reportBean.getQuery());
			query = queryFormat.format(paramValues);
			queryFormat = new MessageFormat(reportBean.getTotalQuery());
			totalQuery = queryFormat.format(paramValues);
			}
			String tempquery=null;
			if(flag == 1 && tblindex!=-1 && timestamp[1]!=null){
				queryFormat = new MessageFormat(reportBean.getQuery());
				paramValues[tblindex]=timestamp[1];
				tempquery=queryFormat.format(paramValues);
				if(query.startsWith("select * from get")){
					String colList = reportBean.getMinSetOfCol();
					if(colList != null){
					query="select "+colList.split(":")[0]+"  from("+query +" union all "+tempquery+")as tmp group by  "+colList.split(":")[1];
					}					
				}else{				
				query=query+"  union all "+tempquery;
				}
				queryFormat = new MessageFormat(reportBean.getTotalQuery());
				totalQuery = queryFormat.format(paramValues);
				totalQuery="select count(*) from ( "+query+" )as tmp";
				
			}
					   
			}catch(Exception e){
			CyberoamLogger.repLog.debug("PrepareQuery.e:" +e ,e);
		}	
		return query;
		
	}
	
	/**
	 * This method is used to prepare SQL query for given report entity and 
	 * time period will be from start date and end date applied to it. 
	 * @param reportBean
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static String getQuery(ReportBean reportBean,String startDate,String endDate){
		return getQuery(reportBean,startDate,endDate,null,null,null,null,null,null);
	}
	/**
	 * This method is used to prepare SQL query for given report entity and
	 * this also takes some other required parameters.
	 * @param reportBean - report entity
	 * @param startDate - start date
	 * @param endDate - end date
	 * @param applianceID - appliance Id
	 * @param orderBy - column to be ordered
	 * @param orderType - type of order
	 * @param offset - offset to be used in SQL query
	 * @param limit - limit of records in SQL query
	 * @return
	 */
	public static String getQuery(ReportBean reportBean,String startDate,String endDate,String applianceID,String orderBy,String orderType,String offset,String limit,LinkedHashMap paramMap){
		String strquery=null;
		try {
			StringTokenizer stToken = new StringTokenizer(reportBean.getInputParams(),",");
			Object[] paramValues =null;
			String timestamp[]=new String [2];
			int flag=0,tblindex=-1;
			paramValues = new Object[stToken.countTokens()];
			for(int i=0;stToken.hasMoreTokens();i++){				
				String paramName = stToken.nextToken();
				if("tbl".equalsIgnoreCase(paramName)){
						if(startDate != null && endDate != null){
						String startDatearray[]=startDate.split(" ");
						String endDatearray[]=endDate.split(" ");
						Date currentDate=new Date();
						String strcurdate=DateDifference.dateToStringMysqlSmallFormat(currentDate);
						
						if(strcurdate.equals(startDatearray[0]) && (strcurdate.equals(endDatearray[0]))){ 
							timestamp[0] ="_5min";						
							timestamp[1]=null;
						}else if((strcurdate.equals(endDatearray[0]))){
							timestamp[0]="_24hr";
							timestamp[1]="_5min";
						}else{
							timestamp[0] ="_24hr";						
							timestamp[1]= null;
						}
										
						
					}else{
						timestamp[0]="_5min";
					}
					
					if(reportBean.getTableName()!=null && !"".equalsIgnoreCase(reportBean.getTableName().trim())){
						if((reportBean.getTableName().indexOf(',') > 0) || timestamp[1]!=null){
						String strQuery = "";
						String unionQuery = "";					
						
						for(int j=0;j<timestamp.length;j++){
							StringTokenizer rowTokens =  new StringTokenizer(reportBean.getTableName().trim(),",");
							for(int r=0;rowTokens.hasMoreTokens();r++){								
								String tableName = rowTokens.nextToken();								
								String colList = reportBean.getMinSetOfCol();
									if(timestamp[j]!=null){
									strQuery = " select " + colList + ", " + r + " as tmpfield from " + tableName+timestamp[j] + " where \"5mintime\" >='" + startDate + "' and \"5mintime\" < '" +  endDate + "' ";
									if("".equals(unionQuery))
										unionQuery = strQuery ;
									else
										unionQuery = unionQuery + " UNION ALL "  + strQuery ;
									}
								}
							}		
								paramValues[i]= " ( " + unionQuery + " ) as tmp ";
							
						}
						else{
							paramValues[i]=reportBean.getTableName().trim()+timestamp[0] ;
						}
						
					}
					else
					{
						paramValues[i]=timestamp[0];	
						if(reportBean.getQuery().startsWith("select * from get") && timestamp[1]!=null){
							if(reportBean.getQuery().startsWith("select * from getdash")) {
								paramValues[i]="both";
								flag=0; 
							}else {
							flag=1;
							tblindex=i;
						}
					}
					}				
					
				}else if("orderby".equalsIgnoreCase(paramName)){
					if(orderBy == null)
						paramValues[i] = reportBean.getDefaultColumnForSort();
					else
						paramValues[i]=orderBy;				
				}else if("enddate".equalsIgnoreCase(paramName)){
						paramValues[i] = endDate;					
				}else if("startdate".equalsIgnoreCase(paramName)){
					paramValues[i]=startDate;									
				}else if("ordertype".equalsIgnoreCase(paramName)){
					if(orderType == null)	
						paramValues[i] = "desc";
					else
						paramValues[i]=orderType;
										
				}else if("limit".equalsIgnoreCase(paramName)){
					if(limit == null){
						paramValues[i]=Integer.toString(TabularReportConstants.DEFAULT_LIMIT);
					}else {
						paramValues[i]=limit;
					}
				}else if("offset".equalsIgnoreCase(paramName)){
					if(offset == null) {
						paramValues[i]=Integer.toString(TabularReportConstants.DEFAULT_OFFSET);
					}else {
						paramValues[i]=offset;
					}
				}else if("appid".equalsIgnoreCase(paramName)){
					if(applianceID == null) {
						Iterator deviceBeanItr=DeviceBean.getDeviceBeanIterator();
						String applianceStr="";
						while(deviceBeanItr !=null && deviceBeanItr.hasNext()){
							applianceStr +=  "'"+((DeviceBean)deviceBeanItr.next()).getApplianceID()+"'";
							if(deviceBeanItr.hasNext())
								applianceStr += ",";
						}
						paramValues[i]=applianceStr;
					}else {
						paramValues[i]=applianceID;
					}
				}
				else{
					if(paramMap!=null){
						paramValues[i]=paramMap.get(paramName);
						
					}
				}
			}
			MessageFormat queryFormat=null;			
			if(reportBean.getReportId()==1002 && timestamp[1]!=null){
				queryFormat = new MessageFormat(reportBean.getMinSetOfCol());
			    strquery = queryFormat.format(paramValues);
				
			}else{
			 queryFormat = new MessageFormat(reportBean.getQuery());
			 strquery = queryFormat.format(paramValues);
			}
			String tempquery=null;
			if(flag == 1 && tblindex!=-1 && timestamp[1]!=null){
				paramValues[tblindex]=timestamp[1];
				tempquery=queryFormat.format(paramValues);
				if(strquery.startsWith("select * from get")){
					String colList = reportBean.getMinSetOfCol();
					if(colList != null){
					strquery="select "+colList.split(":")[0]+"  from("+strquery +" union all "+tempquery+")as tmp group by  "+colList.split(":")[1];
					}					
				}else{				
				strquery=strquery+"  union all "+tempquery;
				}				
			}
		}catch(Exception e){
			CyberoamLogger.repLog.debug("PrepareQuery.e:" +e ,e);
		}
		
		return strquery;
	}
	public static int calculateDifference(Date a, Date b)
	{
	    int tempDifference = 0;
	    int difference = 0;
	    Calendar earlier = Calendar.getInstance();
	    Calendar later = Calendar.getInstance();
	    if (a.compareTo(b) < 0){
	        earlier.setTime(a);
	        later.setTime(b);
	    }
	    else{
	        earlier.setTime(b);
	        later.setTime(a);
	    }
	    while (earlier.get(Calendar.YEAR) != later.get(Calendar.YEAR)){
	        tempDifference = 365 * (later.get(Calendar.YEAR) - earlier.get(Calendar.YEAR));
	        difference += tempDifference;
	        earlier.add(Calendar.DAY_OF_YEAR, tempDifference);
	    }
	    if (earlier.get(Calendar.DAY_OF_YEAR) != later.get(Calendar.DAY_OF_YEAR)){
	        tempDifference = later.get(Calendar.DAY_OF_YEAR) - earlier.get(Calendar.DAY_OF_YEAR);
	        difference += tempDifference;
	        earlier.add(Calendar.DAY_OF_YEAR, tempDifference);
	    }
	    return difference;
	}
}
