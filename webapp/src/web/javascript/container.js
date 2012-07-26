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

var conPath = "";
var reportid = "";
var qString = "";
var lastorderby="";
var lastordertype="";
var isSortOnColumn = true;
var isViewAllLink = false;
var searchQuery = '';
var columnDataFormat = new Array();
var DNSTimer = 0;

function setViewAllLink(viewAllFlag) {
	isViewAllLink = viewAllFlag;
}
function setSortOnColumn(sortValue) {
	isSortOnColumn = sortValue;
}
function setContextPath(path) {
	conPath = path;
}
function setQuaryString(str) {
	qString = str;
}
function replaceChar(str, char1, char2) {
	while (str.indexOf(char1) != -1) {
		str = str.replace(char1, char2);
	}
	return str;

}
function setTooltip(id,toolText){
	document.getElementById("Con_header"+id).title = toolText;
}
function setContainer(id, strhead, nevi, graph, table, size) {
	var ele = document.getElementById(id);
	if(strhead != ""){
		var newdiv = document.createElement("div");
		newdiv.className = "Con_header";
		newdiv.id = "Con_header" + id;
		newdiv.innerHTML = strhead;
		newdiv.innerHTML = newdiv.innerHTML
					+ "<div class='Min_button' ><IMG title=\"Minimize\" SRC='../images/min_button_up.gif' id='min_button"
					+ id + "' onclick=minContainer('" + id + "') width='15px' height='15px' /></div>";
		newdiv.innerHTML = newdiv.innerHTML
				+ "<div class='Close_button' ><IMG title=\"Close\" SRC='../images/close.jpg' id='close_button"
				+ id + "' onclick=closeContainer('" + id + "') width='15px' height='15px' /></div>";
		ele.appendChild(newdiv);
	}
	if (nevi == 1) {
		newdiv = document.createElement("div");
		//newdiv.className = "Con_nevi";
		newdiv.id = "Con_nevi" + id;
		ele.appendChild(newdiv);
	}
	if (graph == 1) {
		newdiv = document.createElement("div");
		newdiv.className = "Con_graph";
		newdiv.id = "Con_graph" + id;
		ele.appendChild(newdiv);
	}
	if (table == 1) {
		newdiv = document.createElement("div");
		newdiv.className = "Con_table";
		newdiv.id = "Con_table" + id;
		ele.appendChild(newdiv);
	}
	newdiv = document.createElement("div");
	newdiv.className = "hidden";
	newdiv.id = "hiddenDiv"+id;
	newdiv.innerHTML = "<input type='hidden' id='tablerow" + id	+ "' value='1'>"
			+ "<input type='hidden' id='totalCol" + id + "' value='1'>"
			+ "<input type='hidden' id='lastpage" + id + "' value='1'>"
			+ "<input type='hidden' id='pageSize" + id + "' value='" + size + "'>"
			+ "<input type='hidden' id='imgwidth" + id + "' value='380'>"
			+ "<input type='hidden' id='imgheight" + id + "' value='250'>"
			+ "<input type='hidden' id='totalNumOfDbRows" + id + "' value='undefined'>"
			+ "<input type='hidden' id='isfiltered" + id + "' value='false'>";
	ele.appendChild(newdiv);
}

function setImageWidth(id,width){
	document.getElementById("imgwidth"+id).value = width;	
}
function setImageHeight(id,height){
	document.getElementById("imgheight"+id).value = height;	
}
function setNevigation(id, pageList, hide) {
	var ele = document.getElementById("Con_nevi" + id);
	ele.className = "Con_nevi";
	var select = "<table width='100%' cellspacing='0' cellpadding='3'><tr>";
	if (pageList != null && pageList[0] > 0) {
		select  += '<td align="left" width="200px" class="navigationfont">'
			+ '<span style="float:left;margin-top:1px;">Show</span>'
			+ '<span style="float:left;margin-top:1px;"><div id="size'+id+'" class="Combo_container" style="margin-bottom:3px;"></div></span>'
			+ '<span style="float:left;margin-top:1px;">records per page</span></td>'
			+ '<td align="right" class="navigationfont">'
			+ '<span style="float:right;margin-right:2px;"><input type="button" class="navibutton" value="Go" onClick="jumpToPage('+id+')" ></span>'
			+ '<span style="float:right;"><input class="navitext" id="gotopage" size="2" type="text" style="margin-left:5px;margin-right:5px;padding-left:4px;"></span>'
			+ '<span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Go to page :</span>'
			+ '<span style="float:right;margin-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page&nbsp;<span id="page'+id+'">1</span><span id="totalRecSpan'+id+'">&nbsp;of&nbsp;1&nbsp;&nbsp;</span><input id="totalRecVal'+id+'" type="hidden" value="1" /></span>'
			+ '<span style="float:right"><img src="../images/first.bmp" style="cursor: pointer;" onClick="firstPage('+id+')" />'
			+ '<img src="../images/prev.bmp" style="cursor: pointer;" onClick="prevPage('+id+')" /><img src="../images/next.bmp" style="cursor: pointer;" onClick="nextPage('+id+')" />'
			+ '<img src="../images/last.bmp" style="cursor: pointer;" onClick="lastPage('+id+')" /></span></td>';
	}
	if (hide == 1) {
		if (document.getElementById("Con_graph" + id) != null)
			select = select
					+ "<td align='right' width='70px' class=\"navigationfont\"><span id='graphHide" + id
					+ "' class='mouseclick' onclick=showHideGraph('" + id
					+ "') style=\"float:left;font-weight:500;\">[Hide Graph]</span></td>";
		if (document.getElementById("Con_table" + id) != null)
			select = select
					+ "<td align='right' width='70px' class=\"navigationfont\"><span id='tableHide" + id
					+ "' class='mouseclick' onclick=showHideTable('" + id
					+ "') style=\"float:left;font-weight:500;\">[Hide Table]</span></td>";

	}
	select = select + "</tr></table>";
	ele.innerHTML = select;
	if (navigator.userAgent.indexOf("MSIE") == -1)
		ele.style.width = "100%";
	setComboContainer("size"+id,"50px",id);
	insertElements("size"+id,pageList);
	size = document.getElementById("pageSize" + id).value;
	setSelectedText("size"+id,size);

}

