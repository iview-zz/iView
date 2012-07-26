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

package org.cyberoam.iview.charts;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.beans.GraphBean;
import org.cyberoam.iview.beans.ProtocolBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iview.beans.ReportGroupBean;
import org.cyberoam.iview.beans.ReportGroupRelationBean;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.search.IndexManager;
import org.cyberoam.iview.servlets.InitServlet;
import org.cyberoam.iview.utility.ByteInUnit;
import org.cyberoam.iview.utility.PrepareQuery;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.servlet.ServletUtilities;



import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.ExceptionConverter;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfTemplate;
import com.lowagie.text.pdf.PdfWriter;

/**
 * This class represents Chart entity.
 * @author Narendra Shah
 *
 */
public class Chart extends PdfPageEventHelper {
	
	//private static BufferedImage watermark = null;
	
	/**
	 * @param reportID specifies that for which report Chart is being prepared.
	 * @param rsw specifies data set which would be used for the Chart
	 * @param requeest used for Hyperlink generation from uri.
	 * @return jfreechart instance with iView Customization.
	 */
	public static JFreeChart getChart(int reportID,ResultSetWrapper rsw,HttpServletRequest request) throws Exception {
		JFreeChart chart=null;
		int chartType=GraphBean.getRecordbyPrimarykey(reportID).getChartType();
		switch (chartType) {
			case ChartConstants.Bar3D:
				chart = Bar3D.getChart(reportID, rsw, request) ;
				break;
			case ChartConstants.Pie3D:
				chart = Pie3D.getChart(reportID, rsw, request);
				break;	
			case ChartConstants.StackedColumn3D:
				chart = StackedColumn3D.getChart(reportID, rsw, request);
				break;
			case ChartConstants.XYLine:
				chart = Line.getChart(reportID, rsw, request);
				break;
			case ChartConstants.ThermoMeter:
				chart = Thermometer.getChart(reportID, rsw, request);
				break;
			case ChartConstants.Meter:
				chart = MeterChart.getChart(reportID, rsw, request);
				break;
			case ChartConstants.DiskUsage:
				chart = DiskUsage.getChart(reportID, rsw, request);
				break;
			default:
				CyberoamLogger.appLog.debug("Default Chart is selected in ChartUtilities.selectChart.");
				//chart = new Column3D();
				break;
		}
		/*chart.getPlot().setBackgroundAlpha(0.0f);
		chart.setBackgroundImageAlpha(1);
		if (Chart.watermark == null){
			watermark = ImageIO.read(new File(request.getRealPath("images/watermark.jpg")));
		}
		chart.setBackgroundImage(watermark);
		chart.setBackgroundImageAlignment(Align.TOP_LEFT);*/
		return chart;
	}
	
	/**
	 * Get chart for web application rendering. 
	 * @param Request instance used for chart generation process
	 * @param out instance used for tool tip image map
	 * @param rsw specifies data set which would be used for the Chart
	 * @param requeest used for Hyperlink generation from uri.
	 * @param imagehieght used for image height
	 * @param imagewidht used for image width
	 * @return fileName
	 */
	public static String getChartForWeb(HttpServletRequest request,PrintWriter out,ResultSetWrapper rsw,int imageWidth,int imageHeight){
		String fileName=null;
		try {
			int reportID=request.getParameter("reportid") == null ? -1:Integer.parseInt(request.getParameter("reportid"));
			JFreeChart chart=Chart.getChart(reportID, rsw, request);
			
			ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
			//Save the generated Chart image to system temporary directory.
			fileName = ServletUtilities.saveChartAsPNG(chart, imageWidth, imageHeight, info, request.getSession());
			//  Write the tool tip map to GUI.
			org.jfree.chart.ChartUtilities.writeImageMap(out, fileName, info,false);
			out.flush();
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("Chart.getChartForWeb:" + e, e);
		}
		return fileName;
	}
	
