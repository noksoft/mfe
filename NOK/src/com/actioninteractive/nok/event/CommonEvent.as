package com.actioninteractive.nok.event
{
	import com.actioninteractive.nok.service.UsuarioDTO;
	import com.actioninteractive.nok.view.body.portlet.Portlet;
	import com.actioninteractive.nok.vo.PortletVO;
	import com.actioninteractive.nok.vo.SectionVO;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	public class CommonEvent extends Event
	{
		public static const MOUSE_CLICKED_IN_STAGE_EVENT:String = "mouseClickedInStageEvent";
		public static const SECTION_CLICKED_EVENT:String = "sectionClickedEvent";
		public static const HIDE_NOTIFICATIONS_MENU_EVENT:String = "hideNotificationsMenuEvent";
		public static const HIDE_LOGIN_MENU_EVENT:String = "hideLoginMenuEvent";
		public static const USER_TRY_LOGIN_EVENT:String = "userTryLoginEvent";
		public static const USER_LOGIN_EVENT:String = "userLoginEvent";
		public static const USER_LOGOUT_EVENT:String = "userLogoutEvent";
		public static const USER_SAVE_SECTION_PORTLETS_EVENT:String = "userSaveSectionPortletsEvent";
		
		public static const PORTLET_FADE_OUT_EVENT:String = "portletFadeOutEvent";
		public static const PORTLET_FADE_IN_EVENT:String = "portletFadeInEvent";
		public static const PORTLET_DROPPED_IN_CONTAINER_EVENT:String = "portletDroppedInContainerEvent";
		public static const PORTLET_SIZE_CHANGED_EVENT:String = "portletSizeChangedEvent";
		public static const PORTLET_CHANGE_POSITION_EVENT:String = "portletChangePositionEvent";
		public static const PORTLET_CREATED_EVENT:String = "portletCreatedEvent";
		public static const PORTLET_REPLACE_EVENT:String = "portletReplaceEvent";
		public static const PORTLET_REMOVE_EVENT:String = "portletRemoveEvent";
		
		/** CONFIGURACIÓN DE USUARIO **/
		public static const SAVE_PASSWORD_USER_SETTING_EVENT:String = "savePasswordUserSettingEvent";
		
		public var section:SectionVO;
		public var portlet:PortletVO;
		
		public var portletOver:Portlet;
		public var portletMoved:Portlet;
		
		public var user:UsuarioDTO;
		public var portletDroppedInContainer:UIComponent;
		public var mouseEvent:MouseEvent;
		public var logoutInactividad:Boolean = false;
		public var newPassword:String = "";
		
		public function CommonEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}