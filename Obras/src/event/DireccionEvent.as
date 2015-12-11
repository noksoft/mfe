package event
{
	import flash.events.Event;
	import model.EntidadVO;
	import model.MunicipioVO;
	import model.LocalidadVO;
	
	public class DireccionEvent extends Event
	{
		public var entidadVO:EntidadVO;
		public var municipioVO:MunicipioVO;
		public var localidadVO:LocalidadVO;
		public static var LOCALIDAD_LIST_DATA:String;
		public function DireccionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}