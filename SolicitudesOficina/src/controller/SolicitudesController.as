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
			getSolicitudes();
		}
		
		
		private function getSolicitudes():void{
			var temp:SolicitudVO = new SolicitudVO();
			temp.estatus_proceso = ProcesoEstatusEnum.ADQUISICION;
			executeServiceCall(solicitudService.findAllSolicitudes(temp), findAllSolicitudesResult, findAllSolicitudesFault);
		}
		
		[EventHandler(event="EventSolicitud.EVENT_FIND_Solicitudes", properties="SolicitudVO")]
		public function findAllSolicitudes(solicitudVO:SolicitudVO):void{
			executeServiceCall(solicitudService.findAllSolicitudes(solicitudVO), findAllSolicitudesResult, findAllSolicitudesFault);
		}
		
		[EventHandler(event="EventSolicitud.EVENT_UPDATE")]
		public function updateSolicitud():void{
			for each(var sol:SolicitudVO in solicitudModel.acSolicitudes){
				trace("estatus_proceso: " + sol.estatus_proceso);
			}
			trace("End for each");
			executeServiceCall(solicitudService.updateSolicitudes(solicitudModel.acSolicitudes), updateSolicitudesResult, updateSolicitudesFault);
			//executeServiceCall(solicitudService.updateSolicitud(solicitudModel.solicitudSelected), updateSolicitudResult, updateSolicitudFault);
		}
		
		/******************	REMOTES OBJECTS	****************************/
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
		
		//Update Solicitudes
		private function updateSolicitudesResult(e:ResultEvent):void{
			try{
				getSolicitudes();
			}catch(e:Error){
				trace(e.message);
			}
		}
		private function updateSolicitudesFault(e:FaultEvent):void{
			Alert.show("Fault Update");
			trace(e.fault.message);
		}
	}
}