function nextPage(id) {
	var page = document.getElementById("page" + id).innerHTML;
	pageValue = parseInt(document.getElementById("page" + id).innerHTML);
	if(pageValue>=parseInt(document.getElementById("totalRecVal" + id).value)){
		alert("You are at last page.");
		return;
	}
	document.getElementById("page" + id).innerHTML = ++page;
	setContPage(id);
}
function prevPage(id) {
	var page = document.getElementById("page" + id).innerHTML;
	if (page != 1) {
		document.getElementById("page" + id).innerHTML = --page;
		setContPage(id);
	} else
		alert("You are at first page");
}
function firstPage(id) {
	var page = document.getElementById("page" + id).innerHTML;
	document.getElementById("page" + id).innerHTML = 1;
	setContPage(id);
}
function lastPage(id){
	var page = document.getElementById("page" + id).innerHTML;
	if (page != document.getElementById("totalRecVal" + id).value) {
		document.getElementById("page" + id).innerHTML = document.getElementById("totalRecVal" + id).value;
		setContPage(id);
	} else
		alert("You are at last page");
}
function jumpToPage(id){
	var pageValue = document.getElementById("gotopage").value;
	if(pageValue=="" || isNaN(pageValue) || parseInt(pageValue)<1 || parseInt(pageValue)>parseInt(document.getElementById("totalRecVal" + id).value)){
		alert("Enter valid page number.");
		document.getElementById("gotopage").value = '';
		return;
	} else {
		document.getElementById("gotopage").value = '';
		document.getElementById("page" + id).innerHTML = pageValue;
		setContPage(id);
	}
}
function sendAjaxRequest(id,ordertype,orderby) {
}
function setContPage(id) {
	var qry = "";
	if (document.getElementById("Con_table" + id) != null
			&& document.getElementById("Con_table" + id).className != "hidden")
		qry = qry + "&tabledata=on";
	if (document.getElementById("Con_graph" + id) != null)
		document.getElementById("Con_graph" + id).innerHTML = "";
	var strprocess = "<center><br/><img src=\"../images/progress.gif\"/></center>";
	var pageValue = 1;
	if (document.getElementById("page" + id) != null){
		pageValue = document.getElementById("page" + id).innerHTML;
		if(isNaN(pageValue) || parseInt(pageValue)<1 || parseInt(pageValue)>parseInt(document.getElementById("totalRecVal" + id).value)){
			alert("Enter valid page number.");
			return;
		}
	}
	if (document.getElementById("size" + id) != null){
		document.getElementById("pageSize" + id).value = getSelectedText("size"+id);
	}
	var sizeValue = document.getElementById("pageSize" + id).value;
	var offset = sizeValue * (pageValue - 1);
	if (sizeValue > 10) {
		hideGraph(id);
		if (document.getElementById("graphHide" + id) != null)
			document.getElementById("graphHide" + id).innerHTML = "";
	} else {
		showGraph(id);
		if (document.getElementById("graphHide" + id) != null)
			document.getElementById("graphHide" + id).innerHTML = "[Hide Graph]";
		if (document.getElementById("Con_graph" + id) != null
				&& document.getElementById("Con_graph" + id).className != "hidden"){
			qry = qry + "&graphdata=on";
			document.getElementById("Con_graph" + id).style.height = "15px";
		}
	}
	
	var imgWidth = document.getElementById("imgwidth"+id).value;
	var imgHeight = document.getElementById("imgheight"+id).value;
	if (document.getElementById("Con_table" + id) != null){
		document.getElementById("Con_table" + id).innerHTML = strprocess;
		document.getElementById("Con_table" + id).style.height = "100px";
	}
	var totalNumOfDbRows = document.getElementById("totalNumOfDbRows" + id).value;
	if(totalNumOfDbRows != 'undefined' && offset > totalNumOfDbRows){
		offset = parseInt(totalNumOfDbRows - (totalNumOfDbRows % sizeValue)); 
	}
	var queryString = "?"+qString+"&reportid="+id+"&offset=" + offset + "&limit="
			+sizeValue+"&imgwidth="+imgWidth+"&imgheight="+imgHeight+qry+lastorderby+lastordertype+"&issort="+isSortOnColumn;
	var url = conPath + "/AjaxController" + queryString + searchQuery;
	SimpleAJAXCall(url, ajaxRequest, "GET", id);
}



