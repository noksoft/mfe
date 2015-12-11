package com.actioninteractive.nok.vo
{
	[Bindable]
	public class NotificationVO
	{
		/**
		 * Contiene la prioridad de la notificacion 
		 */
		public var priority:int = Math.ceil(Math.random() * 3);
		
		/**
		 * Contiene el mensaje de la notificacion 
		 */
		public var message:String = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam";
		
		public var section:String = "Maintenance";
		
		public var portlet:String = "Employee work log";
		
		public function NotificationVO()
		{
		}
	}
}