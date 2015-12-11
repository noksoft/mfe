package view
{
	import event.CommonEvent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import model.ArticuloVO;
	import model.CategoriaVO;
	import model.MarcaVO;
	import model.SubCategoriaVO;
	import model.SubMarcaVO;
	import model.TipoCategoriaVO;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.events.ValidationResultEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	import mx.validators.DateValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import spark.components.Panel;
	import spark.validators.NumberValidator;
	
	import utils.AlertUtils;
	import utils.GeneralUtils;
	
	public class ArticuloViewBase extends Panel implements IMainView
	{
		//Referenca to View Main
		public var viewArticulo:ArticuloView = ArticuloView(this);
		
		
		//ArraysCollections
		[Bindable]protected var listArticulos:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listTipoCategorias:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listCategorias:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listSubCategorias:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listMarcas:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listSubMarcas:ArrayCollection = new ArrayCollection();
		
		//ArraysCollections for Editors
		[Bindable]protected var listTipoCategoriasEditor:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listCategoriasEditor:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listSubCategoriasEditor:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listMarcasEditor:ArrayCollection = new ArrayCollection();
		[Bindable]protected var listSubMarcasEditor:ArrayCollection = new ArrayCollection();
		
		[Bindable]protected var itemSelected:ArticuloVO = new ArticuloVO();
		
		/*******	Remotes Objects	***************/
		private var roArticuloData:RemoteObject = new RemoteObject();
		private var roCategoriaData:RemoteObject = new RemoteObject();
		
		private var roArticuloEditor:RemoteObject = new RemoteObject();
		private var roCategoriaEditor:RemoteObject = new RemoteObject();
		
		/***********	VARIABLE'S	*****************/
		[Bindable]protected var titleFormulario:String;
		private const CREAR:String = "Crear";
		private const ACTUALIZAR:String = "Actualizar";
		
		public function ArticuloViewBase()
		{
			super();
		}
		
		/**
		 * Validate Handler SubCategoria
		 */
		public function validateSubCategoriaHandler(_event:ValidationResultEvent):void{
			viewArticulo.cmbSubCategoriaEditor.errorString = "Debe de seleccionar la SubCategoía";
		}
		
		/**
		 * Fault Handler SubCategoria
		 */
		public function validSubCategoriaFault(_event:ValidationResultEvent):void{
			viewArticulo.cmbSubCategoriaEditor.errorString = "";
		}
		
		/**
		 * Validate Handler Marca
		 */
		public function validateMarcaHandler(_event:ValidationResultEvent):void{
			viewArticulo.cmbMarcaEditor.errorString = "Debe de seleccionar la Marca";
		}
		
		/**
		 * Fault Handler Marca
		 */
		public function validMarcaFault(_event:ValidationResultEvent):void{
			viewArticulo.cmbMarcaEditor.errorString = "";
		}
		
		/**
		 * Validate Handler SubMarca
		 */
		public function validateSubMarcaHandler(_event:ValidationResultEvent):void{
			viewArticulo.cmbSubMarcaEditor.errorString = "Debe de seleccionar la SubMarca";
		}
		
		/**
		 * Fault Handler SubMarca
		 */
		public function validSubMarcaFault(_event:ValidationResultEvent):void{
			viewArticulo.cmbSubMarcaEditor.errorString = "";
		}
		
		/**
		 * Validate Handler Unidad
		 */
		public function validateUnidadHandler(_event:ValidationResultEvent):void{
			viewArticulo.cmbUnidad.errorString = "Debe de seleccionar la Unidad";
		}
		
		/**
		 * Fault Handler Unidad
		 */
		public function validUnidadFault(_event:ValidationResultEvent):void{
			viewArticulo.cmbUnidad.errorString = "";
		}
		
		public function init():void
		{
			titleFormulario = CREAR;
			//Initialization to Remote Object
			//ARTICULO
			roArticuloData.endpoint = "http://localhost:8080/nok/messagebroker/amf";
			roArticuloData.destination = "articuloBusiness";
			roArticuloData.showBusyCursor = true;
			
			roCategoriaData.endpoint = "http://localhost:8080/nok/messagebroker/amf";
			roCategoriaData.destination = "categoriaBusiness";
			roCategoriaData.showBusyCursor = true;
			
			//EDITOR
			roArticuloEditor.endpoint = "http://localhost:8080/nok/messagebroker/amf";
			roArticuloEditor.destination = "articuloBusiness";
			roArticuloEditor.showBusyCursor = true;
			
			roCategoriaEditor.endpoint = "http://localhost:8080/nok/messagebroker/amf";
			roCategoriaEditor.destination = "categoriaBusiness";
			roCategoriaEditor.showBusyCursor = true;
			
			//GetArticulos			
			roArticuloData.getOperation("getArticulosByTipocategoria").addEventListener(ResultEvent.RESULT, resultCatItems);
			roArticuloData.getOperation("getArticulosByTipocategoria").addEventListener(FaultEvent.FAULT, faultCatItems);
			
			//Insert Articulo
			roArticuloData.getOperation("insertArticulo").addEventListener(ResultEvent.RESULT, insertItemHandler);
			roArticuloData.getOperation("insertArticulo").addEventListener(FaultEvent.FAULT, insertItemFault);
			
			//Update Articulo
			roArticuloData.getOperation("updateArticulo").addEventListener(ResultEvent.RESULT, updateItemHandler);
			roArticuloData.getOperation("updateArticulo").addEventListener(FaultEvent.FAULT, updateItemFault);
			
			//Delete Articulo
			roArticuloData.getOperation("deleteArticulo").addEventListener(ResultEvent.RESULT, deleteItemHandler);
			roArticuloData.getOperation("deleteArticulo").addEventListener(FaultEvent.FAULT, deleteItemFault);
			
			
			//Marca
			roArticuloData.getOperation("catMarca").addEventListener(ResultEvent.RESULT, resultCatMarca);
			roArticuloData.getOperation("catMarca").addEventListener(FaultEvent.FAULT, faultCatMarca);
			
			//SubMarca
			roArticuloData.getOperation("catSubmarca").addEventListener(ResultEvent.RESULT, resultSubMarca);
			roArticuloData.getOperation("catSubmarca").addEventListener(FaultEvent.FAULT, faultSubMarca);
			
			
			
			//Marca Editor
			roArticuloEditor.getOperation("catMarca").addEventListener(ResultEvent.RESULT, resultGetMarcaEditor);
			roArticuloEditor.getOperation("catMarca").addEventListener(FaultEvent.FAULT, faultGetMarcaEditor);
			
			//SubMarca Editor
			roArticuloEditor.getOperation("catSubmarca").addEventListener(ResultEvent.RESULT, resultGetSubMarcaEditor);
			roArticuloEditor.getOperation("catSubmarca").addEventListener(FaultEvent.FAULT, faultGetSubMarcaEditor);
			
			
			//CATEGORIA
			
			//SubCategoria
			roCategoriaData.getOperation("catSubcategoria").addEventListener(ResultEvent.RESULT, resultCatSubCategoria);
			roCategoriaData.getOperation("catSubcategoria").addEventListener(FaultEvent.FAULT, faultCatSubCategoria);
			
			
			//Editor
			roCategoriaEditor.endpoint = "http://localhost:8080/nok/messagebroker/amf";
			roCategoriaEditor.destination = "categoriaBusiness";
			roCategoriaEditor.showBusyCursor = true;
			//SubCategoria
			roCategoriaEditor.getOperation("catSubcategoria").addEventListener(ResultEvent.RESULT, resultGetSubCategoriaEditor);
			roCategoriaEditor.getOperation("catSubcategoria").addEventListener(FaultEvent.FAULT, faultGetSubCategoriaEditor);
			
			//Inicializar los Validators
			//initValidators();
			upDataSubcategorias();
			updateData();
		}
		
		
		/*******************************************************************************************************/
		/********************************	Operation and logics	********************************************/
		/*******************************************************************************************************/
		
		
		/**
		 * Evento que se ejecuta al seleccionar una Categoría
		 */
		protected function upListSubcategorias ():void{
			var tempSubCategoria:SubCategoriaVO = new SubCategoriaVO();
			tempSubCategoria.idCategoria = '13';
			roCategoriaData.catSubcategoria(tempSubCategoria);
			viewArticulo.cmbSubCategoria.enabled = true;
			//Limpiamos los demas combos
			viewArticulo.cmbSubCategoria.selectedItem = null;
			
			viewArticulo.cmbMarca.selectedItem = null;
			viewArticulo.cmbMarca.enabled = false;
			
			viewArticulo.cmbSubMarca.selectedItem = null;
			viewArticulo.cmbSubMarca.enabled = false;
		}
		
		
		protected function upListMarcas():void{
			if(viewArticulo.cmbSubCategoria.selectedItem != null){
				var tempMarca:MarcaVO = new MarcaVO();
				tempMarca.idSubcategoria = SubCategoriaVO(viewArticulo.cmbSubCategoria.selectedItem).idSubcategoria;
				roArticuloData.catMarca(tempMarca);
				viewArticulo.cmbMarca.enabled = true;
				//Limpiamos los demas combos
				viewArticulo.cmbMarca.selectedItem = null;
				
				viewArticulo.cmbSubMarca.selectedItem = null;
				viewArticulo.cmbSubMarca.enabled = false;
				
				updateData();
			}
		}
		
		
		protected function upListSubMarcas():void{
			if(viewArticulo.cmbMarca.selectedItem != null){
				var tempSubMarca:SubMarcaVO = new SubMarcaVO();
				tempSubMarca.idMarca = MarcaVO(viewArticulo.cmbMarca.selectedItem).idMarca;
				roArticuloData.catSubmarca(tempSubMarca);
				
				viewArticulo.cmbSubMarca.enabled = true;
				
				updateData();
			}
		}
		
		
		/***********************************	Selection's Editor's *******************************************/
		
		/**
		 * Evento que se ejecuta al seleccionar una Categoría Editor
		 */
		protected function upListSubcategoriasEditor ():void{
			var tempSubCategoria:SubCategoriaVO = new SubCategoriaVO();
			tempSubCategoria.idCategoria = '13';
			roCategoriaEditor.catSubcategoria(tempSubCategoria);
			viewArticulo.cmbSubCategoriaEditor.enabled = true;
			//Limpiamos los demas combos
			viewArticulo.cmbSubCategoriaEditor.selectedItem = null;
			
			viewArticulo.cmbMarcaEditor.selectedItem = null;
			viewArticulo.cmbMarcaEditor.enabled = false;
			
			viewArticulo.cmbSubMarcaEditor.selectedItem = null;
			viewArticulo.cmbSubMarcaEditor.enabled = false;
		}
		
		
		protected function upListMarcasEditor():void{
			if(viewArticulo.cmbSubCategoriaEditor.selectedItem != null){
				var tempMarca:MarcaVO = new MarcaVO();
				tempMarca.idSubcategoria = SubCategoriaVO(viewArticulo.cmbSubCategoriaEditor.selectedItem).idSubcategoria;
				roArticuloEditor.catMarca(tempMarca);
				viewArticulo.cmbMarcaEditor.enabled = true;
				//Limpiamos los demas combos
				viewArticulo.cmbMarcaEditor.selectedItem = null;
				
				viewArticulo.cmbSubMarcaEditor.selectedItem = null;
				viewArticulo.cmbSubMarcaEditor.enabled = false;
			}
		}
		
		
		protected function upListSubMarcasEditor():void{
			if(viewArticulo.cmbMarcaEditor.selectedItem != null){
				var tempSubMarca:SubMarcaVO = new SubMarcaVO();
				tempSubMarca.idMarca = MarcaVO(viewArticulo.cmbMarcaEditor.selectedItem).idMarca;
				roArticuloEditor.catSubmarca(tempSubMarca);
				
				viewArticulo.cmbSubMarcaEditor.enabled = true;
			}
		}
		
		/**
		 * Desactiva los combos de los filtros
		 */
		private function enableCombosFilter():void{
			viewArticulo.cmbSubCategoria.enabled = true;
			viewArticulo.cmbMarca.enabled = false;
			viewArticulo.cmbSubMarca.enabled = false;
		}
		
		/**
		 * Desactiva los combos del Formulario
		 */
		private function enableCombosFormulario():void{
			viewArticulo.cmbSubCategoriaEditor.enabled = true;
			viewArticulo.cmbMarcaEditor.enabled = false;
			viewArticulo.cmbSubMarcaEditor.enabled = false;
		}
		
		
		/*******************************************************************************************************/
		/*******************************	End Operations and Logics	****************************************/
		/*******************************************************************************************************/
		
		public function upDataSubcategorias():void{
			var subCategoria:SubCategoriaVO = new SubCategoriaVO();
			subCategoria.idCategoria = '13';
			roCategoriaData.catSubcategoria(subCategoria);
			roCategoriaEditor.catSubcategoria(subCategoria);
		}
		
		public function updateData():void
		{
			itemSelected = new ArticuloVO();
			//Setea la subcategoria seleccionada
			if(viewArticulo.cmbSubCategoria != null && viewArticulo.cmbSubCategoria.selectedItem != null){
				itemSelected.idsubcategoria = SubCategoriaVO(viewArticulo.cmbSubCategoria.selectedItem).idSubcategoria;
			}
			//Setea la marca seleccionada
			if(viewArticulo.cmbMarca != null && viewArticulo.cmbMarca.selectedItem != null){
				itemSelected.idMarca = MarcaVO(viewArticulo.cmbMarca.selectedItem).idMarca;
			}
			
			if(viewArticulo.cmbSubMarca != null && viewArticulo.cmbSubMarca.selectedItem != null){
				itemSelected.idSubmarca = SubMarcaVO(viewArticulo.cmbSubMarca.selectedItem).idSubmarca;
			}
			
			roArticuloData.getArticulosByTipocategoria(itemSelected);
		}
		
		public function getItems():void
		{
		}
		
		/**
		 * Obtiene los datos del articulo de la pantalla y los setea a nuestro itemSelected(Articulo seleccionado)
		 */
		public function saveUpdate():void
		{
			itemSelected.idsubcategoria = SubCategoriaVO(viewArticulo.cmbSubCategoriaEditor.selectedItem).idSubcategoria;
			itemSelected.subcategoria = SubCategoriaVO(viewArticulo.cmbSubCategoriaEditor.selectedItem).subcategoria;
			itemSelected.idMarca = MarcaVO(viewArticulo.cmbMarcaEditor.selectedItem).idMarca;
			itemSelected.marca = MarcaVO(viewArticulo.cmbMarcaEditor.selectedItem).marca;
			itemSelected.idSubmarca = SubMarcaVO(viewArticulo.cmbSubMarcaEditor.selectedItem).idSubmarca;
			itemSelected.submarca = SubMarcaVO(viewArticulo.cmbSubMarcaEditor.selectedItem).submarca;
			itemSelected.descripcion = viewArticulo.txtNombre.text;
			itemSelected.nParte = viewArticulo.txtNoParte.text;
			itemSelected.stockMin = GeneralUtils.StringToNumber(viewArticulo.txtStockMin.text);
			itemSelected.stockMax = GeneralUtils.StringToNumber(viewArticulo.txtStockMax.text);
			itemSelected.unidad = (viewArticulo.cmbUnidad.selectedItem != null) ? viewArticulo.cmbUnidad.selectedItem : "";
			itemSelected.ubicacion = viewArticulo.txtUbicacion.text;
			itemSelected.fechaAdquisicion = viewArticulo.dateAdquisicion.selectedDate;
		}
		
		public function saveItem():void
		{
			var arrayValidationResult:Array = Validator.validateAll([viewArticulo.validatorSubcategoria, viewArticulo.validatorMarca, viewArticulo.validatorSubMarca, viewArticulo.validatorUnidad, viewArticulo.validatorNombre, viewArticulo.validatorFechaAlta]);
			switch(titleFormulario){
				case CREAR:
					if(arrayValidationResult.length == 0){
						saveUpdate();
						roArticuloData.insertArticulo(itemSelected);
					}else{
						AlertUtils.showNoticeMessage("Notificación", "Debe de seleccionar los campos obligatorios");
					}
					break;
				case ACTUALIZAR:
					if(arrayValidationResult.length == 0){
						saveUpdate()
						roArticuloData.updateArticulo(itemSelected);
					}else{
						AlertUtils.showNoticeMessage("Notificación", "Debe de seleccionar los campos obligatorios");
					}
					break;
				default:
					break;
			}
		}
		
		public function deleteItem():void
		{
			if(itemSelected != null && itemSelected.idArticulo != null && itemSelected.idArticulo != ""){
				var customAlertConfirmation:AlertConfirmation = new AlertConfirmation();
				customAlertConfirmation.newCustomAlert("Por favor confirma!", "¿Estás seguro de Eliminar el Artículo?", 340, 155);
				customAlertConfirmation.addEventListener(CommonEvent.CUSTOM_ALERT_ACCEPTED_EVENT, listenerAcceptedConfirmation);
				PopUpManager.addPopUp(customAlertConfirmation, DisplayObject(FlexGlobals.topLevelApplication),true);
				
			}
		}
		
		public function cleanFormulario():void
		{
			titleFormulario = CREAR;
			viewArticulo.cmbSubCategoriaEditor.selectedItem = null;
			
			listMarcasEditor = new ArrayCollection();
			viewArticulo.cmbMarcaEditor.enabled = false;
			viewArticulo.cmbMarcaEditor.selectedItem = null;
			
			listSubMarcasEditor = new ArrayCollection();
			viewArticulo.cmbSubMarcaEditor.enabled = false;
			viewArticulo.cmbSubMarcaEditor.selectedItem = null;
			
			viewArticulo.txtNombre.text = "";
			viewArticulo.txtNoParte.text = "";
			viewArticulo.txtStockMin.text = "0";
			viewArticulo.txtStockMax.text = "0";
			viewArticulo.txtUbicacion.text = "";
			viewArticulo.dateAdquisicion.selectedDate = new Date();
			viewArticulo.cmbSubCategoriaEditor.errorString = "";
			viewArticulo.cmbSubMarcaEditor.errorString = "";
			viewArticulo.txtNombre.errorString = "";
			viewArticulo.txtNoParte.errorString = "";
			viewArticulo.txtStockMin.errorString = "";
			viewArticulo.txtStockMax.errorString = "";
			viewArticulo.txtUbicacion.errorString = "";
			viewArticulo.dateAdquisicion.errorString = "";
			
			enableCombosFilter();
			
		}
		
		/**
		 * Limpia los filtros
		 */
		protected function cleanFilters():void{
			viewArticulo.cmbSubCategoria.selectedItem = null;
			viewArticulo.cmbMarca.selectedItem = null;
			viewArticulo.cmbSubMarca.selectedItem = null;
			
			enableCombosFilter();
			updateData();
		}
		
		public function selectedItem(_event:MouseEvent):void
		{
			titleFormulario = "Actualizar";
			itemSelected = _event.currentTarget.selectedItem as ArticuloVO;
			selectedCombos();
			viewArticulo.vsArticulo.selectedIndex = 1;
		}
		
		/**
		 * Se encarga de seleccionar los combos en el formulario de acuerdo al Articulo seleccionado en la tabla
		 */
		private function selectedCombos():void{
			
			//Selecciona la Subcategoria a partir del itemSelected (Articulo)
			trace("Init");
			trace("listSubCategoriasEditor.length: " + listSubCategoriasEditor.length);
			trace(itemSelected);
			//Sub Categoria
			//Marca
			//SubMarca
			//Nombre Articulo
			//No. Parte
			//Stock Minimo
			//Stock Máximo
			//Ubicación
			//Unidad
			//Fecha Adquisición
			//Estatus
			
			for each(var objSubCategoria:SubCategoriaVO in listSubCategoriasEditor){
				if(objSubCategoria.idSubcategoria == itemSelected.idsubcategoria){
					viewArticulo.cmbSubCategoriaEditor.selectedItem = objSubCategoria;
					upListMarcasEditor();
					break;
				}
			}
			
			for each (var str:String in viewArticulo.cmbUnidad.dataProvider){
				if(itemSelected.unidad == str){
					viewArticulo.cmbUnidad.selectedItem = str;
				}
			}
		}
		
		public function listenerAcceptedConfirmation(_event:CommonEvent):void
		{
			if(itemSelected != null){
				roArticuloData.deleteMarca(itemSelected);
			}
		}
		
		/*************************************************************************/
		/***********************	REMOTE OBJECTS	******************************/
		/*************************************************************************/
		//catArticulos
		public function resultCatItems(_event:ResultEvent):void
		{
			try{
				if(_event.result != null){
					listArticulos = _event.result as ArrayCollection;						
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de los Artículos");
			}
		}
		
		public function faultCatItems(_event:FaultEvent):void
		{
			AlertUtils.showErrorMessage("Error", "No se pudieron cargar los Artículos.");
		}
		
		//insertArticulo
		public function insertItemHandler(_event:ResultEvent):void
		{
			try{
				if(_event.result != null){
					itemSelected = new ArticuloVO();
					if(listArticulos != null){
						listArticulos.addItem(ArticuloVO(_event.result));
						cleanFormulario();
					}
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo guardar la información del Artículo");
			}
		}
		
		public function insertItemFault(_event:FaultEvent):void
		{
			AlertUtils.showErrorMessage("Error", "No se pudo guardar el Artículo.");
		}
		
		//updateArticulo
		public function updateItemHandler(_event:ResultEvent):void
		{
			try{
				if(_event.result != null){
					itemSelected = new ArticuloVO();
					updateData();
					cleanFormulario();
					viewArticulo.vsArticulo.selectedIndex = 0;
				}
			}catch(e:Error){
				//Alert.show("Error", "updateCliente" + e.message);
				AlertUtils.showErrorMessage("Error", "No se pudo actualizar la información del Artículo");
			}
		}
		
		public function updateItemFault(_event:FaultEvent):void
		{
			AlertUtils.showErrorMessage("Error", "No se pudo actualizar el Artículo.");
		}
		
		//deleteArticulo
		public function deleteItemHandler(_event:ResultEvent):void
		{
			try{
				if(_event.result != null){
					itemSelected = null;
					cleanFormulario();
					updateData();
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo borrar el Artículo");
			}
		}
		
		public function deleteItemFault(_event:FaultEvent):void
		{
			AlertUtils.showErrorMessage("Error", "No se pudo borrar el Artículo.");
		}
		
		public function faultCatCategoria (_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las Categorías.");
		}
		
		//subCategoria
		public function resultCatSubCategoria (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					listSubCategorias = _event.result as ArrayCollection;
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de SubCategorías");
			}
		}
		public function faultCatSubCategoria (_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las SubCategorías.");
		}
		
		//catMarca
		public function resultCatMarca (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					listMarcas = _event.result as ArrayCollection;
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de Marcas");
			}
		}
		public function faultCatMarca (_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las Marcas.");
		}
		
		//catSubMarca
		public function resultSubMarca (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					listSubMarcas = _event.result as ArrayCollection;
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de SubMarcas");
			}
		}
		public function faultSubMarca (_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las SubMarcas.");
		}
		
		
		/************************	REMOTE OBJECTS FOR EDITOR'S	*****************************************/
		//subCategoria Editor
		public function resultGetSubCategoriaEditor(_event:ResultEvent):void{
			try{
				if(_event.result != null){
					listSubCategoriasEditor = _event.result as ArrayCollection;
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de SubCategorías -Editor-");
			}
		}
		public function faultGetSubCategoriaEditor(_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de SubCategorías -Editor-");
		}
		
		//marca Editor
		public function resultGetMarcaEditor(_event:ResultEvent):void{
			try{
				if(_event.result != null){
					listMarcasEditor = _event.result as ArrayCollection;
					if(itemSelected != null 
						&& itemSelected.idMarca != null
						&& itemSelected.idMarca != ""){
						//Selecciona la Marca a partir del itemSelected (Articulo)
						for each(var objMarca:MarcaVO in listMarcasEditor){
							trace(objMarca.idMarca + " == " + itemSelected.idMarca);
							if(objMarca.idMarca == itemSelected.idMarca){
								viewArticulo.cmbMarcaEditor.selectedItem = objMarca;
								upListSubMarcasEditor();
								break;
							}
						}
					}
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de Marcas -Editor-");
			}
		}
		public function faultGetMarcaEditor(_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de Marcas -Editor-");
		}
		
		//submarca Editor
		public function resultGetSubMarcaEditor(_event:ResultEvent):void{
			try{
				if(_event.result != null){
					listSubMarcasEditor = _event.result as ArrayCollection;
					if(itemSelected != null && itemSelected.idSubmarca != null){
						for each(var objSubMarca:SubMarcaVO in listSubMarcasEditor){
							trace(objSubMarca.idSubmarca + " == " + itemSelected.idSubmarca);
							if(objSubMarca.idSubmarca == itemSelected.idSubmarca){
								viewArticulo.cmbSubMarcaEditor.selectedItem = objSubMarca;
								break;
							}
						}
					}
				}
			}catch(e:Error){
				AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de SubMarcas -Editor-");
			}
		}
		public function faultGetSubMarcaEditor(_event:FaultEvent):void{
			AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de SubMarcas -Editor-");
		}
	}
}