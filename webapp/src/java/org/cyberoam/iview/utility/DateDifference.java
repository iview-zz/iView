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

package org.cyberoam.iview.utility;


import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.cyberoam.iview.audit.CyberoamLogger;

/**
 * This utility class is used to calculate date difference.
 * @author Narendra Shah
 *
 */
public class DateDifference{
	/**
	 * Parameters used in this class.
	 */
	private static final int MSINSECOND = 1000;
	private static final int MSINMINUTE = 60000;//1000*60
	private static final int MSINHOUR = 3600000;//1000*60*60
	private static final int  MSINDAY = 86400000;//1000*60*60*24
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static SimpleDateFormat mysqlSmallDate = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat timeformat = new SimpleDateFormat("HH:mm:ss");
	private static SimpleDateFormat reportFormat = new SimpleDateFormat("dd/MM/yyyy");
	private static SimpleDateFormat longFromat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	private static SimpleDateFormat longDateFormat = new SimpleDateFormat("EEE d MMMM HH:mm:ss");
	private static SimpleDateFormat reportQueryDateFormat = new SimpleDateFormat("yyyy/MM/dd");
	/**
	 * Returns days difference between given start date and end date.
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static double getDaysDifference( Date startDate, Date endDate ){
		long startMS = startDate.getTime() ;
		long endMS = endDate.getTime( );
		long resultMS = startMS-endMS;
		double days = ( double )( resultMS / DateDifference.MSINDAY );
		return days;
	}
	/**
	 * Returns minutes difference between given start date and end date.
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static double getMinutesDifference(Date startDate,Date endDate){
		long startMS = startDate.getTime();
		long endMS = endDate.getTime();
		long resultMS = startMS-endMS;
		double minutes = (double)(resultMS / DateDifference.MSINMINUTE);
		return minutes;
	}
	/**
	 * Returns hours difference between given start date and end date.
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static double getHoursDifference(Date startDate,Date endDate){
		long startMS = startDate.getTime();
		long endMS = endDate.getTime();
		long resultMS = startMS - endMS;
		double hours = (double)(resultMS / DateDifference.MSINHOUR);
		return hours;
	}
	/**
	 * Converts given string to {@link Date} entity.
	 * Here string should contain date in "yyyy-MM-dd HH:mm:ss" format.
	 * @param dateString
	 * @return
	 */
	public static Date stringToDate(String dateString){
		Date date = null;
		if (dateString != null){
			sdf.setLenient(true);
			ParsePosition pos = new ParsePosition(0);
			date = sdf.parse(dateString, pos);
		}
		return date;
	}
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in "yyyy-MM-dd HH:mm:ss" format.
	 * @param dateString
	 * @return
	 */
	public static String dateToString(java.util.Date date){
		String dateString = null;
		if (date != null){
			dateString = sdf.format(date);
		}
		return dateString;
	}
	/**
	 * Converts given string to {@link Date} entity.
	 * Here string should contain date in "dd/MM/yyyy" format.
	 * @param dateString
	 * @return
	 */
	public static Date stringToDateSmallFormat(String dateString){
		Date date = null;
		if (dateString != null){
			reportFormat.setLenient(true);
			ParsePosition pos = new ParsePosition(0);
			date = reportFormat.parse(dateString, pos);
		}
		return date;
	}
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in "dd/MM/yyyy" format.
	 * @param date
	 * @return
	 */
	public static String dateToStringSmallFormat(java.util.Date date){
		String dateString = null;
		if (date != null){
			dateString = reportFormat.format(date);
		}
		return dateString;
	}	
	/**
	 * Converts given string to {@link Date} entity.
	 * Here string should contain date in "dd/MM/yyyy HH:mm:ss" format.
	 * @param dateString
	 * @return
	 */
	public static Date stringToDateLongFromat(String dateString){
		Date date = null;
		if (dateString != null){
			longFromat.setLenient(true);
			ParsePosition pos = new ParsePosition(0);
			date = longFromat.parse(dateString, pos);
		}
		return date;
	}
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in "dd/MM/yyyy HH:mm:ss" format.
	 * @param date
	 * @return
	 */
	public static String dateToStringLongFormat(java.util.Date date){
		String dateString = null;
		if (date != null){
			dateString = longFromat.format(date);
		}
		return dateString;
	}
	/**
	 * Converts given string to {@link Date} entity.
	 * Here string should contain date in "EEE d MMMM HH:mm:ss" format.
	 * @param dateString
	 * @return
	 */
	public static Date stringToDateLongDateFormat(String dateString){
		Date date = null;
		if (dateString != null){
			longDateFormat.setLenient(true);
			ParsePosition pos = new ParsePosition(0);
			date = longDateFormat.parse(dateString, pos);
		}
		return date;
	}
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in "EEE d MMMM HH:mm:ss" format.
	 * @param date
	 * @return
	 */
	public static String dateToStringLongDateFormat(java.util.Date date){
		String dateString = null;
		if (date != null){
			dateString = longDateFormat.format(date);
		}
		return dateString;
	}
	/**
	 * Converts given string to {@link Date} entity.
	 * Here string should contain date in mysql "yyyy-MM-dd" format.
	 * @param dateString
	 * @return
	 */
	public static Date stringToDateMysqlSmallFormat(String dateString){
		Date date = null;
		if (dateString != null){
			mysqlSmallDate.setLenient(true);
			ParsePosition pos = new ParsePosition(0);
			date = mysqlSmallDate.parse(dateString, pos);
		}
		return date;
	}
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in mysql "yyyy-MM-dd" format.
	 * @param date
	 * @return
	 */
	public static String dateToStringMysqlSmallFormat(java.util.Date date){
		String dateString = null;
		if (date != null){
			dateString = mysqlSmallDate.format(date);
		}
		return dateString;
	}	
	/**
	 * Converts given string to {@link Date} entity.
	 * Here string should contain date in "yyyy-MM-dd HH:mm:ss" format.
	 * @param dateString
	 * @return
	 */
	public static Date stringToDateMysqlLongFormat(String dateString){
		Date date = null;
		if (dateString != null){
			sdf.setLenient(true);
			ParsePosition pos = new ParsePosition(0);
			date = sdf.parse(dateString, pos);
		}
		return date;
	}
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in "yyyy-MM-dd HH:mm:ss" format.
	 * @param date
	 * @return
	 */
	public static String dateToStringMysqlLongFormat(java.util.Date date){
		String dateString = null;
		if (date != null){
			dateString = sdf.format(date);
		}
		return dateString;
	}
	/**
	 * Converts given string to {@link Date} entity.
	 * Here string should contain date in "HH:mm:ss" format.
	 * @param dateString
	 * @return
	 */
	public static Date stringToDateTimeFormat(String dateString){
		Date date = null;
		if (dateString != null){
			timeformat.setLenient(true);
			ParsePosition pos = new ParsePosition(0);
			date = timeformat.parse(dateString, pos);
		}
		return date;
	}
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in "HH:mm:ss" format.
	 * @param date
	 * @return
	 */
	public static String dateToTimeString(java.util.Date date){
		String dateString = null;
		if (date != null){
			dateString = timeformat.format(date);
		}
		return dateString;
	}
	/**
	 * Converts given string to {@link Date} entity with user specified format.
	 * @param dateString
	 * @param format
	 * @return
	 */
	public static Date stringToDate(String dateString,String format){
		Date date = null;
		if (dateString != null){
			SimpleDateFormat formatter = new SimpleDateFormat(format);
			formatter.setLenient(true);
			ParsePosition pos = new ParsePosition(0);
			date = formatter.parse(dateString, pos);
		}
		return date;
	}
	/**
	 * Converts given {@link Date} entity to string with user specified format.
	 * @param date
	 * @param format
	 * @return
	 */
	public static String dateToString(java.util.Date date, String format){
		String dateString = null;
		if (date != null){
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			dateString = sdf.format(date);
		}
		return dateString;
	}	
	/**
	 * Changes date format from "dd/MM/yyyy" format to "yyyy/MM/dd" format.
	 * @param str
	 * @return
	 */
	public static String changeStringFormat(String str){
		String retStr = null ;
		try{
			java.util.Date dt = stringToDate(str,"dd/MM/yyyy");
			retStr = dateToString(dt,"yyyy/MM/dd");
		}catch(Exception e){ 
			retStr = null ;
		}	
		return retStr ;
	}
	/**
	 * Changes date format from "dd/MM/yy" format to "MMM d,yyyy" format.
	 * @param date
	 * @return
	 */
	public static String getCalendarFormatString(String date){
		SimpleDateFormat sdf1 = new SimpleDateFormat("MMM d,yyyy");
		String calDateStr = null ;
		if(date != null){
			calDateStr = sdf1.format(DateDifference.stringToDate(date,"dd/MM/yy"));
		}
		return calDateStr ;
	}
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in "yyyy/MM/dd" format.
	 * @param date
	 * @return
	 */
	public static String getReportQueryDateFormat(java.util.Date date){
		String dateString = null;
		if (date != null){
			dateString = reportQueryDateFormat.format(date);
		}
		CyberoamLogger.appLog.debug("dateString formatted is "+ dateString);
		return dateString;
	}
	
