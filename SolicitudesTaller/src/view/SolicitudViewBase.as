package view
{
	import event.EventSolicitud;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.FallaEquipoDTO;
	import model.ProcesoEstatusEnum;
	import model.SolicitudModel;
	import model.SolicitudVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;
	
	import spark.components.Group;
	
	public class SolicitudViewBase extends Group
	{
		[Inject]
		[Bindable]
		public var solicitudModel:SolicitudModel;
		
		private var solicitudView:SolicitudView = SolicitudView(this);
		private var eventSolicitud:EventSolicitud;
		
		private const CREAR:String = "Crear";
		private const ACTUALIZAR:String = "Actualizar";
		
		/************	VALIDATOR'S	*********************/
		private var arrayValidationResult:Array;
		
		[Bindable]protected var flagCreateSolicitud:Boolean = false;
		[Bindable]protected var flagEmpleadoRequisicion:Boolean = true;
		[Bindable]protected var flagEmpleadoAdquisicion:Boolean = false;
		[Bindable]
		protected var acEstatus:ArrayCollection = new ArrayCollection([{estatus:ProcesoEstatusEnum.REQUISICION},{estatus:ProcesoEstatusEnum.ADQUISICION}]);
		
		public function SolicitudViewBase()
		{
			super();
		}
		
		/**
		 * Crear una nueva solicitud
		 */
		protected function createSolicitud():void{
			clearFormulario();
			flagCreateSolicitud = true;
			solicitudModel.solicitudSelected = new SolicitudVO();
			clearValidators();
		}
		
		/**
		 * Validate Handler Empleado Requisicion
		 */
		protected function validEmpleadoRequisicion(_event:ValidationResultEvent):void{
			solicitudView.autocompleteEmpleadoRequisicion.errorString = "";
		}
		
		/**
		 * Fault Handler Empleado Requisicion
		 */
		protected function invalidEmpleadoRequisicon(evt:ValidationResultEvent):void {
			solicitudView.autocompleteEmpleadoRequisicion.errorString = "Debes seleccionar un Empleado";
		}
		
		/**
		 * Validate Handler Artículo
		 */
		protected function validArticulo(_event:ValidationResultEvent):void{
			solicitudView.autocompleteArticulo.errorString = "";
		}
		
		/**
		 * Fault Handler Articulo
		 */
		protected function invalidArticulo(evt:ValidationResultEvent):void {
			solicitudView.autocompleteArticulo.errorString = "Debes seleccionar un Artículo";
		}
		
		/**
		 * Label Function para mostrar la marca y el nombre del Artícuo concatenados
		 */
		protected function labelFunctionNombre (item:Object):String{
			return item.nombre + " " + item.paterno + " " + item.materno;
		}
		
		/**
		 * Label Function para mostrar la marca y el nombre del Artícuo concatenados
		 */
		protected function labelFunctionMarcaArticulo (item:Object):String{
			return item.marca + " - " + item.descripcion;
		}
		
		/**
		 * Actualiza los datos de la Adquisición
		 */
		private function updateSolicitudDetalle():void{
			var flagAdd:Boolean = true;
			var articulo:ArticuloVO = null;
			var cantidad:int = 1;
			/*if(solicitudView.autocompleteArticulo.selectedItem != null){
				articulo = solicitudView.autocompleteArticulo.selectedItem as ArticuloVO;
				cantidad = solicitudView.ntsCantidadAdquirida.value;
			}*/
		}
		
		/**
		 * Change Estatus Process
		 * @param event Event Dropdown List
		 */
		protected function changeEstatusProceso(proceso:String):void{
			if(proceso != ""){
				if(proceso == ProcesoEstatusEnum.REQUISICION){
					flagEmpleadoRequisicion = true;
					flagEmpleadoAdquisicion = false;
				}else if(proceso == ProcesoEstatusEnum.ADQUISICION){
					flagEmpleadoAdquisicion = true;
					flagEmpleadoRequisicion = false;
				}else{
					flagEmpleadoAdquisicion = false;
					flagEmpleadoRequisicion = false;
				}
			}
		}
		
		/**
		 * Evento que se despacha al dar doble clic sobre una Adquisición (Un registro del grid de Adquisición)
		 */
		protected function solicitudSelected(_event:MouseEvent):void{
			clearValidators();
			if(_event.currentTarget.selectedItem != null){
				flagCreateSolicitud = true;
				solicitudModel.titleFormulario = SolicitudModel.ACTUALIZAR;
				solicitudModel.solicitudSelected = _event.currentTarget.selectedItem;
				if(solicitudModel.solicitudSelected.id_empleado_requisicion != null
					&& solicitudModel.solicitudSelected.id_empleado_requisicion != ""){
					for each(var e:EmpleadoVO in solicitudModel.acEmpleadosRequisicion){
						if(e.idEmpleado == solicitudModel.solicitudSelected.id_empleado_requisicion){
							solicitudView.autocompleteEmpleadoRequisicion.selectedItem = e;
							break;
						}
					}
				}
				if(solicitudModel.solicitudSelected.id_articulo != null 
					&& solicitudModel.solicitudSelected.id_articulo != ""){
					for each(var a:ArticuloVO in solicitudModel.acArticulos){
						if(a.idArticulo == solicitudModel.solicitudSelected.id_articulo){
							solicitudView.autocompleteArticulo.selectedItem = a;
							break;
						}
					}
				}
				
				if(solicitudModel.solicitudSelected.id_falla != null
					&& solicitudModel.solicitudSelected.id_falla != ""){
					for each(var f:FallaEquipoDTO in solicitudModel.acFallasEquipo){
						if(f.id_tfallas == solicitudModel.solicitudSelected.id_falla){
							solicitudView.autocompleteFalla.selectedItem = f;
							break;
						}
					}
				}
				solicitudView.txtNomSolicitud.text = solicitudModel.solicitudSelected.nombre_solicitud;
				solicitudView.txtCantidad.text = solicitudModel.solicitudSelected.cantidad;
				solicitudView.txtObservaciones.text = solicitudModel.solicitudSelected.observaciones;
				solicitudView.fechaRequisicion.selectedDate = DateField.stringToDate(solicitudModel.solicitudSelected.fecha_requisicion, "YYYY/MM/DD");
			}
		}
		
		/**
		 * Limpia el Formulario de la Adquisición Detalle
		 */
		public function clearFormulario():void{
			clearValidators();
			solicitudModel.titleFormulario = CREAR;
			flagCreateSolicitud = false;
			solicitudView.txtNomSolicitud.text = "";
			solicitudView.txtCantidad.text = "";
			solicitudView.txtObservaciones.text = "";
			solicitudView.autocompleteEmpleadoRequisicion.selectedItem = null;
			solicitudView.autocompleteArticulo.selectedItem = null;
			solicitudView.autocompleteFalla.selectedItem = null;
		}
		
		public function saveSolicitud():void{
			var flagValidation:Boolean = validateRequieres();
			if(arrayValidationResult.length == 0 && flagValidation){
				switch(solicitudModel.titleFormulario){
					case SolicitudModel.CREAR:
							saveUpdate();
							eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_SAVE_SOLICITUD);
							dispatchEvent(eventSolicitud);
							clearFormulario();
						break;
					case SolicitudModel.ACTUALIZAR:
							saveUpdate();
							eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_UPDATE);
							dispatchEvent(eventSolicitud);
							clearFormulario();
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 * Valida los campos Obligatorios
		 */
		private function validateRequieres():Boolean{
			if(solicitudView.autocompleteEmpleadoRequisicion.selectedItem != null){
				//Unicamente validamos los campos de la Requisicion
				arrayValidationResult = Validator.validateAll([solicitudView.validatorNombreSolicitud, solicitudView.validatorEmpleadoRequisicion,
					solicitudView.autocompleteArticulo, solicitudView.validatorCantidad, solicitudView.validatorFechaRequisicion]);
				return true;
			}else{
				clearValidators();
				return false;
			}
		}
		
		/**
		 * Limpia los validadores
		 */
		private function clearValidators():void{
			arrayValidationResult = new Array();
			solicitudView.txtNomSolicitud.errorString = "";
			solicitudView.autocompleteEmpleadoRequisicion.errorString = "";
			solicitudView.autocompleteArticulo.errorString = "";
			solicitudView.txtCantidad.errorString = "";
			solicitudView.fechaRequisicion.errorString = "";
		}
		
		/**
		 * Obtiene los datos del articulo de la pantalla y los setea a nuestro itemSelected
		 */
		public function saveUpdate():void{
			if(solicitudModel.solicitudSelected.id_solicitud == null || solicitudModel.solicitudSelected.id_solicitud == ""){
				solicitudModel.solicitudSelected = new SolicitudVO();
			}
			if(solicitudView.autocompleteEmpleadoRequisicion.selectedItem != null){
				solicitudModel.solicitudSelected.id_empleado_requisicion = EmpleadoVO(solicitudView.autocompleteEmpleadoRequisicion.selectedItem).idEmpleado;
			}
			if(solicitudView.autocompleteArticulo.selectedItem != null){
				solicitudModel.solicitudSelected.id_articulo = ArticuloVO(solicitudView.autocompleteArticulo.selectedItem).idArticulo;
			}
			solicitudModel.solicitudSelected.cantidad = solicitudView.txtCantidad.text;
			if(solicitudView.autocompleteFalla.selectedItem != null){
				solicitudModel.solicitudSelected.id_falla = FallaEquipoDTO(solicitudView.autocompleteFalla.selectedItem).id_tfallas; 
			}
			if(solicitudView.fechaRequisicion.selectedDate != null
				&& solicitudView.fechaRequisicion.enabled){
				var dateSolicitud:Date = solicitudView.fechaRequisicion.selectedDate;
				if(dateSolicitud == null){
					solicitudView.fechaRequisicion.errorString = "Debes ingresar la fecha de adquisición."
				}else{
					solicitudModel.solicitudSelected.fecha_requisicion = dateSolicitud.getFullYear().toString() +	'/' + (dateSolicitud.getMonth()+1).toString() + '/' + dateSolicitud.getDate();
					solicitudView.fechaRequisicion.errorString = "";
				}
			}
			solicitudModel.solicitudSelected.nombre_solicitud 	= solicitudView.txtNomSolicitud.text;
			solicitudModel.solicitudSelected.observaciones 		= solicitudView.txtObservaciones.text;
			solicitudModel.solicitudSelected.estatus_proceso 	= ProcesoEstatusEnum.REQUISICION;
		}
		
		
		/**
		 * Elimina la Adquisición
		 */
		public function deleteSolicitud():void{
			if(solicitudModel.solicitudSelected != null){
				eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_DELETE_SOLICITUD);
				dispatchEvent(eventSolicitud);
				flagCreateSolicitud = false;
				clearFormulario();
			}
		}
		
		public function findArticulos():void{
			var articulo:ArticuloVO = new ArticuloVO();
			eventSolicitud = new EventSolicitud(EventSolicitud.EVENT_FIND_ARTICULOS);
			eventSolicitud.articuloVO = articulo;
			dispatchEvent(eventSolicitud);
		}
	}
}