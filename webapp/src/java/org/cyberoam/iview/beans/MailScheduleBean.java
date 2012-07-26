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

/**
 * 
 */
package org.cyberoam.iview.beans;


import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;

/**
 * This class represents mail schedule (Report Notification) entity.
 * @author Narendra Shah
 *
 */
public class MailScheduleBean {
	private int mailScheduleID;
	private String scheduleName;
	private String description;
	private int reportGroupID;
	private int day;
	private int hours;
	private int schedulefor;
	private int fromhour;
	private int tohour;
	private int scheduletype;
	private String expectedDate;
	
	public static final int DAILY=1;
	public static final int WEEKLY=2;
	public static final int MONTHLY=3;
	public static final int ONLY_ONCE=4;
	
	public static final int PREVIOUS_DAY=1;
	public static final int SAME_DAY=2;
	public static final int LAST_WEEK=3;
	public static final int LAST_MONTH=4;
	
	/**
	 * returns the value of scheduletype
	 * 1 for daily
	 * 2 for weekly
	 * 3 for monthly
	 * 4 for only once
	 * @return
	 */
	public int getScheduletype() {
		return scheduletype;
	}
	
	public String getExpectedDate() {
		return expectedDate;
	}

	public void setExpectedDate(String expectedDate) {
		this.expectedDate = expectedDate;
	}

	/**
	 * sets the value of scheduel type 
	 * 1 for daily
	 * 2 for weekly
	 * 3 for monthly
	 * 4 for only once
	 * @param scheduletype
	 */
	public void setScheduletype(int scheduletype) {
		this.scheduletype = scheduletype;
	}
	/**
	 * returns the schedule value of report
	 * 1 for previous day
	 * 2 for same day
	 * 3 for last 7 days
	 * 4 for last 30 days
	 * @return
	 */
	public int getSchedulefor() {
		return schedulefor;
	}
	/**
	 * sets the value of schedule the is 
	 * 1 for previous day
	 * 2 for same day
	 * 3 for last 7 days
	 * 4 for last 30 days
	 * @param schedulefor
	 */
	public void setSchedulefor(int schedulefor) {
		this.schedulefor = schedulefor;
	}
	/**
	 * returns the end hour value to generate the report 
	 * @return 
	 */
	public int getFromhour() {
		return fromhour;
	}
	/**
	 * sets the starting hours from 
	 * which the report is to be generated 
	 * @param fromhour
	 */
	public void setFromhour(int fromhour) {
		this.fromhour = fromhour;
	}
	/**
	 * returns the value of end duration to generate the report
	 * @return
	 */
	public int getTohour() {
		return tohour;
	}
	/**
	 * sets the end time to generate the report
	 * @param tohour
	 */
	public void setTohour(int tohour) {
		this.tohour = tohour;
	}
	private String toaddress;
	private int deviceID[];
	private String lastsendtime;
	private boolean isBookmark;
	private static TreeMap mailScheduleBeanMap =null;
	
