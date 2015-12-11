package controller
{
	import event.RequisicionEvent;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.RequisicionDetalleDTO;
	import model.RequisicionModel;
	import model.RequisicionVO;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	import service.RequisicionService;
	
	public class RequisicionController extends AbstractController
	{
		[Inject]
		[Bindable]
		public var requisicionModel:RequisicionModel;
		private var requisicionService:RequisicionService = new RequisicionService();
		private var eventRequisicion:RequisicionEvent;
		
		public function RequisicionController()
		{
			super();
		}
		
		[PostConstruct]
		public function post_construct():void
		{
			executeServiceCall(requisicionService.getEmpleados(new EmpleadoVO()), getEmpleadosResult, getEmpleadosFault);
			getArticulos(new ArticuloVO());
			//Cargamos la infrmcacón de las subcategorias
			//var subCategoria:SubCategoriaVO = new SubCategoriaVO();
			//subCategoria.idCategoria = '13';
			//executeServiceCall(requisicionService.getSubcategorias(subCategoria), getSubcategoriaHandler, getSubcategoriaFault);
		}
		
		private function getEmpleadosResult (e:ResultEvent):void{
			try{
				if(e.result != null){
					requisicionModel.acEmpleadosRequisicion = e.result as ArrayCollection;
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		private function getEmpleadosFault(e:FaultEvent):void{
			trace(e.fault.message);
		}
		
		private function getRequisiciones():void{
			executeServiceCall(requisicionService.findAll(new RequisicionVO()), findAllResult, findAllFault);
		}
		
		[EventHandler(event="RequisicionEvent.EVENT_FIND_ARTICULOS", properties="articuloVO")]
		public function getArticulos(articuloVO:ArticuloVO):void{
			executeServiceCall(requisicionService.getArticulos(articuloVO), getArticulosHandler, getArticulosFault);
		}
		public function getArticulosHandler(e:ResultEvent):void{
			try{
				if(e.result != null){
					requisicionModel.acArticulos = e.result as ArrayCollection;
				}
			}catch(error:Error){
				trace(error.message);
			}
		}
		public function getArticulosFault(e:FaultEvent):void{
			trace(e.fault.message);
		}
		
		[EventHandler(event="RequisicionEvent.EVENT_FIND_REQUISICIONES", properties="requisicionVO")]
		public function findAllRequisiciones(requisicionVO:RequisicionVO):void{
			executeServiceCall(requisicionService.findAll(requisicionVO), findAllResult, findAllFault);
		}
		private function findAllResult(e:ResultEvent):void{
			try{
				if(e.result != null){
					requisicionModel.acRequisiciones = e.result as ArrayCollection;
					requisicionModel.requisicionDetalleSelected = new RequisicionDetalleDTO();
					requisicionModel.requisicionSelected = new RequisicionVO();
					dispatcher.dispatchEvent(new RequisicionEvent(RequisicionEvent.EVENT_SAVE_SUCCEFULL));
				}else{
					Alert.show("No se logró cargar la información de las Requisiciones.", "NOK");
				}
			}catch(error:Error){
				trace(error.message);
			}
		}
		
		private function findAllFault(e:FaultEvent):void{
			Alert.show("Error al intentar cargar las Requisiciones", "NOK");
		}
		
		[EventHandler(event="RequisicionEvent.EVENT_UPDATE_REQUISICION")]
		public function updateRequisicion():void{
			executeServiceCall(requisicionService.update(requisicionModel.requisicionSelected), updateResult, updateFault);
		}
		
		private function updateResult (e:ResultEvent):void{
			try{
				getRequisiciones();
			}catch(error:Error){
				trace(error.message);
			}
		}
		
		private function updateFault(e:FaultEvent):void{
			trace(e.fault.message);
		}
		
		[EventHandler(event="RequisicionEvent.EVENT_SAVE_REQUISICION")]
		public function saveRequisicion():void{
			executeServiceCall(requisicionService.save(requisicionModel.requisicionSelected), saveResult, saveFault);
		}
		
		private function saveResult(e:ResultEvent):void{
			try{
				if(e.result != null){
					requisicionModel.acRequisiciones.addItem(e.result as RequisicionVO);
					requisicionModel.requisicionSelected = new RequisicionVO();
					eventRequisicion = new RequisicionEvent(RequisicionEvent.EVENT_SAVE_SUCCEFULL);
					dispatcher.dispatchEvent(eventRequisicion);
				}
			}catch(error:Error){
				trace(error.message);
			}
		}
		
		private function saveFault(e:FaultEvent):void{
			trace(e.fault.message);
			requisicionModel.requisicionSelected = new RequisicionVO();
		}
	}
}