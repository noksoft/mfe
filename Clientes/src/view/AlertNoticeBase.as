package view
{
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	public class AlertNoticeBase extends TitleWindow
	{
		public function AlertNoticeBase()
		{
		}
		
		private var view:AlertNotice = AlertNotice(this);
		
		[Bindable]
		public var noticeMessage:String;
		[Bindable]
		public var title_window:String;
		[Bindable]
		public var alertWidth:int;
		[Bindable]
		public var alertHeight:int;
		[Bindable]
		public var OKLabel:String;
		
		
		public function init():void{
			PopUpManager.centerPopUp(this);
		}
		
		public function closeMe():void{		
			PopUpManager.removePopUp(this);
		}
		
		public function newCustomNotice(windowTitle:String,message:String,alertNoticeWidth:int,alertNoticeHeight:int,alertOKLabel:String):void{
			title_window = windowTitle;
			noticeMessage = message;
			alertWidth = alertNoticeWidth;
			alertHeight = alertNoticeHeight;
			OKLabel = alertOKLabel;
		}
	}
}