	/**
	 * Converts given {@link Date} entity to string.
	 * Here string will be in "yyyyMMdd" format.
	 * @param date
	 * @return
	 */
	public static  String datetostring(GregorianCalendar gc){
		String strdate=null;	
			strdate=String.valueOf(gc.get(Calendar.YEAR));
			if((gc.get(Calendar.MONTH))+1<10){
				strdate=strdate+"0";
			}
			strdate=strdate+String.valueOf((gc.get(Calendar.MONTH))+1);
			if(gc.get(Calendar.DAY_OF_MONTH)<10){
				strdate=strdate+"0";
			}
			strdate=strdate+String.valueOf(gc.get(Calendar.DAY_OF_MONTH));
			
			return strdate;
		}
	
	/**
	 * Converts given {@link Date} long(unix timestamp) to date
	 * Here string will be in "yyyyMMdd" format.
	 * @param date
	 * @return
	 * @author hemant.agrawal
	 */
	
	public static String UnixToDateString(long timestamp) {
		try{	
			 Date date =new Date(timestamp*1000);			 			 
			 String dt=DateDifference.getReportQueryDateFormat(date);
			 return dt.replaceAll("/","");			 
			 
		}catch (Exception e) {
			CyberoamLogger.sysLog.debug("exception in UnixToDateString :"+e);
			e.printStackTrace();
			return null;
		}     		 
	}
}
