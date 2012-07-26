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

var lstChanged = '';

	function createNewMenu(arr, lastAccess){
		var level  = 0;
		var level1 = 0;
		var level2 = 0;
		var level3 = 0;
		var lastLevel = 0;
		var str = '';
		var url = '';
		var menuList = '';
		var len=arr.length;
		if(navigator.appName == "Microsoft Internet Explorer" )
			len = len -1;
		var eleMenu = document.getElementById("menu_data");
		var selMenuList = lastAccess.split('_');
		menuList = '<ul id="menu0" class="level1">';
		for(var i=0; i<len; i++){
			str = arr[i][0];
			url = arr[i][1];
			level = getCount(str,'|');
			str = str.substring(level-1,str.length);
			if(url!='') {
				if(url.indexOf('?')== -1){
					url += '?empty=';
				} else {
					url += '&empty=';
				}
			}
			
			if(level == 1){
				
				level1++;
				level2=0;
				if (lastLevel > level) {
					if (lastLevel ==3) {
						menuList += '</ul>';
					}
					menuList += '</ul><li id="menu'+level1+'" class="level1unSel" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'">'+str+'</a>':str)+'</li>';
				} else {
					menuList += '<li id="menu'+level1+'" class="level1unSel" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'">'+str+'</a>':str)+'</li>';
				}
				lastLevel = 1;
			
			}else if(level == 2){
			
				level2++;
				level3=0;
				if(lastLevel < level) {
					menuList += '<ul id="menu'+level1+'_0" class="level2" style="display:none" ><li id="menu'+level1+'_'+level2+'" class="level2unselCol" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'_'+level2+'">'+str+'</a>':str)+'</li>';
				} else if (lastLevel > level) {
					menuList += '</ul><li id="menu'+level1+'_'+level2+'" class="level2unselCol" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'_'+level2+'">'+str+'</a>':str)+'</li>';
				} else {
					menuList += '<li id="menu'+level1+'_'+level2+'" class="level2unselCol" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'_'+level2+'">'+str+'</a>':str)+'</li>';
				}
				lastLevel = 2;
				
			}else if(level == 3){
				
				level3++;
				if(lastLevel < level) {
					if(arr[i-1][1]!='' && selMenuList[0]==level1 && selMenuList[1]==level2) {
						menuList += '<ul id="menu'+level1+'_'+level2+'_0" class="level3"><li id="menu'+level1+'_'+level2+'_'+level3+'" class="level'+level+'" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'_'+level2+'_'+level3+'">'+str+'</a>':str)+'</li>';
					} else {
						menuList += '<ul id="menu'+level1+'_'+level2+'_0" class="level3" style="display:none"><li id="menu'+level1+'_'+level2+'_'+level3+'" class="level'+level+'" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'_'+level2+'_'+level3+'">'+str+'</a>':str)+'</li>';
					}
				} else if (lastLevel > level) {
					menuList += '</ul><li id="menu'+level1+'_'+level2+'_'+level3+'" class="level'+level+'" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'_'+level2+'_'+level3+'">'+str+'</a>':str)+'</li>';
				} else {
						menuList += '<li id="menu'+level1+'_'+level2+'_'+level3+'" class="level'+level+'" onclick="displayList(this);">'+(url!=''?'<a class="menuitem" href="'+url+level1+'_'+level2+'_'+level3+'">'+str+'</a>':str)+'</li>';
				}
				lastLevel = 3;
			}
		}
		menuList += '</ul>';
		eleMenu.innerHTML = menuList;
		setDefaultMenu(lastAccess);
	}
	
	
	function setDefaultMenu(lastAccess){
		if(lastAccess == ''){
			lastAccess = '1_1_1';
		}
		lstChanged = lastAccess;
		var selMenuList = lastAccess.split('_');
		if(selMenuList.length == 1){
		} else if(selMenuList.length == 2){
			document.getElementById('menu'+selMenuList[0]).className = 'level1Sel';
			document.getElementById('menu'+selMenuList[0]+'_0').style.display = "";
			document.getElementById('menu'+selMenuList[0]+'_0').style.background = "#FFFFFF";
			selItemGrp = document.getElementById('menu'+selMenuList[0]+'_0').getElementsByTagName('li');
			for(var i=0; i<selItemGrp.length; i++){
				if(selItemGrp[i].className == 'level2unselCol')
					selItemGrp[i].style.backgroundImage = "url(../images/inactiveexpand.gif)";
			}
			document.getElementById('menu'+selMenuList[0]+'_'+selMenuList[1]).getElementsByTagName('a')[0].style.color = '#E47440';
			document.getElementById('menu'+selMenuList[0]+'_'+selMenuList[1]).style.backgroundImage = "url(../images/collapse.gif)";
		} else if(selMenuList.length == 3){
			document.getElementById('menu'+selMenuList[0]).className = 'level1Sel';
			document.getElementById('menu'+selMenuList[0]+'_0').style.display = "";
			document.getElementById('menu'+selMenuList[0]+'_0').style.background = "#FFFFFF";
			document.getElementById('menu'+selMenuList[0]+'_'+selMenuList[1]+'_0').style.display = "";
			var selItemGrp = document.getElementById('menu'+selMenuList[0]+'_0').getElementsByTagName('li');
			for(var i=0; i<selItemGrp.length; i++){
				if(selItemGrp[i].className == 'level2unselCol')
					selItemGrp[i].style.backgroundImage = "url(../images/inactiveexpand.gif)";
			}
			document.getElementById('menu'+selMenuList[0]+'_'+selMenuList[1]).className = "level2selExp";
			document.getElementById('menu'+selMenuList[0]+'_'+selMenuList[1]).style.backgroundImage = "url(../images/collapse.gif)";
			selItemGrp = document.getElementById('menu'+selMenuList[0]+'_'+selMenuList[1]+'_0').getElementsByTagName('li');
			for(var i=0; i<selItemGrp.length; i++){
				selItemGrp[i].getElementsByTagName('a')[0].style.color = '#2388C7';
			}
			document.getElementById('menu'+selMenuList[0]+'_'+selMenuList[1]+'_'+selMenuList[2]).getElementsByTagName('a')[0].style.color = '#E47440';
		}
	}
	
	function getCount(str,charCount){
		var myArray = str.toLowerCase().split(charCount);
		return myArray.length;
	}

	function displayList(ele){
		var currMenu = ele.id.replace(/menu/,'');
		var oldMenuList = lstChanged.split('_');
		var curMenuList = currMenu.split('_');
		
		if(curMenuList.length == 1){
			if(oldMenuList.length>=1 && curMenuList[0]!=oldMenuList[0]){
				document.getElementById('menu'+oldMenuList[0]+'_0').style.display='none';
				document.getElementById('menu'+oldMenuList[0]).className = 'level1unSel';
			}
			if(document.getElementById('menu'+curMenuList[0]+'_0').style.display==''){
				document.getElementById('menu'+curMenuList[0]+'_0').style.display='none';
				document.getElementById('menu'+curMenuList[0]).className = 'level1unSel';
			} else {
				document.getElementById('menu'+curMenuList[0]+'_0').style.display='';
				document.getElementById('menu'+curMenuList[0]).className = 'level1Sel';
			}
		} else if(curMenuList.length == 2){
			if(!(ele.getElementsByTagName('a').length > 0 && document.getElementById('menu'+currMenu+'_0'))){
				if(oldMenuList.length>=2 && curMenuList[1]!=oldMenuList[1]){
					if(document.getElementById('menu'+oldMenuList[0]+'_'+oldMenuList[1]+'_0') != null)
						document.getElementById('menu'+oldMenuList[0]+'_'+oldMenuList[1]+'_0').style.display='none';
				}
				if(document.getElementById('menu'+curMenuList[0]+'_'+curMenuList[1]+'_0')){
					if(document.getElementById('menu'+curMenuList[0]+'_'+curMenuList[1]+'_0').style.display==''){
						document.getElementById('menu'+curMenuList[0]+'_'+curMenuList[1]+'_0').style.display='none';
						document.getElementById('menu'+curMenuList[0]+'_'+curMenuList[1]).style.backgroundImage = "url(../images/inactiveexpand.gif)";
					} else {
						document.getElementById('menu'+curMenuList[0]+'_'+curMenuList[1]+'_0').style.display='';
					}
				}
			}
		}
		lstChanged = currMenu;
	}
