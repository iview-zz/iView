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

package org.cyberoam.iview.beans;


import java.io.File;
import java.io.RandomAccessFile;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.zipFileUtility;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * This bean is use to provide search facility for archived data.
 * One method is provided to get All data or selected data based on condition or limit passed to it.
 * @author Amit Maniar
 *
 */
public class SearchDataBean {
	
	/**
	 * This method returns list of data from given table, criteria and limit. 
	 * It will return only requested column(s) and also will add rowlog data as last column. 
	 */
	public static ArrayList getSearchData(String columnlist,String criteria,String limit,String tablename){
    	ResultSetWrapper rsw=null;
		SqlReader sqlReader = null;
		String strQuery=null;
		ArrayList recordArrayList = null;
		ArrayList columnArrayList = null;
		ArrayList columnNameArrayList = null;
		TreeMap openFileMap = new TreeMap();;
		boolean isFileExist=false;
		RandomAccessFile randomAccessFile=null;
		StringTokenizer st = null;
    	try{
    		sqlReader = new SqlReader(false);
    		strQuery="select " + columnlist + ",rowfilename,offsetvalue from " + tablename + " " + criteria + " order by upload_datetime asc " +limit;
    		rsw=sqlReader.getInstanceResultSetWrapper(strQuery);
    		if(rsw.next()){
				recordArrayList = new ArrayList();
				columnNameArrayList = new ArrayList();
				st = new StringTokenizer(columnlist,",");
				while(st.hasMoreTokens()){
					columnNameArrayList.add(st.nextToken());
				}
    			columnArrayList = new ArrayList();
				for(int columncount=0;columncount<columnNameArrayList.size();columncount++){
					columnArrayList.add(rsw.getString((String)columnNameArrayList.get(columncount)));
				}
				isFileExist=true;
				String filepath=IViewPropertyReader.ArchieveDIR+rsw.getString("device_name")+IViewPropertyReader.WARM+tablename.substring(8)+"/"+rsw.getString("rowfilename");
				CyberoamLogger.appLog.debug(" Read This line from File : "+filepath);
				File fileObj = new File(filepath);
				if(!fileObj.exists()){
	 				String zipfilepath=IViewPropertyReader.ArchieveDIR+rsw.getString("device_name")+IViewPropertyReader.COLD+tablename.substring(8)+"/"+rsw.getString("rowfilename")+".zip";
					File zipFileObj = new File(zipfilepath);
					if(!zipFileObj.exists()){
						isFileExist=false;
					}else{
						File dir = new File(IViewPropertyReader.ArchieveDIR+rsw.getString("device_name")+IViewPropertyReader.WARM+tablename.substring(8));
						if(!dir.exists()){
							dir.mkdir();
						}
						zipFileUtility.unzipFile(zipfilepath,IViewPropertyReader.ArchieveDIR+rsw.getString("device_name")+IViewPropertyReader.WARM+tablename.substring(8)+"/");
						isFileExist=true;
					}
				}else{
					isFileExist=true;
				}
				if(isFileExist){
					randomAccessFile = new RandomAccessFile(fileObj,"r");		
					openFileMap.put(new String(filepath),randomAccessFile);
					randomAccessFile.seek(rsw.getLong("offsetvalue"));
					columnArrayList.add(randomAccessFile.readLine());
				}else{
					columnArrayList.add("-");
				}
				recordArrayList.add(columnArrayList);
	    		while(rsw.next()){
	    			columnArrayList = new ArrayList();
					for(int columncount=0;columncount<columnNameArrayList.size();columncount++){
						columnArrayList.add(rsw.getString((String)columnNameArrayList.get(columncount)));
					}
					isFileExist=true;
					filepath=IViewPropertyReader.ArchieveDIR+rsw.getString("device_name")+IViewPropertyReader.WARM+tablename.substring(8)+"/"+rsw.getString("rowfilename");
					CyberoamLogger.appLog.debug(" Read This line from File : "+filepath);
					fileObj = new File(filepath);
					if(!fileObj.exists()){
						String zipfilepath=IViewPropertyReader.ArchieveDIR+rsw.getString("device_name")+IViewPropertyReader.COLD+tablename.substring(8)+"/"+rsw.getString("rowfilename")+".zip";
						File zipFileObj = new File(zipfilepath);
						if(!zipFileObj.exists()){
							isFileExist=false;
						}else{
							File dir = new File(IViewPropertyReader.ArchieveDIR+rsw.getString("device_name")+IViewPropertyReader.WARM+tablename.substring(8));
							if(!dir.exists()){
								dir.mkdir();
							}
							zipFileUtility.unzipFile(zipfilepath,IViewPropertyReader.ArchieveDIR+rsw.getString("device_name")+IViewPropertyReader.WARM+tablename.substring(8)+"/");
							isFileExist=true;
						}
					}else{
						isFileExist=true;
					}
					if(isFileExist){
						if(!openFileMap.containsKey(new String(filepath))){
							randomAccessFile = new RandomAccessFile(fileObj,"r");
							openFileMap.put(new String(filepath),randomAccessFile);
						}
						randomAccessFile = (RandomAccessFile)openFileMap.get(new String(filepath));
						randomAccessFile.seek(rsw.getLong("offsetvalue"));
						columnArrayList.add(randomAccessFile.readLine());
					}else{
						columnArrayList.add("-");
					}
					recordArrayList.add(columnArrayList);
	    		}
    		}
    	}catch(SQLException e){
    		CyberoamLogger.appLog.error("Exception in getSearchData():SearchDataBean :"+e,e);
    	}catch(Exception e){
    		CyberoamLogger.appLog.error("Exception in getSearchData():SearchDataBean :"+e,e);
    	}finally{
		 	   try{
			 	    sqlReader.close();
			 	    rsw.close();
			 	    if(openFileMap != null && openFileMap.size() > 0){
			 	    	Iterator iterator = openFileMap.keySet().iterator();
			 	    	while(iterator.hasNext()){
			 	    		String tmpFileName=(String)iterator.next();
			 	    		randomAccessFile = (RandomAccessFile)openFileMap.get(tmpFileName);
			 	    		CyberoamLogger.appLog.debug(" Closing File : "+tmpFileName);
			 	    		randomAccessFile.close();
			 	    	}
			 	    }
			 	  }catch(Exception e){}
	    }	 	 
    	return recordArrayList;
    }

	/**
	 * This method returns total record count available in given table matching given criteria.
	 */
	public static long getTotalRecordCount(String tablename,String criteria){
		ResultSetWrapper rsw=null;
		SqlReader sqlReader = null;
		String strQuery=null;
    	try{
    		sqlReader = new SqlReader(false);
    		strQuery="select count(*) as total from " + tablename + " " +  criteria;
    		rsw=sqlReader.getInstanceResultSetWrapper(strQuery);
    		if(rsw.next()){
				return rsw.getLong("total");
    		}
    	}catch(SQLException e){
    		CyberoamLogger.appLog.error("Exception in getSearchData():SearchDataBean :"+e,e);
    	}catch(Exception e){
    		CyberoamLogger.appLog.error("Exception in getSearchData():SearchDataBean :"+e,e);
    	}finally{
		 	   try{
			 	    sqlReader.close();
			 	    rsw.close();
			 	  }catch(Exception e){}
	    }	 	 
    	return -1;
    }
}
