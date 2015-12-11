package service
{
	import constants.NOKConstants;
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.RequisicionVO;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class RequisicionService
	{
		private var requisicionRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_REQUISICIONES);
		private var articulosRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_ARTICULOS);
		private var categoriasRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_CATEGORIAS);
		private var empleadosRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_EMPLEADOS);
		private var fallaRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_FALLA);
		
		public function RequisicionService()
		{
			requisicionRemote.endpoint = NOKConstants.SERVICE_URL;
			requisicionRemote.showBusyCursor = true;
			
			articulosRemote.endpoint = NOKConstants.SERVICE_URL;
			articulosRemote.showBusyCursor = true;
			
			categoriasRemote.endpoint = NOKConstants.SERVICE_URL;
			categoriasRemote.showBusyCursor = true;
			
			empleadosRemote.endpoint = NOKConstants.SERVICE_URL;
			empleadosRemote.showBusyCursor = true;
			
			fallaRemote.endpoint = NOKConstants.SERVICE_URL;
			fallaRemote.showBusyCursor = true;
		}
		
		/********************	REQUISICIONES	*************************/
		public function findAll(vo:RequisicionVO):AsyncToken{
			return requisicionRemote.infoRequisicion(vo);
		}
		public function save(vo:RequisicionVO):AsyncToken{
			return requisicionRemote.insertRequisicion(vo);
		}
		public function update(vo:RequisicionVO):AsyncToken{
			return requisicionRemote.updateRequisicion(vo);
		}
		public function deleteRequisicion(vo:RequisicionVO):AsyncToken{
			return requisicionRemote.deleteRequisicion(vo);
		}
		
		/*******************	ARTICULOS		**************************/
		public function getArticulos(vo:ArticuloVO):AsyncToken{
			return articulosRemote.getArticulosByTipocategoria(vo);
		}
		
		/*****************		EMPLEADOS		************************/
		public function getEmpleados(vo:EmpleadoVO):AsyncToken{
			return empleadosRemote.infoEmpleado(vo);
		}
		
	}
}