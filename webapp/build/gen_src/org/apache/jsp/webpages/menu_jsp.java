package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.cyberoam.iview.authentication.beans.IviewMenuBean;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.authentication.beans.RoleBean;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iviewdb.utility.SqlReader;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.beans.CategoryBean;
import java.util.Iterator;

public final class menu_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n\n\n\n\n<html>\n<head>\n");

response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","no-store");
response.setDateHeader("Expires",0);
response.setHeader("Pragma","no-cache");
String categoryId=null;
 if(session.getAttribute("categoryid")!=null){	
		categoryId = (String)session.getAttribute("categoryid");	
	}

      out.write("\n<meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\" />\n<link href=\"../css/menu.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link href=\"../css/newTheme.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script src=\"../javascript/menu.js\"></script>\n<script src=\"../javascript/combo.js\"></script>\n</head>\n\n    <div class=\"sidebar\" id=\"sidebar\">\n     \t<div class=\"imageheader\">\n\t\t\t<div class=\"imageheader2\">\n    \t\t</div>    \t\t\n  \t\t</div>  \t\n  \t\t<div align=\"center\" >\n  \t\t<form name=\"frmcategory\" action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\">\n  \t\t  \t\t \t  \t\t   \t\t \n  \t\t<div id=\"categoryid\" class=\"Combo_container\" style=\"text-align:left;\" ></div>\n  \t\t  \t\t\t  \t\t\n  \t\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(ApplicationModes.CATEGORY_CHANGE);
      out.write("\">\n  \t\t<input type=\"hidden\" name=\"categoryid\" value=\"\">\n  \t\t</form>\n  \t\t</div>\t  \t  \t\t\n       <div class=\"sidemanu\">         \t\n\t\t<div  id = \"menu_data\" class=\"main_data\"></div>\t\t\n\t\t\n\t\t");

			String iViewVersion=iViewConfigBean.getValueByKey("iviewversion");
			if(iViewVersion != null && !"".equalsIgnoreCase(iViewVersion)) {
		
      out.write("\n\t\t<br/>\n\t\t<div class=\"versionText\" >\n\t\t\t<center>\n\t\t\t\tVersion <br/>\n\t\t\t\t");
      out.print(iViewVersion);
      out.write("\n\t\t\t</center>\n\t\t</div>\n\t\t");

			}
		
      out.write('\n');
      out.write('	');
      out.write('	');

			String menuItem = "";
			String lastAccess = "";
			if(request.getParameter("empty") != null){
				lastAccess = request.getParameter("empty");
				session.setAttribute("lastAccess",lastAccess);
			}else{
				if(session.getAttribute("lastAccess") != null)
					lastAccess = session.getAttribute("lastAccess").toString();
				else
					lastAccess = "";
			}
			
			int userLevel = RoleBean.getRecordbyPrimarykey((Integer)session.getAttribute("roleid")).getLevel();
			if(session.getAttribute("menudata")==null){
				menuItem = IviewMenuBean.getIviewMenu(userLevel,Integer.parseInt(session.getAttribute("categoryid").toString()));
				session.setAttribute("menudata",menuItem);
			}else
				menuItem = session.getAttribute("menudata").toString();
		
      out.write("\t\t\n\t\t<script type=\"text/javascript\">\n\n\t\t// category list add \n\t\tfunction getDeviceListByCategory(value)\n\t\t{\n\t\t\tvar categoryId = value;\t\t\n\t\t\tdocument.frmcategory.categoryid.value = categoryId;\n\t\t\tdocument.frmcategory.submit();\n\t\t}\n\t\tvar categoryList=new Array();\n\t\t");
   			
			Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
			CategoryBean categoryBean= null;
			while(categoryBeanItr.hasNext()){	  		
				categoryBean = (CategoryBean)categoryBeanItr.next();
				
      out.write("\n\t\t\t\tcategoryList.push('");
      out.print(categoryBean.getCategoryName()+"|"+categoryBean.getCategoryId());
      out.write("');\n\t\t\t\t");

  			}
  		
      out.write("\n\t\tvar categoryID = ");
      out.print(session.getAttribute("categoryid"));
      out.write(";\n\t\tsetComboBox(\"categoryid\",\"198\",1,\"getDeviceListByCategory\");\n\t\tinsertAllElements(\"categoryid\",categoryList);\n\t\tif(categoryID != \"null\"){\n\t\t\tselectComboItem(\"categoryid\",getElementIndex(\"categoryid\",categoryID));\n\t\t}\n\t\t\t\n\t\t\tvar tmenuItems = [");
      out.print( menuItem);
      out.write("];\n\t\t\tcreateNewMenu(tmenuItems,\"");
      out.print(lastAccess);
      out.write("\");\n\t\t\t/*var lastA = \"");
//=lastAccess
      out.write("\";\n\t\t\tif(lastA != \"\")\n\t\t\t\tdefaultDisplay(lastA);\n\t\t\telse\n\t\t\t\tdefaultDisplay(lastA,'2');\t\t*/\n\n\n\t\t\t\t\n\t\t</script>\t\t\n\t   </div>\n    </div>\t\n\n</html>\n");
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
