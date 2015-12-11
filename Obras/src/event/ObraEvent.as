package event
{
	import flash.events.Event;
	import model.ObraVO;
	
	public class ObraEvent extends Event
	{
		public var obraVO:ObraVO;
		public static var OBRA_SAVE_DATA:String;
		public static var OBRA_UPDATE_DATA:String;
		public static var OBRA_BUSQUEDA_DATA:String;
		public function ObraEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}