function ajaxRequest(xmlreq, id) {
	var ele = "";
	if(xmlreq){
		var root = xmlreq.getElementsByTagName('root').item(0);
		if(root==null){
			document.getElementById("Con_table" + id).innerHTML = "<center><font class=\"processdesc\">Data is not available.</font></center>";
			document.getElementById("Con_table" + id).style.height = "40px";
			return;
		}
		var totalRecSpan = document.getElementById("totalRecSpan" + id);
		if(root.getAttribute('totalRecord') != null && totalRecSpan != null){
			document.getElementById("totalNumOfDbRows" + id).value = root.getAttribute('totalRecord');
			var totalRec = Math.ceil(parseInt(root.getAttribute('totalRecord')) / parseInt(document.getElementById("Combo_selectsize" + id).innerHTML));
			if(totalRec == 0)
				totalRec = 1;
			totalRecSpan.innerHTML = '&nbsp;of&nbsp;' + totalRec +'&nbsp;&nbsp;'; 
			document.getElementById("totalRecVal" + id).value = totalRec;
			if(parseInt(document.getElementById("page" + id).innerHTML) > totalRec){
				document.getElementById("page" + id).innerHTML = totalRec;
			}
		}
		var iNode = 0;
		ele = document.getElementById("Con_table" + id);
		if (ele != null	&& ele.className != "hidden"){
			var tbl = "";
			tbl = "<table cellspacing='0' class='TableData' id='tableData" + id
			+ "' width='100%'>";
			var conLenght = parseInt(document.getElementById(id).style.width);
			var node = root.childNodes.item(iNode);
			var len = node.childNodes.length;
			if (len == 1)
				len++;
			for (i = 0; i < node.childNodes.length; i++) {
				var row = node.childNodes.item(i);
				if (i == 0) {
					document.getElementById("totalCol"+id).value = row.childNodes.length;
					var searchControl = '';
					var searchVariables = '';
					tbl = tbl + "<tr>";
					for ( var j = 0; j < row.childNodes.length; j++) {
						var col = row.childNodes.item(j);
						var rec = (col.childNodes.item(0).data).split("||");
						var ali;
						if (rec[1] == 3)
							ali = "center";
						else if (rec[1] == 1 || rec[1] == 0)
							ali = "left";
						else
							ali = "right";
						searchControl = '';
						columnDataFormat[j] = col.getAttribute("dataformat");
						if(col.getAttribute('issearchable')=='1'){
							if(document.getElementById("isfiltered"+id).value == 'false'){
							searchVariables += '<input type="hidden" id="dataformatid_'+id+'_'+j+'" name="dataformatid_'+id+'_'+j+'" value="'+col.getAttribute("dataformat")+'" />'
								+'<input type="hidden" id="searchColName_'+id+'_'+j+'" name="searchColName_'+id+'_'+j+'" value="'+rec[3]+'" />'
								+'<input type="hidden" id="searchCrit_'+id+'_'+j+'" name="searchCrit_'+id+'_'+j+'" value="2" />'
								+'<input type="hidden" id="searchValue_'+id+'_'+j+'" name="searchValue_'+id+'_'+j+'" value="" />'
								+'<input type="hidden" id="filterImg_'+id+'_'+j+'" name="filterImg_'+id+'_'+j+'" value="filtered.png" />';
							}
							if(document.getElementById("filterImg_"+id+"_"+j) != null && document.getElementById("searchValue_"+id+"_"+j) != ""){
								var filterImgPath = '../images/'+document.getElementById("filterImg_"+id+"_"+j).value;
								var searchValue = document.getElementById("searchValue_"+id+"_"+j).value;
								var searchCrit = document.getElementById("searchCrit_"+id+"_"+j).value;
								if(searchCrit == 0) searchCrit = "is";
								else if(searchCrit == 1) searchCrit = "is not";
								else if(searchCrit == 2) searchCrit = "contains";
								else searchCrit = "does not contain";
								if(navigator.userAgent.indexOf("Chrome")!=-1){
									searchControl = '<img id="filter_'+id+'_'+j+'" SRC=\''+filterImgPath+'\' height=\'15\' widht=\'15\' style=\'float:right;cursor:pointer;\' onclick=\'hideToolTip();showSearch('+id+','+j+',"'+rec[0]+'","'+rec[3]+'",'+columnDataFormat[j]+');\' onmouseover="showToolTip(event,\'&nbsp;&nbsp;&nbsp; '+rec[0]+' '+searchCrit+' '+searchValue+'\')" onmouseout=\"hideToolTip()\" />';
								}
								else{
									searchControl = '<img id="filter_'+id+'_'+j+'" SRC=\''+filterImgPath+'\' height=\'15\' widht=\'15\' style=\'float:right;margin-top:-15px;cursor:pointer;\' onclick=\'hideToolTip();showSearch('+id+','+j+',"'+rec[0]+'","'+rec[3]+'",'+columnDataFormat[j]+');\' onmouseover="showToolTip(event,\'&nbsp;&nbsp;&nbsp; '+rec[0]+' '+searchCrit+' '+searchValue+'\')" onmouseout=\"hideToolTip()\" />';
								}
							} else {
								if(navigator.userAgent.indexOf("Chrome")!=-1){
									searchControl = '<img id="filter_'+id+'_'+j+'" SRC=\'../images/filtered.png\' height=\'15\' widht=\'15\' style=\'float:right;cursor:pointer;\' onclick=\'showSearch('+id+','+j+',"'+rec[0]+'","'+rec[3]+'",'+columnDataFormat[j]+');\' />';
								}
								else{
									searchControl = '<img id="filter_'+id+'_'+j+'" SRC=\'../images/filtered.png\' height=\'15\' widht=\'15\' style=\'float:right;margin-top:-15px;cursor:pointer;\' onclick=\'showSearch('+id+','+j+',"'+rec[0]+'","'+rec[3]+'",'+columnDataFormat[j]+');\' />';
								}
							}
						}
						if(isSortOnColumn){
							ordertype="";
							orderby="&orderby="+rec[3];
							imagetag="";
							if(rec[2] == 0){ //Currently default sorting applied. 
								//So next click will be ascending order.
								ordertype="&ordertype=asc";
							}
							if(rec[2] == 1){//Current order is ascending
								//So next click will be descending order.
								ordertype="&ordertype=desc";
								imagetag="&nbsp;<IMG SRC='../images/arrowup.jpg' height='10' widht='9'>";
							}
							if(rec[2] == 2){ //Current order is desc
								//So next click will be evaluated default
								ordertype="&ordertype=asc";
								imagetag="&nbsp;<IMG SRC='../images/arrowdown.jpg' height='10' widht='9'>";
							}
							tbl = tbl + "<td align='"
								+ ali + "' class='tdhead'><span onclick='javascript:lastordertype=\""+ordertype+ "\"; lastorderby=\""+orderby+"\";firstPage("+id+")' id='thead" + id + "_" + i + "' style='cursor:pointer;'>" + rec[0]+"</span>"+imagetag + searchControl+"</td>";
						} else {
							tbl = tbl+"<td id='thead"+id+"_"+i+"' align='"+ali+"' class='tdhead'>"+rec[0]+searchControl+"</td>";
						}
					}
					if(document.getElementById("isfiltered"+id).value == 'false'){
						document.getElementById("isfiltered"+id).value = 'true';
						document.getElementById("hiddenDiv"+id).innerHTML += searchVariables;
					}
					if (node.childNodes.length == 1)
						tbl = tbl + '<tr class="trdark"><td class="tddata" colspan=7 align="center" >No Record Found</td></tr>';
				} else {
					if (i == 1)
						tbl = tbl + "<tbody id='tbody" + id + "'>"
					if (i % 2 == 0)
						tbl = tbl + "<tr class='trdark'>";
					else
						tbl = tbl + "<tr class='trlight'>";
					var dataformat = '';
					for ( var j = 0; j < row.childNodes.length; j++) {
						var col = row.childNodes.item(j);
						var rec = (col.childNodes.item(0).data).split("||");
						dataformat = '';
						if(columnDataFormat[j] == 5){
							dataformat = '&nbsp;<img SRC=\'../images/info.png\' height=\'10\' style="cursor:pointer" widht=\'10\' onclick=\'resolveDNS(event,'+id+',"'+rec[0]+'");\' onmouseout="hideToolTip()"/> ';
						}
						var ali = "";
						if (rec[1] == 3)
							ali = "center";
						else if (rec[1] == 2)
							ali = "right";
						else
							ali = "left";
						var cut = conLenght / (row.childNodes.length - 1);
						rec[3] = replaceChar(rec[3], "&emp;", "&");
						if (navigator.userAgent.indexOf("MSIE") != -1) {
							if (rec[0].length >= 75)
								rec[0] = rec[0].substring(0, 75) + "...";
							if (rec[3] != "") {
								tbl = tbl + "<td class='tddata' title=\"" + makeHTML(rec[2])
										+ "\" align='" + ali + "'><a href=" + rec[3]
										+ ">" + makeHTML(rec[0]) + "</a>"+dataformat+"</td>";
							} else {
								tbl = tbl + "<td class='tddata' title=\"" + makeHTML(rec[2])
										+ "\" align='" + ali + "'>" + makeHTML(rec[0])+dataformat + "</td>";
							}
						} else {
							if (rec[3] != "") {
								tbl = tbl + "<td class='tddata' title=\"" + makeHTML(rec[2])
										+ "\" style='max-width:" + cut
										+ ";' align='" + ali + "'><a href="
										+ rec[3] + ">" + makeHTML(rec[0]) + "</a>"+dataformat+"</td>";
							} else {
								
								tbl = tbl + "<td class='tddata' title=\"" + makeHTML(rec[2])
										+ "\" style='max-width:" + cut
										+ ";' align='" + ali + "'>" + makeHTML(rec[0])+ dataformat+ "</td>";
							}
						}
					}
					tbl = tbl + "</tr>";
				}
			}
			if(isViewAllLink && node.childNodes.length >= 6){
				len++;
				qString = qString.replace('others=true&','');
				tbl = tbl + "<tr><td colspan='"+row.childNodes.length+"'><a href='"+replaceQueryString(conPath+"/webpages/singlereport.jsp?"+qString,"reportid",id)+"'><b>View All</b></a></td></tr>";
			}
			tbl = tbl + "</table>";
			ele.innerHTML = tbl;
			document.getElementById("pageSize" + id).value = len;
			setTableHeight(id);
			highlighttable('tableData' + id);
			iNode++;
		}
		ele = document.getElementById("Con_graph" + id);
		if (ele != null	&& ele.className != "hidden" && root.childNodes.item(iNode) != null){
			var node = root.childNodes.item(iNode);
			var row = node.childNodes.item(0);		
			if (row.childNodes.length > 0) {
				
				if (window.ActiveXObject) {
					var imgMap  = row.childNodes.item(0).xml;			
				} else if (document.implementation && document.implementation.createDocument) {				
					var imgMap = (new XMLSerializer()).serializeToString(row.childNodes.item(0));
				} else {
					var imgMap = (new XMLSerializer()).serializeToString(row.childNodes.item(0));
				}
	 			
				var filename = (row.childNodes.item(1)).childNodes.item(0).data;          
				var graphURL = (row.childNodes.item(2)).childNodes.item(0).data;
				var width = (row.childNodes.item(3)).childNodes.item(0).data;
				var height = (row.childNodes.item(4)).childNodes.item(0).data;      
				ele.innerHTML = imgMap + ' <img src="' + graphURL + '" width=' + width +' height='+ height +' border=0 usemap="#' + filename + '"> ' ;
				ele.style.height = height + "px";
			}
		}
	}else{
		document.getElementById("Con_table" + id).innerHTML = "<center><font class=\"processdesc\"> Data is not available for this report</font></center>";
		document.getElementById("Con_table" + id).style.height = "40px";
	}
}
function setTableHeight(id) {
	var val = 0;
	row = document.getElementById("pageSize" + id).value;
	val = row * 18;
	val += 7;
	var ele = document.getElementById("Con_table" + id);
	ele.style.height = val + "px";
}

