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

package org.cyberoam.iview.charts;


import org.cyberoam.iview.utility.ByteInUnit;
import org.jfree.chart.axis.NumberTickUnit;


/**
 * This class is used in jfree chart generation and convert bytes to upper level bytes(kb,mb etc.)
 * @author  Vishal Vala
 * @see NumberTickUnit
 * @since
 */
public class ByteTickUnit extends NumberTickUnit{
    private static final long serialVersionUID = -6476772736783076413L;
    /**
     * Constructs a new ByteTickUnit object with
     * @param size specifies the field value.
     *   
     */
    public ByteTickUnit(double size) {
        super(size);
    }

    /**
     * Converts a value to a string.
     * 
     * @param value specifies number which should be converted to according byte formatting.
     * @return The formatted string.
     * 
     */
    public String valueToString(double value) {    	
    	return ByteInUnit.getBytesInUnit((new Double(value)).longValue());
    }
}
