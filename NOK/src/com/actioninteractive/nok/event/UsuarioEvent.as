package com.actioninteractive.nok.event
{
	import com.actioninteractive.nok.service.UsuarioDTO;
	
	import flash.events.Event;
	
	public class UsuarioEvent extends Event
	{
		public static const EVENT_GET_PERFILES:String   = "eventGetPerfiles";
		public static const EVENT_INSERT_USUARIO:String = "eventInsertUsuario";
		public static const EVENT_UPDATE_USUARIO:String = "eventUpdateUsuario";
		public static const EVENT_DELETE_USUARIO:String = "eventDeleteUsuario";
		
		public var _userDTO:UsuarioDTO = new UsuarioDTO();
		
		public function UsuarioEvent(type:String)
		{
			super(type, true, true);
		}
	}
}