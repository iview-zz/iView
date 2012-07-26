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
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import org.cyberoam.iview.audit.CyberoamLogger;

/**
 * This utility class is used to zip and unzip files. 
 * @author Narendra Shah
 *
 */
public class zipFileUtility{
   static final int BUFFER = 2048;
   
  
   /**
    * This method unzip given source zip file to given destination file.
    */
   public static int unzipFile(String srcFile,String dstFile) {
	  int status=0;
      try {
    	  CyberoamLogger.sysLog.debug(" File to unzip : " + srcFile);
    	 
         BufferedOutputStream dest = null;
         BufferedInputStream is = null;
         ZipEntry entry;
         ZipFile zipfile = new ZipFile(srcFile);
         Enumeration e = zipfile.entries();
         CyberoamLogger.sysLog.debug("Dest File name :" +dstFile  ); 
         File destFileObj=new File(dstFile);
         if(!destFileObj.exists()) destFileObj.mkdirs();
         /**
          * Remove following line
          */
         CyberoamLogger.sysLog.debug("Destination file ?" +destFileObj.exists() ); 
         while(e.hasMoreElements()) {
            entry = (ZipEntry) e.nextElement();
            CyberoamLogger.sysLog.debug("Extracting File : " +entry.getName().substring(entry.getName().lastIndexOf(System.getProperty("file.separator"))+1));
            is = new BufferedInputStream
              (zipfile.getInputStream(entry));
            int count;
            byte data[] = new byte[BUFFER];
            FileOutputStream fos = new 
              FileOutputStream(dstFile +entry.getName().substring(entry.getName().lastIndexOf(System.getProperty("file.separator"))+1));
            dest = new 
              BufferedOutputStream(fos, BUFFER);
            while ((count = is.read(data, 0, BUFFER)) 
              != -1) {
               dest.write(data, 0, count);
            }
            dest.flush();
            dest.close();
            is.close();
         }
         zipfile.close();
         status=1;         
      } catch(Exception e) {
    	 CyberoamLogger.sysLog.error(" Exception while try to unzip File : "+e);
         status=0;
      }
      return status;
   }
   
