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


/**
 * 
 */
package org.cyberoam.iview.beans;

import java.sql.SQLException;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This Class is used to Format the Protocol (Application) Report Column
 * @author atitshah
 *
 */
public class ProtocolBean {
	
	private int protocolId;
	private String protocolName;
	private String protocolDesc;
	
	private static TreeMap protocolBeanMap = null ;
	
	/**
	 * @return the protocolId
	 */
	public int getProtocolId() {
		return protocolId;
	}
	/**
	 * @param protocolId to set the protocolId 
	 */
	public void setProtocolId(int protocolId) {
		this.protocolId = protocolId;
	}
	/**
	 * @return the protocolName
	 */
	public String getProtocolName() {
		return protocolName;
	}
	/**
	 * @param protocolName to set the protocolName
	 */
	public void setProtocolName(String protocolName) {
		this.protocolName = protocolName;
	}
	/**
	 * @return the protocolDesc
	 */
	public String getProtocolDesc() {
		return protocolDesc;
	}
	/**
	 * @param protocolDesc to set the protocolDesc 
	 */
	public void setProtocolDesc(String protocolDesc) {
		this.protocolDesc = protocolDesc;
	}
		
	/**
	 * This Method constructs the ProcolBean Object from rsw 
	 *  @param rsw
	 * @return 
	 */
	public static ProtocolBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		ProtocolBean protocolBean=new ProtocolBean();
		try {
			protocolBean.setProtocolId(rsw.getInt("protocolid"));
			protocolBean.setProtocolName(rsw.getString("protocolname"));
			protocolBean.setProtocolDesc(rsw.getString("descr"));
		} catch(Exception e) {
			CyberoamLogger.regLog.error("Exception->getBeanByResultSetWrapper()->ProtocolBean: " + e,e);
		}				
		return protocolBean;
	}
	
	static {
		loadAll();
	}
		
	/**
	 * Loads all instances of report entity into TreeMap	
	 */
	public static void loadAll() {
		ResultSetWrapper rsw = null;
		SqlReader sqlReader = new SqlReader(false);
		ProtocolBean protocolBean = null;
		String strQuery=null;
		try {
			protocolBeanMap=new TreeMap();
			strQuery="select protocolid,protocolname,descr from tblProtocol";
			rsw=sqlReader.getInstanceResultSetWrapper(strQuery);
			while(rsw.next()) {
				protocolBean=ProtocolBean.getBeanByResultSetWrapper(rsw);
				if(protocolBean!=null) {
					protocolBeanMap.put(new Integer(protocolBean.getProtocolId()),protocolBean);
				}
			}
		}catch (SQLException e) {
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->ProtocolBean : "+ e, e);
		}
		catch(Exception e) {
			CyberoamLogger.repLog.error("Exception->loadAll()->ProtocolBean : "+ e, e);
		}
		finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch(Exception e) {				
			}
		}
	}
	
	public static String getProtocolNameById(int protocolId) {
		ProtocolBean protocolBean=null;
		String protocolName=null;
		protocolBean=(ProtocolBean)protocolBeanMap.get(protocolId);
		if(protocolBean!=null) {
			protocolName=protocolBean.getProtocolName();
		} else {
			protocolName = new Integer(protocolId).toString();
		}
		return protocolName;
	}
}
