// ActionScript file
package event{
	import flash.events.Event;
	
	public class CommonEvent extends Event{
		
		public static const CUSTOM_ALERT_ACCEPTED_EVENT:String = "CustomAlertAcceptedEvent";
		public static const CUSTOM_ALERT_DENIED_EVENT:String = "CustomAlertDeniedEvent";
		
		public function CommonEvent(type_event:String){
			super(type_event, true, true);
		}
	}
}