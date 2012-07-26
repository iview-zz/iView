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
//select to_char(date_trunc('hour',"5mintime"),'YYYY-MM-DD HH24:MI') as starttime,appid,sum(events) from tbl_device_event_4hr where "5mintime" >= '2009-08-19 00:00:00' and "5mintime" <= '2009-08-19 23:59:59'  group by starttime,appid order by appid,starttime;

//select date_trunc('minute', "5mintime") as tm,appid,sum(events) from tbl_device_event_4hr group by tm,appid order by tm desc;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.GraphBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.title.LegendTitle;
import org.jfree.text.TextBlock;
import org.jfree.ui.RectangleEdge;
import org.jfree.ui.RectangleInsets;


class CustomDomainAxis extends CategoryAxis {
	public static int colCount = 1;
	public static int counter = 0;
	protected TextBlock createLabel(Comparable category, float width, RectangleEdge edge, Graphics2D g2) {
		CustomDomainAxis.counter++;
		String domainLabel = category.toString();
		int tempcounter = counter - colCount;
			if(colCount%2 == 1){
				if((tempcounter == 1) || (tempcounter == (colCount/4)+1) || (tempcounter == (colCount/2)+1) || (tempcounter == (3*colCount/4)+1) ||(tempcounter == colCount)){
					domainLabel = domainLabel.substring(0, domainLabel.toString().length() - 3);
				} else {
					domainLabel = "";
				}
			} else {
				if((tempcounter == 1)|| (tempcounter == (colCount/4)) || (tempcounter == (colCount/2)) || (tempcounter == (3*colCount/4))||(tempcounter == colCount)) {
					domainLabel = domainLabel.substring(0, domainLabel.toString().length() - 3);
				} else {
					domainLabel = "";
				}
			}
		return super.createLabel(domainLabel , width, edge, g2);
	}
	
}

public class Line {
	
	public static JFreeChart getChart(int reportID,ResultSetWrapper rsw,HttpServletRequest request) {
		ReportBean reportBean = ReportBean.getRecordbyPrimarykey(reportID);
		JFreeChart chart =null;
	//	DefaultCategoryDataset dataset=null;
		CustomCategoryDataset datasetCustom = null;
		
		try{
			ReportColumnBean reportColumnBeanX = null;
			ReportColumnBean reportColumnBeanY = null;
			ReportColumnBean reportColumnBeanZ = null;
			GraphBean graphBean = null;
					
			graphBean = GraphBean.getRecordbyPrimarykey(reportBean.getGraphId());
			reportColumnBeanX = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getXColumnId());//getting ReportColumnBean For X Axis
			String xColumnDBname = reportColumnBeanX.getDbColumnName();
			reportColumnBeanY = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getYColumnId());
			String yColumnDBname = reportColumnBeanY.getDbColumnName();
			String zColumnDBname=null;
			
			datasetCustom= new CustomCategoryDataset();
			rsw.beforeFirst();
			String data = "";
			int count=-1;
			Boolean showLegend=false;
			if(graphBean.getZColumnId()==-1){

				while(rsw.next()) {
					data = rsw.getString(xColumnDBname);
					datasetCustom.addValue(rsw.getLong(yColumnDBname), "", data);					
				}
				
			}else {								
				String zData;
				showLegend=true;
				reportColumnBeanZ = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getZColumnId());
				zColumnDBname= reportColumnBeanZ.getDbColumnName();				
				while(rsw.next()) {
					data = rsw.getString(xColumnDBname);
					zData=rsw.getString(zColumnDBname);
					datasetCustom.addValue(rsw.getLong(yColumnDBname), zData, data);
					count++;
				}
				
			}
			chart = ChartFactory.createLineChart(
					"",       					// chart title
					"",                    		// domain axis label
					"",                   		// range axis label
					datasetCustom,             	// data
					PlotOrientation.VERTICAL,  	// orientation
					showLegend,                 // include legend
					true,                      	// tooltips
					false                      	// urls
		    	);			
			LegendTitle legendTitle=chart.getLegend();			
			if(legendTitle!=null)
				legendTitle.setItemFont(new Font("Vandara", Font.BOLD, 11));						
			chart.setBackgroundPaint(Color.white);		
			CategoryPlot plot = chart.getCategoryPlot();			
			plot.setBackgroundPaint(Color.white);
			plot.setDomainGridlinePaint(Color.LIGHT_GRAY);
			plot.setDomainGridlinesVisible(true);
			plot.setRangeGridlinePaint(Color.LIGHT_GRAY);
			plot.setAxisOffset(new RectangleInsets(0, 0, 0, 0));			
			NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
			rangeAxis.setStandardTickUnits(NumberAxis.createStandardTickUnits());
			rangeAxis.setTickLabelFont(new Font("Vandara",Font.CENTER_BASELINE,10));
			rangeAxis.setTickLabelInsets(new RectangleInsets(0,0,0,5));
			rangeAxis.setTickLabelsVisible(true);
			rangeAxis.setTickMarksVisible(false);
			rangeAxis.setAxisLineVisible(false);			
			CustomDomainAxis catAxis = new CustomDomainAxis();
			CustomDomainAxis.counter = 0;
			CustomDomainAxis.colCount = datasetCustom.getColumnCount();
			catAxis.setTickLabelFont(new Font("Arial",Font.CENTER_BASELINE,10));			
			catAxis.setTickMarksVisible(false);
			catAxis.setTickLabelInsets(new RectangleInsets(10,15,30,10));
			catAxis.setAxisLineVisible(false);
			catAxis.setCategoryLabelPositions(CategoryLabelPositions.createUpRotationLabelPositions(20*Math.PI/180));
			plot.setDomainAxis(catAxis);			
			final LineAndShapeRenderer renderer = (LineAndShapeRenderer) plot.getRenderer();
			renderer.setSeriesPaint(0, Color.DARK_GRAY);			
			if(count>0){
				Color [] colors=null;
				colors=new Color[5];
				colors[0]=new Color(24, 112, 176);
				colors[1]=new Color(168, 192, 232);
				colors[2]=new Color(248, 120, 8);
				colors[3]=new Color(248, 184, 120);
				colors[4]=new Color(152, 216, 136);
				for(int i=0;i<count && i<colors.length;i++)
					renderer.setSeriesPaint(i,colors[i] );
			}
		} catch (Exception e) {
			CyberoamLogger.appLog.debug("LineChart: "+e.getMessage() ,e);
		}
	    return chart;
	}
}

