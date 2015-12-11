package view
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	import utils.EnvironmentUtil;
	
	public class AlertErrorBase extends TitleWindow
	{
		public function AlertErrorBase()
		{
			super();
		}
		
		private var view:AlertError = AlertError(this);
		
		[Bindable]
		public var title_window:String;
		[Bindable]
		public var errorMessage:String;
		[Bindable]
		public var alertWidth:int;
		[Bindable]
		public var alertHeight:int;
		[Bindable]
		public var buttonLabel:String;
		public var validUser:Boolean = true;
		
		public function init():void{
			PopUpManager.centerPopUp(this);
		}
		
		public function newCustomError(windowTitle:String, message:String, errorAlertWidth:int, errorAlertHeight:int, OKLabel:String):void{
			title_window = windowTitle;
			errorMessage = message;
			alertWidth = errorAlertWidth;
			alertHeight = errorAlertHeight;
			buttonLabel = OKLabel;
		}
		
		public function closeMe():void{		
			PopUpManager.removePopUp(this);
		}
		
		public function goToLogInPage():void{
			/*var loginPage:String = EnvironmentUtil.getEnvironment();
			var lIndexOf:int = loginPage.indexOf(EnvironmentUtil.AMF_FILE);
			var random:int = Math.random() * 100;
			
			if(lIndexOf > -1){
				loginPage = loginPage.substr(0, lIndexOf);
			}
			
			if(validUser){
				navigateToURL(new URLRequest(loginPage + "?" + random), "_self");
			}else{
				navigateToURL(new URLRequest("http://localhost:8080/nok/error"), "_self");
			}
			*/
			callLater(closeMe);
		}
	}
}