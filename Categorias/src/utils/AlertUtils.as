package utils
{
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import views.AlertConfirmation;
	import views.AlertError;
	import views.AlertNotice;

	public class AlertUtils
	{
		public function AlertUtils()
		{
		}
		
		public static function showConfirmation(alertTitle:String, alertMessage:String, alertWidth:int=340, alertHeight:int=155):void{			
			var customAlertConfirmation:AlertConfirmation = new AlertConfirmation();
			customAlertConfirmation.newCustomAlert(alertTitle, alertMessage, alertWidth, alertHeight);
			PopUpManager.addPopUp(customAlertConfirmation, DisplayObject(FlexGlobals.topLevelApplication),true);			
		}
		
		public static function showErrorMessage(alertTitle:String, alertMessage:String, alertWidth:int=240, alertHeight:int=220, buttonLabel:String="OK"):void{
			var customErrorAlert:AlertError = new AlertError();
			customErrorAlert.newCustomError(alertTitle, alertMessage, alertWidth,alertHeight, buttonLabel);
			PopUpManager.addPopUp(customErrorAlert, DisplayObject(FlexGlobals.topLevelApplication),true);		
		}
		
		public static function showNoticeMessage(alertTitle:String,alertMessage:String,alertNoticeWidth:int=240,alertNoticeHeight:int=220,alertOKLabel:String="OK"):void{
			var customNoticeAlert:AlertNotice = new AlertNotice();
			customNoticeAlert.newCustomNotice(alertTitle, alertMessage, alertNoticeWidth, alertNoticeHeight, alertOKLabel);
			PopUpManager.addPopUp(customNoticeAlert, DisplayObject(FlexGlobals.topLevelApplication),true);		
		}
	}
}