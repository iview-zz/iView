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

package org.cyberoam.iview.helper;


import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.authentication.beans.UserBean;
import org.cyberoam.iview.beans.DataLinkBean;
import org.cyberoam.iview.beans.ProtocolBean;
import org.cyberoam.iview.beans.ReportBean;
import org.cyberoam.iview.beans.ReportColumnBean;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.utility.ByteInUnit;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;


/**
 * This class is used to generate tabular data for reports.
 * @author Narendra Shah
 *
 */
public class TabularReportGenerator {
	
	/**
	 * This method is used to get table which can be displayed on screen for report.
	 * @param request
	 * @param rsw
	 * @return
	 */
	public static String getBody(HttpServletRequest request,ResultSetWrapper rsw){
		StringBuffer out=new StringBuffer();
		try{
			ReportColumnBean reportColumnBean = null;
			DataLinkBean dataLinkBean = null;
			ArrayList reportColumnsMap = ReportColumnBean.getReportColumnsByReportID(Integer.parseInt(request.getParameter("reportid")));					
			out.append("[[");
			for(int i=0;i<reportColumnsMap.size();i++){				
				reportColumnBean = (ReportColumnBean) reportColumnsMap.get(i);
				out.append("\'");
				out.append(reportColumnBean.getColumnName()+"||"+reportColumnBean.getAlignment());
				out.append("\',");
			}
			out.append("],");
			rsw.beforeFirst();
			
			if(!rsw.next()){
				out.append("[\' No Data Available||3 \'],");				
			}
			rsw.beforeFirst();
			while (rsw.next()) {
				out.append("[");
				for(int i=0;i<reportColumnsMap.size();i++){
					String toolTip = "";
					int aligement = 0;
					String href = "";	
					String url = "";
					reportColumnBean = (ReportColumnBean) reportColumnsMap.get(i);
					if(reportColumnBean.getDataLinkId() != -1){
						dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
						url = dataLinkBean.generateURL(rsw, request);
						url = url.replace("&","&emp;");
					}
					aligement = reportColumnBean.getAlignment();
					if(reportColumnBean.getTooltip() != null && !"".equals(reportColumnBean.getTooltip().trim())){
						if(reportColumnBean.getColumnFormat()== TabularReportConstants.DECODE_FORMATTING){
							toolTip=URLDecoder.decode(rsw.getString(reportColumnBean.getTooltip()),"UTF-8");
						}else{
							toolTip = rsw.getString(reportColumnBean.getTooltip());
						}							
					}
					String data=null;
					data=TabularReportGenerator.getFormattedColumn(reportColumnBean.getColumnFormat(), reportColumnBean.getDbColumnName(), rsw);
					out.append("\'");
					if(!"".equals(href.trim())) {						
						out.append(href + data + "</a>");
					} else {
						out.append(data);						
					}
					out.append("||"+aligement+"||"+toolTip+"||"+url+"\',");
				}
				out.append("],");
			}
			out.append("]");
			CyberoamLogger.appLog.debug(out.toString());
		} catch(Exception e){
			CyberoamLogger.appLog.debug("TabularReportGenerator.getBody.e e" +e,e);
		}
		return out.toString();
	}
	
