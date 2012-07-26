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

package org.cyberoam.iview.modes;

/**
 * This class is used to manage different constants which can be used in iView application.  
 * @author Narendra Shah
 *
 */
public class ApplicationModes {
	/**
	 * Specifies unsuccessful login by user.
	 */
	public static final int UNSUCCESSFUL = -1;
	/**
	 * Specifies successful login by user.
	 */
	public static final int SUCCESSFUL=1;
	/**
	 * Used when user try to login into iView.
	 */
	public static final int LOGIN = 1;
	/**
	 * Used when user try to logout from iView.
	 */
	public static final int LOGOUT = 2;
	/**
	 * Used to add new user.
	 */
	public static final int NEWUSER = 3;
	/**
	 * Used to delete user.
	 */
	public static final int DELETEUSER = 4;
	/**
	 * Used to update user information.
	 */
	public static final int UPDATEUSER = 5;
	/**
	 * Used to add new protocol group (Application group).
	 */
	public final static int ADD_PROTOCOL_GROUP = 6;
	/**
	 * Used to update protocol group (Application group) information.
	 */
	public final static int UPDATE_PROTOCOL_GROUP = 7;
	/**
	 * Used to delete protocol group (Application group).
	 */
	public final static int DELETE_PROTOCOL_GROUP = 8;
	/**
	 * Used to add new protocol (Application).
	 */
	public final static int ADD_APPLICATION = 9;
	/**
	 * Used to update protocol (Application) information.
	 */
	public final static int UPDATE_APPLICATION = 10;
	/**
	 * Used to delete protocol (Application).
	 */
	public final static int DELETE_APPLICATION = 11;
	/**
	 * Used to add new protocol identifier(Application identifier).
	 */
	public final static int ADD_PROTOCOL_IDENTIFIER = 12;
	/**
	 * Used to update protocol identifier(Application identifier) information.
	 */
	public final static int UPDATE_PROTOCOL_IDENTIFIER = 13;
	/**
	 * Used to delete protocol identifier(Application identifier).
	 */
	public final static int DELETE_PROTOCOL_IDENTIFIER = 14;
	/**
	 * Used when user requests loading of achieved data. 
	 */
	public final static int ARCHIEVE_LOAD_REQUEST = 15;
	/**
	 * Used to add new report profile.
	 */
	public final static int ADD_REPORT_PROFILE = 16;
	/**
	 * Used to update report profile information.
	 */
	public final static int UPDATE_REPORT_PROFILE = 17;
	/**
	 * Used to delete report profile.
	 */
	public final static int DELETE_REPORT_PROFILE = 18;
	/**
	 * Used to update iView configuration.
	 */
	public final static int UPDATE_CONFIGURATION = 19;
	/**
	 * Used to update iView database configuration.
	 */
	public final static int UPDATE_DATABASE_CONFIGURATION = 21;
	/**
	 * Used to add new mail scheduler.
	 */
	public final static int ADD_MAIL_SCHEDULER = 22;
	/**
	 * Used to update mail scheduler information.
	 */
	public final static int UPDATE_MAIL_SCHEDULER = 23;
	/**
	 * Used to delete new mail scheduler.
	 */
	public final static int DELETE_MAIL_SCHEDULER = 24;
	/**
	 * Used to add new device.
	 */
	public final static int NEW_DEVICE = 25;
	/**
	 * Used to update device information.
	 */
	public final static int MANAGE_DEVICE = 20;
	/**
	 * Used to delete device.
	 */
	public final static int DELETE_DEVICE = 26;
	/**
	 * used to retrieve audit log data.
	 */
	public final static int GET_AUDIT_LOGS = 27;
	/**
	 * Used to add new device group.
	 */
	public final static int NEW_DEVICE_GROUP = 28;
	/**
	 * Used to update device group information.
	 */
	public final static int UPDATE_DEVICE_GROUP = 29;
	/**
	 * Used to delete device group.
	 */
	public final static int DELETE_DEVICE_GROUP = 30;
	/**
	 * Used to send test mail for mail configuration
	 */
	public final static int SEND_TEST_MAIL = 31;
	/**
	 * Used to reset protocol (Application), group and its identifiers into database.
	 */
	public final static int RESET_PROTOCOL = 32;
	/**
	 * Used to handle iView Warm file Unload request.
	 */
	public final static int WARMFILE_UNLOAD_REQUEST=33;
	/**
	 * Used to set the archive backup request
	 */
	public final static int ARCHIEVE_BACKUP_REQUEST = 34;
	/**
	 * Used to set the archive restore request
	 */
	public final static int ARCHIEVE_RESTORE_REQUEST = 35;	
	
	/**
	 * Used to set the unload all
	 */
	public final static int WARMFILE_UNLOAD_ALL = 36;	
	/**
	 * Used to set the Category change signal
	 */
	public final static int CATEGORY_CHANGE = 37;	
	/**
	 * Used to set the add bookmark request
	 */
	public final static int NEWBOOKMARK = 38;	
	
	/**
	 * Used to set the delete bookmark request
	 */
	public final static int DELETE_BOOKMARK = 39;
	/**
	 * Used to set the add bookmark group request
	 */
	public final static int NEWBOOKMARKGROUP = 40;
	/**
	 * Used to set the delete bookmark group request
	 */
	public final static int DELETE_BOOKMARK_GROUP = 41;
	/**
	 * Used to set check sum request
	 */
	public final static int CHECKSUM_REQUEST = 42;
	/**
	 * Used to set garner port request
	 */
	public final static int GARNER_PORT_CHANGE = 43;
	/**
	 * Used to set schedule backup 
	 */
	public final static int SCHEDULE_BACKUP = 44;
	/**
	 * Used to set restore the backup file
	 */
	public final static int RESTORE_REQUEST = 45;
	
	
	
}

