package view
{
	import event.RequisicionEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.ArticuloVO;
	import model.EmpleadoVO;
	import model.ProcesoEstatusEnum;
	import model.RequisicionDetalleDTO;
	import model.RequisicionModel;
	import model.RequisicionVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DateField;
	import mx.utils.object_proxy;
	
	import spark.components.Group;
	
	public class RequisicionViewBase extends Group
	{
		[Inject]
		[Bindable]
		public var requisicionModel:RequisicionModel;
		
		private var requisicionView:RequisicionView = RequisicionView(this);
		private var eventRequisicion:RequisicionEvent;
		
		[Bindable]protected var flagMarca:Boolean = false;
		[Bindable]protected var flagSubmarca:Boolean = false;
		
		public const AGREGAR_REQUISICION_DETALLE:String = "Agregar +";
		public const ACTUALIZAR_REQUISICON_DETALLE:String = "Actualizar";
		
		[Bindable]protected var titleButtonRequisicionDetalle:String = AGREGAR_REQUISICION_DETALLE;
		[Bindable]protected var flagAutocomplete:Boolean = true;
		
		public function RequisicionViewBase(){
			super();
		}
		public function init():void{
			var requisicionEvent:RequisicionEvent = new RequisicionEvent(RequisicionEvent.EVENT_FIND_REQUISICIONES);
			requisicionEvent.requisicionVO = new RequisicionVO();
			dispatchEvent(requisicionEvent);
			
			var articuloEvent:RequisicionEvent = new RequisicionEvent(RequisicionEvent.EVENT_FIND_ARTICULOS);
			articuloEvent.articuloVO = new ArticuloVO();
			dispatchEvent(articuloEvent);
			
			
			var empleadosEvent:RequisicionEvent = new RequisicionEvent(RequisicionEvent.EVENT_FIND_EMPLEADOS);
			empleadosEvent.empleadoVO = new EmpleadoVO();
			dispatchEvent(empleadosEvent);
		}
		
		public function addRequisicionDetalle():void{
			updateRequisicionDetalle();
		}
		
		public function activarDesactivar(_event:Event, data:*):void{
			var flag:Boolean = _event.currentTarget.selected as Boolean;
			var requisicionDetalle:RequisicionDetalleDTO = data as RequisicionDetalleDTO;
			if(requisicionDetalle.idRequisicionDetalle != null
				&& requisicionDetalle.idRequisicionDetalle != ""){
				requisicionDetalle.estatusRequisicionDetalle = (flag ? ProcesoEstatusEnum.NUEVO : ProcesoEstatusEnum.BAJA);
			}else{
				for(var i:int = 0; i < requisicionModel.acRequisicionesDetalle.length; i++){
					var tempReq:RequisicionDetalleDTO = requisicionModel.acRequisicionesDetalle[i] as RequisicionDetalleDTO;
					if(tempReq.idArticulo == requisicionDetalle.idArticulo){
						requisicionModel.acRequisicionesDetalle.removeItemAt(i);
						break;
					}
				}
			}
		}
		
		private function updateRequisicionDetalle():void{
			var flagAdd:Boolean = true;
			var articulo:ArticuloVO = null;
			var cantidad:int = 1;
			if(requisicionView.articuloComplete.selectedItem != null){
				articulo = requisicionView.articuloComplete.selectedItem as ArticuloVO;
				cantidad = requisicionView.ntsCantidadRequerida.value;
				if(requisicionModel.acRequisicionesDetalle.length > 0){
					for each(var obj:RequisicionDetalleDTO in requisicionModel.acRequisicionesDetalle){
						if(obj.idArticulo == articulo.idArticulo){
							if(obj.idRequisicionDetalle != null
								&& obj.idRequisicionDetalle != ""){
								obj.estatusRequisicionDetalle = ProcesoEstatusEnum.ACTUALIZADO;
							}else{
								obj.estatusRequisicionDetalle = ProcesoEstatusEnum.NUEVO;
							}
							obj.cantidadRequerida = cantidad.toString();
							flagAdd = false;
							break;
						}
					}
					if(flagAdd){
						if(requisicionModel.requisicionDetalleSelected != null
							&& requisicionModel.requisicionDetalleSelected.idRequisicionDetalle != null
							&& requisicionModel.requisicionDetalleSelected.idRequisicionDetalle != ""){
								requisicionModel.requisicionDetalleSelected.estatusRequisicionDetalle = ProcesoEstatusEnum.ACTUALIZADO;
								requisicionModel.requisicionDetalleSelected.cantidadRequerida = cantidad.toString();
						}else{
							requisicionModel.requisicionDetalleSelected = new RequisicionDetalleDTO(ProcesoEstatusEnum.NUEVO, articulo.idArticulo.toString(), cantidad.toString(), articulo.descripcion);
							requisicionModel.acRequisicionesDetalle.addItem(requisicionModel.requisicionDetalleSelected);
						}
					}
				}else{
					requisicionModel.requisicionDetalleSelected = new RequisicionDetalleDTO(ProcesoEstatusEnum.NUEVO, articulo.idArticulo.toString(), cantidad.toString(), articulo.descripcion);
					requisicionModel.acRequisicionesDetalle.addItem(requisicionModel.requisicionDetalleSelected);
				}
			}

			cleanFormularioRequisicionDetalle();
		}
		
		private function cleanFormularioRequisicionDetalle():void{
			flagAutocomplete = true;
			requisicionModel.requisicionDetalleSelected = null;
			titleButtonRequisicionDetalle = AGREGAR_REQUISICION_DETALLE;
			//requisicionView.articuloComplete.selectedItem = null;
			requisicionView.articuloComplete.removeAll();
			requisicionView.ntsCantidadRequerida.value = 0;
		}
		
		public function requisicionSelected(_event:MouseEvent):void{
			if(_event.currentTarget.selectedItem != null){
				requisicionModel.titleFormulario = RequisicionModel.ACTUALIZAR;
				requisicionModel.requisicionSelected = _event.currentTarget.selectedItem;
				requisicionView.vsRequisicion.selectedIndex = 1;
				for each(var emp:EmpleadoVO in requisicionModel.acEmpleadosRequisicion){
					if(emp.idEmpleado == requisicionModel.requisicionSelected.idEmpleadoRequisicion){
						requisicionView.cmbEmpleadoRequisicion.selectedItem = emp;
						break;
					}
				}
				requisicionModel.acRequisicionesDetalle = requisicionModel.requisicionSelected.listRequisicionDetalle;
				requisicionView.dateFieldFechaRequisicion.selectedDate = DateField.stringToDate(requisicionModel.requisicionSelected.fechaRequisicion, "YYYY/MM/DD");
			}
		}
		
		[EventHanlder(event="RequisicionEvent.EVENT_SAVE_SUCCEFULL")]
		public function saveSuccefull():void{
			requisicionView.vsRequisicion.selectedIndex = 0;
		}
		
		public function requisicionDetalleSelected(_event:MouseEvent):void{
			if(_event.currentTarget.selectedItem != null){
				flagAutocomplete = false;
				titleButtonRequisicionDetalle = ACTUALIZAR_REQUISICON_DETALLE;
				requisicionModel.requisicionDetalleSelected = _event.currentTarget.selectedItem;
				if(requisicionModel.requisicionDetalleSelected.idRequisicionDetalle != null 
					&& requisicionModel.requisicionDetalleSelected.idRequisicionDetalle != ""){
					requisicionModel.requisicionDetalleSelected.estatusRequisicionDetalle = ProcesoEstatusEnum.ACTUALIZADO;
				}else{
					requisicionModel.requisicionDetalleSelected.estatusRequisicionDetalle = ProcesoEstatusEnum.NUEVO;
				}
				
				if(requisicionModel.requisicionDetalleSelected.idArticulo != null 
					&& requisicionModel.requisicionDetalleSelected.idArticulo != ""){
					for each (var a:ArticuloVO in requisicionModel.acArticulos){
						if(a.idArticulo == requisicionModel.requisicionDetalleSelected.idArticulo){
							requisicionView.articuloComplete.selectedItem = a;
							break;
						}
					}
				}
				requisicionView.ntsCantidadRequerida.value = Number(requisicionModel.requisicionDetalleSelected.cantidadRequerida);
			}
		}
		
		public function clearFormulario():void{
			requisicionView.cmbEmpleadoRequisicion.selectedItem = null;
			requisicionView.txtObservacionesRequisicion.text = "";
			requisicionView.dateFieldFechaRequisicion.selectedDate = new Date();
			cleanFormularioRequisicionDetalle();
		}
		
		public function saveRequisicion():void{
			//var arrayValidationResult:Array = Validator.validateAll([validateSubCategoria, validateSubMarca, validateNombre, validateNoParte, validateStockMin, validateStockMax, validateUbicacion, validateFechaAdquisicion]);
			switch(requisicionModel.titleFormulario){
				case RequisicionModel.CREAR:
					//if(arrayValidationResult.length == 0){
					saveUpdate();
					//eventRequisicion.requisicionVO =
					if(requisicionModel.requisicionSelected.idEmpleadoRequisicion != null 
						&& requisicionModel.requisicionSelected.idEmpleadoRequisicion != ""){
						eventRequisicion = new RequisicionEvent(RequisicionEvent.EVENT_SAVE_REQUISICION);
						dispatchEvent(eventRequisicion);
						
					}
					requisicionView.vsRequisicion.selectedIndex = 0;
					clearFormulario();
					break;
				case RequisicionModel.ACTUALIZAR:
					saveUpdate();
					eventRequisicion = new RequisicionEvent(RequisicionEvent.EVENT_UPDATE_REQUISICION);
					dispatchEvent(eventRequisicion);
					requisicionView.vsRequisicion.selectedIndex = 0;
					clearFormulario();
					break;
				default:
					break;
			}
		}
		
		public function findArticulos():void
		{
			var articulo:ArticuloVO = new ArticuloVO();
			eventRequisicion = new RequisicionEvent(RequisicionEvent.EVENT_FIND_ARTICULOS);
			eventRequisicion.articuloVO = articulo;
			dispatchEvent(eventRequisicion);
		}
		
		/**
		 * LAbelFunction para mostrar la marca y nombre del Artcículo concatenados
		 */
		protected function labelFunctionMarcaArticulo (item:Object):String{
			return item.marca + " - " + item.descripcion;
		}
		
		/**
		 * Obtiene los datos del articulo de la pantalla y los setea a nuestro itemSelected(Articulo seleccionado)
		 */
		public function saveUpdate():void
		{
			if(requisicionModel.requisicionSelected.folioReq == null || requisicionModel.requisicionSelected.folioReq == ""){
				requisicionModel.requisicionSelected = new RequisicionVO();
			}
			requisicionModel.requisicionSelected.estatusProceso = ProcesoEstatusEnum.REQUISICION;
			if(requisicionView.cmbEmpleadoRequisicion.selectedItem != null){
				requisicionModel.requisicionSelected.idEmpleadoRequisicion = EmpleadoVO(requisicionView.cmbEmpleadoRequisicion.selectedItem).idEmpleado;			
			}
			
			requisicionModel.requisicionSelected.observacionRequisicion = requisicionView.txtObservacionesRequisicion.text;
			//Fecha adquisicion
			var tempDate:Date = requisicionView.dateFieldFechaRequisicion.selectedDate;
			if(tempDate == null){
				//view.dtf_adquisicion.text = "Fecha:__ ___ ___";
				requisicionView.dateFieldFechaRequisicion.errorString = "Debes ingresar la fecha de adquisición."
			}else{
				requisicionModel.requisicionSelected.fechaRequisicion = tempDate.getFullYear().toString() +	'/' + (tempDate.getMonth()+1).toString() + '/' + tempDate.getDate();
				requisicionView.dateFieldFechaRequisicion.errorString = "";
			}
			
			upRequisicionDetalle();
		}
		
		private function upRequisicionDetalle():void{
			requisicionModel.requisicionSelected.listRequisicionDetalle = requisicionModel.acRequisicionesDetalle;
		}
		
		public function deleteRequisicion():void{
			
		}
	}
}