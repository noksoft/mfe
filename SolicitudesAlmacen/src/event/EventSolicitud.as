package event
{
	import flash.events.Event;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.SolicitudVO;
	
	public class EventSolicitud extends Event
	{
		public static const EVENT_FIND_ALL_Solicitudes:String 	= "eventFindAllSolicitudes";
		public static const EVENT_FIND_Solicitudes:String 		= "eventFindSolicitudes";
		//public static const EVENT_SAVE_Solicitud:String			= "eventSaveSolicitud";
		//public static const EVENT_UPDATE_SOLICITUD:String 		= "eventUpdateSolicitud";
		public static const EVENT_DELETE_SOLICITUD:String		= "eventDeleteSolicitud";
		public static const EVENT_SAVE_SOLICITUD:String			= "eventSaveSolicitud";
		public static const EVENT_UPDATE:String					= "eventUpdate";
		
		public static const EVENT_FIND_ARTICULOS:String			= "eventFindArticulos";
		public static const EVENT_FIND_EMPLEADOS:String 		= "eventFindEmpleados";
		
		public var articuloVO:ArticuloVO;
		public var empleadoVO:EmpleadoVO;
		public var solicitudVO:SolicitudVO;
		
		public function EventSolicitud(type:String)
		{
			super(type, true, true);
		}
	}
}