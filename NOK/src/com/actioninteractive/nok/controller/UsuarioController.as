package com.actioninteractive.nok.controller
{
	import com.actioninteractive.nok.delegate.CommonService;
	import com.actioninteractive.nok.model.UsuarioModel;
	import com.actioninteractive.nok.vo.PerfilDTO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	public class UsuarioController extends AbstractController
	{
		private var commonService:CommonService = new CommonService();
		
		[Inject]
		public var usuarioModel:UsuarioModel;
		
		public function UsuarioController()
		{
			super();
		}
		
		[PostConstruct]
		public function init():void{
			
		}
		
		/**
		 * Llama el servicio para obtener los perfiles de los usuarios
		 */
		[EventHandler(event="UsuarioEvent.EVENT_GET_PERFILES")]
		public function getPerfiles():void{
			var _tempPerfilDTO:PerfilDTO = new PerfilDTO();
			executeServiceCall(commonService.getPerfiles(_tempPerfilDTO), handlerGetPerfiles, faultGetPerfiles);
		}
		
		private function handlerGetPerfiles (_event:ResultEvent):void{
			try{
				trace(_event.result);
				usuarioModel.perfilesCollection = _event.result as ArrayCollection;
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		private function faultGetPerfiles (_event:FaultEvent):void{
			try{
				trace(_event.message);
			}catch(e:Error){
				trace(e.message);
			}
		}
		
	}
}