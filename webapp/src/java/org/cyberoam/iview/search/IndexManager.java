
package org.cyberoam.iview.search;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
//import java.io.RandomAccessFile;
//import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
//import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.NumericField;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.NumericRangeQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.search.WildcardQuery;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.SimpleFSDirectory;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.search.TopFieldDocs;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.Field.Index;
//import org.apache.lucene.index.IndexDeletionPolicy;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.util.Version;

import com.mockrunner.mock.jdbc.MockResultSet;

import org.cyberoam.iview.beans.IndexDataFieldsBean;
import org.cyberoam.iview.beans.SearchIndexBean;
//import org.cyberoam.iview.device.beans.DeviceTypeBean;
import org.cyberoam.iview.audit.CyberoamLogger;
//import org.cyberoam.iview.authentication.beans.DeviceBean;
import org.cyberoam.iview.utility.IViewPropertyReader;
//import org.cyberoam.iview.utility.PrepareQuery;
import org.cyberoam.iview.utility.zipFileUtility;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;



/***
 * This class represents creating index and search data from index
 * @author Hemant Agrawal
 *
 */


/*This class use for storing IndexWriter and Directory object 
 * it has set and get method for getting and setting object
 * 
 */
class IndexWriterDirectoryStorage {
	
	private IndexWriter writer = null;
	private Directory INDEX_DIR = null;	
	
	IndexWriterDirectoryStorage(IndexWriter writer ,Directory INDEX_DIR){
		this.writer=(IndexWriter)writer;
		this.INDEX_DIR=(Directory)INDEX_DIR;
	}		
	public void setIndexWriter(IndexWriter writer){
		this.writer=(IndexWriter)writer;
	}
	public IndexWriter getIndexWriter(){
		return this.writer;
	}
	public void setDirectory(Directory INDEX_DIR){
		this.INDEX_DIR=(Directory)INDEX_DIR;
	}
	public Directory getDirectory(){
		return this.INDEX_DIR;
	}
}

/* This class is main class and call from index creation device wise thread 
 * 
 */

public class IndexManager{

	private IndexWriterDirectoryStorage indexwriterObject;
	private  TreeMap<String,IndexWriterDirectoryStorage> writerDocumentMap=null;
	String [] fileMap=new String[Integer.parseInt(IndexSearchBean.getValueByKey("filecount"))];
	private long hitsSize;
	
	/*
	 * This method use for getting folder size 
	 * 
	 */
	
	public long getFileSize(File folder) {
		
		long foldersize = 0;		

		File[] filelist = folder.listFiles();
		for (int i = 0; i < filelist.length; i++) {
			if (filelist[i].isDirectory()) {
				foldersize += getFileSize(filelist[i]);
			} else {	  
				foldersize += filelist[i].length();
			}
		}
		return foldersize;
	}
	
	/*
	 * This method use for delete temporary directory 
	 * 
	 */
	
	public  void deleteTempDir(File tempDir){		
		if(tempDir != null && tempDir.exists()){
			File[] tempDirFiles = tempDir.listFiles();
			for(int temp = 0 ; temp < tempDirFiles.length ; temp++){				
				if(tempDirFiles[temp].isDirectory()){
					deleteTempDir(tempDirFiles[temp].getAbsoluteFile());
				}
				tempDirFiles[temp].delete();						 
			}
			tempDir.delete();			
		}
	}
	
	/*
	 * This method moving file from rotated folder to cold or delete files or bad folder depends on user because it is configurable 
	 */
	
	public  boolean movingFile(String deviceFolder,String filePath,int flag){
		
		switch(flag){
		
		case 0:
			try{				
				return new File(filePath).delete();				
			}catch (Exception e) {
				e.printStackTrace();				
				return false;
			}		
		case 1:
			try{
				File folder=new File(deviceFolder);
				if(!folder.exists()){
					folder.mkdirs();
				}
				String filenm=(filePath.split("rotated")[1]).replace("/","")+".zip";
				if(zipFileUtility.zipFile(filePath,deviceFolder+"/"+filenm)==1){					
					return new File(filePath).delete();
				}	
				else 
					return false;
				
			}catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		case 2:
			try{
				File folder=new File(deviceFolder);
				if(!folder.exists()){
					folder.mkdir();
				}
				String filenm=(filePath.split("rotated")[1]).replace("/","");								
				return (new File(filePath).renameTo(new File(folder,filenm)));				
			}catch (Exception e) {
				e.printStackTrace();
				return false;
			}			
		}
		return true;
	}
	
	/*
	 * This method use for creating chunk folder because chunk folder size is configurable so it creates on runtime
	 * chunk folder name is combination of time and 1
	 */
	
