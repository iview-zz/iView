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


/* Search Component Constructor */
Search = function () {
};

/* Initializing Static Members */
Search.rowcount=1;
if (document.all)
	Search.browser_ie=true
else if (document.layers)
	Search.browser_nn4=true
else if (document.layers || (!document.all && document.getElementById))
	Search.browser_nn6=true

Search.createOption = function(objSelect,valueArray,tablefieldarray){
		var arrayLen=valueArray.length
		var i;
		for (i=0;i<arrayLen;i++){
			var objOption = document.createElement("OPTION");
			objOption.value=tablefieldarray[i];
			objOption.name=valueArray[i];
			var wordlistEntryName = valueArray[i];
			var textNode = document.createTextNode(wordlistEntryName);
			objOption.appendChild(textNode); 
			objSelect.appendChild(objOption);
		}
}



Search.addCriteria = function (){
	Search.rowcount = Search.rowcount + 1;
	var objcontainer = document.getElementById("container");

	var objTR=document.createElement("tr");
	var objCheckBoxTD=document.createElement("td");
	var objFieldTD=document.createElement("td");
	var objCriteriaTD=document.createElement("td");
	var objInputTD=document.createElement("td");
	
	var objFieldList=document.createElement("SELECT");
	objFieldList.style.height="20px";
	objFieldList.style.fontWeight="bold";
	objFieldList.style.fontSize="11px";	
	objFieldList.style.color="#2A576A";
	var objCriteriaList=document.createElement("SELECT");
	objCriteriaList.style.height="20px";
	objCriteriaList.style.fontWeight="bold";
	objCriteriaList.style.fontSize="11px";	
	objCriteriaList.style.color="#2A576A";
	var objCriteriaValue=document.createElement("input");
	objCriteriaValue.style.height="20px";
	objCriteriaValue.style.fontWeight="bold";
	objCriteriaValue.style.fontSize="11px";
	objCriteriaValue.style.color="#2A576A";
	var objCheckBox=document.createElement("input");


	objTR.id="row"+Search.rowcount;
	objTR.name="row"+Search.rowcount;


	objFieldList.id="fieldlist"+Search.rowcount;
	//objFieldList.name="fieldlist"+Search.rowcount;
	objFieldList.name="fieldlist";

	objCriteriaList.id="criterialist"+Search.rowcount;
	//objCriteriaList.name="criterialist"+Search.rowcount;
	objCriteriaList.name="criterialist";

	objCriteriaValue.id="criteriavalue"+Search.rowcount;
	//objCriteriaValue.name="criteriavalue"+Search.rowcount;
	objCriteriaValue.name="criteriavalue";
	objCriteriaValue.value="";
	objCriteriaValue.type="text";

	objCheckBox.id="checkbox"+Search.rowcount
	objCheckBox.name="checkbox"+Search.rowcount
	objCheckBox.type="checkbox";
	objCheckBox.checked="";



	Search.createOption(objFieldList,fieldArray,tablefieldArray);
	Search.createOption(objCriteriaList,criteriaArray,criteriaValueArray);


	objCheckBoxTD.appendChild(objCheckBox);
	objFieldTD.appendChild(objFieldList);
	objCriteriaTD.appendChild(objCriteriaList);
	objInputTD.appendChild(objCriteriaValue);

	objTR.appendChild(objCheckBoxTD);
	objTR.appendChild(objFieldTD);
	objTR.appendChild(objCriteriaTD);
	objTR.appendChild(objInputTD);

	objcontainer.appendChild(objTR);
	

}


/* Removing Criteria */
Search.removeCriteria = function()
{
	var atleastOneRowFound=false
	
	var container=document.getElementById("container");
	var len=Search.rowcount
	var i;
	for (i=2;i<=len;i++)
	{
		var objCheck=document.getElementById('checkbox'+i)
		if(objCheck!=null){
			var objSearchCriteria=document.getElementById('row'+i)
			if (objCheck.checked==true)
			{
				container.removeChild(objSearchCriteria)
				//Search.rowcount--
				atleastOneRowFound=true
			}
		}	
	}
	
	if (atleastOneRowFound==true)
	{
		/*for (i=2;i<=Search.rowcount;i++)
		{
			if (document.getElementById("row"+i)==null)
			{
				var objChild=document.getElementById("container");
				var rows = objChild.getElementsByTagName("tr");   

				var currRow=rows[i].id;

				var currId=currRow.substring(currRow.lastIndexOf("w")+1,currRow.length)
				
				var objTable=document.getElementById("row"+currId)
				
				if (Search.browser_ie)
				{
					//objTable.className=rowbgclass
					objTable.id="row"+i
				}
				else if (Search.browser_nn4 || Search.browser_nn6)
				{
					//objTable.setAttribute("class",rowbgclass)
					objTable.setAttribute("id","row"+i)
				}
				
				Search.changeIndex("row",currId,i)

				Search.changeIndex("checkbox",currId,i)

				Search.changeIndex("fieldlist",currId,i)
				Search.changeIndex("criterialist",currId,i)

				Search.changeIndex("criteriavalue",currId,i)
			}
		}*/
	}
	else alert(" Please select the criteria to removed.")
};


/* Change Row Index after Deletion  */
Search.changeIndex = function(objPrefix,prevId,newId)
{
	var tempObj=document.getElementById(objPrefix+prevId)
        if(tempObj == null)
        {
            return;
        }
	if (Search.browser_ie)
	{
		tempObj.id=objPrefix+newId
		if (objPrefix.indexOf("div")<0)
			tempObj.name=objPrefix+newId
	}
	else
	{
		tempObj.setAttribute("id",objPrefix+newId)
		if (objPrefix.indexOf("div")<0)
			tempObj.setAttribute("name",objPrefix+newId)
	}
};

/* Changing Match Text i.e., either "and the" or "or the"  */
/*Search.changeMatch = function()
{
	var matchoperator = (objMatchOperator[0].checked) ? "and the" : "or the"
	var i;
	for (i=2;i<=Search.rowcount;i++)
	{
		var objMatch=MM_findObj('match'+i)
		objMatch.value=matchoperator
	}
};
*/

