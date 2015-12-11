package com.actioninteractive.nok.view.body.portlet
{
	import com.actioninteractive.nok.event.CRUDEvent;
	import com.actioninteractive.nok.event.EquipoEvent;
	import com.actioninteractive.nok.model.CRUDModel;
	import com.actioninteractive.nok.model.EquipoModel;
	import com.actioninteractive.nok.view.body.component.altaEquipo.CompEquipoMecanico;
	import com.actioninteractive.nok.view.body.component.altaEquipo.CompMaquinaPesada;
	import com.actioninteractive.nok.view.body.component.altaEquipo.CompTransporteLigero;
	import com.actioninteractive.nok.view.body.component.altaEquipo.CompTransportePesado;
	import com.actioninteractive.nok.vo.CategoriaVO;
	import com.actioninteractive.nok.vo.MarcaMotorVO;
	import com.actioninteractive.nok.vo.MarcaVO;
	import com.actioninteractive.nok.vo.SubCategoriaVO;
	import com.actioninteractive.nok.vo.SubMarcaVO;
	import com.actioninteractive.nok.vo.equipo.EquipoVO;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import flashx.textLayout.events.ModelChange;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	public class CatalogoEquipoBase extends Portlet
	{
		[Inject]
		[Bindable]
		public var marcasModel:CRUDModel;
		
		[Inject]
		[Bindable]
		public var equipoModel:EquipoModel;
		
		protected var eventCRUD:CRUDEvent;
		protected var eventEquipo:EquipoEvent;
		
		[Bindable]private var categoriaVO:CategoriaVO;
		[Bindable]private var subCategoriaVO:SubCategoriaVO;
		[Bindable]private var marcaVO:MarcaVO;
		[Bindable]private var subMarcaVO:SubMarcaVO;
		
		private var compMaqPesada:CompMaquinaPesada;
		private var compTransPesado:CompTransportePesado;
		private var compTransLigero:CompTransporteLigero;
		private var compEquipoMecanico:CompEquipoMecanico;
		
		private var fileReferenceFoto:FileReference;
		private var fileReferenceFactura:FileReference;
		private var fileReferencePedimento:FileReference;
		
		private var view:CatalogoEquipo = CatalogoEquipo(this);
		
		protected function init ():void{
			var tempDate:Date = new Date();
			equipoModel.maxAnioModelo = tempDate.getFullYear();
			
			equipoModel.equipoVO = new EquipoVO();
			getCategorias();
			
			//Imagenes
			fileReferenceFoto = new FileReference();
			fileReferenceFoto.addEventListener(Event.SELECT, fotoSeleccionada);
			
			fileReferenceFactura = new FileReference ();
			fileReferenceFactura.addEventListener(Event.SELECT, facturaSeleccionada);
			
			fileReferencePedimento = new FileReference();
			fileReferencePedimento.addEventListener(Event.SELECT, pedimentoSeleccionado);
		}
		
		private function getYesterday():Date {
			var today:Date = new Date();
			var millisecondsPerDay:Number = 1000 * 60 * 60 * 24;
			
			var yesterday:Date = new Date();
			yesterday.setTime(today.getTime() - millisecondsPerDay);
			return yesterday;
		}
		
		protected function changeTipoAdquisicion():void{
			var value:String = view.radioTipoAdquision.selection.label;
			if(value != ""){
				switch(value){
					case "Nuevo":
							equipoModel.equipoVO.tipoadquisicion = "N";
						break;
					case "Usado":
							equipoModel.equipoVO.tipoadquisicion = "U";
						break;
					default:
							equipoModel.equipoVO.tipoadquisicion = "";
						break;
				}
			}else{
				equipoModel.equipoVO.tipoadquisicion = "";
			}
		}
		
		protected function changeNoEconomico ():void{
			var tempValue:String = view.txtNoEconomico.text;
			
			if(tempValue != ""){
				equipoModel.equipoVO.numeroeconomico = tempValue;	
				view.txtNoEconomico.errorString = "";
			}else{
				view.txtNoEconomico.errorString = "Debe ingresar el No. Economico.";
			}
		}
		
		protected function changeNoSerie ():void{
			var tempValue:String = view.txtNoSerie.text;
			if(tempValue != ""){
				equipoModel.equipoVO.numeroserie = tempValue;
				view.txtNoSerie.errorString = "";
			}else{
				view.txtNoSerie.errorString = "Debes ingresar el No. Serie.";
			}
		}
		
		protected function changeFactura():void{
			var tempValue:String = view.txtFactura.text;
			if(tempValue != ""){
				equipoModel.equipoVO.factura = tempValue;
				view.txtFactura.errorString = "";
			}else{
				view.txtFactura.errorString = "Debes ingresar la factura.";
			}
		}
		
		protected function changePedimento ():void{
			var tempValue:String = view.txtPedimento.text;
			if(tempValue != ""){
				equipoModel.equipoVO.pedimiento = tempValue;
				view.txtPedimento.errorString = "";
			}else{
				view.txtPedimento.errorString = "Debes ingresar el Pedimento.";
			}
		}
		
		protected function changeModelo ():void{
			var tempValue:Number = view.nsModelo.value;
			if(tempValue > 1960){
				equipoModel.equipoVO.anioequipo= tempValue.toString();
				view.nsModelo.errorString = "";
			}else{
				view.nsModelo.errorString = "la fecha debe de ser mayor a 1960.";
			}
		}
		
		protected function changeDescription ():void{
			var value:String = view.txtDescripcion.text;
			if(value != ""){
				equipoModel.equipoVO.descripcion = value;
			}else{
				equipoModel.equipoVO.descripcion = "";
			}
		}
		
		protected function siguienteComponente():void{
			if(view.containerExtend.numElements > 0 ){
				equipoModel.flagCompEquipos = true;
			}else{
				equipoModel.flagCompEquipos = false;
			}
		}
		
		protected function anteriorComponente():void{
			equipoModel.flagCompEquipos = false;
		}
		
		/**
		 * Función que se ejecuta al seleccionar un archivo (imagen a guardar)
		 */
		private function fotoSeleccionada(event:Event):void {
			fileReferenceFoto.load();
			view.txtImageFoto.text = fileReferenceFoto.name;
		}
		
		/**
		 * Funciòn que permite obtener la imagen del Equipo y guardarla
		 */
		protected function obtenerFoto():void
		{
			var arr:Array = [];
			arr.push(new FileFilter("Imagenes", ".gif;*.jpeg;*.jpg;*.png"));
			fileReferenceFoto.browse(arr);
		}
		
		/**
		 * Función que se ejecuta al seleccionar un pedimento (imagen a guardar)
		 */
		private function pedimentoSeleccionado(event:Event):void {
			fileReferencePedimento.load();
			view.txtImagePedimento.text = fileReferencePedimento.name;
		}
		
		/**
		 * Funciòn que permite obtener la imagen de Pedimentos y guardarla
		 */
		protected function obtenerPedimento():void{
			var arr:Array = [];
			arr.push(new FileFilter("Imagenes", ".gif;*.jpeg;*.jpg;*.png"));
			fileReferencePedimento.browse(arr);
		}
		
		/**
		 * Función que se ejecuta al seleccionar una factura (imagen a guardar)
		 */
		private function facturaSeleccionada(event:Event):void {
			fileReferenceFactura.load();
			view.txtImageFactura.text = fileReferenceFactura.name;
		}
		
		/**
		 * Funciòn que permite obtener la imagen de la factura y guardarla
		 */
		protected function obtenerFactura():void
		{
			var arr:Array = [];
			arr.push(new FileFilter("Imagenes", ".gif;*.jpeg;*.jpg;*.png"));
			fileReferenceFactura.browse(arr);
		}	
		
		/***
		 * Obtiene todas las categorías y marcas
		 */
		private function getCategorias ():void{
			categoriaVO = new CategoriaVO();
			categoriaVO.idCategoria = '';
			categoriaVO.idtipocategoria = '1';
			categoriaVO.filterEstatusCategoria = 'true';
			
			eventCRUD = new CRUDEvent (CRUDEvent.EVENT_ACTUALIZAR_CATALOGOS_ALTA_EQUIPOS);				
			eventCRUD.categoriaVO = categoriaVO;				
			dispatchEvent(eventCRUD);
			
			/***	Esto es para obtener las categorias de motor	***/
			var tempMarcaMotorVO:MarcaMotorVO = new MarcaMotorVO();
			tempMarcaMotorVO.idMarcaMotor = '';
			tempMarcaMotorVO.filterEstatusMarcaMotor = 'true';
			
			var tempEvent:EquipoEvent = new EquipoEvent(EquipoEvent.GET_MARCAS_MOTOR);
			tempEvent.marcaMotorVO = tempMarcaMotorVO;
			dispatchEvent(tempEvent);
		}
		
		
		
		/***
		 * Selección de una Categoria
		 */
		protected function changeCategoria(event:Event):void{
			limpiarListas(1); //Al seleccionar una nueva categoría inicializamos los arreglos de subcategoria, marca y submarca
			
			var obj:CategoriaVO = event.target.selectedItem as CategoriaVO;
			
			var _subCat:SubCategoriaVO = new SubCategoriaVO();
			_subCat.idCategoria = obj.idCategoria;
			_subCat.idSubcategoria = '';
			_subCat.subcategoria = "";				
			_subCat.categoria = obj.categoria;
			_subCat.filterEstatusSubcategoria = 'true';
			
			if(view.containerExtend.numElements > 0){
				view.containerExtend.removeAllElements();
			}
			
			switch(obj.idCategoria){
				case '1':
					compMaqPesada = new CompMaquinaPesada();
					compMaqPesada.percentWidth = 100;
					compMaqPesada.percentHeight = 100;
					view.containerExtend.addElement(compMaqPesada);
					break;
				case '2':
					compTransPesado = new CompTransportePesado();
					compTransPesado.percentWidth = 100;
					compTransPesado.percentHeight = 100;
					view.containerExtend.addElement(compTransPesado);
					break;
				case '3':
					compTransLigero = new CompTransporteLigero();
					compTransLigero.percentWidth = 100;
					compTransLigero.percentHeight = 100;
					view.containerExtend.addElement(compTransLigero);
					break;
				case '6':
					compEquipoMecanico = new CompEquipoMecanico();
					compEquipoMecanico.percentWidth = 100;
					compEquipoMecanico.percentHeight = 100;
					view.containerExtend.addElement(compEquipoMecanico);
					break;
				default:
					break;
			}
			
			equipoModel.equipoVO.idCategoria = obj.idCategoria;
			equipoModel.equipoVO.categoria = obj.categoria;	
			
			var eventCat:CRUDEvent = new CRUDEvent(CRUDEvent.SUBCATEGORIA_LIST);
			eventCat.subcategoriaVO = _subCat;
			dispatchEvent(eventCat);
		}
		
		/***
		 * Selección de una SubCategoria
		 */
		protected function changeSubcategoria (event:Event):void{
			limpiarListas(2); //Al seleccionar una nueva categoría inicializamos los arreglos de marca y submarca
			
			var obj:SubCategoriaVO = event.target.selectedItem as SubCategoriaVO;
			
			var _marcaVO:MarcaVO = new MarcaVO();
			_marcaVO.filterEstatusMarca = "true";
			_marcaVO.idMarca = "";
			_marcaVO.subcategoria = obj.subcategoria;
			_marcaVO.idSubcategoria = obj.idSubcategoria;
			
			eventCRUD = new CRUDEvent(CRUDEvent.MARCAS_GET_LIST);
			eventCRUD.marcaVO = _marcaVO;
			dispatchEvent(eventCRUD);
			
			equipoModel.equipoVO.idSubcategoria = obj.idSubcategoria;
			equipoModel.equipoVO.subcategoria = obj.subcategoria;
			
			marcasModel.flagEnableMarca = true;
		}
		
		/***
		 * Selección de una Marca
		 */
		protected function changeMarca(event:Event):void
		{
			limpiarListas(3); //Al seleccionar una nueva categoría inicializamos los arreglos de submarca
			
			var eventSubmarca:CRUDEvent = new CRUDEvent(CRUDEvent.SUBMARCA_GET_LIST);
			var tempMarcaVO:MarcaVO = event.target.selectedItem as MarcaVO;
			
			equipoModel.equipoVO.idMarca = tempMarcaVO.idMarca;
			equipoModel.equipoVO.marca   = tempMarcaVO.marca;
			
			var _subMarcaVO:SubMarcaVO = new SubMarcaVO();
			_subMarcaVO.idMarca = tempMarcaVO.idMarca;
			_subMarcaVO.idSubmarca = "";
			_subMarcaVO.filterEstatusSubmarca = "true";
			
			eventSubmarca.subMarcaVO = _subMarcaVO;
			dispatchEvent(eventSubmarca);
			marcasModel.flagEnableSubMarca = true;
		}
		
		
		/***
		 * Selección de una SubMarca
		 */
		protected function changeSubMarca(event:Event):void{
			var tempSubMarca:SubMarcaVO = event.target.selectedItem as SubMarcaVO;
			
			equipoModel.equipoVO.idSubmarca = tempSubMarca.idSubmarca;
			equipoModel.equipoVO.submarca = tempSubMarca.submarca;
		}
		
		private function limpiarListas(value:int = 0):void{
			switch(value){
				case 0:
						marcasModel.acListCategorias = new ArrayCollection();
						marcasModel.acListSubcategorias = new ArrayCollection();
						marcasModel.acListMarcas = new ArrayCollection();
						marcasModel.acListSubMarcasEquipo = new ArrayCollection();
					break;
				case 1:
						marcasModel.acListSubcategorias = new ArrayCollection();
						marcasModel.acListMarcas = new ArrayCollection();
						marcasModel.acListSubMarcasEquipo = new ArrayCollection();
					break;
				case 2:
						marcasModel.acListMarcas = new ArrayCollection();
						marcasModel.acListSubMarcasEquipo = new ArrayCollection();
					break;
				case 3:
						marcasModel.acListSubMarcasEquipo = new ArrayCollection();
					break;
				default:
						marcasModel.acListCategorias = new ArrayCollection();
						marcasModel.acListSubcategorias = new ArrayCollection();
						marcasModel.acListMarcas = new ArrayCollection();
						marcasModel.acListSubMarcasEquipo = new ArrayCollection();
					break;
			}
		}
		
		private function cargarPropiedadesImagenes():void{
			try{
				//Foto
				if(fileReferenceFoto != null && fileReferenceFoto.data.length > 0){
					equipoModel.equipoVO.fotoequipo = view.txtImageFoto.text;
					equipoModel.equipoVO.contentFoto = fileReferenceFoto.data;
				}
				
				//Factura
				if(fileReferenceFactura.data != null){
					equipoModel.equipoVO.fotofactura = view.txtImageFactura.text;
					equipoModel.equipoVO.contentFactura = fileReferenceFactura.data;
				}
				
				//Pedimento
				if(fileReferencePedimento.data != null){
					equipoModel.equipoVO.fotopedimento = view.txtImagePedimento.text;
					equipoModel.equipoVO.contentPedimento = fileReferencePedimento.data;
				}
				
			}catch(e:Error){
				trace(e.message);
			}				
		}
		
		/**
		 * Método para obetner la fecha seleccionada en Fecha de Adquisición
		 */
		protected function selectFechaAdquisicion ():void{
			var tempDate:Date = view.dtf_adquisicion.selectedDate;
			if(tempDate == null){
				//view.dtf_adquisicion.text = "Fecha:__ ___ ___";
				view.dtf_adquisicion.errorString = "Debes ingresar la fecha de adquisición."
			}else{
				equipoModel.equipoVO.fechaadquisicion = tempDate.getFullYear().toString() +	'/' + (tempDate.getMonth()+1).toString() + '/' + tempDate.getDate();
				view.dtf_adquisicion.errorString = "";
			}
		}
		
		
		/**
		 * Función que despacha el evento para guardar un nuevo equipo
		 */
		protected function altaEquipo ():void{
			actualizarDTO();
			cargarPropiedadesImagenes();
			trace(equipoModel.equipoVO);
			eventEquipo = new EquipoEvent(EquipoEvent.INSERT_EQUIPO);
			dispatchEvent(eventEquipo);
			
			equipoModel.flagActualizar = false;
			equipoModel.flagAlta = true;
			equipoModel.flagEliminar = false;
		}
		
		/**
		 * Función que actualiza la información del equipo
		 */
		protected function actualizarEquipo():void{
			actualizarDTO();
			cargarPropiedadesImagenes();
			
			trace(equipoModel.equipoVO);
			eventEquipo = new EquipoEvent(EquipoEvent.UPDATE_EQUIPO);
			dispatchEvent(eventEquipo);
			
			equipoModel.flagActualizar = false;
			equipoModel.flagAlta = true;
			equipoModel.flagEliminar = false;
		}
		
		/**
		 * Función que elimina el equipo seleccionado
		 */
		protected function deleteEquipo ():void{
			changeIdEquipo();
			Alert.show("Eliminar Equipo: " + equipoModel.equipoVO.idEquipo);
			eventEquipo = new EquipoEvent(EquipoEvent.DELETE_EQUIPO);
			dispatchEvent(eventEquipo);
			
			equipoModel.flagActualizar = false;
			equipoModel.flagAlta = true;
			equipoModel.flagEliminar = false;
		}
		
		/**
		 * Función que despacha el evento para buscar un equipo
		 */
		protected function buscarEquipo():void{
			eventEquipo = new EquipoEvent(EquipoEvent.BUSCAR_EQUIPO);
			eventEquipo.equipoVO.numeroeconomico = view.txtBusquedaEquipos.text;
			eventEquipo.equipoVO.idEquipo = "";
			eventEquipo.equipoVO.idMarca = "";
			eventEquipo.equipoVO.idSubmarca = "";
			eventEquipo.equipoVO.idSubcategoria = "";
			eventEquipo.equipoVO.filterEstatusEquipo = "true";
			dispatchEvent(eventEquipo);
		}
		
		private function changeIdEquipo ():void{
			if (equipoModel.equipoVO.numeroserie != "" && equipoModel.equipoVO.factura != ""){
				equipoModel.equipoVO.idEquipo = equipoModel.equipoVO.numeroserie + equipoModel.equipoVO.factura;
				view.txtNoSerie.errorString = "";
				view.txtFactura.errorString = "";
			}else{
				if(equipoModel.equipoVO.numeroserie != ""){
					view.txtNoSerie.errorString = "Debes ingresar el No. de Serie.";
				}else if(equipoModel.equipoVO.factura != ""){
					view.txtFactura.errorString = "Debes ingresar la Factura.";
				}
			}
		}
		
		/**
		 * Función que se encarga de actualizar los datos del DTO
		 **/
		private function actualizarDTO ():void{
			trace("Serie: " + view.txtNoSerie.text);
			trace("Factura: " + view.txtFactura.text);
			trace("idEquipo: " + view.txtNoSerie.text + view.txtFactura.text);
			changeNoEconomico();
			changeNoSerie();
			changeFactura();
			changeIdEquipo();
			changePedimento();
			selectFechaAdquisicion();
			changeTipoAdquisicion();
			changeModelo();
			changeDescription();
			
			trace("Serie: " + equipoModel.equipoVO.numeroserie);
			trace("Factura: " + equipoModel.equipoVO.factura);
			trace("idEquipo: " + equipoModel.equipoVO.idEquipo);
			
			if(Number(equipoModel.equipoVO.idSubmarca) <= 0){
				var tempSubMarca:SubMarcaVO = view.listSubMarca.selectedItem as SubMarcaVO;
				
				equipoModel.equipoVO.idSubmarca = tempSubMarca.idSubmarca;
				equipoModel.equipoVO.submarca = tempSubMarca.submarca;
			}
			
			switch(equipoModel.equipoVO.idCategoria){
				case '1':
					compMaqPesada.actualizarDTO();
					break;
				case '2':
					compTransPesado.actualizarDTO();
					break;
				case '3':
					compTransLigero.actualizarDTO();
					break;
				case '6':
					compEquipoMecanico.actualizarDTO();
					break;
				default:
					compMaqPesada.cleanComponent();
					break; 
			}
		}
		
		
		protected function cancelarEquipo ():void{
			
		}
		
		/**
		 * Limpia los controles y los valores de equipoVO
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 */
		[EventHandler(event="EquipoEvent.CLEAN_CONTROLS")]
		protected function limpiar(event:MouseEvent):void
		{
			equipoModel.equipoVO = new EquipoVO();
			view.txtNoEconomico.text 			= "";
			view.txtNoSerie.text 				= "";
			view.txtPedimento.text 				= "";
			view.txtFactura.text 				= "";
			view.txtDescripcion.text 			= "";
			view.txtImageFactura.text 			= "";
			view.txtImageFoto.text 				= "";
			view.txtImagePedimento.text 		= "";
			view.listCategorias.selectedIndex 	= 0;
			view.listSubCategoria.selectedIndex = 0;
			view.listMarca.selectedIndex 		= 0;
			view.listSubMarca.selectedIndex 	= 0;
			view.dtf_adquisicion.selectedDate = new Date();
			view.radioTipoAdquision.selectedValue = "Nuevo";
			view.nsModelo.value = 1960;
			if(view.containerExtend.numElements > 0 ){
				view.containerExtend.removeAllElements();
				equipoModel.flagCompEquipos = false;
			}
		}
		
		/**
		 * Obtiene la lista de equipos encontrados de la busqueda realiada
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 */
		[EventHandler(event="EquipoEvent.EQUIPOS_ENCONTRADOS")]
		public function muestraEquiposEncontradosEvent():void
		{
			var resultWindowEquipo:ResultComponentPopup = ResultComponentPopup(PopUpManager.createPopUp(this,ResultComponentPopup, true) as spark.components.TitleWindow);
			trace("event ------> ITEM_FOUND_DATA")
			resultWindowEquipo.titleComponent = "Articulos encontrados";
			resultWindowEquipo._width = 850;
			resultWindowEquipo._height = 500;
			resultWindowEquipo._collectionItems = equipoModel.acEquiposEncontrados;
			resultWindowEquipo.columnsArray = new ArrayCollection([
				]);
			//resultWindowEquipo.createColumns();
			resultWindowEquipo.addEventListener(EquipoEvent.SELECTED_ITEM_FIND, itemSelectedEvent);
			PopUpManager.centerPopUp(resultWindowEquipo);
			//resultWindowEquipo.addEventListener(CRUDEvent.EVENT_SELECT_MOUSE_EVENT, itemSelectedEvent);
			//resultWindowEquipo.addEventListener(EquipoEvent.SELECTED_ITEM_FIND, itemSelectedEvent);
		}
		
		/**
		 * Obtiene el elemento seleccionado en el grid de elementos encontrados para editarlo o eliminarlo
		 * 
		 * @productversion NOK 1
		 * @author Ricardo Zaragoza Solís
		 */
		[EventHandler(event="EquipoEvent.SELECTED_ITEM_FIND")]
		public function itemSelectedEvent (event:EquipoEvent):void{
			
			//Actulizamos la variable par mostrar la primera sección del contenedor principal de Equipos
			equipoModel.flagCompEquipos = false;
			
			trace(event.equipoVO.idEquipo);
			trace(event.equipoVO.numeroserie);
			trace(event.equipoVO.factura);
			
			equipoModel.equipoVO 				= event.equipoVO;
			view.txtNoEconomico.text 			= event.equipoVO.numeroeconomico;
			view.txtNoSerie.text 				= event.equipoVO.numeroserie;
			view.txtPedimento.text 				= event.equipoVO.pedimiento;
			view.txtFactura.text 				= event.equipoVO.factura;
			view.txtDescripcion.text 			= event.equipoVO.descripcion;
			view.txtImageFactura.text 			= event.equipoVO.fotofactura;
			view.txtImageFoto.text 				= event.equipoVO.fotoequipo;
			view.txtImagePedimento.text 		= event.equipoVO.fotopedimento;
			
			trace(event.equipoVO.fechaadquisicion);
			trace(DateField.stringToDate(event.equipoVO.fechaadquisicion, "YYYY/MM/DD"));
			view.dtf_adquisicion.selectedDate = DateField.stringToDate(event.equipoVO.fechaadquisicion, "YYYY/MM/DD")
			trace("Tipo Adquisición: "+event.equipoVO.tipoadquisicion);
			trace((event.equipoVO.tipoadquisicion == 'N') ? "Nuevo":"Usado");
			trace(view.radioTipoAdquision.selectedValue);
			trace(view.radioTipoAdquision.selection);
			trace((event.equipoVO.tipoadquisicion == "N") ? "Nuevo" : "Usado");
			view.radioTipoAdquision.selectedValue = (event.equipoVO.tipoadquisicion == "N") ? "Nuevo" : "Usado";
			view.nsModelo.value = Number(event.equipoVO.anioequipo);
			
			equipoModel.flagSerie				= false;
			equipoModel.flagFactura				= false;
			equipoModel.flagActualizar			= true;
			equipoModel.flagAlta				= false;
			equipoModel.flagEliminar			= true;
			searchCategoria(event.equipoVO);
		}
		
		private function searchCategoria(_equipoVO:EquipoVO):void{
			var _idCategoria:Number = Number(_equipoVO.idCategoria);
			for(var i:int = 0; i < marcasModel.acListCategorias.length; i++){
				var cat:CategoriaVO = marcasModel.acListCategorias[i];
				if(Number(cat.idCategoria) == Number(_idCategoria)){
					view.listCategorias.selectedIndex = i;
					break;
				}
			}
			
			limpiarListas(1); //Al seleccionar una nueva categoría inicializamos los arreglos de subcategoria, marca y submarca
			
			var obj:CategoriaVO = view.listCategorias.selectedItem as CategoriaVO;
			
			var _subCat:SubCategoriaVO = new SubCategoriaVO();
			_subCat.idCategoria = obj.idCategoria;
			_subCat.idSubcategoria = '';
			_subCat.subcategoria = "";				
			_subCat.categoria = obj.categoria;
			_subCat.filterEstatusSubcategoria = 'true';
			
			if(view.containerExtend.numElements > 0){
				view.containerExtend.removeAllElements();
			}
			
			switch(obj.idCategoria){
				case '1':
					trace("equipoModel.acCombustible.length: " + equipoModel.acCombustible.length);
					compMaqPesada = new CompMaquinaPesada();
					compMaqPesada.percentWidth = 100;
					compMaqPesada.percentHeight = 100;
					view.containerExtend.addElement(compMaqPesada);
					compMaqPesada.selectItem(_equipoVO);
					break;
				case '2':
					compTransPesado = new CompTransportePesado();
					compTransPesado.percentWidth = 100;
					compTransPesado.percentHeight = 100;
					view.containerExtend.addElement(compTransPesado);
					compTransPesado.selectItem(_equipoVO);
					break;
				case '3':
					compTransLigero = new CompTransporteLigero();
					compTransLigero.percentWidth = 100;
					compTransLigero.percentHeight = 100;
					view.containerExtend.addElement(compTransLigero);
					compTransLigero.selectItem(_equipoVO);
					break;
				case '6':
					compEquipoMecanico = new CompEquipoMecanico();
					compEquipoMecanico.percentWidth = 100;
					compEquipoMecanico.percentHeight = 100;
					view.containerExtend.addElement(compEquipoMecanico);
					compEquipoMecanico.selectItem(_equipoVO);
					break;
				default:
					break;
			}
			
			equipoModel.equipoVO.idCategoria = obj.idCategoria;
			equipoModel.equipoVO.categoria = obj.categoria;	
			
			var eventCat:CRUDEvent = new CRUDEvent(CRUDEvent.SUBCATEGORIA_LIST);
			eventCat.subcategoriaVO = _subCat;
			dispatchEvent(eventCat);
		}
	}
}