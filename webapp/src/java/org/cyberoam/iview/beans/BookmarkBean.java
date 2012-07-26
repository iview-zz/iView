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
import java.util.ArrayList;
import java.util.LinkedHashMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This bean handle all Bookmark information.
 * bookmark will be We stored in table named tblbookmark.
 * @author Darshan Shah
 */

public class BookmarkBean {
	private int categoryID;
	private int groupID;
	private String url;
	private String name;
	private String description;
	private int bookmarkId;
	private static LinkedHashMap bookmarkBeanMap;
	/**
	 * Returns bookmarkId.
	 * @return
	 */
	public int getBookmarkId() {
		return bookmarkId;
	}
	
	/**
	 * Sets Bookmark ID.
	 * @param bookmarkID
	 */
	public void setBookmarkId(int bookmarkId) {
		this.bookmarkId = bookmarkId;
	}
	
	
	/**
	 * Returns categoryID.
	 * @return
	 */
	public int getCategoryId() {
		return categoryID;
	}
	
	/**
	 * Sets category ID.
	 * @param categoryID
	 */
	public void setCategoryId(int categoryid) {
		this.categoryID = categoryid;
	}
	
	/**
	 * Returns Bookmark groupID
	 */
	public int getGroupId() {
		return groupID;
	}

	/**
	 * Sets Group Id.
	 * @param groupid
	 */
	public void setGroupId(int groupid) {
		this.groupID = groupid;
	}
	
	/**
	 * Returns url
	 */
	
	public String getUrl() {
		return url;
	}
	
	/**
	 * Sets Bookmark url.
	 * @param url
	 */
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	/**
	 * Returns Bookmark name
	 */ 
	
	public String getName() {
		return name;
	}
	
	/**
	 * Sets Bookmark name.
	 * @param name
	 */
	
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * Returns Bookmark description
	 */ 
	
	public String getDescription() {
		return description;
	}
	
	/**
	 * Sets Bookmark description.
	 * @param description
	 */
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public static Iterator getIterator(){
		return bookmarkBeanMap.values().iterator();
	}
	static{
		loadAll();
	}
	/**
	 * Load all instances of all bookmarks.  
	 * @return true on success else returns false
	 */
	public static synchronized boolean loadAll(){
		 boolean retStatus = false;
		 SqlReader sqlReader = null;
		 String strQuery=null;
		 ResultSetWrapper rsw=null;
		 BookmarkBean bookmarkBean=null;
		 bookmarkBeanMap=new LinkedHashMap();
		 try{
			 strQuery="select * from tblbookmark";
			 rsw=sqlReader.getResultSetWrapper(strQuery);
			 while(rsw.next()){
				 bookmarkBean=BookmarkBean.getBeanByResultSetByWrapper(rsw); 
				 bookmarkBeanMap.put(bookmarkBean.getBookmarkId(),bookmarkBean);
			 }
			 retStatus=true;
		 }
		 catch(Exception e){
			 
			 CyberoamLogger.repLog.error("Got an exception in BookmarkBean loadAll " + e,e);
		 }
		 finally{
	            try{
	            	rsw.close();
	                sqlReader.close();
	            }catch(Exception e){}
	        }
		return retStatus;
	}
	 public static BookmarkBean getRecordbyPrimarykey(int primarykey) {        
	    	BookmarkBean bookmarkBean=null;
	        try {
	        	   if(bookmarkBeanMap==null) {
	               	loadAll();
	               }
	        	   bookmarkBean=(BookmarkBean)bookmarkBeanMap.get(new Integer(primarykey));
	        	           	
	        }catch(Exception e) {
	        	CyberoamLogger.repLog.error("Exception->getRecordbyPrimarykey()->BookmarkBean: " + e,e);
	        }
	        return bookmarkBean;
	    }
	 
