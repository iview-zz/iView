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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.BookmarkBean;
import org.cyberoam.iview.beans.BookmarkGroupBean;
import org.cyberoam.iview.modes.ApplicationModes;
import java.util.Iterator;
/**
 * Helper class to Add,Delete new BookmarkGroup.
 * @author Darshan Shah
 */
public class BookmarkGroupHelper {
	 
	/**
	 * Process given request and provide response to ADD new Bookmarks.
	 * Here request must contain appmode parameter as process flag.
	 * <br>Process flags are as follows.
	 * <u>
	 * <li>ApplicationModes.NEWBOOKMARK</li>
	 * </u> 
	 * @param request
	 * @param response
	 */
	public static void process(HttpServletRequest request, HttpServletResponse response ){
		
		int iAppMode = Integer.parseInt(request.getParameter("appmode"));
		BookmarkGroupBean bookmarkGroupBean = null;
		String name = null;
		int status=0;
		int totalRec=0;
		Iterator bookmarkIterator=null;
		HttpSession session=request.getSession();
		switch(iAppMode){
		/**
		 * New BookmarkGroup Creation event
		 */
		case ApplicationModes.NEWBOOKMARKGROUP:
			name = request.getParameter("bmg_name");
			bookmarkGroupBean = new BookmarkGroupBean();
			
			try{
				bookmarkGroupBean.setName(name);
				status=bookmarkGroupBean.insertRecord();
				if(status>0){
					session.setAttribute("status","Bookamark Group Added Successfully");
				}
				else{
					session.setAttribute("status","Same Bookamark Group Exist");
				}
				
				response.sendRedirect(request.getContextPath()+"/webpages/managebookmark.jsp");
				
			}
			catch(Exception e){
				CyberoamLogger.appLog.debug("Exception in BookmarkGroupHelper.process()" + e,e);
			}		
			break;
			
		case ApplicationModes.DELETE_BOOKMARK_GROUP:
			int id=Integer.parseInt(request.getParameter("id"));
			bookmarkGroupBean=new BookmarkGroupBean();
			try{
				status=bookmarkGroupBean.deleteRecord(id);
				if(status>0){
					session.setAttribute("status","Bookamark Group Deleted Successfully");
				}
				else if(status == -2){
					session.setAttribute("status","Error in deletion..Relation exist with Report Notification");
				}
				bookmarkIterator=BookmarkBean.getIterator();
				totalRec=0;
				while(bookmarkIterator.hasNext()){
						bookmarkIterator.next();
						totalRec++;		
				}
				if(totalRec==0){
					String lastAccess=session.getAttribute("lastAccess").toString();
					lastAccess=lastAccess.replace(lastAccess.substring(0,1),new Integer(Integer.parseInt(lastAccess.substring(0,1))-1).toString());
					session.setAttribute("lastAccess",lastAccess);
				}
				response.sendRedirect(request.getContextPath()+"/webpages/managebookmark.jsp");
			}
			catch(Exception e){
				CyberoamLogger.appLog.debug("Exception in BookmarkGroupHelper.process()" + e,e);
			}
			
		}
	}	
}
