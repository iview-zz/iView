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

/*
 * @(#)Timer.java
 *
 * Copyright (c) 1999 Ajay Iyer. All Rights Reserved.
 *
 * You may study, use, modify, and distribute this software for any
 * purpose provided that this copyright notice appears in all copies.
 *
 * This software is provided WITHOUT WARRANTY either expressed or
 * implied.
 *
 * @author  Ajay Iyer
 * @version 1.0
 * @date    09Mar1999
 *
 */

package org.cyberoam.iviewdb.helper;

import org.cyberoam.iview.audit.CyberoamLogger;
/**
  * <p>This class implements a simple timer. Every time the
  * timer clock cycle that is specified expires the TimerEvent
  * method on the given TimerListener object will be invoked.
  * This gives the object a chance to perform some type of
  * timeout checking.
  */

public class Timer extends Thread
{
  // TimerListener to receive TimerEvent notifications
  TimerListener m_timerListener;

  //Exit variable
  private boolean exit;
  // Number of seconds in each timer cycle
  int m_cycle;

  // Object to be supplied with the TimerEvent notification
  Object m_object;

  /**
    * <p>Constructs a new Timer object
    *
    * @param timerListener Object that will receive TimerEvent
    * notifications
    * @param cycle Number of seconds in each timer cycle
    */
  public Timer(TimerListener timerListener, int cycle)
    {
      m_timerListener = timerListener;
      m_cycle = cycle;
      m_object = null;
      exit     = false;
    }
  /**
    * <p>Constructs a new Timer object
    *
    * @param timerListener Object that will receive TimerEvent
    * notifications
    * @param cycle Number of seconds in each timer cycle
    * @param object Object to be supplied with the TimerEvent
    * notification
    */
  public Timer(TimerListener timerListener, int cycle,
               Object object)
    {
      m_timerListener = timerListener;
      m_cycle = cycle;
      m_object = object;
    }
  /**
    *<p>Sets the exit value default is false
    *
    * @param Tells the object to exit from loop
    */
   public  synchronized void setExit(boolean exit){
        this.exit = exit;
   }
  /**
    *<p>Gets the exit value default is false
    *
    *
    */
   public synchronized  boolean getExit(){
        return exit;
   }

  /**
    * <p>Runs the timer. The timer will run until stopped and
    * fire a TimerEvent notification every clock cycle
    */
  public void run()
    {
      // Loop until stopped
      while (true) {
		  CyberoamLogger.connectionPoolLog.debug("timer");
        try {
          if (getExit()) //set from calling program
            return;
          // Sleep for the clock cycle
          sleep(m_cycle * 1000);
        }
        catch (InterruptedException ex) {
        }

        // Fire a TimerEvent
        if (m_timerListener != null) {
          m_timerListener.TimerEvent(m_object);
        }
      }
    }
}
