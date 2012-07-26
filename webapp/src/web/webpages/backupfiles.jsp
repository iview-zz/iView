<!-- ***********************************************************************
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
*********************************************************************** -->
   
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="org.cyberoam.iview.mlm.TranslationHelper"%>
<%@page import="org.cyberoam.iview.utility.IViewPropertyReader"%>
<%@page import="org.cyberoam.iview.utility.BackupRestoreUtility"%>
    
<html>
<body>
<div style="z-index:99999;">

<form action="<%=request.getContextPath()%>/BackupServlet?choice=1" method="post" name="frmbackup">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">	
		<tr class="innerpageheader">
			<td width="3%">&nbsp;</td>
			<td class="contHead">Backup Files</td>
			<td colspan="3" align="right" style="padding-right: 5px;padding-top: 2px;">
			<img src="../images/close.jpg" width="15px" height="15px" onclick="handleThickBox('2','backuprestore')" style="cursor: pointer;">
			</td>
		</tr>
	</table>

<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	File dstPath=new File(IViewPropertyReader.BackupDIR);
	String filenames[]=dstPath.list();
	int recordcount;
	int height=filenames.length > 18 ? 396:(filenames.length+1)*23;
%>

<div style='width:500px; height: <%=height%>px; overflow:auto' align="center">

<table class="TableData" width="100%" cellspacing="0" cellpadding="0">
	<tr height="22px">
		<td class="tdhead"> <input name="selectall" type=checkbox onclick="selectAll(this);"/></td>	
		<td class="tdhead" style="padding-left:10px"><b><%=TranslationHelper.getTranslatedMessge("Filename")%></b></td>
		<td align="center" class="tdhead"><b><%=TranslationHelper.getTranslatedMessge("Download")%></b></td>		
	</tr>
	
<%	for(recordcount=0;recordcount<filenames.length;recordcount++){
		if(BackupRestoreUtility.isValidArchiveFile(IViewPropertyReader.BackupDIR+filenames[recordcount])==-1){
			continue;			
		}
%>
	
	<tr height="22px">
		<td class="tddata"><input type=checkbox name="filenames" value="<%=filenames[recordcount]%>" onclick="DeSelectAll(this);"></input></td>
		<td class="tddata"><%=TranslationHelper.getTranslatedMessge(filenames[recordcount])%></td>
		<td class="tddata" align="center"><a href="<%=request.getContextPath()%>/backup/
		<%=filenames[recordcount]%>?choice=2"><%=TranslationHelper.getTranslatedMessge("Download")%></a></td>		
		
	</tr>		
	
<% } %>
   
</table>

</div>

<table align="center">
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="criButton" value="<%=TranslationHelper.getTranslatedMessge("Delete")%>" onClick="return confirmAction(this);">			
			<input type="button" class="criButton" value="<%=TranslationHelper.getTranslatedMessge("Cancel")%>" onclick="return handleThickBox('2','backuprestore')">
		</td>
	</tr>
</table>
	
</form>	
</div>
</body>
</html>
