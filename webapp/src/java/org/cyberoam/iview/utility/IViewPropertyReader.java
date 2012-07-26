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

import java.io.File;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.beans.iViewConfigBean;
import org.cyberoam.iview.system.utility.SystemInformation;


/**
 * General Properties reader class for iView.
 * @author Narendra Shah
 */

public class IViewPropertyReader {

	private static ResourceBundle myresources;
	/**
	 * Name of property file.
	 */
	public static String FILENAME = "iview";
	
	/**
	 * Command to start mySql.
	 */
	public static String MySQLCommandArgument = null;
	/**
	 * Command to start PostGreSQL.
	 */
	public static String PostGreSQLCommandArgument = null;
	/**
	 * Garner file path.
	 */
	public static String GarnerHOME = "/usr/local/garner/";
	
	/**
	 * Archive raw directory path.
	 */
	public static String ArchieveDIR = null;
	/**
	 * Archive Indexed log directory path.
	 */
	public static String IndexDIR = null;
	
	/**
	 * Archive Backup log directory path.
	 */
	public static String BackupDIR = null;
	

	/**
	 * Hot folder directory path.
	 */
	public static String HOT = "/hot/rotated/";
	/**
	 * Cold folder directory path.
	 */
	public static String COLD = "/cold/";
	/**
	 * Warm folder directory path.
	 */
	public static String WARM = "/warm/";

	/**
	 * Field terminator used for indexed file.
	 */
	public static String IndexFileFiledTerminator = null;
	/**
	 * Line terminator used for indexed file.
	 */
	public static String IndexFileLineTerminator = null;
	/**
	 * Time stamp to be used from indexed file name.
	 */
	public static int IndexFileTimeStampUsed = 1;
	/**
	 * Number of bytes to read from indexed file.
	 */
	public static long LastIndexFileReadBytes = 0;
	/**
	 * Sleep time of file manager thread.
	 */
	public static long FileManagerSleepTimeMIN = 720;
	/**
	 * Pattern to be used to filter indexed log.
	 */
	public static String IndexLogFileFilterRegExp = null;
	/**
	 * Pattern to be used to filter raw log.
	 */
	public static String RowLogFileFilterRegExp = null;
	/**
	 * Command to be used to create indexed file. 
	 */
	public static String IndexTableCreationCommand = null;
	/**
	 * List of columns for indexing on table containing indexed log data.
	 */
	public static String ColumnsListForIndexingOnIndexTable = null;
	/**
	 * Number of days to keep warm file.
	 */
	public static int RetainWARMFilesForDay = 0;
	/**
	 * Sleep time of warm file manager thread.
	 */
	public static long WarmFileSleepTimeHours = 0;

	/**
	 * Path of file containing list of Active devices.
	 */
	public static String ActiveDeviceFile = "";
	/**
	 * Path of file containing list of Inactive devices.
	 */
	public static String InActiveDeviceFile = "";
	/**
	 * Path of file containing list of IP Addresses.
	 */
	public static String DeviceIPAddressListFile = "";
	
	static {
		initialize();
	}

	/**
	 * This method initializes all properties for iView.
	 * @throws MissingResourceException
	 */
	public static void initialize() throws MissingResourceException {

		myresources = ResourceBundle.getBundle(FILENAME, Locale.getDefault());

		/**
		 * Dynamic parameter get from tbliviewconfig.
		 */
		if(SystemInformation.isWindow)
			GarnerHOME=iViewConfigBean.iViewHome + "cygwin/usr/local/garner/";
		/**
		 * Static parameter for iview
		 */
		MySQLCommandArgument = getParameter("mysqlcommandargument");
		PostGreSQLCommandArgument = iViewConfigBean.iViewHome+ getParameter("postgresqlcommandargument");

		ArchieveDIR = iViewConfigBean.ArchiveHome + getParameter("archieveddir");
		IndexDIR = iViewConfigBean.ArchiveHome + getParameter("indexdir");
		BackupDIR = iViewConfigBean.ArchiveHome + getParameter("backupdir");
		if(!(new File(BackupDIR)).exists()) (new File(BackupDIR)).mkdirs(); 
		IndexFileFiledTerminator = getParameter("filefieldterminator");
		IndexFileLineTerminator = getParameter("filelineterminator");
		IndexFileTimeStampUsed = Integer.parseInt(getParameter("indexfiletimestampuse"));
		LastIndexFileReadBytes = Long.parseLong(getParameter("lastindexfilereadbytes"));
		FileManagerSleepTimeMIN = Long.parseLong(getParameter("filemanagersleeptimemin"));
		IndexLogFileFilterRegExp = getParameter("indexlogfilefilterregexp");
		RowLogFileFilterRegExp = getParameter("rowlogfilefilterregexp");
		IndexTableCreationCommand = getParameter("indextablecreationcommand");
		ColumnsListForIndexingOnIndexTable = getParameter("columnslistforindexingonindextable");
		RetainWARMFilesForDay = Integer.parseInt(getParameter("retainwarmfilesfordays"));
		WarmFileSleepTimeHours = Long.parseLong(getParameter("warmfilesleeptimehours"));

		ActiveDeviceFile = getParameter("activedevicefile");
		InActiveDeviceFile = getParameter("inactivedevicefile");
		DeviceIPAddressListFile = getParameter("deviceipaddresslistfile");
	}

	/**
	 * This method is used to get parameter value of given property.
	 * @param parmName
	 * @return
	 */
	private static String getParameter(String parmName) {
		String param = null;
		try {
			param = myresources.getString(parmName);
		} catch (Exception e) {
			CyberoamLogger.sysLog.error(
					"Exception in getting parameter in IViewPropertyReader.java --> "
							+ parmName + " " + e, e);
			param = null;
		}
		if (param != null)
			return param.trim();
		else
			return param;
	}
}
