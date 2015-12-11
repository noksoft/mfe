package utils
{
	public class GeneralUtils
	{
		public static function StringToNumber(text:String):Number{
			var result:Number = 0;
			if(text != null && text != ""){
				text = removeFormatString(text);
				return result = Number(text);
			}else{
				return result;
			}
		}
		
		public static function removeFormatString(text:String):String{
			return text;
		}
	}
}