   /**
    * This method create zip given source file with given destination zip file name.
    */
   public static int zipFile (String srcFile,String dstFile) {
	  int status=0;
      try {
    	 BufferedInputStream origin = null;
         FileOutputStream dest = new FileOutputStream(dstFile);
         ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(dest));
		 byte data[] = new byte[BUFFER];		
		 FileInputStream fi = new FileInputStream(srcFile);
         origin = new BufferedInputStream(fi, BUFFER);
         ZipEntry entry = new ZipEntry(srcFile);
         out.putNextEntry(entry);
         int count;
         while((count = origin.read(data, 0,BUFFER)) != -1) {
        	 out.write(data, 0, count);
         }
         origin.close();
		 out.close();
         status=1;         
      } catch(Exception e) {
    	 CyberoamLogger.sysLog.error(" Exception while try to create zip file : "+e); 
    	 status=0;
      }
      return status;
   }
   
   
   /**
    * This method create zip given multiple source file with given destination zip file name.
    */
   public static int zipFiles(String [] srcFile,String dstFile) {
	  int status=0;
      try {
    	 BufferedInputStream origin = null;
    	 FileInputStream fi=null;
    	 ZipEntry entry=null;
         FileOutputStream dest = new FileOutputStream(dstFile);
         ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(dest));
         byte data[] = new byte[BUFFER];
		 for(int i=0; i < srcFile.length; i++) {
			 fi = new FileInputStream(srcFile[i]);
			 origin = new BufferedInputStream(fi, BUFFER);
			 entry = new ZipEntry(srcFile[i]);
			 out.putNextEntry(entry);
			 int count;
			 while((count = origin.read(data, 0,BUFFER)) != -1) {
				 out.write(data, 0, count);
			 }
			 out.closeEntry();
			 origin.close(); 
			 fi.close();
			 entry=null;
		 }	          
		 out.close();
		 dest.close();
         status++;         
      } catch(Exception e) {
    	 CyberoamLogger.sysLog.error(" Exception while try to create zip file : "+e); 
    	 status=0;
      }
      return status;
   }
   
   
   /**
    * This method add file to zip given with given destination zip file name.
    * jenit shah
    */
 public static  void addFileToZip(String path, String srcFile, ZipOutputStream zip)
    {
	 try{
 File folder = new File(srcFile);
 if (folder.isDirectory()) {
   addFolderToZip(path, srcFile, zip);
 } else {
   byte[] buf = new byte[1024];
   int len;
   FileInputStream in = new FileInputStream(srcFile);
   zip.putNextEntry(new ZipEntry(path + "/" + folder.getName()));
   while ((len = in.read(buf)) > 0) {
     zip.write(buf, 0, len);
   }
   }
  }catch(Exception e){
	  CyberoamLogger.appLog.error(" Exception while try to zip File : "+e);
 } 
}

 /**
  * This method add folder to zip given with given destination zip file name.
  * 
  */
 public static  int addFolderToZip(String path, String srcFolder, ZipOutputStream zip)
    {
	 int returnStatus=1;
	 try{
 File folder = new File(srcFolder);

 for (String fileName : folder.list()) {
   if (path.equals("")) {
     addFileToZip(folder.getName(), srcFolder + "/" + fileName, zip);
   } else {
     addFileToZip(path + "/" + folder.getName(), srcFolder + "/" + fileName, zip);
   }
 }
	 }catch(Exception e){
		 CyberoamLogger.appLog.error(" Exception while try to zip File : "+e);
		 returnStatus=-1;
	 }
	 return returnStatus;
}
 
 public static int unzipFiles(String srcFile,String dstFile) {
	  int status=0;
     try {
   	  CyberoamLogger.sysLog.debug(" File to unzip : " + srcFile);
   	 
        BufferedOutputStream dest = null;
        BufferedInputStream is = null;
        ZipEntry entry;
        ZipFile zipfile = new ZipFile(srcFile);
        Enumeration e = zipfile.entries();
        CyberoamLogger.sysLog.debug("Dest File name :" +dstFile  ); 
        File destFileObj=new File(dstFile);
        if(!destFileObj.exists()) destFileObj.mkdirs();
        /**
         * Remove following line
         */
        CyberoamLogger.sysLog.debug("Destination file ?" +destFileObj.exists() ); 
        while(e.hasMoreElements()) {
           entry = (ZipEntry) e.nextElement();
           CyberoamLogger.sysLog.debug("Extracting File : " +entry.getName().substring(entry.getName().lastIndexOf(System.getProperty("file.separator"))+1));
           File destdirobj=new File(dstFile+"/"+entry.getName().substring(0,entry.getName().lastIndexOf("/")));
           if(!destdirobj.exists()) destdirobj.mkdirs();
           is = new BufferedInputStream
             (zipfile.getInputStream(entry));
           int count;
           byte data[] = new byte[BUFFER];
           FileOutputStream fos = new 
             FileOutputStream(dstFile +"/"+entry.getName());
           
           dest = new 
             BufferedOutputStream(fos, BUFFER);
           while ((count = is.read(data, 0, BUFFER)) 
             != -1) {
              dest.write(data, 0, count);
           }
           dest.flush();
           dest.close();
           is.close();
        }
        zipfile.close();
        status=1;         
     } catch(Exception e) {
   	 CyberoamLogger.sysLog.error(" Exception while try to unzip File : "+e);
        status=0;
     }
     return status;
  }
 public static boolean isValidZipFile(File file) {
	    ZipFile zipfile = null;
	    try {
	        zipfile = new ZipFile(file);
	        return true;
	    } catch (ZipException e) {
	        return false;
	    } catch (IOException e) {
	        return false;
	    } finally {
	        try {
	            if (zipfile != null) {
	                zipfile.close();
	                zipfile = null;
	            }
	        } catch (IOException e) {
	        	CyberoamLogger.appLog.debug("Exception at time to checkvalid zip File"+e);
	        }
	    }
	}   
}
