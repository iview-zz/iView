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

package org.cyberoam.iview.helper;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.FileHandlerBean;
import org.cyberoam.iview.utility.ExtractRowFilesThread;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.LoadIndexFilesThread;
import org.cyberoam.iview.utility.zipFileUtility;
import org.cyberoam.iviewdb.utility.SqlReader;

/**
 * This class is used for handling data loading for archived logs.
 * @author Amit Maniar
 *
 */
public class LoadDataHandler {
		
	private static int STOPPED = 1;
	private static int RUNNING = 0;
	private static String firstrowfile=null;
	private static String lastrowfile=null;
	private static int running_process_flag=0;
	private static int extractrowfile=0;
	private static int stopFlag = STOPPED;
	private static int processPercentComplete=0;
	private static int commit = 1;
	
	public static int getCommit() {
		return commit;
	}

	public static void setCommit(int commit) {
		LoadDataHandler.commit = commit;
	}

	/**
	 * Returns flag which states whether process of loading data is already running or not.
	 * @return
	 */
	public static int getRunningProcessFlag(){
		return running_process_flag;
	}
	
	/**
	 * Returns flag which states whether to stop loading of archive or not.
	 * @return
	 */
	public static int getStopFlag() {
		return stopFlag;
	}
	
	/**
	 * Sets flag which states whether to stop loading of archive or not.
	 * @param stopFlag
	 */
	public static synchronized void setStopFlag(int stopFlag) {
		LoadDataHandler.stopFlag = stopFlag;
	}
	
	/**
	 * Returns percent of archived logs which is loaded till now.
	 * @return
	 */
	public static int getProcessPercentComplete() {
		return processPercentComplete;
	}
	
	/**
	 * Sets percent of archived logs which is loaded till now.
	 * @return
	 */
	public static synchronized void setProcessPercentComplete(int processPercentComplete) {
		LoadDataHandler.processPercentComplete = processPercentComplete;
	}
	
