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

package org.cyberoam.iview.servlets;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.charts.Chart;
import org.cyberoam.iview.helper.BackupDataHandler;
import org.cyberoam.iview.helper.RestoreDataHandler;
import org.cyberoam.iview.helper.LoadDataHandler;
import org.cyberoam.iview.helper.TabularReportGenerator;
import org.cyberoam.iview.search.IndexManager;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.utility.IPTranslation;
import org.cyberoam.iview.utility.PrepareQuery;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This servlet is used to handle AJAX requests of iView web application.
 * @author Amit Maniar
 *
 */
public class AjaxController extends HttpServlet {
	
	/**
	 * This method is used to handle HTTP GET requests. 
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		doPost(request, response);
	}
	
	/**
	 * This method is used to handle HTTP POST requests.
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml;charset=UTF-8");
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Pragma","no-cache");
		response.setHeader("Cache-Control","no-store");
		PrintWriter out=response.getWriter();		
		IndexManager indexManager=null;			
		try {
			String value = null;
			
			CyberoamLogger.appLog.error("%%%%%%Ajax Controller Request%%%%%");
			if(request.getParameter("tabledata") != null || request.getParameter("graphdata") != null){
				ResultSetWrapper rsw = null;
				SqlReader sqlReader = new SqlReader(false);
				try {
					if(CheckSession.checkSession(request,response)<0){
						return;
					}
					ReportBean reportBean = null;
					if(request.getParameter("reportid")!=null && !"".equals(request.getParameter("reportid").trim())) {
						reportBean = ReportBean.getRecordbyPrimarykey(request.getParameter("reportid"));	    
					} else {
						return;
					}
					
					PrepareQuery prepareQuery = new PrepareQuery();			
					String reportQuery = prepareQuery.getQuery(reportBean, request);
					String searchQuery=request.getParameter("searchquery");
					if( searchQuery != null && !"".equalsIgnoreCase(searchQuery)){
						if(reportQuery.indexOf("select")==-1 && reportQuery.indexOf("SELECT")==-1){
							searchQuery=searchQuery.replaceAll("lower","");
							searchQuery=searchQuery.replaceAll("[(]","");
							searchQuery=searchQuery.replaceAll("[)]","");
							searchQuery=searchQuery.replaceAll("'","");
							searchQuery=searchQuery.replaceAll(" and ","#@!AND#@!");
							reportQuery = reportQuery + "#@!AND#@!"+searchQuery;
							
						}else{
							reportQuery = reportQuery.replaceAll("where", "where "+ searchQuery +" and");
						}
					}
					
					try {		
						if(reportQuery.indexOf("select")==-1 && reportQuery.indexOf("SELECT")==-1){ 
							indexManager=new IndexManager();														
							rsw=indexManager.getSearch(reportQuery);																					
						}else{
							rsw = sqlReader.getInstanceResultSetWrapper(reportQuery);
						}	
					} catch (org.postgresql.util.PSQLException e) {
						if(reportQuery.indexOf("5min_ts_20") > -1) {
							reportQuery = reportQuery.substring(0,reportQuery.indexOf("5min_ts_20")) + "4hr" +reportQuery.substring(reportQuery.indexOf("5min_ts_20") + 16,reportQuery.length());
							rsw = sqlReader.getInstanceResultSetWrapper(reportQuery);
						} else {
							CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
						}
					} catch (Exception e) {
						CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
						rsw.close();
					}
					
					String offset = request.getParameter("offset");
					if(offset==null || "".equalsIgnoreCase(offset)||"null".equalsIgnoreCase(offset)){
						offset = "0";
					}
					if(request.getParameter("issort") != null && "true".equalsIgnoreCase(request.getParameter("issort"))&& (reportQuery.indexOf("select")>-1 || reportQuery.indexOf("SELECT")>-1)){
						out.write("<root totalRecord=\""+reportBean.getNumberOfRecords(request.getParameter("searchquery"),prepareQuery.getTotalQuery())+"\">");
					}else if(reportQuery.indexOf("select")==-1 && reportQuery.indexOf("SELECT")==-1){ 
						out.write("<root totalRecord=\""+indexManager.getTotalHits()+"\">");
					}else {
						out.write("<root>");
					}
					if(request.getParameter("tabledata") != null){	
						out.write(TabularReportGenerator.getAjaxBody(request,rsw));					
					}
					if(request.getParameter("graphdata") != null && (reportQuery.indexOf("select")>-1 || reportQuery.indexOf("SELECT")>-1)){					
						int imgwd = request.getParameter("imgwidth") == null ? 400:Integer.parseInt(request.getParameter("imgwidth"));						
						int imght = request.getParameter("imgheight") == null ? 250:Integer.parseInt(request.getParameter("imgheight"));	
						
						out.write("<data><row><cel> ");	
						String filename = Chart.getChartForWeb(request,new PrintWriter(out),rsw,imgwd,imght);		
						String graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
						out.write(" </cel>");						
						out.write("<cel>"+filename+"</cel>");
						out.write("<cel>"+graphURL+"</cel>");		
						out.write("<cel>" + imgwd + "</cel>");
						out.write("<cel>" + imght + "</cel>");	
						out.write("</row></data>");
					}
					out.write("</root>");
				}catch(Exception e){
					CyberoamLogger.appLog.error(" Exeption in graphdata request while Try to Extract Rowlog files "+e,e );
				} finally{
					try{
						rsw.close();
						sqlReader.close();		
					}catch (Exception e) {}
				}
			}
			if(request.getParameter("resolvedns") != null){
				value = request.getParameter("ip");
				out.write("<root><ip>"+value+"</ip><dname>"+IPTranslation.getHostName(value)+"</dname></root>");
			}
			if(request.getParameter("pinstatus") != null){
				value = request.getParameter("pinstatus");
				request.getSession().setAttribute("pinstatus",value);
				out.flush();
				out.close();
			}
			if(request.getParameter("giveloadtime") != null){
				out.println(LoadDataHandler.getProcessPercentComplete());
				out.flush();
				out.close();
			}
			if(request.getParameter("givebackuptime") != null){
				if(BackupDataHandler.isStoppedThread()){
					CyberoamLogger.appLog.info("Ajax Controller->Backup->Stopped");
					request.getSession().setAttribute("statusCheck","1");
					out.print(1);
				} else {
					CyberoamLogger.appLog.info("Ajax Controller->Backup->Running");
					out.print(0);					
				}
				out.flush();
				out.close();
			}
			if(request.getParameter("giverestoretime") != null){
				if(RestoreDataHandler.isStopped()){
					CyberoamLogger.appLog.info("Ajax Controller->Restore->Stopped");
					request.getSession().setAttribute("statusCheck","3");
					out.print(1);
				} else {
					CyberoamLogger.appLog.info("Ajax Controller->Restore->Running");
					out.print(0);					
				}
				out.flush();
				out.close();
			}			
			
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("AJAXCotroller.doPost.e" +e,e);
		}
		out.flush();
		out.close();
	}
}
