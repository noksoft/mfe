package controller
{
	import event.UsuarioEvent;
	
	import model.EmpleadoVO;
    import model.PerfilVO;
	import model.UsuarioDTO;
	import model.UsuarioModel;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import service.UsuarioService;
	
	public class UsuarioController extends AbstractController
	{
		[Inject]
		[Bindable]
		public var usuarioModel:UsuarioModel;
		private var usuarioService:UsuarioService = new UsuarioService();
		private var usuarioEvent:UsuarioEvent;
		
		public function UsuarioController()
		{
			super();
		}
		
		[PostConstruct]
		public function post_construct():void{
			getUsuarios();
            getEmpleados();
            getPerfiles();
		}

        private function getEmpleados():void{
            executeServiceCall(usuarioService.getEmpleados(new EmpleadoVO()), getEmpleadosResult, getEmpleadosFault);
        }
		
		private function getUsuarios():void{
			executeServiceCall(usuarioService.findAllUsers(new UsuarioDTO()), getUsuarioResult, getUsuarioFault);
		}

        private function getPerfiles():void{
            executeServiceCall(usuarioService.getPerfiles(new PerfilVO()), getPerfilesResult, getPerfilesFault)
        }

		[EventHandler(event="UsuarioEvent.SAVE_USUARIO_EVENT")]
		public function saveUsuario():void{
			executeServiceCall(usuarioService.saveUsuario(usuarioModel.usuarioSelected), saveUsuarioResult, saveUsuarioFault);
		}
		
		[EventHandler(event="UsuarioEvent.UPDATE_USUARIO_EVENT")]
		public function updateUsuario():void{
			if(usuarioModel.usuarioSelected.idUsuario != null
				&& usuarioModel.usuarioSelected.idUsuario != ""){
				executeServiceCall(usuarioService.updateUsuario(usuarioModel.usuarioSelected), updateUsuarioResult, updateUsuarioFault);
			}
		}
		
		[EventHandler(event="UsuarioEvent.DELETE_USUARIO_EVENT")]
		public function deleteUsuario():void{
			if(usuarioModel.usuarioSelected.idUsuario != null
				&& usuarioModel.usuarioSelected.idUsuario != ""){
				executeServiceCall(usuarioService.deleteUsuario(usuarioModel.usuarioSelected), deleteUsuarioHandler, deleteUsuarioFault);
			}
		}
		
		/******************	REMOTES OBJECTS	****************************/
        //Empleados
        private function getEmpleadosResult (e:ResultEvent):void{
            try{
                if(e.result != null){
                    usuarioModel.acEmpleados = e.result as ArrayCollection;
                }
            }catch (error:Error){
                trace(error.message);
            }
        }
        private function getEmpleadosFault(e:FaultEvent):void{
            trace(e.fault.message);
        }

		//Usuarios
		private function getUsuarioResult (e:ResultEvent):void{
			try{
				if(e.result != null){
					usuarioModel.acUsuarios = e.result as ArrayCollection;
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function getUsuarioFault (e:FaultEvent):void{
			trace(e.fault.message);
		}

        //Perfile
        private function getPerfilesResult(e:ResultEvent):void{
            try{
                if(e.result != null){
                    usuarioModel.acPerfiles = e.result as ArrayCollection;
                }
            }catch(e:Error){
                trace(e.message);
            }
        }
        private function getPerfilesFault (e:FaultEvent):void{
            trace(e.fault.message);
        }
		
		//Update Usuario
		private function updateUsuarioResult(e:ResultEvent):void{
			try{
				getUsuarios();
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function updateUsuarioFault(e:FaultEvent):void{
			Alert.show("Fault Update");
			trace(e.fault.message);
		}
		
		//Save Usuario
		private function saveUsuarioResult(e:ResultEvent):void{
			try{
				if(e.result != null){
					usuarioModel.acUsuarios.addItem(e.result as UsuarioDTO);
					usuarioModel.usuarioSelected = new UsuarioDTO();
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function saveUsuarioFault(e:FaultEvent):void{
			trace(e.fault.message);
			usuarioModel.usuarioSelected = new UsuarioDTO();
		}
		
		//Delete Usuario
		private function deleteUsuarioHandler(e:ResultEvent):void{
			try{
				getUsuarios()
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function deleteUsuarioFault(e:FaultEvent):void{
			trace(e.message);
		}
	}
}