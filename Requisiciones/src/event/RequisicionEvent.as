package event
{
	import flash.events.Event;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.RequisicionVO;
	
	public class RequisicionEvent extends Event
	{
		public static const EVENT_SAVE_REQUISICION:String = "eventSaveRequisicion";
		public static const EVENT_UPDATE_REQUISICION:String = "eventUpdateRequisicion";
		public static const EVENT_DELETE_REQUISICION:String = "eventDeleteRequisicion";
		public static const EVENT_FIND_REQUISICIONES:String = "eventFindRequisiciones";
		
		public static const EVENT_FIND_ARTICULOS:String = "eventFindArticulos";
		public static const EVENT_FIND_EMPLEADOS:String = "eventFindEmpleados";
		public static const EVENT_SAVE_SUCCEFULL:String = "eventSaveSuccefull";
		
		public var requisicionVO:RequisicionVO;
		public var articuloVO:ArticuloVO;
		public var empleadoVO:EmpleadoVO;
		
		public function RequisicionEvent(type:String)
		{
			super(type, true, true);
		}
	}
}