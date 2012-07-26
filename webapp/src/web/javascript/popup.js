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
	var currentEle = "";
	var popupForm = 0;
	
	document.onclick = closeElements;
	
	function closeElements(evt){
		if(currentEle != "" && popupForm == 0){
			var X=0;
			var Y=0;
			if (navigator.appName != "Microsoft Internet Explorer") {
				X = evt.pageX;
				Y = evt.pageY;
			} else{
				X = event.clientX + document.body.scrollLeft;
				Y = event.clientY + document.body.scrollTop;
			}
			eles = currentEle.split("|");
			if(eles[1] == "dragedList")
				hidedragedList(eles[0],X,Y);
			else if(eles[1] == "popup"){
				
				hideMe(eles[0],X,Y);
			}
			else if(eles[1] == "combo"){
				
				hideCombo(eles[0],X,Y);
			}
		}
	}

	function setOpenComponent(id,component){
		currentEle = id+"|"+component;
	}
function setPopupValue(name,category,items){
	if(document.getElementById("selectedCat"+name)){
		document.getElementById("selectedCat"+name).value = category;
		document.getElementById("selectedItems"+name).value = items;
		for(var i= 0;i<15;i++){
			var elecheck = document.getElementById("popupratio"+name+"_"+i);
			if(elecheck){
					if(category == elecheck.value.split("|")[0])
					elecheck.checked = true;
			}
		}
		setRecord(name);
		popupOk(name);
	}

}
function createPopUp(name,arr,category,items){
		var mainele =  document.getElementById(name);
		
		//if(navigator.appName == "Microsoft Internet Explorer" && document.getElementById("temp"))
		//var parrentele = document.getElementById("temp");
		//else if(navigator.appName == "Microsoft Internet Explorer")
		//	var parrentele = mainele;
		//else
			var parrentele = mainele.parentNode;
		var newpop = document.createElement("div");
		newpop.id="value"+name;
		newpop.title = ""; 
		newpop.className = "popup_select";
		newpop.onclick = function(){showMe(this.id.substring(5));};
		
		
		mainele.appendChild(newpop);
		newpop = document.createElement("div");
		newpop.className = "popup_button";
		newpop.setAttribute("id","button"+name);
		newpop.setAttribute("name","finalbutton1"+name);
		newpop.onclick = function(){showMe(this.id.substring(6));};
		
		var newele = document.createElement("input");
		newele.setAttribute("type","hidden");
		newele.setAttribute("id","selectedCat"+name);
		newele.setAttribute("value",category);
		newpop.appendChild(newele);

		var newele = document.createElement("input");
		newele.setAttribute("type","hidden");
		newele.setAttribute("id","selectedItems"+name);
		newele.setAttribute("value",items);
		newpop.appendChild(newele);

		var newele = document.createElement("input");
		newele.setAttribute("type","hidden");
		newele.setAttribute("id","disable"+name);
		newele.setAttribute("value","1");
		newpop.appendChild(newele);

		mainele.appendChild(newpop);
		//var elepop = document.getElementById("popup"+name);
		var elepop = document.createElement("div");
		elepop.setAttribute("id","popup"+name);
		elepop.className ="popup";
		elepop.style.top = parseInt(mainele.offsetTop+20) +"px";
		elepop.style.left = parseInt(mainele.offsetLeft);
		elepop.style.visibility = "hidden";
		var popnavi = document.createElement("div");
		popnavi.setAttribute("id","popupnavi"+name);
		popnavi.className ="popupnavi";
		elepop.appendChild(popnavi);
		parrentele.appendChild(elepop);
		
		var table = document.createElement("table");
		table.setAttribute("id","maintable"+name);
		table.setAttribute("width","100%");
		var tablebody = document.createElement("tbody");
		var tabletr = document.createElement("tr");
		tabletr.setAttribute("id","tr1"+name);
		for(var i=0;i<arr.length;i++){
				var tabletd = document.createElement("td");
				if(arr.length != 1){
					var elecheck = null;
					if(navigator.appName == "Microsoft Internet Explorer" ){
						elecheck = document.createElement("<input type=\"radio\" name=\"ratio"+name+"\" value=\""+arr[i]+"\" id=\"popupratio"+name+"_"+i+"\" />");
					}else{
						elecheck = document.createElement("input");
						elecheck.setAttribute("type","radio");
						elecheck.setAttribute("id","popupratio"+name+"_"+i);
						elecheck.setAttribute("value",arr[i]);
						elecheck.name = "ratio"+name;
					}
					elecheck.onclick = function(){setRecord(this.name.substring(5),this.id.substring(this.id.lastIndexOf("_")+1));};
					tabletd.appendChild(elecheck);
				}else{
					var elecheck = document.createElement("input");
					elecheck.setAttribute("type","hidden");
					elecheck.setAttribute("id","popupratio"+name);
					elecheck.setAttribute("value",arr[i]);
					tabletd.appendChild(elecheck);
				}
				tabletd.style.whiteSpace = "nowrap";
				tabletd.appendChild(document.createTextNode(arr[i].split("|")[0]));
				tabletr.appendChild(tabletd);	
		}
		
		tablebody.appendChild(tabletr);
		tabletr = document.createElement("tr");
		tabletr.setAttribute("id","tr2"+name);
		if(navigator.appName == "Microsoft Internet Explorer" )
			tabletd = document.createElement("<td colspan=\"10\"></td>");
		else{
			tabletd = document.createElement("td");
			tabletd.colSpan=10;
		}
			eletext = document.createElement("input");
			eletext.setAttribute("type","text");
			eletext.setAttribute("id","searchpopup"+name);
			eletext.className = "searchtext";
			eletext.style.width = "280px";
			eletext.onkeyup = function(){searchRecord(this.id.substring(11));}
			tabletd.appendChild(eletext);
			eletext = document.createElement("input");
			eletext.setAttribute("type","hidden");
			eletext.setAttribute("id","allelements"+name);
			tabletd.appendChild(eletext);
		tabletr.appendChild(tabletd);
		tablebody.appendChild(tabletr);

		table.appendChild(tablebody);
		popnavi.appendChild(table);
		
		tabletr = document.createElement("tr");
		tabletr.setAttribute("id","tr3"+name);
		if(navigator.appName == "Microsoft Internet Explorer" )
			tabletd = document.createElement("<td id=\"popupbody"+name+"\" colspan=\"10\" style=\"background-color: #FFFFFF;\"></td>");
		else{
			tabletd = document.createElement("td");
			tabletd.colSpan=10;
			tabletd.setAttribute("style","background-color: #FBFBFB;");
			tabletd.setAttribute("id","popupbody"+name);
		}
		var span = document.createElement(span);
		span.id = 'spanID';
		tabletd.appendChild(span);
		tabletr.appendChild(tabletd);
		tablebody.appendChild(tabletr);
		
		tabletr = document.createElement("tr");
		tabletr.setAttribute("id","tr4"+name);
		
		var tabletd;
		if(navigator.appName == "Microsoft Internet Explorer" )
			tabletd = document.createElement("<td id=\"popupbody"+name+"\" colspan=\"10\" ></td>");
		else{
			tabletd = document.createElement("td");
			tabletd.colSpan=10;
		}

		elebut = document.createElement("input");
		elebut.setAttribute("id","btn1"+name);
		elebut.setAttribute("type","button");
		elebut.className="criButton";
		elebut.style.width="60px";
		elebut.style.paddingLeft="10px";
		elebut.style.marginRight="10px";
		elebut.setAttribute("value","OK");
		elebut.setAttribute("name","popupbutton1"+name);
		elebut.onclick = function(){popupOk(this.id.substring(4));}
		tabletd.appendChild(elebut);
		elebut = document.createElement("input");
		elebut.setAttribute("id","newele"+name);
		elebut.setAttribute("type","hidden");
		tabletd.appendChild(elebut);
		
		elebut = document.createElement("input");
		elebut.setAttribute("id","mypopupheight"+name);
		elebut.setAttribute("type","hidden");
		elebut.value="20";
		tabletd.appendChild(elebut);
		
		elebut = document.createElement("input");
		elebut.setAttribute("id","btn3"+name);
		elebut.setAttribute("type","button");
		elebut.setAttribute("name","popupbutton2"+name);
		elebut.className="criButton";
		elebut.style.width="60px";
		elebut.style.paddingLeft="10px";
		elebut.setAttribute("value","Cancel");
		elebut.onclick = function(){cancelMe(this.id.substring(4));}
		tabletd.appendChild(elebut);
		tabletr.appendChild(tabletd);
		tablebody.appendChild(tabletr);
		table.appendChild(tablebody);
		popnavi.appendChild(table);
		if(navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion.split(";")[1].substring(6)) <= 6){
			var frame = document.createElement("iframe");
			frame.id = "frame"+name;
			frame.className = "frmcls";
			frame.style.height = '0';
			frame.style.top = "0px";
			mainele.appendChild(frame);
			frame.style.display = "none";
		}
		for(var i= 0;i<arr.length;i++){
			var elecheck = document.getElementById("popupratio"+name+"_"+i);
			if(elecheck){
				var cname = arr[i].split("|");
				if(category == cname[0] || i == 0)
					elecheck.checked = true;
			}
		}
		setRecord(name);
		if(category)
			popupOk(name);
		setTimeout("setOpenComponent('','')",1);
}
function myDashbordPopup(id,height){
	document.getElementById(id).onclick = function(){showMe(this.id);};
	document.getElementById("mypopupheight"+id).value = height;
	if(navigator.appName == "Microsoft Internet Explorer" )
		height = height - 3;
	document.getElementById("value"+id).style.height = height+"px";
	document.getElementById("value"+id).style.visibility = "hidden";
	document.getElementById("button"+id).style.height = height+"px";
	document.getElementById("button"+id).style.visibility = "hidden";
}
function cancelMe(id){
	if(document.getElementById("value"+id).childNodes[0]) {
		document.getElementById("value"+id).removeChild(document.getElementById("value"+id).childNodes[0]);
	}
	
	if(document.getElementById("selectedItems"+id).value!="undefined"){
		var arr1 = document.getElementById("selectedItems"+id).value.split(",");
		var allmyeles = getRecord(document.getElementById("selectedCat"+id).value.split("|")[0]);
		var arr = [];
		if(arr1.length == allmyeles.length){
			arr.push("All "+document.getElementById("selectedCat"+id).value.split("|")[0]);
		}else{
			if(findIdx("Any",arr1) != -1 ){
				arr.push("Any");
			}
			for(var i=0;i<allmyeles.length;i++){
				var nameid = allmyeles[i].split("|");
				if(findIdx(nameid[0],arr1) != -1 ){
					arr.push(nameid[0]);
					continue;
				}
				if(findIdx(nameid[1],arr1) != -1 ){
					arr.push(nameid[0]);
					continue;
				}
			}
		}
		var str = arr.toString();
		if(arr.toString() != "undefined"){
			if(str.length > 25)
				str = str.substring(0,25) + "...";
			document.getElementById("value"+id).appendChild(document.createTextNode(str));
			document.getElementById("value"+id).title = arr;
		}
	}
	reallyHideMe(id);
}
function showMe(name){
	
	if(document.getElementById("disable"+name).value == "1"){
		var mainele =  document.getElementById(name);
		var popupele = document.getElementById("popup"+name);
		popupele.style.visibility="";
		var height = document.getElementById("mypopupheight"+name).value;
		var frame = document.getElementById("frame"+name);
		popupele.style.top = parseInt(mainele.offsetTop)+parseInt(height)+"px";
		popupele.style.left = mainele.offsetLeft;
		if(frame){
			//if(height <= 20)
			//	popupele.style.top = "20px";
			//frame.style.height = popupele.offsetHeight;
			//frame.style.width =popupele.offsetWidth - 10;
			//frame.style.left = popupele.offsetLeft;
			//frame.style.top = popupele.style.top;
			frame.style.display = "none";
		}
		if(document.getElementById("popup"+name).style.visibility!="hidden")
			document.getElementById("searchpopup"+name).focus();
		setOpenComponent('','');
		setTimeout("setOpenComponent('"+name+"','popup');",10);
		document.getElementById("value"+name).style.background ="#D4D0C8";
		document.getElementById("disable"+name).value = "0";
	}
}
function openNewPopupForm(id){
	var maingroup = getCheckedValues(id,"popupratio"+id);
	var recordConf = maingroup.toString().split("|");
	openPopupForm(recordConf[2],id,1);
	
}

