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
function setOpenComponent(id,component){
		currentEle = id+"|"+component;
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

function showCombo(id){
	var bodyele = document.getElementById("show_combo_body");
	var combo = document.getElementById(id);
	bodyele.style.visibility = '';
	bodyele.style.top = combo.offsetTop + 44;
	bodyele.style.left = combo.offsetLeft + 2;
	if(navigator.appName == "Microsoft Internet Explorer" )
		bodyele.style.left = combo.offsetLeft + 4;
	setTimeout("setOpenComponent('"+id+"','combo')",1);
}					
function hideCombo(id,X,Y){
	var mainele = document.getElementById(id);
	var ele = document.getElementById("Combo_body"+id);
	var parentele = mainele.parentNode;
	var x1=mainele.offsetLeft;
	var y1=mainele.offsetTop;
	while(parentele.parentNode){
		if(parentele.tagName != "TR" && parentele.tagName != "FORM"){
			x1 += parentele.offsetLeft;
			y1 += parentele.offsetTop;
		}
		parentele = parentele.parentNode;
	}
	var x2=x1+ele.offsetWidth;
	var y2=y1+ele.offsetHeight+40;
	if(x1 < X && x2 > X && y1 < Y && y2 > Y){
	}else{realyHideCombo(id);}
}

function realyHideCombo(id){
	setTimeout("setOpenComponent('','')",1);
	var bodyele = document.getElementById("Combo_body"+id);
	bodyele.className = "hidden";
}
function setComboMainContainer(id,width,selection) {
	var combo = document.getElementById(id);
	combo.onclick = function(){showCombo(this.id)};
	combo.style.width = width;
	var newdiv = document.createElement("div");
	if(selection == 2)
		newdiv.className = "Main_Combo_select";
	else
		newdiv.className = "Combo_select";
	newdiv.id = "Combo_select"+id;

	combo.appendChild(newdiv);

	newdiv = document.createElement("div");
	if(selection==2)
		newdiv.className="hidden";
	else
		newdiv.className = "Combo_button";
	newdiv.innerHTML="<input type=\"hidden\" id=\"comboFlag"+id+"\" value="+selection+" />";
	combo.appendChild(newdiv);

	newdiv = document.createElement("div");
	newdiv.id="Combo_body"+id;

	newdiv.style.top = combo.offsetHeight+"px";
	newdiv.style.left = "0px";
	if(navigator.appName == "Microsoft Internet Explorer" )
		newdiv.style.width = (parseInt(combo.style.width) - 2) + "px";
	else
		newdiv.style.width = (parseInt(combo.style.width) - 22) + "px";
	var bodyele = document.getElementById("show_combo_body");
	bodyele.style.height = "20px";
	bodyele.appendChild(newdiv);
	
	newdiv = document.createElement("div");
	newdiv.setAttribute("align","center");
	newdiv.style.border ="1px solid #9AA5AB";
	newbtn = document.createElement("input");
	newbtn.setAttribute("id","btn"+id);
	newbtn.setAttribute("type","button");
	newbtn.setAttribute("name","combobutton"+id);
	newbtn.className="criButton";
	newbtn.setAttribute("value","OK");
	newbtn.style.height = "20px";
	newbtn.onclick = function(){realyHideCombo(this.id.substring(3));}
	newdiv.style.background = "#FFFFFF";
	newdiv.appendChild(newbtn);
	
	bodyele.appendChild(newdiv);
	
	setTimeout("setOpenComponent('','')",1);
	showCombo(id);
	realyHideCombo(id);
}
function getElementIndex(id,value){
	var a = [];
	var ele = document.getElementById("Combo_body"+id);
	if (ele.childNodes && ele.childNodes.length > 0) 
		for (var x = 0; x < ele.childNodes.length; x++) {
			if(ele.childNodes[x].childNodes[1].innerHTML == value){
				return x;
			}
		}
	return -1;
}

function getAllEle(id){
	var a = [];
	var ele = document.getElementById("Combo_body"+id);
	if (ele.childNodes && ele.childNodes.length > 0) 
		for (var x = 0; x < ele.childNodes.length; x++) 
			a.push(ele.childNodes[x].innerHTML);
	return a;
}
function setComboBox(id,width,mainid,onselect) {
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
	newdiv.innerHTML="<input type=\"hidden\" id=\"comboFlag"+id+"\" value="+mainid+" /><input type=\"hidden\" id=\"comboOnSelect"+id+"\" value="+onselect+" />";
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

function showComboBody(id){	
	var mainele = document.getElementById(id);
	var ele = document.getElementById("Combo_body"+id);
	if(ele.className!="hidden"){
		ele.className = "hidden";
		setOpenComponent('','');
	}else{
		ele.className="Combo_body";
		setTimeout("setOpenComponent('"+id+"','combo')",5);
	}
	
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
							selectCombo(myid,pos);
						}
		newdiv.innerHTML = arr[x];
		ele.appendChild(newdiv);
	}
	highlightdiv(id);
}
function insertElement(id,item){
	var ele = document.getElementById("Combo_body"+id);
	newdiv = document.createElement("div");
	var arrData = item.split("|");
	var flag = document.getElementById("comboFlag"+id).value;
	if(flag == 2)
		newdiv.className = "Combo_item";
	else
		newdiv.className = "Combo_item_single";
	
	var width = document.getElementById(id).style.width;
	newdiv.id = "Combo_item"+id+"_"+ele.childNodes.length;
	if(ele.childNodes.length > 0)
		document.getElementById("Combo_item"+id+"_"+(ele.childNodes.length-1)).style.borderBottom = "0px solid #9AA5AB";
	newdiv.style.borderBottom = "1px solid #9AA5AB";
	newdiv.onclick = function(e){
						var str = this.id;
						var index = str.lastIndexOf("_");
						var myid = str.substring(10,index);
						var pos = str.substring(index+1);
						selectComboItem(myid,pos,e);
					}
	newdiv.appendChild(document.createTextNode(arrData[0]));

	var valuediv = document.createElement("div");
	valuediv.className = "hidden";
	valuediv.id =  "Combo_item_value"+id+"_"+ele.childNodes.length;
	if(arrData.length >= 2)
		valuediv.innerHTML = arrData[1];
	else
		valuediv.innerHTML = arrData[0];
	if(arrData[2])
		if(arrData[2] == 1)
			newdiv.className = "Combo_item_select";
	bodydiv = document.getElementById("show_combo_body");
	bodydiv.style.height = (parseInt(bodydiv.style.height)+ 21) +"px";
	bodydiv.style.width = width;
	newdiv.appendChild(valuediv);
	ele.appendChild(newdiv);
	
	var combo = document.getElementById(id);
	combo.title = getSelectedItemsValue(id);
	
	highlightdiv(id);
}
function insertAllElements(id,arr){
	var flag = document.getElementById("comboFlag"+id).value;
	var ele = document.getElementById("Combo_body"+id);	
	var width = document.getElementById(id).style.width;
	ele.style.width = width;
	//document.getElementById("Combo_item"+id+"_"+(ele.childNodes.length-1)).style.borderBottom = "0px solid #9AA5AB";
	for(var x=0 ; x< arr.length ;x++){
		var arrData = arr[x].split("|");
		newdiv = document.createElement("div");
		if(flag == 2)
			newdiv.className = "Combo_item";
		else
			newdiv.className = "Combo_item_single";
		newdiv.id = "Combo_item"+id+"_"+x;
		newdiv.onclick = function(e){
							var str = this.id;
							var index = str.lastIndexOf("_");
							var myid = str.substring(10,index);
							var pos = str.substring(index+1);
							selectComboItem(myid,pos,1);
						}
		newdiv.appendChild(document.createTextNode(arrData[0]));

		var valuediv = document.createElement("div");
		valuediv.className = "hidden";
		valuediv.id =  "Combo_item_value"+id+"_"+x;
		if(arrData.length >= 2)
			valuediv.innerHTML = arrData[1];
		else{
			valuediv.innerHTML = arrData[0];
		}
		if(arrData[2])
			if(arrData[2] == 1)
				newdiv.className = "Combo_item_select";
		newdiv.appendChild(valuediv);
		ele.appendChild(newdiv);
		
	}
	
	var combo = document.getElementById(id);
	combo.title = getSelectedItemsValue(id);
	
	highlightdiv(id);
}

