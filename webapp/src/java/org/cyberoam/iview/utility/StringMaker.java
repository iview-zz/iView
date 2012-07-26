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

package org.cyberoam.iview.utility;

import java.util.StringTokenizer;

/**
 * This class is used to make SQL string.
 * @author Cyberoam
 *
 */
public class StringMaker{
    public static final String DEFAULT = null;
	
    /**
     * This method makes SQL string using given string.
     * @param tempString
     * @return
     */
	public static String makeString( String tempString ){
		if( tempString == null )
			return DEFAULT;
		else if( tempString.equals( "<None>" ) )
			return DEFAULT;
		else if( tempString.trim().equals( "" ) )
			return DEFAULT;
		else{
			StringTokenizer st = new StringTokenizer( tempString,"'");
			tempString = st.nextToken();
			
			while( st.hasMoreTokens()){
				tempString +="''" +st.nextToken();
			}
			return ( "\'" + tempString.trim() + "\'" );
		}
	}
  
	/**
	 * This method makes SQL string using given character.
	 * @param temp
	 * @return
	 */
	public static String makeString( char temp ){
		if ( Character.isWhitespace(temp)|| Character.isISOControl(temp) )
		    return DEFAULT;
		else
		    return ( "\'" + temp + "\'" );
	}

	/**
	 * This method is used to add where condition to SQL query.
	 * @param sqlString SQL query
	 * @param logicalOperator AND or OR operator
	 * @param fieldName name of database field
	 * @param operand operator to be used condition matching
	 * @param fieldValue value of field to be matched
	 * @return
	 */
	public static String addWhere(String sqlString,String logicalOperator,String fieldName,
                           String operand,String fieldValue ){
        String space = " ";
        String quotes = "\'";
        sqlString = sqlString+space+logicalOperator+space+fieldName+space+operand+space+quotes+fieldValue+quotes+space;
        return sqlString;
    }
    
	/**
	 * This method compares two SQL query strings. 
	 * @param oldString
	 * @param newString
	 * @return
	 */
	public static boolean compare( String oldString, String newString ) {
		if( oldString == null && newString != null )		// THIS IS MOST USEFUL CASE
			return true;
		else if( oldString != null && newString == null )
			return false;
		else if( oldString == null && newString == null )
			return false;
		else return ( !((oldString.trim()).equals( newString.trim() )) );
    }

	/**
	 * Truncates number of characters from query string and adds given post fix string.
	 * @param targetString
	 * @param noOfChars
	 * @param postFix
	 * @return
	 */
	public static String getTruncatedString(String targetString, int noOfChars, String postFix){ 
		String truncatedString = targetString;
		if (targetString.length() > noOfChars ) { 
			truncatedString = targetString.substring(0,(noOfChars - postFix.length() ));
			truncatedString = truncatedString + postFix;
		}
		return truncatedString;
	}

}