function hideMe(name,X,Y){
	var mainele =  document.getElementById(name);
	var popup = document.getElementById("popup"+name);	
	var parentele = mainele.parentNode;
	var x1=0;	
	var y1=parseInt(document.getElementById("mypopupheight"+name).value);
	if(y1 <= 20)
		y1 = 20;
	var lastsize = 0;
	while(parentele.parentNode.parentNode){
		if(parentele.tagName != "TR" && parentele.tagName != "FORM" && parentele.tagName != "TBODY"){
			if(parentele.tagName == "DIV"){
				if(lastsize == parentele.offsetTop){
					lastsize = parentele.offsetTop;
					parentele = parentele.parentNode;
					continue;
				}
				lastsize = parentele.offsetTop;
			}
			x1 += parentele.offsetLeft;
			y1 += parentele.offsetTop;
		}	
		parentele = parentele.parentNode;
	}
	var x2=x1+popup.offsetWidth;
	var y2=parseInt(y1)+parseInt(popup.offsetHeight);
	if(x1 < X && x2 > X && y1 < Y && y2 > Y){
		//showMe(name);
	}else{	reallyHideMe(name); }
}

function reallyHideMe(name){
	document.getElementById("popup"+name).style.visibility="hidden";
	var frame = document.getElementById("frame"+name);
	if(frame){
		frame.style.height = "0";
		frame.style.width = "0";
	}
	setOpenComponent("","");
	document.getElementById("disable"+name).value = "1";
	document.getElementById("value"+name).style.background ="url(../images/header.jpg) 2px";
}