function hideNevi(id) {
	var ele = document.getElementById("Con_nevi" + id);
	if (ele.className == "Con_nevi") {
		ele.className = "hidden";
	} else {
		ele.className = "Con_nevi";
	}
}

function hideTable(id) {
	var ele = document.getElementById("Con_table" + id);
	var ele1 = document.getElementById("tableHide" + id);
	ele.className = "hidden";
	if (ele1 != null)
		ele1.innerHTML = "[Show Table]";
}
function showTable(id) {
	var ele = document.getElementById("Con_table" + id);
	var ele1 = document.getElementById("tableHide" + id);
	ele.className = "Con_table";
	if (ele1 != null)
		ele1.innerHTML = "[Hide Table]";
}

function showHideTable(id) {
	if (document.getElementById("Con_table" + id).className == "hidden")
		showTable(id);
	else
		hideTable(id);
}
function showHideGraph(id) {
	if (document.getElementById("Con_graph" + id).className == "hidden")
		showGraph(id);
	else
		hideGraph(id);
}
function hideGraph(id) {
	var ele = document.getElementById("Con_graph" + id);
	if (ele != null) {
		var ele1 = document.getElementById("graphHide" + id);
		ele.className = "hidden";
			if (ele1 != null)
				ele1.innerHTML = "[Show Graph]";
	}
}

