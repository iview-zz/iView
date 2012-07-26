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

	URL = "";
	function handleThickBox(op,container,width,top){
		var thickBox = document.getElementById('TB_overlay');
		var containerBox = document.getElementById(container);
		if(top != undefined)
			containerBox.style.top = top;
		if(width != undefined)
			containerBox.style.width = width;
		if(op == 1){			
			
			thickBox.style.display = '';
			submitPopupForm(container);
			containerBox.style.display = 'block';
		}else{
			thickBox.style.display = 'none';
			containerBox.style.display = 'none';
			containerBox.innerHTML = '';
		}
	}   
	
	function submitPopupForm(container) {
		var xhr; 
		try {  xhr = new ActiveXObject('Msxml2.XMLHTTP');   }
	    catch (e){
	    	try {   xhr = new ActiveXObject('Microsoft.XMLHTTP');    }
	    	catch (e2) {
	    		try {  xhr = new XMLHttpRequest();     }
	    		catch (e3) {  xhr = false;   }
	    	}
		}
		xhr.onreadystatechange  = function() { 
	    	if(xhr.readyState  == 4) {
				if(xhr.status  == 200){ 
					document.getElementById(container).innerHTML = xhr.responseText;
					setTimeout("getWinSize('"+container+"');",1);
					eval("if(typeof init"+container+" == 'function') {init"+container+"()}");
				}else {
					document.getElementById(container).innerHTML = 'Error in request.<br> Error Code : ' + xhr.status;
					setTimeout("getWinSize('"+container+"');",1);
				}
			}
	    }; 
		xhr.open("GET", URL,  true); 
	   	xhr.send(null); 
	}
	function getWinSize(container) {
		if( typeof( window.innerWidth ) == 'number' ) {		//Non-IE
	    	winWidth = window.innerWidth;
	    	winHeight = window.innerHeight;
	  	} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
	    	winWidth = document.documentElement.clientWidth;
	    	winHeight = document.documentElement.clientHeight;
	  	} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
	    	winWidth = document.body.clientWidth;	    
	    	winHeight = document.body.clientHeight;
	  	}
		if(document.getElementById(container)){			
			document.getElementById(container).style.left = (winWidth - document.getElementById(container).offsetWidth)/2;			
			if(parseInt(document.getElementById(container).style.left) > 232 || parseInt(document.getElementById(container).style.left) < 200){			
				document.getElementById(container).style.left = "232px";											
			}			
			if(document.getElementById(container).style.top == "")
		  		document.getElementById(container).style.top = (winHeight - 50)/2 - document.getElementById(container).offsetHeight;
		  	if(parseInt(document.getElementById(container).style.top) < 0){
                document.getElementById(container).style.top = 50;
		  	}
		}
		if(navigator.appName == "Microsoft Internet Explorer" ){
			document.body.scrollTop = "0";
			document.getElementById(container).style.right = parseInt(document.getElementById(container).style.left)+ document.getElementById(container).offsetWidth + "px";
		}
		
			
	}