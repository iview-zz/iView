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


import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.FileHandlerBean;
import org.cyberoam.iview.helper.LoadDataHandler;

/**
 * This Thread class is use to extract raw files 
 * This thread first gets all archive files then
 * makes list of files created between given start and end rawlog file.
 * <p>Comparison is based on unix time stamp available to file name itself.<br>
 * If file is created between given start and end time stamp but extracted
 * file is available in warm directory than no need to extract that file.</p>
 * <p>Now we having list of files that actually need to be extracted.<br>
 * Run separate thread named rawFilesSizeCountThread for writing status
 * information to display progress bar for extracting process and then 
 * start extract rawlog file from cold to warm directory one bye one.</p>
 * <p>Before extracting each raw file we read stop status file to confirm 
 * that whether any request for terminating extract process or not.</p>
 * 
 * @author Narendra Shah
 */
public class ExtractRowFilesThread implements Runnable{

	private String startRowFile;
	private String endRowFile;
	private ArrayList appIDList;
	/**
	 * Default constructor for extract raw file thread.
	 */
	public ExtractRowFilesThread(){}
	/**
	 * Constructor to initialize thread with given start raw file, end raw file and 
	 * {@link ArrayList} containing list of appliance Ids. 
	 * @param startRowFile
	 * @param endRowFile
	 * @param appIDs
	 */
	public ExtractRowFilesThread(String startRowFile,String endRowFile,ArrayList appIDs){
		this.appIDList=appIDs;
		this.startRowFile=startRowFile;
		this.endRowFile=endRowFile;
	}
	/**
	 * This method will be called by start method to process thread. 
	 */
	public void run(){
		ArrayList fileToExtract=null;
		FileWriter fileWriter=null;
		BufferedReader bufferedReader=null;
		File fileObj=null;
		
		String strDay = "";
		String appID=null;
		String coldDir=null;
		String warmDir=null;
		for(int i=0;i<appIDList.size();i++){
			appID=(String)appIDList.get(i);
			coldDir=IViewPropertyReader.ArchieveDIR+appID+IViewPropertyReader.COLD;
			warmDir=IViewPropertyReader.ArchieveDIR+appID+IViewPropertyReader.WARM;
			try{
				if(!"".equalsIgnoreCase(startRowFile) && !"".equalsIgnoreCase(endRowFile)){
					long lowertimestamp=0;
					long uppertimestamp=0;
					try{
						if(startRowFile != null && !"".equalsIgnoreCase(startRowFile)){
							//lowertimestamp=Long.parseLong(startRowFile.substring(startRowFile.lastIndexOf("_")+1,startRowFile.indexOf(".")));
							if(IViewPropertyReader.IndexFileTimeStampUsed==2){
								lowertimestamp=Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(startRowFile));
							}else{
								lowertimestamp=Long.parseLong(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(startRowFile));
							}
						}
						if(endRowFile != null && !"".equalsIgnoreCase(endRowFile)){
							if(IViewPropertyReader.IndexFileTimeStampUsed==2){
								uppertimestamp=Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(endRowFile));
							}else{
								uppertimestamp=Long.parseLong(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(endRowFile));
							}
							//uppertimestamp=Long.parseLong(endRowFile.substring(endRowFile.lastIndexOf("_")+1,endRowFile.indexOf(".")));
						}
						if(uppertimestamp < lowertimestamp){
							long tmp = uppertimestamp;
							uppertimestamp =lowertimestamp;
							lowertimestamp = tmp;
						}
					}catch(Exception e){
						CyberoamLogger.sysLog.error(" Exception while getting row file lower & upper unix time stamp ");
					}
					
					if(lowertimestamp!=0 && uppertimestamp!=0){
						strDay = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(1000*lowertimestamp));
						CyberoamLogger.sysLog.debug(" Day is --> " + strDay);
						fileObj = new File(coldDir+strDay+"/");
						String fileList[] = fileObj.list(new FileFilter(IViewPropertyReader.RowLogFileFilterRegExp));
						CyberoamLogger.sysLog.debug(" File list " + fileList.length);
						CyberoamLogger.sysLog.debug(" Row file lower unix time stamp --> "+lowertimestamp);
						CyberoamLogger.sysLog.debug(" Row file upper unix time stamp --> "+uppertimestamp);
						for(int filecount=0;filecount<fileList.length;filecount++){
							long currentfiletimestamp=0;
							if(IViewPropertyReader.IndexFileTimeStampUsed==2){
								currentfiletimestamp=Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(fileList[filecount]));
							}else{
								currentfiletimestamp=Long.parseLong(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(fileList[filecount]));
							}
							if(lowertimestamp <= currentfiletimestamp && currentfiletimestamp <= uppertimestamp){												
								if(fileToExtract == null){
									fileToExtract = new ArrayList();
								}
								File tmpFileObj = new File(warmDir+strDay+"/"+fileList[filecount].substring(0,fileList[filecount].length()-4)); 
								if(!tmpFileObj.exists()){									
									fileToExtract.add(fileList[filecount]);
								}else{
									CyberoamLogger.sysLog.debug("Files Available");
								}
							}
						}
						
						RowFilesSizeCountThread rowFilesSizeCountThread= new RowFilesSizeCountThread(fileToExtract,strDay,appID);
						Thread fileSizeCountThread = new Thread(rowFilesSizeCountThread);
						fileSizeCountThread.start();
						if(fileToExtract == null){
							CyberoamLogger.sysLog.debug(" No archive file available ");
						}else{
							for(int filecount=0;filecount<fileToExtract.size();filecount++){
									
								if(LoadDataHandler.getStopFlag() == 1){
									CyberoamLogger.sysLog.error(" Terminating ExtractRowFileThread  ");
									break;
								}
								File dirObj = new File(IViewPropertyReader.ArchieveDIR+appID+IViewPropertyReader.WARM+strDay);
								if(!dirObj.exists()){
									dirObj.mkdirs();
								}
								if( zipFileUtility.unzipFile(coldDir +strDay+"/"+(String)fileToExtract.get(filecount),warmDir+strDay+"/")==1){
									FileHandlerBean.updateLoadedIndexedFileStatus(((String)fileToExtract.get(filecount)).split("[.]")[0]+".log","tblfilelist"+strDay,1);
									CyberoamLogger.sysLog.debug(" File extracted successFully");
								}else{
									FileHandlerBean.updateLoadedIndexedFileStatus(((String)fileToExtract.get(filecount)).split("[.]")[0]+".log","tblfilelist"+strDay,1);
									CyberoamLogger.sysLog.debug(" Problem in extracting file");
								}
							}
						}
						
					}else{
						CyberoamLogger.sysLog.debug(" Problem in parsing timestamp range ");
					}
				//	LoadDataHandler.setProcessPercentComplete(100);
				}else{
					CyberoamLogger.sysLog.debug("Only one row file will use ");
					if("".equalsIgnoreCase(startRowFile)){
						if(IViewPropertyReader.IndexFileTimeStampUsed==2){
							strDay = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(1000*Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(endRowFile))));
						}else{
							strDay = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(1000*Long.parseLong(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(endRowFile))));
						}
						fileObj = new File(IViewPropertyReader.ArchieveDIR+IViewPropertyReader.COLD+strDay+"/"+endRowFile+".zip");
					}else if("".equalsIgnoreCase(endRowFile)){
						if(IViewPropertyReader.IndexFileTimeStampUsed==2){
							strDay = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(1000*Long.parseLong(IndexFileNameParsingUtility.getFileSecondUnixTimeStamp(startRowFile))));
						}else{
							strDay = (new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date(1000*Long.parseLong(IndexFileNameParsingUtility.getFileFirstUnixTimeStamp(startRowFile))));
						}
						fileObj = new File(IViewPropertyReader.ArchieveDIR+IViewPropertyReader.COLD+strDay+"/"+startRowFile+".zip");
					}
					if(fileObj != null && fileObj.exists()){
						LoadDataHandler.setProcessPercentComplete(0);
						File dirObj = new File(IViewPropertyReader.ArchieveDIR+IViewPropertyReader.WARM	+strDay);
						if(!dirObj.exists()){
							dirObj.mkdirs();
						}
						if(zipFileUtility.unzipFile(fileObj.getName(),IViewPropertyReader.ArchieveDIR+IViewPropertyReader.WARM+strDay+"/")==1){
							FileHandlerBean.updateLoadedIndexedFileStatus(fileObj.getName(),"tblfilelist"+strDay,1);
							CyberoamLogger.sysLog.debug(" File extracted successFully");
						}else{
							FileHandlerBean.updateLoadedIndexedFileStatus(fileObj.getName(),"tblfilelist"+strDay,1);
							CyberoamLogger.sysLog.debug(" Problem in extracting file");
						}
						
					}
				}
			//	LoadDataHandler.setProcessPercentComplete(100);
			}catch(Exception e){
				CyberoamLogger.sysLog.error(" Exception while extracting row files "+e,e);
			}
		}
		LoadDataHandler.setProcessPercentComplete(100);		
	}
}
