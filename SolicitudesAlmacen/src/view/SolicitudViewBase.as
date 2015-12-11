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
		
		private const CREAR:String = "Crear";
		private const ACTUALIZAR:String = "Actualizar";
		
		/************	VALIDATOR'S	*********************/
		private var arrayValidationResult:Array;
		
		[Bindable]protected var flagCreateSolicitud:Boolean = false;
		[Bindable]protected var flagEmpleadoRequisicion:Boolean = false;
		[Bindable]protected var flagCuentaBancaria:Boolean = false;
		[Bindable]
		protected var acEstatus:ArrayCollection = new ArrayCollection([{estatus:ProcesoEstatusEnum.REQUISICION},{estatus:ProcesoEstatusEnum.ADQUISICION}]);
		
		public function SolicitudViewBase()
		{
			super();
		}
		
		/**
		 * Validate Handler Empleado Requisicion
		 */
		protected function validEmpleadoRequisicion(_event:ValidationResultEvent):void{
			solicitudView.autocompleteEmpleadoRequisicion.errorString = "";
			//viewArticulo.cmbSubCategoriaEditor.errorString = "Debe de seleccionar la SubCategoía";
		}
		
		/**
		 * Fault Handler Empleado Requisicion
		 */
		protected function invalidEmpleadoRequisicon(evt:ValidationResultEvent):void {
			solicitudView.autocompleteEmpleadoRequisicion.errorString = "Debes seleccionar un Empleado";
		}
		
		/**
		 * Validate Handler Empleado Adquisición
		 */
		protected function validEmpleadoAdquisicion(_event:ValidationResultEvent):void{
			solicitudView.autocompleteEmpleadoAdquisicion.errorString = "";
			//viewArticulo.cmbSubCategoriaEditor.errorString = "Debe de seleccionar la SubCategoía";
		}
		
		/**
		 * Fault Handler Empleado Adquisición
		 */
		protected function invalidEmpleadoAdquisicion(evt:ValidationResultEvent):void {
			solicitudView.autocompleteEmpleadoAdquisicion.errorString = "Debes seleccionar un Empleado";
		}
		
		/**
		 * Validate Handler Proveedor
		 */
		protected function validProveedor(_event:ValidationResultEvent):void{
			solicitudView.autocompleteProveedor.errorString = "";
		}
		
		/**
		 * Fault Handler Proveedor
		 */
		protected function invalidProveedor(evt:ValidationResultEvent):void {
			solicitudView.autocompleteProveedor.errorString = "Debes seleccionar un Proveedor";
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
		 * Validate Handler Forma de Pago
		 */
		protected function validFormaPago(_event:ValidationResultEvent):void{
			solicitudView.cmbFormaPago.errorString = "";
		}
		
		/**
		 * Fault Handler Falla
		 */
		protected function invalidFormaPago(evt:ValidationResultEvent):void {
			solicitudView.cmbFormaPago.errorString = "Debes seleccionar una Forma de Pago";
		}
		/**
		 * Crear una nueva solicitud
		 */
		protected function createSolicitud():void{
			flagCreateSolicitud = true;
			flagEmpleadoRequisicion = true;
			solicitudModel.solicitudSelected = new SolicitudVO();
			clearValidators();
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
		 * Change Estatus Process
		 * @param event Event Dropdown List
		 */
		protected function changeEstatusProceso(proceso:String):void{
			Alert.show(proceso);
			if(proceso != ""){
				if(proceso == ProcesoEstatusEnum.REQUISICION){
					flagEmpleadoRequisicion = true;
				}else if(proceso == ProcesoEstatusEnum.ADQUISICION){
					flagEmpleadoRequisicion = false;
				}else{
					flagEmpleadoRequisicion = false;
				}
			}
		}
		
		/**
		 * Change DropdownList Forma Pago
		 */
		protected function changeFormaPago():void{
			if(solicitudView.cmbFormaPago.selectedItem != null){
				switch(solicitudView.cmbFormaPago.selectedItem){
					case "Efectivo":
							flagCuentaBancaria = false;
						break;
					case "Transferencia":
							flagCuentaBancaria = true;
						break;
					default:
						break;
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
				
				solicitudView.lblProceso.text = solicitudModel.solicitudSelected.estatus_proceso;
				
				//Empleado Requisicion
				if(solicitudModel.solicitudSelected.id_empleado_requisicion != null
					&& solicitudModel.solicitudSelected.id_empleado_requisicion != ""){
					for each(var e:EmpleadoVO in solicitudModel.acEmpleadosRequisicion){
						if(e.idEmpleado == solicitudModel.solicitudSelected.id_empleado_requisicion){
							solicitudView.autocompleteEmpleadoRequisicion.selectedItem = e;
							break;
						}
					}
				}
				
				//Empleado Adquisicion
				if(solicitudModel.solicitudSelected.id_empleado_adquisicion != null
						&& solicitudModel.solicitudSelected.id_empleado_adquisicion != ""){
					for each(var ea:EmpleadoVO in solicitudModel.acEmpleadosAdquisicion){
						if(ea.idEmpleado == solicitudModel.solicitudSelected.id_empleado_adquisicion){
							solicitudView.autocompleteEmpleadoAdquisicion.selectedItem = ea;
							break;
						}
					}
					
				}
				
				//Articulo
				if(solicitudModel.solicitudSelected.id_articulo != null 
					&& solicitudModel.solicitudSelected.id_articulo != ""){
					for each(var a:ArticuloVO in solicitudModel.acArticulos){
						if(a.idArticulo == solicitudModel.solicitudSelected.id_articulo){
							solicitudView.autocompleteArticulo.selectedItem = a;
							break;
						}
					}
				}
				
				//Falla
				if(solicitudModel.solicitudSelected.id_falla != null
					&& solicitudModel.solicitudSelected.id_falla != ""){
					for each(var f:FallaEquipoDTO in solicitudModel.acFallasEquipo){
						if(f.id_tfallas == solicitudModel.solicitudSelected.id_falla){
							solicitudView.autocompleteFalla.selectedItem = f;
							break;
						}
					}
				}
				
				//Proveedor
				if(solicitudModel.solicitudSelected.id_prooveedor != null
						&& solicitudModel.solicitudSelected.id_prooveedor != ""){
					for each(var p:ProveedorVO in solicitudModel.acProveedor){
						if(solicitudModel.solicitudSelected.id_prooveedor == p.idProveedor){
							solicitudView.autocompleteProveedor.selectedItem = p;
							break;
						}
					}
				}
				
				solicitudView.txtNomSolicitud.text = solicitudModel.solicitudSelected.nombre_solicitud;
				solicitudView.txtCantidad.text = solicitudModel.solicitudSelected.cantidad;
				//Costo
				solicitudView.txtCosto.text = NumberFormatUtil.formatThousandsNumber(Number(solicitudModel.solicitudSelected.costo_unidad));
				//Total
				solicitudView.lblTotal.text = NumberFormatUtil.formatThousandsNumber(Number(solicitudModel.solicitudSelected.costo_total));
				
				if(solicitudModel.solicitudSelected.forma_pago != ""){
					switch(solicitudModel.solicitudSelected.forma_pago){
						case "Efectivo":
								flagCuentaBancaria = false;
							break;
						case "Transferencia":
								flagCuentaBancaria = true;
							break;
						default:
							break;
					}
					solicitudView.cmbFormaPago.selectedItem = solicitudModel.solicitudSelected.forma_pago;
					
				}
				solicitudView.txtTiempoEntrega.text = solicitudModel.solicitudSelected.tiempo_entrega;
				solicitudView.txtObservaciones.text = solicitudModel.solicitudSelected.observaciones;
				if(solicitudModel.solicitudSelected.fecha_requisicion != null
						&& solicitudModel.solicitudSelected.fecha_requisicion != ""){
					solicitudView.fechaRequisicion.selectedDate = DateField.stringToDate(solicitudModel.solicitudSelected.fecha_requisicion, "YYYY/MM/DD");
				}
				if(solicitudModel.solicitudSelected.fecha_adquisicion != null
						&& solicitudModel.solicitudSelected.fecha_adquisicion != ""){
					solicitudView.fechaAdquisicion.selectedDate = DateField.stringToDate(solicitudModel.solicitudSelected.fecha_adquisicion, "YYYY/MM/DD");
				}
				
			}
		}
		
		/**
		 * Calcula los valores del costo y total de acuerdo a la cantidad ingresada y el costo por unidad
		 */
		public function calCosto():void{
			if(solicitudView.txtCosto.text != "" 
					&& solicitudView.txtCosto.text != "0"){
				//removeCharacter();
				solicitudView.txtCosto.text = NumberFormatUtil.removeCharacter(solicitudView.txtCosto.text);
				if(solicitudView.txtCantidad.text != ""){
					solicitudView.lblTotal.text = NumberFormatUtil.formatThousandsNumber(Number(solicitudView.txtCantidad.text) * Number(solicitudView.txtCosto.text), 3);
				}
				solicitudView.txtCosto.text = NumberFormatUtil.formatThousandsNumber(Number(solicitudView.txtCosto.text), 3);
			}
		}
		
		/**
		 * Calc Value for Costo
		 */
		public function changeCosto():void{
			solicitudView.txtCosto.text = NumberFormatUtil.removeCharacter(solicitudView.txtCosto.text);
		}
		
		/**
		 * Limpia el Formulario de la Adquisición Detalle
		 */
		public function clearFormulario():void{
			clearValidators();
			solicitudModel.titleFormulario = CREAR;
			flagCuentaBancaria = false
			flagCreateSolicitud = true;
			flagEmpleadoRequisicion = true;
			solicitudView.txtNomSolicitud.text = "";
			solicitudView.lblProceso.text = "";
			if(solicitudView.autocompleteEmpleadoRequisicion.selectedItem != null
					&& solicitudView.autocompleteEmpleadoRequisicion.selectedItem != ""){
				solicitudView.autocompleteEmpleadoRequisicion.selectedItem = null;
			}
			if(solicitudView.autocompleteEmpleadoAdquisicion.selectedItem != null
				&& solicitudView.autocompleteEmpleadoAdquisicion.selectedItem != ""){
				solicitudView.autocompleteEmpleadoAdquisicion.selectedItem = null;
			}
			if(solicitudView.autocompleteProveedor.selectedItem != null
				&& solicitudView.autocompleteProveedor.selectedItem != ""){
				solicitudView.autocompleteProveedor.selectedItem = null;
			}
			if(solicitudView.autocompleteArticulo.selectedItem != null
				&& solicitudView.autocompleteArticulo.selectedItem != ""){
				solicitudView.autocompleteArticulo.selectedItem = null;
			}
			solicitudView.txtCantidad.text = "";
			solicitudView.txtCosto.text = "";
			solicitudView.lblTotal.text = "";
			if(solicitudView.autocompleteFalla.selectedItem != null
				&& solicitudView.autocompleteFalla.selectedItem != ""){
				solicitudView.autocompleteFalla.selectedItem = null;
			}
			solicitudView.fechaRequisicion.selectedDate = null;
			solicitudView.fechaAdquisicion.selectedDate = null;
			solicitudView.txtTiempoEntrega.text = "";
			solicitudView.cmbFormaPago.selectedItem = null;
			solicitudView.txtCuentaBancaria.text = "";
			solicitudView.txtObservaciones.text = "";
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
		 * Limpia los validadores
		 */
		private function clearValidators():void{
			arrayValidationResult = new Array();
			solicitudView.txtNomSolicitud.errorString = "";
			solicitudView.autocompleteEmpleadoRequisicion.errorString = "";
			solicitudView.autocompleteEmpleadoAdquisicion.errorString = "";
			solicitudView.autocompleteProveedor.errorString = "";
			solicitudView.autocompleteArticulo.errorString = "";
			solicitudView.txtCantidad.errorString = "";
			solicitudView.txtCosto.errorString = "";
			solicitudView.fechaRequisicion.errorString = "";
			solicitudView.fechaAdquisicion.errorString = "";
			solicitudView.txtTiempoEntrega.errorString = "";
			solicitudView.cmbFormaPago.errorString = "";
		}
		
		/**
		 * Valida los campos Obligatorios
		 */
		private function validateRequieres():Boolean{
			if(solicitudView.autocompleteEmpleadoRequisicion.selectedItem != null){
				if(solicitudView.autocompleteEmpleadoAdquisicion.selectedItem != null){
					//Vamos a validar todos los campos
					arrayValidationResult = Validator.validateAll([solicitudView.validatorNombreSolicitud, solicitudView.validatorEmpleadoRequisicion,
										solicitudView.validatorEmpleadoAdquisicion, solicitudView.validatorProveedor, solicitudView.validatorArticulo,
										solicitudView.validatorCantidad, solicitudView.validatorCosto, solicitudView.validatorFechaRequisicion,
										solicitudView.validatorFechaAdquisicion, solicitudView.validatorTiempoEntrega, solicitudView.validatorFormaPago]);
					return true;
				}else{
					//Unicamente validamos los campos de la Requisicion
					arrayValidationResult = Validator.validateAll([solicitudView.validatorNombreSolicitud, solicitudView.validatorEmpleadoRequisicion,
						solicitudView.validatorArticulo, solicitudView.validatorCantidad, solicitudView.validatorFechaRequisicion]);
					return true;
				}
			}else if (solicitudView.autocompleteEmpleadoAdquisicion.selectedItem != null){
				//Validamos los campos de una Adquisición
				arrayValidationResult = Validator.validateAll([solicitudView.validatorNombreSolicitud, solicitudView.validatorEmpleadoAdquisicion, 
										solicitudView.validatorProveedor, solicitudView.validatorArticulo, solicitudView.validatorCantidad, 
										solicitudView.validatorCosto, solicitudView.validatorFechaAdquisicion, solicitudView.validatorTiempoEntrega, 
										solicitudView.validatorFormaPago]);
				return true;
			}else{
				clearValidators();
				return false;
			}
		}
		
		/**
		 * Obtiene los datos del articulo de la pantalla y los setea a nuestro itemSelected
		 */
		public function saveUpdate():void{
			
			//Nombre Solicitud
			solicitudModel.solicitudSelected.nombre_solicitud = solicitudView.txtNomSolicitud.text;
			
			//Empleado Requisición
			if(solicitudView.autocompleteEmpleadoRequisicion.selectedItem != null
					&& solicitudView.autocompleteEmpleadoRequisicion.selectedItem != ""){
				solicitudModel.solicitudSelected.id_empleado_requisicion = EmpleadoVO(solicitudView.autocompleteEmpleadoRequisicion.selectedItem).idEmpleado;
			}
			
			//Empleado Adquisición
			if(solicitudView.autocompleteEmpleadoAdquisicion.selectedItem != null
					&& solicitudView.autocompleteEmpleadoAdquisicion.selectedItem != ""){
				solicitudModel.solicitudSelected.id_empleado_adquisicion = EmpleadoVO(solicitudView.autocompleteEmpleadoAdquisicion.selectedItem).idEmpleado;
			}
			
			//Proveedor
			if(solicitudView.autocompleteProveedor.selectedItem != null){
				solicitudModel.solicitudSelected.id_prooveedor = ProveedorVO(solicitudView.autocompleteProveedor.selectedItem).idProveedor;
			}
			
			//Artículo
			if(solicitudView.autocompleteArticulo.selectedItem != null){
				solicitudModel.solicitudSelected.id_articulo = ArticuloVO(solicitudView.autocompleteArticulo.selectedItem).idArticulo;
			}
			
			//Cantidad
			solicitudModel.solicitudSelected.cantidad = solicitudView.txtCantidad.text;
			//Costo
			solicitudModel.solicitudSelected.costo_unidad = NumberFormatUtil.removeCharacter(solicitudView.txtCosto.text);
			//Costo Total
			solicitudModel.solicitudSelected.costo_total = NumberFormatUtil.removeCharacter(solicitudView.lblTotal.text);
			
			//Falla
			if(solicitudView.autocompleteFalla.selectedItem != null){
				solicitudModel.solicitudSelected.id_falla = FallaEquipoDTO(solicitudView.autocompleteFalla.selectedItem).id_tfallas; 
			}
			
			//Fecha Requisición
			if(solicitudView.fechaRequisicion.selectedDate != null
				&& solicitudView.fechaRequisicion.enabled){
				var dateSolicitud:Date = solicitudView.fechaRequisicion.selectedDate;
				if(dateSolicitud == null){
					solicitudView.fechaRequisicion.errorString = "Debes ingresar la fecha de Requisición."
				}else{
					solicitudModel.solicitudSelected.fecha_requisicion = dateSolicitud.getFullYear().toString() +	'/' + (dateSolicitud.getMonth()+1).toString() + '/' + dateSolicitud.getDate();
					solicitudView.fechaRequisicion.errorString = "";
				}
			}
			
			//Fecha Adquisición
			if(solicitudView.fechaAdquisicion.selectedDate != null){
				var dateAdquisicion:Date = solicitudView.fechaAdquisicion.selectedDate;
				if(dateAdquisicion == null){
					solicitudView.fechaAdquisicion.errorString = "Debes ingresar la fecha de Adquisición";
				}else{
					solicitudModel.solicitudSelected.fecha_adquisicion = dateAdquisicion.getFullYear().toString() + '/' + (dateAdquisicion.getMonth()+1).toString() + '/' + dateAdquisicion.getDate();
					solicitudView.fechaAdquisicion.errorString = "";
				}
			}
			
			//Tiempo de Entrega
			solicitudModel.solicitudSelected.tiempo_entrega = solicitudView.txtTiempoEntrega.text;
			
			//Actualiza el Estatus del Proceso
			switch(solicitudModel.solicitudSelected.estatus_proceso){
				case ProcesoEstatusEnum.REQUISICION:
					if(solicitudModel.solicitudSelected.id_empleado_adquisicion != null 
							&& solicitudModel.solicitudSelected.id_empleado_adquisicion != ""){
						solicitudModel.solicitudSelected.estatus_proceso = ProcesoEstatusEnum.ADQUISICION;
					}
					break;
				default:
					break;
			}
			
			//Forma PAgo
			if(solicitudView.cmbFormaPago.selectedItem != null){
				solicitudModel.solicitudSelected.forma_pago = solicitudView.cmbFormaPago.selectedItem;
			}
			
			//Observaciones
			solicitudModel.solicitudSelected.observaciones 		= solicitudView.txtObservaciones.text;
			
			//Este flujo se ejecutará unicamente para las solicitudes nuevas
			if(solicitudModel.solicitudSelected.id_solicitud != null
				&& solicitudModel.solicitudSelected.id_solicitud == ""){
				if(solicitudModel.solicitudSelected.id_empleado_requisicion != null
					&& solicitudModel.solicitudSelected.id_empleado_requisicion != ""){
					if(solicitudModel.solicitudSelected.id_empleado_adquisicion != null
						&& solicitudModel.solicitudSelected.id_empleado_adquisicion != ""){
						solicitudModel.solicitudSelected.estatus_proceso = ProcesoEstatusEnum.ADQUISICION;	
					}else{
						solicitudModel.solicitudSelected.estatus_proceso = ProcesoEstatusEnum.REQUISICION;
					}
					
				}
			}
		}
		
		
		/**
		 * Elimina la Adquisición
		 */
		public function deleteSolicitud():void{
			if(solicitudModel.solicitudSelected != null
					&& solicitudModel.solicitudSelected.id_solicitud != null
					&& solicitudModel.solicitudSelected.id_solicitud != ""){
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