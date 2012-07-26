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
import org.cyberoam.iview.beans.GraphBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.ThermometerPlot;
import org.jfree.data.general.DefaultValueDataset;
import org.jfree.ui.ApplicationFrame;


/**
 * This class represents Thermometer chart entity.
 * @author Vishal Vala
 *
 */
public class Thermometer extends ApplicationFrame {
	
	public Thermometer() {
		super("");
	}

	/**
	 * This method generates JFreeChart instance for Thermometer chart with iView customization. 
	 * @param reportID
	 * @param rsw
	 * @param request
	 * @return
	 */
	public static JFreeChart getChart(int reportID,ResultSetWrapper rsw,HttpServletRequest request) {
		ReportBean reportBean = ReportBean.getRecordbyPrimarykey(reportID);
		JFreeChart chart =null;
		ReportColumnBean reportColumnBean = null;			
		GraphBean graphBean = null;
		try {
			DefaultValueDataset dataset = null;
			graphBean = GraphBean.getRecordbyPrimarykey(reportBean.getGraphId());
			reportColumnBean = ReportColumnBean.getRecordByPrimaryKey(reportBean.getReportId(), graphBean.getYColumnId());
			String yColumnDBname = reportColumnBean.getDbColumnName();
			rsw.first();
			double used = Double.parseDouble(rsw.getString(yColumnDBname));
			rsw.next();
			double free = Double.parseDouble(rsw.getString(yColumnDBname));
			dataset = new DefaultValueDataset((100*used)/(used+free));
			ThermometerPlot plot = new ThermometerPlot(dataset);
			chart = new JFreeChart("",  // chart title
                    JFreeChart.DEFAULT_TITLE_FONT,
                    plot,                 // plot
                    false);               // include legend
			chart.setBackgroundPaint(Color.white);
			plot.setThermometerStroke(new BasicStroke(2.0f));
			plot.setThermometerPaint(Color.DARK_GRAY);
			plot.setBulbRadius(30);
			plot.setColumnRadius(15);
			plot.setUnits(ThermometerPlot.UNITS_NONE);
			plot.setMercuryPaint(Color.WHITE);
			plot.setValueFont(new Font("Vandara",Font.CENTER_BASELINE,12));
			plot.setBackgroundPaint(Color.white);
			plot.setBackgroundAlpha(0.0f);
			plot.setOutlineVisible(false);
			plot.setSubrangeInfo(0, 0, 50);
			plot.setSubrangeInfo(1, 50, 85);
			plot.setSubrangeInfo(2, 85, 100);
			plot.setSubrangePaint(0, new Color(75, 200, 85));
			plot.setSubrangePaint(1, new Color(254, 211, 41));
			plot.setSubrangePaint(2, new Color(255, 85, 85));
			
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("Thermometer=>getChart.exception : "+e, e);
		}
		return chart;
		}
}
