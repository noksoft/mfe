package com.actioninteractive.nok.view
{
	[Bindable]
	/**
	 * Contiene variables estaticas de todos los assets usados en la aplicacion 
	 * @author Ing. Carlos Zaragoza
	 * 
	 */
	public class AssetManagerIn
	{
		
		//Header skins
		[Embed(source='assets/maqzar_assets.swf', symbol='porlet_header1')]
		public static var portletHeader1Skin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='porlet_header2')]
		public static var portletHeader2Skin:Class;
		//Text Input Skin
		[Embed(source='assets/maqzar_assets.swf', symbol='input_text_w')]
		public static var textInputWhiteSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_btnclose')]
		public static var gridBtnCloseSkin:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='icon_add')]
		public static var iconAddSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_btnscroll')]
		public static var verticalThumbSkin:Class;
		/*[Embed(source='assets/maqzar_assets.swf', symbol='grid_bgscroll')]*/
		public static var verticalTrackSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='btn_gray')]
		public static var buttonGraySkin:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='btn_gray_hover')]
		public static var buttonGrayHoverSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='date_btnnext')]
		public static var buttonDateNextSkin:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='date_btnback')]
		public static var buttonDateBackSkin:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='date_wrapper')]
		public static var dateWrapper:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_bgscroll_h')]
		public static var horizontalTrackSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_btnscroll_h')]
		public static var horizontalThumbSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='add_photo')]
		public static var imagenButtonSkin:Class;

		[Embed(source='assets/maqzar_assets.swf', symbol='gray_container')]
		public static var GridContainerSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='portletGrid_divider')]
		public static var portletGridDivider:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_header_days')]
		public static var gridHeaderDays:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_header1')]
		public static var gridHeader1:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_header2')]
		public static var gridHeader2:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_reportFail')]
		public static var gridReportFail:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_btnclose')]
		public static var gridBtnClose:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_selectHover')]
		public static var gridSelectHover:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_baclkComment')]
		public static var gridBlackComment:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_orangeComment')]
		public static var gridOrangeComment:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_greenComment')]
		public static var gridGreenComment:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_yellowComment')]
		public static var gridYellowComment:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='grid_blueComment')]
		public static var gridBlueComment:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='btn_numStep_up')]
		public static var buttonNumericStepperIncrement:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='btn_numStep_up_hover')]
		public static var buttonNumericStepperIncrementHover:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='btn_numStep_down')]
		public static var buttonNumericStepperDecrement:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='btn_numStep_down_hover')]
		public static var buttonNumericStepperDecrementHover:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='arrowDown')]
		public static var buttonArrowDownSkin:Class;
		
		[Embed(source='assets/maqzar_assets.swf', symbol='icon_zoom')]
		public static var iconZoom:Class;
		
		//TEST PORTLETS
		[Embed(source='assets/images/test/fletes.png')]
		public static var testPortletFletes:Class;//TEST PORTLETS
		[Embed(source='assets/images/test/obras.png')]
		public static var testPortletObras:Class;//TEST PORTLETS
		[Embed(source='assets/images/test/taller.png')]
		public static var testPortletTaller:Class;
		[Embed(source='assets/images/test/obras.png')]
		public static var testPortletResguardoEmpleado:Class;//TEST PORTLETS
		
		//Buttons Next and Back
		[Embed(source='assets/maqzar_assets.swf', symbol='date_btnback')]
		public static var iconButtonBack:Class;
		[Embed(source='assets/maqzar_assets.swf', symbol='date_btnnext')]
		public static var iconButtonNext:Class;
		
		public function AssetManagerIn()
		{
		}
	}
}