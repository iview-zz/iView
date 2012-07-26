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


import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.cyberoam.iview.audit.AuditLog;
import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;

/**
 * This utility class is used to send mails over SMTP.
 * This allows to send mail with and with out attachments. 
 * @author Narendra Shah
 */
public class MailSender {
	/**
	 * This class is generic mail sender. 
	 * Your work is just to create MailSender object and invoke its send method. 
	 */
	
	private String smtpServerHost;
	private String smtpServerPort;
	private String smtpFromAddr;
	private String smtpToAddr;
	private String mailSubject;
	private String mailContentFile;
	private String smtpUsername;
	private String smtpPassword;
	private String smtpAuthFlag;
	private String smtpDisplayName;
	/**
	 * Mail setting static properties value.
	 */
	private static final String MAILSMTPHOST="mail.smtp.host";
	private static final String MAILSMTPPORT="mail.smtp.port";
	private static final String MAILSMTPAUTH="mail.smtp.auth";
	private static final String MAILSMTPUSER="mail.smtp.user";
	private static final String MAILSMTPPASSWORD="mail.smtp.password";
	private static final String MAILSMTPSOCKETFACTORYPORT="mail.smtp.socketFactory.port";
	private static final String MAILSMTPSOCKETFACTORYCLASS="mail.smtp.socketFactory.class";
	private static final String MAILSMTPSOCKETFACTORYFALLBACK="mail.smtp.socketFactory.fallback";	
	private static final String MAILTRANSPORTPROTOCOL="mail.transport.protocol";
	private static final String MAILDEBUG="mail.debug";
	private static final String VALUETRUE="true";
	private static final String VALUEFALSE="false";
	
	/**
	 * This constructer will send mail using iView default mail server.
	 * @param fromAddress - sender email address
	 * @param toAddress - receiver email address
	 * @param subject - subject of email
	 * @param message - message to be sent
	 */
	public MailSender(String fromAddress,String toAddress,String subject,String message){
	 
		this.smtpFromAddr = fromAddress;
		this.smtpToAddr = toAddress;
		this.mailSubject = subject;
		this.mailContentFile = message;
		
		smtpServerHost = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERHOST);					
		if(smtpServerHost == null || "".equalsIgnoreCase(smtpServerHost)) {
			smtpServerHost = "127.0.0.1";
		}				
		