	 public int insertRecord(){
	        CyberoamLogger.repLog.debug("insert Bookmark called ...");
	        String insert = null;
	        int insertValue=-1;
	        SqlReader sqlReader = null;
	        try{
	            sqlReader = new SqlReader(false);	            
	            insert ="insert into tblbookmark "+
	            "(bookmarkgroupid,name,url,categoryid,description) values"+ 
	            "(" + groupID + "," + StringMaker.makeString(name) + "," +
	            StringMaker.makeString(url) + "," + categoryID+ ","+StringMaker.makeString(description)+")";
	            insertValue = sqlReader.executeInsertWithLastid(insert,"bookmarkid");
	            CyberoamLogger.repLog.info("ID after insert : "+insertValue);
	           
	           if(insertValue>=0){ 	
	            	this.setBookmarkId(insertValue);
	            	if(bookmarkBeanMap==null){
	            		loadAll();
	            	}
	            	bookmarkBeanMap.put(insertValue, this);
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
	 
	 public int insertRecordWithNewGroup(String groupname){
	        CyberoamLogger.repLog.debug("insert Bookmark with New Group called ...");
	        String insert = null;
	        int insertValue=-1;
	        BookmarkGroupBean bookmarkGroupBean=new BookmarkGroupBean();
	        SqlReader sqlReader = null;
	        try{
	            sqlReader = new SqlReader(false);
	            insert= "insert into tblbookmarkgroup (name) values ("+StringMaker.makeString(groupname)+")";
	            insertValue=-3;
	            groupID=sqlReader.executeInsertWithLastid(insert,"bookmarkgroupid");
	            
	            insertValue=-2;
	            insert ="insert into tblbookmark "+
	           	"(bookmarkgroupid,name,url,categoryid,description) values"+ 
	           	"(" + groupID + "," + StringMaker.makeString(name) + "," +
	           	StringMaker.makeString(url) + "," + categoryID+ ","+StringMaker.makeString(description)+")";
	           	insertValue = sqlReader.executeInsertWithLastid(insert,"bookmarkid");
	           	
	           	 CyberoamLogger.repLog.info("ID after insert : "+insertValue);
	           	 if(insertValue>=0){ 	
		            	this.setBookmarkId(insertValue);
		            	if(bookmarkBeanMap==null){
		            		loadAll();
		            	}
		            	bookmarkBeanMap.put(insertValue, this);
		            	bookmarkGroupBean.setBookmarkGroupID(groupID);
			            bookmarkGroupBean.setName(groupname);
			            bookmarkGroupBean.setBookmarkGroupMap(bookmarkGroupBean);
		            }
	        }catch(Exception e){
	            CyberoamLogger.repLog.error("Got an exception while inserting record " + this + e,e);
	            if(insertValue!=-3){
	            	insertValue = -1;
	            	try{
		            	sqlReader.executeUpdate("delete from tblbookmarkgroup where bookmarkgroupid="+groupID+"",5);
		            	}
		            	catch(Exception deleteexc){}
	            }
	        }finally{
	            try{
	                sqlReader.close();
	            }catch(Exception e){}
	        }
	        return insertValue;
	    }
	 
	 public int deleteRecord(int bookmarkid)
	 {
		 int status=0;
		 SqlReader sqlReader=null;
		 String strQuery=null;
		 Iterator mailScheduleIterator=null;
		 MailScheduleBean mailScheduleBean=null;
		 boolean isrelated=false;
		 try{
			 sqlReader = new SqlReader(false);
			 mailScheduleIterator=MailScheduleBean.getIterator();
			 while(mailScheduleIterator.hasNext()){
				 mailScheduleBean=(MailScheduleBean)mailScheduleIterator.next();
				 if(mailScheduleBean.getReportGroupID()==bookmarkid){
					 isrelated=true;
					 break;
				 }
			 }
			 if(!isrelated){
				 strQuery="delete from tblbookmark where bookmarkid="+bookmarkid+"";
				 status=sqlReader.executeUpdate(strQuery, 5);
			 }
			 else{
				 status=-2;
			 }
			 if(status>0){
			    bookmarkBeanMap.remove(bookmarkid);
			 }
		 }	
		 catch(Exception e){
			 CyberoamLogger.repLog.error("Got an exception while deleting record " + this + e,e);
		 }
		 finally{
	            try{
	                sqlReader.close();
	            }catch(Exception e){}
	        }
		 return status;
	 }
	 
	 public static LinkedHashMap getRecord(String fieldname,int value){
		 SqlReader sqlReader = null;
		 LinkedHashMap bookmarkMap=new LinkedHashMap();
		 String strQuery=null;
		 ResultSetWrapper rsw=null;
		 BookmarkBean bookmarkBean=null;
		 try{
			 strQuery="select * from tblbookmark where "+fieldname+"="+value+"";
			 rsw=sqlReader.getResultSetWrapper(strQuery);
			 while(rsw.next()){
				 bookmarkBean=BookmarkBean.getBeanByResultSetByWrapper(rsw);
				 bookmarkMap.put(bookmarkBean.getBookmarkId(),bookmarkBean);
			 }
		 }
		 catch(Exception e){
			 CyberoamLogger.repLog.error("Got an exception while fetching bookmark record " + e,e);
		 }
		 finally{
	            try{
	            	rsw.close();
	                sqlReader.close();
	            }catch(Exception e){}
	        }
		 return bookmarkMap;
		 
	 }
	 
	 public static BookmarkBean getBeanByResultSetByWrapper(ResultSetWrapper rsw){
	    	BookmarkBean bookmarkBean=new BookmarkBean();
	    	try{
	    		bookmarkBean.setBookmarkId(rsw.getInt("bookmarkid"));
	    		bookmarkBean.setName(rsw.getString("name"));
	    		bookmarkBean.setCategoryId(rsw.getInt("categoryid"));
	    		bookmarkBean.setDescription(rsw.getString("description"));
	    		bookmarkBean.setGroupId(rsw.getInt("bookmarkgroupid"));
	    		bookmarkBean.setUrl(rsw.getString("url"));
	    	}
	    	catch(Exception e){
	    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetByWrapper()->BookmarkBean: " + e,e);
	    	}
	    	return bookmarkBean;
	    }
	 
	 public static void removeFromCache(int bookmarkGroupId){
		 BookmarkBean bookmarkBean=null;
		 int cnt=0;
		 ArrayList bookmarkid=new ArrayList();
		 Iterator bookmarkIterator=getIterator();
		 while(bookmarkIterator.hasNext()){
			 bookmarkBean=(BookmarkBean)bookmarkIterator.next(); 
			 if(bookmarkBean.getGroupId()==bookmarkGroupId){
				 bookmarkid.add(bookmarkBean.getBookmarkId());			
			 }
		 }
		 	for(int i=0;i<bookmarkid.size();i++){
		 		bookmarkBeanMap.remove(bookmarkid.get(i));
		 	}
	 }
    
}
