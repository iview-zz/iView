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


import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.DataLinkBean;
import org.cyberoam.iview.beans.GraphBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.Axis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;


/**
 * This class represents XYLine Chart entity.
 * @author Vishal Vala
 * 
 */
public class XYLine {
	/**
	 * Get JfreeChart XYLine chart with iView Customization.
	 */

	/**
	 * This method generates JFreeChart instance for XYLine chart with iView customization.
	 * @param reportID specifies that for which report Chart is being prepared.
	 * @param rsw specifies data set which would be used for the Chart
	 * @param requeest used for Hyperlink generation from URL.
	 * @return jfreechart instance with iView Customization.
	 */
	public static JFreeChart getChart(int reportID,ResultSetWrapper rsw,HttpServletRequest request) {
		ReportBean reportBean = ReportBean.getRecordbyPrimarykey(reportID);
		JFreeChart chart =null;
		try {			
			ReportColumnBean reportColumnBean = null;			
			GraphBean graphBean = null;
			DataLinkBean dataLinkBean = null;		
			XYDataset dataset = null;
			XYSeriesCollection seriesCollection = new XYSeriesCollection();
			XYSeries series = new XYSeries(reportBean.getTitle());
			graphBean = GraphBean.getRecordbyPrimarykey(reportBean.getGraphId());//Getting GraphBean
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getXColumnId());//getting ReportColumnBean For X Axis
			String xColumnDBname = reportColumnBean.getDbColumnName();
			String xColumnName = reportColumnBean.getColumnName();
			//Wheather DataLink is Given For X Axis column
			if(reportColumnBean.getDataLinkId() != -1) {
				dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
			}
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getYColumnId());
			String yColumnDBname = reportColumnBean.getDbColumnName();
			String yColumnName = reportColumnBean.getColumnName();
			//if DataLink is not Given For X Axis column then Check of Y Axis Column
			if(dataLinkBean == null && reportColumnBean.getDataLinkId() != -1) {
				dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
			}		
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getZColumnId());
			String zColumnDbname = reportColumnBean.getDbColumnName();
			//Preparing DataSet
			String data = "";
			rsw.beforeFirst();
			while(rsw.next()) {				
				data = rsw.getString(xColumnDBname);
				series.add( Long.parseLong((data).substring(data.length() - 2)) ,new Long(rsw.getLong(yColumnDBname)).longValue()  );
			}
			seriesCollection.addSeries(series);
			
			dataset = seriesCollection;
			// create the chart...
			chart = ChartFactory.createXYLineChart(
				"", 						// chart title
				"", 						// domain axis label
				"",
				seriesCollection, 			// data
				PlotOrientation.VERTICAL, 	// orientation
				false, 						// include legend
				true, 						// tooltips?
				false 						// URLs?
			);
			/*
			 * Additional iView Customization.
			 */
			//Set the background color for the chart...
			chart.setBackgroundPaint(Color.white);
			
			//Get a reference to the plot for further customisation...
			XYPlot plot = chart.getXYPlot();
			plot.setBackgroundPaint(new Color(245,245,245));
			plot.setDomainGridlinePaint(Color.LIGHT_GRAY);
			plot.setDomainGridlinesVisible(true);
			plot.setRangeGridlinePaint(Color.LIGHT_GRAY);
			plot.setForegroundAlpha(0.7f);
			
			//Set the range axis to display integers only...
			NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
			if(reportColumnBean.getColumnFormat() == TabularReportConstants.BYTE_FORMATTING) {				
				rangeAxis.setTickUnit(new ByteTickUnit(rangeAxis.getUpperBound()/4));
			}
			rangeAxis.setStandardTickUnits(NumberAxis.createStandardTickUnits());
			rangeAxis.setTickLabelFont(new Font("Vandara",Font.CENTER_BASELINE,10));
			rangeAxis.setTickLabelsVisible(true);
			rangeAxis.setTickMarksVisible(false);
			rangeAxis.setAxisLineVisible(false);
										
			Axis domainAxis = plot.getDomainAxis();
			domainAxis.setTickLabelFont(new Font("Vandara",Font.CENTER_BASELINE,10));			
			domainAxis.setTickMarksVisible(false);
			domainAxis.setAxisLineVisible(false);			
			
	        XYLineAndShapeRenderer renderer = (XYLineAndShapeRenderer) plot.getRenderer();
	        renderer.setSeriesPaint(0, Color.DARK_GRAY);
	        renderer.setSeriesStroke(0, new BasicStroke(1));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return chart;
	}
}