function popupOk(name){
	var eleselected = getCheckedValues(name,"popupselect"+name);
	if(eleselected.length != 0){
		var maingroup = getCheckedValues(name,"popupratio"+name);
		var recordConf = maingroup.toString().split("|");
		if(document.getElementById("popupselectAll"+name) && document.getElementById("popupselectAll"+name).checked){
			if(document.getElementById("value"+name).childNodes[0])
				document.getElementById("value"+name).removeChild(document.getElementById("value"+name).childNodes[0]);
			document.getElementById("value"+name).appendChild(document.createTextNode("All "+recordConf[0]));
			document.getElementById("value"+name).title = "All "+recordConf[0]+"s";
		}else{
			var elements = getCheckedValues(name,"popupselect"+name);
			if(document.getElementById("value"+name).childNodes[0])
				document.getElementById("value"+name).removeChild(document.getElementById("value"+name).childNodes[0]);
			var str = elements.toString();
			if(str.length > 25)
				str = str.substring(0,22) + "...";
			document.getElementById("value"+name).appendChild(document.createTextNode(str));
			document.getElementById("value"+name).title = elements;				
		}
		if(recordConf.length == 5){
			eval(recordConf[4]);
		}
		reallyHideMe(name);
	}else{
		var maingroup = getCheckedValues(name,"popupratio"+name);
		maingroup = maingroup.toString().split("|");
		alert("Please select a "+maingroup[0]);
	}
}