function showGraph(id) {
	var ele = document.getElementById("Con_graph" + id);
	if (ele != null) {
		var ele1 = document.getElementById("graphHide" + id);
		ele.className = "Con_graph";
		if (ele1 != null)
			ele1.innerHTML = "[Hide Graph]";
	}
}
function closeContainer(id) {
	var obj = document.getElementById(id);
	obj.innerHTML = "";
	obj.className = "hidden";

}

function minContainer(id) {
	var ele = document.getElementById("container" + id);
	var obj = document.getElementById("min_button" + id);
	if (document.getElementById("Con_nevi" + id) != null)
		hideNevi(id);

	if (document.getElementById("Con_graph" + id) != null) {
		if (document.getElementById("graphHide" + id) == null
				|| (document.getElementById("graphHide" + id).innerHTML != "[Show Graph]" && document
						.getElementById("graphHide" + id).innerHTML != "")) {
			var ele = document.getElementById("Con_graph" + id);
			if (ele.className == "Con_graph")
				ele.className = "hidden";
			else
				ele.className = "Con_graph";
		}
	}
	if (document.getElementById("Con_table" + id) != null) {
		if (document.getElementById("chkall") != null) {
			if (document.getElementById("chkall").value == "on")
				showTable(id);
			else
				hideTable(id);
		} else {
			if (document.getElementById("tableHide" + id) == null
					|| document.getElementById("tableHide" + id).innerHTML != "[Show Table]") {
				var ele = document.getElementById("Con_table" + id);
				if (ele.className == "Con_table")
					ele.className = "hidden";
				else
					ele.className = "Con_table";
			}
		}
	}
	var file = obj.src.split("/");
	if (file[file.length-1] == "min_button_up.gif"){
		obj.title = "Restore";
		obj.src = "../images/min_button_down.gif";
	}else{
		obj.title = "Minimize";
		obj.src = "../images/min_button_up.gif";
	}
}
function setConWidth(id, width) {
	var ele = document.getElementById(id);
	ele.style.width = width;
}

function setGraph(id, graphURL,filename,imgwd,imght) {
	var ele = document.getElementById("Con_graph" + id);
	if (graphURL != null) {
	//	ele.innerHTML = '<div id="' + graph[0] + 'Div" align="center" style="background:white"> Chart.</div>';
	//	graph[3] = "99%";  
		
		ele.innerHTML = '<img src="' + graphURL + '" width=' + imgwd + ' height=' + imght + ' border=0 usemap="#' + filename + '">';
	//	var chart = new FusionCharts(graph[2], graph[0], graph[3], graph[4],
	//			graph[5], graph[6]);  
	//	chart.setDataXML('' + graph[1] + '');  
	//	chart.render('' + graph[0] + 'Div');  
		ele.style.height = imght + "px";
	}
}

function setTable(id, bodyList,url) {
	addTableRecord(id, bodyList,url);
	setTableHeight(id);
}

function setRecord(id) {
	setTableSize(id);
	setGraphRecord(id);
}