	/**
	 * This method is used to get table which can be displayed on screen for report.
	 * This method can handle dashboard report in different manner.
	 * @param request
	 * @param rsw
	 * @param isDashReport
	 * @return
	 */
	public static String getBody(HttpServletRequest request,ResultSetWrapper rsw,boolean isDashReport){
		StringBuffer out=new StringBuffer();
		HttpSession session=request.getSession();
		try{
			if(isDashReport == true){ 
				String strUserName = (String)session.getAttribute("username");
				UserBean userBean = UserBean.getRecordbyPrimarykey(strUserName);
				int count = 0;
				count=DeviceBean.getDeviceBeanMap().size();
				int maxRow=1 , maxCol=1;
				String[][] recordStr = new String[2500][7];
				ReportColumnBean reportColumnBean = null;
				DataLinkBean dataLinkBean = null;
				ArrayList reportColumnsMap = ReportColumnBean.getReportColumnsByReportID(Integer.parseInt(request.getParameter("reportid")));					
				rsw.beforeFirst();
				if(!rsw.next()){
					out.append("[[\'No Column Available||3 \'],[\' No Data Available||3 \'],]");				
				}else{
					rsw.beforeFirst();
				    recordStr[0][0]="Device";
					while(rsw.next()){
						String toolTip = "";
						int aligement = 0;
						String href = "";	
						String url = "";
						reportColumnBean = (ReportColumnBean) reportColumnsMap.get(0);
						aligement = reportColumnBean.getAlignment();
						if(reportColumnBean.getTooltip() != null && !"".equals(reportColumnBean.getTooltip().trim())){
							if(reportColumnBean.getColumnFormat()== TabularReportConstants.DECODE_FORMATTING){
								toolTip=URLDecoder.decode(rsw.getString(reportColumnBean.getTooltip()),"UTF-8");
							}else{			
								toolTip = rsw.getString(reportColumnBean.getTooltip());
							}
						}
						if(reportColumnBean.getDataLinkId() != -1){
							dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
							url = dataLinkBean.generateURL(rsw, request);
							url = url.replace("&","&emp;");
						}
						String data=rsw.getString(reportColumnBean.getDbColumnName());
						if(data == null || data.equalsIgnoreCase("null") || data.equalsIgnoreCase("")) {
							data="N/A";
						}						
						data = data + "||"+aligement+"||"+toolTip+"||"+url;
						int i=1;
						for(;i<maxRow;i++){
							if(recordStr[i][0].equals(data))
								break;
						}
						if(maxRow == i){
							recordStr[maxRow][0] = data;
							maxRow++;
						}
						if(maxCol < 7){
							reportColumnBean = (ReportColumnBean) reportColumnsMap.get(2);
							//data=rsw.getString(reportColumnBean.getDbColumnName());
							data=TabularReportGenerator.getFormattedColumn(reportColumnBean.getColumnFormat(), reportColumnBean.getDbColumnName(), rsw);
							if(data == null || data.equalsIgnoreCase("null") || data.equalsIgnoreCase("")){
								data="N/A";
							}
							aligement = reportColumnBean.getAlignment();
							data = data + "||3|| || ";
							i=1;
							for(;i<maxCol;i++){
								if(recordStr[0][i].equals(data))
									break;
							}
							if(maxCol == i){
								recordStr[0][maxCol] = data;
								maxCol++;
							}
						}
					}
					rsw.beforeFirst();
					while(rsw.next()){
						String toolTip = "";
						int aligement = 0;
						String href = "";	
						String url = "";
						reportColumnBean = (ReportColumnBean) reportColumnsMap.get(0);
						aligement = reportColumnBean.getAlignment();
						if(reportColumnBean.getTooltip() != null && !"".equals(reportColumnBean.getTooltip().trim())){
							if(reportColumnBean.getColumnFormat()== TabularReportConstants.DECODE_FORMATTING){
								toolTip=URLDecoder.decode(rsw.getString(reportColumnBean.getTooltip()),"UTF-8");
							}else{
								toolTip = rsw.getString(reportColumnBean.getTooltip());
							}
						}
						if(reportColumnBean.getDataLinkId() != -1){
							dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
							url = dataLinkBean.generateURL(rsw, request);
							url = url.replace("&","&emp;");
						}
						String device=rsw.getString(reportColumnBean.getDbColumnName());
						if(device == null || device.equalsIgnoreCase("null") || device.equalsIgnoreCase(""))
							device="UNKNOWN";
						device = device + "||"+aligement+"||"+toolTip+"||"+url;
						int i,j;
						for(i=1;i<maxRow;i++){
							if(recordStr[i][0].equals(device))
								break;
						}
						reportColumnBean = (ReportColumnBean) reportColumnsMap.get(2);
						String protocol = TabularReportGenerator.getFormattedColumn(reportColumnBean.getColumnFormat(), reportColumnBean.getDbColumnName(), rsw);
						if(protocol == null || protocol.equalsIgnoreCase("null") || protocol.equalsIgnoreCase(""))
							protocol="UNKNOWN";
						aligement = reportColumnBean.getAlignment();
						protocol = protocol + "||3|| || ";
						for(j=1;j<maxCol;j++){
							if(recordStr[0][j].equals(protocol))
								break;
						}
						if(i!=maxRow && j!=maxCol){
							
							url="";
							toolTip="";
							reportColumnBean = (ReportColumnBean) reportColumnsMap.get(1);
							String bytes = null;
							aligement = reportColumnBean.getAlignment();
							bytes=TabularReportGenerator.getFormattedColumn(reportColumnBean.getColumnFormat(), reportColumnBean.getDbColumnName(), rsw);
							recordStr[i][j] = bytes+ "||"+aligement+"||"+toolTip+"||"+url;
						}
					}
					out.append("[");
					for(int i=0;i<maxRow;i++){
						out.append("[");
						for(int j=0;j<maxCol;j++){
								if(recordStr[i][j] == null)
								recordStr[i][j] = " ";
							out.append("\'"+recordStr[i][j]+"\',");
						}
						out.append("],");
					}
					out.append("]");					
				}
			}else{
				out.append(getBody(request,rsw));
			}
			CyberoamLogger.appLog.debug(out.toString());
		} catch(Exception e){
			CyberoamLogger.appLog.debug("TabularReportGenerator.process.e e" +e,e);
		}
		return out.toString();
	}
	
