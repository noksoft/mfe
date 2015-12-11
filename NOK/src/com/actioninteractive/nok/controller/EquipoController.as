package com.actioninteractive.nok.controller
{
	import com.actioninteractive.nok.delegate.CRUDService;
	import com.actioninteractive.nok.delegate.EquipoService;
	import com.actioninteractive.nok.event.EquipoEvent;
	import com.actioninteractive.nok.model.EquipoModel;
	import com.actioninteractive.nok.vo.CategoriaVO;
	import com.actioninteractive.nok.vo.MarcaMotorVO;
	import com.actioninteractive.nok.vo.MarcaVO;
	import com.actioninteractive.nok.vo.SubCategoriaVO;
	import com.actioninteractive.nok.vo.equipo.EquipoVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	public class EquipoController extends AbstractController
	{
		[Inject]
		public var modelEquipo:EquipoModel;
		
		public var equipoService:EquipoService = new EquipoService();
		public var crudService:CRUDService = new CRUDService();
		
		private var eventEquipo:EquipoEvent;
		
		public function EquipoController()
		{
			super();
		}
		
		[PostConstruct]
		public function init():void{
			
		}
		
		/**********************************************************************************************************/
		/*********************************************	EQUIPOS	***********************************************/
		
		/**
		 * Llama al servicio para obtener la lista de equipos
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 * @EquipoVO
		 */
		[EventHandler(event="EquipoEvent.GET_EQUIPO_LIST", properties="equipoVO")]
		public function getEquipoList(equipoVO:EquipoVO):void{
			executeServiceCall(equipoService.getEquipolist(equipoVO), resultGetEquipoList, faultGetEquipoList);
		}
		
		/***	Result GetEquipoList	***/
		private function resultGetEquipoList (event:ResultEvent):void{
			if(event.result != null){
				modelEquipo.acEquipos = event.result as ArrayCollection;
			}
		}
		
		/***	Fault GetEquipoList	   ***/
		private function faultGetEquipoList (event:FaultEvent):void{
			Alert.show("Error GetEquipoList", event.fault.faultDetail);
		}
		
		/**
		 * Lllama al servicio para obtener uno o más equipos de acuerdo a su número ecónomico
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 * @EquipoVO
		 **/
		[EventHandler(event="EquipoEvent.BUSCAR_EQUIPO", properties="equipoVO")]
		public function buscarEquipo(equipoVO:EquipoVO):void{
			executeServiceCall(equipoService.getEquipolist(equipoVO), resultBuscarEquipo, faultBuscarEquipo);
		}
		
		/***	Result BuscarEquipo		***/
		private function resultBuscarEquipo (event:ResultEvent):void{
			try{
				modelEquipo.acEquiposEncontrados = event.result as ArrayCollection;
				dispatcher.dispatchEvent(new EquipoEvent(EquipoEvent.EQUIPOS_ENCONTRADOS));
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		/***	Fault BuscarEquipo		***/
		private function faultBuscarEquipo(event:FaultEvent):void{
			Alert.show("Error al buscar el Equipo.", event.fault.faultDetail);
		}
		
		/**
		 * Llama al servicio para insertar un equipo
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 * @EquipoVO
		 */
		[EventHandler(event="EquipoEvent.INSERT_EQUIPO")]
		public function insertEquipo():void{
			trace("Serie: " + modelEquipo.equipoVO.numeroserie);
			trace("Factura: " + modelEquipo.equipoVO.factura);
			trace("idEquipo: " + modelEquipo.equipoVO.idEquipo);
			
			trace(modelEquipo.equipoVO.numeroserie + modelEquipo.equipoVO.factura);
			modelEquipo.equipoVO.idEquipo = modelEquipo.equipoVO.numeroserie + modelEquipo.equipoVO.factura;
			
			trace("Serie: " + modelEquipo.equipoVO.numeroserie);
			trace("Factura: " + modelEquipo.equipoVO.factura);
			trace("idEquipo: " + modelEquipo.equipoVO.idEquipo);
			executeServiceCall(equipoService.insertEquipo(modelEquipo.equipoVO), resultInsertEquipo, faultInsertEquipo);
		}
		
		/***	Result GetEquipoList	***/
		private function resultInsertEquipo (event:ResultEvent):void{
			if(event.result != null){
				modelEquipo.acEquipos = event.result as ArrayCollection;
				dispatcher.dispatchEvent(new EquipoEvent(EquipoEvent.CLEAN_CONTROLS));
			}
		}
		
		/***	Fault GetEquipoList	   ***/
		private function faultInsertEquipo (event:FaultEvent):void{
			modelEquipo.equipoVO = new EquipoVO();
			Alert.show("Error InsertEquipo", event.fault.faultDetail);
		}
		
		/**
		 * Llama al servicio para actualizar una maquina
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 * @EquipoVO
		 */
		[EventHandler(event="EquipoEvent.UPDATE_EQUIPO")]
		public function updateEquipo():void{
			executeServiceCall(equipoService.updateEquipo(modelEquipo.equipoVO), resultUpdateEquipo, faultUpdateEquipo);
		}
		
		/***	Result GetEquipoList	***/
		private function resultUpdateEquipo (event:ResultEvent):void{
			if(event.result != null){
				modelEquipo.acEquipos = event.result as ArrayCollection;
			}
		}
		
		/***	Fault GetEquipoList	   ***/
		private function faultUpdateEquipo (event:FaultEvent):void{
			trace(event.fault.message);
			Alert.show("Error al Actualizar el Equipo", event.fault.faultDetail);
		}
		
		/**
		 * Llama al servicio para eliminar una maquina
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 * @EquipoVO
		 */
		[EventHandler(event="EquipoEvent.DELETE_EQUIPO")]
		public function deleteEquipo():void{
			executeServiceCall(equipoService.deleteEquipo(modelEquipo.equipoVO), resultDeleteEquipo, faultDeleteEquipo);
		}
		
		/***	Result GetEquipoList	***/
		private function resultDeleteEquipo (event:ResultEvent):void{
			if(event.result != null){
				modelEquipo.acEquipos = event.result as ArrayCollection;
			}
		}
		
		/***	Fault GetEquipoList	   ***/
		private function faultDeleteEquipo (event:FaultEvent):void{
			Alert.show("Error InsertEquipo", event.fault.faultDetail);
		}
		
		/*******************************************************************************************************************/
		/****************************************	MOTOR	****************************************************************/				
		/**
		 * Llama al servicio para obtener las marcas de motor
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 * @SubCategoriaVO
		 */
		[EventHandler(event="EquipoEvent.GET_MARCAS_MOTOR", properties="marcaMotorVO")]
		public function getMarcasMotor(marcaMotorVO:MarcaMotorVO):void{
			if(modelEquipo.flagServiceMarcasMotor){
				modelEquipo.flagServiceMarcasMotor = false;
				executeServiceCall(equipoService.getMarcasMotor(marcaMotorVO), resultGetMarcasMotor, faultGetMarcasMotor);	
			}			
		}
		
		/***	Result getMarcasMotor	***/
		private function resultGetMarcasMotor (event:ResultEvent):void{
			modelEquipo.flagServiceMarcasMotor = true;
			if(event.result != null){
				modelEquipo.acMarcasMotor = event.result as ArrayCollection;
			}
		}
		
		/***	Fault getMarcasMotor	   ***/
		private function faultGetMarcasMotor (event:FaultEvent):void{
			modelEquipo.flagServiceMarcasMotor = true;
			modelEquipo.acMarcasMotor = new ArrayCollection();
			Alert.show("Error GetMarcasMotor", event.fault.faultDetail);
		}
	}
}