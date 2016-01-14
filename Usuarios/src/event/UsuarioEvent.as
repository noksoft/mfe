package event
{
	import flash.events.Event;

	public class UsuarioEvent extends Event
	{
		public static const SAVE_USUARIO_EVENT:String = "SaveUsuarioEvent";
		public static const UPDATE_USUARIO_EVENT:String = "UpdateUsuarioEvent";
		public static const DELETE_USUARIO_EVENT:String = "DeleteUsuarioEvent";

		public function UsuarioEvent(typeEvent:String)
		{
			super(typeEvent, true, true);
		}
	}
}