	/**
	 * This method processes loading of archived data based on parameters passed to it.
	 * @param request
	 * @param response
	 */
	public static void process(HttpServletRequest request,HttpServletResponse response){
		
		/*
		* Reading request parameter
		*/
		String indexfilelist = request.getParameter("indexfilelist");
		String extractrowlog = request.getParameter("extractrowlog");
		String daystring = request.getParameter("daystring");
		String startrowlogfile = request.getParameter("startrowlogfile");
		String endrowlogfile = request.getParameter("endrowlogfile");
		CyberoamLogger.sysLog.debug("Index File List --> " +indexfilelist);
		CyberoamLogger.sysLog.debug("Extractrowlog --> " +extractrowlog);
		CyberoamLogger.sysLog.debug("Day String -->  " +daystring);
		CyberoamLogger.sysLog.debug(" Startrowlogfile -->  " +startrowlogfile);
		CyberoamLogger.sysLog.debug(" Endrowlogfile -->  " +endrowlogfile);
		
		try{
			if(getStopFlag() == STOPPED){
				if(startrowlogfile == null && endrowlogfile == null){
					firstrowfile=null;
					lastrowfile=null;
					running_process_flag=0;
					extractrowfile=0;
					
					LoadDataHandler.setStopFlag(RUNNING);
					processPercentComplete=0;
				}else{
					response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate"));
					return;
				}
			}else{
				if(startrowlogfile == null && endrowlogfile == null){
					response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?msg=yes&startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate"));
					return;
				}
			}
		}catch(Exception e){
			CyberoamLogger.sysLog.error("Exception while initializing stop flag value false "+e,e);	
		}
		/*
		 * Initialization of local variable
		 */
	/*	ArrayList indexFileListToLoad = new ArrayList();
		
		String existtabletablelist="";
		String firstRowlogFile = "";
		String lastRowlogFile = "";
		String strLine="";
		String LastIndexFile = "";		
		BufferedReader br=null;
		boolean fileExist=false; 
		StringTokenizer st = null;
		int isFirstExistsFile=0;
		File fileObj = null;
		StringTokenizer stApplianceIDTokenizer=null;
		String fileName=null;
		String appID=null;
		String fileAppIDToken=null;
		String categoryID = request.getParameter("categoryID");
		
		*/
			/*
			 * Preparing index file list to load
			 * Extracting index file if needed
			 * Preparing list of file that already loaded 
			*/
		/*	CyberoamLogger.sysLog.debug(" Call For Load Index File ");
			try{
				if(indexfilelist != null){
					
					if(running_process_flag==1){ //Index Loading Process Running
						String queryString="indexflag=1&";
						if(extractrowfile==1){
							f=queryString+"extractrowlog=1&startrowlogfile="+firstrowfile+"&endrowlogfile="+lastrowfile;
						}
						response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?processrunning=yes&msg=yes&"+queryString+"&startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate"));
						return;
					}else{
						if("1".equalsIgnoreCase(extractrowlog)){
							extractrowfile=1;
						}
						running_process_flag=1;
					}
					st = new StringTokenizer(indexfilelist,",");
					while(st.hasMoreTokens()){
						fileAppIDToken = st.nextToken();
						stApplianceIDTokenizer=new StringTokenizer(fileAppIDToken,"@");
						appID=stApplianceIDTokenizer.nextToken();
						fileName=stApplianceIDTokenizer.nextToken();
						/*
						 * Checking of file existance in warm
						 * If not available in warm than extract it from cold
						*/
					/*	fileExist=false;
						fileObj = new File(IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+daystring+fileName);
						if(fileObj.exists()){
							fileExist = true;
						}else{
							CyberoamLogger.sysLog.error(" Indexed Warm File "+IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+daystring+System.getProperty("file.separator")+fileName+" NOT Exists");
							fileObj = new File(IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.COLD +daystring+System.getProperty("file.separator")+fileName+".zip");														
							if(fileObj.exists()){
								File dirObj = new File(IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+daystring);								
								if(!dirObj.exists()){													
									dirObj.mkdirs();
								}
								CyberoamLogger.sysLog.error(" Indexed Zip File "+IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.COLD+daystring+System.getProperty("file.separator")+fileName+".zip" +" Exists");
								if(zipFileUtility.unzipFile(IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.COLD+daystring+System.getProperty("file.separator")+fileName+".zip",IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+daystring+System.getProperty("file.separator")) == 1){
									CyberoamLogger.sysLog.error(" Index Zip file Extracted Successfully");
									fileExist=true;
								}
							}
							
						}
						if(fileExist){
							/*
							 * If file exist and is already loaded than add in loaded file list
							 * If file exist but not loaded than add in file list that have to load 
							 */
							
							/**
							 * @author avanithakker
							 * check table name generated by this 
							 */														
					/*		String fileNameParts[] = fileName.split("_");								
							long timestamp = Long.parseLong(fileNameParts[2].substring(0, fileNameParts[2].indexOf('.')));												
							String dateQuery = "select FROM_UNIXTIME(" + timestamp + ")";							
							String dateParts[] = ((SqlReader.getResultAsArrayList(dateQuery, 1000)).get(0)).toString().split("-");
							String tblName = new String("tblfilelist"+dateParts[0].substring(1)+dateParts[1]+(dateParts[2]).substring(0,2));							
							
							CyberoamLogger.appLog.error("file is loaded: "+IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+dateParts[0].substring(1)+dateParts[1]+(dateParts[2]).substring(0,2)+"/"+fileName);
							//if(FileHandlerBean.getIndexFileLoadStatus(fileName,tblName)==1 && FileHandlerBean.isTableExists((fileName).substring(0,(fileName).indexOf('.')))==1){
							if(new File(IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+dateParts[0].substring(1)+dateParts[1]+(dateParts[2]).substring(0,2)+"/"+fileName).exists() && FileHandlerBean.isTableExists((fileName).substring(0,(fileName).indexOf('.')))==1){
								if("".equalsIgnoreCase(existtabletablelist)){
									existtabletablelist = fileName.substring(0,fileName.indexOf('.'));
								}else{
									existtabletablelist = existtabletablelist + "," + fileName.substring(0,fileName.indexOf('.'));
								}
							}else{
								indexFileListToLoad.add(fileName);
								appIDList.add(appID);
							}							
							/*
							 * Reading start rowlog file name from first index file. 
							*/
				/*			if(isFirstExistsFile == 0){								
								try{
									br = new BufferedReader( new FileReader(IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+daystring+System.getProperty("file.separator")+fileName));									
									strLine = br.readLine();									
									br.close();									
									firstRowlogFile = strLine.substring( (strLine.substring(0,strLine.lastIndexOf(IViewPropertyReader.IndexFileFiledTerminator)-((IViewPropertyReader.IndexFileFiledTerminator).length()))).lastIndexOf(IViewPropertyReader.IndexFileFiledTerminator)+(IViewPropertyReader.IndexFileFiledTerminator.length()) , strLine.lastIndexOf(IViewPropertyReader.IndexFileFiledTerminator)) ;									
									CyberoamLogger.sysLog.debug(" First Row File Name : " + firstRowlogFile);
								}catch(Exception e){
									CyberoamLogger.sysLog.error(" Error While Reading  Row file name from first existing index file ");
								}
								isFirstExistsFile=1;
							}
						}
						LastIndexFile = fileName; 
					}
					CyberoamLogger.sysLog.debug(" List of Index file(s) have to Load -> "+indexFileListToLoad);
					CyberoamLogger.sysLog.debug(" List of table have to merge -> "+existtabletablelist);
					try{
						/*
						 * Reading last rowlog file name from last index file. 
						 * Directly Jump to LastIndexFileReadBytes bytes from end if file size greater than that   
						*/
				/*		br = new BufferedReader( new FileReader(IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+daystring+"/"+LastIndexFile));
						String tmp;
						long indexfilesize = new File(IViewPropertyReader.IndexDIR+appID+IViewPropertyReader.WARM+daystring+"/"+LastIndexFile).length();
						CyberoamLogger.sysLog.debug(" Last Index File size in bytes "+indexfilesize); 
						if(indexfilesize > IViewPropertyReader.LastIndexFileReadBytes){
							br.skip(indexfilesize-IViewPropertyReader.LastIndexFileReadBytes);
						}
						while((tmp = br.readLine()) != null){
							strLine = tmp;
						}
						br.close();									
						lastRowlogFile = strLine.substring( (strLine.substring(0,strLine.lastIndexOf(IViewPropertyReader.IndexFileFiledTerminator)-((IViewPropertyReader.IndexFileFiledTerminator).length()))).lastIndexOf(IViewPropertyReader.IndexFileFiledTerminator)+(IViewPropertyReader.IndexFileFiledTerminator.length()) , strLine.lastIndexOf(IViewPropertyReader.IndexFileFiledTerminator));
						CyberoamLogger.sysLog.debug(" Last Row File Name : " + lastRowlogFile);
					}catch(Exception e){
						CyberoamLogger.sysLog.error(" Error While Reading Row file name from Last existing index file --> "+e,e);
					}
					String pageno = request.getParameter("pageno");
					if(pageno==null || "".equalsIgnoreCase(pageno) || "null".equalsIgnoreCase(pageno)){
						pageno = "1";
					}
					if(indexFileListToLoad != null && indexFileListToLoad.size() > 0 && getStopFlag()==RUNNING){
						LoadIndexFilesThread loadIndexFilesThread = new LoadIndexFilesThread(indexFileListToLoad,appIDList,existtabletablelist,request.getParameter("checkeddate"),categoryID);
						Thread t = new Thread(loadIndexFilesThread);
						t.start();
						String queryString="indexflag=1&";
						if("1".equalsIgnoreCase(extractrowlog)){
							firstrowfile=firstRowlogFile;
							lastrowfile=lastRowlogFile;
							queryString=queryString+"extractrowlog=1&startrowlogfile="+firstRowlogFile+"&endrowlogfile="+lastRowlogFile;
						}
						response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?processrunning=yes&"+queryString+"&startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate")+"&pageno="+pageno);
					//}else if(!"".equalsIgnoreCase(firstRowlogFile) && !"".equalsIgnoreCase(lastRowlogFile) && "0".equalsIgnoreCase(strStopFlag)){
					}else if(!"".equalsIgnoreCase(firstRowlogFile) && !"".equalsIgnoreCase(lastRowlogFile) && getStopFlag() == RUNNING){		
						CyberoamLogger.sysLog.debug(" No index file to load so directly call for extract Rowlog Files ");
						try{
							running_process_flag=2;
							ExtractRowFilesThread extractRowFilesThread = new ExtractRowFilesThread(startrowlogfile,endrowlogfile,appIDList);
							Thread t = new Thread(extractRowFilesThread);
							t.start();
							response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?processrunning=yes"+"&startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate")+"&pageno="+pageno);
						}catch(Exception e){
							CyberoamLogger.sysLog.error(" Exeption in LoadDataHandler.java while Try to Extract Rowlog files "+e,e );
						}						
					}else{
						
						LoadDataHandler.setStopFlag(STOPPED);
						LoadDataHandler.setProcessPercentComplete(100);
						response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?stop=yes"+"&startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate")+"&pageno="+pageno);
					}
				}else{
					
					LoadDataHandler.setStopFlag(STOPPED);
					LoadDataHandler.setProcessPercentComplete(100);
					response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate"));
				}
			}catch(Exception e){
				CyberoamLogger.sysLog.error(" Exeption in LoadDataHandler.java while Preparing for Load Data "+e,e );
			}
		*/
			/*
			 * If user selected to extract rowlog than we run thread
			 * Thread extract all related rowlog files
			 */
			running_process_flag=2;
			if(startrowlogfile==null){
				startrowlogfile="";
			}else if(endrowlogfile==null){
				endrowlogfile="";
			}
			CyberoamLogger.sysLog.debug(" Call For Extract Rowlog Files ");
			ArrayList appIDList =new ArrayList();
			try{	
				if(getStopFlag() == RUNNING){
					String [] st = indexfilelist.split(",");
					for(int i=0 ; i<st.length  ;i++){
						String appidnm=st[i].split("@")[0];
						if(!appIDList.contains(appidnm)){
							appIDList.add(st[i].split("@")[0]);
						}
					}	
					running_process_flag=2;
					ExtractRowFilesThread extractRowFilesThread = new ExtractRowFilesThread(st[0].split("@")[1],st[st.length-1].split("@")[1],appIDList);
					Thread t = new Thread(extractRowFilesThread);
					t.start();
					response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?processrunning=yes"+"&startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate"));
				}else{
					response.sendRedirect(request.getContextPath()+"/webpages/archive.jsp?startdate="+request.getParameter("startdate")+"&enddate="+request.getParameter("enddate"));
				}
			}catch(Exception e){
				CyberoamLogger.sysLog.error(" Exeption in LoadDataHandler.java while Try to Extract Rowlog files "+e,e );
			}
		
	}
}
