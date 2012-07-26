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

package org.cyberoam.iview.system.beans;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * 
 * @author narendrashah
 *
 */
public class CPUUsageBean {
	int idlePercent=0;
	
	/**
     * Insert SQL record into database table.
     * @return  positive integer on success
     */
    public int insertRecord(){
        String insert = null;
        int insertValue=-1;
        SqlReader sqlReader = null;
        try{
            sqlReader = new SqlReader(false);
            
            insert ="insert into tblcpuusage "+
            "(usagetimestamp,idlecpu) values"+ 
            "(now(),"+ idlePercent +  ")";
            insertValue = sqlReader.executeUpdate(insert, 5);
        }catch(Exception e){
            CyberoamLogger.repLog.error("MemoryUsageBean.insertRecord.e:" +  e,e);
            insertValue = -1;
        }finally{
            try{
                sqlReader.close();
            }catch(Exception e){}
        }
        return insertValue;
    }

	/**
	 * @return the idlePercent
	 */
	public int getIdlePercent() {
		return idlePercent;
	}

	/**
	 * @param idlePercent the idlePercent to set
	 */
	public void setIdlePercent(int idlePercent) {
		this.idlePercent = idlePercent;
	}

	
}
