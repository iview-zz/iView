package org.cyberoam.iview.utility;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.NumericField;
import org.apache.lucene.document.Field.Index;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.SimpleFSDirectory;
import org.apache.lucene.util.Version;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.FileHandlerBean;
import org.cyberoam.iview.beans.IndexFieldsBean;
import org.cyberoam.iview.helper.LoadDataHandler;

public class IndexFilesThread extends Thread {
	private ArrayList fileList = null;
	private String dateFolder = null;
	private String hrsLog = null;
	private String indexDir = null;
	private int totalFiles = 0;
	private String deviceCriteria = null;
	private long startDate = 0;
	private long endDate = 0;
	private String categoryID = null;
	
	public IndexFilesThread(String indexDir, ArrayList fileList, String dateFolder, String hrsLog, String deviceCriteria, long startDate, long endDate, String categoryID)	{
		this.indexDir = indexDir;
		this.fileList = fileList;
		this.dateFolder = dateFolder;
		this.hrsLog = hrsLog;
		this.deviceCriteria = deviceCriteria;
		this.startDate = startDate;
		this.endDate = endDate;
		this.categoryID = categoryID;
	}	
	public void setTotalFiles(int totalFiles){
		this.totalFiles = totalFiles;
	}
	public void run(){
		IndexWriter writer = null;
		Directory INDEX_DIR = null;
		try	{			
			StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT);			
			File file = new File(this.indexDir+"/"+"category"+this.categoryID+"/"+this.dateFolder+"/"+this.hrsLog);
			File tempDir = null;
			boolean mergeDir = false;
			if(file.exists() && file.list().length != 0){
				mergeDir = true;
				tempDir = new File(this.indexDir+"/"+"category"+this.categoryID+"/"+this.dateFolder+"/"+"temp"+this.hrsLog);
				INDEX_DIR = new SimpleFSDirectory(tempDir);
			}
			else{
				INDEX_DIR = new SimpleFSDirectory(file);
			}
			writer = new IndexWriter(INDEX_DIR, analyzer, true, IndexWriter.MaxFieldLength.UNLIMITED);	
			writer.setRAMBufferSizeMB(48);		   
			writer.setUseCompoundFile(false);
			FileInputStream fstream = null;
			DataInputStream in = null;
			BufferedReader br = null;
			FileHandlerBean fileHandlerBean = null;
			int processedFiles;
			String line = null;
			StringTokenizer st = null;
			ArrayList<IndexFieldsBean> indexFileList = IndexFieldsBean.getIndexFieldBeanListByCategoryID(categoryID);
			String[][] fields = new String[indexFileList.size()][3];
			
			IndexFieldsBean indexFieldsBean = null;
			for(int n=0 ; n < indexFileList.size() ; n++){
				  indexFieldsBean = (IndexFieldsBean)indexFileList.get(n);
				  fields[n][0] = indexFieldsBean.getIndexName();
				  fields[n][1] = indexFieldsBean.getDataType();
				  fields[n][2] = Boolean.toString(indexFieldsBean.isSearchable());
			}
			Index index = null;
			String fileListcriteria = "";
			String filePath = "";
			for(int i=fileList.size()-1 ; i >= 0 ; i--)	{				  
				  fileHandlerBean = (FileHandlerBean)fileList.get(i);
				  filePath = indexDir+fileHandlerBean.getAppID()+
							IViewPropertyReader.WARM+dateFolder+"/"+fileHandlerBean.getFileName();
				  try{
					  fstream = new FileInputStream(filePath);					  
				  }catch (Exception e) {
					  CyberoamLogger.appLog.error("IndexFilesThread Index file not found "+e);
					  continue;
				  	}
				  
				  in = new DataInputStream(fstream);
				  br = new BufferedReader(new InputStreamReader(in));
				  Document d = null;
				  while(null != (line = br.readLine()))	{					  
					  try{
					  st = new StringTokenizer(line,"\t");
					  
					  if(d == null)	  {
						  d = new Document();		
						  for(int n=0 ; n<fields.length ;n++){
							  if(fields[n][2].equals("true")){
								  index = Field.Index.NOT_ANALYZED_NO_NORMS;
							  }else{
								  index = Field.Index.NO;
							  }
							  
							  if(fields[n][1].equals("2")){
								  d.add(new Field(fields[n][0], st.nextElement().toString(), Field.Store.YES, index));  
							  }else{
								  d.add(new NumericField(fields[n][0],Field.Store.YES, Boolean.parseBoolean(fields[n][2])).setLongValue(new Long(st.nextElement().toString())));
							  }
						  }						  
					  }
					  else {			
						  for(int n=0 ; n<fields.length ;n++){							  							  
							  if(fields[n][1].equals("2")){
								  d.getField(fields[n][0]).setValue(st.nextElement().toString());								   
							  }else{
								  ((NumericField)d.getFieldable(fields[n][0])).setLongValue(new Long(st.nextElement().toString()));								  
							  }
						  }						  					  						 
					  }					  
					  writer.addDocument(d);		
					  }catch(Exception ee){
						  CyberoamLogger.appLog.error("Exception in IndexFilesThread: ee :",ee);
					  }
				  }
				  br.close();
				  in.close();			  
				  fstream.close();
				  br = null;
				  in = null;
				  fstream = null;
				  //FileHandlerBean.updateLoadedIndexedFileStatus(fileHandlerBean.getFileName(),"tblfilelist"+dateFolder,1);
				  //CyberoamLogger.appLog.error("loaded file name: "+fileHandlerBean.getFileName());
			  
				  if(fileListcriteria.equals(""))
					  fileListcriteria = fileListcriteria + " and filename='"+fileHandlerBean.getFileName()+"'";
				  else
					  fileListcriteria = fileListcriteria + " or filename='"+fileHandlerBean.getFileName()+"'";
				  if(LoadDataHandler.getStopFlag() == 1) {
					CyberoamLogger.appLog.error("going to stop load data handler from " + writer.getDirectory());
					break;
				  }				 
				  
				  /*
				   * LoadIndexFilesThread.getProcessedFiles() is a static method for an int variable
				   * and that variable gets incremented each time we complete indexing of each file
				   * and this method is synchronized so that multiple threads can work synchronous
				   * on this method 
				   */
				  
				  processedFiles = LoadIndexFilesThread.getProcessedFiles();
				  if(processedFiles * 100 / totalFiles != 100){
					  LoadDataHandler.setProcessPercentComplete(processedFiles * 100 / totalFiles);
				  }
				  else
					  LoadDataHandler.setProcessPercentComplete(99);
			}
			//CyberoamLogger.appLog.error("going to stop load data handler." + writer.getDirectory()  + "::object:" + this + " writer.obj:" + writer );
			writer.optimize();
			if(IndexWriter.isLocked(INDEX_DIR)){	
				writer.commit();
				writer.close();
			}
			if(mergeDir){
				writer = new IndexWriter(new SimpleFSDirectory(file), analyzer, false, IndexWriter.MaxFieldLength.UNLIMITED);
				writer.setRAMBufferSizeMB(48);		   				
				writer.setUseCompoundFile(false);
				writer.addIndexesNoOptimize(INDEX_DIR);
				writer.optimize();
				writer.close();
				
				if(tempDir != null && tempDir.exists()){
					 File[] tempDirFiles = tempDir.listFiles();
					 for(int temp = 0 ; temp < tempDirFiles.length ; temp++){
						 tempDirFiles[temp].delete();						 
					 }
					 tempDir.delete();
					 
				}
			}
			String fileTimestamp = null;
			if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
				fileTimestamp = "fileeventtimestamp";
			}else{
				fileTimestamp = "filecreationtimestamp";
			}
			String whereCriteria = "where "+fileTimestamp+" between '"+startDate+"' and '"+endDate+"'";
			whereCriteria += deviceCriteria;
			whereCriteria += fileListcriteria;
			CyberoamLogger.appLog.error("where criteria in indexfilesthread: "+whereCriteria);
			FileHandlerBean.updateLoadedindexFileStatusForDateRange(whereCriteria,"tblfilelist"+dateFolder,1);
		}
		catch(Exception e){
			CyberoamLogger.appLog.error("Exception in IndexFilesThread: "+e,e);
			try {
			   writer.close();
			   String[] listFiles = INDEX_DIR.listAll();
			   for(String fileToDel : listFiles){ 
				   INDEX_DIR.deleteFile(fileToDel);
			   }
			 } catch(Exception ei){
				 CyberoamLogger.appLog.error("Exception in IndexFilesThread: "+ei,e);
			 }
		}		
	}
}
