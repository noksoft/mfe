package service
{
	import constants.NOKConstants;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.FallaEquipoDTO;
	import model.ProveedorVO;
	import model.SolicitudVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class SolicitudService
	{
		private var solicitudRemote:RemoteObject 	= new RemoteObject(NOKConstants.SERVICE_DESTINATION_SOLICITUDES);
		private var articulosRemote:RemoteObject 	= new RemoteObject(NOKConstants.SERVICE_DESTINATION_ARTICULOS);
		private var empleadosRemote:RemoteObject 	= new RemoteObject(NOKConstants.SERVICE_DESTINATION_EMPLEADOS);
		private var fallaEquipoRemote:RemoteObject 	= new RemoteObject(NOKConstants.SERVICE_DESTINATION_FALLA_EQUIPO);
		private var proveedorRemote:RemoteObject 	= new RemoteObject(NOKConstants.SERVICE_DESTINATION_PROVEEDOR);
		private var provedoresRemote:RemoteObject 	= new RemoteObject(NOKConstants.SERVICE_DESTINATION_PROVEEDORES);
		
		public function SolicitudService()
		{
			
			solicitudRemote.endpoint = NOKConstants.SERVICE_URL;
			solicitudRemote.showBusyCursor = true;
			
			articulosRemote.endpoint = NOKConstants.SERVICE_URL;
			articulosRemote.showBusyCursor = true;
			
			empleadosRemote.endpoint = NOKConstants.SERVICE_URL;
			empleadosRemote.showBusyCursor = true;
			
			fallaEquipoRemote.endpoint = NOKConstants.SERVICE_URL;
			fallaEquipoRemote.showBusyCursor = true;
			
			proveedorRemote.endpoint = NOKConstants.SERVICE_URL;
			proveedorRemote.showBusyCursor = true;
		}
		
		/*****************	  SOLICITUDES 	****************************/
		public function findAllSolicitudes(vo:SolicitudVO):AsyncToken{
			return solicitudRemote.getSolicitudes(vo);
		}
		
		public function saveSolicitud(vo:SolicitudVO):AsyncToken{
			return solicitudRemote.insertSolicitud(vo);
		}
		
		public function updateSolicitud(vo:SolicitudVO):AsyncToken{
			return solicitudRemote.updateSolicitud(vo);
		}
		
		public function deleteSolicitud(vo:SolicitudVO):AsyncToken{
			return solicitudRemote.deleteSolicitud(vo);
		}
		
		/*********************	ARTÍCULOS	***********************/
		public function getArticulos(vo:ArticuloVO):AsyncToken{
			return articulosRemote.getArticulosByTipocategoria(vo);
		}
		
		/*********************	EMPLEADOS	***********************/
		public function getEmpleados(vo:EmpleadoVO):AsyncToken{
			return empleadosRemote.infoEmpleado(vo);
		}
		
		/********************* FALLA EQUIPO ************************/
		public function getFallasEquipo(vo:FallaEquipoDTO):AsyncToken{
			return fallaEquipoRemote.getFallasEquipo(vo);
		}
		
		/*********************	PROVEEDOR	*************************/
		public function getProveedores(vo:ProveedorVO):AsyncToken{
			return proveedorRemote.catProveedor(vo);
		}
	}
}