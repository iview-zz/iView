
package org.cyberoam.iview.search;

import java.util.Date;
import java.util.Iterator;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.io.File;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.device.beans.DeviceTypeBean;
import org.cyberoam.iview.utility.IViewPropertyReader;


/***
 * This class represents start thread device wise for creating index.
 * @author Hemant Agrawal
 *
 */
 
class IndexCreationThread implements Runnable {

	/* This thread run and getting device from device bean and also getting category id. 
	*  it getting pool size from configure table.
	*  it called indexcreationdevicewise thread.
	*  
	*/
	public void run() {
		CyberoamLogger.appLog.debug(" call index creation thread   ");
		DeviceBean devicebean=null;
		String path=null;
		try{			
			Date d=new Date();			
			path=IViewPropertyReader.IndexDIR;
			CyberoamLogger.appLog.debug(" index directory path :"+path);
			Iterator deviceIterator=DeviceBean.getDeviceBeanIterator();
			ExecutorService executor = Executors.newFixedThreadPool(Integer.parseInt(IndexSearchBean.getValueByKey("PoolSize")));
			while(deviceIterator.hasNext()){
					devicebean = (DeviceBean)deviceIterator.next();
					if(devicebean!=null){						
						if(devicebean.getDeviceStatus()==2){							
							if(new File(path+devicebean.getApplianceID()).exists()){								
								int devicettypeid=devicebean.getDeviceType();
								DeviceTypeBean deviceTypeBean=(DeviceTypeBean)DeviceTypeBean.getRecordbyPrimarykey(devicettypeid);								
								Runnable indexthread = new IndexCreationDevicewiseThread(path+devicebean.getApplianceID()+IViewPropertyReader.HOT,deviceTypeBean.getCategoryId());							
								executor.execute(indexthread);
							}								
						}
					}
			}
			executor.shutdown();
			while (!executor.isTerminated()) {
				Thread.sleep(5000);
			}
			Date d1=new Date();
			CyberoamLogger.repLog.error("Finished all threads time ="+(d1.getTime()-d.getTime()));
		}catch (Exception e){
			CyberoamLogger.repLog.error("IndexCreationThread Exception : "+e);
		}	
	}
		
}	