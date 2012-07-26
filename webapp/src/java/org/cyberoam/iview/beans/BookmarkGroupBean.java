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

package org.cyberoam.iview.beans;

import java.util.Iterator;
import java.util.LinkedHashMap;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This bean handle all Bookmark Group information.
 * bookmarkgroup will be We stored in table named tblbookmarkgroup.
 * @author Darshan Shah
 */

public class BookmarkGroupBean {
	private int bookmarkGroupID;
	private String name;
	private static LinkedHashMap bookmarkGroupMap;
	
	/**
	 * Returns bookmarkGroupID.
	 * @return
	 */
	public int getBookmarkGroupID() {
		return bookmarkGroupID;
	}
	
	/**
	 * Sets Bookmark Group ID.
	 * @param bookmarkGroupID
	 */
	public void setBookmarkGroupID(int bookmarkGroupID) {
		this.bookmarkGroupID = bookmarkGroupID;
	}
	
	/**
	 * Returns name.
	 * @return
	 */
	public String getName() {
		return name;
	}
	/**
	 * Sets Bookmark Group Name.
	 * @param name
	 */

	public void setName(String name){
		this.name=name;
	}
	
	/**
	 * Sets New Bookmark Group in Map.
	 * @param bookmarkGroupBean
	 */

	public void setBookmarkGroupMap(BookmarkGroupBean bookmarkGroupBean){
		bookmarkGroupMap.put(bookmarkGroupBean.getBookmarkGroupID(),bookmarkGroupBean);
	}
	
	
	static{
		loadAll();
	}
	
	public static synchronized boolean loadAll(){
		 
		 SqlReader sqlReader = null;
		 String strQuery=null;
		 ResultSetWrapper rsw=null;
		 boolean retStatus = false;
		 bookmarkGroupMap=new LinkedHashMap();
		 BookmarkGroupBean bookmarkGroupBean=new BookmarkGroupBean();
		 try{
			 strQuery="select * from tblbookmarkgroup";
			 rsw=sqlReader.getResultSetWrapper(strQuery);
			 while(rsw.next()){
				 bookmarkGroupBean=BookmarkGroupBean.getResultSetByWrapper(rsw);
				 bookmarkGroupMap.put(bookmarkGroupBean.getBookmarkGroupID(),bookmarkGroupBean);
			 }
			 retStatus=true;
		 }
		 catch(Exception e){
		 }
		 finally{
	            try{
	            	rsw.close();
	                sqlReader.close();
	            }catch(Exception e){
	            	CyberoamLogger.repLog.error("Got an exception in bookmarkGroupBean loadAll " + e,e);
	            }
	        }
		 return retStatus;
		
	}
	
	 public int insertRecord(){ 
	        CyberoamLogger.repLog.debug("insert Bookmark Group called ...");
	        String insert = null;
	        int insertValue=-1;
	        SqlReader sqlReader = null;
	        try{
	            sqlReader = new SqlReader(false);	            
	            insert ="insert into tblbookmarkgroup "+
	            "(name) values"+ 
	            "("+StringMaker.makeString(name)+")";
	            insertValue = sqlReader.executeInsertWithLastid(insert,"bookmarkgroupid");
	            CyberoamLogger.repLog.info("ID after insert : "+insertValue);
	            if(insertValue>=0){ 	
	            	this.setBookmarkGroupID(insertValue);
	            	if(bookmarkGroupMap==null){
	            		loadAll();
	            	}
	            	bookmarkGroupMap.put(insertValue, this);
	            }
	        }catch(Exception e){
	            CyberoamLogger.repLog.error("Got an exception while inserting record " + this + e,e);
	            insertValue = -1;
	        }finally{
	            try{
	                sqlReader.close();
	            }catch(Exception e){}
	        }
	        return insertValue;
	    }
	 
	 public int deleteRecord(int bookmarkgroupid)
	 {
		 int status=0;
		 SqlReader sqlReader=null;
		 String strQuery=null;
		 Iterator mailScheduleIterator=null;
		 Iterator bookmarkIterator=null;
		 BookmarkBean bookmarkBean=null;
		 
		 MailScheduleBean mailScheduleBean=null;
		 boolean isrelation=false;
		 try{
			 bookmarkIterator=BookmarkBean.getIterator();
			 mailScheduleIterator=MailScheduleBean.getIterator(); 
			 while(bookmarkIterator.hasNext()){
				 bookmarkBean=(BookmarkBean)bookmarkIterator.next();
				 if(bookmarkBean.getGroupId()==bookmarkgroupid){
					 while(mailScheduleIterator.hasNext()){
						 mailScheduleBean=(MailScheduleBean)mailScheduleIterator.next();
						 if(bookmarkBean.getBookmarkId()==mailScheduleBean.getReportGroupID()){
							 	isrelation=true;
						 }
					 }
					 if(isrelation){
						 break;
					 }
				 }
			 }
			 if(!isrelation){
			 sqlReader = new SqlReader(false);
			 strQuery="delete from tblbookmarkgroup where bookmarkgroupid="+bookmarkgroupid+"";
			 status=sqlReader.executeUpdate(strQuery, 5);
			 }
			 else{
				 status=-2;
			 }
			 if(status>0){
				 bookmarkGroupMap.remove(bookmarkgroupid);
				 BookmarkBean.removeFromCache(bookmarkgroupid);
			 }
			 
		 }	
		 catch(Exception e){
			 CyberoamLogger.repLog.error("Got an exception while deleting record " + this + e,e);
		 }
		 return status;
	 }
	 public static BookmarkGroupBean getRecordbyPrimarykey(int primarykey) {        
	    	BookmarkGroupBean bookmarkGroupBean=null;
	        try {
	        	   if(bookmarkGroupMap==null) {
	               	loadAll();
	               }
	        	   bookmarkGroupBean=(BookmarkGroupBean)bookmarkGroupMap.get(new Integer(primarykey));
	        	           	
	        }catch(Exception e) {
	        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->BookmarkGroupBean: " + e,e);
	        }
	        return bookmarkGroupBean;
	    }
	 
	 public static LinkedHashMap getRecord(){
		 
		 if(bookmarkGroupMap==null){
			 loadAll();
		 }
		 return bookmarkGroupMap;
	 }
	 
    public static BookmarkGroupBean getResultSetByWrapper(ResultSetWrapper rsw){
    	BookmarkGroupBean bookmarkGroupBean=new BookmarkGroupBean();
    	try{
    		bookmarkGroupBean.setBookmarkGroupID(rsw.getInt("bookmarkgroupid"));
    		bookmarkGroupBean.setName(rsw.getString("name"));
    	}
    	catch(Exception e){
    		CyberoamLogger.repLog.error("Exception->getResultSetByWrapper()->BookmarkGroupBean: " + e,e);
    	}
    	return bookmarkGroupBean;
    }
}
