package com.actioninteractive.nok.view.header
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.model.CommonModel;
	import com.actioninteractive.nok.service.UsuarioDTO;
	import com.actioninteractive.nok.view.AssetManager;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.managers.PopUpManager;
	
	import spark.components.Group;
	import spark.components.TextInput;
	
	public class LoginMenuBase extends Group
	{
		private var closeTimer:Timer = new Timer(3000, 1);
		private var view:LoginMenu = LoginMenu(this);
		[Bindable]protected var flagSettingsButton:Boolean = false;
		
		[Bindable]
		protected var showLogin:Boolean = false;
		
		[Bindable]
		protected var userLoginButtonIcon:Class = AssetManager.userLoginButtonSkin;
		
		[Bindable]
		protected var userLoginButtonLabel:String = NokConstants.BUTTON_LABEL_LOGIN;
		
		[Bindable]
		public var userName:String;
		
		[Inject]
		[Bindable]
		public var commonModel:CommonModel;
		
		public function LoginMenuBase()
		{
			super();
			closeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, closeTimerEnd);
		}
		
		protected function closeTimerStart():void{
			closeTimer.start();
		}
		
		protected function closeTimerReset():void{
			closeTimer.reset();
			closeTimer.stop();
		}
		
		protected function closeTimerEnd(e:TimerEvent):void{
			closeTimer.stop();
			closeTimer.reset();
			
			if(showLogin){
				showLogin = false;
				
				this.height = 26;
			}
		}
		
		/**
		 * Usado para mostrar u ocultar la ventana del login 
		 * 
		 */
		protected function showLoginOptions():void{
			if(showLogin){
				showLogin = false;
				
				this.height = 26;
			}else{
				showLogin = true;
				
				if(commonModel.isLoggedIn){
					this.height = 110;
				}else{
					this.height = 127;
				}
				
				this.setFocus();
			}
		}
		
		/**
		 * Usado para manejar el text que sale cuando el usuario no ha ingresado nada 
		 * @param input
		 * @param promptText
		 * 
		 */
		protected function textInputClicked(input:TextInput, promptText:String = ""):void{
			if(input.text == promptText){
				input.text = "";
			}
			input.setStyle("color", 0xCCCCCC);
		}
		
		/**
		 * Usado para manejar el text que sale cuando el usuario no ha ingresado nada 
		 * @param input
		 * @param promptText
		 * 
		 */
		protected function textInputLoseFocus(input:TextInput, promptText:String = ""):void{
			if(input.text.length == 0){
				input.text = promptText;
				input.setStyle("color", 0x666666);
			}
		}
		
		/**
		 * Detecta cuando el usuario ha realizado una modificacion y verifica
		 * si se debe activar el boton 
		 * 
		 */
		protected function textInputChanged():void{
			if(view.usernameInput.text.length > 0 && view.passwordInput.text.length > 0){
				if(view.usernameInput.text != NokConstants.USERNAME_INPUT_TEXT && view.passwordInput.text != NokConstants.PASSWORD_INPUT_TEXT){
					view.loginButton.enabled = true;
				}else{
					view.loginButton.enabled = false;
				}
			}else{
				view.loginButton.enabled = false;
			}
		}
		
		/**
		 * Envia los datos del usuario para probar el login 
		 * 
		 */
		protected function tryLogin():void{
			if(view.loginButton.label == NokConstants.BUTTON_LABEL_LOGIN){
				var event:CommonEvent = new CommonEvent(CommonEvent.USER_TRY_LOGIN_EVENT);
				var user:UsuarioDTO = new UsuarioDTO();
				user.usuario = view.usernameInput.text;//'ZAOC810304NM0';//view.usernameInput.text;
				user.pass = view.passwordInput.text;
				
				event.user = user;
				
				this.dispatchEvent(event);
			}else{
				dispatchEvent(new CommonEvent(CommonEvent.USER_LOGOUT_EVENT));
			}
		}
		
		/**
		 * Función que muestra el popup para cambiar la configuración del usuario
		 */
		protected function changeSettingsUser ():void{
			if(!flagSettingsButton){
				flagSettingsButton = true;
				
				var _popUpSettingUser:PopUpChangeUserSettings = new PopUpChangeUserSettings();
				_popUpSettingUser.title = "Cambio de contraseña";
				_popUpSettingUser.width = 240;
				_popUpSettingUser.height = 180;
				
				PopUpManager.addPopUp(_popUpSettingUser, parent.parent, true);
				PopUpManager.centerPopUp(_popUpSettingUser);
			}else{
				flagSettingsButton = false;
			}
			
			
		}
		
		[EventHandler(event="CommonEvent.USER_LOGIN_EVENT")]
		public function userLoggedIn():void{
			showLogin = false;
			this.height = 26;
			
			userLoginButtonIcon = AssetManager.userLogoutButtonSkin;
			userLoginButtonLabel = NokConstants.BUTTON_LABEL_LOGOUT;
		}
		
		[EventHandler(event="CommonEvent.USER_LOGOUT_EVENT")]
		public function userLoggedOut():void{
			showLogin = false;
			this.height = 26;
			
			userLoginButtonIcon = AssetManager.userLoginButtonSkin;
			userLoginButtonLabel = NokConstants.BUTTON_LABEL_LOGIN;
				
			view.usernameInput.text = "";
			view.passwordInput.text = "";
			textInputLoseFocus(view.usernameInput, NokConstants.USERNAME_INPUT_TEXT);
			textInputLoseFocus(view.passwordInput, NokConstants.PASSWORD_INPUT_TEXT);
			textInputChanged();
		}
	}
}