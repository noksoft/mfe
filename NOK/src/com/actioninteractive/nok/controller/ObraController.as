package com.actioninteractive.nok.controller
{
	import com.actioninteractive.nok.delegate.ObraService;
	import com.actioninteractive.nok.event.CRUDEvent;
	import com.actioninteractive.nok.event.ObraEvent;
	import com.actioninteractive.nok.model.ObraModel;
	import com.actioninteractive.nok.view.body.portlet.CatalogoObras;
	import com.actioninteractive.nok.vo.ObraVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;

	public class ObraController extends AbstractController
	{
		public var obraService:ObraService = new ObraService();
		public function ObraController()
		{
			super();
		}
		[Inject]
		public var obraModel:ObraModel;
		[PostConstruct]
		public function init():void
		{
			
		}
		private function obraFault(event:FaultEvent):void
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
		[EventHandler(event="ObraEvent.OBRA_LIST_DATA", properties="obraVO")]
		public function getListObras(obra:ObraVO):void
		{
			trace("Event-----> OBRA_LIST_DATA");
			
			executeServiceCall(obraService.catObraService(obra),catObraResult,obraFault);
			
		}
		private function catObraResult(event:ResultEvent):void
		{
			if (event.result == null)
			{
				Alert.show("No hay obras en la base de información");
			}else
			{
				obraModel.acListObras = event.result as ArrayCollection;
				trace(obraModel.acListObras.length);
			}
			
		}
		
		[EventHandler(event="ObraEvent.OBRA_SAVE_DATA", properties="obraVO")]
		public function saveObra(obra:ObraVO):void
		{
			trace("Event-----> OBRA_SAVE_DATA");
			
			executeServiceCall(obraService.saveObraService(obra),saveObraServiceResult,obraFault);
			
		}
		
		private function saveObraServiceResult(event:ResultEvent):void
		{
			//Guardando con exito
			try
			{
				
					var resetControlsEvent:ObraEvent = new ObraEvent(ObraEvent.OBRA_RESET_CONTROLS);
					dispatcher.dispatchEvent(resetControlsEvent);
					Alert.show("Obra guardada y activada","Obra");
					
				
			} 
			catch(error:Error) 
			{
				Alert.show(error.message, "Error");
			}
		}
		
		[EventHandler(event="ObraEvent.OBRA_UPDATE_DATA", properties="obraVO")]
		public function udateObra(obra:ObraVO):void
		{
			trace("Event-----> OBRA_UPDATE_DATA");
			
			executeServiceCall(obraService.updateObraService(obra),updateObraServiceResult,obraFault);
			
		}
		public function updateObraServiceResult(event:ResultEvent):void
		{
			//Dispara el evento 
			var resetControlsEvent:ObraEvent = new ObraEvent(ObraEvent.OBRA_RESET_CONTROLS);
			dispatcher.dispatchEvent(resetControlsEvent);
			Alert.show("Obra actualizada","Obra");
		}
		
		[EventHandler(event="ObraEvent.OBRA_BUSQUEDA_DATA", properties="obraVO")]
		public function busquedaObra(obra:ObraVO):void
		{
			trace("Event-----> OBRA_BUSQUEDA_DATA");
			
			executeServiceCall(obraService.catObraService(obra),busquedaObraServiceResult,obraFault);
			
		}
		
		private function busquedaObraServiceResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			obraModel.acListObrasEncontradas = e.result as ArrayCollection;
			dispatcher.dispatchEvent(new ObraEvent(ObraEvent.OBRA_ITEM_FOUND_DATA));	
		}
		
		[EventHandler(event="ObraEvent.OBRA_DELETE_DATA", properties="obraVO")]
		public function deleteObra(obra:ObraVO):void
		{
			executeServiceCall(obraService.deleteObraService(obra),deleteObraServiceResult,obraFault);

		}
		
		private function deleteObraServiceResult():void
		{
			// TODO Auto Generated method stub
			trace('Registro Borrado ::::');
		}
		
	}
}