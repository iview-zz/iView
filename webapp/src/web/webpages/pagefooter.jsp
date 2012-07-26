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

<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript"> 
function resize(){ 
	var htmlheight = document.body.parentNode.clientHeight; 
	var windowheight = window.screen.height; 
	var sidebar = document.getElementById("sidebar"); 
	if ( htmlheight < windowheight )	 { 
		sidebar.style.height = windowheight + "px";
	} 
} 
</script> 
</head>
<body>
<script> resize();</script>
<table width="100%" border="0" class="pagefooter" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" class="footerHead">&copy;&nbsp;&nbsp;Elitecore Technologies Ltd.</td>
</tr>
<tr>
	<td align="center" class="footerBody">The Program is provided AS IS, without warranty. Licensed under <a target="_blank"  class="pagefooterlink" href="<%=request.getContextPath()%>/LICENSE.txt" style="color:#08467C">GPLv3</a>. This program is free software; you can redistribute it and/or modify it under the terms of the <a target="_blank" class="pagefooterlink" href="<%=request.getContextPath()%>/LICENSE.txt" style="color:#08467C">GNU General Public License version 3</a> as published by the Free Software Foundation including the additional permission set forth in the source code header.</td>
</tr>
<tr>	
	<td align="center"><img style="cursor:pointer" src="../images/InitiativeLogo.png" onclick="window.open('http://www.cyberoam.com','blank')" /></td>
</tr>
</table>
</body>
</html>