	/**
	 * Function to write a given ChartID to pdf file
	 * @param pdfFileName specifies the pdf where chart is written.Please specify full path with the filename.
	 * @param reportGroup id specifies the chart to be generated
	 * @param startdate specifies start date 
	 * @param enddate specifies end date
	 * @param limit specifies number of records per record to be written in report
	 */
	public static void generatePDFReportGroup(OutputStream  out,int reportGroupID,String applianceID,String startDate,String endDate,String limit, int [] deviceIDs,HttpServletRequest request,LinkedHashMap paramMap)throws Exception{
		float width=768;
		float height=1024;
		float rec_hieght=470;
		Rectangle pagesize = new Rectangle(768, 1024);
		Document document = new Document(pagesize, 30, 30, 30, 30);
		
		JFreeChart chart=null;
		SqlReader sqlReader = new SqlReader(false);
		//CyberoamLogger.sysLog.debug("pdf:"+pdfFileName);
		CyberoamLogger.sysLog.debug("reportGroupID:"+reportGroupID);
		CyberoamLogger.sysLog.debug("applianceID:"+applianceID);
		CyberoamLogger.sysLog.debug("startDate:"+startDate);
		CyberoamLogger.sysLog.debug("endDate:"+endDate);
		CyberoamLogger.sysLog.debug("limit:"+limit);
		try{
			//PdfWriter writer = PdfWriter.getInstance(document, response!=null ? response.getOutputStream():new FileOutputStream(pdfFileName));
			PdfWriter writer = PdfWriter.getInstance(document,out);
			writer.setPageEvent(new Chart());
			document.addAuthor("iView");
			document.addSubject("iView Report");
			document.open();
			PdfContentByte  contentByte= writer.getDirectContent();
			ReportGroupBean reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
			ArrayList reportList=reportGroupBean.getReportIdByReportGroupId(reportGroupID); 			
			ReportBean reportBean;
			ResultSetWrapper rsw = null;
									
			String seperator=System.getProperty("file.separator");
			
			//String path=System.getProperty("catalina.home") +seperator+"webapps" +seperator+"ROOT" + seperator + "images" + seperator + "iViewPDF.jpg";
			String path = InitServlet.contextPath + seperator + "images" + seperator + "iViewPDF.jpg";
						
			Image iViewImage = Image.getInstance(path);
			iViewImage.scaleAbsolute(750,900);
			//iViewImage.scaleAbsolute(600,820);
			iViewImage.setAbsolutePosition(10,10);
			document.add(iViewImage);
			
            document.add(new Paragraph("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"));

            /*
             *	Generating Table on the First Page of Report providing summary of Content 
             */         
            PdfPTable frontPageTable=new PdfPTable(2);
			PdfPCell dataCell;
			ReportGroupRelationBean	reportGroupRelationBean;
			String reportName="";
		
			Color tableHeadBackColor=new Color(150,174,190);
			Color tableContentBackColor=new Color(229,232,237);
			Color tableBorderColor=new Color(229,232,237);
			
			dataCell=new PdfPCell(new Phrase(new Chunk("Report Profile", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Font.PLAIN, new Color(255,255,255)))));
			dataCell.setBackgroundColor(tableHeadBackColor);
			dataCell.setBorderColor(tableBorderColor);
			frontPageTable.addCell(dataCell);
			
			/**
			 * Getting dynamic title.
			 */
			String title="";
			if(paramMap!=null){
				title=paramMap.get("title").toString();
				
				paramMap.remove("title");
			}
			if(request!=null)
				title=getFormattedTitle(request, reportGroupBean,true);
		
			dataCell=new PdfPCell(new Phrase(new Chunk(title, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Font.PLAIN, new Color(255,255,255)))));
			dataCell.setBackgroundColor(tableHeadBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(new Chunk("Start Date", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(startDate));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(new Chunk("End Date", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(endDate));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			
			dataCell=new PdfPCell(new Phrase(new Chunk("iView Server Time", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			java.util.Date currentDate=new java.util.Date();
			dataCell=new PdfPCell(new Phrase(currentDate.toString()));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			
			dataCell=new PdfPCell(new Phrase(new Chunk("Reports", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			int len=reportList.size();
			for(int k=0;k<len;k++) {
				reportGroupRelationBean=(ReportGroupRelationBean)reportList.get(k);
				reportName +=  " " +(k+1)+ ". " + ReportBean.getRecordbyPrimarykey(reportGroupRelationBean.getReportId()).getTitle() +"\n";
			}
			dataCell=new PdfPCell(new Phrase("\n" + reportName + "\n"));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);	
			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(new Chunk("Device Names (IP Address)", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			DeviceBean deviceBean=null;
			String deviceNameWithIP="";
			if(deviceIDs!=null){
				for(int i=0;i<deviceIDs.length;i++){
					deviceBean=DeviceBean.getRecordbyPrimarykey(deviceIDs[i]);
					if(deviceBean != null){
						deviceNameWithIP += " " + (i+1) + ". " + deviceBean.getName() + " (" + deviceBean.getIp() +")\n";
					}
				}					
			}
			dataCell=new PdfPCell(new Phrase("\n" + deviceNameWithIP + "\n"));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);		
			frontPageTable.addCell(dataCell);
			
			
			/*
			 * Adding Table to PDF		
			 */
			document.add(frontPageTable);
			
			/*
			 * Adding Charts and Table to PDF 
			 */
			for(int i=0;i<reportList.size();i++){			
				document.newPage();
				reportBean=ReportBean.getRecordbyPrimarykey(((ReportGroupRelationBean)reportList.get(i)).getReportId());
				String query=null;
				if(request == null){
					query=PrepareQuery.getQuery(reportBean, startDate, endDate,applianceID,null,null,"0",limit,paramMap);
				}else {
					PrepareQuery prepareQuery=new PrepareQuery();
					query=prepareQuery.getQuery(reportBean, request);
				}
		  	    CyberoamLogger.sysLog.debug("PDF:ReportID:" + reportBean.getReportId()+ "Query->"+query);
		  	    		  	    
				try {					
					rsw=sqlReader.getInstanceResultSetWrapper(query);
				} catch (org.postgresql.util.PSQLException e) {
					if(query.indexOf("5min_ts_20") > -1) {
						query = query.substring(0,query.indexOf("5min_ts_20")) + "4hr" +query.substring(query.indexOf("5min_ts_20") + 16,query.length());
						CyberoamLogger.appLog.debug("New query : "+ query);						
						rsw = sqlReader.getInstanceResultSetWrapper(query);
						
					} else {
						CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
					}
				} catch (Exception e) {
					CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
					rsw.close();
				}
		  	    
				/*
				 * PDF Rendering work starts here
				 */

				for(int j=0;j<(int)(rec_hieght/16)+1;j++) {
					document.add(new Paragraph("\n"));
				}
				// This fix is to resolve the problems associated with reports which don't have graphs.
				// If there is no graph associated with the report than no need to generate 
				//a chart for it.
				GraphBean graphBean=GraphBean.getRecordbyPrimarykey(reportBean.getReportId());
				//if(graphBean!=null)
				if(reportBean.getReportFormatId()!=2)
				{
					chart=Chart.getChart(reportBean.getReportId(),rsw, null);
					PdfTemplate pdfTemplate = contentByte.createTemplate(width, height);					
					Graphics2D graphics2D = pdfTemplate.createGraphics(width, height);
					Rectangle2D rectangle = new Rectangle2D.Double(100,85,540,rec_hieght);	
					chart.draw(graphics2D, rectangle);
					graphics2D.dispose();			
					contentByte.addTemplate(pdfTemplate, 0, 0);
				}else{							
					Paragraph p=new Paragraph(reportBean.getTitle()+"\n\n", FontFactory.getFont(FontFactory.HELVETICA,18, Font.BOLD));
					p.setAlignment("center");
					document.add(p);					
				}
				
				// Retrieving PdfPTable
				PdfPTable pdfTable=getPdfPTable(reportBean, rsw);
				rsw.close();				
				
				
				/*
				 * Adding Table to PDF
				 */
				
				document.add(pdfTable);	
			}
			CyberoamLogger.appLog.info("*************Finishing Chart****************");
		}catch (Exception e) {
			CyberoamLogger.sysLog.debug("Chart.writeChartToPDF.e"  + e.getMessage(),e);
		}finally{
			sqlReader.close();
		}
		
		document.close();
	}
	
	/**
	 * Function for getting report PdfPtable instance for given report and record set
	 * @param report bean specifies the report for which table is generated 
	 * @param rsw specifies Result set collection
	 * @return instance of PdfPtable
	 */
	public static PdfPTable getPdfPTable(ReportBean reportBean,ResultSetWrapper rsw){
		PdfPTable pdfTable=null;
		try {
			rsw.last();
			//int rowCount=rsw.getRow();
			ReportColumnBean[] reportColumns= (ReportColumnBean[])ReportColumnBean.getReportColumnsByReportID(reportBean.getReportId()).toArray(new ReportColumnBean[0]);
			pdfTable=new PdfPTable(reportColumns.length);
			// Adding Column Name to PDF Table
			PdfPCell headCell;
			for(int count=0;count<reportColumns.length;count++) {
				headCell=new PdfPCell(new Phrase(18, new Chunk(reportColumns[count].getColumnName(), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Font.BOLD, Color.blue))));
				headCell.setBackgroundColor(new Color(238,238,238));
				pdfTable.addCell(headCell);		
			}
			String data;
			int i=0;
			rsw.beforeFirst();
			while(rsw.next()){
				for(int j=0;j<reportColumns.length;j++){
					if(reportColumns[j].getColumnFormat() == TabularReportConstants.BYTE_FORMATTING){
						data=ByteInUnit.getBytesInUnit(rsw.getLong(reportColumns[j].getDbColumnName()));				
					}else if(reportColumns[j].getColumnFormat() == TabularReportConstants.PERCENTAGE_FORMATTING){
						data=rsw.getString(reportColumns[j].getDbColumnName()) + " %";
					}else if(reportColumns[j].getColumnFormat() == TabularReportConstants.DECODE_FORMATTING){
						data=URLDecoder.decode(rsw.getString(reportColumns[j].getDbColumnName()));
					}else if(reportColumns[j].getColumnFormat() == TabularReportConstants.PROTOCOL_FORMATTING){
						int index=rsw.getString(reportColumns[j].getDbColumnName()).indexOf(':');
						if(index!=-1) {					
							data=ProtocolBean.getProtocolNameById(Integer.parseInt(rsw.getString(reportColumns[j].getDbColumnName()).substring(0, index)));
							data=data+rsw.getString(reportColumns[j].getDbColumnName()).substring(index,rsw.getString(reportColumns[j].getDbColumnName()).length());
						} else {
							data=rsw.getString(reportColumns[j].getDbColumnName());		
						}
					}else if( reportColumns[j].getColumnFormat()== TabularReportConstants.SEVERITY_FORMATTING){
						data=TabularReportConstants.getSeverity(rsw.getString(reportColumns[j].getDbColumnName()));
					}else if(  reportColumns[j].getColumnFormat()== TabularReportConstants.ACTION_FORMATTING) {
						data=TabularReportConstants.getAction(rsw.getString(reportColumns[j].getDbColumnName()));
					}
					else {
						data=rsw.getString(reportColumns[j].getDbColumnName());
					}
					if(data == null || "".equalsIgnoreCase(data)) data="N/A";					
					pdfTable.addCell(data);
				}
				i++;
			}
		}catch (SQLException e) {
			CyberoamLogger.sysLog.debug("Chart.getPDFPTable.e"+e,e);
		}
		
		return pdfTable;
	}
	
	public static void generatePDFReport(OutputStream  out,int reportID,String applianceID,String startDate,String endDate,String limit, int [] deviceIDs,HttpServletRequest request,int reportGroupID,LinkedHashMap paramMap)throws Exception{
		float width=768;
		float height=1024;
		float rec_hieght=470;
		Rectangle pagesize = new Rectangle(768, 1024);
		Document document = new Document(pagesize, 30, 30, 30, 30);
		IndexManager indexManager=null;
		JFreeChart chart=null;
		SqlReader sqlReader = new SqlReader(false);		
		CyberoamLogger.sysLog.debug("reportID:"+reportID);
		CyberoamLogger.sysLog.debug("applianceID:"+applianceID);
		CyberoamLogger.sysLog.debug("startDate:"+startDate);
		CyberoamLogger.sysLog.debug("endDate:"+endDate);
		CyberoamLogger.sysLog.debug("limit:"+limit);
	
		try{
			//PdfWriter writer = PdfWriter.getInstance(document, response!=null ? response.getOutputStream():new FileOutputStream(pdfFileName));			
			PdfWriter writer = PdfWriter.getInstance(document,out);
			writer.setPageEvent(new Chart());
			document.addAuthor("iView");
			document.addSubject("iView Report");
			document.open();
			PdfContentByte  contentByte= writer.getDirectContent();
			//ReportGroupBean reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reportGroupID);
			
			//ArrayList reportList=reportGroupBean.getReportIdByReportGroupId(reportGroupID); 			
			ReportBean reportBean;
			ResultSetWrapper rsw = null;
								
			
			String seperator=System.getProperty("file.separator");
//			String path=System.getProperty("catalina.home") +seperator+"webapps" +seperator+"ROOT" + seperator + "images" + seperator; 
			String path = InitServlet.contextPath + seperator + "images" + seperator + "iViewPDF.jpg";
			/*			 
			 *	Loading Image to add into PDF 
			 */		
						
			Image iViewImage = Image.getInstance(path);								
			iViewImage.scaleAbsolute(750,900);
			//iViewImage.scaleAbsolute(600,820);
			iViewImage.setAbsolutePosition(10,10);
			
			/*Image headerImage= Image.getInstance(path+ "iViewPDFHeader.jpg");
			
			PdfPTable headerTable = new PdfPTable(2);
			PdfPCell cell = new PdfPCell(headerImage);
			headerTable.addCell(cell);			
			HeaderFooter docHeader=null;			
			//document.setHeader(new HeaderFooter(new Phrase(new Chunk())), true);
			*/
			document.add(iViewImage);
			                     
    		document.add(new Paragraph("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"));

            /*
             *	Generating Table on the First Page of Report providing summary of Content 
             */         
            PdfPTable frontPageTable=new PdfPTable(2);
            
			PdfPCell dataCell;			
			String reportName="";
		
			Color tableHeadBackColor=new Color(150,174,190);
			Color tableContentBackColor=new Color(229,232,237);
			Color tableBorderColor=new Color(229,232,237);
			
			dataCell=new PdfPCell(new Phrase(new Chunk("Report Profile", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Font.PLAIN, new Color(255,255,255)))));
			dataCell.setBackgroundColor(tableHeadBackColor);
			dataCell.setBorderColor(tableBorderColor);
			frontPageTable.addCell(dataCell);
			if(paramMap!=null){
				reportName = paramMap.get("title").toString();
				paramMap.remove("title");
			}
			if(request!=null){
				ReportGroupBean reportGroupBean=ReportGroupBean.getRecordbyPrimarykey(reportGroupID);				
				reportName=getFormattedTitle(request, reportGroupBean,true);
			}
			dataCell=new PdfPCell();			
			
			dataCell.addElement(new Phrase(new Chunk(reportName, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(255,255,255)))));
			//dataCell.addElement(new Phrase(new Chunk(ReportBean.getRecordbyPrimarykey(reportID).getTitle(), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.PLAIN, new Color(10,10,10)))));
			if(request!=null){
				dataCell.addElement(new Phrase(new Chunk(reportName + " >> ", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(255,255,255)))));
				dataCell.addElement(new Phrase(new Chunk(ReportBean.getRecordbyPrimarykey(reportID).getTitle(), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(255,255,255)))));
			}	
			dataCell.setBackgroundColor(tableHeadBackColor);			
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(new Chunk("Start Date", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(startDate));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(new Chunk("End Date", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(endDate));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			dataCell=new PdfPCell(new Phrase(new Chunk("iView Server Time", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			java.util.Date currentDate=new java.util.Date();
			dataCell=new PdfPCell(new Phrase(currentDate.toString()));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);

			dataCell=new PdfPCell(new Phrase(new Chunk("Device Names (IP Address)", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.PLAIN, new Color(0,0,0)))));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			DeviceBean deviceBean=null;
			String deviceNameWithIP="";
			if(deviceIDs!=null){
				for(int i=0;i<deviceIDs.length;i++){
					deviceBean=DeviceBean.getRecordbyPrimarykey(deviceIDs[i]);
					if(deviceBean != null){
						deviceNameWithIP += " " + (i+1) + ". " + deviceBean.getName() + " (" + deviceBean.getIp() +")\n";
					}
				}					
			}
			dataCell=new PdfPCell(new Phrase("\n" + deviceNameWithIP + "\n"));
			dataCell.setBackgroundColor(tableContentBackColor);
			dataCell.setBorderColor(tableBorderColor);			
			frontPageTable.addCell(dataCell);
			
			
			
			/*
			 * Adding Table to PDF		
			 */
			document.add(frontPageTable);
			
			/*
			 * Adding Charts and Table to PDF 
			 */
				document.newPage();
				reportBean=ReportBean.getRecordbyPrimarykey(reportID);
				String query=null;
				if(request == null){
					query=PrepareQuery.getQuery(reportBean, startDate, endDate,applianceID,null,null,"0",limit,paramMap);
				}else {
					PrepareQuery prepareQuery=new PrepareQuery();
					query=prepareQuery.getQuery(reportBean, request);					
				}
				String searchQuery ="";
				if(request == null){
					searchQuery =null;					
				}else{
					searchQuery = request.getParameter("searchquery");
				}
				if( searchQuery != null && !"".equalsIgnoreCase(searchQuery)){
					query = query.replaceFirst("where", "where "+ searchQuery +" and");
				}
		  	    CyberoamLogger.sysLog.debug("PDF:ReportID:" + reportBean.getReportId()+ "Query->"+query);
		  	    try {					
		  	    	if(query.indexOf("select")==-1 && query.indexOf("SELECT")==-1){		  	    	 
						indexManager=new IndexManager();														
						rsw=indexManager.getSearch(query);														
						//rsw=indexManager.getResutSetFromArrayList(searchRecord);
					}else{
						rsw=sqlReader.getInstanceResultSetWrapper(query);
					}
				} catch (org.postgresql.util.PSQLException e) {
					if(query.indexOf("5min_ts_20") > -1) {
						query = query.substring(0,query.indexOf("5min_ts_20")) + "4hr" +query.substring(query.indexOf("5min_ts_20") + 16,query.length());
						CyberoamLogger.appLog.debug("New query : "+ query);						
						rsw = sqlReader.getInstanceResultSetWrapper(query);
					} else {
						CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
					}
				} catch (Exception e) {
					CyberoamLogger.appLog.error("Exeption in AjaxController.java "+e,e );
					rsw.close();
				}
				/*
				 * PDF Rendering work starts here
				 */	
				//if(Integer.parseInt(limit)<=10 && query.indexOf("where")>-1){
				if(reportBean.getReportFormatId()!=2){
					chart=Chart.getChart(reportBean.getReportId(),rsw, null);								
					PdfTemplate pdfTemplate = contentByte.createTemplate(width, height);					
					Graphics2D graphics2D = pdfTemplate.createGraphics(width, height);
					Rectangle2D rectangle = new Rectangle2D.Double(100,85,540,rec_hieght);	
					chart.draw(graphics2D, rectangle);
					graphics2D.dispose();			
					contentByte.addTemplate(pdfTemplate, 0, 0);	
					
					for(int j=0;j<(int)(rec_hieght/16)+1;j++) {
						document.add(new Paragraph("\n"));
					}
				}else
					document.add(new Paragraph("\n"));
				
				// Retrieving PdfPTable
				PdfPTable pdfTable=getPdfPTable(reportBean, rsw);
				rsw.close();								
								
				document.add(pdfTable);	
			CyberoamLogger.appLog.info("*************Finishing PDF Work****************");
		}catch (Exception e) {
			
			CyberoamLogger.sysLog.debug("Chart.writeChartToPDF.e"  + e.getMessage(),e);
		}finally{
			sqlReader.close();
		}
		document.close();
	}
	
	/**
	 * This Method gives Title with Dynamic values of Parameter
	 * @param title
	 * @param request
	 * @param reportGroupBean
	 * @return
	 */
	public static String getFormattedTitle(HttpServletRequest request, ReportGroupBean reportGroupBean,boolean isPDF) {
		String title=null;
		if(request != null){
			Object[] paramValues =null;
			String paramName=null,paramVal=null;
			StringTokenizer stToken = new StringTokenizer(reportGroupBean.getInputParams(),",");
			paramValues = new Object[stToken.countTokens()];
			
			for(int i=0;stToken.hasMoreTokens();i++){				
				paramName = stToken.nextToken();				
				if(paramName!= null && (paramName.equalsIgnoreCase("Application") || paramName.equalsIgnoreCase("Protocol Group") || paramName.equalsIgnoreCase("proto_group") && request.getParameter(paramName).indexOf(':')!=-1)) {
					paramVal=request.getParameter(paramName);
				try {
					String data;
					data=ProtocolBean.getProtocolNameById(Integer.parseInt(paramVal.substring(0,paramVal.indexOf(':'))));
					data=data + paramVal.substring(paramVal.indexOf(':'),paramVal.length());
					paramVal=data;
					} catch(Exception ex) {					
					}
				} else if( paramName.equalsIgnoreCase("Severity")) {
					paramVal= TabularReportConstants.getSeverity(request.getParameter(paramName));
				} else if(request.getParameter(paramName)==null ||  request.getParameter(paramName).equals("")) {
					paramVal="N/A";
				}  else {
					paramVal=request.getParameter(paramName);
				}						
				if(isPDF){
					paramValues[i]=paramVal;
				}else {
					paramValues[i]="<i>" + paramVal + "</i>";
				}
			}					
			MessageFormat queryFormat = new MessageFormat(reportGroupBean.getTitle());
			title=queryFormat.format(paramValues);
		}
		if(title == null){
			return reportGroupBean.getTitle();
		} else { 
			return title;
		}
	}

	/**
	 * This Event handler Method adds Header and Footer in PDF File
	 */
	  public void onEndPage(PdfWriter writer, Document document) {
        try {
        	if(document.getPageNumber()>1){
        		String seperator=System.getProperty("file.separator");
        		//String path=System.getProperty("catalina.home") +seperator+"webapps" +seperator+"ROOT" + seperator + "images" + seperator;
        		String path = InitServlet.contextPath + seperator + "images" + seperator;
        		Image imgHead=Image.getInstance(path+ "iViewPDFHeader.JPG");
        		Image imgFoot=Image.getInstance(path+ "iViewPDFFooter.JPG");
            	Rectangle page = document.getPageSize();
            
            	PdfPTable head = new PdfPTable(1);       
            	head.addCell(imgHead);            	
            	head.setTotalWidth(page.getWidth() - document.leftMargin() - document.rightMargin());
            	head.writeSelectedRows(0, -1, document.leftMargin()-10, page.getHeight() - document.topMargin() + head.getTotalHeight(),writer.getDirectContent());
            
            	PdfPTable foot = new PdfPTable(1);            	
            	foot.addCell(imgFoot);
            	foot.setTotalWidth(page.getWidth() - document.leftMargin() - document.rightMargin());
            	foot.writeSelectedRows(0, -1, document.leftMargin()-10, document.bottomMargin()+24,writer.getDirectContent());
        	}
        }
        catch (Exception e) {
            throw new ExceptionConverter(e);
        }
    }
}

