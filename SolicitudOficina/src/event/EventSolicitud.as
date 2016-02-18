package event
{
	import flash.events.Event;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.SolicitudVO;
	
	public class EventSolicitud extends Event
	{
		public static const EVENT_FIND_ALL_Solicitudes:String 		= "eventFindAllSolicitudes";
		public static const EVENT_FIND_Solicitudes:String 			= "eventFindSolicitudes";
		public static const EVENT_UPDATE_CHANGES_SOLICITUDES:String	= "eventUpdateChangeSolicitudes";
		public static const EVENT_UPDATE:String						= "eventUpdate";
		public var solicitudVO:SolicitudVO;
		
		public function EventSolicitud(type:String)
		{
			super(type, true, true);
		}
	}
}