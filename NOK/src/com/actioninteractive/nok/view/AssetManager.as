package com.actioninteractive.nok.view
{
	[Bindable]
	/**
	 * Contiene variables estaticas de todos los assets usados en la aplicacion 
	 * @author Ing Carlos
	 * 
	 */
	public class AssetManager
	{
		//Main App skins
		[Embed(source='assets/images/background_image.png')]
		public static var mainAppBackgroundSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='background')]
		public static var mainAppBackgroundOverlaySkin:Class;
		//Main App skins
		
		//Header skins
		[Embed(source='assets/maqzar_assets.swf', symbol='hd_background')]
		public static var headerBackgroundSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='hd_LogoArea')]
		public static var headerLogoSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='toolbar_wrapper')]
		public static var headerToolbarSkin:Class;
		//Header skins
		
		//User Menu skins
		[Embed(source='assets/maqzar_assets.swf', symbol='toolbar_userWrapper')]
		public static var userMenuSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='toolbar_alerts')]
		public static var userAlertsSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='toolbar_btn_user')]
		public static var userButtonSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='toolbar_btn_arrow')]
		public static var userArrowSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='toolbar_userWrapperOpened')]
		public static var userLoginSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='user_iconLogin')]
		public static var userLoginButtonSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='user_iconLogout')]
		public static var userLogoutButtonSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='user_iconProfile')]
		public static var userProfileButtonSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='user_iconSettings')]
		public static var userSettingsButtonSkin:Class;
		//User Menu skins
		
		//Notification Skins
		[Embed(source='assets/maqzar_assets.swf', symbol='msg_container')]
		public static var userNotificationSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='msg_greenPin')]
		public static var notificationPriorityLowSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='msg_yellowPin')]
		public static var notificationPriorityMediumSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='msg_redPin')]
		public static var notificationPriorityHighSkin:Class;
		//Notification Skins
		
		//Settings Menu Skins
		[Embed(source='assets/maqzar_assets.swf', symbol='toolbar_btn_settings')]
		public static var settingsButtonSkin:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='toolbar_settingsWraper')]
		public static var settingsMenuSkin:Class;
		//Settings Menu Skins
		
		//Scroll bar skins
		[Embed(source='assets/maqzar_assets.swf', symbol='scroll_bg_hor')]
		public static var horizontalTrackSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='scroll_bar_hor')]
		public static var horizontalThumbSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='scroll_bg')]
		public static var verticalTrackSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='scroll_bar')]
		public static var verticalThumbSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='scroll_intersection')]
		public static var scrollIntersectionSkin:Class;
		//Scroll bar skins
		
		//Button Skins
		[Embed(source='assets/maqzar_assets.swf',symbol='hd_btn_show_up')]
		public static var portletMenuButtonShowUpSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf',symbol='hd_btn_show_hover')]
		public static var portletMenuButtonShowOverSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf',symbol='hd_btn_hide_up')]
		public static var portletMenuButtonHideUpSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf',symbol='hd_btn_hide_hover')]
		public static var portletMenuButtonHideOverSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf',symbol='hd_button_up')]
		public static var sectionButtonUpSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf',symbol='hd_button_down')]
		public static var sectionButtonDownSkin:Class;
		//Button Skins
		
		//Portlet skins
		[Embed(source='assets/maqzar_assets.swf', symbol='hd_imgCont')]
		public static var portletMiniSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='hd_imgCont_plus')]
		public static var portletMiniAddButtonSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='portlet_empty')]
		public static var portletEmptySkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='portletnoSettings')]
		public static var portletSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='portletMaxL')]
		public static var portletButtonMaximizeLeftSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='maximizarD')]
		public static var portletButtonMaximizeRightSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='portletRestoring')]
		public static var portletButtonFullScreenSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='portlet4dist')]
		public static var portletButtonRestoreSkin:Class;
		//Portlet skins
		
		//Text Input Skin
		[Embed(source='assets/maqzar_assets.swf', symbol='input_text')]
		public static var textInputSkin:Class;
		//Text Input Skin
		
		//Popup skins
		[Embed(source='assets/maqzar_assets.swf', symbol='popUp_container')]
		public static var popupContentSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='popUp_blackHeader')]
		public static var popupTitleSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='popUp_btnClose')]
		public static var popupCloseButtonSkin:Class;
		//Popup skins
		
		//TEST PORTLETS
		[Embed(source='assets/images/test/reparaciones.png')]
		public static var testPortletReparaciones:Class;
		
		[Embed(source='assets/images/test/reporte_mensual.png')]
		public static var testPortletReporteMensual:Class;
		//TEST PORTLETS
		
		public function AssetManager()
		{
		}
	}
}