function getSelectedItem(id){
	var value = document.getElementById("Combo_select"+id).innerHTML;
	if(value == "Select item")
		return "";
	return value;
}
function getSelectedItems(id){
	var ele = document.getElementById("Combo_body"+id);
	var items=[];
	for( i=0;i<ele.childNodes.length ; i++ ){
		if(ele.childNodes[i].className.indexOf("_select") != -1){
				if(ele.childNodes[i].childNodes[1].innerHTML == "-1")
					return "-1";
				items.push(ele.childNodes[i].childNodes[1].innerHTML);
		}
	}
	return items;
}
function getSelectedItemsValue(id){
	var ele = document.getElementById("Combo_body"+id);
	var items=[];
	for( i=0;i<ele.childNodes.length ; i++ ){
		if(ele.childNodes[i].className.indexOf("_select") != -1){
				items.push(ele.childNodes[i].childNodes[0].nodeValue);
		}
	}
	return items;
}
function getSelectedIndex(id){
	var ele = document.getElementById("Combo_body"+id);
	var items=[];
	for( i=0;i<ele.childNodes.length ; i++ ){
		if(ele.childNodes[i].className.indexOf("_select") != -1){
				items.push(i);
		}
	}
	return items;
}
function getItemByIndex(id,index){
	return document.getElementById("Combo_item"+id+"_"+index).childNodes[1].innerHTML;
}
function selectComboItem(id,index,selectionFlag){
	ele = document.getElementById("Combo_item"+id+"_"+index);
	var flag = document.getElementById("comboFlag"+id).value;
	if(flag == 2){
			if(ele.className.indexOf("_select")== -1){
				ele.className = ele.className.replace('_hilite', '');
				ele.className +="_select";
			}else{
				ele.className = ele.className.replace('_hilite', '');
				ele.className = ele.className.replace('_select', '');
			}
			if(getItemByIndex(id,index) == "-1"){
				var mainele = document.getElementById("Combo_body"+id);
				for(var i=1;i<mainele.childNodes.length;i++){
					var elenode = document.getElementById("Combo_item"+id+"_"+i);
					if(ele.className.indexOf("_select") != -1){
						elenode.className = elenode.className.replace('_select', '');
					}
				}
			}else{
				selectall = document.getElementById("Combo_item"+id+"_0");
				selectall.className = selectall.className.replace('_select', '');
			}				
			showCombo(id);
	}
	else
		document.getElementById("Combo_select"+id).innerHTML = ele.innerHTML;		
			var func = document.getElementById('comboOnSelect'+id).value;			
			if(func != "undefined" && selectionFlag)
				eval(func+"('"+ele.childNodes[1].innerHTML+"')");
}