function getSelectedValue(name){
	return document.getElementById("value"+name).childNodes[0].nodeValue;
}

function setRecord(name,flag){	
	if(document.getElementById("value"+name).childNodes[0])
		document.getElementById("value"+name).removeChild(document.getElementById("value"+name).childNodes[0]);
	document.getElementById("value"+name).appendChild(document.createTextNode(''));
	if(flag >= 0){
		document.getElementById("searchpopup"+name).value = "" ;
	}
	var maingroup = getCheckedValues(name,"popupratio"+name);
	var recordConf = maingroup.toString().split("|");
	var innerSearch = document.getElementById("searchpopup"+name).value;
	var myeles = getRecord(recordConf[0]);

	document.getElementById("allelements"+name).value = myeles;
	
	var elebody = document.getElementById("popupbody"+name);
	if(elebody.childNodes.length > 0 )
		elebody.removeChild(elebody.childNodes[0]);

	generateCheckBox(name,myeles);
	if(document.getElementById("popup"+name).style.visibility!="hidden")
		setTimeout('document.getElementById("searchpopup'+name+'").focus();',1);
	var frame = document.getElementById("frame"+name);
	var popupele =  document.getElementById("popup"+name);
	if(frame){
		frame.style.height = popupele.offsetHeight;
		frame.style.width = popupele.offsetWidth;
	}
}

