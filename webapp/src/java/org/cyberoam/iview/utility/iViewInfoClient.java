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
	private static String passKey="iviewsdnv@1v1ew";
	static{
		try {
	/**
	public void run(){
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
		processInitialResponse(responseData);
	/**
	 * 
	 * @return
	 */
    public static iViewInfoBean  requestiViewInfo(iViewInfoBean requestData){
        HttpURLConnection servletCon=null;
        ObjectOutputStream objOS=null;
        ObjectInputStream objIS=null;        
        iViewInfoBean responseData=null;
        System.out.println("Requesting server");
        Properties prop = System.getProperties();
        prop.setProperty("sun.net.inetaddr.ttl","0");
                class RegistrationAuthenticator extends Authenticator{
                	public void setPassword(String pwd){
                Authenticator authenticator=new RegistrationAuthenticator(proxyUserName,proxyPassword);
        try{
    /**
    	if(iViewID == null){
    /**
    private static iViewInfoBean getInitialRequestData(){
    /**
    private static ArrayList executeSQL(String query) {
    /**
     * 
     * @param actReqData
     * @return
     */
    private static SealedObject getSealedObj(Object objToSealed){
        return so;
    /**
	private static Object getUnSealedObject(SealedObject sealedObject){
	public static String parseString(String str){