package event
{
	import flash.events.Event;
	
	public class EmpleadoEvent extends Event
	{
		public function EmpleadoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}