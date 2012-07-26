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

package org.cyberoam.iview.modes;


import java.util.Hashtable;


/**
 * This class provides various constatants to generate report.
 * If needed, others can be added here as well.
 * 
 * @author Narendra Shah
 */
public class TabularReportConstants{
	 
	/**
	 * Following constants specifies default limit and offset values for report query.
	 */
	/**
	 * Default limit of records in SQL query.
	 */
	public static final int DEFAULT_LIMIT = 5;
	/**
	 * Default offset of records in SQL query.
	 */
	public static final int DEFAULT_OFFSET = 0;
	
	/**
	 * The following constants define the type of formatting that will be used for report column.
	 * currently the one formatting is needed. if any other formatting is 
	 * needed then, constants need to be accordingly added.
	 */
	/**
	 * Used if formatting is not required to column values.
	 */
	public static final int NO_DATA_FORMATTING = 1;
	/**
	 * Used if byte formatting is required to column values.
	 */
	public static final int BYTE_FORMATTING = 2;
	/**
	 * Used if percent formatting is required to column values.
	 */
	public static final int PERCENTAGE_FORMATTING = 3;
	/**
	 * Used if decoding is required to column values.
	 */
	public static final int DECODE_FORMATTING = 4;
	/**
	 * Used if IP formating is required to column values.
	 */
	public static final int IP_FORMAT=5;
	
	/**
	 * Used if Protocol (Application) formating is required to column values.
	 */
	public static final int PROTOCOL_FORMATTING=6;
	
	/**
	 * Used if Severity formating is required to column values.
	 */
	public static final int SEVERITY_FORMATTING=7;
	
	/**
	 * Used if Action formating is required to column values.
	 */
	public static final int ACTION_FORMATTING=8;
	
	/**
	 * The following constants define the type of formatting that will be used for display report.
	 * 
	 */
	
	/**
	 * Used if in report we want to display graph and table both.
	 */
	public static final int DEFAULT_VIEW=1;
	
	/**
	 * Used if in report we want to display only graph.
	 */
	public static final int TABLE_VIEW=2;

	/**
	 * Used if in report we want to display only table.
	 */
	public static final int GRAPH_VIEW=3;
	
	/**
	 * HashTable of Severity
	 */			
	public static Hashtable severityTable=new Hashtable();
	
	/**
	 * HashTable of Action
	 */			
	public static Hashtable actionTable= new Hashtable();
	
	/**
	 * Static Block to initialize actionTable and severityTable 
	 */
	static {
		severityTable.put(0,"Emergency");
		severityTable.put(1,"Alert");
		severityTable.put(2,"Critical");
		severityTable.put(3,"Error");
		severityTable.put(4,"Warning");
		severityTable.put(5,"Notice");
		severityTable.put(6,"Info");
		severityTable.put(7,"Debug");
		
		actionTable.put(1,"Detected");
		actionTable.put(2,"Dropped");
	}
	
	/**
	 * The Method returns Severity Text based on Input Value
	 * @param severity
	 * @return
	 */
	public static String getSeverity(String severity) {
		if(severityTable.get(Integer.parseInt(severity))!=null) {
			return (String)severityTable.get(Integer.parseInt(severity));
		}else {
			return  severity;
		}		
	}	
	
	/**
	 * The Method returns Action Text based on Input Value
	 * @param action
	 * @return
	 */
	public static String getAction(String action) {
		if(actionTable.get(Integer.parseInt(action))!=null) {
			return (String)actionTable.get(Integer.parseInt(action));
		}else {
			return action;
		}			
	}
}
