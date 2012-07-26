package org.cyberoam.iview.utility;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPConnectionClosedException;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.commons.net.io.CopyStreamException;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.audit.CyberoamLogger;

 /**This class is useful to login to FTP server and store files and retrieve files from ftp.
  * @author  Jenit Shah
  */
public class FTPFileManager
{
	   private String username=null;
	   private String password=null;
	   private String serverip=null;
	   public  FTPClient ftp; 
		    
    public  int login(String username,String password,String serverip,Boolean Socketclose){
    	int returnstatus=1;
    	this.username=username;
    	this.password=password;
    	this.serverip=serverip;
    	ftp=new FTPClient();
    	try{
    		ftp.connect(serverip);		
    		returnstatus = ftp.getReplyCode();
         	if (!FTPReply.isPositiveCompletion(returnstatus)){
         		ftp.disconnect();
         		returnstatus=-1;
         		CyberoamLogger.appLog.debug("FTP server refused connection.");
         	}        	
    	 if (!ftp.login(username,password))
         {
             ftp.logout();
             returnstatus=-2;
             CyberoamLogger.appLog.debug("FTP username or password not found");
         }
    	}
    	catch (IOException e){	
    		CyberoamLogger.appLog.debug("FTP server refused connection."+e);
    		returnstatus=-3;
	     }
    	finally{
    		if(Socketclose){
    			if (ftp.isConnected()){
    				try {
      				ftp.disconnect();
   			    	}catch (IOException f){
   			    	returnstatus=-3;
   			    	}
             	}
    		}
    	}
    	return returnstatus;
    }
    
    public  int storeFile (String remotefilename,String localfilename){
    	int returnstatus=1;
    	InputStream input=null;
    	 try{
    	    
            ftp.setFileType(FTP.BINARY_FILE_TYPE);
            //Use passive mode as default because most of us are
            // behind firewalls these days.
            ftp.enterLocalPassiveMode();
                     
            Boolean direxist=false;
            Boolean dircreate=false;
            Boolean iscopycmplt=false;
            
            
            direxist=ftp.changeWorkingDirectory(iViewConfigBean.FTPBACKUPDIR);
            if(direxist){
            	dircreate=true;
            }
            else{	
        	dircreate=ftp.makeDirectory(iViewConfigBean.FTPBACKUPDIR);
        	dircreate=ftp.changeWorkingDirectory(iViewConfigBean.FTPBACKUPDIR);
            }
        	if(dircreate){
        		
        		input = new FileInputStream(localfilename);
        		iscopycmplt=ftp.storeFile(remotefilename,input);
        		
        	}
        	if(!iscopycmplt){
        		returnstatus=-2;
        		CyberoamLogger.appLog.debug("FTPFileManager StoreFile Method Copy Not Complete -->"+remotefilename);
        	}else{
        		CyberoamLogger.appLog.debug("FTPFileManager StoreFile Method Copy Complete -->"+remotefilename);
        	}
        	 ftp.changeToParentDirectory();
         }catch(FileNotFoundException e){
        	 CyberoamLogger.appLog.debug("FTP File Not Found Exception "+e);
        	 returnstatus=-3; 
         }catch (IOException e){
        	 CyberoamLogger.appLog.debug("FTP Exception on FileStore"+e);
        	 returnstatus=-1;
          } 
        finally
        {
               try
                {	if(input!=null){
                	input.close();	
                	}
                }
                catch (IOException f)
                {
                    returnstatus=-2;
                }
            }
        
        return returnstatus;
      } 
    public  int retrieveFile (String remotefilename,String localfilename){
    	int returnstatus=1;
    	Boolean direxist=false;
    	Boolean iscopycmplt=false;
        OutputStream output=null;
        try{
        	direxist=ftp.changeWorkingDirectory(iViewConfigBean.FTPBACKUPDIR);
        	if(direxist){
        		output = new FileOutputStream(localfilename+"/"+remotefilename);
        		iscopycmplt=ftp.retrieveFile(remotefilename, output);
        		if(!iscopycmplt){
        			returnstatus=-2;
        		}
        	}
        	else{
        		returnstatus=-1;
        	}
        	ftp.changeToParentDirectory();
        }catch(CopyStreamException e){
        	CyberoamLogger.appLog.debug("FTP CopyStreamException Exception "+e);
        	returnstatus=-2;
        }
        catch(IOException e){
        	CyberoamLogger.appLog.debug("FTP RetrieveFile  Exception"+e);
        returnstatus=-1;
        }
        finally
        {  	       try
                     {	
                    	 if(output!=null){
                    	 output.close();
                    	 }
                    }
                     catch (IOException f)
                     {
                         returnstatus=-2;
                     }
                 
             }
        return returnstatus;
    }
    public int logout()
    {
    	int returnstatus=1;
    	try{
    		if (ftp.isConnected()){
    			ftp.logout();
    			ftp.disconnect();
    		}
    	}catch(IOException e){
    		CyberoamLogger.appLog.debug("FTP Logout Exception"+e);
    		returnstatus=-1;
    	}    	
    	return returnstatus;
    }
    
}

