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
import java.awt.GradientPaint;
import java.awt.Point;
import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.GraphBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.dial.DialBackground;
import org.jfree.chart.plot.dial.DialCap;
import org.jfree.chart.plot.dial.DialPlot;
import org.jfree.chart.plot.dial.DialPointer;
import org.jfree.chart.plot.dial.DialValueIndicator;
import org.jfree.chart.plot.dial.StandardDialFrame;
import org.jfree.chart.plot.dial.StandardDialRange;
import org.jfree.chart.plot.dial.StandardDialScale;
import org.jfree.data.general.DefaultValueDataset;
import org.jfree.ui.GradientPaintTransformType;
import org.jfree.ui.StandardGradientPaintTransformer;

import com.lowagie.text.Image;

/**
 * This class represents Meter chart entity.
 * @author Vishal Vala
 *
 */
public class MeterChart {
	
	/**
	 * This method generates JFreeChart instance for Meter chart with dial port and iView customization.
	 * @param reportID
	 * @param rsw
	 * @param request
	 * @return
	 */
	public static JFreeChart getChart(int reportID,ResultSetWrapper rsw,HttpServletRequest request) {
		ReportBean reportBean = ReportBean.getRecordbyPrimarykey(reportID);
		JFreeChart chart = null;
		ReportColumnBean reportColumnBean = null;			
		GraphBean graphBean = null;
		try{
			DefaultValueDataset data = null;
			graphBean = GraphBean.getRecordbyPrimarykey(reportBean.getGraphId());
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getYColumnId());
			String yColumnDBname = reportColumnBean.getDbColumnName();
			rsw.first();
			double used = Double.parseDouble(rsw.getString(yColumnDBname));
			data = new DefaultValueDataset(100-used);
			DialPlot plot  = new DialPlot(data);
	        chart = new JFreeChart(
	            "", 
	            JFreeChart.DEFAULT_TITLE_FONT, 
	            plot, 
	            false
	        );
	        
	        chart.setBackgroundPaint(Color.white);
	        int imgWidth = graphBean.getWidth();
	        int imgHeight = graphBean.getHeight();
	        if (request!=null && request.getParameter("imgwidth")!=null && !"".equalsIgnoreCase(request.getParameter("imgwidth")) && !"null".equalsIgnoreCase(request.getParameter("imgwidth"))) {
	        	imgWidth = Integer.parseInt(request.getParameter("imgwidth"));
	        }
	        if (request!=null && request.getParameter("imgheight")!=null && !"".equalsIgnoreCase(request.getParameter("imgheight")) && !"null".equalsIgnoreCase(request.getParameter("imgheight"))) {
	        	imgHeight = Integer.parseInt(request.getParameter("imgheight"));
	        }
	        plot.setView((1-((double)imgWidth/(double)imgHeight))/2, plot.getViewY(),((double)imgWidth/(double)imgHeight), plot.getViewHeight());
	        StandardDialFrame dialFrame = new StandardDialFrame();
	        dialFrame.setBackgroundPaint(new Color(54, 73, 109));
	        dialFrame.setRadius(0.8);
	        dialFrame.setStroke(new BasicStroke(0));
	        plot.setDialFrame(dialFrame);
	        GradientPaint gp = new GradientPaint(new Point(), new Color(255, 255, 255), new Point(), new Color(196,210,219));
	        DialBackground db = new DialBackground(gp);
	        db.setGradientPaintTransformer(new StandardGradientPaintTransformer(GradientPaintTransformType.VERTICAL));
	        plot.setBackground(db);

	        DialValueIndicator dvi = new DialValueIndicator(0);
	        dvi.setRadius(0.55);
	        dvi.setBackgroundPaint(gp);
	        dvi.setNumberFormat(new DecimalFormat("###"));
	        dvi.setFont(new Font("Vandara",Font.CENTER_BASELINE,10));
	        dvi.setOutlinePaint(Color.lightGray);
	        plot.addLayer(dvi);
	        
	        StandardDialScale scale = new StandardDialScale(0,100,-120, -300,10,4);
	        scale.setTickRadius(0.75);
            scale.setTickLabelOffset(0.15);
            scale.setTickLabelFont(new Font("Vandara",Font.CENTER_BASELINE,9));
            plot.addScale(0, scale);
            
            StandardDialRange range = new StandardDialRange(0.0, 50.0, Color.green);
            range.setInnerRadius(0.35);
            range.setOuterRadius(0.38);
            plot.addLayer(range);
            
            StandardDialRange range2 = new StandardDialRange(50.0, 75.0, Color.yellow);
            range2.setInnerRadius(0.35);
            range2.setOuterRadius(0.38);
            plot.addLayer(range2);
            
            StandardDialRange range3 = new StandardDialRange(75.0, 100.0, Color.red);
            range3.setInnerRadius(0.35);
            range3.setOuterRadius(0.38);
            plot.addLayer(range3);
            
            DialPointer needle = new DialPointer.Pointer();
            needle.setRadius(0.55);
            plot.addLayer(needle);
            
            DialCap cap = new DialCap();
            cap.setRadius(0.05);
            plot.setCap(cap);
            
	         
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("MeterChart=>Exception : "+e,e);
		}
		return chart;
	}
}
