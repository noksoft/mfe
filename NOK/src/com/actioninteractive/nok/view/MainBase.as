package com.actioninteractive.nok.view
{
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.model.CommonModel;
	import com.actioninteractive.nok.view.body.component.CustomPopup;
	import com.actioninteractive.nok.view.body.component.TestPopup;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	
	import spark.components.SkinnableContainer;
	
	public class MainBase extends SkinnableContainer
	{
		private var inactivityTimer:Timer = new Timer(900000,1);
		
		[Inject]
		[Bindable]
		public var commonModel:CommonModel;
		
		public static const application_version:String = "1.0.0001";
		
		public function MainBase()
		{
			super();
			inactivityTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerEnd);
		}
		
		/**
		 * Dispara el evento que ejecuta el servicio del logout 
		 * @param e El evento del temporizador
		 * 
		 */
		private function timerEnd(e:TimerEvent):void{
			if(commonModel.isLoggedIn){
				var ev:CommonEvent = new CommonEvent(CommonEvent.USER_LOGOUT_EVENT);
				ev.logoutInactividad = true;
				this.dispatchEvent(ev);
			}
		}
		
		/**
		 * Reinicia el conteo que hace el logout por inactividad 
		 * 
		 */
		protected function mouseMoved():void{
			inactivityTimer.stop();
			inactivityTimer.reset();
			inactivityTimer.start();
		}
		
		/**
		 * Dispara un evento en toda la aplicacion para detectar clicks del mouse
		 * @param e El evento generado por el click
		 * 
		 */
		protected function mouseClicked(e:MouseEvent):void{
			var ev:CommonEvent = new CommonEvent(CommonEvent.MOUSE_CLICKED_IN_STAGE_EVENT);
			ev.mouseEvent = e;
			
			this.dispatchEvent(ev);
		}
	}
}