function disablePopup(name){
	if(document.getElementById("disable"+name)){
		document.getElementById("disable"+name).value = "0";
		document.getElementById("value"+name).style.background ="#D4D0C8";
	}
}

function enablePopup(name){
	if(document.getElementById("disable"+name)){
		document.getElementById("disable"+name).value = "1";
		document.getElementById("value"+name).style.background ="#FFFFFF";
	}
}
function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function searchRecord(name){
	var innerSearch = document.getElementById("searchpopup"+name).value;
	innerSearch = innerSearch.toLowerCase();
	var myeles = document.getElementById("allelements"+name).value.split(",");
	var neweles = [];
	for(cnt = 0 ; cnt < myeles.length ; cnt++){
		var mydata = myeles[cnt].split("-");
		for(var i=0;i<mydata.length;i++){
			var data = trim(mydata[i]).toLowerCase();
			if(data.indexOf(innerSearch,-1) == 0){
				neweles.push(myeles[cnt]);
				break;
			}
		}
	}
	generateCheckBox(name,neweles,1);
}

function generateCheckBox(name,myeles,sflag){
	var charFlag = 0;
	var maingroup = getCheckedValues(name,"popupratio"+name);
	var recordConf = maingroup.toString().split("|");
	var conf = recordConf[1];
	var image ; 
	if(recordConf[3])
		image = recordConf[3];
	
	var eleselected = getCheckedValues(name,"popupselect"+name);
	var elebody = document.getElementById("popupbody"+name);
	if(elebody.childNodes.length > 0 )
		elebody.removeChild(elebody.childNodes[0]);
	var allSelected = 0;
	if(eleselected.length == myeles.length){
		allSelected = 1;
	}
	var innerSearch = document.getElementById("searchpopup"+name).value;
	var eleSelCat = document.getElementById("selectedCat"+name);
	var eleSelItems = document.getElementById("selectedItems"+name);
	var newele = document.getElementById("newele"+name).value;
	var arr1 = eleSelItems.value.split(",");
	var arr = [];

	allmyeles = document.getElementById("allelements"+name).value.split(",");
	
	if(findIdx("Any",arr1) != -1 ){
		arr.push("Any");
	}
	for(var i=0;i<allmyeles.length;i++){
		var nameid = allmyeles[i].split("|");
		if(findIdx(nameid[0],arr1) != -1 ){
			arr.push(allmyeles[i]);
			continue;
		}
		if(findIdx(nameid[1],arr1) != -1 ){
			arr.push(allmyeles[i]);
			continue;
		}
	}
	var innerSearch = document.getElementById("searchpopup"+name).value;
	if(findIdx("-1",arr1) != -1 && eleSelCat.value == recordConf[0] && sflag == undefined)
		eleselected = arr1;
	if(eleselected.length > 0){
		var eleselected1 = [];
		for(var j=0;j<allmyeles.length;j++){
			var nameid = allmyeles[j].split("|");
			if(findIdx("-1",eleselected)!= -1){
				eleselected1.push(allmyeles[j]);
				continue;
			}
			if(findIdx(nameid[0],eleselected) != -1 ){
				eleselected1.push(allmyeles[j]);
				continue;
			}
			if(findIdx(nameid[1],eleselected) != -1 ){
				eleselected1.push(allmyeles[j]);
				continue;
			}
		}
		eleselected = eleselected1;
	}
	
	if(newele != ""){
		eleselected.push(newele);
		document.getElementById("newele"+name).value = "";
	}
	if(eleSelCat.value == recordConf[0]){
		for(var i=0;i<arr.length;i++){
			if(findIdx(arr[i],eleselected) == -1){
				eleselected.push(arr[i]);
			}
		}
	}
	var neweles = [];
	for(cnt = 0 ; cnt < eleselected.length ; cnt++){
		if(eleselected[cnt].indexOf(innerSearch,-1) != 0 ){
			neweles.push(eleselected[cnt]);
		}else if(innerSearch == ""){
			neweles.push(eleselected[cnt]);
		}
	}
	if(neweles[0] == "")
		neweles = [];

	for(var i=0;i<myeles.length;i++){	
			if(findIdx(myeles[i],neweles) == -1){
				neweles.push(myeles[i]);
			}
	}
	myeles = neweles;
	var cnt = 0;
	var elediv = document.createElement("div");
	var eletable = document.createElement("table");
	eletable.setAttribute("border","0");
	eletable.setAttribute("width","100%");
	eletable.setAttribute("style","overflow:hidden");
	eletable.setAttribute("id","checktable"+name);
	var eletablebody = document.createElement("TBODY");
	var elecheckAll = null;
	if(conf > 0){
		var eletr =  document.createElement("tr");
		if(conf == 1 || conf == 3){
			var eletd =  document.createElement("td");
			elecheckAll = document.createElement("input");
			elecheckAll.setAttribute("type","checkbox");
			elecheckAll.setAttribute("id","popupselectAll"+name);
			elecheckAll.onclick =  function(){return selectAllCheckPop(this.id.substring(14));	}
			eletd.appendChild(elecheckAll);
			if(allSelected == 1)
				elecheckAll.checked = true;
			eletd.appendChild(document.createTextNode("Select All"));
			eletr.appendChild(eletd);
		}
		if(conf == 2 || conf == 3){
			var eletd =  document.createElement("td");
			var elecheck = document.createElement("input");
			elecheck.setAttribute("type","checkbox");
			elecheck.setAttribute("id","popupselect"+name+"_"+cnt);
			
			elecheck.setAttribute("value","Any");
			eletd.appendChild(elecheck);
			eletd.appendChild(document.createTextNode("Any"));
			eletr.appendChild(eletd);
			if(findIdx("Any",myeles) == -1){
				if(myeles.length != 0)
					myelesstr  =  "Any,"+myeles.toString();
				else
					myelesstr  =  "Any";
				myeles = myelesstr.split(",");
			}
			cnt++;
		}
		eletablebody.appendChild(eletr);
	}
	
	var len = myeles.length;
	var noCol = 2;
	if(len > 100)
		noCol = 3;
	for(row = 0 ; cnt < len ; row++){
		var eletr =  document.createElement("tr");
		for(col=0;col<noCol;col++,cnt++){
			if(cnt<len){
				var myelesvalues = myeles[cnt].split("|");
				var myelesvalue = myelesvalues[0];
				var myelesid = myelesvalues[0];
				if(myelesvalues[1])
					myelesid = myelesvalues[1];
				var eletd =  document.createElement("td");
				var tempele = document.createElement("div");
				if (navigator.appName == "Microsoft Internet Explorer") 
					tempele.style.styleFloat = "left";
				else
					tempele.setAttribute("style","float:left;");
				var elecheck = document.createElement("input");
				elecheck.setAttribute("type","checkbox");
				elecheck.setAttribute("id","popupselect"+name+"_"+cnt);
				elecheck.onclick =  function(){return selectCheckPop(name);	}
				elecheck.setAttribute("value",myelesvalue);
				tempele.appendChild(elecheck);
				
				eletd.appendChild(tempele);
				eletd.style.whiteSpace = "nowrap";
				var eletext = document.createElement("input");
				eletext.setAttribute("type","hidden");
				eletext.setAttribute("id","popupselectid"+name+"_"+cnt);
				eletext.setAttribute("value",myelesid);
				tempele.appendChild(eletext);
				
				eletd.title = myelesvalue;
				var myelesimg = replaceAll(myelesvalue," ","");
				if(myelesvalue.length > 20 ){
					myelesvalue = myelesvalue.substring(0,20) + "...";
				}					
				if(image == 1){
					if(myelesvalue.length > 15 ){
						myelesvalue = myelesvalue.substring(0,15) + "...";
					}
					var img = document.createElement("div");
					img.className = "checkBoxImage";
					img.style.backgroundImage = "url(images/"+myelesimg+".gif)";	
					img.appendChild(document.createTextNode(myelesvalue));
					eletd.appendChild(img);
				}else
					eletd.appendChild(document.createTextNode(myelesvalue));
				eletr.appendChild(eletd);
			}
		}
		eletablebody.appendChild(eletr);
	}
	eletable.appendChild(eletablebody);
	
	if(len<=0){
		elediv.appendChild(document.createTextNode("Record not Available"));
	}
	else
		elediv.appendChild(eletable);
	elebody.appendChild(elediv);

	if(myeles.length > 15){
		elediv.style.height = "166px";
		elediv.style.overflowY = "auto";
	}
	if(noCol == 2)
		document.getElementById("popup"+name).style.width = "330px";
	else
		document.getElementById("popup"+name).style.width = "450px";
	currentEle = "";
	setTimeout("setOpenComponent('"+name+"','popup')",10);

	for(var i = 0; i < len; i++) {
		var elecheck = document.getElementById("popupselect"+name+"_"+i);
		if(elecheck){
			if(findIdx(myeles[i],eleselected) != -1){
					elecheck.checked = true;
			}
		}
	}
	if(myeles.length == eleselected.length)
		elecheckAll.checked = true;
}