function setGraphRecord(id) {
	if (document.getElementById("Con_graph" + id) != null
			&& document.getElementById("graphHide" + id).innerHTML != ""
			&& document.getElementById("graphHide" + id).innerHTML != "[Show Graph]") {
		var graph = getGraph(id);
		setGraph(id, graph);
	}
}
function addTableRecord(id, record,url) {
	var ele = document.getElementById("Con_table" + id);
	var tbl = "<table cellspacing='0' class='TableData' id='tableData" + id
			+ "' width='100%'><tr>";
	var len = record.length;
	var conLenght = parseInt(document.getElementById(id).style.width);
	var len1 = record[0].length;
	if (navigator.userAgent.indexOf("MSIE") != -1) {
		len--;
		len1--;
	}
	for ( var i = 0; i < len1; i++) {
		var rec = (record[0][i]).split("||");
		var ali;
		if (rec[1] == 3)
			ali = "center";
		else if (rec[1] == 1 || rec[1] == 0)
			ali = "left";
		else
			ali = "right";
		tbl = tbl + "<td  id='thead" + id + "_" + i + "' align='" + ali
				+ "' class='tdhead'>" + rec[0] + "</td>";
	}
	tbl = tbl + "</tr>";
	if (record[1].length < len1 || len1 <= 1) {
		document.getElementById("pageSize" + id).value = 2;
		var rec = (record[1][0]).split("||");
		var ali = "";
		if (rec[1] == 3)
			ali = "center";
		else if (rec[1] == 1 || rec[1] == 0)
			ali = "left";
		else
			ali = "right";
		tbl = tbl + "<tr class='trdark'><td colspan=7 align=" + ali + ">"
				+ rec[0] + "</td></tr>";
	} else {
		if(typeof url != "undefined" && len >= 6)
			document.getElementById("pageSize" + id).value = len+1;
		else
			document.getElementById("pageSize" + id).value = len;
		for ( var row = 1; row < len; row++) {
			if (row % 2 == 0)
				tbl = tbl + "<tr class='trdark'>";
			else
				tbl = tbl + "<tr class='trlight'>";
			for ( var col = 0; col < len1; col++) {
				var rec = (record[row][col]).split("||");
				var ali = "";
				var cut = conLenght / (len1 - 1);
				if (rec[1] == 3)
					ali = "center";
				else if (rec[1] == 2 )
					ali = "right";
				else
					ali = "left";
				if(typeof rec[3] != "undefined")
					rec[3] = replaceChar(rec[3], "&emp;", "&");
				if (navigator.userAgent.indexOf("MSIE") != -1) {
					if (rec[0].length >= 40)
						rec[0] = rec[0].substring(0, 40) + "...";
					if (rec[3] != "") {
						tbl = tbl + "<td align='" + ali
								+ "' class='tddata' title='" + rec[0]
								+ "'><a href=" + rec[3] + ">" + rec[0]
								+ "</a></td>";
					} else {
						tbl = tbl + "<td align='" + ali
								+ "' class='tddata' title='" + rec[0] + "'>"
								+ rec[0] + "</td>";
					}
				} else {
					if (rec[3] != "") {
						tbl = tbl + "<td class='tddata' title='" + rec[0]
								+ "' style='max-width:" + cut + ";' align='"
								+ ali + "'><a href=" + rec[3] + ">" + rec[0]
								+ "</a></td>";
					} else {
						tbl = tbl + "<td class='tddata' title='" + rec[0]
								+ "' style='max-width:" + cut + ";' align='"
								+ ali + "'>" + rec[0] + "</td>";
					}
				}
			}
			tbl = tbl + "</tr>";
		}
	}
	if(typeof url != "undefined" && record[1].length >= len1  && len >= 6){
		tbl = tbl + "<tr><td colspan="+len1+" align=left >&nbsp;<a href="+url+"><b>View All</b></a></td></tr>";	
	}
	tbl = tbl + "</table>";
	ele.innerHTML = tbl;
	highlighttable('tableData' + id);
}

function highlighttable(tablename) {
	var table = document.getElementById(tablename);
	var rows = table.rows;
	for ( var i = 0; i < rows.length; i++) {
		rows[i].onmouseover = function() {
			this.className += 'hilite';
		}
		rows[i].onmouseout = function() {
			this.className = this.className.replace('hilite', '');
		}
	}
}
function highlightdiv(id) {	
	var ele = document.getElementById("Combo_body"+id);
	var eles = ele.getElementsByTagName("div");
	for (var x = 0; x < eles.length; x++) {
		if(eles[x].className.indexOf("Combo_item") != -1){
			eles[x].onmouseover = function() {
				this.className += '_hilite';
			}
			eles[x].onmouseout = function() {
				this.className = this.className.replace('_hilite', '');
			}	
		}
	}	
}
function showComboBody(id){
	var mainele = document.getElementById(id);
	var ele = document.getElementById("Combo_body"+id);
	if(ele.className!="hidden"){
		ele.className = "hidden";
	}else{
		ele.className="Combo_body";		
		var flag = document.getElementById("comboFlag"+id).value;
	}
}
function setComboContainer(id,width,mainid) {
	var combo = document.getElementById(id);
	combo.onclick = function(){showComboBody(this.id)};
	combo.style.width = width;
	var newdiv = document.createElement("div");
	newdiv.className = "Combo_select";
	newdiv.id = "Combo_select"+id;
	newdiv.innerHTML = "Select item";
	newdiv.style.width = (parseInt(combo.style.width) - 20)+"px";
	combo.appendChild(newdiv);
	
	newdiv = document.createElement("div");
	newdiv.className = "Combo_button";
	newdiv.innerHTML="<input type=\"hidden\" id=\"comboFlag"+id+"\" value="+mainid+" />";
	newdiv.style.left=(parseInt(combo.style.width)-20)+"px";
	combo.appendChild(newdiv);
	newdiv = document.createElement("div");
	newdiv.id="Combo_body"+id;
	newdiv.className="hidden";
	combo.appendChild(newdiv);
}
function setSelectedText(id,text){
	document.getElementById("Combo_select"+id).innerHTML = text;
}
function getSelectedText(id){
	return document.getElementById("Combo_select"+id).innerHTML;
}
function selectCombo(id,index){
	ele = document.getElementById("Combo_item"+id+"_"+index);
	document.getElementById("Combo_select"+id).innerHTML = ele.innerHTML;
	var mainid = document.getElementById("comboFlag"+id).value;
	setContPage(mainid);
}

