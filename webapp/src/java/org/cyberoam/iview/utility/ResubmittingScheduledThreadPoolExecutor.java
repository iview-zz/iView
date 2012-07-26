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

import java.util.IdentityHashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import org.cyberoam.iview.audit.CyberoamLogger;
/**
 * This utility class is used for submitting thread at initialization of iView.
 * if an error occurs then will report for that and reschedules the thread.
 * @author Avani Thakker
 */

public class ResubmittingScheduledThreadPoolExecutor extends ScheduledThreadPoolExecutor {

	/** Default exception handler, always reschedules */
	private static final ScheduledExceptionHandler NULL_HANDLER = new ScheduledExceptionHandler() {
        public boolean exceptionOccurred(Throwable e) {
          return true;
        }
      };
      
      private final Map<Object, FixedRateParameters> runnables = new IdentityHashMap<Object, FixedRateParameters>();
      private final ScheduledExceptionHandler handler;

	  /**
	   * @param reschedule when an exception causes a task to be aborted,  
	   *        reschedule it and notify the exception listener
	   */
	  public ResubmittingScheduledThreadPoolExecutor(int poolSize) {
		  this(poolSize, NULL_HANDLER);
	  }

	  public ResubmittingScheduledThreadPoolExecutor(int poolSize, ScheduledExceptionHandler handler) {
		  		super(poolSize);
		  		this.handler = handler;
	  }

	  private class FixedRateParameters 
	  {
		  private Runnable command;
		  private long period;
		  private TimeUnit unit;

	    /**
	     * We do not need initialDelay, since we can set it to period
	     */
		  public FixedRateParameters(Runnable command, long period,TimeUnit unit) {
		      this.command = command;
		      this.period = period;
		      this.unit = unit;
		  }
	  }

	  public ScheduledFuture<?> scheduleAtFixedRate(Runnable command, long initialDelay, long period,TimeUnit unit) 
	  {		  		  
		  CyberoamLogger.sysLog.info("ResubmittingScheduledThreadPoolExecutor:-> "+command.toString()+" thread scheduled.");
		  ScheduledFuture<?> future = super.scheduleAtFixedRate(command, initialDelay, period, unit);
		  runnables.put(future,new FixedRateParameters(command, period, unit));
		  return future;
	  }

	  @SuppressWarnings("unchecked")
	  protected void afterExecute(Runnable r, Throwable t) {				  
		  ScheduledFuture future = (ScheduledFuture) r;
		  // future.isDone() is always false for scheduled tasks,
		  //unless there was an exception		  
		  if (future.isDone()) {
			  try {			
				  future.get();
			  }
			  catch (ExecutionException e) {				  
				  Throwable problem = e.getCause();
				  FixedRateParameters parms = runnables.remove(r);
				  if (problem != null && parms != null) 
				  {
					  boolean resubmitThisTask = handler.exceptionOccurred(problem);
					  if (resubmitThisTask) {
						  scheduleAtFixedRate(parms.command, parms.period,parms.period, parms.unit);
					  }
				  }
			  } 
			  catch (InterruptedException e) {
				  Thread.currentThread().interrupt();
			  }
		  }
	  }
}  

  
class MyScheduledExceptionHandler implements ScheduledExceptionHandler {
      public boolean exceptionOccurred(Throwable e) {      
    	  CyberoamLogger.sysLog.info("ResubmittingScheduledThreadPoolExecutor--> Error occured : "+e);
    	  CyberoamLogger.sysLog.info("ResubmittingScheduledThreadPoolExecutor-->Resubmitting task to scheduler");      
    	 
    	  return true;
    }
}
interface ScheduledExceptionHandler {
	  /**
	   * @return true if the task should be rescheduled;
	   *         false otherwise
	   */
	  boolean exceptionOccurred(Throwable e);
	}

  