	static {
		loadAll();
	}
	/**
	 * Loads data from tblmailschedule to iView Cache.
	 */
	public static void loadAll(){
		SqlReader sqlReader=null;
		ResultSetWrapper rsw=null;
		mailScheduleBeanMap=new TreeMap();
		MailScheduleBean mailScheduleBean=null;
		try {
			sqlReader=new SqlReader();
			rsw=sqlReader.getInstanceResultSetWrapper("select * from tblmailschedule");
			while(rsw.next()){
				mailScheduleBean=MailScheduleBean.getBeanByResultSetWrapper(rsw);
				mailScheduleBeanMap.put(mailScheduleBean.getMailScheduleID(),mailScheduleBean );
			}				
		}catch (Exception e) {
			CyberoamLogger.sysLog.debug("MailScheduleBean.e:" +e, e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * This method will convert current {@link ResultSetWrapper} instance to MailScheduleBean instance.  
	 * @param rsw specifies Result set wrapper which is not empty.
	 * @return
	 */
	public static MailScheduleBean getBeanByResultSetWrapper(ResultSetWrapper rsw)throws SQLException  {
		MailScheduleBean mailScheduleBean=new MailScheduleBean();
		mailScheduleBean.setMailScheduleID(rsw.getInt("mailscheduleid"));
		mailScheduleBean.setScheduleName(rsw.getString("schedulename"));
		mailScheduleBean.setDescription(rsw.getString("descr"));
		mailScheduleBean.setReportGroupID(rsw.getInt("reportgroupid"));
		mailScheduleBean.setToaddress(rsw.getString("toaddress"));
		mailScheduleBean.setDay(rsw.getInt("day"));
		mailScheduleBean.setHours(rsw.getInt("hours"));
		mailScheduleBean.setDeviceID(rsw.getString("deviceid"));
		mailScheduleBean.setLastsendtime(rsw.getString("lastsendtime"));
		mailScheduleBean.setSchedulefor(rsw.getInt("schedulefor"));
		mailScheduleBean.setFromhour(rsw.getInt("fromhour"));
		mailScheduleBean.setTohour(rsw.getInt("tohour"));
		mailScheduleBean.setScheduletype(rsw.getInt("scheduletype"));
		mailScheduleBean.setExpectedDate(rsw.getString("expdate"));
		mailScheduleBean.setIsBookamrk(rsw.getBoolean("isbookmark"));
		return mailScheduleBean;
	}
	/**
	 * This method returns the cached bean for given mailScheduleID.
	 */
	public static MailScheduleBean getRecordByPrimaryKey(int mailScheduleID){
		return (MailScheduleBean)mailScheduleBeanMap.get(mailScheduleID);
	}
	/**
	 * This method will return value iterator for all mail schedules.
	 * @return Iterator specifies the value iterator for all mail schedule. It contains all mail schedule.
	 */
	public static Iterator getIterator(){
		CyberoamLogger.sysLog.debug("mailschedule size:" + mailScheduleBeanMap.size());
		return mailScheduleBeanMap.values().iterator();
	}
	/**
	* This method is used to insert mail schedule information into tblmailschedule.
	*/
	public int insertRecord(){
        String insert = null;
        int insertValue=-1;
        SqlReader sqlReader = null;
        try{
            sqlReader = new SqlReader(false);
            insertValue = checkForDuplicate();
            if(insertValue != -4) {
	            insert ="insert into tblmailschedule "+
	            "(schedulename, descr, reportgroupid , day , hours , toaddress , lastsendtime, deviceid, schedulefor, fromhour, tohour, scheduletype, expdate,isbookmark) values ("+ 
	             StringMaker.makeString(getScheduleName()) + "," +
	             StringMaker.makeString(getDescription()) + "," +
	             reportGroupID + "," +
	             day + ","  + 
	             hours+ "," + 
	             StringMaker.makeString(toaddress) + "," + 
	             StringMaker.makeString(lastsendtime) + "," +
	             StringMaker.makeString(getDeviceIDInString()) +
	             "," + getSchedulefor() +
	             "," + getFromhour() + 
	             "," + getTohour() + 
	             "," + getScheduletype() +
	             "," + StringMaker.makeString(getExpectedDate())+
	             "," + isBookmark 
	             + ")";
	            
	             
	            
	            insertValue = sqlReader.executeInsertWithLastid(insert,"mailscheduleid");
				if (insertValue > 0){
					setMailScheduleID(insertValue);
					if (mailScheduleBeanMap != null ){
					
						mailScheduleBeanMap.put(getMailScheduleID(),this);
					}else{
						
						MailScheduleBean.loadAll();
					}
				}
            }
        }catch(Exception e){
            CyberoamLogger.sysLog.error("MailScheduleBean.e:" + e,e);
            insertValue = -1;
        }finally{
            try{
                sqlReader.close();
            }catch(Exception e){}
        }
        return insertValue;
    }
    /**
     * This method is used to update mail schedule record in database as well as cache. 
     */
    public int updateRecord(){
        int updateValue=-1;
        String update = null;
        SqlReader sqlReader = null;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try{
            sqlReader = new SqlReader(false);
            update = "update tblmailschedule "+
            "set reportgroupid = "+reportGroupID+","+
            "day = "+getDay() +","+
            "hours = " + getHours()+ "," +
            "toaddress = " + StringMaker.makeString(getToaddress()) + "," + 
            "schedulename = " + StringMaker.makeString(getScheduleName()) + "," +
            "descr = " + StringMaker.makeString(getDescription()) + "," +
            "lastsendtime = " + StringMaker.makeString(getLastsendtime()) + "," +
            "deviceid = " + StringMaker.makeString(getDeviceIDInString())  + "," +
            "schedulefor = " + getSchedulefor() + "," +
            "fromhour = " + getFromhour() + "," +
            "tohour = " + getTohour() + "," +
            "scheduletype = " + getScheduletype() + "," +
            "expdate = " + StringMaker.makeString(getExpectedDate()) + "," +  
            "isbookmark=" + isBookmark + 
            " where mailscheduleid="+ getMailScheduleID();
            updateValue=sqlReader.executeUpdate(update,5);
			if (updateValue > 0){
				if (mailScheduleBeanMap != null ){
					mailScheduleBeanMap.put(getMailScheduleID(),this);
				}else {
					loadAll();
				}
			}
        }catch(Exception e){
            CyberoamLogger.sysLog.error("Exception in updating record: " + e,e);
            updateValue = -1;
        }finally{
            try{
                sqlReader.close();
            }catch(Exception e){
            }
        }
        return updateValue;
    }
    /**
     * This method is used to delete mail schedule record and also iView cache.
     */
	public int deleteRecord(){
		SqlReader sqlReader = null;
		int deleteValue = -1;
		try{
			sqlReader = new SqlReader(false);
			String deleteQuery = null;
			deleteQuery = "DELETE from tblmailschedule "+
						"WHERE mailscheduleid ="+ getMailScheduleID();
			
			deleteValue=sqlReader.executeUpdate( deleteQuery,5);
			if (deleteValue >= 0){
				if(mailScheduleBeanMap != null){
					mailScheduleBeanMap.remove(getMailScheduleID());
				}else{
					loadAll();
				}
			}
		}catch(Exception e){
			CyberoamLogger.sysLog.error("Exception in deleting from memory in liveuserbean " +e,e);
			deleteValue = -1;			
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){}
		}
		return deleteValue;
	}
	/**
	 * this method is used to delete the records of only once shcedule
	 * whose id are in CSV formate
	 * @param mailScheduleIds
	 */
	public static void deleteOnlyOnceRecord(String mailScheduleIds){
		SqlReader sqlReader = null;
		int deleteValue = -1;
		try{
			sqlReader = new SqlReader(false);
			String deleteQuery = null;
			deleteQuery = "DELETE from tblmailschedule "+
						"WHERE mailscheduleid IN("+ mailScheduleIds + ")";
			deleteValue=sqlReader.executeUpdate( deleteQuery,5);
			if (deleteValue >= 0){
				if(mailScheduleBeanMap != null){
					for(String id : mailScheduleIds.split(",")){
					mailScheduleBeanMap.remove(Integer.parseInt(id));
					}
				}else{
					loadAll();
				}
			}
		}catch(Exception e){
			CyberoamLogger.sysLog.error("Exception in deleting from memory in liveuserbean " +e,e);
			deleteValue = -1;			
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){}
		}
	}
	/**
	 * This method is used to delete multiple mail schedules from database table.
	 * <br>List of comma separated schedule Ids will be passed to this method. 
	 * @return the number of mailSchedules deleted
	 */
	public static int deleteAllRecord(String strSchedules){
		SqlReader sqlReader = null;
		int deleteValue = -1;
		try{
			sqlReader = new SqlReader(false);
			String deleteQuery = null;
			deleteQuery = "DELETE from tblmailschedule "+
						"WHERE mailscheduleid in ("+ strSchedules +")";
			
			deleteValue=sqlReader.executeUpdate( deleteQuery,5);
			if (deleteValue >= 0) {
				String profileList[] = strSchedules.split(",");
				for(int i=0;i<profileList.length;i++){
					mailScheduleBeanMap.remove(new Integer(profileList[i]));
				}
			}
		}catch(Exception e){
			CyberoamLogger.sysLog.error("Exception in deleting from memory in liveuserbean " +e,e);
			deleteValue = -1;			
		}finally{
			try{
				sqlReader.close();
			}catch(Exception e){}
		}
		return deleteValue;
	}
	/**
	 * Returns mail schedule Id.
	 * @return the mailScheduleID
	 */
	public int getMailScheduleID() {
		return mailScheduleID;
	}
	/**
	 * Sets mail schedule Id.
	 * @param mailScheduleID the mailScheduleID to set
	 */
	public void setMailScheduleID(int mailScheduleID) {
		this.mailScheduleID = mailScheduleID;
	}
	/**
	 * Returns report group Id related to mail schedule.
	 * @return the reportGroupID
	 */
	public int getReportGroupID() {
		return reportGroupID;
	}
	/**
	 * Sets report group Id related to mail schedule.
	 * @param reportGroupID the reportGroupID to set
	 */
	public void setReportGroupID(int reportGroupID) {
		this.reportGroupID = reportGroupID;
	}
	/**
	 * Returns day on which mail will be scheduled.
	 * <br>-1 is used for weekly schedule and in case of daily schedule 1 for sunday, 2 for monday and so on. 
	 * @return the day
	 */
	public int getDay() {
		return day;
	}
	/**
	 * Sets day on which mail is to be scheduled.
	 * <br>1 for sunday, 2 for monday and so on.and date form 1 to 30 or 31.
	 * @param day the day to set
	 */
	public void setDay(int day) {
		this.day = day;
	}
	/**
	 * Returns the hour at which mail will be scheduled.
	 * Here hour will be in the range of 00 to 23.
	 * @return the hours
	 */
	public int getHours() {
		return hours;
	}
	/**
	 * Sets the hour at which mail will be scheduled.
	 * Here hour will be in the range of 00 to 23.
	 * @param hours the hours to set
	 */
	public void setHours(int hours) {
		this.hours = hours;
	}
	/**
	 * Returns email address at which mail will be sent.
	 * @return the toaddress
	 */
	public String getToaddress() {
		return toaddress;
	}
	/**
	 * Sets email address at which mail will be sent.
	 * @param toaddress the toaddress to set
	 */
	public void setToaddress(String toaddress) {
		this.toaddress = toaddress;
	}
	/**
	 * Returns last sent date and time on which mail was sent.
	 * <br>Here format of date and time will be yyyy-mm-dd hh:mm:ss.
	 * @return the lastsendtime
	 */
	public String getLastsendtime() {
		return lastsendtime;
	}
	/**
	 * Sets last sent date and time on which mail was sent.
	 * <br>Here format of date and time should be yyyy-mm-dd hh:mm:ss.
	 * @param lastsendtime the lastsendtime to set
	 */
	public void setLastsendtime(String lastsendtime) {
		this.lastsendtime = lastsendtime;
	}
	/**
	 * Returns name of mail schedule.
	 * @return the scheduleName
	 */
	public String getScheduleName() {
		return scheduleName;
	}
	/**
	 * Sets name of mail schedule.
	 * @param scheduleName the scheduleName to set
	 */
	public void setScheduleName(String scheduleName) {
		this.scheduleName = scheduleName;
	}
	/**
	 * Returns description about mail schedule.
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * Sets description about mail schedule.
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * Returns array of integer containing device Ids.
	 * @return the deviceID
	 */
	public int[] getDeviceID() {
		return deviceID;
	}
	/**
	 * Sets array of integer containing device Ids.
	 * @param deviceID the deviceID to set
	 */
	public void setDeviceID(int[] deviceID) {
		this.deviceID = deviceID;
	}
	/**
	 * Returns bookkmark flag
	 * @return the isbookmark
	 */
	public boolean getIsBookmark() {
		return isBookmark;
	}
	/**
	 * Sets isBookmark flag
	 * @param isBookmark
	 */
	public void setIsBookamrk(boolean isBookmark) {
		this.isBookmark = isBookmark;
	}
	
	/**
	 * Returns comma separated string containing device Ids. 
	 * @return DeviceID in string
	 */
	public String getDeviceIDInString(){
		StringBuffer strDeviceID=new StringBuffer();
		for(int i=0;i<deviceID.length;){
			strDeviceID.append(deviceID[i]);
			i++;
			if(i != deviceID.length)  strDeviceID.append(",");
		}
		return strDeviceID.toString();
	}
	/**
	 * Converts comma separated string containing device Ids to array of integer.
	 * @param deviceID the deviceID to set
	 */
	public void setDeviceID(String deviceID) {
		StringTokenizer strToken=new StringTokenizer(deviceID,",");
		this.deviceID=new int[strToken.countTokens()];
		for(int i=0;strToken.hasMoreElements();i++){
			this.deviceID[i]=Integer.parseInt((String)strToken.nextElement());
		}
	}
	/**
	 * Returns comma separated list of appliance Ids related to appropriate device Ids.
	 * @return appliance with coma seperated values from deviceID
	 */
	public String getApplianceID(){
		StringBuffer strApplianceID=new StringBuffer();
		DeviceBean deviceBean=null;
		for(int i=0; i<(deviceID.length-1); i++){
			deviceBean=DeviceBean.getRecordbyPrimarykey(deviceID[i]);
			if(deviceBean != null)	strApplianceID.append("'" + deviceBean.getApplianceID() +"',");
		}
		deviceBean=DeviceBean.getRecordbyPrimarykey(deviceID[deviceID.length-1]);
		if(deviceBean != null)	strApplianceID.append("'" + deviceBean.getApplianceID() +"'");
		return strApplianceID.toString();
	}
	/**
	 * Returns comma separated list of device names related to appropriate device Ids.
	 * @return Device name from deviceID
	 */
	public String getDeviceName(){
		StringBuffer strDeviceName=new StringBuffer();
		DeviceBean deviceBean=null;
		for(int i=0;i<deviceID.length;){
			deviceBean=DeviceBean.getRecordbyPrimarykey(deviceID[i]);
			if(deviceBean != null) strDeviceName.append(deviceBean.getName()); 
			i++;
			if(i != deviceID.length) strDeviceName.append(",");
		}
		return strDeviceName.toString();
	}
	/**
	 * This method checks whether given device is related to any mail schedule or not.
	 * @return true if device is dependent else it returns false
	 */
	public static boolean isDeviceDependent(String deviceId){
		boolean returnValue = false;
		try{
		Iterator mailSchItr = mailScheduleBeanMap.values().iterator();
		MailScheduleBean mailScheduleBean = null;
		while((!returnValue) && mailSchItr.hasNext()){
			mailScheduleBean = (MailScheduleBean) mailSchItr.next();
			for(int i=0; (!returnValue) && i<mailScheduleBean.getDeviceID().length; i++){
				if(Integer.parseInt(deviceId) == mailScheduleBean.getDeviceID()[i]){
					returnValue = true;
				}
			}
		}
		}catch(Exception e){
			CyberoamLogger.appLog.debug("Exception->MailSchedulerBean->isDeviceDependent"+e,e);
		}
		CyberoamLogger.appLog.info("Exception->MailSchedulerBean->isDeviceDependent->returnValue" + returnValue);
		return returnValue;
	}
	/**
	 * This method checks for duplicate mail schedule based on given data into current bean.
	 * @return true or false 
	 */
	public int checkForDuplicate(){
		int returnStatus = -1;
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = null;
		String sqlQuery = null;
		try{
			sqlReader = new SqlReader(false);
			sqlQuery = "select count(*) as count from tblmailschedule where schedulename = " + StringMaker.makeString(this.getScheduleName());
			rsw = sqlReader.getInstanceResultSetWrapper(sqlQuery, 120);
			if (rsw.next() && rsw.getInt("count")>0){
				returnStatus = -4;
			}
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception->checkForDuplicate()->MailScheduleBean: " + e);
			return -4;
		}finally{
			try {
				rsw.close();
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		return returnStatus;
	}
/**
 * Loads data from tblmailschedule for given ReportIds
 */
public static String getMailScheduleForViews(String strReportGroupGList){
	SqlReader sqlReader=null;
	ResultSetWrapper rsw=null;
	String mailSchList="";
	try {
		sqlReader=new SqlReader();
		rsw=sqlReader.getInstanceResultSetWrapper("select mailscheduleid from tblmailschedule where reportgroupid in ("+strReportGroupGList+") ");
		while(rsw.next()){
			mailSchList += rsw.getString("mailscheduleid")+ ",";
		}
		mailSchList = mailSchList.substring(0,mailSchList.length()-1);
	}catch (Exception e) {
		CyberoamLogger.sysLog.debug("MailScheduleBean.e:" +e, e);
	}finally {
		try {
			rsw.close();
			sqlReader.close();
		} catch (Exception e) {
		}
	}
	return mailSchList;
 }
}