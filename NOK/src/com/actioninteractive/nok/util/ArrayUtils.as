/**
* Copyright © 2014 Action Interactive. ALL RIGHTS RESERVED.
* This file contains proprietary and Action Interactive Information.
* Use, disclosure or reproduction is prohibited.
* 
* @fileName ArrayUtils.as
* @creationDate Abril 2014
* @author RICARDO ZARAGOZA SOLÍS
* @version 1.0
*/
package com.actioninteractive.nok.util
{
	import mx.collections.ArrayCollection;
	
	public class ArrayUtils
	{
		public function ArrayUtils()
		{
		}
		
		/**
		 * Returns an item that is in an array that matches the specified property name and value 
		 * @param array
		 * @param property
		 * @param value
		 * @return 
		 * 
		 */
		public static function getItemByProperty(array:ArrayCollection, property:String, value:String):Object{
			
			for each(var obj:Object in array){
				if(""+obj[property] == value){
					return obj;
				}
			}
			
			return null;
		}
		
		/**
		 * Returns an item that is in an array that matches the specified properties and values
		 * @param array
		 * @param property
		 * @param value
		 * @return 
		 * 
		 */
		public static function getItemByMultipleProperties(array:ArrayCollection, property:Array, value:Array):Object{
			
			for each(var obj:Object in array){
				var inc:Boolean = true;
				var i:int = 0;
				var properties:int = property.length;
				
				while(i < properties){
					if(""+obj[property[i]] != ""+value[i]){
						inc = false;
						break;
					}
					
					i++;
				}
				if(inc){
					return obj;
				}
			}
			
			return null;
		}
	}
}