function insertElements(id,arr){
	var flag = document.getElementById("comboFlag"+id).value;
	var ele = document.getElementById("Combo_body"+id);
	for(var x=0 ; x< arr.length ;x++){
		newdiv = document.createElement("div");
		newdiv.className = "Combo_item_single";
		newdiv.id = "Combo_item"+id+"_"+x;
		newdiv.onclick = function(e){
							var str = this.id;
							var index = str.lastIndexOf("_");
							var myid = str.substring(10,index);
							var pos = str.substring(index+1);
							selectCombo(myid,pos,e);
						}
		newdiv.innerHTML = arr[x];
		ele.appendChild(newdiv);
	}
	highlightdiv(id);
}
function showSearch(id,columnid,colName,dbcolName,formatid){
	var searchVal = document.getElementById("searchValue_"+id+"_"+columnid).value;
	var i = parseInt(document.getElementById("searchCrit_"+id+"_"+columnid).value);
	document.getElementById("reportid").value = id;
	document.getElementById("columnid").value = columnid;
	document.searchreport.searchCritValue.options[i].selected = 'selected';
	document.searchreport.confirm.style.display = '';
	document.searchreport.searchCritValue.style.display = '';
	document.getElementById("searchDiv").style.display = 'block';
	document.getElementById("TB_overlay").style.display = 'block';
	document.getElementById("searchLabel").innerHTML = colName;
	document.getElementById("searchHead").innerHTML = 'Filter by ' + colName;
	document.getElementById("searchLabeltxt").innerHTML = '<input type="text" value="'+searchVal+'" maxlength="50" style="width: 180px;" class="datafield" name="txtsearchrep" id="name="txtsearchrep" autocomplete=off />';
	getWinSize("searchDiv");
	document.searchreport.txtsearchrep.focus();
	
}	
function hideSearch(){
	document.getElementById("searchDiv").style.display = 'none';
	document.getElementById("TB_overlay").style.display = 'none';
}
function clearSearch(){
	document.searchreport.txtsearchrep.value='';
	document.searchreport.txtsearchrep.focus();	
}
function getSearchResult(){
	var id = document.searchreport.reportid.value;
	var i = document.searchreport.searchCritValue.selectedIndex;
	var condition = document.searchreport.searchCritValue.options[i].value;
	var columnid = document.getElementById("columnid").value;
	var searchVal = document.getElementById("searchValue_"+id+"_"+columnid);
	var colName = document.getElementById("searchColName_"+id+"_"+columnid);
	var colValue = document.searchreport.txtsearchrep.value;
	searchVal.value = document.searchreport.txtsearchrep.value;
	document.getElementById("searchCrit_"+id+"_"+columnid).value = i;
	if(document.searchreport.txtsearchrep.value == ''){
		searchQuery = '';
		document.getElementById("searchCrit_"+id+"_"+columnid).value = 2;
		document.getElementById("filterImg_"+id+"_"+columnid).value = 'filtered.png';
	} else {
		document.getElementById("filterImg_"+id+"_"+columnid).value = 'filter.png';
		if(condition == 'like' || condition == 'not like'){
			colValue = '%25' + colValue + '%25';
		}
		if(document.getElementById("dataformatid_"+id+"_"+columnid).value == 5) {
			searchQuery = '&searchquery=INET_NTOA('+colName.value+') '+condition+' \''+colValue+'\'';
		} else {
			searchQuery = '&searchquery=lower('+colName.value+') '+condition+' lower(\''+colValue+'\')';
		}
	}
	var totalCol = document.getElementById("totalCol"+id).value;
	for(i=0;i<totalCol;i++){
		if(document.getElementById("searchValue_"+id+"_"+i) != null && i!=columnid){
			if(document.getElementById("searchValue_"+id+"_"+i).value != ''){
				condition = document.searchreport.searchCritValue.options[document.getElementById("searchCrit_"+id+"_"+i).value].value;
				colValue = document.getElementById("searchValue_"+id+"_"+i).value;
				if(condition == 'like' || condition == 'not like'){
					colValue = '%25' + colValue + '%25';
				}
				if(document.getElementById("dataformatid_"+id+"_"+i).value == 5) {
					if(searchQuery == '')
						searchQuery += '&searchquery=INET_NTOA('+document.getElementById("searchColName_"+id+"_"+i).value+') '+condition+' \''+colValue+'\'';
					else
						searchQuery += ' and INET_NTOA('+document.getElementById("searchColName_"+id+"_"+i).value+') '+condition+' \''+colValue+'\'';
				} else {
					if(searchQuery == '')
						searchQuery += '&searchquery=INET_NTOA('+document.getElementById("searchColName_"+id+"_"+i).value+') '+condition+' \''+colValue+'\'';
					else
						searchQuery += ' and lower('+document.getElementById("searchColName_"+id+"_"+i).value+') '+condition+' lower(\''+colValue+'\')';
				}
			}
		}
	}
	var strprocess = "<center><br><img src=\"../images/progress.gif\"/></center>";
	if (document.getElementById("Con_graph" + id) != null){
		document.getElementById("Con_graph" + id).innerHTML = "";
		document.getElementById("Con_graph" + id).style.height = "20px";
	}
	if (document.getElementById("Con_table" + id) != null){
		document.getElementById("Con_table" + id).innerHTML = strprocess;
		document.getElementById("Con_table" + id).style.height = "120px";
	}
	var imgWidth = document.getElementById("imgwidth"+id).value;
	var imgHeight = document.getElementById("imgheight"+id).value;
	var limit = 5;
	if(document.getElementById("Combo_selectsize" + id) != null)
		limit = document.getElementById("Combo_selectsize" + id).innerHTML;
	var queryString = "?"+qString+"&tabledata=on&graphdata=on&reportid="+id+"&offset=0&limit="+limit+"&imgwidth="+imgWidth+"&imgheight="+imgHeight;
	var url = conPath + "/AjaxController" + queryString + searchQuery;
	SimpleAJAXCall(url, ajaxRequest, "GET", id);
	hideSearch();
	return false;
}
function resolveDNS(e,id,colName){
	if(DNSTimer != 1){
		DNSTimer = 1;
		showToolTip(e,'<img src="../images/loader.gif" />Resolving DNS...');
		var url = conPath + "/AjaxController?resolvedns=true&ip="+colName;
		SimpleAJAXCall(url, handleResolveDNS, "GET", id, e);
	}
}
function handleResolveDNS(xmlreq, id, e){
	if(xmlreq){
		DNSTimer=0;
		var root = xmlreq.getElementsByTagName('root').item(0);
		if(root==null){
			document.getElementById("searchLabel").innerHTML = '';
			document.getElementById("searchLabeltxt").innerHTML = '&nbsp;&nbsp;&nbsp;Error while resolving DNS.';
		}else{
			document.getElementById("searchLabel").innerHTML = '';
			if(root.childNodes.item(0).childNodes.item(0).data == root.childNodes.item(1).childNodes.item(0).data){
				showToolTip(e,'&nbsp;&nbsp;&nbsp;Can not resolve DNS ');
			} else {
				showToolTip(e,'<b>&nbsp;&nbsp;&nbsp;' + root.childNodes.item(1).childNodes.item(0).data+'</b>');
			}
		}
	}
}
function showToolTip(e,text){
	if(document.all) e = event;
	if(e == null) return;
	var obj = document.getElementById('bubble_tooltip');
	var obj2 = document.getElementById('bubble_tooltip_content');
	obj2.innerHTML = text;
	obj.style.display = 'block';
	var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
	if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0; 
	var leftPos = e.clientX-50;
	if(leftPos<0)leftPos = 0;
	obj.style.left = leftPos + 'px';
	obj.style.top = e.clientY - obj.offsetHeight + st + 'px';
}
function hideToolTip(){
	document.getElementById('bubble_tooltip').style.display = 'none';
}

