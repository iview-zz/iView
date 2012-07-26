package org.cyberoam.iview.beans;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.RandomAccessFile;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.StringTokenizer;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.NumericRangeQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.search.TermRangeQuery;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.search.WildcardQuery;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.SimpleFSDirectory;
import org.apache.lucene.util.Version;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.search.IndexSearchBean;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iview.utility.IndexFileNameParsingUtility;
import org.cyberoam.iview.utility.zipFileUtility;


public class SearchIndexBean {

	private static String message = "";
	public static String getMessage() {
		return message;
	}

	public static void setMessage(String message) {
		SearchIndexBean.message = message;
	}

	/*
	 * method gets called when we apply different search criteria
	 */
	public static ArrayList<Object> getSearchData(HashMap<String,String> criteriaList){
		CyberoamLogger.appLog.error("In getSearchData function");
		ArrayList<Object> searchData = new ArrayList<Object>();
		try{
			String startDayArr = getAllConditions(criteriaList.get("upload_datetimeStart"))[1];
			String endDayArr = getAllConditions(criteriaList.get("upload_datetimeEnd"))[1];
			String device_name = getAllConditions(criteriaList.get("device_name"))[1];		
			Integer offset = new Integer(getAllConditions(criteriaList.get("offset"))[1]);
			String categoryID = getAllConditions(criteriaList.get("categoryID"))[1];
			CyberoamLogger.appLog.error("offset: "+offset);
			Integer limit = new Integer(getAllConditions(criteriaList.get("limit"))[1]);
			CyberoamLogger.appLog.error("limit: "+limit);
			int offsetCnt = 0;
			ArrayList criteria = new ArrayList();
			CyberoamLogger.appLog.error("device name: "+device_name);
			
			int startDayIdx = new Integer(startDayArr.substring(0,startDayArr.indexOf(" ")).replace("-", "")).intValue();
			int endDayIdx = new Integer(endDayArr.substring(0,endDayArr.indexOf(" ")).replace("-", "")).intValue();
				
			StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT);
			Directory INDEX_DIR = null;
			int hitsPerPage = limit + offset + 1;
			CyberoamLogger.appLog.error("hits per page: "+hitsPerPage);
			IndexSearcher searcher = null;
			TopScoreDocCollector collector = null;
						
			StringTokenizer st = new StringTokenizer(device_name,",");
			String deviceNameStr = "";
			ArrayList<String> selectedDevice = new ArrayList<String>();
			while(st.hasMoreTokens()){
				deviceNameStr = st.nextToken();
				selectedDevice.add(deviceNameStr.substring(1,deviceNameStr.length()-1));						
			}
			
			Iterator iterat = DeviceBean.getAllDeviceBeanIterator();
			ArrayList<String> notSelectedDeviceList = new ArrayList<String>();
			String app = null;
			while(iterat.hasNext()){
				app = ((DeviceBean)iterat.next()).getApplianceID();
				if(!selectedDevice.contains(app))
					notSelectedDeviceList.add(app);
			}
			/*
			 * loop for the days we want to search on
			 * e.g. startDayIdx = 20100120
			 * startDayIdx also denotes the folder in which our index data according to range resides
			 */
			ArrayList<IndexFieldsBean> indexFileList = IndexFieldsBean.getIndexFieldBeanListByCategoryID(categoryID);
			String[] fields = new String[indexFileList.size()];
			for(int n=0 ; n < indexFileList.size() ; n++){				  
				  fields[n] = ((IndexFieldsBean)indexFileList.get(n)).getIndexName();				  
			}
			boolean onlyIsnt = true; 
			String appidlist[]=device_name.split(",");
			for(int i=startDayIdx ; i <= endDayIdx ; i++){
				for(int m=0 ;m<appidlist.length ; m++){
				appidlist[m]=appidlist[m].replace("'","");		
				File indexFile=new File(IViewPropertyReader.IndexDIR+appidlist[m]+"/"+IndexSearchBean.getValueByKey("indexinfo")+"/"+i+"/"+"webindexlogger"+categoryID);
				if(!indexFile.exists()){
					continue;
				}					
				String[] timeIntervals = indexFile.list();
				
				for(int k=0 ; k <= timeIntervals.length ; k++){
										
					INDEX_DIR = new SimpleFSDirectory(new File(IViewPropertyReader.IndexDIR+appidlist[m]+"/"+IndexSearchBean.getValueByKey("indexinfo")+"/"+i+"/"+"webindexlogger"+categoryID+"/"+timeIntervals[k]));
					CyberoamLogger.appLog.error("date folder path: "+IViewPropertyReader.IndexDIR+appidlist[m]+"/"+IndexSearchBean.getValueByKey("indexinfo")+"/"+i+"/"+"webindexlogger"+categoryID+"/"+timeIntervals[k]);
					
					Query query = new BooleanQuery();					
									
					//for device list
					for(int iCnt=0 ; iCnt<notSelectedDeviceList.size() ; iCnt++){
						TermQuery termQry = new TermQuery(new Term("device_name",notSelectedDeviceList.get(iCnt)));
						((BooleanQuery)query).add(termQry, BooleanClause.Occur.MUST_NOT);
					}
						
					
					//BooleanClause.Occur.MUST is used in case of ANDing
					BooleanClause.Occur occur = BooleanClause.Occur.MUST;
					String searchCriteria =	criteriaList.get("indexCriteria");
					if(searchCriteria != null)
					{						
						//BooleanClause.Occur.SHOULD is used in case of ORing
						if(searchCriteria.indexOf("OR") == 0)													
							occur = BooleanClause.Occur.SHOULD;						
												
						String[] criteriaArr = searchCriteria.split(",");
						String condName = "";
						String cond = "";
						String condVal = "";
						TermQuery termQry = null;
						for(int tmp=1 ; tmp < criteriaArr.length ; tmp++)
						{
							criteriaArr[tmp] = criteriaArr[tmp].trim();
							condName = criteriaArr[tmp].substring(0,criteriaArr[tmp].indexOf(" "));
							cond = criteriaArr[tmp].substring(criteriaArr[tmp].indexOf(" ") + 1,criteriaArr[tmp].lastIndexOf(" ")).trim();
							condVal = criteriaArr[tmp].substring(criteriaArr[tmp].lastIndexOf(" ") + 1,criteriaArr[tmp].length());							
							condVal = condVal.trim();							
							if(cond.equals("="))
							{
								onlyIsnt = false;
								termQry = new TermQuery(new Term(condName,condVal));
								((BooleanQuery)query).add(termQry, occur);
							}
							else if(cond.equals("!="))
							{								
								termQry = new TermQuery(new Term(condName,condVal));
								((BooleanQuery)query).add(termQry, BooleanClause.Occur.MUST_NOT);
							}
							else if(cond.equals("like"))
							{
								onlyIsnt = false;
								WildcardQuery widlscardQry = new WildcardQuery(new Term(condName,condVal.replace("%", "*")));
								((BooleanQuery)query).add(widlscardQry, occur);
							}
							else if(cond.equals(">="))
							{
								onlyIsnt = false;
								Query numericQry = NumericRangeQuery.newLongRange(condName,new Long(condVal),null,true,true);
								((BooleanQuery)query).add(numericQry, occur);
								
							}
							else if(cond.equals(">"))
							{
								onlyIsnt = false;
								Query numericQry = NumericRangeQuery.newLongRange(condName,new Long(condVal),null,false,true);
								((BooleanQuery)query).add(numericQry, occur);
								
							}
							else if(cond.equals("<="))
							{
								onlyIsnt = false;
								Query numericQry = NumericRangeQuery.newLongRange(condName,null,new Long(condVal),true,true);
								((BooleanQuery)query).add(numericQry, occur);
								
							}
							else if(cond.equals("<"))
							{
								onlyIsnt = false;
								Query numericQry = NumericRangeQuery.newLongRange(condName,null,new Long(condVal),true,false);
								((BooleanQuery)query).add(numericQry, occur);
								
							}							
						}
					}
					//approch-1
					/*StringTokenizer stDevice = new StringTokenizer(device_name,",");
					String deviceNameStr1 = "";
					//below both the loops for adding all the selected devices
					while(stDevice.hasMoreTokens())
					{
						deviceNameStr1 = stDevice.nextToken();
						criteria.add(deviceNameStr1.substring(1,deviceNameStr1.length()-1));						
					}
										
					BooleanQuery deviceQuery = new BooleanQuery();
					for(int tmp=0 ; tmp < criteria.size() ; tmp++)
					{
						deviceQuery.add(new TermQuery(new Term("device_name",(String)criteria.get(tmp))),BooleanClause.Occur.MUST);						 
					}													
					
					((BooleanQuery)query).add(deviceQuery, BooleanClause.Occur.SHOULD);
					*/
					//end approch-1
					//approch-2
					//below is the condition to add all selected devices when there is only isn't criteria
					if(onlyIsnt)
					{
						Query criteriaQry = null;
						StringTokenizer stDevice = new StringTokenizer(device_name,",");
						String deviceNameStr1 = "";
						while(stDevice.hasMoreTokens())
						{
							deviceNameStr1 = stDevice.nextToken();
							criteriaQry = new TermQuery(new Term("device_name",deviceNameStr1.substring(1,deviceNameStr1.length()-1)));
							((BooleanQuery)query).add(criteriaQry, BooleanClause.Occur.SHOULD);
						}						
					}
					//end approch-2
														 	
					
					
					//INDEX_DIR on which we want to perform our search operation
				    searcher = new IndexSearcher(INDEX_DIR, true);
				    
				    /*
				     * hitsPerPage:- total no. or record we want to display
				     */
				    collector = TopScoreDocCollector.create(hitsPerPage, true);
				    searcher.search(query, collector);	    
				    CyberoamLogger.appLog.error("total records: "+collector.getTotalHits());	    
				    /*
				     * collector.topDocs().scoreDocs will collect total rows till our hitsPerPage
				     * e.g. if we want to display 51-60 records then we want to cache all 1-60 records 
				     * and from that we will display 51-60 record
				     */
				    
				    ScoreDoc[] hits = collector.topDocs().scoreDocs;
				    CyberoamLogger.appLog.error("after hits1[]: "+hits.length+" "+new Date());
				    	    	    	     
				    //alternate - 2 with sort criteria
				    /*Sort sort = new Sort(new SortField("upload_datetime",Locale.ENGLISH,false));
				    //TopFieldDocs tfd = searcher.search(query, new PrefixFilter(new Term("src_ip","")),hitsPerPage,sort);	    
				    TopFieldDocs totalFieldDocs = searcher.search(query, new QueryWrapperFilter(query),hitsPerPage,sort);
				    
				    ScoreDoc[] hits = totalFieldDocs.scoreDocs;*/
				    			    
				    ArrayList<String> record = null;
				     for(int j=0 ; j < hits.length ; j++) {
				    	 offsetCnt++;
				    	 /*
				    	  * the condition is to check whether we have reached at the location from which
				    	  * we want to display our rows 
				    	  */
				    	 if(offsetCnt > offset)
				    	 {
					    	 record = new ArrayList<String>();
					    	 int docId = hits[j].doc;
						      Document doc = searcher.doc(docId);
						      for(int n=0 ; n < fields.length - 2 ; n++){
						    	  if(n==0){
						    		  String dt=""+doc.get(fields[n]);
						    		  record.add(dt.substring(0,4)+"-"+dt.substring(4,6)+"-"+dt.substring(6,8)+" "+dt.substring(8,10)+":"+dt.substring(10,12)+":"+dt.substring(12,14));
						    	  }else{
						    		  record.add(doc.get(fields[n]));
						    	  }	  
						      }						      
						      //archive file data start
						      boolean isFileExist=true;
								String filepath=IViewPropertyReader.ArchieveDIR+doc.get("device_name")+IViewPropertyReader.WARM+i+"/"+doc.get(fields[fields.length - 2]);
								CyberoamLogger.appLog.debug(" Read This line from File : "+filepath);
								File fileObj = new File(filepath);
								if(!fileObj.exists()){
									String zipfilepath=IViewPropertyReader.ArchieveDIR+doc.get("device_name")+IViewPropertyReader.COLD+i+"/"+doc.get(fields[fields.length - 2])+".zip";
									File zipFileObj = new File(zipfilepath);
									if(!zipFileObj.exists()){
										isFileExist=false;
									}else{
										File dir = new File(IViewPropertyReader.ArchieveDIR+doc.get("device_name")+IViewPropertyReader.WARM+i);
										if(!dir.exists()){
											dir.mkdir();
										}
										zipFileUtility.unzipFile(zipfilepath,IViewPropertyReader.ArchieveDIR+doc.get("device_name")+IViewPropertyReader.WARM+i+"/");
										isFileExist=true;
									}
								}else{
									isFileExist=true;
								}
								if(isFileExist){
									RandomAccessFile randomAccessFile = new RandomAccessFile(fileObj,"r");
									randomAccessFile.seek(new Long(doc.get(fields[fields.length - 1])));
									record.add(randomAccessFile.readLine());
									randomAccessFile.close();
									randomAccessFile = null;
								}else{
									record.add("-");
								}
						      //archive file data end
						      
						      //record.add("0");
						      searchData.add(record);
						      if(searchData.size() == limit + 1)
						    	  break;
				    	 }
				    }	    	     
					    
				    searcher.close();
				    if(searchData.size() == limit + 1)
				    	  break;
				}
				if(searchData.size() == limit + 1)
			    	  break;
			}
			}	
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception in SearcchIndexBean.java: "+e);
			CyberoamLogger.appLog.error("Exception in SearcchIndexBean.java message: "+e.getMessage());
		}catch(Error e){
			CyberoamLogger.appLog.error("Error in SearcchIndexBean.java: "+e);
			CyberoamLogger.appLog.error("Error in SearcchIndexBean.java message: "+e.getMessage());
			if(e.getMessage().equals("Java heap space")){
				SearchIndexBean.setMessage("Java heap space");
			}
		}
				
