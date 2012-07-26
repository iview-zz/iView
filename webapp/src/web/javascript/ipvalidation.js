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

function isValidIP(ipaddr) { 
	var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
   		if (re.test(ipaddr)) {
      		var parts = ipaddr.split(".");
      		if (parseInt(parseFloat(parts[0])) == 0) { return false; }
      			for (var i=0; i<parts.length; i++) {
         			if (parseInt(parseFloat(parts[i])) > 255) { return false; }
      			}
    	  		return true;
   			} else {
      		return false;
   		}
}

function isValidPort(port){
	reExp = new RegExp("^[0-9]{1,}$");   

	portval = reExp.test(port); 
	if(!portval){
		return false;
	}
	if(parseInt(port)<1 || parseInt(port)>65535){
		return false ; 

	}
	return true ;
}	
