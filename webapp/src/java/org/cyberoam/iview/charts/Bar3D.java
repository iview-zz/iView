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
import java.awt.Graphics2D;
import java.awt.Paint;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.util.HashMap; 

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
import org.jfree.chart.axis.AxisLocation;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.labels.StandardCategoryToolTipGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.chart.renderer.category.CategoryItemRenderer;
import org.jfree.chart.urls.StandardCategoryURLGenerator;
import org.jfree.chart.urls.URLUtilities;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.text.TextBlock;
import org.jfree.ui.RectangleEdge;


/**
 * This class is used in Bar3D to generate custom category axis. 
 * @author Vishal Vala
 *
 */
class CustomCategoryAxis extends CategoryAxis {
	private int labelFormat=TabularReportConstants.NO_DATA_FORMATTING;
	/**
	 * get iView byte formatting
	 * @return byteformat
	 */
	public int getLabelFormat(){
		return labelFormat;
	}
	/**
	 * set iView byte formatting
	 */
	public void setLabelFormat(int labelFormat){
		this.labelFormat=labelFormat;
	}
	/**
	 * Label creation 
	 * @return will return textblock of label
	 */
	protected TextBlock createLabel(Comparable category, float width, RectangleEdge edge, Graphics2D g2) {
		String labelValue=category.toString().substring(2);
		if(labelValue == null || "".equalsIgnoreCase(labelValue) || "null".equalsIgnoreCase(labelValue)){
			labelValue="N/A";
		}else if(getLabelFormat() == TabularReportConstants.PROTOCOL_FORMATTING && labelValue.indexOf(':') != -1){
			String data=ProtocolBean.getProtocolNameById(Integer.parseInt(labelValue.substring(0, labelValue.indexOf(':'))));
			labelValue=data+labelValue.substring(labelValue.indexOf(':'),labelValue.length());
		}
		else if(getLabelFormat() == TabularReportConstants.SEVERITY_FORMATTING){
			labelValue=TabularReportConstants.getSeverity(labelValue);
		}
		return super.createLabel(labelValue, width, edge, g2);
	}	
	
	
}

/**
 * This class is used in Bar3D to generate URL for chart.
 * @author Narendra Shah
 *
 */
class CustomURLGeneratorForBarChart extends StandardCategoryURLGenerator {
	private String prefix;
	private String categoryParameterName;
	// use to store URL's for all the rows in the data report
	private HashMap<Integer,String> urlMap;
	public CustomURLGeneratorForBarChart(String a,String c) {
		super(a,"",c);
		this.prefix = a;
		this.categoryParameterName = c;
	}
	
	//Setter method for URL MAP
	public void setUrlMap(HashMap<Integer,String> urlmap) {
		this.urlMap=urlmap;
	}

	/* Description: This method use for generate url to every bar line in graph. it is call from jfree char framework. 
					it is till end of records for bar line in graph. Here we will take url from the take map for getting url and return url to jfreechat .
		By: 		Hemant Agrawal
	*/
	
	public String generateURL(CategoryDataset dataset, int series, int category) {						
			String url=this.urlMap.get(new Integer(category));
			return url;
/*it is old code. it is not work when two value with comma like(ruleid,porto_group)	in rswparameter column in tbldatalink table.
bec it is use column name and append in url and value but it is not using tbldatalink value in rswparameter field.
For URL, we should be use value of rswparameter from tbldatalink table.
		
			String data=dataset.getColumnKey(category).toString().substring(2) ;
			return this.prefix + (this.prefix.indexOf("?") == -1? "?" : "&amp;")  +
			this.categoryParameterName + "=" + 
			URLUtilities.encode(data.equalsIgnoreCase("N/A") ?"":data, "UTF-8");			
*/						
	}         		
		
}

/**
 * This class is used in Bar3D to generate tooltip for chart.
 * @author Narendra Shah
 *
 */
