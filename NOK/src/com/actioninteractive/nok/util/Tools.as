package com.actioninteractive.nok.util
{
	import mx.collections.ArrayCollection;
	
	import spark.components.DropDownList;

	public class Tools
	{
		
		
		public static function locateAndSelect(combo:DropDownList,elementToCompare:String, field:String):void{
			var size:Object = combo.dataProvider;
			var index:Number = 0;
			for(var i:int=0; i<size.length;i++){
				combo.selectedIndex = i;
				if(combo.selectedItem[field] == elementToCompare)
				{
					index = i; 
				}
			}
			combo.selectedIndex = index;
		}
		
		public function Tools()
		{
		}
	}
}