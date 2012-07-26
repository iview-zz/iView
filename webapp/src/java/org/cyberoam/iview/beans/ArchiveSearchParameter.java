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

/*
 * 
 */
package org.cyberoam.iview.beans;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.cyberoam.iview.audit.CyberoamLogger;

/**
 * This class represents entity of Archive Search Parameters.<br>
 * The main purpose of this class is to maintain parameters used for searching into archived logs.
 * @author Narendra Shah
 */
public class ArchiveSearchParameter {
	
	private String andOrValue = null;
	private ArrayList fieldIdList = null;
	private ArrayList criteriaIdList = null;
	private ArrayList criteriaValue = null;
	private String criteria = null;
	
	/**
	 * Returns reference of {@link ArchiveSearchParameter} from Http Session.
	 * @param request
	 * @return
	 */
	public static ArchiveSearchParameter getSessionObj(HttpServletRequest request){
		return (ArchiveSearchParameter)request.getSession().getAttribute("archievesearch");
	}
	
	/**
	 * Sets current reference of {@link ArchiveSearchParameter} into Http session.
	 * @param request
	 */
	public static void setSessionObj(HttpServletRequest request){
		ArchiveSearchParameter searchParamBean=new ArchiveSearchParameter();
		ArrayList fieldList = null;
		ArrayList criteriaIdList = null;
		ArrayList criteriaValue = null;
		try{
			searchParamBean.setAndOrValue(request.getParameter("andorvalue"));
			searchParamBean.setCriteria(request.getParameter("criteria"));
			CyberoamLogger.appLog.debug("ArchiveSearchParameter -> setSessionObj() -> tblname : " + request.getParameter("tblname"));	
			CyberoamLogger.appLog.debug("ArchiveSearchParameter -> setSessionObj() -> andorvalue : " +request.getParameter("andorvalue"));
			String[] strFieldList = request.getParameterValues("fieldlist");
			if(strFieldList != null ){
				fieldList = new ArrayList(strFieldList.length);
				CyberoamLogger.appLog.debug("ArchiveSearchParameter -> setSessionObj() -> fieldlist : " +request.getParameterValues("fieldlist"));
			}
			
			String[] strCriteriaIdList = request.getParameterValues("criterialist");
			if(strCriteriaIdList != null ){
				criteriaIdList = new ArrayList(strCriteriaIdList.length);
				CyberoamLogger.appLog.debug("ArchiveSearchParameter -> setSessionObj() -> criterialist : " +request.getParameterValues("criterialist"));
			}
			String[] strCriteriaValueList = request.getParameterValues("criteriavalue");
			if(strCriteriaValueList != null ){
				criteriaValue = new ArrayList(strCriteriaValueList.length);
				CyberoamLogger.appLog.debug("ArchiveSearchParameter -> setSessionObj() -> fieldlist : " +request.getParameterValues("criteriavalue"));
			}
			for(int i=0; fieldList!=null && i<strFieldList.length;i++)
			{
				fieldList.add(strFieldList[i]);
				criteriaIdList.add(strCriteriaIdList[i]);
				criteriaValue.add(strCriteriaValueList[i]);
			}
			searchParamBean.setFieldIdList(fieldList);
			searchParamBean.setCriteriaIdList(criteriaIdList);
			searchParamBean.setCriteriaValue(criteriaValue);
			request.getSession().setAttribute("archievesearch",searchParamBean);
		}catch(Exception e){
			CyberoamLogger.appLog.debug("ArchiveSearchParameter -> setSessionObj() : "+e,e);
		}
	}
	
	/**
	 * Returns logical relation used between multiple search parameter.
	 * <br>This can be either "AND" or "OR".  
	 * @return
	 */
	public String getAndOrValue() {
		return andOrValue;
	}

	/**
	 * Sets logical relation used between multiple search parameter.
	 * <br>This can be either "AND" or "OR".  
	 * @return
	 */
	public void setAndOrValue(String andOrValue) {
		this.andOrValue = andOrValue;
	}

	/**
	 * Returns {@link ArrayList} of fieldIds used for searching.
	 * @return
	 */
	public ArrayList getFieldIdList() {
		return fieldIdList;
	}

	/**
	 * Sets {@link ArrayList} of fieldIds used for searching.
	 * @return
	 */
	public void setFieldIdList(ArrayList fieldIdList) {
		this.fieldIdList = fieldIdList;
	}

	/**
	 * Returns {@link ArrayList} of criteria used for searching.
	 * <br>For e.g. Id of "is", "isn't", "contains" or "doesn't contain" used into HTML page. 
	 * @return
	 */
	public ArrayList getCriteriaIdList() {
		return criteriaIdList;
	}

	/**
	 * Sets {@link ArrayList} of criteria used for searching.
	 * <br>For e.g. Id of "is", "isn't", "contains" or "doesn't contain" used into HTML page. 
	 * @return
	 */
	public void setCriteriaIdList(ArrayList criteriaIdList) {
		this.criteriaIdList = criteriaIdList;
	}

	/**
	 * Returns {@link ArrayList} of values required to be searched.
	 * @return
	 */
	public ArrayList getCriteriaValue() {
		return criteriaValue;
	}

	/**
	 * Sets {@link ArrayList} of values required to be searched.
	 * @return
	 */
	public void setCriteriaValue(ArrayList criteriaValue) {
		this.criteriaValue = criteriaValue;
	}
	
	/**
	 * Returns string representation containing criteria to be searched into archive logs.
	 * @return
	 */
	public String getCriteria() {
		return criteria;
	}

	/**
	 * Sets string representation containing criteria to be searched into archive logs.
	 * @return
	 */
	public void setCriteria(String criteria) {
		this.criteria = criteria;
	}
	
	/**
	 * Sets string representation of {@link ArchiveSearchParameter}.
	 * @return
	 */
	public String toString(){
		String strString="";
    	strString="AndOrValue="+getAndOrValue()+
    	"\tCriteria="+getCriteria()+
    	"\tfieldIdList="+getFieldIdList()+
    	"\tcriteriaIdList="+getCriteriaIdList()+
    	"\tcriteriaValue="+getCriteriaValue();
    	return strString;
	}
}
