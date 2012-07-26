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


import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.helper.LoadDataHandler;



/**
 * This utility class is used to calculate size of raw log files.
 * This utility will be used in {@link ExtractRowFilesThread}.
 * @author Narendra Shah
 *
 */
public class RowFilesSizeCountThread implements Runnable{

	ArrayList zipeFilelist;
	ArrayList rowFilelist;
	String strDay;
	String appID;
	long totalAllFilesSize=0;
	/**
	 * Default constructor.
	 */
	public RowFilesSizeCountThread(){}
	/**
	 * Constructor which initializes file list and day.
	 * @param fileList
	 * @param strDay
	 */
	public RowFilesSizeCountThread(ArrayList fileList,String strDay,String appID){
		this.zipeFilelist=fileList;
		this.strDay = strDay;
		this.appID= appID;
	}
	
	/**
	 * This method calculates size of given raw log files.
	 */
	public void run(){
		
		FileWriter fileWriter=null;
		BufferedReader bufferedReader=null;
		ArrayList fileToExtract=null;
		File fileObj=null;
		BufferedInputStream is = null;
		try{
			
			if(zipeFilelist == null || zipeFilelist.size() <= 0){
				CyberoamLogger.appLog.debug(" No Zip File to Extract ");
				
				LoadDataHandler.setProcessPercentComplete(100);
			}else{
				CyberoamLogger.appLog.debug(" Total extacted file size count thread started");
				LoadDataHandler.setProcessPercentComplete(0);
					
				for(int filecount=0;filecount<zipeFilelist.size();filecount++){
					try{
						ZipFile zipfile = new ZipFile(IViewPropertyReader.ArchieveDIR +appID+IViewPropertyReader.COLD+strDay+"\\"+(String)zipeFilelist.get(filecount));
						ZipEntry entry;
						Enumeration e = zipfile.entries();
				        while(e.hasMoreElements()) {
				        	entry = (ZipEntry) e.nextElement();
				        	if(rowFilelist == null){
				        		rowFilelist = new ArrayList();
				        	}
				        	rowFilelist.add(entry.getName().substring(entry.getName().lastIndexOf("\\")));				            
				            is = new BufferedInputStream(zipfile.getInputStream(entry));				            
				            totalAllFilesSize = totalAllFilesSize + is.available();
				            is.close();
				            is=null;
				        }
					}catch(Exception e){
						CyberoamLogger.appLog.error(" Exception while getting zip file size of --> "+zipeFilelist.get(filecount));	
					}
				}	
				
				while( true ){
					long extractedSize = 0;
					for(int filecount=0;filecount<rowFilelist.size();filecount++){
						fileObj = new File(IViewPropertyReader.ArchieveDIR+appID+IViewPropertyReader.WARM+strDay+"\\"+((String)rowFilelist.get(filecount)));
						if(fileObj.exists()){
							extractedSize = extractedSize + fileObj.length();
						}
					}
					
					try{
						int extractedPercentage = (int)((extractedSize*100)/totalAllFilesSize); 						
						LoadDataHandler.setProcessPercentComplete(extractedPercentage);
						
						if(extractedPercentage == 100){													
							break;
						}		
						if(LoadDataHandler.getStopFlag() == 1){
							CyberoamLogger.sysLog.error(" Terminating RowFileSizeCountThread ");
							break;
						}
						Thread.currentThread().sleep(1000);
					}catch(Exception e){
						CyberoamLogger.sysLog.error(" Exception while writting extracted size for process status ");
					}
					
				}
			}
		}catch(Exception e){
			CyberoamLogger.sysLog.error("Exception while counting row file size and writting status for processbar --> "+e,e);	
		}
	}
}