function replaceAll(str,str1,str2){
	while(str.indexOf(str1) > -1)
		str = str.replace(str1,str2);
	return str;
}
function selectAllCheckPop(name){
	var myeles = document.getElementById("allelements"+name).value.split(",");
	var radioLength = myeles.length;
	for(var i = 0; i < radioLength+1; i++) {
		if(document.getElementById("popupselect"+name+"_"+i))
		document.getElementById("popupselect"+name+"_"+i).checked = document.getElementById("popupselectAll"+name).checked;
	}
}
function selectCheckPop(name){
	var eleselected = getCheckedValues(name,"popupselect"+name);
	var myeles = document.getElementById("allelements"+name).value.split(",");

	if(document.getElementById("popupselectAll"+name).checked){
		document.getElementById("popupselectAll"+name).checked=false;
	}
	if(eleselected.length == myeles.length){	
		document.getElementById("popupselectAll"+name).checked=true;
	}
	
}
function findIdx(item, arr) {
	var idx=-1;
	var last = arr.length;
	for (var i = 0; i < last; i++) {
		idx = (item == arr[i])?i:-1;
		if (-1 != idx) break;
	}
	return idx;
}

function getCheckedValues(name,id) {
	var ele = [];
	if(document.getElementById(id+"_0")){
		var myeles = document.getElementById("allelements"+name).value.split(",");
		var radioLength = myeles.length;
		if(radioLength < 10)
			radioLength = 10;
		for(var i = 0; i < radioLength; i++) {
			if(document.getElementById(id+"_"+i))
				if(document.getElementById(id+"_"+i).checked ) {
						ele.push(document.getElementById(id+"_"+i).value);
				}		
		}
	}else{
		if(document.getElementById(id)){
			var eletext = document.getElementById(id).value;
			ele.push(eletext);
		}
	}
	return ele;
}
function getCheckedIds(name) {
	var id = "popupselect"+name; 
	var ele = [];
	var myeles = document.getElementById("allelements"+name).value.split(",");
	var radioLength = myeles.length;
	if(radioLength < 10)
		radioLength = 10;
	for(var i = 0; i < radioLength; i++) {
		if(document.getElementById(id+"_"+i))
			if(document.getElementById(id+"_"+i).checked ) {
					ele.push(document.getElementById("popupselectid"+name+"_"+i).value);
			}		
	}
	return ele;
}
function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}

function GetCoords() { 
	var scrollX, scrollY; 
	if (document.all) { 
		if (!document.documentElement.scrollLeft) 
			scrollX = document.body.scrollLeft; 
		else 
			scrollX = document.documentElement.scrollLeft; 
		if (!document.documentElement.scrollTop) 
			scrollY = document.body.scrollTop; 
		else scrollY = document.documentElement.scrollTop; 
		} else { 
			scrollX = window.pageXOffset; 
		} 
}
