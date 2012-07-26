
package org.cyberoam.iview.search;

import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.SqlReader;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;

/***
 * This class represents take configuration detail from tblindexsearchconfig and store in Tree Map object 
 * @author Hemant Agrawal
 *
 */

public class IndexSearchBean{
		
	
	private static TreeMap<String, String> IndexSearchMap = null ;
	
	//This method use for return value from tree map using key
	
	public static String getValueByKey(String keyName){
		return (String)IndexSearchMap.get(keyName);
	}
	
	// This method set value in Tree Map with key
	
	public static void setValueByKey(String keyName,String value){
		IndexSearchMap.put(keyName,value);
	}
	
	//When any object declare of this class static method call start execution 
	static{
		loadAll();
		//IndexSearchMap.put("time","5");
		
	}
	
	
	//When static method call this method call and get config data from database and store value and key in Tree Map 
	
	public static void loadAll(){
		CyberoamLogger.appLog.debug(" loadall method call  of indexsearchbean:");
		SqlReader sqlReader=new SqlReader();
		ResultSetWrapper rsw = null;
		try {
			IndexSearchMap=new TreeMap<String, String>();
			String query = "select keyname,value from tblindexsearchconfig;";
			rsw=sqlReader.getInstanceResultSetWrapper(query);			
			while(rsw.next()){
				IndexSearchMap.put(rsw.getString("keyname"), rsw.getString("value"));
			}			
		}catch (Exception e) {
			CyberoamLogger.appLog.debug("iviewConfigBean.loadAll.e " + e,e);
		}finally {
			try {
				rsw.close();
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		
	}
	
}