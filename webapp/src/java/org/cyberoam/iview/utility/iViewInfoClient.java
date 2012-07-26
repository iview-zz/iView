package org.cyberoam.iview.utility;


import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Authenticator;
import java.net.HttpURLConnection;
import java.net.NoRouteToHostException;
import java.net.PasswordAuthentication;
import java.net.SocketException;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.TimerTask;

import javax.crypto.Cipher;
import javax.crypto.SealedObject;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.beans.iViewInfoBean;
import org.cyberoam.iview.system.utility.SystemInformation;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;


/**
 * iView Information Client
 * This client will connect to iView Server given in server url. 
 * @author narendrashah
 *
 */
public class iViewInfoClient implements Runnable{
	private static String passKey="iviewsdnv@1v1ew";	private static String serverURL="http://update.cyberoam-iview.org/iviewupgrades/iViewInfoServer";	private static String proxyServerIP=null;	private static String proxyUserName=null;	private static String proxyPassword=null;	private static String proxyPort=null;	public static String message=null;	public static String iViewID=null;	/**	 * Start from command line. 	 * @param args	 */
	static{
		try {			iViewID = (iViewConfigBean.getValueByKey("iviewid")!=null && !"".equalsIgnoreCase(iViewConfigBean.getValueByKey("iviewid").trim()))?iViewConfigBean.getValueByKey("iviewid").trim():null;			//iViewID="".equalsIgnoreCase(iViewConfigBean.getValueByKey("iviewid").trim())?null:iViewConfigBean.getValueByKey("iviewid");		}catch (Exception e) {			CyberoamLogger.regLog.debug("Exception in iViewInfoClient static block"+e,e);		}	}
	/**	 * Scheduled thread.	 */
	public void run(){		/**
         * Making message null.
         */
        message=null;       
		iViewInfoBean requestData=getInitialRequestData();
		CyberoamLogger.regLog.info("iViewInfoClient:First iViewInfoBean:"+requestData);		
		/**
		 * Request for first time.
		 */
		iViewInfoBean responseData = requestiViewInfo(requestData);
		CyberoamLogger.regLog.info("iViewInfoClient:First response from server:"+responseData);
		processInitialResponse(responseData);	}
	/**
	 * 
	 * @return
	 */
    public static iViewInfoBean  requestiViewInfo(iViewInfoBean requestData){    	URL url=null;
        HttpURLConnection servletCon=null;
        ObjectOutputStream objOS=null;
        ObjectInputStream objIS=null;        
        iViewInfoBean responseData=null;
        System.out.println("Requesting server");
        Properties prop = System.getProperties();
        prop.setProperty("sun.net.inetaddr.ttl","0");        try{        		if(proxyServerIP != null && !"".equals(proxyServerIP)) {        		//Registering the authenticator object            	CyberoamLogger.regLog.debug("In USING PROXY BLOCK....");
                class RegistrationAuthenticator extends Authenticator{                	private String username,password;                	public RegistrationAuthenticator(){                	   this.username = "";                	   this.password = "";                	}	                	public RegistrationAuthenticator(String username,String password){                	   this.username = username;                	   this.password = password;                	}              	                	public void setUsername(String usrname){                		this.username = usrname;                	}
                	public void setPassword(String pwd){                		this.password = pwd;                	}                	protected PasswordAuthentication getPasswordAuthentication(){                	      return new PasswordAuthentication(                	          username,password.toCharArray());                	}                };
                Authenticator authenticator=new RegistrationAuthenticator(proxyUserName,proxyPassword);                Authenticator.setDefault(authenticator);                prop.setProperty("proxySet","true");                prop.setProperty("http.proxyHost",proxyServerIP );                prop.setProperty("http.proxyPort",proxyPort);            }else{                      CyberoamLogger.regLog.debug("NO PROXY INFO SET");                 prop.setProperty("proxySet","false");                prop.setProperty("http.proxyHost","");                prop.setProperty("http.proxyPort","");             }                                 /**             * Connection Initialization             */            url=new URL (serverURL);            CyberoamLogger.regLog.debug("Opening Server URL :: "+url);            servletCon= (HttpURLConnection)url.openConnection();            servletCon.setUseCaches(false);            servletCon.setDefaultUseCaches(false);            servletCon.setDoInput(true);                        servletCon.setDoOutput(true);            servletCon.setRequestProperty ("Content-Type", "application/octet-stream");            servletCon.setRequestMethod("POST");            CyberoamLogger.regLog.debug("Successfully Connected to Server URL :: "+url);            /**             * Connection initialized and getting outputstream.             */            objOS=new ObjectOutputStream(servletCon.getOutputStream());                        CyberoamLogger.regLog.debug("iViewInfoBean initial request data :"+requestData);            SealedObject si=getSealedObj(requestData);            CyberoamLogger.regLog.debug("Request SealedObject="+si);            objOS.writeObject(si);            objOS.flush();            CyberoamLogger.regLog.debug("Written initial request SealedObject successfully");        }catch(NoRouteToHostException noRouteExc){            CyberoamLogger.regLog.debug("NoRouteToHostException :"+noRouteExc);            responseData = new iViewInfoBean();            return responseData ;                    }catch(SocketException se){            CyberoamLogger.regLog.debug("Socket Exception:"+se);        }catch(UnknownHostException uhe){            CyberoamLogger.regLog.debug("Exception:"+uhe);            responseData = new iViewInfoBean();            return responseData;         }catch(java.net.ProtocolException pe){            CyberoamLogger.regLog.debug("[Registration Process: ] Exception Occurred "+pe);            CyberoamLogger.regLog.debug("[Registration Process: ] Please Check your Username and Password for Proxy Server. ");        }catch(Exception e){            CyberoamLogger.regLog.debug("iViewClientInfo.requestUpdatedInfo.initRequest:"+e,e);        }  
        try{            objIS= new ObjectInputStream(servletCon.getInputStream());            SealedObject so=null;                   so=(SealedObject)objIS.readObject();            responseData=(iViewInfoBean)getUnSealedObject(so);            CyberoamLogger.regLog.debug("iViewInfoBean Server Response Data :"+responseData);        }catch(Exception ex){            CyberoamLogger.regLog.debug("iViewClientInfo.requestUpdatedInfo.readObject and write object:"+ex,ex);                    }finally{        	CyberoamLogger.regLog.debug("Closing connection.");            servletCon.disconnect();            try{            	objOS.close();            	objIS.close();            }catch (Exception e) {}        }        return responseData;            }
    /**     *      * @param response     */    private static void processInitialResponse(iViewInfoBean response){    	CyberoamLogger.regLog.debug("ProcessResponse:" + response);    	if(response.getValue("message.upgrade") != null){    		message=response.getValue("message.upgrade");    	}
    	if(iViewID == null){    		iViewConfigBean iViewConfigBean=new iViewConfigBean();    		String serveriViewID=response.getValue("iviewid");    		if(serveriViewID != null){    			iViewConfigBean.updateRecord("iviewid", serveriViewID);    			iViewID=serveriViewID;    		}    	}    } 
    /**     *      * @return     */
    private static iViewInfoBean getInitialRequestData(){    	iViewInfoBean iViewInfoBean=new iViewInfoBean();    	try {	    	iViewInfoBean.setValueForKey("dbversion", iViewConfigBean.getValueByKey("dbversion"));	    	iViewInfoBean.setValueForKey("os.name", System.getProperty("os.name")+ " version " +System.getProperty("os.version") );	    	iViewInfoBean.setValueForKey("systemtime", String.valueOf(System.currentTimeMillis()));   		    	iViewInfoBean.setValueForKey("query.iviewuptime", executeSQL("select actiontime from tblauditlog where message like 'iView Server started successfully' order by actiontime limit 1 "));	    	iViewInfoBean.setValueForKey("query.weeklogincount", executeSQL("select count(*)  from tblauditlog where message like 'User admin login successful' and actiontime > (now() - interval '1 week')"));	    	iViewInfoBean.setValueForKey("query.lastevents", executeSQL("select '24 hour (Average)' as tm,sum(events)/120 as events from tbl_device_event_4hr where   \"5mintime\" <= current_timestamp and \"5mintime\" > current_timestamp - interval '24 hour' union select '12 hour (Average)' as tm,sum(events)/60  as events from tbl_device_event_4hr where   \"5mintime\" <= current_timestamp and \"5mintime\" > current_timestamp - interval '12 hour' union select '1 hour (Average)' as tm,sum(events)/12 as events  from tbl_device_event_4hr where   \"5mintime\" <= current_timestamp and \"5mintime\" > current_timestamp - interval '1 hour' order by tm;"));	    	iViewInfoBean.setValueForKey("query.installdate", executeSQL("select actiontime from tblauditlog where logid = 1;"));	    	iViewInfoBean.setValueForKey("query.devicetypecount", executeSQL("select typename,count(*) from tbldevice,tbldevicetype where devicetypeid = devicetype group by typename;"));  		    	if(iViewID == null) {	    		iViewInfoBean.setValueForKey("lanipaddress", SystemInformation.getFirstLocalIPAddress());	    	}else {	    		iViewInfoBean.setValueForKey("iviewid", iViewID);	    	}    	}catch (Exception e) {    		CyberoamLogger.regLog.debug("iViewClientInfo.getInitialRequest:"+e,e);		}    	return iViewInfoBean;    }
    /**     *      * @param query     * @return     */
    private static ArrayList executeSQL(String query) {    	SqlReader sqlReader = new SqlReader();		ResultSetWrapper rsw = null;		ArrayList returnValue = new ArrayList();		try {			rsw = sqlReader.getInstanceResultSetWrapper(query);			int columnCount = rsw.getMetaData().getColumnCount();			String[] columns = new String[columnCount];			for(int i=1; i<=columnCount; i++){				columns[i-1] = rsw.getMetaData().getColumnName(i);			}			returnValue.add(columns);			while(rsw.next()){				String[] data = new String[columnCount];				for(int i=1; i<=columnCount; i++){					data[i-1] = rsw.getString(i);				}				returnValue.add(data);			}		}catch (Exception e) {			CyberoamLogger.repLog.debug("Server side Query problem: "+e,e);		}finally{ 						rsw.close();			sqlReader.close();		}		return returnValue;    }   
    /**
     * 
     * @param actReqData
     * @return
     */
    private static SealedObject getSealedObj(Object objToSealed){        byte key[] = passKey.getBytes();        SealedObject so=null;        try{            Cipher ecipher = Cipher.getInstance("DES");            DESKeySpec desKeySpec = new DESKeySpec(key);            SecretKeyFactory keyFactory =SecretKeyFactory.getInstance("DES");            SecretKey scKey =keyFactory.generateSecret(desKeySpec);            ecipher.init(Cipher.ENCRYPT_MODE, scKey);            ByteArrayOutputStream bos = new ByteArrayOutputStream(1024);            java.io.ObjectOutputStream oos = new ObjectOutputStream(bos);            oos.writeObject(objToSealed);            byte buffer[] = bos.toByteArray();             so = new SealedObject(buffer,ecipher);                }catch(Exception e){            CyberoamLogger.regLog.debug("iViewInfoClient.getSealedObject:"+e,e);        }
        return so;    }
    /**	 * 	 * @param si- SealsedObject which is to be unsealed.	 * @return	 */    
	private static Object getUnSealedObject(SealedObject sealedObject){        byte key[] = passKey.getBytes();        Object data=null;        try{            DESKeySpec desKeySpec = new DESKeySpec(key);            SecretKeyFactory keyFactory =SecretKeyFactory.getInstance("DES");            SecretKey scKey =keyFactory.generateSecret(desKeySpec);            Cipher dcipher = Cipher.getInstance("DES");            dcipher.init(Cipher.DECRYPT_MODE, scKey);                     byte buffer[] = (byte[])sealedObject.getObject(dcipher);            ObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(buffer));            data = (iViewInfoBean)ois.readObject();            System.out.println("OBJECT ="+data);        }catch(Exception e){        	CyberoamLogger.regLog.debug("iViewInfoClient.getUnSealedObject:"+e,e);        }        return data;     }
	public static String parseString(String str){		String parsedStr = str;		if(parsedStr!=null){			parsedStr.replaceAll(",", "\\,");			parsedStr.replaceAll("\\[", "\\["); // Searches for [ as regEx			parsedStr.replaceAll("\\]", "\\]");		}		return parsedStr;	}}