package com.actioninteractive.nok.delegate
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.service.NotificacionDTO;
	import com.actioninteractive.nok.service.SectionDTO;
	import com.actioninteractive.nok.service.UsuarioDTO;
	import com.actioninteractive.nok.vo.PerfilDTO;
	import com.actioninteractive.nok.vo.PortletVO;
	import com.actioninteractive.nok.vo.SectionVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import org.swizframework.utils.services.ServiceHelper;

	public class CommonService
	{
		private var loginRO:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_LOGIN);
		private var portletRO:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_PORTLET);
		private var notificationRO:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_NOTIFICATION);
		
		public function CommonService(){
			loginRO.endpoint = NokConstants.SERVICE_URL;
			loginRO.showBusyCursor = true;
			notificationRO.endpoint = NokConstants.SERVICE_URL;
			notificationRO.showBusyCursor = true;
			portletRO.endpoint = NokConstants.SERVICE_URL;
			portletRO.showBusyCursor = true;
		}
		
		public function userLogin(user:UsuarioDTO):AsyncToken{
			return loginRO.logIn(user);
		}
		
		public function updateUser(_usuarioDTO:UsuarioDTO):AsyncToken{
			return loginRO.updateUserAopSession(_usuarioDTO);
		}
		
		public function userLogout():AsyncToken{
			return loginRO.logOut();
		}
		
		public function getNotifications(notification:NotificacionDTO):AsyncToken{
			return notificationRO.infoNotificacion(notification);
		}
		
		public function getInfoProtlets():AsyncToken{
			return portletRO.getInfoProtlets();
		}
		
		public function updatePosicionPortlet(_portletVO:PortletVO):AsyncToken{
			return portletRO.updatePosicionPortletAopSession(_portletVO);
		}
		
		public function getPerfiles(_perfilDTO:PerfilDTO):AsyncToken{
			return loginRO.getInfoPerfilesAopSession(_perfilDTO);
		}
	}
}