	/**
	 * This method is used to get data for table in report through AJAX requests.
	 * Because of AJAX requests, here XML string will be generated.
	 * @param request
	 * @param rsw
	 * @return
	 */
	public static String getAjaxBody(HttpServletRequest request,ResultSetWrapper rsw){
		StringBuffer out=new StringBuffer();
		try{
			
			ReportColumnBean reportColumnBean = null;
			DataLinkBean dataLinkBean = null;
			ReportBean reportBean = null;
			if(request.getParameter("reportid")!=null && !"".equals(request.getParameter("reportid").trim())) {
				reportBean = ReportBean.getRecordbyPrimarykey(request.getParameter("reportid"));	    
			} 
			ArrayList reportColumnsMap = ReportColumnBean.getReportColumnsByReportID(Integer.parseInt(request.getParameter("reportid")));					
			out.append("<data><row>");
			for(int i=0;i<reportColumnsMap.size();i++){				
				reportColumnBean = (ReportColumnBean) reportColumnsMap.get(i);
				out.append("<cel issearchable=\""+ reportColumnBean.getIsSearchable() +"\" dataformat=\""+reportColumnBean.getColumnFormat() +"\" >");
				out.append(reportColumnBean.getColumnName()    +"||"+reportColumnBean.getAlignment());
					
				if(request.getParameter("ordertype") == null && request.getParameter("orderby") == null){
					if(reportBean.getDefaultColumnForSort().equalsIgnoreCase(reportColumnBean.getDbColumnName()))
						out.append("||1||"  + reportColumnBean.getDbColumnName()) ;
					else
						out.append("||0||"  + reportColumnBean.getDbColumnName()) ;
				}else if(!reportColumnBean.getDbColumnName().equalsIgnoreCase(request.getParameter("orderby")))
					out.append("||0||"  + reportColumnBean.getDbColumnName()) ;
				else if("asc".equalsIgnoreCase(request.getParameter("ordertype")) && reportColumnBean.getDbColumnName().equalsIgnoreCase(request.getParameter("orderby")))
					out.append("||1||"  + reportColumnBean.getDbColumnName());
				else if("desc".equalsIgnoreCase(request.getParameter("ordertype")) && reportColumnBean.getDbColumnName().equalsIgnoreCase(request.getParameter("orderby")))
					out.append("||2||"  + reportColumnBean.getDbColumnName());
				out.append("</cel>");
				
			}
			out.append("</row>");
		
			rsw.beforeFirst();
			while (rsw.next()) {
				
				out.append("<row>");
				
				for(int i=0;i<reportColumnsMap.size();i++){
					String toolTip = "";
					int aligement = 0;
					String href = "";	
					String url="";
					reportColumnBean = (ReportColumnBean) reportColumnsMap.get(i);
					
					if(reportColumnBean.getDataLinkId() != -1){
						dataLinkBean = DataLinkBean.getRecordbyPrimarykey(reportColumnBean.getDataLinkId());
						url = dataLinkBean.generateURL(rsw, request);
						url = url.replace("&","&emp;");
					}
					
					aligement = reportColumnBean.getAlignment();
					if(reportColumnBean.getTooltip() != null && !"".equals(reportColumnBean.getTooltip().trim())){
						if(reportColumnBean.getColumnFormat()== TabularReportConstants.DECODE_FORMATTING){
							toolTip=URLDecoder.decode(rsw.getString(reportColumnBean.getTooltip()),"UTF-8");
						}else{
							toolTip = rsw.getString(reportColumnBean.getTooltip());
						}
					}
					
					String data=TabularReportGenerator.getFormattedColumn(reportColumnBean.getColumnFormat(), reportColumnBean.getDbColumnName(), rsw);
					out.append("<cel>"+parseXMLToString(data+"||"+aligement+"||"+toolTip+"||"+url)+"</cel>");
				}  
				out.append("</row>");
			}
			out.append("</data>");
		} catch(Exception e){
			CyberoamLogger.appLog.debug("TabularReportGenerator.process.e e" +e,e);
		}
		return out.toString();
	}
	
