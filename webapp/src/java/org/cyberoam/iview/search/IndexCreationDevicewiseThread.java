
package org.cyberoam.iview.search;

import java.io.File;

import org.cyberoam.iview.audit.CyberoamLogger;

/***
 * This class represents start thread device wise for creating index.
 * @author Hemant Agrawal
 *
 */
 
public class IndexCreationDevicewiseThread implements Runnable{

	private String  path;
	private int categoryid;
	
	/*	It is costructor which set path and category id 
	*	
	*/
	IndexCreationDevicewiseThread(String path,int categoryid) {
		this.path = path;		
		this.categoryid=categoryid;
	}
	
	/*	it is start thread and call index create method in index manager. 
	*	it get chunksize from database and pass chunksize , device wise rotated folder path and category id for device.
	*/
	public void run() {
		CyberoamLogger.appLog.debug(" call index creation devicewise  devicepath : "+path);
		long chunksize=0;	
		IndexManager indexManager=null;
		try{
			chunksize=Long.parseLong(IndexSearchBean.getValueByKey("chunksize"));															
			if(new File(path).exists()){	
				indexManager=new IndexManager();
				indexManager.createIndex(path,chunksize,categoryid);
			}	
		}catch(Exception e){
			CyberoamLogger.repLog.error("IndexCreationDevicewiseThread Exception : "+e);
		}
	}


}