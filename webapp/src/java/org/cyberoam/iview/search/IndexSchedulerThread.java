
package org.cyberoam.iview.search;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import org.cyberoam.iview.audit.CyberoamLogger;

/***
 * This class represents schedule thread and  start thread  for creating index.
 * @author Hemant Agrawal
 *
 */
 

public class IndexSchedulerThread{

	/**
	 * This method call from initServlet and start scheduling thread
	 */
	public void process(){
		
		CyberoamLogger.appLog.debug(" call index creation   ");
		int time=0;	
		
		//this try catch block specially handle string to number conversion exception
		
		try{
				// Here we take time from bean class because schedule time is user configurable
			
			 time=Integer.parseInt(IndexSearchBean.getValueByKey("time"));			
		}catch(NumberFormatException  e){
			CyberoamLogger.repLog.error("NumberFormatException in changing time from string to integer : " + e,e);
		}//complete try catch block 
		
		//This try catch block handle thread exception
		try{	
			ScheduledExecutorService schedExe = Executors.newSingleThreadScheduledExecutor();
			Runnable IndexThread = new IndexCreationThread();
			
			/* Start thread scheduling , 
			*  Argument 
			*  		1)	object which execute run method 
			*  		2)	initial delay
			*  		3)  delay between first thread complete and second thread start
			*  		4)	schedule time consider in second 
			*/
			
			 
			ScheduledFuture<?> sf = schedExe.scheduleWithFixedDelay(IndexThread, time*60,time*60, TimeUnit.SECONDS );
			
			//sf.get() method throw error if any interrupt come in running thread
			
			//CyberoamLogger.repLog.error(sf.get());
			
			//shutdownNow method it is not allow new thread in queue 
			//schedExe.shutdownNow();			
							
		} catch (Exception e) {
			CyberoamLogger.repLog.error("Exception in IndexSchedulerThread  : " + e,e);					
		}	
	
	}

	public static void main(String []args){
		IndexSchedulerThread i =new IndexSchedulerThread();
		i.process();
	}
}