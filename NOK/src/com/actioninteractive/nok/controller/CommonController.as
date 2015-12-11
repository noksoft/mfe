package com.actioninteractive.nok.controller
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.delegate.CommonService;
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.model.CommonModel;
	import com.actioninteractive.nok.service.NotificacionDTO;
	import com.actioninteractive.nok.service.SectionDTO;
	import com.actioninteractive.nok.service.UsuarioDTO;
	import com.actioninteractive.nok.util.Tools;
	import com.actioninteractive.nok.view.body.portlet.Portlet;
	import com.actioninteractive.nok.vo.NotificationVO;
	import com.actioninteractive.nok.vo.PortletVO;
	import com.actioninteractive.nok.vo.SectionVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	public class CommonController extends AbstractController
	{
		private var commonService:CommonService = new CommonService();
		private var tempPassword:String = "";
		
		[Inject]
		public var commonModel:CommonModel;
		
		
		public function CommonController()
		{
			super();
		}
		
		[PostConstruct]
		public function init():void{
			var sectionList:ArrayCollection = new ArrayCollection();
			var section:SectionVO;
			
			section = new SectionVO();
			section.id = 0;
			section.index = 0;
			section.name = "Home";
			section.label = "HOME";
			section.selected = true;
			sectionList.addItem(section);
			
			var emptyPortlet1:PortletVO = new PortletVO();
			var emptyPortlet2:PortletVO = new PortletVO();
			
			emptyPortlet1.id_config = 1;
			emptyPortlet1.componente_class = "com.actioninteractive.nok.view.body.portlet.CatalogoEmpleados";
			emptyPortlet1.nombre_submenu = "Gesitón de empleados";
			emptyPortlet1.posicion = NokConstants.PORTLET_POSITION_UPPER_LEFT;
			//emptyPortlet1.main_posicion = NokConstants.PORTLET_SIZE_FULL_SCREEN;
			emptyPortlet1.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
			
			emptyPortlet2.id_config = 2;
			emptyPortlet2.componente_class = "com.actioninteractive.nok.view.body.portlet.CatalogoPerfiles";
			emptyPortlet2.nombre_submenu = "Usuarios del sistema";
			emptyPortlet2.posicion = NokConstants.PORTLET_POSITION_UPPER_RIGHT;
			emptyPortlet2.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
			
			//section.portletList.addItem(emptyPortlet1);
			section.portletList.addItem(emptyPortlet2);
			
			commonModel.sectionList = sectionList;
		}
		
		
		/**
		 * Llama el servicio para cambiar el password del usuario
		 * @newPassword propiedad que contiene el nuevo password
		 */
		[EventHandler(event="CommonEvent.SAVE_PASSWORD_USER_SETTING_EVENT", properties="newPassword")]
		public function updateUser(_newPassword:String):void{
			trace("_newPassword: " + _newPassword);
			tempPassword = _newPassword;
			commonModel.currentUser.pass = _newPassword;
			executeServiceCall(commonService.updateUser(commonModel.currentUser), handlerChangePassword, faultChangePaswword);
		}
		
		/**
		 * Handler service changePaswword user
		 */
		private function handlerChangePassword (_event:ResultEvent):void{
			try{
				if((_event.result != null)){
					trace(_event.result);
					trace("Se actualizó la contraseña del usuario.");
				}else{
					commonModel.currentUser.pass = tempPassword;
				}
			}catch(e:Error){
				trace(e.message);
				commonModel.currentUser.pass = tempPassword;
			}
		}
		
		/**
		 * Fault event service changePassword user
		 */
		private function faultChangePaswword (_event:FaultEvent):void{
			commonModel.currentUser.pass = tempPassword;
			trace(_event.message);
		}
		
		/**
		 * Llama el servicio para obtener los datos del usuario actual  
		 * 
		 */
		[EventHandler(event="CommonEvent.USER_TRY_LOGIN_EVENT", properties="user")]
		public function getCurrentUser(usuario:UsuarioDTO):void{
			//var user:UsuarioDTO = new UsuarioDTO();
			//user.usuario = "ZAOC810304NM0";
			//user.pass = "carast";
			
			executeServiceCall(commonService.userLogin(usuario),getCurrentUserResult,getCurrentUserFault);
		}
		
		/**
		 * Maneja el resultado del servicio que obtiene los datos del usuario 
		 * @param e El evento con los resultados del servicio
		 * 
		 */
		public function getCurrentUserResult(e:ResultEvent):void{
			if(e.result.status){
				dispatcher.dispatchEvent(new CommonEvent(CommonEvent.USER_LOGIN_EVENT));
				commonModel.isLoggedIn = true;
				
				commonModel.currentUser = UsuarioDTO(e.result);
				
				getSections();
			}else{
				if(UsuarioDTO(e.result).errorLogin != ""){
					Alert.show("El usuario o contraseña son incorrectos.", "Aviso");
				}else{
					Alert.show("Error al acceder a sesión.", "Aviso");
				}
			}
			
			//Alert.show("Se ha iniciado sesion con exito.", "Aviso");
		}
		
		/**
		 * Maneja cuando hay un error en el servicio que obtiene los datos del usuario
		 * @param e El error con los detalles de porque falló el servicio
		 * 
		 */		
		public function getCurrentUserFault(e:FaultEvent):void{
			try{
				Alert.show("Hubo un problema al intentar iniciar sesion", "Aviso");
			}catch(e:Error){
				Alert.show("Hubo un problema al intentar iniciar sesion", "Aviso");
			}
		}
		
		[EventHandler(event="CommonEvent.USER_LOGOUT_EVENT")]
		public function logoutUser(e:CommonEvent):void{
			if(e.logoutInactividad){
				Alert.show("Se ha terminado la sesion por inactividad", "Aviso");
			}else{
				Alert.show("Se ha cerrado la sesion con éxito", "Aviso");
			}
			
			var sectionListLength:int = commonModel.sectionList.length;
			
			commonModel.currentUser = new UsuarioDTO();
			
			commonModel.isLoggedIn = false;
			
			//Disparamos evento para seleccionar la seccion HOME
			if(commonModel.currentSection.id != 0){
				var ev:CommonEvent = new CommonEvent(CommonEvent.SECTION_CLICKED_EVENT);
				ev.section = SectionVO(commonModel.sectionList.getItemAt(0));
				dispatcher.dispatchEvent(ev);
			}
			
			//Removemos las demas secciones
			for(var i:int = 1; i < sectionListLength; i++){
				commonModel.sectionList.removeItemAt(1);
			}
			
			commonModel.sectionList = new ArrayCollection(commonModel.sectionList.source);
			commonModel.notificationsList = new ArrayCollection();
			
			executeServiceCall(commonService.userLogout(), logoutUserResult, logoutUserFault);
		}
		
		public function logoutUserResult(e:ResultEvent):void{
			if(e.result){
				trace(e.result);
			}
		}
		
		public function logoutUserFault(e:FaultEvent):void{
			trace(e.fault.message);
		}
		
		/**
		 * Llama el servicio que obtiene las secciones visibles por usuario
		 * 
		 */
		public function getSections():void{
			executeServiceCall(commonService.getInfoProtlets(), getSectionsResult, getSectionFault);
		}
		
		/**
		 * Maneja el resultado del servicio que obtiene la lista de secciones 
		 * @param e El evento con los resultados del servicio
		 * 
		 */
		public function getSectionsResult(e:ResultEvent):void{
			try{
				if(e.result){
					var sectionList:ArrayCollection = new ArrayCollection(commonModel.sectionList.source);
					var portletList:ArrayCollection;
					var i:int = 1;
					var section:SectionVO;
					var portlet:PortletVO;
					for each(var newSection:Object in e.result){
						section = new SectionVO();
						section.id = newSection.id_menu;
						section.index = i;
						section.name = newSection.nombreCortoMenu;
						section.label = newSection.menu;
						
						portletList = new ArrayCollection();
						for each(var newPortlet:PortletVO in newSection.lisPortlet){
							portlet = new PortletVO();
							
							portlet.id_config = newPortlet.id_config;
							portlet.id_componente = newPortlet.id_componente;
							portlet.componente_class = newPortlet.componente_class;
							portlet.nombreCortoComponente = newPortlet.nombreCortoComponente;
							portlet.nombre_submenu = newPortlet.nombre_submenu;
							portlet.nombreCortoMenu = newPortlet.nombreCortoMenu;
							portlet.id_menu = newPortlet.id_menu;
							portlet.posicion = (newPortlet.posicion == 0)? NokConstants.PORTLET_POSITION_NOT_SET:newPortlet.posicion;
							portlet.main_posicion = newPortlet.main_posicion;
							
							portletList.addItem(portlet);
						}
						
						section.portletList = portletList;
						sectionList.addItem(section);
						
						i++;
					}
					
					commonModel.sectionList = sectionList;
					
					var notification:NotificacionDTO = new NotificacionDTO();
					notification.idNotificacion = '';
					notification.idConfig = '';
					notification.idUsuario = commonModel.currentUser.idUsuario;//commonModel.currentUser.usuario;
					
					
					getNotifications(notification);
				}else{
					Alert.show("Hubo un problema al intentar recuperar las secciones", "Error");
				}	
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		/**
		 * Maneja cuando hay un error en el servicio que obtiene las secciones 
		 * @param e El error con los detalles de porque falló el servicio
		 * 
		 */		
		public function getSectionFault(e:FaultEvent):void{
			if(e.message){
				Alert.show("Hubo un problema al intentar recuperar las secciones", "Error");
			}
		}
		
		/**
		 * Actualiza los cambios en el portlet
		 * @portlet contienen las propiedades del protlet (posicion, main_posicion, id_menu)
		 */
		[EventHandler(event="CommonEvent.USER_SAVE_SECTION_PORTLETS_EVENT", properties="portlet")]
		public function sendUserSectionPortlets(_portletVO:PortletVO):void{
			if(commonModel.currentSection.label != "HOME"){				
				executeServiceCall(commonService.updatePosicionPortlet(_portletVO),sendUserSectionPortletsResult, sendUserSectionPortletsFault);
			}
		}
		
		public function sendUserSectionPortletsResult(e:ResultEvent):void{
			try{
				if(e.result){
					trace(e.result);
					if(Boolean(e.result)){
						trace("Se actualizó con éxito!!!!");
					}else{
						trace("No se logró realizar la actualización con éxito!!!");
					}
				}	
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		public function sendUserSectionPortletsFault(e:FaultEvent):void{
			trace(e.message);
		}
		
		
		public function getNotifications(notification:NotificacionDTO):void{
			executeServiceCall(commonService.getNotifications(notification), getNotificationsResult, getNotificationsFault);
		}
		
		public function getNotificationsResult(e:ResultEvent):void{
			if(e.result){
				
			}else{
				Alert.show("Hubo un problema al intentar recuperar las secciones", "Error");
			}
		}
		
		public function getNotificationsFault(e:FaultEvent):void{
			trace(e.message);
			Alert.show("Hubo un problema al intentar recuperar las notificaciones", "Error");
		}
		
		public function generateNotifications():void{
			commonModel.notificationsList = new ArrayCollection([new NotificationVO(),new NotificationVO(),new NotificationVO(),new NotificationVO(),new NotificationVO()]);
		}
	}
}
