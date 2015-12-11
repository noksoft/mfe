package com.actioninteractive.nok.view.header
{
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.model.CommonModel;
	import com.actioninteractive.nok.view.body.component.NotificationRenderer;
	import com.actioninteractive.nok.vo.NotificationVO;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.SkinnableContainer;
	
	public class NotificationsMenuBase extends SkinnableContainer
	{
		private var view:NotificationsMenu = NotificationsMenu(this)
		private var _notificationsList:ArrayCollection
		
		public var showEffectIsPlaying:Boolean = false;
		
		public function NotificationsMenuBase()
		{
			super();
		}
		
		public function createNotifications():void{
			view.notificationsGroup.removeAllElements();
			
			for each(var notification:NotificationVO in notificationsList){
				var renderer:NotificationRenderer = new NotificationRenderer();
				renderer.datasource = notification;
				
				view.notificationsGroup.addElement(renderer);
			}
		}
		
		protected function hideMe():void{
			dispatchEvent(new CommonEvent(CommonEvent.HIDE_NOTIFICATIONS_MENU_EVENT));
		}
		
		protected function effectStart():void{
			showEffectIsPlaying = true;
		}
		protected function effectEnd():void{
			showEffectIsPlaying = false;
			this.setFocus();
		}
		
		[Bindable]
		public function get notificationsList():ArrayCollection
		{
			return _notificationsList;
		}

		public function set notificationsList(value:ArrayCollection):void
		{
			_notificationsList = value;
			
			if(view.notificationsGroup != null){
				createNotifications();
			}
		}

	}
}