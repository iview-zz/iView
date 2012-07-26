package org.cyberoam.iview.beans;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
/**
 * This class contains information which would be used between iView Upgrade server and iView Upgrade client. 
 * @author narendrashah
 */
public class iViewInfoBean implements Serializable{
	HashMap keyValueMap=new HashMap();
	/**
	 * UpgradeInfoBean Settings.
	 */
	public iViewInfoBean() {
	   super();
	}
	/**
	 * Set value for given key,value in string format and also insert/update key in keyvaluemappings.
	 * @param keyName
	 * @param value
	 */
	public void setValueForKey(String keyName,String value){
		keyValueMap.put(keyName,value);
	}
	/**
	 * Get String value from keyValue map
	 * @param keyName
	 * @return value
	 */
	public String getValue(String keyName){
		return (String)keyValueMap.get(keyName);
	}
	/**
	 * Set value for given key,value and also insert/update key in keymappings.
	 * @param keyName
	 * @param value
	 */
	public void setValueForKey(Object keyName,Object value){
		keyValueMap.put(keyName,value);
	}
	/**
	 * Get String value from keyValue map
	 * @param keyName
	 * @return value
	 */
	/**
	 * Get Object value for a given key object
	 * @param keyName
	 * @return value
	 */
	public Object getValue(Object keyName){
		return keyValueMap.get(keyName);
	}
	/**
	 * Get Key value mapping Hash
	 * 
	 * @return keyValueMap
	 */
	public HashMap getKeyValue(){
		return keyValueMap;
	}
	/**
	 * 
	 */
	@Override
	public String toString() {
		Iterator keyvalIterator=keyValueMap.keySet().iterator();
		String returnString="";
		while(keyvalIterator.hasNext()){
			Object keyObject=keyvalIterator.next();
			returnString += "#" + keyObject.toString()+ ":"+keyValueMap.get(keyObject) + "#";
		}
		return returnString;
	}
}
