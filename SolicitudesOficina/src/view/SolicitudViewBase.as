package view
{
	import event.EventSolicitud;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.FallaEquipoDTO;
	import model.ProcesoEstatusEnum;
	import model.ProveedorVO;
	import model.SolicitudModel;
	import model.SolicitudVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.events.ValidationResultEvent;
	import mx.validators.DateValidator;
	import mx.validators.NumberValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import spark.components.Group;
	
	import utils.NumberFormatUtil;
	
	public class SolicitudViewBase extends Group
	{
		[Inject]
		[Bindable]
		public var solicitudModel:SolicitudModel;
		
		private var solicitudView:SolicitudView = SolicitudView(this);
		private var eventSolicitud:EventSolicitud;

		public function SolicitudViewBase()
		{
			super();
		}
		
		/**
		 * Update los cambios realizados en las solicitudes
		 */
		protected function updateSolicitudes():void{
			eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_UPDATE);
			for each(var sol:SolicitudVO in solicitudModel.acSolicitudes){
				trace("estatus_proceso: " + sol.estatus_proceso);
			}
			trace("End for each");
			dispatchEvent(eventSolicitud);
		}
		
		/**
		 * Evento que se despacha al dar doble clic sobre una Adquisición (Un registro del grid de Adquisición)
		 */
		protected function solicitudSelected(_event:MouseEvent):void{
			if(_event.currentTarget.selectedItem != null){
				
			}
		}
		
	}
}