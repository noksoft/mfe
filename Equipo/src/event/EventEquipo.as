package event
{
	import flash.events.Event;
	
	import model.EquipoVO;
	
	public class EventEquipo extends Event
	{
		public static const SELECTED_MAQUINA_PESADA_EVENT:String = "selectedMaquinaPesadaEvent";
		
		public var equipoSelected:EquipoVO;
		
		public function EventEquipo(type:String)
		{
			super(type, true, true);
		}
	}
}