class CustomToolTipGenerator extends StandardCategoryToolTipGenerator {
	private String formatString = null; 
	CustomToolTipGenerator(){
		formatString = super.getLabelFormat();
	}
	CustomToolTipGenerator(String formatString ){
		this.formatString = formatString;
	}
	 public String generateToolTip(CategoryDataset dataset,int row, int column) {
		String result = null;
		Object[] items = createItemArray(dataset, row, column);
		items[1] = items[1].toString().substring(1);
		result = MessageFormat.format(formatString, items);
		return result;
	 }		
	
}

/**
 * This class represents JfreeChart Bar3D chart entity with iView customization.
 * @author Narendra Shah
 *
 */
public class Bar3D {
	
	/**
	 * This method generates JFreeChart instance for 3D Bar chart with iView customization.
	 * @param reportID specifies that for which report Chart is being prepared.
	 * @param rsw specifies data set which would be used for the Chart
	 * @param requeest used for Hyperlink generation from uri.
	 * @return jfreechart instance with iView Customization.
	 */
	public static JFreeChart getChart(int reportID,ResultSetWrapper rsw,HttpServletRequest request){
		JFreeChart chart = null;
		boolean isPDF=false;
		try {			
			if(request == null){
				isPDF=true;
			}
			/*
			 * Create data set based on rsw object.
			 */
			ReportBean reportBean = ReportBean.getRecordbyPrimarykey(reportID);
			ReportColumnBean reportColumnBeanX,reportColumnBeanY = null;
			
			GraphBean graphBean = null;
			DataLinkBean dataLinkBean = null;		
			DefaultCategoryDataset dataset = new DefaultCategoryDataset();			
			graphBean = GraphBean.getRecordbyPrimarykey(reportBean.getGraphId());//Getting GraphBean
			reportColumnBeanX = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getXColumnId());//getting ReportColumnBean For X Axis
			if(reportColumnBeanX.getDataLinkId() != -1) {
				dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBeanX.getDataLinkId());
			}
			
