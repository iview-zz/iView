package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.modes.TabularReportConstants;
import org.cyberoam.iview.utility.CheckSession;
import java.util.*;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.beans.BookmarkGroupBean;
import org.cyberoam.iview.beans.BookmarkBean;
import org.cyberoam.iview.beans.CategoryBean;

public final class managebookmark_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.List _jspx_dependants;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- ***********************************************************************\n*  Cyberoam iView - The Intelligent logging and reporting solution that \n*  provides network visibility for security, regulatory compliance and \n*  data confidentiality \n*  Copyright  (C ) 2009  Elitecore Technologies Ltd.\n*  \n*  This program is free software: you can redistribute it and/or modify \n*  it under the terms of the GNU General Public License as published by \n*  the Free Software Foundation, either version 3 of the License, or\n*  (at your option) any later version.\n*  \n*  This program is distributed in the hope that it will be useful, but \n*  WITHOUT ANY WARRANTY; without even the implied warranty of \n*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU \n*  General Public License for more details.\n*  \n*  You should have received a copy of the GNU General Public License \n*  along with this program.  If not, see <http://www.gnu.org/licenses/>.\n*  \n*  The interactive user interfaces in modified source and object code \n");
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n");

	try{
	if(CheckSession.checkSession(request,response)<0)
		return;
	String fontClass="";
	String strStatus="";
	if(session.getAttribute("status")!=null){
		 strStatus = session.getAttribute("status").toString();
		 session.removeAttribute("status");
	}
	

      out.write("\n\n<HTML>\n<HEAD>\n\t<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n\t<META http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n\t<LINK rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\" />\n\t<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n\t<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/protocolgroup.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/popupform.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/utilities.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\" SRC=\"");
      out.print(request.getContextPath());
      out.write("/javascript/ipvalidation.js\"></SCRIPT>\n\t<SCRIPT LANGUAGE=\"Javascript\">\n\t\n\tfunction setWidth(){\n\t\tvar main_div = document.getElementById(\"main_content\");\t\n\t\tmain_div.style.width = (document.body.clientWidth - 217);\t\n\t}\n\n\t\twindow.onload = function (evt) {\n\t\t\tsetWidth();\n\t\t\t//getWinSize();\t\t\t\n\t\t}\t\t\n\t\t\n\tfunction openAddBookmarkGroup(){\n\t\t\tURL = '");
      out.print(request.getContextPath());
      out.write("/webpages/addBookmarkGroup.jsp';\n\t\t\thandleThickBox('1','bookmarkgroup','500');\n\t}\n\tfunction deleteBookmarkGroup(id,bookmarkgroup){\n\t\tvar answer;\n\t    \tanswer=confirm(\"Are you sure to delete \" + bookmarkgroup + \" Bookmark group?\");\n\t    if(answer){\n\t    \tdocument.frmProtocolGroup.id.value=id;\n\t    \tdocument.frmProtocolGroup.appmode.value=");
      out.print(ApplicationModes.DELETE_BOOKMARK_GROUP);
      out.write(";\t\n\t\t\tdocument.frmProtocolGroup.submit();\n\t\t}\n\t}\n\tfunction deleteBookmark(id,bookmark){\n\t\tvar answer;\n\t    \tanswer=confirm(\"Are you sure to delete \" + bookmark + \" Bookmark ?\");\n\t    if(answer){\n\t    \tdocument.frmProtocolGroup.id.value=id;\n\t    \tdocument.frmProtocolGroup.appmode.value=");
      out.print(ApplicationModes.DELETE_BOOKMARK);
      out.write(";\t\n\t\t\tdocument.frmProtocolGroup.submit();\n\t\t}\n\t}\n\tfunction checkBlankGroupname(){\n\t\tif(document.getElementByID(\"bmg_name\").value==\"\"){\n\t\t\talert(\"Please Enter Group Name\");\n\t\t\treturn false;\n\t\t}\n\t\treturn true;\n\t}\n\t\n\n\t</SCRIPT>\n</HEAD>\n<BODY>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("\n<div class = \"maincontent\" id=\"main_content\">\n\t<div class=\"reporttitlebar\">\n\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t<div class=\"reporttitle\">Bookmark Management</div>\n\t</div>\n\t<br /><br />\n");

	
	BookmarkGroupBean bookmarkGroupBean = null;
	BookmarkBean bookmarkBean = null;
	LinkedHashMap bookmarkGroupMap=null,bookmarkMap=null;
	Iterator bookmarkGroupIterator=null,bookmarkIterator=null;
	bookmarkGroupMap=BookmarkGroupBean.getRecord();


      out.write("\t\n<FORM method=\"POST\" name=\"frmProtocolGroup\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\">\n<input type=\"hidden\" name=\"id\" value =\"-1\">\n<input type=\"hidden\" name=\"appmode\" value =\"-1\">\n<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"margin-bottom: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td align=\"left\" class=\"ButtonBack\">\n\t\t\t<input class=\"criButton\" type=\"button\" onClick=\"openAddBookmarkGroup();\" value=\"Add Bookmark Group\">\n\t\t</td>\n\t</tr>\n\t</table>\n<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 2px;margin-left:2px;\">\n ");

	if(!"".equals(strStatus)){

      out.write("\n\t<tr>\n\t\t<td class=\"posimessage\" colspan=\"4\">&nbsp;&nbsp;");
      out.print(strStatus);
      out.write("</td>\n\t</tr>\n");

	}

      out.write("\n\n\t<tr>\n\t\t<td>\n\t\t\t<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"TableData\">\n\t\t\t<tr>\n\t\t\t\t<td class=\"tdhead\">&nbsp;</td>\n\t\t\t\t<td class=\"tdhead\" width=\"20%\">Bookmark Groups</td>\n\t\t\t\t<td class=\"tdhead\" width=\"8%\" align=\"center\">Delete</td>\n\t\t\t</tr>\n\t\t\t");

			if(bookmarkGroupMap != null && bookmarkGroupMap.size() > 0){
						bookmarkGroupIterator=bookmarkGroupMap.values().iterator();
						int grpCounter = 0;
						String rowStyle = "";
						String tdStyle="";
						String astyle="";
						while(bookmarkGroupIterator.hasNext()){
							grpCounter++;							
							if(grpCounter%2 == 0)
									rowStyle = "trdark";
								else
									rowStyle = "trlight";
								
								tdStyle="tddata";
								astyle="";
								bookmarkGroupBean=(BookmarkGroupBean)bookmarkGroupIterator.next();
			
      out.write("\n\t\t\t\t\t\t<tr class=\"");
      out.print(rowStyle);
      out.write("\">\n\t\t\t\t\t\t\t<td class=\"tddata\" align=\"center\" width=\"5%\">\n\t\t\t\t\t\t\t\t<input type=\"hidden\" id=\"");
      out.print("0_1_"+ grpCounter);
      out.write("\" value=\"");
      out.print(request.getContextPath());
      out.write("/images/collapse.gif\" />\n\t\t\t\t\t\t\t\t<img id=\"");
      out.print("1_1_"+ grpCounter);
      out.write("\" src=\"");
      out.print(request.getContextPath());
      out.write("/images/inactiveexpand.gif\" onClick=\"changeImg(this.id);\" style=\"cursor: pointer;\" />\n\t\t\t\t\t\t\t</td>\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t<td class=\"");
      out.print(tdStyle);
      out.write("\">\n\t\t\t\t\t\t\t\t<div  ");
      out.print(astyle);
      out.write('>');
      out.write(' ');
      out.print(bookmarkGroupBean.getName());
      out.write(" </div>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t");
 if(bookmarkGroupBean.getBookmarkGroupID()!=1){
      out.write("\n\t\t\t\t\t\t\t<td class=\"");
      out.print(tdStyle);
      out.write("\" align=\"center\">\n\t\t\t\t\t\t\t\t\t<img src=\"");
      out.print(request.getContextPath());
      out.write("/images/false.gif\" title=\"Disable\" onClick=\"deleteBookmarkGroup(");
      out.print(bookmarkGroupBean.getBookmarkGroupID());
      out.write(' ');
      out.write(',');
      out.write('\'');
      out.print(bookmarkGroupBean.getName());
      out.write("')\" >\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t");
} 
      out.write("\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t");

							bookmarkMap=BookmarkBean.getRecord("bookmarkgroupid",bookmarkGroupBean.getBookmarkGroupID());
										if(bookmarkMap!=null && bookmarkMap.size()>0){
											bookmarkIterator=bookmarkMap.values().iterator();
											
      out.write("\n\t\t\t\t\t\t\t\t\t\t\t<tr class=\"trlight\" id=\"1_");
      out.print(grpCounter);
      out.write("_0\" style=\"display: none;\">\n\t\t\t\t\t\t\t\t\t\t\t<td class=\"tddata\">&nbsp;</td>\n\t\t\t\t\t\t\t\t\t\t\t<td colspan=\"2\" class=\"tddata\" style=\"padding-left:0px;padding-right:0px\">\n\t\t\t\t\t\t\t\t\t\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n\t\t\t\t\t\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t\t\t\t\t\t<td class=\"tdhead\">Bookmarks</td>\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t\t<td class=\"tdhead\">Category</td>\n\t\t\t\t\t\t\t\t\t\t\t\t<td class=\"tdhead\" colspan=\"2\">Description</td>\n\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\t\t\t\t");

											int protoCounter = 0;
											String protoRowStyle = "";
											String ptdStyle="";
											String pastyle="";
											while(bookmarkIterator.hasNext()){
												bookmarkBean=(BookmarkBean)bookmarkIterator.next();
												protoCounter++;
												if(protoCounter%2 == 0)
													protoRowStyle = "trdark";
												else
													protoRowStyle = "trlight";
												
													ptdStyle="tddata";
													pastyle="";										
										
      out.write("\n\t\t\t\t\t\t\t\t<tr class=\"");
      out.print(protoRowStyle);
      out.write("\">\n\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t<td class=\"");
      out.print(ptdStyle);
      out.write("\" width=\"25%\"><div ");
      out.print(pastyle);
      out.write('>');
      out.print(bookmarkBean.getName());
      out.write(" </div></td>\n\t\t\t\t\t\t\t\t\t<td class=\"");
      out.print(ptdStyle);
      out.write("\" width=\"10%\"><div ");
      out.print(pastyle);
      out.write('>');
      out.print((CategoryBean.getRecordByPrimaryKey(bookmarkBean.getCategoryId())).getCategoryName() );
      out.write("</div></td>\n\t\t\t\t\t\t\t\t\t");
String description=bookmarkBean.getDescription(); 		
									
      out.write("\n\t\t\t\t\t\t\t\t\t<td class=\"");
      out.print(ptdStyle);
      out.write("\"><div ");
      out.print(pastyle);
      out.write(" title=\"");
      out.print(description);
      out.write('"');
      out.write('>');
      out.print(description.length()>60?description.substring(0,60)+"...":description );
      out.write("</div></td>\n\t\t\t\t\t\t\t\t\t<td class=\"");
      out.print(ptdStyle);
      out.write("\" width=\"8%\" align=\"center\"><img src=\"");
      out.print(request.getContextPath());
      out.write("/images/false.gif\" title=\"Disable\" onClick=\"deleteBookmark(");
      out.print(bookmarkBean.getBookmarkId() );
      out.write(',');
      out.write('\'');
      out.print(bookmarkBean.getName());
      out.write("')\"></td>\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t</tr>\n\t\n\t\t\t\t\t\t");

							}
						
      out.write("\n\t\t\t\t\t\t\t\t\t</table>\n\t\t\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t");

							}
										
						
      out.write("\t\n\t\t\t\t\t\t\n\t\t\t\t\t\t\n\t\t\t\t");

					}
      out.write("\n\t\t\t\t\t\t</table>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td>&nbsp;</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t\t\t\t\n\t\t\t\n\t\t\t");
}else{}	
			
      out.write("\n\t\t\t\n</table>\n</FORM>\n</div>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n<div id=\"TB_overlay\" class=\"TB_overlayBG\" style=\"display: none;\"></div>\n<div class=\"TB_window\" id=\"bookmarkgroup\"></div>\n\n</BODY> \n</HTML>\n");

	} catch(Exception e){
		CyberoamLogger.appLog.info("Exception in managebookmark.jsp"+e);
	}

      out.write('\n');
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
