package org.apache.jsp.webpages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import org.cyberoam.iview.modes.ApplicationModes;
import org.cyberoam.iview.utility.CheckSession;
import org.cyberoam.iview.beans.*;
import org.cyberoam.iview.mlm.TranslationHelper;
import org.cyberoam.iview.audit.CyberoamLogger;

public final class managereportprofile_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("*  versions of this program must display Appropriate Legal Notices, as \n*  required under Section 5 of the GNU General Public License version 3.\n*  \n*  In accordance with Section 7(b) of the GNU General Public License \n*  version 3, these Appropriate Legal Notices must retain the display of\n*   the \"Cyberoam Elitecore Technologies Initiative\" logo.\n*********************************************************************** -->\n\n\n\n\n\n\n\n");

	try{
		if(CheckSession.checkSession(request,response) < 0) return;
		int categoryId;
		if(request.getParameter("category")==null){
			categoryId = Integer.parseInt(session.getAttribute("categoryid").toString());
		}else{
			categoryId = Integer.parseInt(request.getParameter("category"));
		}
		String strProfileId = request.getParameter("profileid");
		String header = "";
		int iProfileId = -1;
		int mode = ApplicationModes.ADD_REPORT_PROFILE;
		ReportGroupBean reportGroupBean = null;
		ArrayList currReportGroupRelList = null;
		ArrayList currReportIdList = null;
		ReportGroupRelationBean reportGroupRelationBean = null;
		boolean isEdit = false;
		if(strProfileId == null || strProfileId.equalsIgnoreCase("")){
			header = TranslationHelper.getTranslatedMessge("Add Custom View");
		}
		else {
			header = TranslationHelper.getTranslatedMessge("Edit Custom View");
			iProfileId = Integer.parseInt(strProfileId);
			reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(iProfileId);
			mode = ApplicationModes.UPDATE_REPORT_PROFILE;
			currReportGroupRelList = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportGroupBean.getReportGroupId()));
			currReportIdList = new ArrayList(currReportGroupRelList.size());
			for(int i=0; i<currReportGroupRelList.size(); i++){
				reportGroupRelationBean = (ReportGroupRelationBean)currReportGroupRelList.get(i); 
				currReportIdList.add(new Integer(reportGroupRelationBean.getReportId()));
			}
			isEdit = true;
		}

      out.write("\n\n<html>\n<head>\n<TITLE>");
      out.print(iViewConfigBean.TITLE);
      out.write("</TITLE>\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/container.css\" rel=\"stylesheet\" type=\"text/css\" />\n<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/reports.css\">\n<link href=\"");
      out.print(request.getContextPath());
      out.write("/css/configuration.css\" rel=\"stylesheet\" type=\"text/css\" />\n<script language=\"JavaScript\" src=\"/javascript/cyberoam.js\"></script>\n<script type=\"text/javascript\">\nvar totalSel = 0;\nfunction viewReports(reportgroupid){\n\tvar img0 = document.getElementById('img0_'+reportgroupid);\n\tvar img1 = document.getElementById('img1_'+reportgroupid);\n\tvar row = document.getElementById('row_'+reportgroupid);\n\tvar temp = img0.value;\n\timg0.value = img1.src;\n\timg1.src = temp;\n\tif(row.style.display == 'none' ){\n\t\trow.style.display = ''; \n\t} else {\n\t\trow.style.display = 'none'; \n\t}\n}\nfunction selectME(obj,id){\n\telecount = document.getElementById(\"cnt_\"+id).value;\n\tif(obj.checked == true){\n\t\telecount++;\n\t\ttotalSel++;\n\t}else{\n\t\telecount--;\n\t\ttotalSel--;\n\t}\n\tif(totalSel == 9){\n\t\tobj.checked = false;\n\t\ttotalSel --;\n\t\telecount--;\n\t\talert(\"You can select only 8 reports\");\n\t\treturn;\n\t}\n\tif(elecount > 0){\n\t\tdocument.getElementById(\"star_\"+id).style.visibility = \"\";\n\t\tdocument.getElementById(\"cntshow_\"+id).innerHTML = \"(\"+elecount+\")\";\n\t}else{\n");
      out.write("\t\tdocument.getElementById(\"star_\"+id).style.visibility = \"hidden\";\n\t\tdocument.getElementById(\"cntshow_\"+id).innerHTML = \"\";\n\t}\n\tdocument.getElementById(\"cnt_\"+id).value = elecount;\n}\nwindow.onload = function (evt) {\n\t//setWidth();\t\t\t\t\n}\t\nfunction setWidth(){\n\tvar main_div = document.getElementById(\"main_content\");\t\n\tmain_div.style.width = (document.body.clientWidth - 218);\t\n}\nfunction validate(){\n\tnameReExp = new RegExp(\"^[0-9a-zA-Z][0-9a-zA-Z_.@ ]*$\");\n\tif (document.managereportprofileform.profilename.value == ''){\n\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must enter the View Name"));
      out.write("');\n\t\tdocument.managereportprofileform.profilename.focus();\n\t\treturn false;\n\t}else if (!nameReExp.test(document.managereportprofileform.profilename.value)){\n\t\talert(\"");
      out.print(TranslationHelper.getTranslatedMessge("Only alpha numeric characters, '_', '@', ' ' and '.' allowed in View Name"));
      out.write("\");\n\t\tdocument.managereportprofileform.profilename.focus();\n\t\treturn false;\n\t}\n\n\tvar cnt = 0; \n\tfor(i=0; i<document.managereportprofileform.reportid.length; i++){\n\t\tif(document.managereportprofileform.reportid[i].checked){\n\t\t\tcnt++;\n\t\t}\n\t}\n\tif(cnt==0){\n\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("You must select atleast one report."));
      out.write("');\n\t\treturn false;\n\t} else if(cnt > 8){\n\t\talert('");
      out.print(TranslationHelper.getTranslatedMessge("maximum 8 reports are allowed in one View."));
      out.write("');\n\t\treturn false;\n\t}\n\t");
if(isEdit){
      out.write("\n\t\tvar con = confirm('");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to update Custom View?"));
      out.write("');\n\t");
} else {
      out.write("\n\t\tvar con = confirm('");
      out.print(TranslationHelper.getTranslatedMessge("Are you sure you want to add Custom View?"));
      out.write("');\n\t");
}
      out.write("\n\tif(con){\n\t\tdocument.managereportprofileform.submit();\n\t}\n}\n\nfunction getReportGroup(){\n\tvar ele = document.getElementById(\"reportList\");\n\tvar id = document.getElementById(\"customViewCategory\").value;\n\n\t// deleting rows\n\twhile(ele.rows.length>1){\n\t\tdocument.all.reportList.deleteRow(ele.rows.length-1);\t\t\t\n\t}\n\t\n");

	Iterator allCategoryBeanItr = CategoryBean.getAllCategoryIterator();  
	CategoryBean allCategoryBean= null;
	while(allCategoryBeanItr.hasNext()){	  		
		allCategoryBean = (CategoryBean)allCategoryBeanItr.next();

      out.write("\n\t\tif(id == ");
      out.print(allCategoryBean.getCategoryId());
      out.write("){\n\t\tvar rowStyle = \"trdark\";\t\n\t\tvar oddRow = 1;\n\t\t\t\t\n");
			//ArrayList reportGroupBeanList = CategoryBean.getReportGroupIdByCategoryId(allCategoryBean.getCategoryId());
			ArrayList<Integer> reportGroupBeanList = CategoryReportGroupRelationBean.getReportgroupListByCategory(allCategoryBean.getCategoryId());			
			reportGroupBean = null;
			ArrayList reportGroupRelationList = null;
			ReportBean reportBean = null;
	
			int tblCount=0;
			int recordCount=0;			
			if(reportGroupBeanList!=null && reportGroupBeanList.size()>0){				
				for(;recordCount<reportGroupBeanList.size();recordCount++){					
					reportGroupBean = ReportGroupBean.getSQLRecordByPrimaryKey(reportGroupBeanList.get(recordCount));
					if(reportGroupBean.getGroupType() == ReportGroupBean.STATIC_GROUP){
						reportGroupRelationList = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportGroupBean.getReportGroupId()));

      out.write("\t\t\t\t\t\t\n\t\t\t\t\t\tif(oddRow==0){\t\t\t\t\t\n\t\t\t\t\t\t\trowStyle = \"trdark\";\t\t\t\t\t\n\t\t\t\t\t\t}else{\t\t\t\t\n\t\t\t\t\t\t\trowStyle = \"trlight\";\n\t\t\t\t\t\t}\n\t\t\t\t\t\toddRow=1-oddRow;\n\n\n\t\t\t\t\t\trow1 = ele.insertRow(-1);\n\t\t\t\t\t\trow1.className = rowStyle;\n\t\t\t\t\t\tcell1 = row1.insertCell(-1);\n\t\t\t\t\t\tcell1.className = \"tddata\";\n\t\t\t\t\t\tcell1.innerHTML = \"<center><input type='hidden' id='img0_");
      out.print(reportGroupBean.getReportGroupId());
      out.write("' value='");
      out.print(request.getContextPath());
      out.write("/images/collapse.gif' /> \t<img id='img1_");
      out.print(reportGroupBean.getReportGroupId());
      out.write("' onclick='viewReports(");
      out.print(reportGroupBean.getReportGroupId());
      out.write(")'  src='");
      out.print(request.getContextPath());
      out.write("/images/inactiveexpand.gif' style='cursor: pointer;' />\"\n\n\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\tcell1 = row1.insertCell(-1);\n\t\t\t\t\t\tcell1.id = \"desc_");
      out.print(reportGroupBean.getReportGroupId());
      out.write("\";\n\t\t\t\t\t\tcell1.className = \"tddata\";\n\t\t\t\t\t\tcell1.innerHTML = \"<div style='float:left;'>");
      out.print(reportGroupBean.getTitle());
      out.write("&nbsp;</div><div id='star_");
      out.print(reportGroupBean.getReportGroupId());
      out.write("' style='visibility:hidden;float:left;'><font class='compfield'>*&nbsp;</font></div> <div id='cntshow_");
      out.print(reportGroupBean.getReportGroupId());
      out.write("' ></div>\"\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\trow1 = ele.insertRow(-1);\n\t\t\t\t\t\trow1.id = \"row_");
      out.print(reportGroupBean.getReportGroupId());
      out.write("\";\n\t\t\t\t\t\trow1.style.display=\"none\";\n\n\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\tcell1 = row1.insertCell(-1);\n\t\t\t\t\t\tcell1.className = \"tddata\";\n\t\t\t\t\t\tcell1.innerHTML = \"<input type='hidden' id='cnt_");
      out.print(reportGroupBean.getReportGroupId());
      out.write("' value ='0' >\"\n\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\tcell1 = row1.insertCell(-1);\n\t\t\t\t\t\tcell1.className = \"tddata\";\t\n\t\t\t\t\t\tcell1.innerHTML = \"<table id='tblinner");
      out.print(tblCount);
      out.write("' border='0' cellpadding='0' cellspacing='0' width='100%'>\";\n\n\t\t\t\t\t\tvar innerTable = document.getElementById(\"tblinner");
      out.print(tblCount);
      out.write("\");\n\t\t\t\t\t\t\n\t\t\t\t\t\tvar j=0;\n\t\t\t\t\t\t");

						tblCount++;
						boolean isChecked = false;
						
						for(int i=0; i<reportGroupRelationList.size(); i++){
							reportGroupRelationBean = (ReportGroupRelationBean)reportGroupRelationList.get(i);
							reportBean = ReportBean.getRecordbyPrimarykey(reportGroupRelationBean.getReportId());
							if(currReportIdList != null){
								isChecked = currReportIdList.contains(new Integer(reportBean.getReportId()));
							}

      out.write("\n\t\t\t\t\t\t\trow1 = innerTable.insertRow(-1);\n\n\t\t\t\t\t\t\tif(j==0){\n\t\t\t\t\t\t\t\trow1.className=\"trdark\";\n\t\t\t\t\t\t\t}\t\t\t\t\t\t\t\n\t\t\t\t\t\t\telse{\n\t\t\t\t\t\t\t\trow1.className=\"trlight\";\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\tj=1-j;\n\t\t\t\t\t\n\t\t\t\t\t\t\tcell1 = row1.insertCell(-1);\n\t\t\t\t\t\t\tcell1.className = \"tddata\";\n\t\t\t\t\t\t\tcell1.style.width=\"5%\";\n\t\t\t\t\t\t\tcell1.innerHTML=\"<center><input type='checkbox' id='chk_");
      out.print(reportGroupBean.getReportGroupId());
      out.write('_');
      out.print(i);
      out.write("' name='reportid'");
      out.print((isChecked)?"checked":"");
      out.write(" value='");
      out.print(reportBean.getReportId());
      out.write("' onclick='selectME(this,");
      out.print(reportGroupBean.getReportGroupId());
      out.write(")'>\"\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tcell1 = row1.insertCell(-1);\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tcell1.className = \"tddata\";\n\t\t\t\t\t\t\tcell1.innerHTML = \"");
      out.print(reportBean.getTitle());
      out.write("\";\n\t\t\t\t\t\t\t\n\n\t\t\t\t\t\t\t");
	if(isChecked){  
      out.write("\t\t\n\t\t\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\tselectME(document.getElementById(\"chk_");
      out.print(reportGroupBean.getReportGroupId());
      out.write('_');
      out.print(i);
      out.write('"');
      out.write(')');
      out.write(',');
      out.print(reportGroupBean.getReportGroupId());
      out.write(");\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\n\t\t\t\t\t\t\t");
		 			}
						}						
						
				}											
			}
		} 
      out.write("\n\n\t}\n");

	}

      out.write("\t\t\t\n}\n\n\n</script>\n</head>\n<body>\n\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.jsp", out, true);
      out.write("\n    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pageheader.jsp", out, true);
      out.write("  \n\t<div class=\"maincontent\" id=\"main_content\">\n\t\t<div class=\"reporttitlebar\">\n\t\t\t<div class=\"reporttitlebarleft\"></div>\n\t\t\t<div class=\"reporttitle\">");
      out.print(TranslationHelper.getTranslatedMessge("Custom View"));
      out.write("</div>\n\t\t</div>\n\t\t<br><br>\n\t\t\n");
		
		if(strProfileId == null || strProfileId.equalsIgnoreCase("")){
			header = TranslationHelper.getTranslatedMessge("Add Custom View");
		}
		else {
			header = TranslationHelper.getTranslatedMessge("Edit Custom View");
			iProfileId = Integer.parseInt(strProfileId);
			reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(iProfileId);
			mode = ApplicationModes.UPDATE_REPORT_PROFILE;
			currReportGroupRelList = (ArrayList)ReportGroupRelationBean.getReportGroupRelationBeanMap().get(new Integer(reportGroupBean.getReportGroupId()));
			currReportIdList = new ArrayList(currReportGroupRelList.size());
			for(int i=0; i<currReportGroupRelList.size(); i++){
				reportGroupRelationBean = (ReportGroupRelationBean)currReportGroupRelList.get(i); 
				currReportIdList.add(new Integer(reportGroupRelationBean.getReportId()));
			}
			isEdit = true;
		}		

      out.write("\n\n\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/iview\" method=\"post\" name=\"managereportprofileform\" >\n\t<input type=\"hidden\" name=\"appmode\" value=\"");
      out.print(mode);
      out.write("\" >\n\t<input type=\"hidden\" name=\"profileid\" value=\"");
      out.print((isEdit)?reportGroupBean.getReportGroupId():"");
      out.write("\" >\n\t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"margin-bottom: 2px;margin-left:2px;\">\n\t<tr>\n\t\t<td class=\"tdhead\" colspan=\"2\">");
      out.print(header);
      out.write("</td>\n\t</tr>\n\t<tr class=\"trdark\">\n\t\t<td class=\"tddata\" width=\"35%\">");
      out.print(TranslationHelper.getTranslatedMessge("Custom View Name :"));
      out.write(" </td>\n\t\t<td class=\"tddata\"><input type=\"text\" class=\"datafield\" value=\"");
      out.print((isEdit)?reportGroupBean.getTitle():"");
      out.write("\" name=\"profilename\" ");
      out.print((isEdit)?"readonly='readonly'":"");
      out.write("></td>\n\t</tr>\n\t<tr class=\"trdark\">\n\t\t<td class=\"tddata\">");
      out.print(TranslationHelper.getTranslatedMessge("Custom View Description :"));
      out.write(" </td>\n\t\t<td class=\"tddata\">\n\t\t\t<textarea class=\"datafield\" name=\"profiledesc\">");
      out.print(((isEdit && reportGroupBean.getDescription()!=null)?reportGroupBean.getDescription():""));
      out.write("</textarea>\n\t\t</td>\n\t</tr>\n\t<tr class=\"trdark\">\n\t\t<td class=\"tddata\">");
      out.print(TranslationHelper.getTranslatedMessge("Category Type :"));
      out.write(" </td>\n\t\t<td class=\"tddata\">\n\t\t<select id=\"customViewCategory\" name=\"customViewCategory\" style='width:27%' ");
      out.print((isEdit?"disabled=true":""));
      out.write(" onchange='getReportGroup()'>\n \n  \t\t");
   			
  			Iterator categoryBeanItr = CategoryBean.getAllCategoryIterator();  
  			CategoryBean categoryBean= null;
  			while(categoryBeanItr.hasNext()){
  				categoryBean = (CategoryBean)categoryBeanItr.next();			
				if(categoryBean.getCategoryId()== categoryId){ 
      out.write("   \t\t\t\t\n  \t\t\t\t\t<option value='");
      out.print(categoryBean.getCategoryId());
      out.write("' selected >");
      out.print(categoryBean.getCategoryName());
      out.write("</option>  \t\t\t\t\n  \t\t\t\t");
 }else{ 
      out.write("  \t\t\t\t  \t\t\t\t\n     \t\t\t\t\n  \t\t\t\t\t<option value='");
      out.print(categoryBean.getCategoryId());
      out.write('\'');
      out.write('>');
      out.print(categoryBean.getCategoryName());
      out.write("</option>  \t\t\t\t\n  \t\t");
 		}
  				}
  		
      out.write("\n  \t\t</select>\n\t\t</td>\n\t</tr>\n\t<tr class=\"trdark\">\n\t\t<td class=\"tddata\" >");
      out.print(TranslationHelper.getTranslatedMessge("Select Report :"));
      out.write(" </td>\n\t\t<td class=\"helpfont\">");
      out.print(TranslationHelper.getTranslatedMessge("You can select 8 reports"));
      out.write("</td>\n\t</tr>\n\t<tr class=\"trdark\">\n\t\t<td class=\"tddata\" colspan=\"2\" align=\"center\">\n\t\t\t<table id=\"reportList\" width=\"75%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"TableData\">\n\t\t\t\n\t\t\t<tr>\n\t\t\t\t<td class=\"tdhead\">&nbsp;</td>\n\t\t\t\t<td class=\"tdhead\">");
      out.print(TranslationHelper.getTranslatedMessge("Report Groups"));
      out.write("</td>\n\t\t\t</tr>\n\n\t\t\t<script>\n\t\t\t\tgetReportGroup();\n\t\t\t</script>\n\t\t\t\n\t\t\t</table>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td colspan=\"2\">&nbsp;</td>\n\t</tr>\n\t<tr>\n\t\t<td colspan=\"2\" align=\"center\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge((isEdit)?"Update":"Add"));
      out.write("\" onclick=\"validate()\">\n\t\t\t<input class=\"criButton\" type=\"button\" value=\"");
      out.print(TranslationHelper.getTranslatedMessge("Cancel"));
      out.write("\" onclick=\"location.href='");
      out.print( request.getContextPath() );
      out.write("/webpages/reportprofile.jsp'\">\n\t\t</td>\n\t</tr>\n\t</table>\n\t</form>\n\t</div>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pagefooter.jsp", out, true);
      out.write("\n</body>\n</html>\n");

	}catch(Exception  e){
	CyberoamLogger.appLog.debug("Exception in reportprofile.jsp : "+e,e);
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