	/**
	 * This method is used to parse XML string.
	 * This is required to handle special characters into XML string.
	 * @param paramValue
	 * @return
	 */
	public static String parseXMLToString(String paramValue){
		try{
			paramValue = paramValue.replace("&","&amp;");
			paramValue = paramValue.replace("<","&lt;");
			paramValue = paramValue.replace(">","&gt;");
			
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->parseParamValue()->GenerateXML : " + e);
		}
		return paramValue;
	}
	/**
	 *	This Method Formats the Content of Byte Column based on its Content 
	 *  @param columnFormat 
	 *  @param columnName
	 *  @param rsw
	 *  @return
	 */
	
	public static String getFormattedColumn(int columnFormat,String columnName,ResultSetWrapper rsw){
		String data=null;
		try {
			switch(columnFormat) {
				case TabularReportConstants.BYTE_FORMATTING:
					data=ByteInUnit.getBytesInUnit(rsw.getLong(columnName));
					break;
				case TabularReportConstants.PERCENTAGE_FORMATTING:
					data=rsw.getString(columnName) + " %"; 
					break;
				case TabularReportConstants.DECODE_FORMATTING:
					data=URLDecoder.decode(rsw.getString(columnName),"UTF-8");
					break;
				case TabularReportConstants.PROTOCOL_FORMATTING:
					int index=rsw.getString(columnName).indexOf(':');
					if(index!=-1) {					
						data=ProtocolBean.getProtocolNameById(Integer.parseInt(rsw.getString(columnName).substring(0, index)));
						data=data+rsw.getString(columnName).substring(index,rsw.getString(columnName).length());
					} else {
						data=rsw.getString(columnName);		
					}
					break;
				case TabularReportConstants.SEVERITY_FORMATTING:
					data=TabularReportConstants.getSeverity(rsw.getString(columnName));
					break;				
				case TabularReportConstants.ACTION_FORMATTING:
					data=TabularReportConstants.getAction(rsw.getString(columnName));
					break;
				default:					
					data=rsw.getString(columnName);
			} 			
		}catch(Exception e){
			CyberoamLogger.appLog.debug("TabularReportGenerator.process.formatting.e e" +e,e);
		}
		if(data == null || data.equalsIgnoreCase("null") || data.equalsIgnoreCase(""))
			data="N/A";
		return data;
	}
}