		smtpServerPort = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERPORT);					
		if(smtpServerPort == null || "".equalsIgnoreCase(smtpServerPort)) {
			smtpServerPort = "25";
		}
		
		smtpAuthFlag = iViewConfigBean.getValueByKey(iViewConfigBean.AUTHENTICATIONFLAG);					
		if(smtpAuthFlag == null || "".equalsIgnoreCase(smtpAuthFlag)) {
			smtpAuthFlag = "0";
		}
		smtpDisplayName=iViewConfigBean.getValueByKey(iViewConfigBean.MAIL_ADMIN_NAME);
		if("1".equals(smtpAuthFlag)) {
			smtpUsername = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERUSERNAME);					
			if(smtpUsername == null) {
				smtpUsername = "";
			}
			smtpPassword = iViewConfigBean.getValueByKey(iViewConfigBean.MAILSERVERPASSWORD);					
			if(smtpPassword == null) {
				smtpPassword = "";
			}
		}
	}
	
	/**
	 * This constructor will set given parameters.
	 * @param smtpServerHost - SMTP server host Address
	 * @param smtpServerPort - SMTP server port number
	 * @param smtpFromAddr - sender email address
	 * @param smtpToAddr - receiver email address
	 * @param mailSubject - subject of email
	 * @param mailContentFile - content to be sent as email
	 */
	public MailSender(String smtpServerHost, String smtpServerPort, String smtpFromAddr, 
			String smtpToAddr, String mailSubject, String mailContentFile) {
		this.smtpServerHost = smtpServerHost;
		this.smtpServerPort = smtpServerPort;
		this.smtpFromAddr = smtpFromAddr;
		this.smtpToAddr = smtpToAddr;
		this.mailSubject = mailSubject;
		this.mailContentFile = mailContentFile;
	}
	
	/**
	 * 
	 * @param smtpServerHost - SMTP server host Address
	 * @param smtpServerPort - SMTP server port number
	 * @param smtpFromAddr - sender email address
	 * @param smtpToAddr - receiver email address
	 * @param mailSubject - subject of email
	 * @param mailContentFile - content to be sent as email
	 * @param smtpAuthFlag - states whether user authentication is required or not
	 * @param smtpUsername - username to be used if authentication is required
	 * @param smtpPassword - password to be used with given username
	 */
	public MailSender(String smtpServerHost, String smtpServerPort, String smtpFromAddr, 
			String smtpToAddr, String mailSubject, String mailContentFile,
			String smtpAuthFlag, String smtpUsername, String smtpPassword) {

		this.smtpServerHost = smtpServerHost;
		this.smtpServerPort = smtpServerPort;
		this.smtpFromAddr = smtpFromAddr;
		this.smtpToAddr = smtpToAddr;
		this.mailSubject = mailSubject;
		this.mailContentFile = mailContentFile;
		this.smtpAuthFlag = smtpAuthFlag;
		this.smtpUsername = smtpUsername;
		this.smtpPassword = smtpPassword;
	}
	
	/**
	 * Sends mail.
	 * @return
	 */
	public int send() {
		int status=0;
		String messageBody = null;
		Properties props = null;
		Session session = null;
		Message message = null;		
		Authenticator auth = null;
		Transport transport = null;
		if(smtpServerHost == null || "".equalsIgnoreCase(smtpServerHost)){
			CyberoamLogger.sysLog.debug("mail send is stopped because smtpserverhost in tbliviewconfig is not exist.");
			return -1;
		}
		try {
			CyberoamLogger.sysLog.debug("Getting System Properties .....");
			props = System.getProperties();
			
			CyberoamLogger.sysLog.debug("Setting SMTP Mail Host and SMTP Mail Port  .....");
			props.put(MAILSMTPHOST, smtpServerHost);
			props.put(MAILSMTPPORT, smtpServerPort);
			props.put(MAILDEBUG, VALUEFALSE);
			props.put(MAILSMTPAUTH, VALUEFALSE);
			CyberoamLogger.sysLog.debug("SMTP Mail Host :: SMTP Mail Port - " 
					+ smtpServerHost + " :: " + smtpServerPort);
			
			if("1".equals(smtpAuthFlag)) {
				props.put(MAILSMTPAUTH, VALUETRUE);
				props.put(MAILSMTPUSER, smtpUsername);
				auth = new SMTPAuthenticator();				
			} 
			
			CyberoamLogger.sysLog.debug("Getting session for mail sending .....");
			// if auth is null then session without authentication will be created.
			session = Session.getInstance(props, auth);
			
			CyberoamLogger.sysLog.debug("Initializing mail contents .....");
			messageBody = mailContentFile;
			
			CyberoamLogger.sysLog.debug("Preparing a message body .....");
			message = new MimeMessage(session);
			message.setHeader("X-Mailer", "Cyberoam Mail Client");
			message.setHeader("Content-Type", "text/html; charset=UTF-8");
			
			if(smtpDisplayName==null || "".equalsIgnoreCase(smtpDisplayName) )
				message.setFrom(new InternetAddress(smtpFromAddr) );
			else message.setFrom(new InternetAddress(smtpFromAddr,smtpDisplayName));
			CyberoamLogger.sysLog.debug("Mail will be sent to: " + smtpToAddr);
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(smtpToAddr, false));
			
			InternetAddress replyAddress[]=new InternetAddress[1];
			replyAddress[0]=new InternetAddress("no-reply@cyberoam.com");
			message.setReplyTo(replyAddress);
			
			message.setSentDate(new Date());
			message.setSubject(mailSubject);
			message.setText(messageBody);			
			message.setContent(messageBody, "text/html");
			message.saveChanges();
			CyberoamLogger.sysLog.debug("Message Content Type: " + message.getContentType());
			CyberoamLogger.sysLog.debug("Mail is ready to send .....");
			
			CyberoamLogger.sysLog.debug("Getting SMTP Transport Object for mail sending .....");
			transport = session.getTransport("smtp");
			
			if("1".equals(smtpAuthFlag)) {
				CyberoamLogger.sysLog.debug("Connecting to SMTP MailServer Host with Authentication .....");
				transport.connect(smtpServerHost, smtpUsername, smtpPassword);
				CyberoamLogger.sysLog.debug("Sending Mail .....");
				transport.sendMessage(message, message.getAllRecipients());
			} else {
				CyberoamLogger.sysLog.debug("Connecting to SMTP MailServer Host without Authentication .....");
				transport.connect();
				CyberoamLogger.sysLog.debug("Sending Mail .....");
				transport.sendMessage(message, message.getAllRecipients());
			}
			transport.close();
			CyberoamLogger.sysLog.debug("Mail sent OK.");
			AuditLog.mail.info("Mail with subject :\"" + mailSubject + "\" sent to " +smtpToAddr, null);
			
		}catch (MessagingException mex) {
	    	 status=-1;
	    	 AuditLog.mail.error("Mail sending failed : " + mex.getMessage(), null);
	    	 CyberoamLogger.sysLog.debug("MailSender.sendWithAttachment.messageexception:" +mex ,mex );
	    }catch (Exception e) {
		     status=-1;
		     AuditLog.mail.error("Mail sending failed : " + e.getMessage(), null);
		     CyberoamLogger.sysLog.debug("MailSender.sendWithAttachment.exception:" +e ,e );
	    }
		return status;
	}
	
	/**
	 * Sends mail with attachment.
	 * @param mimeAttachment
	 * @return
	 */
	public int sendWithAttachment(MimeBodyPart mimeAttachment){
		int status=0;
		Properties props = null;
		Session session = null;
		Message message = null;		
		Authenticator auth = null;
		Transport transport = null;
		if(smtpServerHost == null || "".equalsIgnoreCase(smtpServerHost)){
			CyberoamLogger.sysLog.debug("mail send is stopped because smtpserverhost in tbliviewconfig is not exist.");
			return -1;
		}
		try {
			props = System.getProperties();
			
			CyberoamLogger.sysLog.debug("Set MailServer configuration");
			props.put(MAILSMTPHOST, smtpServerHost);
			props.put(MAILSMTPPORT, smtpServerPort);
			props.put(MAILDEBUG, VALUEFALSE);
			props.put(MAILSMTPAUTH, VALUEFALSE);
			CyberoamLogger.sysLog.debug("SMTP Mail Host :: SMTP Mail Port - " 
					+ smtpServerHost + " :: " + smtpServerPort);
			
			if("1".equals(smtpAuthFlag)) {
				props.put(MAILSMTPAUTH, VALUETRUE);
				props.put(MAILSMTPUSER, smtpUsername);
				auth = new SMTPAuthenticator();				
			} 
			
			session = Session.getInstance(props, auth);
			message = new MimeMessage(session);
			message.setHeader("X-Mailer", "iView Mail Client");
			if(smtpDisplayName==null || "".equalsIgnoreCase(smtpDisplayName) )
				message.setFrom(new InternetAddress(smtpFromAddr) );
			else message.setFrom(new InternetAddress(smtpFromAddr,smtpDisplayName));
			CyberoamLogger.sysLog.debug("Mail will be sent to: " + smtpToAddr);
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(smtpToAddr, false));
			InternetAddress replyAddress[]=new InternetAddress[1];
			replyAddress[0]=new InternetAddress("no-reply@cyberoam.com");
			message.setReplyTo(replyAddress);
			
			message.setSentDate(new Date());
			message.setSubject(mailSubject);
  
			// create and fill the first message part
	        MimeBodyPart textPart = new MimeBodyPart();
	        textPart.setText(mailContentFile);
	        textPart.setHeader("Content-Type", "text/html; charset=UTF-8");
	   
	        // create the Multipart and its parts to it
	        Multipart mp = new MimeMultipart();
	        mp.addBodyPart(mimeAttachment);
	        
	        mp.addBodyPart(textPart);
	        // add the Multipart to the message
	        message.setContent(mp);
	        
	       CyberoamLogger.sysLog.debug("Mail is ready to send .....");
			
			CyberoamLogger.sysLog.debug("Getting SMTP Transport Object for mail sending .....");
			transport = session.getTransport("smtp");
			
			if("1".equals(smtpAuthFlag)) {
				CyberoamLogger.sysLog.debug("Connecting to SMTP MailServer Host with Authentication .....");
				transport.connect(smtpServerHost, smtpUsername, smtpPassword);
				CyberoamLogger.sysLog.debug("Sending Mail .....");
				transport.sendMessage(message, message.getAllRecipients());
			} else {
				CyberoamLogger.sysLog.debug("Connecting to SMTP MailServer Host without Authentication .....");
				transport.connect();
				CyberoamLogger.sysLog.debug("Sending Mail .....");
				transport.sendMessage(message, message.getAllRecipients());
			}
			transport.close();
			AuditLog.mail.info("Mail with subject :\"" + mailSubject + "\" sent to " +smtpToAddr, null);
			CyberoamLogger.sysLog.debug("Mail sent OK.");
		  } catch (MessagingException mex) {
	    	 status=-1;
	    	 AuditLog.mail.error("Mail sending failed : " + mex.getMessage(), null);
	    	 CyberoamLogger.sysLog.debug("MailSender.sendWithAttachment.messageexception:" +mex ,mex );
	      }catch (Exception e) {
		     status=-1;
		     AuditLog.mail.error("Mail sending failed : " + e.getMessage(), null);
		     CyberoamLogger.sysLog.debug("MailSender.sendWithAttachment.exception:" +e ,e );
		  }
	      return status;

	}
	
	/**
	 * This inner class is used to authenticate SMTP username and password.
	 * @author Narendra Shah
	 *
	 */
	private class SMTPAuthenticator extends javax.mail.Authenticator {
	    public PasswordAuthentication getPasswordAuthentication() {
	       String username = smtpUsername;
	       String password = smtpPassword;
	       return new PasswordAuthentication(username, password);
	    }
	}

	/**
	 * Returns SMTP server host Address.
	 * @return
	 */
	public String getSmtpServerHost() {
		return smtpServerHost;
	}
	/**
	 * Sets SMTP server host Address.
	 * @param smtpServerHost
	 */
	public void setSmtpServerHost(String smtpServerHost) {
		this.smtpServerHost = smtpServerHost;
	}
	/**
	 * Returns SMTP server port number.
	 * @return
	 */
	public String getSmtpServerPort() {
		return smtpServerPort;
	}
	/**
	 * Sets SMTP server port number.
	 * @param smtpServerPort
	 */
	public void setSmtpServerPort(String smtpServerPort) {
		this.smtpServerPort = smtpServerPort;
	}
	/**
	 * Returns sender email address.
	 * @return
	 */
	public String getSmtpFromAddr() {
		return smtpFromAddr;
	}
	/**
	 * Sets sender email address.
	 * @param smtpFromAddr
	 */
	public void setSmtpFromAddr(String smtpFromAddr) {
		this.smtpFromAddr = smtpFromAddr;
	}
	/**
	 * Returns receiver email address.
	 * @return
	 */
	public String getSmtpToAddr() {
		return smtpToAddr;
	}
	/**
	 * Sets receiver email address.
	 * @param smtpToAddr
	 */
	public void setSmtpToAddr(String smtpToAddr) {
		this.smtpToAddr = smtpToAddr;
	}
	/**
	 * Returns subject of email.
	 * @return
	 */
	public String getMailSubject() {
		return mailSubject;
	}
	/**
	 * Sets subject of email.
	 * @param mailSubject
	 */
	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}
	/**
	 * Returns content to be sent as email.
	 */
	public String getMailContentFile() {
		return mailContentFile;
	}
	/**
	 * Sets content to be sent as email. 
	 * @param mailContentFile
	 */
	public void setMailContentFile(String mailContentFile) {
		this.mailContentFile = mailContentFile;
	}
	/**
	 * Returns username to be used if authentication is required.
	 * @return
	 */
	public String getSmtpUsername() {
		return smtpUsername;
	}
	/**
	 * Sets username to be used if authentication is required.
	 * @param smtpUsername
	 */
	public void setSmtpUsername(String smtpUsername) {
		this.smtpUsername = smtpUsername;
	}
	/**
	 * Returns password to be used with given username.
	 * @return
	 */
	public String getSmtpPassword() {
		return smtpPassword;
	}
	/**
	 * Sets password to be used with given username.
	 * @param smtpPassword
	 */
	public void setSmtpPassword(String smtpPassword) {
		this.smtpPassword = smtpPassword;
	}
	/**
	 * Returns flag that states whether user authentication is required or not.
	 * @return
	 */
	public String getSmtpAuthFlag() {
		return smtpAuthFlag;
	}
	/**
	 * Sets flag that states whether user authentication is required or not.
	 * @param smtpAuthFlag
	 */
	public void setSmtpAuthFlag(String smtpAuthFlag) {
		this.smtpAuthFlag = smtpAuthFlag;
	}
	/**
	 * Returns name to be displayed in mail with sender address.
	 * @return
	 */
	public String getSmtpDisplayName() {
		return smtpDisplayName;
	}
	/**
	 * Sets name to be displayed in mail with sender address.
	 * @param smtpDisplayName
	 */
	public void setSmtpDisplayName(String smtpDisplayName) {
		this.smtpDisplayName = smtpDisplayName;
	}
}
