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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.IndexFieldsBean;
import org.cyberoam.iview.beans.ProtocolBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iview.beans.ReportGroupBean;
import org.cyberoam.iview.beans.ReportGroupRelationBean;
import org.cyberoam.iview.beans.SearchIndexBean;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.search.IndexManager;
import org.cyberoam.iview.utility.ByteInUnit;
import org.cyberoam.iview.utility.DateDifference;
import org.cyberoam.iview.utility.PrepareQuery;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;

/**
 * This class is used for generating excel file. 
 * @author Avani Thakker
 *
 */

public class ExcelFileGenerator extends HttpServlet {

	private static final long serialVersionUID = 1L;

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
		String startDate=null,endDate=null,limit="1000",offset=null,applianceList=null,mode=null;
		int reportGroupID=-1;
		int reportID=-1;		
		
		SqlReader sqlReader = new SqlReader();		
		ResultSetWrapper rsw=null;
		String query=null;
		IndexManager indexManager=null;
		HttpSession session=request.getSession();
		ServletOutputStream out = response.getOutputStream();
		response.setContentType("application/octet-stream");
		
		try {
			// Archive Logs Exportation
			if(request.getParameter("archive")!= null){
				try{
					HashMap<String,String> criteriaList = new HashMap<String,String>();
					String categoryID = (String)session.getAttribute("categoryid");
					query = " where";
					Date startDateDt = DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd hh:mm:ss");
					Date endDateDt = DateDifference.stringToDate((String)session.getAttribute("enddate"),"yyyy-MM-dd hh:mm:ss");
					if(PrepareQuery.calculateDifference(startDateDt,endDateDt) > 0){
						query += " upload_datetime >= '"+(String)(String)session.getAttribute("startdate") +"' and upload_datetime <= ' " +  (new SimpleDateFormat("yyyy-MM-dd")).format(DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd")) + " 23:59:59'";
						criteriaList.put("upload_datetimeStart",">=,"+(String)session.getAttribute("startdate"));
						criteriaList.put("upload_datetimeEnd","<=,"+(new SimpleDateFormat("yyyy-MM-dd")).format(DateDifference.stringToDate((String)session.getAttribute("startdate"),"yyyy-MM-dd")) + " 23:59:59");
					} else {
						query += " upload_datetime >= '"+(String)(String)session.getAttribute("startdate") +"' and upload_datetime <= ' " + (String)session.getAttribute("enddate") + "'";
						criteriaList.put("upload_datetimeStart",">=,"+(String)session.getAttribute("startdate")); 
						criteriaList.put("upload_datetimeEnd","<=,"+(String)session.getAttribute("enddate"));
					}
					query += " and device_name in (" + (String)session.getAttribute("appliancelist") +") ";
					criteriaList.put("device_name","=,"+(String)session.getAttribute("appliancelist"));
					criteriaList.put("indexCriteria",request.getParameter("indexCriteria"));
					
					CyberoamLogger.appLog.info("ExcelGeneration : indexCriteria = "+request.getParameter("indexCriteria"));
					
					String intLotSize = iViewConfigBean.getValueByKey("Limit");
				
					long longCurrentRecordPosition=Long.parseLong(request.getParameter("offset"));
					String tblName=request.getParameter("tblname");
									
					HSSFWorkbook wb = new HSSFWorkbook();
					HSSFSheet formattedLogs = wb.createSheet("Formatted Logs");
					HSSFSheet rawLogs = wb.createSheet("Raw Logs");
					HSSFRow row;
					HSSFCell cell;
					
					//Formatted logs Column Headings
					row = formattedLogs.createRow(0);
					ArrayList<IndexFieldsBean> indexFileList = IndexFieldsBean.getIndexFieldBeanListByCategoryID(categoryID);					
					for(int n=0 ; n < indexFileList.size()-2 ; n++){				  						  		
						  row.createCell(n).setCellValue(((IndexFieldsBean)indexFileList.get(n)).getGuiIndexName());
					}
					// Raw Logs Column Heading.
					row = rawLogs.createRow(0);
					row.createCell(0).setCellValue("Raw Logs");
					
					// For freezing first row in both sheets
					formattedLogs.createFreezePane( 0, 1, 0, 1 );
					rawLogs.createFreezePane(0,1 ,0,1);
					
					criteriaList.put("limit","=,"+Integer.parseInt(intLotSize));
					criteriaList.put("offset","=,"+longCurrentRecordPosition);
					criteriaList.put("categoryID","=,"+categoryID);
					ArrayList recordArray = null;
					if(request.getParameter("indexCriteria") == null || request.getParameter("indexCriteria").equals("null"))
						recordArray = SearchIndexBean.getDateRangeData(criteriaList);
					else
						recordArray = SearchIndexBean.getSearchData(criteriaList);
					if(recordArray.size() == Integer.parseInt(intLotSize) + 1){
						recordArray.remove(recordArray.size() - 1);
					}
					//Formatted Logs data					
					ArrayList columnArray=null;
					String dataValue;
									
					if(recordArray != null){
						for(int recordcount=0;recordcount<recordArray.size();recordcount++){
							columnArray = (ArrayList)recordArray.get(recordcount);
							row = formattedLogs.createRow(recordcount+1);
							for(int columncount=0;columncount<columnArray.size()-1;columncount++){			
								dataValue = (String)columnArray.get(columncount);
								formattedLogs.autoSizeColumn((short)columncount);
								cell = row.createCell(columncount);
								if(dataValue != null && dataValue.length() > 0){	
									// 1 is for numeric data type 
									if( Integer.parseInt((indexFileList.get(columncount)).getDataType()) ==1){
										cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
										cell.setCellValue(Integer.parseInt(dataValue));
									}
									else
										cell.setCellValue(dataValue);
								}
								else{
									cell.setCellValue("-");
								}									
							}
						}
					}
					// Raw Logs
					if(recordArray != null){
						for(int recordcount=0;recordcount<recordArray.size();recordcount++){													
							row = rawLogs.createRow(recordcount+1);
							columnArray = (ArrayList)recordArray.get(recordcount);
							dataValue = (String)columnArray.get(columnArray.size()-1);
							if(dataValue != null && dataValue.length() > 0){
								row.createCell(0).setCellValue(dataValue);
							}else{
								row.createCell(0).setCellValue("-");
							}
						}
					}
					
					wb.write(out);
					out.close();
				}
				catch(Exception e){
					CyberoamLogger.appLog.error("Error in exporting archive data to excel");
				}
			}
			//Report data Export				
			else{				
				if(request.getParameter("xlsdata")!=null)
					mode=(String)request.getParameter("xlsdata");
				if(mode.equalsIgnoreCase("group")) {
					limit="5";				
				}else{
					reportID=Integer.parseInt(request.getParameter("reportid"));
				}
			
				PrepareQuery prepareQuery = new PrepareQuery();
				
				if(request.getParameter("reportgroupid")!=null)
					reportGroupID=Integer.parseInt(request.getParameter("reportgroupid"));
				
				// For report group
				if(reportID==-1){
					try
					{
						CyberoamLogger.appLog.info("Report Group id : "+reportGroupID);
						ReportGroupBean reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
						ReportGroupRelationBean	reportGroupRelationBean;				
						ArrayList reportList=reportGroupBean.getReportIdByReportGroupId(reportGroupID); 			
												
						//For getting workbook of Excel
						HSSFWorkbook wb = new HSSFWorkbook();
					
						int noReports = reportList.size();
						for(int ctr=0;ctr<noReports;ctr++)
						{
							reportGroupRelationBean=(ReportGroupRelationBean)reportList.get(ctr);
							reportID = reportGroupRelationBean.getReportId(); 
							CyberoamLogger.appLog.info("ReportGroup : Report id : "+reportID);							
							ReportBean reportBean = ReportBean.getRecordbyPrimarykey(reportID);							
							
							query = prepareQuery.getQuery(reportBean, request);
							// Getting result set
							try {	
								if(query.indexOf("select")==-1 && query.indexOf("SELECT")==-1){  
									indexManager=new IndexManager();														
									rsw=indexManager.getSearch(query);														
									//rsw=indexManager.getResutSetFromArrayList(searchRecord);
								}else{
									rsw=sqlReader.getInstanceResultSetWrapper(query);
								}													
							}
							catch (org.postgresql.util.PSQLException e) {
								if(query.indexOf("5min_ts_20") > -1) {
									query = query.substring(0,query.indexOf("5min_ts_20")) + "4hr" +query.substring(query.indexOf("5min_ts_20") + 16,query.length());
									rsw = sqlReader.getInstanceResultSetWrapper(query);
								} else {
									CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
								}
							}
							catch (Exception e) {
								CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
								rsw.close();
							}
							// Getting workbook with sheets & all data & chart
							getWorkBook(rsw, reportBean, wb);
						}
						wb.write(out);
						out.close();
					}catch(Exception e){
						CyberoamLogger.appLog.error("***Exeption in report group Excel file generation***"+e );	
					}finally{
						sqlReader.close();
						rsw.close();
					}
				}else{// For single report
					try{									
						ReportBean reportBean=ReportBean.getRecordbyPrimarykey(reportID);
						
						//Getting query for report
						
						query = prepareQuery.getQuery(reportBean, request);
						String searchQuery = request.getParameter("searchquery");
						if( searchQuery != null && !"".equalsIgnoreCase(searchQuery)){
							query = query.replaceAll("where", "where "+ searchQuery +" and");
						}
						try {				
							if(query.indexOf("select")==-1 && query.indexOf("SELECT")==-1){ 
								indexManager=new IndexManager();														
								rsw=indexManager.getSearch(query);														
								//rsw=indexManager.getResutSetFromArrayList(searchRecord);
							}else{
								rsw=sqlReader.getInstanceResultSetWrapper(query);
							}	
						}
						catch (org.postgresql.util.PSQLException e) {
							if(query.indexOf("5min_ts_20") > -1) {
								query = query.substring(0,query.indexOf("5min_ts_20")) + "4hr" +query.substring(query.indexOf("5min_ts_20") + 16,query.length());						
								rsw = sqlReader.getInstanceResultSetWrapper(query);
							} else {
								CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
							}
						}
						catch (Exception e) {
							CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
							rsw.close();
						}
						
						HSSFWorkbook wb = new HSSFWorkbook();
						
						getWorkBook(rsw,reportBean,wb);	    
					    
						wb.write(out);
						out.close();    
					}catch(Exception e){
						CyberoamLogger.appLog.info("***Exception during Excel Single report generation***" + e.getMessage());
					}finally{
						sqlReader.close();
						rsw.close();
					}
				}	
			}
		}catch(Exception ex){
			CyberoamLogger.appLog.info("***Excel Report Generartion Exception***" + ex,ex);	
		}	
	}
	void getWorkBook(ResultSetWrapper rsw,ReportBean reportBean,HSSFWorkbook wb)	{
		try{
			ReportColumnBean[] reportColumns= (ReportColumnBean[])ReportColumnBean.getReportColumnsByReportID(reportBean.getReportId()).toArray(new ReportColumnBean[0]);
			HSSFSheet newSheet = wb.createSheet(reportBean.getTitle()); 
			HSSFRow row;
			HSSFCell cell;

            HSSFCellStyle cellStyle = wb.createCellStyle();                        
            HSSFFont fontStyle = wb.createFont();
            
            fontStyle.setFontHeightInPoints((short) 10);
            fontStyle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            
            cellStyle.setFont(fontStyle);
            
            // getting number of records & fields for report
			rsw.last();
			int rowCount=rsw.getRow();
			int colCount = reportColumns.length;
			
			//For Freezing the first row
			newSheet.createFreezePane( 0, 1, 0, 1 );
			
			// Adding column headings to Excel
			row = newSheet.createRow((short)0);
			for(int cCount=0;cCount<colCount;cCount++){							
				cell = row.createCell(cCount);
				cell.setCellStyle(cellStyle);
				cell.setCellValue(reportColumns[cCount].getColumnName());			
			}
			//Adding data for each record to Excel
			rsw.first();			
			for(int rcount=1;rcount<=rowCount;rcount++){
				row = newSheet.createRow(rcount);
				for(int cCount=0;cCount<colCount;cCount++){
					String data = rsw.getString(reportColumns[cCount].getDbColumnName());
					cell = row.createCell(cCount);
					newSheet.autoSizeColumn((short)cCount); 
					if(reportColumns[cCount].getColumnFormat() == TabularReportConstants.BYTE_FORMATTING){
						data=ByteInUnit.getBytesInUnit(rsw.getLong(reportColumns[cCount].getDbColumnName()));
					}
					else if(reportColumns[cCount].getColumnFormat() == TabularReportConstants.PROTOCOL_FORMATTING && data.indexOf(':') != -1) {
						String xdata=ProtocolBean.getProtocolNameById(Integer.parseInt(rsw.getString(reportColumns[cCount].getDbColumnName()).substring(0, data.indexOf(':'))));
						data=xdata+rsw.getString(reportColumns[cCount].getDbColumnName()).substring(data.indexOf(':'),data.length());
					}					
					// Setting value to the cell
					if(cCount==0 && (data == null || "".equalsIgnoreCase(data))) data="N/A";					
					if(reportColumns[cCount].getColumnFormat() == TabularReportConstants.PERCENTAGE_FORMATTING){					
						try{
							cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
							cell.setCellValue(Double.parseDouble(data));
						}
						catch(NumberFormatException e){
							cell.setCellValue(data);
						}
					}	
					else if(rsw.getMetaData().getColumnTypeName(cCount+1).equalsIgnoreCase("numeric") && reportColumns[cCount].getColumnFormat() != TabularReportConstants.BYTE_FORMATTING){
						try{
							cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
							cell.setCellValue(Integer.parseInt(data));
						}
						catch(NumberFormatException e){
							cell.setCellValue(data);
						}
					}				
					else{
						cell.setCellValue(data);
					}
				}
				rsw.next();
			}			
			
		}catch(Exception e){
			CyberoamLogger.appLog.error("***Error in getWorkbook function***"+ e,e);
		}
	}
}
