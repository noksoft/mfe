package com.actioninteractive.nok.controller
{
	import com.actioninteractive.nok.delegate.DireccionService;
	import com.actioninteractive.nok.event.DireccionEvent;
	import com.actioninteractive.nok.model.DireccionModel;
	import com.actioninteractive.nok.model.ObraModel;
	import com.actioninteractive.nok.vo.direccion.EntidadVO;
	import com.actioninteractive.nok.vo.direccion.LocalidadVO;
	import com.actioninteractive.nok.vo.direccion.MunicipioVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	public class DireccionController extends AbstractController
	{
		public var direccionService:DireccionService = new DireccionService();
		public function DireccionController()
		{
			super();
		}
		[Inject]
		public var direccionModel:DireccionModel;
		
		[PostConstruct]
		public function init():void
		{
			var entidad:EntidadVO = new EntidadVO();
			
			executeServiceCall(direccionService.catEntidadService(entidad),catEntidadResult,direccionFault);
		}
		
		[EventHandler(event="DireccionEvent.ENTIDAD_LIST_DATA", properties="entidadVO")]
		public function getListEntidad(entidad:EntidadVO):void
		{
			trace("Event-----> ENTIDAD_LIST_DATA");
			
			executeServiceCall(direccionService.catEntidadService(entidad),catEntidadResult,direccionFault);
		}
		
		private function direccionFault(event:FaultEvent):void
		{
			// TODO Auto Generated method stub
			Alert.show(event.message.toString(),"Error");
		}
		
		private function catEntidadResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			try
			{
				direccionModel.acListEntidad = event.result as ArrayCollection	
			} 
			catch(error:Error) 
			{
				Alert.show(error.message,"Error");
			}
			
		}
		
		[EventHandler(event="DireccionEvent.MUNICIPIO_LIST_DATA", properties="municipioVO")]
		public function getListMunicipio(municipio:MunicipioVO):void
		{
			trace("Event-----> MUNICIPIO_LIST_DATA");
			
			executeServiceCall(direccionService.catMunicipioService(municipio),catMunicipioResult,direccionFault);
		}
		
		private function catMunicipioResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			try
			{
				direccionModel.acListMunicipio = event.result as ArrayCollection;
				if(direccionModel.entidadLocated)
				{
					var localizaMunicipioEvent:DireccionEvent  = new DireccionEvent(DireccionEvent.LOCALIZA_MUNICIPIO);
					dispatcher.dispatchEvent(localizaMunicipioEvent);
				}
			}
			catch(error:Error) 
			{
				Alert.show(error.message, "Error");
			}
			
		}
		
		[EventHandler(event="DireccionEvent.LOCALIDAD_LIST_DATA", properties="localidadVO")]
		public function getListLocalidad(localidad:LocalidadVO):void
		{
			trace("Event-----> LOCALIDAD_LIST_DATA");
			
			executeServiceCall(direccionService.catLocalidadService(localidad),catLocalidadResult,direccionFault);
		}
		
		private function catLocalidadResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			try
			{
				direccionModel.acListLocalidad = event.result as ArrayCollection;	
				if(direccionModel.municipioLocated)
				{
					var localizaLocalidadEvent:DireccionEvent  = new DireccionEvent(DireccionEvent.LOCALIZA_LOCALIDAD);
					dispatcher.dispatchEvent(localizaLocalidadEvent);
				}
			} 
			catch(error:Error) 
			{
				Alert.show(error.message, "Error");
			}
			
		}
	}
}