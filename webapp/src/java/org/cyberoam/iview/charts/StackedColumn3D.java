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
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.DataLinkBean;
import org.cyberoam.iview.beans.GraphBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iview.helper.TabularReportGenerator;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.utility.ByteInUnit;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.Axis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.labels.StandardCategoryToolTipGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.urls.StandardCategoryURLGenerator;
import org.jfree.chart.urls.URLUtilities;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;


/**
 * This class is used to represent category data sets for StackedColumn3D chart.
 * @author Vishal Vala
 * 
 */
class CustomCategoryDataset extends DefaultCategoryDataset {
	private ArrayList linkValue;
	
	/**
	 * This is default constructor and calls super constructor.
	 * This also initiates {@link ArrayList} of links.
	 */
	public CustomCategoryDataset() {
		super();
		linkValue = new ArrayList();
		
	}
	
	/**
	 * This method adds link value to {@link ArrayList}.
	 * @param value
	 * @param rowKey
	 * @param columnKey
	 * @param linkValue
	 */
	public void addValue(double value, Comparable rowKey, Comparable columnKey,Comparable linkValue) {
		// TODO Auto-generated method stub
		addValue(value, rowKey, columnKey);
		this.linkValue.add(linkValue);
	}	
	
	/**
	 * Returns link value from {@link ArrayList}.
	 * @param column
	 * @return
	 */
	public Comparable getLinkValuKey(int column) {
		// TODO Auto-generated method stub
		return (Comparable) linkValue.get(column);
	}
}

class CustomToolTipGeneratorForStacked extends StandardCategoryToolTipGenerator {
	private String formatString = null; 
	CustomToolTipGeneratorForStacked(){
		formatString = super.getLabelFormat();
	}
	CustomToolTipGeneratorForStacked(String formatString ){
		this.formatString = formatString;
	}
	 public String generateToolTip(CategoryDataset dataset,int row, int column) {
		String result = null;
		Object[] items = createItemArray(dataset, row, column);
		result = MessageFormat.format(formatString, items);
		return result;
	 }		
	
}


/**
 * This class is used to generate URL for stacked chart.
 * @author Narendra Shah
 *
 */
class CustomURLGeneratorForStackedChart extends StandardCategoryURLGenerator {
	private String prefix;
	private String categoryParameterName;
	
	/**
	 * This is default constructor used to initialize standard category URL generator and also used for initializing prefix and category parameter name. 
	 * @param a
	 * @param b
	 * @param c
	 */
	public CustomURLGeneratorForStackedChart(String prefix,String seriesParameterName,String categoryParameterName) {
		// TODO Auto-generated constructor stub
		super(prefix, seriesParameterName, categoryParameterName);
		this.prefix = prefix;
		this.categoryParameterName = categoryParameterName;
	}
	
	/**
	 * This method generates URL for chart.
	 */
	@Override
	public String generateURL(CategoryDataset dataset, int series, int category) {
		// TODO Auto-generated method stub	
        CustomCategoryDataset data = (CustomCategoryDataset) dataset;
        String dataValue=data.getLinkValuKey(category).toString();
		String url = this.prefix;
        url += url.indexOf("?") == -1 ? "?" : "&amp;";
        url += this.categoryParameterName + "=" + URLUtilities.encode(dataValue.equalsIgnoreCase("N/A") ?"":dataValue, "UTF-8");
        return url;    
		
	}	
}

/**
 * This class represents StackedColumn3D chart entity.
 * @author Narendra Shah
 * 
 */
public class StackedColumn3D{
	/**
	 * Get JfreeChart StackedColumn3D chart with iView Customization.
	 */