			reportColumnBeanY = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getYColumnId());
			rsw.beforeFirst();
			int i = 0;
			DecimalFormat placeHolder=new DecimalFormat("00");			
			String xData=null;			
			String graphurl="";
			HashMap<Integer,String> urlmap=new HashMap<Integer,String>();
			while(rsw.next()) {
				xData=rsw.getString(reportColumnBeanX.getDbColumnName());
				if(dataLinkBean != null && request != null) {
					//datalink id is non -1 in tblcolumnreport table means another report is avaialble so set url 
					// here multiple url possible bec multiple record so take hashmap and store url. 
					// we have dataset but dataset is occupied.
					graphurl=dataLinkBean.generateURLForChart(rsw,request);					
					urlmap.put(new Integer(i),graphurl);
				}
				//dataset second arugument use for bar line of graph and third argument give name of graph
				dataset.addValue(new Long(rsw.getLong(reportColumnBeanY.getDbColumnName())), "" ,  placeHolder.format(i) + xData );								
				i++;
			}
			// we define object of CustomURLGeneratorForBarChart and if datalinkid is not -1 then it object define for link
			CustomURLGeneratorForBarChart customURLGeneratorForBarChart=null;
			if(dataLinkBean!=null && request !=null)
			{
				customURLGeneratorForBarChart=new CustomURLGeneratorForBarChart(dataLinkBean.generateURLForChart(request),reportColumnBeanX.getDbColumnName());
				customURLGeneratorForBarChart.setUrlMap(urlmap);
			}
			/*
			 * Create the jfree chart object.
			 */
			String title=isPDF?reportBean.getTitle():"";
			chart = ChartFactory.createBarChart3D(
				title, // chart title
				"", // domain axis label
				"",
				dataset, // data				
				PlotOrientation.HORIZONTAL, // orientation
				false, // include legend
				true, // tooltips?
				false // URLs?
			);
					
			
			/*
			 *Setting additional customization to the chart. 
			 */
			//Set background color
			chart.setBackgroundPaint(Color.white);
			//Get a reference to the plot for further customisation
			CategoryPlot plot = chart.getCategoryPlot();
			plot.setBackgroundPaint(Color.white);
			plot.setDomainGridlinePaint(Color.white);
			plot.setDomainGridlinesVisible(true);
			plot.setRangeGridlinePaint(Color.DARK_GRAY);
			plot.setForegroundAlpha(0.8f);
			plot.setDomainGridlineStroke(new BasicStroke(2));
			plot.setOutlineVisible(false);
			plot.setRangeAxisLocation(AxisLocation.BOTTOM_OR_RIGHT);					
			
			//Set the range axis to display integers only...
			NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
			if(reportColumnBeanY.getColumnFormat() == TabularReportConstants.BYTE_FORMATTING) {				
				rangeAxis.setTickUnit(new ByteTickUnit(rangeAxis.getUpperBound() /4));
			}
			rangeAxis.setStandardTickUnits(NumberAxis.createStandardTickUnits());
			rangeAxis.setTickLabelFont(new Font("Arial",Font.CENTER_BASELINE,10));
			rangeAxis.setTickLabelsVisible(true);
			rangeAxis.setTickMarksVisible(true);
			rangeAxis.setAxisLineVisible(false);
			rangeAxis.setLabel(reportColumnBeanY.getColumnName());
			rangeAxis.setLabelFont(new Font("Arial",Font.CENTER_BASELINE,12));
			rangeAxis.setLabelPaint(new Color(35,139,199));

			
			CustomCategoryAxis catAxis = new CustomCategoryAxis();
			catAxis.setTickLabelFont(new Font("Arial",Font.CENTER_BASELINE,10));			
			catAxis.setTickMarksVisible(false);
			catAxis.setAxisLineVisible(false);
			catAxis.setLabel(reportColumnBeanX.getColumnName());
			catAxis.setLabelFont(new Font("Arial",Font.CENTER_BASELINE,12));
			catAxis.setLabelPaint(new Color(35,139,199));
			catAxis.setLabelFormat(reportColumnBeanX.getColumnFormat());
			
			plot.setDomainAxis(catAxis);
			
			//Set custom color for the chart.			
	        CategoryItemRenderer renderer = new CustomRenderer(
		                new Paint[] {new Color(254,211,41),
		                			 new Color(243,149,80), 
		                			 new Color(199,85,82), 
		                			 new Color(181,105,152) ,
		                			 new Color(69,153,204),
		                			 new Color(155,212,242), 
		                			 new Color(52,172,100),
		                			 new Color(164,212,92),
		                			 new Color(177,155,138),
		                			 new Color(149,166,141)
	                			}
	            );

	        plot.setRenderer(renderer);
			
			BarRenderer renderer2 = (BarRenderer) plot.getRenderer();
			renderer2.setDrawBarOutline(false);						
			renderer2.setBaseItemLabelsVisible(true);
			renderer2.setMaximumBarWidth(0.04);
			
			if(dataLinkBean != null && request != null) {				
				renderer.setBaseItemURLGenerator(customURLGeneratorForBarChart);
				//renderer.setBaseItemURLGenerator(new CustomURLGeneratorForBarChart(dataLinkBean.generateURLForChart(request),reportColumnBeanX.getDbColumnName()));
			}
            renderer.setBaseToolTipGenerator(new CustomToolTipGenerator());
            renderer.setBaseToolTipGenerator(new CustomToolTipGenerator());
			renderer.setBaseToolTipGenerator(new CustomToolTipGenerator("{2} " + reportColumnBeanY.getColumnName()));				
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("Bar3D.e:" +e,e);
		}
		return chart;
	}
}

/**
 * This class is used to maintain renderer for Bar3D chart.
 * @author Narendra Shah
 *
 */
class CustomRenderer extends BarRenderer3D {
    /**
     *  The colors. 
    */
    private Paint[] colors;
    
    /**
     * Creates a new renderer.
     * @param colors  the colors.
     */
    public CustomRenderer(final Paint[] colors) {
        this.colors = colors;
    }
    
    /**
     * Returns the paint for an item.  Overrides the default behavior inherited from AbstractSeriesRenderer.
     * @param row  the series.
     * @param column  the category.
     * @return The item color.
     */
    public Paint getItemPaint(final int row, final int column) {
        return this.colors[column % this.colors.length];
    }   
    
}