	public  void createChunkFolder(String deviceFolder,String folderDate,String module,String tempIndexFile){
		
		SimpleDateFormat formatter= new SimpleDateFormat("HHmmss");			
		String chunkName=formatter.format(Calendar.getInstance().getTime())+"_1";
		String dst=deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/"+folderDate+"/"+module+"/"+chunkName;
		String src=deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/"+tempIndexFile+"/"+module;								
		File indexFolder=new File(dst);
		if(!indexFolder.exists()){
			if(!indexFolder.mkdirs()){
				CyberoamLogger.repLog.error("date folder can't create and return from indexmanager");				
			}					
		}
		String tempIndexFileList[] =new File(src).list();						
		for(int j=0 ; j<tempIndexFileList.length ; j++){
			new File(src,tempIndexFileList[j]).renameTo(new File(dst,tempIndexFileList[j]));
		}
		deleteTempDir(new File(src));
	}
	
	public String [][] getFields(String indexFile){		
		ArrayList<IndexDataFieldsBean> indexFileList = IndexDataFieldsBean.getIndexDataFieldBeanListByIndexFile(indexFile);
		String[][] fields = new String[indexFileList.size()][2];
		IndexDataFieldsBean indexDataFieldsBean = null;
		for(int index=0 ; index < indexFileList.size() ; index++){
			  indexDataFieldsBean = (IndexDataFieldsBean)indexFileList.get(index);
			  fields[index][0] = indexDataFieldsBean.getIndexName();
			  fields[index][1] = indexDataFieldsBean.getDataType();			  
		}
		return fields;
	}
	
	
	/*
	 * This method is using for close all object which is use in creating index
	 */
	
	public void closeFiles(FileInputStream fstream,DataInputStream dataInputStream,BufferedReader bufferedReader ,Document document){
		try{
			bufferedReader.close();
			dataInputStream.close();					
			fstream.close();
			bufferedReader = null;
			dataInputStream = null;
			fstream = null;
			document=null;
		}catch (Exception e) {
			e.printStackTrace();			
		}		
	}
	
	/*
	 * This method use for writing index from file to lucene index
	 * here we create temporary date wise index and read from file and create index according to date wise temporary folder
	 * it take date from record and write in lucene index in temporary date wise folder
	 */
	
	public  void writeIndex(String path,String deviceFolder,int indexRotation){
		
		IndexWriter writer = null;
		Directory INDEX_DIR = null;
		FileInputStream fstream = null;
		DataInputStream dataInputStream = null;
		BufferedReader bufferedReader = null;					
		String line = null;
		String keyDate=null;
		String module=null;
		String [][] fields=null;
		String [] stringTokenizer = null;		
		Document document=null;
		String longDate=null;
		int fileIndex=0;		
		
		StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT);
		Index index = Field.Index.NOT_ANALYZED_NO_NORMS;
		
