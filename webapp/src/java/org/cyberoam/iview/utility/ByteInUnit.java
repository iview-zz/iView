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


import java.text.DecimalFormat;

import org.cyberoam.iview.audit.CyberoamLogger;


/**
 * This utility class is used to convert bit and byte data into more understandable format. 
 * @author Narendra Shah
 *
 */
public class ByteInUnit {
	/**
	 * Data format used for formatting of decimal values. 
	 */
	static DecimalFormat dformat = new DecimalFormat("0.00");
	
	/**
	 * This method is used to format byte data.
	 * @param bytes
	 * @return
	 */
    public static String getBytesInUnit(long bytes){
        return getInUnit(bytes,false);
    }
    /**
     * This method is used to format bit data.
     * @param bits
     * @return
     */
    public static String getBitsInUnit(long bits){
        return getInUnit(bits,true);
    }
       
    /**
     * This method can format both byte and bit data based on flag applied to it.
     * @param bytes
     * @param isBits
     * @return formatted string.
     */
    private static String getInUnit(long bytes,boolean isBits){
        StringBuffer bytesWithUnit = new StringBuffer();
        bytes = Math.abs(bytes);
        try{
            double bytesInLong = bytes;
            
            if(bytes < 1048576 ){	
                bytesWithUnit.append(dformat.format(bytesInLong/1024  ));
                if(isBits){
                    bytesWithUnit.append(" K");
                }else{
                    bytesWithUnit.append(" KB");
                }
            }else if(bytes >= 1048576 && bytes < 1073741824 ){
                bytesWithUnit.append(dformat.format(bytesInLong/1048576));
                if(isBits){
                    bytesWithUnit.append(" M");
                }else{
                    bytesWithUnit.append(" MB");
                }
            }else if(bytes >= 1073741824  && bytes < 1099511627776.0d){
            	 bytesWithUnit.append(dformat.format(bytesInLong/1073741824));
                 if(isBits){
                     bytesWithUnit.append(" G");
                 }else{
                     bytesWithUnit.append(" GB");
                 }
            }else if(bytes >= 1099511627776.0d){
            	bytesWithUnit.append(dformat.format(bytesInLong/1099511627776.0d));
                if(isBits){
                    bytesWithUnit.append(" T");
                }else{
                    bytesWithUnit.append(" TB");
                }
            }
        }catch(Exception e){ 
            CyberoamLogger.appLog.debug("Exception in getBytesInUnit : "+ e);
            bytesWithUnit.append(bytes); ;
        }	
        return bytesWithUnit.toString();	
    }
}