	/**
	 * This method generates JFreeChart instance for 3D Stacked Column chart with iView customization.
	 * @param reportID specifies that for which report Chart is being prepared.
	 * @param rsw specifies data set which would be used for the Chart
	 * @param requeest used for Hyperlink generation from uri.
	 * @return jfreechart instance with iView Customization.
	 */
	public static JFreeChart getChart(int reportId,ResultSetWrapper rsw,HttpServletRequest request) {
		ReportBean reportBean = ReportBean.getRecordbyPrimarykey(reportId);
		JFreeChart chart=null;
		try {			
			/*
			 * Create data set based on rsw object.
			 */
			ReportColumnBean reportColumnBean = null;			
			GraphBean graphBean = null;
			DataLinkBean dataLinkBean = null;		
			CustomCategoryDataset dataset = new CustomCategoryDataset();
			graphBean = GraphBean.getRecordbyPrimarykey(reportBean.getGraphId());//Getting GraphBean
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getXColumnId());//getting ReportColumnBean For X Axis
			String xColumnDBname = reportColumnBean.getDbColumnName();
			reportColumnBean.getColumnName();
			
			//Wheather DataLink is Given For X Axis column
			if(reportColumnBean.getDataLinkId() != -1) {
				dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
			}
			
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getYColumnId());
			String yColumnDBname = reportColumnBean.getDbColumnName();
			reportColumnBean.getColumnName();
			
			//if DataLink is not Given For X Axis column then Check of Y Axis Column
			if(dataLinkBean == null && reportColumnBean.getDataLinkId() != -1) {
				dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
			}		
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getZColumnId());
			//String zColumnDbname = reportColumnBean.getDbColumnName();
			String xData=null,zData=null;
			//Preparing DataSet
			rsw.beforeFirst();
			while(rsw.next()) {
				xData=rsw.getString(xColumnDBname);
				//zData = rsw.getString(zColumnDbname);
				zData = TabularReportGenerator.getFormattedColumn(reportColumnBean.getColumnFormat(), reportColumnBean.getDbColumnName(), rsw);
				if(xData == null || "".equalsIgnoreCase(xData) || "null".equalsIgnoreCase(xData))
						xData="N/A";
				dataset.addValue(new Long(rsw.getLong(yColumnDBname)), zData, xData,rsw.getString("deviceid"));
			}
			
			//Create the jfree chart instance.
			chart = ChartFactory.createStackedBarChart3D(
				"", 				// chart title
				"",
				"",
				dataset, 			// data
				PlotOrientation.VERTICAL,
				true, 				// include legend
				true, 				// tooltips?
				false 				// URLs?
			);
			/*
			 *Setting additional customization to the chart. 
			 */
			//Set the background color for the chart...
			chart.setBackgroundPaint(Color.white);
			//Get a reference to the plot for further customisation...
			CategoryPlot plot = chart.getCategoryPlot();
			plot.setBackgroundPaint(new Color(245,245,245));
			plot.setDomainGridlinePaint(Color.white);
			plot.setDomainGridlinesVisible(true);
			plot.setRangeGridlinePaint(Color.LIGHT_GRAY);

			//Set the range axis to display integers only...
			NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
			
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getYColumnId());			
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
			
			LegendTitle legendTitle=chart.getLegend();
			legendTitle.setItemFont(new Font("Arial", Font.CENTER_BASELINE, 11));
		    
			BarRenderer renderer = (BarRenderer) plot.getRenderer();
			renderer.setDrawBarOutline(false);
			renderer.setMaximumBarWidth(0.05);
			

			renderer.setSeriesPaint(0, new Color(24, 112, 176));
			renderer.setSeriesPaint(1, new Color(168, 192, 232));
			renderer.setSeriesPaint(2, new Color(248, 120, 8));
			renderer.setSeriesPaint(3, new Color(248, 184, 120));
			renderer.setSeriesPaint(4, new Color(152, 216, 136));			
			if(dataLinkBean != null && request != null) {
				renderer.setBaseItemURLGenerator(new CustomURLGeneratorForStackedChart(dataLinkBean.generateURLForChart(request),"","deviceid"));
			}
			renderer.setBaseToolTipGenerator(new CustomToolTipGeneratorForStacked());
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("StackedColumn3D.e:"+e,e);
		}
		return chart;
	}
}
