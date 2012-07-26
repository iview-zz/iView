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

	var oldURL;
	function changeImg(element){
		var curImg = document.getElementById(element);  // current image element
		var newImg = document.getElementById('0' + element.substring(1)); // hidden image element
		var tempImg = curImg.src;
		curImg.src = newImg.value; 
		newImg.value = tempImg;
		var innerSection = document.getElementById(element.substring(2) + '_0');
		if (innerSection.style.display == 'none') {
			innerSection.style.display = '';
		} else {
			innerSection.style.display = 'none';
		}		
	}
	function movelistitems(direction) {	
	form=document.frmAddProtocolGroup;
		if(direction=="right") {
			src=form.availableapps;
			dst=form.selectedapps;
		} else {
			src=form.selectedapps;
			dst=form.availableapps;
		}

		for(i=src.length-1;i>=0;i--) {
			if(src[i].selected==true) {
				val=src[i].value;
				arr=val.split(",");
				val=arr[1];
				ln=dst.length;
				dst.options[ln]=new Option(src.options[i].text,src.options[i].value,false,false);
				src.options[i]=null;
			}
		}
	}
	function validateForm(){
		form=document.frmAddProtocolGroup;
		if(form.protocolgroupname != null) {
			if(trim(form.protocolgroupname.value) == ""){
				alert("Please Enter Protocol Group");
				form.protocolgroupname.focus();
				return false;
			}
		}	
		if(form.selectedapps.length <= 0){
			alert("Please Enter Protocols");
			form.availableapps.focus();
			return false;
		}else{
			for(var i=0;i<form.selectedapps.length;i++){
				form.selectedapps[i].selected = true;
			}
		}
		document.frmAddProtocolGroup.submit();
	}
	function validateProtocolForm(){
		form=document.frmAddProtocol;
		if(form.applicationname != null){
			if(trim(form.applicationname.value) == ""){
				alert("Please Enter Protocol Name");
				form.applicationname.focus();
				return false;
			}
		}
		document.frmAddProtocol.submit();
	}
	function disableElement(ele){
		ele.disabled = true;
	}
	function enableElement(ele){
		ele.disabled = false;
	}
	function onChangePortType(){
		if(document.getElementById("rdoPort").checked == true){
			disableElement(document.getElementById("txtTo"));
		}else{
			enableElement(document.getElementById("txtTo"));
		}
	}
	function validateIdentifierForm(){
		var startPort,endPort;
		startPort=trim(document.frmProtocolIdentifier.txtFrom.value);
		endPort=trim(document.frmProtocolIdentifier.txtTo.value);
		if (!isValidPort(startPort)) {
			alert("Please enter only numerice value in range 1-65535 for From Port");
			document.frmProtocolIdentifier.txtFrom.focus();
			return false;
		}
		
		if(document.frmProtocolIdentifier.rdoPortRange.checked == true){
			if(!isValidPort(endPort)){
				alert("Please enter only numerice value in range 1-65535 for To Port");
				document.frmProtocolIdentifier.txtTo.focus();
				return false;
			}
			if(parseInt(startPort)>= parseInt(endPort)){
					alert("From port must be less than To Port");
					return false;
			}
		}
		document.frmProtocolIdentifier.submit();
	}
