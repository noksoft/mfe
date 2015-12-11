package com.actioninteractive.nok.controller
{
	import com.actioninteractive.nok.delegate.CommonService;
	import com.actioninteractive.nok.delegate.EmpleadoService;
	import com.actioninteractive.nok.event.EmpleadoEvent;
	import com.actioninteractive.nok.model.EmpleadoModel;
	import com.actioninteractive.nok.vo.EmpleadoVO;
	import com.actioninteractive.nok.vo.HabilidadDTO;
	import com.actioninteractive.nok.vo.PerfilDTO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	public class EmpleadoController extends AbstractController
	{
		public var empleadoService:EmpleadoService = new EmpleadoService();
		private var commonService:CommonService = new CommonService();
		public function EmpleadoController()
		{
			super();
		}
		[Inject]
		public var empleadoModel:EmpleadoModel;
		[PostConstruct]
		public function init():void
		{
			//var perfiles:PerfilDTO = new PerfilDTO();
			//executeServiceCall(commonService.getPerfiles(perfiles), getPerfilesResult, empleadoFault);
		}
		
		private function getPerfilesResult(event:ResultEvent):void
		{
			empleadoModel.perfilesList = (event.result) as ArrayCollection;
		}
		
		private function empleadoFault(event:FaultEvent):void
		{
			trace(event.message);
			
		}
		//Read
		/**
		 * Lee los elementos de una obra dentro del catalogo, obras vigentes.
		 * 
		 * @productversion NOK 1	
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="EmpleadoEvent.EMPLEADO_LIST_DATA", properties="empleadoVO")]
		public function getListEmpleados(empleado:EmpleadoVO):void
		{
			trace("Event-----> EMPLEADO_LIST_DATA");
			
			executeServiceCall(empleadoService.catEmpleadoService(empleado),catEmpleadoResult,empleadoFault);
			
		}
		private function catEmpleadoResult(event:ResultEvent):void
		{
			if (event.result == null)
			{
				Alert.show("No hay obras en la base de información");
			}else
			{
				empleadoModel.acListEmpleados = event.result as ArrayCollection;
				trace(empleadoModel.acListEmpleados.length);
			}
			
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_SAVE", properties="empleadoVO")]
		public function saveEmpleadoService(empleado:EmpleadoVO):void
		{
			executeServiceCall(empleadoService.empleadoSave(empleado), empleadoSaveResult, empleadoFault);
		}
		
		private function empleadoSaveResult(event:ResultEvent):void
		{
			if(event.result)
			{
				Alert.show("Se guardo correctamente el empleado");
				dispatcher.dispatchEvent(new EmpleadoEvent(EmpleadoEvent.EMPLEADO_LIMPIA_FORMULARIO));
			}
		}
		[EventHandler(event="EmpleadoEvent.EMPLEADO_BUSCAR_POR_RFC", properties="empleadoVO")]
		public function searchEmpleadoService(empleado:EmpleadoVO):void
		{
			executeServiceCall(empleadoService.empleadoBusquedaRFC(empleado), empleadoBusquedaRFCResult, empleadoFault);
		}
		
		private function empleadoBusquedaRFCResult(event:ResultEvent):void
		{
			if(event.result.source.length != 0)
			{
				var empleadoFound:EmpleadoVO = new EmpleadoVO();
				empleadoFound = ArrayCollection(event.result).getItemAt(0) as EmpleadoVO;
				
				var eventEmpleado:EmpleadoEvent = new EmpleadoEvent(EmpleadoEvent.EMPLEADO_ENCONTRADO_POR_RFC);
				eventEmpleado.empleadoVO = empleadoFound;
				
				var habilidad:HabilidadDTO= new HabilidadDTO();
				habilidad.idEmpleado = empleadoFound.idEmpleado;
				habilidad.idHabilidad='';
				habilidad.status='';
				habilidad.filterEstatusFalla='true';
				
				eventEmpleado.habilidad = habilidad;
				dispatcher.dispatchEvent(eventEmpleado);
			}else{
				Alert.show("No hay resultados");
			}
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_ENCONTRADO_POR_RFC", properties="habilidad")]
		public function empleadoEncontradoPorRFC(habilidad:HabilidadDTO):void
		{
			executeServiceCall(empleadoService.empleadoHabilidades(habilidad), empleadoHabilidadesResult, empleadoFault);
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_RECUPERA_LISTA_DESPUES_ACTUALIZACION", properties="habilidad")]
		public function habilidadActualizadaRecuperaLista(habilidad:HabilidadDTO):void
		{
			executeServiceCall(empleadoService.empleadoHabilidades(habilidad), empleadoHabilidadesResult, empleadoFault);
		}
		
		private function empleadoHabilidadesResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			empleadoModel.habilidadList = event.result as ArrayCollection;
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_BUSCAR", properties="empleadoVO")]
		public function empleadoBusquedaFiltrada(empleado:EmpleadoVO):void
		{
			executeServiceCall(empleadoService.empleadoBusqueda(empleado), empleadoBusquedaResult, empleadoFault);
		}
		
		private function empleadoBusquedaResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			empleadoModel.empleadosBusquedaList = event.result as ArrayCollection;
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_GUARDAR_HABILIDAD", properties="habilidad")]
		public function empleadoGuardaHabilidad(habilidad:HabilidadDTO):void
		{
			executeServiceCall(empleadoService.empleadoHabilidadSave(habilidad), empleadoHabilidadSaveResult, empleadoFault);
		}
		
		private function empleadoHabilidadSaveResult(event:ResultEvent):void
		{
			if(event.result){
				Alert.show("Se guardo habilidad");
				dispatcher.dispatchEvent(new EmpleadoEvent(EmpleadoEvent.EMPLEADO_BOTON_BUSCAR_EMPLEADO));
			}
			
		}	
		private var habilidadUsadaParaActualzar:HabilidadDTO;
		[EventHandler(event="EmpleadoEvent.EMPLEADO_ACTUALIZAR_HABILIDAD", properties="habilidad")]
		public function empleadoActualizarHabilidad(habilidad:HabilidadDTO):void
		{
			habilidadUsadaParaActualzar = habilidad;
			executeServiceCall(empleadoService.empleadoHabilidadActualizar(habilidad), empleadoHabilidadActualizarResult, empleadoFault);
		}
		
		private function empleadoHabilidadActualizarResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			dispatcher.dispatchEvent(new EmpleadoEvent(EmpleadoEvent.EMPLEADO_BOTON_BUSCAR_EMPLEADO));
			Alert.show("Se actualizó correctamente","");
		}
		
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_HABILIDAD_BORRAR", properties="habilidad")]
		public function empleadoBorrarHabilidad(habilidad:HabilidadDTO):void
		{
			executeServiceCall(empleadoService.empleadoBorrarHabilidad(habilidad), empleadoBorrarHabilidadResult,empleadoFault);
		}
		
		private function empleadoBorrarHabilidadResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
	}
}