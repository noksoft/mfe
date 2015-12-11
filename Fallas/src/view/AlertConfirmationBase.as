/*	
Copyright © 2015 Action IT. ALL RIGHTS RESERVED.
This file contains proprietary and ActionIT CONFIDENTIAL Information.
Use, disclosure or reproduction is prohibited.

@filename AlertConfirmationBase.as
@created on 18/03/2015
@author rzaragoza
@version 1.0
*/
package view
{	
	import event.CommonEvent;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	
	import mx.containers.VBox;
	import mx.core.Application;
	import mx.core.mx_internal;
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	public class AlertConfirmationBase extends TitleWindow
	{
		public function AlertConfirmationBase()
		{	
		}
		
		//public var view:AlertConfirmation = AlertConfirmation(this);
		
		[Bindable]
		public var message:String = "¿Estás seguro de realizar esto?";
		[Bindable]
		public var title_window:String = "Por favor Confirma!";
		[Bindable]
		public var customAlertWidth:int = 400;
		[Bindable]
		public var customAlertHeight:int = 300;
		
		
		public function init():void{
			PopUpManager.centerPopUp(this);			
		}
		
		public function setResponse(value:String):void{					
			closeMe();
		}
		
		public function closeMe():void{
			PopUpManager.removePopUp(this);
		}
		
		public function newCustomAlert(alertTitle:String, alertMessage:String, ctmWidth:int, ctmHeight:int):void{
			message = alertMessage;
			title_window = alertTitle;
			customAlertWidth = ctmWidth;
			customAlertHeight = ctmHeight;
		}
		
		public function setCustomAlertResponse():void{
			var commonEventContainer:CommonEvent = new CommonEvent(CommonEvent.CUSTOM_ALERT_ACCEPTED_EVENT);
			dispatchEvent(commonEventContainer);
			callLater(closeMe);
		}
		
		public function setCustomAlertResponseNegative():void{
			var commonEventContainer:CommonEvent = new CommonEvent(CommonEvent.CUSTOM_ALERT_DENIED_EVENT);
			dispatchEvent(commonEventContainer);
			callLater(closeMe);
		}
		
	}
	
}