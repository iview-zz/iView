package org.cyberoam.iview.utility;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.ArrayList;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.audit.CyberoamLogger;


/**
 * This class is designed for capturing packets when garner is in stopped mode.
 * @author darshanshah
 * @author huzaifa bhavnagri
 * @author jenit shah
 */
public class UdpPacketCapture extends Thread{
	 private static DatagramSocket socket;
	 private static ArrayList<String> logList =null;
	 private static boolean isRunning=false;	 
	 /**
	  * Start capture.
	  */
	 public static void startCapture(){
		 if(isRunning){ 
			return; 
		 }else {
			 Thread udpPacketCapture=new UdpPacketCapture();			 udpPacketCapture.start();
		 }
	 }
	 public void run(){
		 try{
			logList= new ArrayList();
			int port=Integer.parseInt(iViewConfigBean.getValueByKey("GarnerPort"));
		 	socket = new DatagramSocket(port);
	        byte[] buffer = new byte[2048];
	        CyberoamLogger.sysLog.debug("#########Packet Capture Started########");	        
	        DatagramPacket packet=null;
	        InetAddress client=null;	        	        String log="";
	        while(true){
	        	isRunning=true;
	        	packet = new DatagramPacket(buffer, buffer.length );
		        socket.receive(packet);
		        client = packet.getAddress();		        		        log="Device IP : "+client.toString()+" "+new String(buffer,0,packet.getLength());		        addInList(log);		       
		    }
        }catch (IOException e){
        	  	CyberoamLogger.sysLog.error("UDPPacketCapture.run.Error:"+e,e);
	    }finally{
	    	  CyberoamLogger.sysLog.debug("#########Packet Capture Ends##########");
	    } 
	 }
	 /**
	  * Stop capture
	  */
	 public static void stopCapture(){
		 CyberoamLogger.appLog.info("Request for stoping udppacketcapture");
		 if(isRunning){
			 logList=null;
			 isRunning=false;
			 socket.close();
			 socket.disconnect();
			 
			 CyberoamLogger.sysLog.info("Udppacketcapture socket closed");
		 }
	 }
	 
	 /**
	  * Return show status about port used or not
	  * @return
	  */
	 @SuppressWarnings("finally")
	public static int checkudpport(String portval){
		 int returnstatus=1;
		 int iportval=Integer.parseInt(portval);
		 DatagramSocket sockettest= null;
		 try{
				sockettest=new DatagramSocket(iportval);
				return returnstatus;
		 }catch(IOException se){
			CyberoamLogger.sysLog.info("UDP Port already in Use"+se);
			returnstatus=-2;
			return returnstatus;
		  }			
		 finally{
			 if(sockettest!=null)
			 {
				 sockettest.close();
				 sockettest.disconnect();
			 }
		 }
 	 }
	 
	 /**
	  * Return filled log
	  * @return
	  */
	public static ArrayList<String> getLogList() {
		return logList;
	}	
	private static void  addInList(String log){
		if (logList.size()>=100){
    		logList.remove(99);  
    	}
    	logList.add(0,log);
	}		
}