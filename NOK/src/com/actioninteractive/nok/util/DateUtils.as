/**
* Copyright © 2011 Action Interactive. ALL RIGHTS RESERVED.
* This file contains proprietary and Action Interactive Information.
* Use, disclosure or reproduction is prohibited.
*
* @filename Dateutils.as
* @created on Abril 2014
* @author RICARDO ZARAGOZA SOLÍS
* @version 1.0
**/
package com.actioninteractive.nok.util
{
	import mx.formatters.DateFormatter;
	
	public class DateUtils
	{
		public function DateUtils()
		{
		}
		
		public static function parseBackDate(dateString:String):Date {                  
			if(dateString == null || dateString == ""){
				return null;
			}
			
			dateString = dateString.replace(/\-/g, "/");
			
			return new Date(Date.parse(dateString));
		}
		
		public static function formatDate(value:Object, format:String = "MMM D,YYYY"):String{
			var backFormat:DateFormatter = new DateFormatter();
			backFormat.formatString = format;
			
			return backFormat.format(value);
		}
		
		public static function formatBackDate(dateString:String, format:String = "MM/DD/YY"):String{
			var date:Date = DateUtils.parseBackDate(dateString);
			
			return DateUtils.formatDate(date, format);
		}
		
		public static function dateToBackDateString(value:Date):String{
			var backFormat:DateFormatter = new DateFormatter();
			backFormat.formatString = "YYYY/MM/DD";
			
			return backFormat.format(value);
		}
		
		public static function shiftDateByDays(currentDate:Date, daysOffset:int = 0):Date{
			var result:Date = new Date(currentDate);
			result.setDate(result.getDate() + daysOffset);
			
			return result;
		}
		
		/**
		 * Compares 2 dates and determines if the first one is greater than 
		 * the second, they are equal or the second greather than the first
		 * @param date1
		 * @param date2
		 * @return -1 if date1 is before date 2, 0 if equal, 1 if date1 is after date2
		 * 
		 */
		public static function compareDates(date1:Date, date2:Date):int{
			var result:int = 0;
			var date1Compare:Date = new Date(date1.getFullYear(), date1.getMonth(), date1.getDate());
			var date2Compare:Date = new Date(date2.getFullYear(), date2.getMonth(), date2.getDate());
			
			if(date1Compare.valueOf() < date2Compare.valueOf()){
				return -1;
			}else{
				if(date1Compare.valueOf() == date2Compare.valueOf()){
					return 0;
				}else{
					return 1;
				}
			}
		}
		
		/**
		 * Creates an array of dates that are in between the start and end dates 
		 * @param startDate
		 * @param endDate
		 * @param backFormat
		 * @return 
		 * 
		 */
		public static function createDateArray(start:Object, end:Object, backFormat:Boolean = true):Array{
			var result:Array = [];
			var startDate:Date;
			var endDate:Date;
			
			if(start is String && end is String){
				startDate = DateUtils.parseBackDate(start as String);
				endDate = DateUtils.parseBackDate(end as String);
			}else if(start is Date && end is Date){
				startDate = new Date(start);
				endDate = new Date(end);
			}else{
				return result;
			}
			
			if(startDate != null && endDate != null){
				startDate = new Date(startDate.fullYear, startDate.getMonth(), startDate.getDate());
				endDate = new Date(endDate.fullYear, endDate.getMonth(), endDate.getDate());
				var i:int = 0;
				
				if(backFormat){
					while(startDate.valueOf() <= endDate.valueOf()){
						result[i] = new Object();
						result[i].date = DateUtils.dateToBackDateString(startDate);
						startDate.setDate(startDate.getDate() + 1);
						i++;
					}
				}else{
					while(startDate.valueOf() <= endDate.valueOf()){
						result[i] = new Object();
						result[i].date = startDate;
						startDate.setDate(startDate.getDate() + 1);
						i++;
					}
				}
			}
			return result;
		}
	}
}