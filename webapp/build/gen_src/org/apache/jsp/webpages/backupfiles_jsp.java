package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.File;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.BackupRestoreUtility;

public final class backupfiles_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n   \n\n\n\n\n\n    \n<html>\n<body>\n<div style=\"z-index:99999;\">\n\n<form action=\"");
      out.print(request.getContextPath());
      out.write("/BackupServlet?choice=1\" method=\"post\" name=\"frmbackup\">\n\t<table cellpadding=\"2\" cellspacing=\"0\" width=\"100%\" border=\"0\">\t\n\t\t<tr class=\"innerpageheader\">\n\t\t\t<td width=\"3%\">&nbsp;</td>\n\t\t\t<td class=\"contHead\">Backup Files</td>\n\t\t\t<td colspan=\"3\" align=\"right\" style=\"padding-right: 5px;padding-top: 2px;\">\n\t\t\t<img src=\"../images/close.jpg\" width=\"15px\" height=\"15px\" onclick=\"handleThickBox('2','backuprestore')\" style=\"cursor: pointer;\">\n\t\t\t</td>\n\t\t</tr>\n\t</table>\n\n");

	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	File dstPath=new File(IViewPropertyReader.BackupDIR);
	String filenames[]=dstPath.list();
	int recordcount;
	int height=filenames.length > 18 ? 396:(filenames.length+1)*23;

      out.write("\n\n<div style='width:500px; height: ");
      out.print(height);
      out.write("px; overflow:auto' align=\"center\">\n\n<table class=\"TableData\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n\t<tr height=\"22px\">\n\t\t<td class=\"tdhead\"> <input name=\"selectall\" type=checkbox onclick=\"selectAll(this);\"/></td>\t\n\t\t<td class=\"tdhead\" style=\"padding-left:10px\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Filename"));
      out.write("</b></td>\n\t\t<td align=\"center\" class=\"tdhead\"><b>");
      out.print(TranslationHelper.getTranslatedMessge("Download"));
      out.write("</b></td>\t\t\n\t</tr>\n\t\n");
	for(recordcount=0;recordcount<filenames.length;recordcount++){
		if(BackupRestoreUtility.isValidArchiveFile(IViewPropertyReader.BackupDIR+filenames[recordcount])==-1){
			continue;			
		}

      out.write("\n\t\n\t<tr height=\"22px\">\n\t\t<td class=\"tddata\"><input type=checkbox name=\"filenames\" value=\"");
      out.print(filenames[recordcount]);
      out.write("\" onclick=\"DeSelectAll(this);\"></input></td>\n\t\t<td class=\"tddata\">");
      out.print(TranslationHelper.getTranslatedMessge(filenames[recordcount]));
      out.write("</td>\n\t\t<td class=\"tddata\" align=\"center\"><a href=\"");
      out.print(request.getContextPath());
      out.write("/backup/\n\t\t");
      out.print(filenames[recordcount]);
      out.write("?choice=2\">");
      out.print(TranslationHelper.getTranslatedMessge("Download"));
      out.write("</a></td>\t\t\n\t\t\n\t</tr>\t\t\n\t\n");
 } 
      out.write("\n   \n</table>\n\n</div>\n\n<table align=\"center\">\n\t<tr>\n\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t<input type=\"submit\" class=\"criButton\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Delete"));
      out.write("\" onClick=\"return confirmAction(this);\">\t\t\t\n\t\t\t<input type=\"button\" class=\"criButton\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Cancel"));
      out.write("\" onclick=\"return handleThickBox('2','backuprestore')\">\n\t\t</td>\n\t</tr>\n</table>\n\t\n</form>\t\n</div>\n</body>\n</html>\n");
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
