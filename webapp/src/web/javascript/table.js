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

	function setTableNevi(id,pageList,line,hide){
		var ele = document.getElementById(id);
		if (ele.childNodes && ele.childNodes.length > 0) {
			for (var x = 0; x < ele.childNodes.length; x++) {
				if("TableNevi" == ele.childNodes[x].className){
					ele.childNodes[x].style.visibility ="";
					ele.childNodes[x].style.position ="relative";
					ele.childNodes[x].id = "TableNevi" + id;					
					var select = "<input type='hidden' id='tablerow"+id+"' value="+line+"><table width=100% ><tr>";
					if(pageList!=null && pageList[0] > 0){
						select = select + "<td align='left'>Result per page <select id='size"+id+"' onChange=setTableSize('"+id+"')>";
						for(var i=0;i<pageList.length;i++){
							select = select + "<option value='"+pageList[i]+"'>"+pageList[i]+"</option>";
						}
						select = select + "</select</td>";
						select = select +"<td></td>";

				    	select =select +  "<td align='right'>Page :<select id='page"+id+"' onChange=findTableRecord('"+id+"') height='50px'>";
						for(var i=1;i<line/pageList[0];i++)
							select = select + "<option value='"+i+"'>"+i+"</option>";
						if(line%pageList[0] != 0)
							select = select + "<option value='"+i+"'>"+i+"</option>";
						select = select + "</select></td>"
					}

					if(hide == 1){
						select = select + "<td align='right'><div id='tableHide"+id+"' class='mouseclick' onclick=hideTable('"+id+"')>[Hide]</div></td>"
					}
					select = select + "</tr></table>";
					ele.childNodes[x].innerHTML = select;
				}
			}
		}
		if(navigator.userAgent.indexOf("MSIE")==-1)
			document.getElementById("TableNevi"+id).style.width = "99.5%";
	}

	function hideTable(id){
		var ele=document.getElementById("table"+id);
		var ele1=document.getElementById("tableHide"+id);
		if(ele.style.position == "relative"){
			ele.style.visibility = "hidden";
			ele.style.position="absolute";
			ele1.innerHTML = "[Hide]";
		}else{
			ele.style.visibility = "";
			ele.style.position="relative";
			ele1.innerHTML = "[Show]";
		}

	}
	function findTableRecord(id){
		var size=document.getElementById("size"+id);
		var page=document.getElementById("page"+id);
		var record_no;
		if(size != null)
			record_no =  parseInt(size.value) * (parseInt(page.value)-1);
		else
			record_no =  1;
		if(document.getElementById("Line"+id+"_"+record_no)){
			if(navigator.userAgent.indexOf("Chrome")!=-1)	
				removeHeader(id);
			goTablePage(id,record_no);
		}
		else{
			var data;
			if(size != null)
				data = getRecord(size.value,page.value);
			else
				data = getRecord(document.getElementById("pageSize"+id).value,1);
			if(data == 0)
				alert("page not Found");
			else
				addTableRecord(id,record_no,data);
		}
		if(size != null)
			document.getElementById("lastpage"+id).value = page.value;
	}

	function removeHeader(id){
		var ele = document.getElementById("tableData"+id);
		var elTableRows = ele.getElementsByTagName("tr");
		if(document.getElementById("lastpage"+id).value != 1){
			for(var row=0;row<elTableRows.length;row++){
				if(document.getElementById("headRow"+id) == elTableRows[row]){
						break;
				}
			}
			ele.deleteRow(row);			
		}
	}

	function addTableRecord(id,rowid,record){
		var ele=document.getElementById("tableData"+id);
		var totCol = document.getElementById("totalCol"+id).value;
		var page = document.getElementById("page"+id);
		var pageValue;
		if(page != null)
			pageValue = page.options[page.selectedIndex].value;
		else
			pageValue = 1;

		var size = document.getElementById("size"+id);
		var sizeValue;
		if(size != null)
			sizeValue = size.options[size.selectedIndex].value;
		else
			sizeValue =  document.getElementById("pageSize"+id).value;
		for(var i = rowid; i > 0;i=i-sizeValue){
			if(document.getElementById("Line"+id+"_"+i))
				break;
		}
		var row;
		var elTableRows = ele.getElementsByTagName("tr");
		for(row=0;row<elTableRows.length;row++){
			if(document.getElementById("Line"+id+"_"+i) == elTableRows[row]){
					break;
			}
		}
		if(row != 2)
			row = row + parseInt(sizeValue);
		else
			row = 1;
		
		for(var i=0;i<sizeValue;i++){
			var rowele = ele.insertRow(row+i);
			if(i%2 == 0)
				rowele.className = "trdark";
			else
				rowele.className = "trlight";
			
			rowele.id = "Line"+id+"_"+rowid;
			rowid++;
			var len = 0;
			if(navigator.userAgent.indexOf("MSIE")!=-1)
				len = parseInt(record[i].length) - 1;
			else
				len = parseInt(record[i].length);
			if(len==1){
				var cel = rowele.insertCell(0);
				cel.colSpan=totCol;
				cel.style.textAlign="center";
				cel.innerHTML = record[i][0];
			}else{
				for(var j=0;j<len;j++){
					var rec = (record[i][j]).split("||");
					var cel = rowele.insertCell(j);
					cel.title = rec[2];
					if(rec[1]==1)
						cel.style.textAlign="left";
					else if(rec[1]==0)
						cel.style.textAlign="center";
					else 
						cel.style.textAlign="right";
					cel.className= "tddata";
					cel.innerHTML = rec[0];
				}
			}
		}
		findTableRecord(id);
	}

	function setTableHeader(id,headList){
		var ele = document.getElementById(id);
		
		var newdiv = document.createElement("div");
		newdiv.className="TableNevi";
		ele.appendChild(newdiv);
		newdiv = document.createElement("div");
		newdiv.className="tableContainer";
		ele.appendChild(newdiv);
		
		if (ele.childNodes && ele.childNodes.length > 0) {
			for (var x = 0; x < ele.childNodes.length; x++) {
				if("tableContainer" == ele.childNodes[x].className){
					ele.childNodes[x].id = "table" + id;
					ele.childNodes[x].style.position="relative";
					var tbl= "<input type='hidden' id='totalCol"+id+"' value='1'>" +
							"<input type='hidden' id='lastpage"+id+"' value='1'>" +
							"<input type='hidden' id='pageSize"+id+"' value=''>" +
							"<table cellspacing='0' class='TableData' id='tableData"+id+"'><thead><tr>";
					var len = 0;
					if(navigator.userAgent.indexOf("MSIE")!=-1)
						len = headList.length - 1;
					else
						len = headList.length;
					for(var i=0;i<len;i++){
						var rec = (headList[i]).split("||");
						var ali ;
						if(rec[1] == 0)ali ="center";else if(rec[1] == 1)ali ="left";else ali ="right";
						tbl = tbl + "<td  id='thead"+id+"_"+i+"' align='"+ali+"'>"+rec[0]+"</td>";					
						}
					tbl = tbl + "</tr></thead>";
					tbl = tbl + "<tbody id='tbody"+id+"'><tr></tr>";
					tbl = tbl + "</tbody>";
					tbl = tbl + "</table>";
					ele.childNodes[x].innerHTML = tbl;
					if(navigator.userAgent.indexOf("Chrome")==-1)
						ele.childNodes[x].style.marginBottom= "-22px";
					else
						ele.childNodes[x].style.marginBottom= "-12px";
				}
			}
		}
		document.getElementById("totalCol"+id).value = headList.length;
	}

	function goTablePage(id,record_no){		
		var page = document.getElementById("page"+id);
		var pageValue;
		if(page!= null)
			pageValue = page.options[page.selectedIndex].value;
		else
			pageValue = 1;
		var elTable = document.getElementById("tableData"+id);
		var elTableRows = elTable.getElementsByTagName("tr");
		var row;
		for(row=0;row<elTableRows.length;row++){
			if(document.getElementById("Line"+id+"_"+record_no) == elTableRows[row])
				break;
		}
		
		var nAgt = navigator.userAgent;
		if(nAgt.indexOf("Chrome")!=-1 && pageValue != 1){
			var row1 = elTable.insertRow(row);
			row1.id = "headRow"+id;
			for(var j=0;j<document.getElementById("totalCol"+id).value;j++){
				var cel1 = row1.insertCell(j);
				cel1.className="tdhead";
				cel1.innerHTML = document.getElementById("thead"+id+"_"+j).innerHTML;;
			}
		}

		var nAgt = navigator.userAgent;
		var col = 0;
		if(nAgt.indexOf("MSIE")!=-1)
			col = (row-1) * 18;
		else if(nAgt.indexOf("Chrome")!=-1)
			col = (row) * 19 + 5;
		else
			col = (row-1) * 19;
		if(nAgt.indexOf("Firefox")!=-1)
			document.getElementById("tbody"+id).scrollTop = col;
		else
			document.getElementById("table"+id).scrollTop = col ;

	}

	function setTableSize(id){
		var obj = document.getElementById("size"+id);
		var row = parseInt(obj.options[obj.selectedIndex].value);
		setTableHeightByPage(id,row);
		var nAgt = navigator.userAgent;
		if(nAgt.indexOf("Firefox")!=-1){
			var elBody = document.getElementById("tbody"+id);
			elBody.innerHTML = "<tr></tr>";
		}else
		{
			var elTable = document.getElementById("tableData"+id);
			var elTableRows = elTable.getElementsByTagName("tr");
			var row = elTableRows.length - 2;
			for(;row > 0;row--){
				elTable.deleteRow(1);
			}
		}
		findTableRecord(id);

	}

	function setTableHeightByPage(id,row){
		var val =0;
		var nAgt = navigator.userAgent;
		if(nAgt.indexOf("Chrome")!=-1 || nAgt.indexOf("Safari")!=-1)
			val = row * 19 + 22;
		else if(nAgt.indexOf("MSIE")!=-1)
			val = row * 18 + 22;
		else 
			val = row * 19 + 41;
		setTableHeight(id,val);
		var page = document.getElementById("page"+id);
		document.getElementById("pageSize"+id).value = row;
		if(page!=null){
			var trow = document.getElementById("tablerow"+id);
			for(;page.options.length > 0;){			
				page.remove(page.options[0].index);
			}		
			for(var i=1;i<trow.value/row;i++){
				var opt = document.createElement("option");
				page.options.add(opt);
				opt.text = i;
				opt.value = i;		
			}
			if(trow.value%row != 0){
				var opt = document.createElement("option");
				page.options.add(opt);
				opt.text = i;
				opt.value = i;
			}
		}
	}

	function setTableHeight(id,heigth){
		var ele = document.getElementById("table"+id);
		var mainele = document.getElementById(id);
		var ele1 = document.getElementById("tbody"+id);
		ele.style.height = heigth+"px";
		if(navigator.appName != "Microsoft Internet Explorer" )
			ele1.style.height = (heigth-40)+"px";
	}

	function setTableWidth(id,width){
		var ele = document.getElementById("table"+id);
		var mele = document.getElementById(id);
		mele.style.width = width+"px";
		ele.style.width = width+"px";
	}