		return searchData;
	}
	
	/*
	 * method gets called when we want to search only on date range
	 */
	public static ArrayList<Object> getDateRangeData(HashMap<String,String> criteriaList){
		CyberoamLogger.appLog.error("In getDateRangeData function");
		ArrayList<Object> searchData = new ArrayList<Object>();
		try{
			String startDayArr = getAllConditions(criteriaList.get("upload_datetimeStart"))[1];
			String endDayArr = getAllConditions(criteriaList.get("upload_datetimeEnd"))[1];
			Integer limit = new Integer(getAllConditions(criteriaList.get("limit"))[1]);;
			Integer offset = new Integer(getAllConditions(criteriaList.get("offset"))[1]);
			String device_name = getAllConditions(criteriaList.get("device_name"))[1];
			int offsetCnt = 0;
		
			Long startDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startDayArr).getTime();
			Long endDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(endDayArr).getTime();
			
			CyberoamLogger.appLog.error("data range start date: "+startDate);
			CyberoamLogger.appLog.error("data range end date: "+endDate);
			
			String sDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(startDayArr));
			String eDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(endDayArr));
			
			CyberoamLogger.appLog.error("sDate searchindexbean: "+sDate);
			CyberoamLogger.appLog.error("eDate searchindexbean: "+eDate);
			String fileTimestamp = ""; 
			if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
				fileTimestamp = "fileeventtimestamp";
			}else{
				fileTimestamp = "filecreationtimestamp";
			}
			String criteria = "where "+fileTimestamp+" between '"+startDate/1000+"' and '"+endDate/1000+"' and (";
			StringTokenizer stt = new StringTokenizer(device_name,",");
			while(stt.hasMoreTokens()){
				String crit = stt.nextToken();
				if(stt.hasMoreTokens())
					criteria += " appid='"+ crit.substring(1,crit.length() - 1)+"' or";
				else
					criteria += " appid='"+ crit.substring(1,crit.length() - 1)+"'";
			}
			criteria += ")";
			ArrayList fileList = FileHandlerBean.getFileList(criteria, "", sDate, eDate);						
			FileInputStream fstream = null;
			DataInputStream in = null;
			BufferedReader br = null;
			FileHandlerBean fileHandlerBean = null;
			
		/*	sDate=sDate.replaceAll("-", "");
			eDate=eDate.replaceAll("-", "");
			int enddate=Integer.parseInt(eDate);
			int startdate =Integer.parseInt(sDate);
			*/ArrayList<String> record = null;
			int j=0;
			for(int i = fileList.size() - 1 ; i >= 0 ; i--){
				record = new ArrayList<String>();							   
			    fileHandlerBean = (FileHandlerBean)fileList.get(i);
			    String dtfolder=fileHandlerBean.getFileEventTimestamp();
			    dtfolder=FileHandlerBean.unixToDate(dtfolder);
			    dtfolder=dtfolder.split(" ")[0].replace("-","");
			    File DateFolder = new File(IViewPropertyReader.ArchieveDIR+fileHandlerBean.getAppID()+IViewPropertyReader.WARM+dtfolder);
			    if(!DateFolder.exists()){
			    	record.add("-");
			    	continue;
			    }else{				    
					fstream = new FileInputStream(IViewPropertyReader.ArchieveDIR+fileHandlerBean.getAppID()+IViewPropertyReader.WARM+dtfolder+"/"+fileHandlerBean.getFileName());
					 
					in = new DataInputStream(fstream);
					br = new BufferedReader(new InputStreamReader(in));
					String strLine=null;
					  
					for( ; (strLine = br.readLine()) != null ; j++)   {
						if(j>=offset){
							/*record = new ArrayList<String>();
							String [] strtemp=strLine.split("\t");
							for(int k=0 ; k<strtemp.length ; k++){
								record.add(strtemp[k]);
							}*/	
							searchData.add(strLine);
							if(searchData.size() == limit + 1)
					    	  break;
						}
					}
					br.close();
					in.close();
					fstream.close();  					
				}						
				
			    if(searchData.size() == limit + 1)
			    	  break;
			}
			/*}
			
			for(int i = fileList.size() - 1 ; i >= 0 ; i--){
				fileHandlerBean = (FileHandlerBean)fileList.get(i);
				String timestamp = null;
				if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
					timestamp = new SimpleDateFormat("yyyyMMdd").format(new Date(new Long(fileHandlerBean.getFileEventTimestamp())*1000));
					fstream = new FileInputStream(IViewPropertyReader.IndexDIR+fileHandlerBean.getAppID()+IViewPropertyReader.WARM+timestamp+"/"+fileHandlerBean.getFileName());
				}else{
					timestamp = new SimpleDateFormat("yyyyMMdd").format(new Date(new Long(fileHandlerBean.getFileCreationTimestamp())*1000));
					fstream = new FileInputStream(IViewPropertyReader.IndexDIR+fileHandlerBean.getAppID()+IViewPropertyReader.WARM+timestamp+"/"+fileHandlerBean.getFileName());
				}				
				in = new DataInputStream(fstream);
				br = new BufferedReader(new InputStreamReader(in));
				String line = "";
				ArrayList<String> record = null;
				String[] recordsArr = null;
				int n;
				while(null != (line = br.readLine()))	{
					
					 offsetCnt++;
			    	 if(offsetCnt > offset)
			    	 {						
						StringTokenizer st = new StringTokenizer(line,"\t");
						if(recordsArr == null)
							recordsArr = new String[st.countTokens()];
						n=0;
						while(st.hasMoreTokens()){
							recordsArr[n++] = st.nextToken();
						}						
						
						record = new ArrayList<String>();
						for(n=0 ; n < recordsArr.length - 2 ; n++){
							record.add(recordsArr[n]);
						}						  
					      
					    //archive file data start
					      boolean isFileExist=true;
					      String archiveFileName = recordsArr[recordsArr.length - 2];
							String filepath=IViewPropertyReader.ArchieveDIR+fileHandlerBean.getAppID()+IViewPropertyReader.WARM+timestamp+"/"+archiveFileName;
							CyberoamLogger.appLog.debug(" Read This line from File : "+filepath);
							File fileObj = new File(filepath);
							if(!fileObj.exists()){
								String zipfilepath=IViewPropertyReader.ArchieveDIR+fileHandlerBean.getAppID()+IViewPropertyReader.COLD+timestamp+"/"+archiveFileName+".zip";
								File zipFileObj = new File(zipfilepath);
								if(!zipFileObj.exists()){
									isFileExist=false;
								}else{
									File dir = new File(IViewPropertyReader.ArchieveDIR+fileHandlerBean.getAppID()+IViewPropertyReader.WARM+timestamp);
									if(!dir.exists()){
										dir.mkdir();
									}
									zipFileUtility.unzipFile(zipfilepath,IViewPropertyReader.ArchieveDIR+fileHandlerBean.getAppID()+IViewPropertyReader.WARM+timestamp+"/");
									isFileExist=true;
								}
							}else{
								isFileExist=true;
							}
							if(isFileExist){
								RandomAccessFile randomAccessFile = new RandomAccessFile(fileObj,"r");								
								randomAccessFile.seek(new Long(recordsArr[recordsArr.length - 1]));
								record.add(randomAccessFile.readLine());
								randomAccessFile.close();
								randomAccessFile = null;
							}else{
								record.add("-");
							}
					      //archive file data end
							
							searchData.add(record);
						      if(searchData.size() == limit + 1)
						    	  break;
			    	 }
				}
				br.close();
				in.close();
				fstream.close();
				
				br = null;
				in = null;
				fstream = null;
								
			      if(searchData.size() == limit + 1)
			    	  break;
			}*/
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception in getDateRangeData function: "+e);
		}
		
		return searchData;
	}
	private static String[] getAllConditions(String criteriaStr){
		String[] criteria = new String[2];
		
		criteria[0] = criteriaStr.substring(0,criteriaStr.indexOf(","));		
		criteria[1] = criteriaStr.substring(criteriaStr.indexOf(",")+1,criteriaStr.length());
		
		return criteria;
	}
}
