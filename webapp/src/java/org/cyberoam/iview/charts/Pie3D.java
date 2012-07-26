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
import java.text.MessageFormat;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.DataLinkBean;
import org.cyberoam.iview.beans.GraphBean;
import org.cyberoam.iview.beans.ProtocolBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardPieToolTipGenerator;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.chart.title.LegendTitle;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.general.PieDataset;
import org.jfree.ui.HorizontalAlignment;
import org.jfree.util.Rotation;


/**
 * This class is used to generate tooltip for pie chart.
 * @author Narendra Shah
 *
 */
class CustomToolTipGeneratorForPie3D extends StandardPieToolTipGenerator {
	private String formatString = null; 
	CustomToolTipGeneratorForPie3D(){
		formatString = super.getLabelFormat();
	}
	CustomToolTipGeneratorForPie3D(String formatString ){
		this.formatString = formatString;
	}
	 public String generateToolTip(PieDataset dataset,Comparable key) {
		String result = null;
		Object[] items = createItemArray(dataset, key);
		result = MessageFormat.format(formatString, items);
		return result;
	 }		
	
}


/**
 * This class represents Pie3D chart entity.
 * @author Vishal Vala
 *
 */
public class Pie3D {
	
	private static Color[] pieSections = {new Color(254,211,41),
		new Color(243,149,80),
		new Color(199,85,82),
		new Color(181,105,152),
		new Color(69,153,204)};
	
	/**
	 * This method generates JFreeChart instance for 3D Pie chart with iView customization.
	 * @param reportID specifies that for which report Chart is being prepared.
	 * @param rsw specifies data set which would be used for the Chart
	 * @param requeest used for Hyperlink generation from uri.
	 * @return jfreechart instance with iView Customization.
	 */
	public static JFreeChart getChart(int reportID,ResultSetWrapper rsw,HttpServletRequest request) {
		boolean xFlag=false;
		ReportBean reportBean = ReportBean.getRecordbyPrimarykey(reportID);
		JFreeChart chart=null;
		try {			
			ReportColumnBean reportColumnBean,reportColumnBeanX = null;			
			GraphBean graphBean = null;
			DataLinkBean dataLinkBean = null;		
			DefaultPieDataset dataset = new DefaultPieDataset();
			graphBean = GraphBean.getRecordbyPrimarykey(reportBean.getGraphId());//Getting GraphBean
			reportColumnBeanX = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getXColumnId());//getting ReportColumnBean For X Axis
		//	String xColumnDBname = reportColumnBeanX.getDbColumnName();
			
			if(reportColumnBeanX.getDataLinkId() != -1) {
				dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBeanX.getDataLinkId());
			}
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getZColumnId());
			rsw.beforeFirst();
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getYColumnId());
			String yColumnName = reportColumnBean.getColumnName();
			if(dataLinkBean == null && reportColumnBean.getDataLinkId() != -1) {
				dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
			}					
			String xData=null;
			while(rsw.next()) {
				xData=rsw.getString(reportColumnBeanX.getDbColumnName());
				if(xData==null || "".equalsIgnoreCase(xData) || "null".equalsIgnoreCase(xData) ) {
					xData="N/A";
				}else if (reportColumnBeanX.getColumnFormat() == TabularReportConstants.PROTOCOL_FORMATTING && xData.indexOf(':') != -1) {
					String data=data=ProtocolBean.getProtocolNameById(Integer.parseInt(rsw.getString(reportColumnBeanX.getDbColumnName()).substring(0, xData.indexOf(':'))));
					xData=data+rsw.getString(reportColumnBeanX.getDbColumnName()).substring(xData.indexOf(':'),xData.length());	
				}
				dataset.setValue(xData,new Long(rsw.getLong(reportColumnBean.getDbColumnName())) );
			}			
			chart = ChartFactory.createPieChart3D(
				"", 		// chart title
				dataset, 	// data
				true, 		// include legend
				true, 		// tooltips?
				false 		// URLs?
			);
			/*
			 *Setting additional customization to the chart. 
			 */
			//Set the background color for the chart...
			chart.setBackgroundPaint(Color.white);
						
			
			//Get a reference to the plot for further customisation...
			PiePlot3D plot = (PiePlot3D) chart.getPlot();
			plot.setBackgroundPaint(Color.white);
			plot.setBackgroundAlpha(0.0f);
			plot.setSectionOutlinesVisible(false);
			plot.setOutlineVisible(false);
		    plot.setStartAngle(290);
		    plot.setDepthFactor(0.1);
		    plot.setDirection(Rotation.CLOCKWISE);
		    plot.setNoDataMessage("No data to display");
		    plot.setSectionOutlinesVisible(false);
		    plot.setSectionOutlinePaint(Color.white);
		    plot.setOutlineVisible(false);		
		    plot.setExplodePercent(dataset.getKey(0), 0.3);
		    
		    plot.setLabelLinkPaint(Color.gray);
		    plot.setLabelBackgroundPaint(Color.white);
		    plot.setLabelFont(new Font("Arial",Font.CENTER_BASELINE,10));
		    plot.setLabelOutlinePaint(Color.white);
		    plot.setLabelShadowPaint(Color.white);
		    
	
		    LegendTitle legend = chart.getLegend();
		    legend.setItemFont(new Font("Arial",Font.CENTER_BASELINE,10));
		    legend.setMargin(0, 0, 2, 0);
		    legend.setHorizontalAlignment(HorizontalAlignment.CENTER);

		    plot.setToolTipGenerator(new CustomToolTipGeneratorForPie3D("{0}: ({1} "+yColumnName+", {2})"));
		    //Setting Color 
		    try{
			    plot.setSectionPaint(dataset.getKey(0),Pie3D.pieSections[0]);
			    plot.setSectionPaint(dataset.getKey(1),Pie3D.pieSections[1]); 
			    plot.setSectionPaint(dataset.getKey(2),Pie3D.pieSections[2]) ;
			    plot.setSectionPaint(dataset.getKey(3),Pie3D.pieSections[3]);
			    plot.setSectionPaint(dataset.getKey(4),Pie3D.pieSections[4]);
		    }catch (Exception e) {}
		    
		} catch (Exception e){
			CyberoamLogger.appLog.debug("Pie3D.e:"+e,e);
		}
		return chart;
	}
}
