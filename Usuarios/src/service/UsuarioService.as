package service
{
	import constants.NOKConstants;
	import model.EmpleadoVO;
import model.PerfilVO;
import model.TipoEmpleadoVO;
    import model.UsuarioDTO;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class UsuarioService
	{
		private var empleadoRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_EMPLEADO);
		
		public function UsuarioService()
		{
			empleadoRemote.endpoint = NOKConstants.SERVICE_URL;
			empleadoRemote.showBusyCursor = true;
		}
		
		/*****************	  Usuario 	****************************/
		public function findAllUsers(vo:UsuarioDTO):AsyncToken{
			return empleadoRemote.infoUsuario(vo);
		}
		
		public function saveUsuario(vo:UsuarioDTO):AsyncToken{
			return empleadoRemote.insertUsuario(vo);
		}
		
		public function updateUsuario(vo:UsuarioDTO):AsyncToken{
			return empleadoRemote.updateUsuario(vo);
		}
		
		public function deleteUsuario(vo:UsuarioDTO):AsyncToken{
			return empleadoRemote.deleteUsuario(vo);
		}

		public function getEmpleados(vo:EmpleadoVO):AsyncToken{
			return empleadoRemote.infoEmpleado(vo);
		}

        /*********************  PERFILES        ***********************/
        public function getPerfiles(vo:PerfilVO):AsyncToken{
            return empleadoRemote.catPerfil(vo);
        }
	}
}