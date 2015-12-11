package com.actioninteractive.nok.constant
{
	/**
	 * Contiene todas las constantes utilizadas en la aplicacion 
	 * @author Ing Carlos
	 * 
	 */
	[Bindable]
	public class NokConstants
	{
		/**
		 * Todas las constantes relacionadas con los servicios 
		 */
		//public static var SERVICE_URL:String = "http://54.214.253.51:8080/nok/messagebroker/amf";  //SERVER AMAZON
		public static var SERVICE_URL:String = "http://localhost:8080/nok/messagebroker/amf";
		//public static var SERVICE_URL:String = "http://107.170.49.102:8080/nok/messagebroker/amf";
		//public static var SERVICE_URL:String = "http://127.0.0.1:8080/nok/messagebroker/amf";
		//public static var SERVICE_URL:String = "http://localhost:8080/messagebroker/amf";
		public static var SERVICE_DESTINATION_LOGIN:String   = "loginBusiness";
		public static var SERVICE_DESTINATION_PORTLET:String = "portletBusiness";
		public static var SERVICE_DESTINATION_CRUD:String    = "articuloBusiness";
		public static var SERVICE_DESTINATION_FALLA:String    = "fallaBusiness";
		public static var SERVICE_DESTINATION_CATEGORIA:String    = "categoriaBusiness";
		public static var SERVICE_DESTINATION_NOTIFICATION:String    = "notificacionBusiness";
		public static var SERVICE_DESTINATION_OBRA:String    = "obraBusiness";
		public static var SERVICE_DESTINATION_EMPLEADO:String    = "empleadoBusiness";
		public static var SERVICE_DESTINATION_TIPO_EMPLEADO:String    = "tipoempeladoBusiness";
		public static var SERVICE_DESTINATION_DIRECCION:String    = "direccionBusiness";
		public static var SERVICE_DESTINATION_EQUIPO:String = "equipoBusiness";		
		
		/**
		 * Los tamaños de portlet disponibles 
		 */
		public static var PORTLET_SIZE_HIDDEN:String      = "0";
		public static var PORTLET_SIZE_MINI:String        = "1/12";
		public static var PORTLET_SIZE_NORMAL:String      = "1/4";
		public static var PORTLET_SIZE_MAXIMIZED:String   = "3/4";
		public static var PORTLET_SIZE_FULL_SCREEN:String = "1";
		
		/**
		 * Las posiciones disponibles para los portlets 
		 */
		public static var PORTLET_POSITION_UPPER_LEFT:int  = 1;
		public static var PORTLET_POSITION_LOWER_LEFT:int  = 2;
		public static var PORTLET_POSITION_UPPER_RIGHT:int = 3;
		public static var PORTLET_POSITION_LOWER_RIGHT:int = 4;
		public static var PORTLET_POSITION_NOT_SET:int = -1;
		
		/**
		 * Los niveles de prioridad para notificaciones
		 */
		public static var NOTIFICATION_PRIORITY_HIGH:int   = 1;
		public static var NOTIFICATION_PRIORITY_MEDIUM:int = 2;
		public static var NOTIFICATION_PRIORITY_LOW:int    = 3;
		
		public static var USERNAME_INPUT_TEXT:String = "Usuario o Correo";
		public static var PASSWORD_INPUT_TEXT:String = "Contraseña";
		
		public static var BUTTON_LABEL_LOGIN:String  = "Login";
		public static var BUTTON_LABEL_LOGOUT:String = "Logout";
		public static var BUTTON_LABEL_PASSWORD:String = "Cambiar Clave";
		
		public function NokConstants()
		{
		}
	}
}