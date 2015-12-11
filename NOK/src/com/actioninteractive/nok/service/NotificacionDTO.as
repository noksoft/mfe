package com.actioninteractive.nok.service
{
	[RemoteClass(alias="mx.com.nok.notificacion.model.dto.NotificacionDTO")]
	public class NotificacionDTO {
		
		public function NotificacionDTO()
		{
		}
		
		public var idNotificacion:String; 
		public var descripcion:String;
		public var labelMin:String;
		public var idConfig:String;
		public var fechaNotificacion:String;
		public var estatusNotificacion:int;
		public var idUsuario:String;
	}
}