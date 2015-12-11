// ActionScript file
package event{
	import flash.events.Event;
	
	import model.EquipoVO;
	
	public class CommonEvent extends Event{
		
		public static const CUSTOM_ALERT_ACCEPTED_EVENT:String = "CustomAlertAcceptedEvent";
		public static const CUSTOM_ALERT_DENIED_EVENT:String = "CustomAlertDeniedEvent";
		
		public static const SAVE_EQUIPO_EVENT:String = "saveEquipoEvent";
		public static const UPDATE_EQUIPO_EVENT:String = "updateEquipoEvent";
		public static const DELETE_EQUIPO_EVENT:String = "deleteEquipoEvent";
		
		public static const SELECTED_MAQUINA_PESADA_EVENT:String = "selectedMaquinaPesadaEvent";
		public static const SELECTED_ITEM:String = "selectedItem";
		public static const SELECTED_ITEM2:String = "selectedItem2";
		
		public var equipoItem:EquipoVO;
		
		public function CommonEvent(type_event:String){
			super(type_event, true, true);
		}
	}
}