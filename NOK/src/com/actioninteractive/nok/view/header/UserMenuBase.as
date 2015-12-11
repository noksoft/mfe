package com.actioninteractive.nok.view.header
{
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.model.CommonModel;
	
	import mx.managers.PopUpManager;
	
	import spark.components.Application;
	import spark.components.Group;
	
	public class UserMenuBase extends Group
	{
		private var view:UserMenu = UserMenu(this);
		private var notificationsMenu:NotificationsMenu;
		
		[Bindable]
		protected var showNotificationsMenu:Boolean = false;
		
		[Inject]
		[Bindable]
		public var commonModel:CommonModel;
		
		public function UserMenuBase()
		{
			super();
		}
		
		protected function showNotifications():void{
			if(commonModel.notificationsList.length > 0){
				if(notificationsMenu == null){
					notificationsMenu = new NotificationsMenu();
					notificationsMenu.notificationsList = commonModel.notificationsList;
					
					relocateNotificationsMenu();
				}else{
					relocateNotificationsMenu();
				}
				
				if(!notificationsMenu.showEffectIsPlaying){
					if(showNotificationsMenu){
						showNotificationsMenu = false;
						
						notificationsMenu.removeEventListener(CommonEvent.HIDE_NOTIFICATIONS_MENU_EVENT, hideNotifications);
						PopUpManager.removePopUp(notificationsMenu);
						notificationsMenu.visible = false;
					}else{
						showNotificationsMenu = true;
						
						notificationsMenu.addEventListener(CommonEvent.HIDE_NOTIFICATIONS_MENU_EVENT, hideNotifications);
						PopUpManager.addPopUp(notificationsMenu, this, false);
						notificationsMenu.visible = true;
					}
				}
			}
			
		}
		
		public function hideNotifications(e:CommonEvent):void{
			showNotificationsMenu = false;
			notificationsMenu.visible = false;
			PopUpManager.removePopUp(notificationsMenu);
		}
		
		private function relocateNotificationsMenu():void{
			notificationsMenu.x = this.parentApplication.width - 185 - notificationsMenu.width;
			notificationsMenu.y = 13;
		}
		
		protected function showSettings():void{
			
		}
	}
}