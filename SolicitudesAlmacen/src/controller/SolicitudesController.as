package controller
{
	import event.EventSolicitud;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.FallaEquipoDTO;
	import model.ProcesoEstatusEnum;
	import model.ProveedorVO;
	import model.SolicitudModel;
	import model.SolicitudVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import service.SolicitudService;
	
	import view.AlertError;
	
	public class SolicitudesController extends AbstractController
	{
		[Inject]
		[Bindable]
		public var solicitudModel:SolicitudModel;
		private var solicitudService:SolicitudService = new SolicitudService();
		private var eventSolicitud:EventSolicitud;
		
		public function SolicitudesController()
		{
			super();
		}
		
		[PostConstruct]
		public function post_construct():void{
			getEmpleados();
			getArticulos(new ArticuloVO());
			getSolicitudes();
			getFallasEquipo();
			getProveedores();
		}
		
		private function getEmpleados():void{
			executeServiceCall(solicitudService.getEmpleados(new EmpleadoVO()), getEmpleadosResult, getEmpleadosFault);
		}
		
		private function getFallasEquipo():void{
			executeServiceCall(solicitudService.getFallasEquipo(new FallaEquipoDTO()), getFallasEquipoResult, getFallasEquipoFault);
		}
		
		private function getSolicitudes():void{
			var temp:SolicitudVO = new SolicitudVO();
			executeServiceCall(solicitudService.findAllSolicitudes(temp), findAllSolicitudesResult, findAllSolicitudesFault);
		}
		
		private function getProveedores():void{
			executeServiceCall(solicitudService.getProveedores(new ProveedorVO()), getProveedoresResult, getProveedoresFault);
		}
		
		[EventHandler(event="EventSolicitud.EVENT_FIND_ARTICULOS", properties="articuloVO")]
		public function getArticulos(articuloVO:ArticuloVO):void{
			executeServiceCall(solicitudService.getArticulos(articuloVO), getArticulosResult, getArticulosFault);
		}
		
		[EventHandler(event="EventSolicitud.EVENT_FIND_Solicitudes", properties="SolicitudVO")]
		public function findAllSolicitudes(solicitudVO:SolicitudVO):void{
			executeServiceCall(solicitudService.findAllSolicitudes(solicitudVO), findAllSolicitudesResult, findAllSolicitudesFault);
		}
		
		[EventHandler(event="EventSolicitud.EVENT_UPDATE")]
		public function updateSolicitud():void{
			executeServiceCall(solicitudService.updateSolicitud(solicitudModel.solicitudSelected), updateSolicitudResult, updateSolicitudFault);
		}
		
		[EventHandler(event="EventSolicitud.EVENT_SAVE_SOLICITUD")]
		public function saveSolicitud():void{
			if(solicitudModel.solicitudSelected.nombre_solicitud != ""){
				executeServiceCall(solicitudService.saveSolicitud(solicitudModel.solicitudSelected), saveSolicitudResult, saveSolicitudFault);
			}
		}
		
		[EventHandler(event="EventSolicitud.EVENT_DELETE_SOLICITUD")]
		public function deleteSolicitud():void{
			executeServiceCall(solicitudService.deleteSolicitud(solicitudModel.solicitudSelected), deleteSolicitudHandler, deleteSolicitudFault);
		}
		
		/******************	REMOTES OBJECTS	****************************/
		//Empleados
		private function getEmpleadosResult (e:ResultEvent):void{
			try{
				if(e.result != null){
					solicitudModel.acEmpleadosAdquisicion = e.result as ArrayCollection;
					solicitudModel.acEmpleadosRequisicion = e.result as ArrayCollection;
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function getEmpleadosFault (e:FaultEvent):void{
			trace(e.fault.message);
		}
		
		//Artículos
		public function getArticulosResult(e:ResultEvent):void{
			try{
				if(e.result != null){
					solicitudModel.acArticulos = e.result as ArrayCollection;
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		public function getArticulosFault(e:FaultEvent):void{
			trace(e.fault.message);
		}
		
		//Solicitudes
		private function findAllSolicitudesResult(e:ResultEvent):void{
			try{
				if(e.result != null){
					solicitudModel.solicitudSelected = new SolicitudVO();
					solicitudModel.acSolicitudes = e.result as ArrayCollection;
				}else{
					Alert.show("No se logró cargar la información de las Solicitudes");
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function findAllSolicitudesFault(e:FaultEvent):void{
			Alert.show("Error al intentar cargar las Solicitudes", "NOK");
		}
		
		//PROVEEDORES
		private function getProveedoresResult(e:ResultEvent):void{
			try{
				if(e.result != null){
					solicitudModel.acProveedor = e.result as ArrayCollection;
				}else{
					solicitudModel.acProveedor = new ArrayCollection();
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function getProveedoresFault(e:FaultEvent):void{
			Alert.show("Error", "No se pudieron cargar los proveedores");
		}
		
		//Update Solicitudes
		private function updateSolicitudResult(e:ResultEvent):void{
			try{
				getSolicitudes();
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function updateSolicitudFault(e:FaultEvent):void{
			Alert.show("Fault Update");
			trace(e.fault.message);
		}
		
		//Save Solicitud
		private function saveSolicitudResult(e:ResultEvent):void{
			try{
				if(e.result != null){
					solicitudModel.solicitudSelected = new SolicitudVO();
					solicitudModel.acSolicitudes.addItem(e.result as SolicitudVO);
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function saveSolicitudFault(e:FaultEvent):void{
			trace(e.fault.message);
			solicitudModel.solicitudSelected = new SolicitudVO();
		}
		
		//Delete Solicitud
		private function deleteSolicitudHandler(e:ResultEvent):void{
			try{
				getSolicitudes();
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function deleteSolicitudFault(e:FaultEvent):void{
			trace(e.message);
		}
		
		//Fallas
		private function getFallasEquipoResult(e:ResultEvent):void{
			trace(e.result);
			if(e.result != null){
				solicitudModel.acFallasEquipo = e.result as ArrayCollection;
			}else{
				trace("No se encontro ningun registro de Fallas Equipo");
			}
		}
		
		private function getFallasEquipoFault(e:FaultEvent):void{
			trace(e.fault.faultDetail);
		}
		
	}
}