		String[] filesList=new File(path).list();		
		for(fileIndex=0; fileIndex<filesList.length && fileIndex<Integer.parseInt(IndexSearchBean.getValueByKey("filecount")) ; fileIndex++)	{
			try{				
				fstream = new FileInputStream(path+filesList[fileIndex]);					  			
				dataInputStream = new DataInputStream(fstream);
				bufferedReader = new BufferedReader(new InputStreamReader(dataInputStream));				
				document = new Document();	
				fields=null;
				module=filesList[fileIndex].split("_")[0];
				fields=getFields(module);
				for(int fieldIndex=0 ; fieldIndex<fields.length ;fieldIndex++){							  					
					 if(fields[fieldIndex][1].equalsIgnoreCase("1")){
						 document.add(new NumericField(fields[fieldIndex][0],Field.Store.YES, Boolean.parseBoolean("true")).setLongValue(new Long("0")));					 
					  }else {							 
						 document.add(new Field(fields[fieldIndex][0],"", Field.Store.YES, index));
					  }  						
				}	
				
				// read from file line by line
				while(null != (line = bufferedReader.readLine()))	{	
					line=line.trim();
					if((line.equalsIgnoreCase("")) || (line.equalsIgnoreCase(" "))){
						continue;
					}
						stringTokenizer = line.split("\t");					  									
						for(int fieldIndex=0 ; fieldIndex<fields.length ;fieldIndex++){
							if(fields[fieldIndex][1].equalsIgnoreCase("1"))	{
								if(fieldIndex==0){
									longDate=stringTokenizer[fieldIndex];
									longDate=longDate.replace(" ","");
									longDate=longDate.replace("-","");
									longDate=longDate.replace(":","");								 
								 	((NumericField)document.getFieldable(fields[fieldIndex][0])).setLongValue(new Long(longDate));
								 }else{									 
									((NumericField)document.getFieldable(fields[fieldIndex][0])).setLongValue(new Long(stringTokenizer[fieldIndex]));
								 }
							}else {
								document.getField(fields[fieldIndex][0]).setValue(stringTokenizer[fieldIndex]);
							}															   							 
						}
						// create index of record which read from file
						
						keyDate=longDate.substring(0, 8);
						indexwriterObject=writerDocumentMap.get(keyDate+module);						
						try{
							if(indexwriterObject ==null  ){								
								INDEX_DIR=new SimpleFSDirectory(new File(deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/"+"temp"+keyDate+"/"+module));
								writer = new IndexWriter(INDEX_DIR, analyzer, true, IndexWriter.MaxFieldLength.UNLIMITED);								
								//writer.setRAMBufferSizeMB(48);		   
								writer.setUseCompoundFile(false);
								writer.addDocument(document);
								indexwriterObject=new IndexWriterDirectoryStorage(writer, INDEX_DIR);
								writerDocumentMap.put(keyDate+module, indexwriterObject);								
							}else{
								writer =(IndexWriter)indexwriterObject.getIndexWriter();
								writer.addDocument(document);
							}
						}catch(Exception e){						
							CyberoamLogger.repLog.error("create  inded in 1  :"+e,e);
							 writer.optimize();
							 INDEX_DIR=(Directory)indexwriterObject.getDirectory();
							if(IndexWriter.isLocked(INDEX_DIR)){
								writer.commit();							
							}
						}
				}// End of While Loop		
				CyberoamLogger.repLog.error("1 st try block fiel: "+path+filesList[fileIndex]);
				closeFiles(fstream,dataInputStream,bufferedReader ,document);	
				fileMap[fileIndex]=(path+filesList[fileIndex]);
				/*if(!movingFile(deviceFolder+IndexSearchBean.getValueByKey("cold")+"/"+keyDate,path+filesList[fileIndex],indexRotation)){
					  if(!new File(path+filesList[fileIndex]).delete()){
						  CyberoamLogger.repLog.error("file not moved as well as not deleted");
					  }else{
						  CyberoamLogger.repLog.error("File not moved but deleted successfully");
					  }
				  }else{
					  CyberoamLogger.repLog.error("succesfully files move");
				  }*/
			/*
			 * if any exception come during the create index of file , we try another time to create index of same file in catch block	
			 */
			}catch (Exception e) {
								
				CyberoamLogger.repLog.error("errr after scnd try  :"+e,e);				
				  try{
					  	closeFiles(fstream,dataInputStream,bufferedReader ,document);
						fstream = new FileInputStream(path+filesList[fileIndex]);					  						  
						dataInputStream = new DataInputStream(fstream);
						bufferedReader = new BufferedReader(new InputStreamReader(dataInputStream));						
						document = new Document();		
						fields=null;
						module=filesList[fileIndex].split("_")[0];
						fields=getFields(module);
						for(int fieldList=0 ; fieldList<fields.length ;fieldList++){							  					
							 if(fields[fieldList][1].equalsIgnoreCase("1")){
								 document.add(new NumericField(fields[fieldList][0],Field.Store.YES, Boolean.parseBoolean("true")).setLongValue(new Long("0")));					 
							  }else {							 
								  document.add(new Field(fields[fieldList][0],"", Field.Store.YES, index));
							  }  						
						}						  				
						while(null != (line = bufferedReader.readLine()))	{
							line=line.trim();
							if((line.equalsIgnoreCase("")) || (line.equalsIgnoreCase(" "))){
								continue;
							}
								stringTokenizer = line.split("\t");					  									
								for(int fieldList=0 ; fieldList<fields.length ;fieldList++){
									if(fields[fieldList][1].equalsIgnoreCase("1")){
										if(fieldList==0){
											longDate=(stringTokenizer[fieldList]);
											longDate=longDate.replace(" ","");
											longDate=longDate.replace("-","");
											longDate=longDate.replace(":","");								 
										 	((NumericField)document.getFieldable(fields[fieldList][0])).setLongValue(new Long(longDate));
										 }else{									 
											((NumericField)document.getFieldable(fields[fieldList][0])).setLongValue(new Long(stringTokenizer[fieldList]));
										 }
									}else {
										document.getField(fields[fieldList][0]).setValue(stringTokenizer[fieldList]);
									}															   							 
								}
								keyDate=longDate.substring(0, 8);
								indexwriterObject=writerDocumentMap.get(keyDate+module);						
								try{
									if(indexwriterObject ==null){										
										INDEX_DIR=new SimpleFSDirectory(new File(deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/"+"temp"+keyDate+"/"+module));
										writer = new IndexWriter(INDEX_DIR, analyzer, true, IndexWriter.MaxFieldLength.UNLIMITED);								
										//writer.setRAMBufferSizeMB(48);		   
										writer.setUseCompoundFile(false);
										writer.addDocument(document);
										indexwriterObject=new IndexWriterDirectoryStorage(writer, INDEX_DIR);
										writerDocumentMap.put(keyDate+module, indexwriterObject);		
										CyberoamLogger.repLog.error("index writer : "+writer);
										CyberoamLogger.repLog.error("index dir : "+INDEX_DIR);
									}else{
										writer =(IndexWriter)indexwriterObject.getIndexWriter();
										writer.addDocument(document);
										CyberoamLogger.repLog.error("index writer : "+writer);
										CyberoamLogger.repLog.error("fiel: "+path+filesList[fileIndex]);
									}
								}catch(Exception e1){						
									CyberoamLogger.repLog.error("create  inded in 2:"+e1,e1);
									 writer.optimize();
									 INDEX_DIR=(Directory)indexwriterObject.getDirectory();
									if(IndexWriter.isLocked(INDEX_DIR)){
										writer.commit();							
									}
								}
						}
						closeFiles(fstream,dataInputStream,bufferedReader ,document);
						fileMap[fileIndex]=(path+filesList[fileIndex]);
						CyberoamLogger.repLog.error("2 st try block fiel: "+path+filesList[fileIndex]);
						/*if(!movingFile(deviceFolder+IndexSearchBean.getValueByKey("cold")+"/"+keyDate,path+filesList[fileIndex],indexRotation)){
							  if(!new File(path+filesList[fileIndex]).delete()){
								  CyberoamLogger.repLog.error("file not moved as well as not deleted");
							  }
						  }
						*/
						
					}catch (Exception ee) {
						/*
						 * if exception come during the creating index of second time , we move this file in bad folder,
						 * if we face exception during the moving file to bad folder then we delete this file. 
						 */
						
						try{								
							CyberoamLogger.repLog.error("errr after scnd try  :"+ee,ee);
							closeFiles(fstream,dataInputStream,bufferedReader ,document);							
							if(!movingFile(deviceFolder+"bad",path+filesList[fileIndex],2)){
							  if(!new File(path+filesList[fileIndex]).delete()){
								  CyberoamLogger.repLog.error("file not moved as well as not deleted folder= "+filesList[fileIndex]+"path: "+path+" error : "+ee,ee);
							  }else CyberoamLogger.repLog.error("Bad File can't move in bad folder but "+filesList[fileIndex]+" is deleted error :"+ee,ee);								  
							}else CyberoamLogger.repLog.error("files moved in bad folder= "+filesList[fileIndex]+"path: "+path+" error : "+ee,ee);
							continue;
						}catch(Exception e1){
							CyberoamLogger.repLog.error("Abc",e1);
							continue;
						}	
					}
			}//End of Main Try Catch Block			
		} // End of FOR Loop for FILE
	
	} //End of Method
	
	/*
	 * This method is call from thread and create index 
	 * 
	 */
	
	@SuppressWarnings("deprecation")
	public  void createIndex(String path,long chunksize,int categoryID){
		IndexWriter writer = null;
		Directory INDEX_DIR = null;	
		String indexPath=null;
		String deviceFolder=null;
		String [] tempIndexList=null;
		String [] moduleList=null;
		File indexFolder=null;		
		StandardAnalyzer analyzer = null;						
		int indexRotation=0;
		int kIndex=0,index=0,moduleIndex=0;
		writerDocumentMap = new TreeMap<String,IndexWriterDirectoryStorage>();
		try	{				
			try{
				
				indexRotation=Integer.parseInt(IndexSearchBean.getValueByKey("indexrotation"));				
			}catch(NumberFormatException  e){
				CyberoamLogger.repLog.error("NumberFormatException in changing time from string to integer : " + e,e);				
				e.printStackTrace();
			}
			deviceFolder=path.split("hot")[0];			
			indexPath=deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/";
			indexFolder=new File(indexPath);
			if(!indexFolder.exists()){
				if(!indexFolder.mkdirs()){
					CyberoamLogger.repLog.error("index info folder can't create due to some problem");
					return;
				}
			}
			String templist[]=new File(deviceFolder+IndexSearchBean.getValueByKey("indexinfo")).list();
			for(index=0 ; index<templist.length ; index++){
				if(templist[index].startsWith("temp")){
					try{
					deleteTempDir(new File(indexPath+templist[index]));
					}catch(Exception et){
						et.printStackTrace();
						CyberoamLogger.repLog.error("deletion error :"+et);
					}
				}
			}
			
			
			
			writeIndex(path, deviceFolder,indexRotation);
			
			/*
			 * This part is append index from temporary date wise index into date wise main index and finally temporary directory delete.
			 */
			
			tempIndexList=new File(deviceFolder+IndexSearchBean.getValueByKey("indexinfo")).list();
			
			for( index=0 ; index<tempIndexList.length ; index++){
				
				if(tempIndexList[index].startsWith("temp")){
					
					String folderDate=tempIndexList[index].split("temp")[1];
					moduleList=new File(deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/"+tempIndexList[index]).list();
					for(moduleIndex=0 ; moduleIndex<moduleList.length ; moduleIndex++){
											
						File dateFolder=new File(deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/"+folderDate+"/"+moduleList[moduleIndex]);
					
						int flag=0;
					
						if(dateFolder.exists()){
						
							File[] fileList=dateFolder.listFiles();	
						
							for( kIndex=0 ; kIndex<fileList.length ; kIndex++){
							
								if(getFileSize(fileList[kIndex])<(chunksize*1024*1024)){		
									flag=1;
									break;
								}
							}						
							if(flag==0){
								writer=(IndexWriter)(writerDocumentMap.get(folderDate+moduleList[moduleIndex])).getIndexWriter();
								INDEX_DIR=(Directory)(writerDocumentMap.get(folderDate+moduleList[moduleIndex])).getDirectory();
								try{
									writer.optimize();
									if(IndexWriter.isLocked(INDEX_DIR)){
										writer.commit();
										writer.close();
										INDEX_DIR.close();
										writerDocumentMap.remove(folderDate+moduleList[moduleIndex]);									
									}	
								}catch(Exception indexerror){
									indexerror.printStackTrace();
									try {
										writer.close();									
										/*String[] listFiles = INDEX_DIR.listAll();
										for(String fileToDel : listFiles){ 
											INDEX_DIR.deleteFile(fileToDel);
										}*/
										INDEX_DIR.close();	
										writerDocumentMap.remove(folderDate+moduleList[moduleIndex]);									
									}catch(Exception ei){
										ei.printStackTrace();
										try{
											INDEX_DIR.close();										
										}catch(Exception e1){
											e1.printStackTrace();
										}									
									}
								}
								createChunkFolder(deviceFolder,folderDate,moduleList[moduleIndex],tempIndexList[index]);
								
								}
								//Logic for appending the temp folder to chunk folder
								else if(flag==1){
									indexFolder=null;
									indexFolder=new File(deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/"+folderDate+"/"+moduleList[moduleIndex]+"/"+fileList[kIndex].getName());
									writer=(IndexWriter)(writerDocumentMap.get(folderDate+moduleList[moduleIndex])).getIndexWriter();
									INDEX_DIR=(Directory)(writerDocumentMap.get(folderDate+moduleList[moduleIndex])).getDirectory();
									try{
										writer.optimize();
										if(IndexWriter.isLocked(INDEX_DIR)){
											writer.commit();
											writer.close();									
										}	
										writer = new IndexWriter(new SimpleFSDirectory(indexFolder), analyzer, false, IndexWriter.MaxFieldLength.UNLIMITED);
										//writer.setRAMBufferSizeMB(48);		   				
										writer.setUseCompoundFile(false);
										writer.addIndexesNoOptimize(INDEX_DIR);
										writer.optimize();
										writer.close();	
										INDEX_DIR.close();	
										writerDocumentMap.remove(folderDate+moduleList[moduleIndex]);
										deleteTempDir(new File(deviceFolder+IndexSearchBean.getValueByKey("indexinfo")+"/"+tempIndexList[index]));
									}catch(Exception indexerror){
										indexerror.printStackTrace();
										try {
											CyberoamLogger.repLog.error("merger error : "+indexerror);
											writer.close();									
											/*String[] listFiles = INDEX_DIR.listAll();
											for(String fileToDel : listFiles){ 
												INDEX_DIR.deleteFile(fileToDel);
											}*/
											INDEX_DIR.close();
										}catch(Exception ei){
											ei.printStackTrace();
											try{
												INDEX_DIR.close();										
											}catch(Exception e1){
												e1.printStackTrace();
												
											}									
										}
									}
								}						
							}else{
								writer=(IndexWriter)(writerDocumentMap.get(folderDate+moduleList[moduleIndex])).getIndexWriter();
								INDEX_DIR=(Directory)(writerDocumentMap.get(folderDate+moduleList[moduleIndex])).getDirectory();						
								writer.optimize();
								if(IndexWriter.isLocked(INDEX_DIR)){
									writer.commit();
									writer.close();
									INDEX_DIR.close();
									writerDocumentMap.remove(folderDate+moduleList[moduleIndex]);						
								}	
								createChunkFolder(deviceFolder,folderDate,moduleList[moduleIndex],tempIndexList[index]);
							}
					}//end second for loop	
				}//end if condition		
			}//end main for loop				
			SimpleDateFormat formatter= new SimpleDateFormat("yyyyMMdd");
			String dateNow = formatter.format(new Date());
			for(index=0  ; index<fileMap.length ;  index++){
				if(!movingFile(deviceFolder+IndexSearchBean.getValueByKey("cold")+"/"+dateNow ,fileMap[index],indexRotation)){
				  if(!new File(fileMap[index]).delete()){
					  CyberoamLogger.repLog.error("file not moved as well as not deleted");
				  }
			  }							
			}			
		}catch(Exception e){
			e.printStackTrace();
		
		}		
	}
	
	public long getTotalHits(){
		return hitsSize;
	}
	
	public  ResultSetWrapper getSearch(String reportQuery){
		
		Directory INDEX_DIR = null;		
		IndexSearcher searcher = null;
		TopScoreDocCollector collector = null;
		TermQuery termQry = null;
		Query query=null;
		BooleanClause.Occur occur =null;	
		MockResultSet mockResultSet=null;	
		ResultSetWrapper rsw=null;
		TreeMap<String,String> fieldDatatype=null;
		hitsSize=0;
		int hitsPerPage=0;
		int offset=0;
		int index=0;
		int appIndex=0;
		int condIndex=1;
		int flag=0;
		int startdate = 0;		
		int enddate = 0;
		String[][] fields=null;		
		String [] searchCriteria=null;
		String[] criteriaArr=null;
		String appidList[]=null;
		String condVal = "";
		String appid=null;
		String module=null;
		String sortField=null;
		ArrayList<Object> searchData = new ArrayList<Object>();
		try{
			
			if(reportQuery==null){
				return rsw ;				
			}
			
			fieldDatatype=new TreeMap<String,String>();
			searchCriteria=reportQuery.split("#@!");
			for(index=0 ; index<searchCriteria.length ; index++){
				if((searchCriteria[index].split(" ")[0]).indexOf("appid")>-1){
					appid=searchCriteria[index].split(" ")[2];
					appid=(appid.replace("'", "")).trim();
					appidList=appid.split(",");
					//categoryID=""+DeviceBean.deviceCategoryMap.get(appid);					
				}else if((searchCriteria[index].split(" ")[0]).indexOf("time")>-1){
					if(flag==0){
						flag=1;
						startdate=Integer.parseInt(((searchCriteria[index].split(" ")[2]).split(" ")[0]).replace("-",""));
					}else{
						enddate=Integer.parseInt(((searchCriteria[index].split(" ")[2]).split(" ")[0]).replace("-",""));
					}
				}else if((searchCriteria[index].split(" ")[0]).indexOf("module")>-1){
					module=searchCriteria[index].split(" ")[2];
					module=(module.replace("'", "")).trim();
				}
			}
			fields=getFields(module);						
			for( index=0 ; index < fields.length ; index++){				  				  
				  fieldDatatype.put(fields[index][0],fields[index][1]);
			}
			
			//StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT);
			query = new BooleanQuery();
			
			occur = BooleanClause.Occur.MUST;
			for(index=0 ; index<searchCriteria.length ; index++){
				
				if(searchCriteria[index].indexOf("AND")>-1 ){
					occur = BooleanClause.Occur.MUST;
				}else if(searchCriteria[index].indexOf("OR")>-1 ){
					occur = BooleanClause.Occur.SHOULD;
				}else if(searchCriteria[index].indexOf("limit")>-1){
					hitsPerPage=Integer.parseInt(""+searchCriteria[index].split(" ")[2]);
				}else if(searchCriteria[index].indexOf("offset")>-1){
					offset=Integer.parseInt(""+searchCriteria[index].split(" ")[2]);
				}else if(searchCriteria[index].indexOf("orderby")>-1){
					sortField=searchCriteria[index].split(" ")[2].toString();
				}else if((searchCriteria[index].split(" ")[0]).indexOf("appid")>-1){
				
				}else if((searchCriteria[index].split(" ")[0]).indexOf("module")>-1){
					
				}else{
						criteriaArr=null;
						criteriaArr = searchCriteria[index].trim().split(" ");
						if(criteriaArr.length<3){
							continue;
							/*criteriaArr =null;
							searchCriteria[index]+="*";
							criteriaArr = searchCriteria[index].split(" ");*/						
						}
						
						if(!(criteriaArr[0].trim()).equalsIgnoreCase("time")){
							for(int criteriaIndex=3;criteriaIndex<criteriaArr.length;criteriaIndex++)
							{
								criteriaArr[2]=criteriaArr[2].trim()+" "+criteriaArr[criteriaIndex].trim();
							}
						}	
						if((criteriaArr[condIndex].trim()).equalsIgnoreCase("=")){
							
							if(fieldDatatype.get(criteriaArr[0].trim()).equals("1")){
								condVal=criteriaArr[2];
								if((criteriaArr[0].trim()).equalsIgnoreCase("time")){
									condVal+=criteriaArr[3];
									condVal=condVal.replace(" ","");
									condVal=condVal.replace("-","");
									condVal=condVal.replace(":","");
								}	
								Query numericQry = NumericRangeQuery.newLongRange((criteriaArr[0].trim()),new Long(condVal),new Long(condVal),true,true);
								((BooleanQuery)query).add(numericQry, occur);
							}else{
								
								termQry = new TermQuery(new Term((criteriaArr[0].trim()),criteriaArr[2].trim()));
								((BooleanQuery)query).add(termQry, occur);
							}
							
						}else if((criteriaArr[condIndex].trim()).equalsIgnoreCase("!=")){
							
							if(fieldDatatype.get(criteriaArr[0].trim()).equals("1")){
								condVal=criteriaArr[2];
								if((criteriaArr[0].trim()).equalsIgnoreCase("time")){
									condVal+=criteriaArr[3];
									condVal=condVal.replace(" ","");
									condVal=condVal.replace("-","");
									condVal=condVal.replace(":","");
								}	
								Query numericQry = NumericRangeQuery.newLongRange((criteriaArr[0].trim()),new Long(condVal),new Long(condVal),true,true);
								((BooleanQuery)query).add(numericQry, BooleanClause.Occur.MUST_NOT);
							}else{
								
								termQry = new TermQuery(new Term((criteriaArr[0].trim()),criteriaArr[2].trim()));
								((BooleanQuery)query).add(termQry,  BooleanClause.Occur.MUST_NOT);
							}
							
						}else if((criteriaArr[condIndex].trim()).equalsIgnoreCase(">=")){
							
							if(fieldDatatype.get(criteriaArr[0].trim()).equals("1")){
								condVal=criteriaArr[2];
								if((criteriaArr[0].trim()).equalsIgnoreCase("time")){
									condVal+=criteriaArr[3];
									condVal=condVal.replace(" ","");
									condVal=condVal.replace("-","");
									condVal=condVal.replace(":","");
								}	
								Query numericQry = NumericRangeQuery.newLongRange((criteriaArr[0].trim()),new Long(condVal),null,true,true);
								((BooleanQuery)query).add(numericQry, occur);
							}else{
								
								termQry = new TermQuery(new Term((criteriaArr[0].trim()),criteriaArr[2].trim()));
								((BooleanQuery)query).add(termQry, occur);
							}
							
						}else if((criteriaArr[condIndex].trim()).equalsIgnoreCase("<=")){
							
							if(fieldDatatype.get(criteriaArr[0].trim()).equals("1")){
								condVal=criteriaArr[2];
								if((criteriaArr[0].trim()).equalsIgnoreCase("time")){
									condVal+=criteriaArr[3];
									condVal=condVal.replace(" ","");
									condVal=condVal.replace("-","");
									condVal=condVal.replace(":","");
								}	
								Query numericQry = NumericRangeQuery.newLongRange((criteriaArr[0].trim()),null,new Long(condVal),true,true);
								((BooleanQuery)query).add(numericQry, occur);
							}else{
								
								termQry = new TermQuery(new Term((criteriaArr[0].trim()),criteriaArr[2].trim()));
								((BooleanQuery)query).add(termQry, occur);
							}
							
						}else if((criteriaArr[condIndex].trim()).equalsIgnoreCase(">")){
							
							if(fieldDatatype.get(criteriaArr[0].trim()).equals("1")){
								condVal=criteriaArr[2];
								if((criteriaArr[0].trim()).equalsIgnoreCase("time")){	
									condVal+=criteriaArr[3];
									condVal=condVal.replace(" ","");
									condVal=condVal.replace("-","");
									condVal=condVal.replace(":","");
								}	
								Query numericQry = NumericRangeQuery.newLongRange((criteriaArr[0].trim()),new Long(condVal),null,false,true);
								((BooleanQuery)query).add(numericQry, occur);
							}else{
								
								termQry = new TermQuery(new Term((criteriaArr[0].trim()),criteriaArr[2].trim()));
								((BooleanQuery)query).add(termQry, occur);
							}
							
						}else if((criteriaArr[condIndex].trim()).equalsIgnoreCase("<")){
							
							if(fieldDatatype.get(criteriaArr[0].trim()).equals("1")){
								condVal=criteriaArr[2];
								if((criteriaArr[0].trim()).equalsIgnoreCase("time")){
									condVal+=criteriaArr[3];
									condVal=condVal.replace(" ","");
									condVal=condVal.replace("-","");
									condVal=condVal.replace(":","");
								}	
								Query numericQry = NumericRangeQuery.newLongRange((criteriaArr[0].trim()),null,new Long(condVal),true,false);
								((BooleanQuery)query).add(numericQry, occur);
							}else{
								
								termQry = new TermQuery(new Term((criteriaArr[0].trim()),criteriaArr[2].trim()));
								((BooleanQuery)query).add(termQry, occur);
							}
							
							
						}else if((criteriaArr[condIndex].trim()).equalsIgnoreCase("like")){
							//criteriaArr[2]=criteriaArr[2].toLowerCase();
							CyberoamLogger.repLog.error("arry : "+criteriaArr[2]);
							String tempcond="*"+criteriaArr[2].trim()+"*";							
							WildcardQuery widlscardQry = new WildcardQuery(new Term((criteriaArr[0].trim()),tempcond.replace("%", "*")));
							((BooleanQuery)query).add(widlscardQry, occur);
						}
				}
			}
			
			if(startdate>enddate){
				int temp=enddate;
				enddate=startdate;
				startdate=temp;
			}
			CyberoamLogger.repLog.error("indexmanager : "+query);
			hitsSize=0;
			
			for(appIndex=0 ; appIndex<appidList.length ; appIndex++){
				appid=appidList[appIndex];
				for(index=startdate ; index <= enddate ; index++){
					File indexFile=new File(IViewPropertyReader.IndexDIR+appid+"/"+IndexSearchBean.getValueByKey("indexinfo")+"/"+index+"/"+module);
					if(!indexFile.exists()){
						continue;
					}					
					String[] timeIntervals = indexFile.list();
					for(int k=0 ; k < timeIntervals.length ; k++){
										
						INDEX_DIR = new SimpleFSDirectory(new File(IViewPropertyReader.IndexDIR+appid+"/"+IndexSearchBean.getValueByKey("indexinfo")+"/"+index+"/"+"/"+module+"/"+timeIntervals[k]));
						searcher = new IndexSearcher(INDEX_DIR, true);
						
						Sort sort = new Sort (new SortField ( sortField, SortField.LONG, false));  
				
						//collector = TopScoreDocCollector.create(10000, true);
						TopFieldDocs topFieldDocs=searcher.search(query, null,100000,sort);
						//ScoreDoc[] hits = collector.topDocs().scoreDocs;
						ScoreDoc[] hits=topFieldDocs.scoreDocs;						
						ArrayList<String> record = null;						 
						hitsSize+=hits.length ;
						 
						/*j=offset;
						if(j>hits.length && hits.length>0){
				    	 		if(j-hits.length >hitsPerPage){
				    	 			j=hits.length-hitsPerPage;
				    	 		}else{
				    	 			j=j-hits.length;
				    	 		}
				    	}	*/
					     //for( ; j < offset+hitsPerPage && j<hitsSize; j++) {
						int j=(int) (offset-(hitsSize-hits.length));
						for(; j < offset+hitsPerPage && j<hitsSize && offset<hitsSize; j++,offset++) {
								
					    	 	if(searchData.size() > hitsPerPage-1 )
					    	 		break;
					    	 
					    	 	
						    	 record = new ArrayList<String>();
						    	 int docId = hits[j].doc;
							      Document doc = searcher.doc(docId);
							      for(int filedIndex=0 ; filedIndex < fields.length  ; filedIndex++){
							    	  if(filedIndex==0){
							    		  String dt=""+doc.get(fields[filedIndex][0]);
							    		  record.add(dt.substring(0,4)+"-"+dt.substring(4,6)+"-"+dt.substring(6,8)+" "+dt.substring(8,10)+":"+dt.substring(10,12)+":"+dt.substring(12,14));
							    	  }else{
							    		  record.add(doc.get(fields[filedIndex][0]));
							    	  }
							      }						      			   				  
							      //record.add("-");
							      searchData.add(record);
							      
							    	  
					    }				    	
					    searcher.close();
					    INDEX_DIR.close();
					    /*if(searchData.size() > hitsPerPage + 1)
					    	  break;
					    	*/
						//storeSearchRecord(hits,offset,hitsPerPage,searcher,fields);
					}
					/*if(searchData.size() > hitsPerPage + 1)
				    	  break;*/
				}	
				/*if(searchData.size() > hitsPerPage + 1)
			    	  break;*/
			}	
			mockResultSet = new MockResultSet("hemantResultSet");
			for(int filedIndex=0 ; filedIndex < fields.length ; filedIndex++){
				 mockResultSet.addColumn(fields[filedIndex][0]);
		    }			
			int lt=searchData.size();
			String [] str=null;		
			List<Object> objects =null;
			for (int i=0; i<lt ; i++) {
				objects = new ArrayList<Object>();
				str=searchData.get(i).toString().split(",");
				for(int j=0 ; j<str.length ; j++){
					str[j]=str[j].replace("]", "");
					objects.add(str[j].replace("[",""));
				}										            			
				mockResultSet.addRow(objects);			
			}
			
			rsw=new ResultSetWrapper(mockResultSet);
			return rsw;
		}catch(Exception e){
			e.printStackTrace();
			CyberoamLogger.repLog.error("merger error : "+e);
			return rsw;
		}
								
	}		
	
/*	public ResultSetWrapper getResutSetFromArrayList(ArrayList searchData){
		
		try{
			MockResultSet mockResultSet = new MockResultSet("hemantResultSet");
			mockResultSet.addColumn("url");
			mockResultSet.addColumn("dates");
			mockResultSet.addColumn("bytes");
			int lt=searchData.size();
			String [] str=null;		
			List<Object> objects =null;
			for (int i=0; i<lt ; i++) {
				objects = new ArrayList<Object>();
				str=record.get(i).toString().split(",");
				objects.add(str[8]);
				objects.add(str[0]);
				objects.add(Long.parseLong(str[6].trim()));	            				
				mockResultSet.addRow(objects);			
			}
			
			rsw=new ResultSetWrapper(mockResultSet);
		}catch (Exception e) {
			e.printStackTrace();
			CyberoamLogger.repLog.error("merger error : "+e);
		}
		
	}*/
}