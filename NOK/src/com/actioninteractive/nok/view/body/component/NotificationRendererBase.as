package com.actioninteractive.nok.view.body.component
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.view.AssetManager;
	import com.actioninteractive.nok.vo.NotificationVO;
	
	import spark.components.HGroup;
	
	public class NotificationRendererBase extends HGroup
	{
		private var _datasource:NotificationVO;
		
		[Bindable]
		/**
		 * Contiene el icono que sera mostrado en la prioridad 
		 * 
		 */
		protected var priorityIcon:Class;
		
		public function NotificationRendererBase()
		{
			super();
		}

		[Bindable]
		public function get datasource():NotificationVO
		{
			return _datasource;
		}

		public function set datasource(value:NotificationVO):void
		{
			_datasource = value;
			
			if(value.priority == NokConstants.NOTIFICATION_PRIORITY_HIGH){
				priorityIcon = AssetManager.notificationPriorityHighSkin;
			}else if(value.priority == NokConstants.NOTIFICATION_PRIORITY_MEDIUM){
				priorityIcon = AssetManager.notificationPriorityMediumSkin;
			}else if(value.priority == NokConstants.NOTIFICATION_PRIORITY_LOW){
				priorityIcon = AssetManager.notificationPriorityLowSkin;
			}
		}

	}
}