function getPDF(id,grpid) {
	var aTag=null;
	var qry ="pdfdata=single&";		
	aTag=document.getElementById("pdfLinkForSingle");
	var sizeValue = 5;	
	if(document.getElementById("Combo_selectsize" + id) != null){
		sizeValue = document.getElementById("Combo_selectsize" + id).innerHTML;
	}
	if(aTag==null){
		aTag=document.getElementById("pdfLinkForGroup");
		qry = "pdfdata=group&";
		sizeValue = "10";
	}			
	var pageValue = 1;	
	if (document.getElementById("page" + id) != null){
		pageValue = document.getElementById("page" + id).innerHTML;		
	}
	if(qString==""){
		qString = "reportid="+id+"&reportgroupid="+grpid;
	}
	
	var imgWidth =document.getElementById("imgwidth"+id).value;	
	var imgHeight = document.getElementById("imgheight"+id).value;
	var offset = sizeValue * (pageValue - 1);
	var queryString = "?"+qry+qString+"&offset=" + offset + "&limit="+sizeValue+"&imgwidth="+imgWidth+"&imgheight="+imgHeight+lastorderby+lastordertype;
	var url = conPath + "/iview.pdf" + queryString + searchQuery;		
	aTag.target="blank";
	aTag.href=url;
}
function getXLS(id,grpid) {
	var aTag=null;
	var qry ="xlsdata=single&";		
	aTag=document.getElementById("xlsLinkForSingle");
	var sizeValue = document.getElementById("pageSize" + id).value-1;
	if(aTag==null){
		aTag=document.getElementById("xlsLinkForGroup");
		qry = "xlsdata=group&";
		sizeValue = "10";
	}			
	var pageValue = 1;	
	if (document.getElementById("page" + id) != null){
		pageValue = document.getElementById("page" + id).innerHTML;		
	}
	if(qString==""){
		qString = "reportid="+id+"&reportgroupid="+grpid;
	}
		
	var imgWidth =document.getElementById("imgwidth"+id).value;	
	var imgHeight = document.getElementById("imgheight"+id).value;
	var offset = sizeValue * (pageValue - 1);
	var queryString = "?"+qry+qString+"&offset=" + offset + "&limit=1000&imgwidth="+imgWidth+"&imgheight="+imgHeight+lastorderby+lastordertype;
	var url = conPath + "/iview.xls" + queryString + searchQuery;
		
	aTag.target="blank";
	aTag.href=url;
}
function getXLSFile(limit,offset,tblname,str,indexCriteria){
	var aTag=null;
	if(aTag==null){
		aTag=document.getElementById("xlsLinkForArchive");
		qry = "archive=abc";
		sizeValue = "10";
	}	
	var url = conPath + "/iview.xls?archive=1&limit=1000&offset="+offset+"&strCriteria="+str+"&tblname="+tblname+"&indexCriteria="+indexCriteria;	
	aTag.target="blank";
	aTag.href=url;
}
function makeHTML(dataStr) {                                                                                                 
    dataStr = dataStr.replace('>','&gt;');                                                                      
    dataStr = dataStr.replace('<','&lt;');                                                             
    dataStr = dataStr.replace('"','&quot;');                                      
    return dataStr;                                                                                                      
}    

function checkBlankBookmark(url){
	document.getElementById("url").value=decodeURIComponent(url.replace(/\+/g, " "));
	if(document.getElementById("bm_name").value=="")
	{
		alert("Please Enter Bookmark Name");
		return false;
	}
	if(document.getElementById("newbkgroup")!=null){
		if(document.getElementById("newbkgroup").value==""){
			alert("Please Enter Bookmark Group Name");
			return false;
		}
	}
	return true;
}

function addnewgroup(){
	var selectedindex=document.getElementById("bm_group").selectedIndex;
	var gpvalue=document.getElementById("bm_group").options[selectedindex].value;
	var addtext=document.getElementById("newgroup");
	if(gpvalue==0){
	addtext.innerHTML="<input type='text'id='newbkgroup' name='newbkgroup' maxlength='20'>";
	}
	else{
		addtext.innerHTML="";
	}
}

