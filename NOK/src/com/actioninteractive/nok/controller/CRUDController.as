package com.actioninteractive.nok.controller
{
	import com.actioninteractive.nok.delegate.CRUDService;
	import com.actioninteractive.nok.event.CRUDEvent;
	import com.actioninteractive.nok.model.CRUDModel;
	import com.actioninteractive.nok.vo.ArticuloVO;
	import com.actioninteractive.nok.vo.CategoriaVO;
	import com.actioninteractive.nok.vo.FallaVO;
	import com.actioninteractive.nok.vo.MarcaVO;
	import com.actioninteractive.nok.vo.SubCategoriaVO;
	import com.actioninteractive.nok.vo.SubMarcaVO;
	import com.actioninteractive.nok.vo.SubfallaVO;
	import com.actioninteractive.nok.vo.TipocategoriaVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	
	public class CRUDController extends AbstractController
	{
		public var crudService:CRUDService = new CRUDService();
		
		public function CRUDController()
		{
			super();
		}
		[Inject]
		public var crudModel:CRUDModel;
		[PostConstruct]
		public function init():void
		{
			//traemos las marcas del array
			//getListMarcas();
		}
		
		/**
		 * Maneja todas los faults dentro de los servicios de CRUD
		 * 
		 * @param e FaultEvent
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		public function crudFault(e:FaultEvent):void
		{
			// TODO Auto Generated method stub
			trace("ERROR----->"+e.fault.message);
		}
		
/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										CREATE SERVICES
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		
		/**
		 * Llama al servicio para guardar datos
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.CRUD_SAVE_DATA", properties="marcaVO")]
		public function saveDataMarca(marcaVO:MarcaVO):void
		{
			executeServiceCall(crudService.saveDataMarca(marcaVO),saveResult,crudFault);
		}
		
		/**
		 * Resultado de guardado en el server
		 * 
		 * @param e ResultEvent
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		public function saveResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			crudModel.marcaSaved = true;
			crudModel.acListMarcas.addItem(MarcaVO(e.result));
		}
		
		/**
		 * Agrega una nueva submarca
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.CRUD_SAVE_SUBMARCA", properties="subMarcaVO")]
		public function saveSubMarca(submarca:SubMarcaVO):void
		{
			executeServiceCall(crudService.saveSubMarcaService(submarca),saveSubMarcaResult,crudFault);
		}
		
		private function saveSubMarcaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			crudModel.acListSubMarcas.addItem(SubMarcaVO(e.result));
		}	
		
		/**
		 * Agrega un nuevo producto-articulo a la base de datos
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.ARTICULO_SAVE_DATA", properties="articuloVO")]
		public function saveArticulo(articulo:ArticuloVO):void
		{
			executeServiceCall(crudService.saveArticuloService(articulo),saveArticuloResult,crudFault);
		}
		
		private function saveArticuloResult(e:ResultEvent):void
		{
			crudModel.articuloSaved = true;
		}
		
		/* FALLAS------------------ --------------- ---------------*/
		/**
		 * Llama al servicio para guardar datos de fallas
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.FALLA_SAVE", properties="fallaVO")]
		public function saveFalla(fallaVO:FallaVO):void
		{
			executeServiceCall(crudService.saveFallaService(fallaVO),fallaServiceResult,crudFault);
		}
		
		public function fallaServiceResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			crudModel.acListFallas.addItem(FallaVO(e.result));
		}
		
		[EventHandler(event="CRUDEvent.SUBFALLA_SAVE", properties="subfallaVO")]
		public function saveSubfalla(subfalla:SubfallaVO):void
		{
			executeServiceCall(crudService.saveSubfallaService(subfalla),subFallaResult,crudFault);
		}
		
		private function subFallaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			crudModel.acListSubfallas.addItem(SubfallaVO(e.result));
		}		
		
/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										READ SERVICES
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MARCAS Y SUBMARCAS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		/**
		 * Solicita el listado de marcas que existen dentro del sistema 
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.MARCAS_GET_LIST", properties="marcaVO")]
		public function getListMarcas(marcaVO:MarcaVO):void
		{
			if(crudModel.acListMarcas.length <= 0){
				executeServiceCall(crudService.getListMarcas(marcaVO),getListMarcasResult,crudFault);				
			}
		}
		
		/**
		 * Dispara la petición para obtener la lista de SubCategorias
		 * 
		 * @subCategoriaVO parametro que contiene las propiedades de la subcategoria
		 * @author RZS
		 */
		[EventHandler(event="CRUDEvent.SUBCATEGORIA_LIST_PRODUCTOS", properties="subcategoriaVO")]
		public function getListSubcategoriaProduct (subcategoriaVO:SubCategoriaVO):void{
			trace(subcategoriaVO);
			executeServiceCall(crudService.catSubcategoriasService(subcategoriaVO), getListSubcategoriaProductResult, getListSubcategoriaProductFault);
		}
		
		//Result getListSubcategoriaProduct
		private function getListSubcategoriaProductResult (_event:ResultEvent):void{
			try{
				trace(_event.result);
				if(_event.result != null){
					crudModel.acListSubcategoriasProcutos = _event.result as ArrayCollection;
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		//Fault getListSubcategoriaProduct
		private function getListSubcategoriaProductFault (_fault:FaultEvent):void{
			trace(_fault.message);
		}
		
		/**
		 * Dispara la petición para traer la lista de Categorías
		 * 
		 * @categoriaVO parametro que contiene las propiedades de la categoría que queremos ver
		 * @author RZS
		 */
		[EventHandler(event="CRUDEvent.CATEGORIA_LIST", properties="categoriaVO")]
		public function getListCategorias(categoriaVO:CategoriaVO):void{
			executeServiceCall(crudService.getListCategoriasServices(categoriaVO), getListCategoriasResut, getListCategoriasFault);
		}
		
		//Result getCategorias
		private function getListCategoriasResut (_event:ResultEvent):void{
			if(_event.result != null){
				trace(_event.result);
				crudModel.acListCategoriasProductos = _event.result as ArrayCollection;
				crudModel.acListCategoriasProductos.refresh();
			}
		}
		
		//Fault getCategorias
		private function getListCategoriasFault (_event:FaultEvent):void{
			trace(_event.fault.message);	
		}
		
		/**
		 * Dispara la petición de actualización de la categoria de productos
		 * @categoriaVO Contiene las propiedades de actualizacón de categoría
		 * @RZS
		 */
		[EventHandler(event="CRUDEvent.CATEGORIA_PRODUCTO_UPDATE", properties="categoriaVO")]
		public function updateCategoriaProducto (categoriaVO:CategoriaVO):void{
			executeServiceCall(crudService.updateCategoriaProducto(categoriaVO), resultUpdateCategoriaProducto, faultUpdateCategoriaProducto);
		}
		
		//Result
		private function resultUpdateCategoriaProducto (_event:ResultEvent):void{
			trace(_event.result);
			try{
				if(_event.result != null){
					var tempCategoriaVO:CategoriaVO = _event.result as CategoriaVO;
					for (var i:int = 0; i < crudModel.acListCategoriasProductos.length; i++){
						if(tempCategoriaVO.idCategoria == crudModel.acListCategoriasProductos[i].idCategoria){
							crudModel.acListCategoriasProductos[i].categoria = tempCategoriaVO.categoria;
							crudModel.acListCategoriasProductos.refresh();
							break;
						}
					}
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		//Fault
		private function faultUpdateCategoriaProducto (_event:FaultEvent):void{
			trace(_event.message);
		}
		
		
		/**
		 * Dispara la petición para traer la lista de Submarcas
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.SUBCATEGORIA_LIST", properties="subcategoriaVO")]
		public function getListSubCategorias(subcategoriaVO:SubCategoriaVO):void
		{
			if(crudModel.acListSubMarcas.length <= 0){
				executeServiceCall(crudService.catSubcategoriasService(subcategoriaVO),catSubcategoriaResult,crudFault);				
			}			
		}
		
		/**
		 * Obtiene el listado de las subcategoris que existen dentro del sistema 
		 * las asigna a un ArrayCollection que se enviará a la vista.
		 * @param e Resguarda todos los elementos eviados por el servidor
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		private function catSubcategoriaFault (error:FaultEvent):void{
			trace(error.message);
		}
		
		private function catSubcategoriaResult(event:ResultEvent):void
		{
			crudModel.acListSubcategorias = event.result as ArrayCollection;			
		}
		
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CATEGORIAS Y SUBCATEGORIAS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		
		/**
		 * Obtiene el listado de marcas que existen dentro del sistema 
		 * las asigna a un ArrayCollection que se enviará a la vista.
		 * @param e Resguarda todos los elementos eviados por el servidor
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		public function getListMarcasResult(e:ResultEvent):void
		{
			crudModel.acListMarcas = e.result as ArrayCollection;
			
		}
		
		/****
		 * Inserta una nueva categoría
		 * @categoriaVO Value Object que tiene las propiedades de la nueva categoría a insertar
		 */
		[EventHandler(event="CRUDEvent.CATEGORIA_SAVE", properties="categoriaVO")]
		public function insertCategoria (categoriaVO:CategoriaVO):void{
			trace(categoriaVO);
			executeServiceCall(crudService.saveCategoria(categoriaVO), resultInsertCategoria, faultInsertCategoria);
		}
		
		//Result Insertar Categoría
		private function resultInsertCategoria (_event:ResultEvent):void{
			trace(_event.result);
			try{
				if(_event.result != null){
					crudModel.acListCategoriasProductos.addItem(_event.result as CategoriaVO);
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		//Fault Insertar Categoría
		private function faultInsertCategoria (_event:FaultEvent):void{
			trace(_event.fault.message);
		}
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CATEGORIAS Y SUBCATEGORIAS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
		/**
		 * Soicita los catalogos de Categorias y SubCategorias
		 * 
		 * 
		 */
		[EventHandler(event="CRUDEvent.EVENT_ACTUALIZAR_CATALOGOS_ALTA_EQUIPOS", properties="categoriaVO")]
		public function getCategorias (categoriaVO:CategoriaVO):void{
			//executeServiceCall(crudService.getListCategoriasServices(categoriaVO), getListCategoriaResult, getListCategoriaFault);
			executeServiceCall(crudService.getListCategoriasServices(categoriaVO), getListCategoriaResult, crudFault);
		}
		
		/**
		 * Obtiene el listado de marcas que existen dentro del sistema 
		 * las asigna a un ArrayCollection que se enviará a la vista.
		 * @param e Resguarda todos los elementos eviados por el servidor
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		public function getListCategoriaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			
			try{
				if(e.result != null){
					crudModel.acListCategorias = e.result as ArrayCollection;
					
				}
			}catch(e:Error){
				trace(e.message);
			}
			
		}
/*		
		[EventHandler(event="CRUDEvent.EVENT_SELECCIONA_CATEGORIA", properties="subcategoriaVO")]
		public function getCatalogosSubCategoria (subcategoriaVO:SubCategoriaVO):void{
			executeServiceCall(crudService.catSubcategoriasService(subcategoriaVO), catSubcategoriaResult, catSubcategoriaFault);			
		}*/
	 	
		
		/**
		 * Dispara la petición para traer la lista de Submarcas
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.SUBMARCA_GET_LIST_EQUIPO", properties="subMarcaVO")]
		public function getListSubMarcasEquipo(subMarcaVO:SubMarcaVO):void
		{
			executeServiceCall(crudService.catSubmarcaServiceEquipo(subMarcaVO),catSubmarcaEquipoResult,crudSubMarcaEquipoFault);
			
		}
		
		private function catSubmarcaEquipoResult(event:ResultEvent):void
		{
			crudModel.acListSubMarcasEquipo = event.result as ArrayCollection;			
		}
		
		private function crudSubMarcaEquipoFault (event:FaultEvent):void{
			Alert.show("Error: " + event.message);
		}
		
		/**
		 * Dispara la petición para traer la lista de Submarcas
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.SUBMARCA_GET_LIST", properties="subMarcaVO")]
		public function getListSubMarcas(subMarcaVO:SubMarcaVO):void
		{
			executeServiceCall(crudService.catSubmarcaService(subMarcaVO),catSubmarcaResult,crudFault);
			
		}
		
		private function catSubmarcaResult(event:ResultEvent):void
		{
			crudModel.acListSubMarcas = event.result as ArrayCollection;			
		}
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FALLA Y SUBFALLA ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		/**
		 * Solicita el listado de FALLAS que existen dentro del sistema 
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.FALLA_LIST")]
		public function getListFallas():void
		{
			executeServiceCall(crudService.getListFallasServices(),getListFallasResult,crudFault);
		}
		
		/**
		 * Obtiene el listado de marcas que existen dentro del sistema 
		 * las asigna a un ArrayCollection que se enviará a la vista.
		 * @param e Resguarda todos los elementos eviados por el servidor
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		public function getListFallasResult(e:ResultEvent):void
		{
			crudModel.acListFallas = e.result as ArrayCollection;
		}
		
		/**
		 * Dispara la petición para traer la lista de subfallas
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.SUBFALLA_LIST", properties="subfallaVO")]
		public function getListSubFallas(subfalla:SubfallaVO):void
		{
			executeServiceCall(crudService.catSubfallaService(subfalla),catSubfallaResult,crudFault);
			
		}
		private function catSubfallaResult(event:ResultEvent):void
		{
			crudModel.acListSubfallas = event.result as ArrayCollection;
		}
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ARTICULOS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		/**
		 * Obtiene la información de un articulo basado en su descripción
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.ARTICULO_BUSQUEDA_DATA", properties="articuloVO")]
		public function searchArticuloDescripcion(articulo:ArticuloVO):void
		{
			executeServiceCall(crudService.searchArticulosServices(articulo),searchArticulosResult,crudFault);
			
		}
		
		private function searchArticulosResult(e:ResultEvent):void
		{
			crudModel.acListArticulosResult = e.result as ArrayCollection;
			dispatcher.dispatchEvent(new CRUDEvent(CRUDEvent.ITEM_FOUND_DATA));
		}	
		
		
/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										UPDATE SERVICES
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		/**
		 * Borra una marca, siempre y cuando no tenga elementos usandos por llave foranea
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.CRUD_UPDATE_DATA", properties="marcaVO")]
		public function updateMarca(marcaVO:MarcaVO):void
		{
			executeServiceCall(crudService.updateMarcaService(marcaVO),updateMarcaResult,crudFault);
		}
		
		private function updateMarcaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			trace("ResultEvent-----> updateMarcaResult");
			//getListMarcas();
		}
		
		[EventHandler(event="CRUDEvent.CRUD_UPDATE_SUBMARCA", properties="subMarcaVO")]
		public function updateSubMarca(submarcaVO:SubMarcaVO):void
		{
			executeServiceCall(crudService.updateSubMarcaService(submarcaVO),updateSubMarcaResult,crudFault);
		}
		
		private function updateSubMarcaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			//actualizar la lista de submarcas para ubicar el submarcaVO
		}	
		
		
		//******** FALLAS
		[EventHandler(event="CRUDEvent.FALLA_UPDATE", properties="fallaVO")]
		public function updateFalla(falla:FallaVO):void
		{
			executeServiceCall(crudService.updateFallaService(falla),updateFallaResult,crudFault);
		}
		
		private function updateFallaResult(e:ResultEvent):void
		{
			executeServiceCall(crudService.getListFallasServices(),getListFallasResult,crudFault);
		}
		
		//******** subfallas
		[EventHandler(event="CRUDEvent.SUBFALLA_UPDATE", properties="subfallaVO")]
		public function updateSubfalla(subfalla:SubfallaVO):void
		{
			executeServiceCall(crudService.updateSubFallaService(subfalla),updateSubfallaResult,crudFault);
		}
		
		private function updateSubfallaResult(e:ResultEvent):void
		{
			trace("Event------>ResultEvent------>Subfalla updated");
		}
		
		[EventHandler(event="CRUDEvent.ARTICULO_UPDATE_DATA", properties="articuloVO")]
		public function updateArticulo(articulo:ArticuloVO):void
		{
			executeServiceCall(crudService.updateArticuloService(articulo),updateArticuloResult,crudFault);
		}
		
		private function updateArticuloResult(e:ResultEvent):void
		{
			try{
				if(e.result != null){
					trace("Se actualizao con éxito!");
				}else{
					trace("Ocurrio un error al intentar actualzar.");
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		
/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										DELETE SERVICES
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		/**
		 * Borra una marca, siempre y cuando no tenga elementos usandos por llave foranea
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.CRUD_DELETE_DATA", properties="marcaVO")]
		public function deleteMarca(marca:MarcaVO):void
		{
			crudModel.marcaDeleted = marca;
			executeServiceCall(crudService.deleteMarcaService(marca),deleteMarcaResult,crudFault);
		}
		
		/**
		 * mensaje entregado pro el server en caso de haber borrado exitosamente
		 * 
		 * @param e ResultEvent
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		private function deleteMarcaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			var resultMarca:MarcaVO =  crudModel.marcaDeleted;
			if (e.result)
			{
				for each (var marca:MarcaVO in crudModel.acListMarcas) 
				{
					if (marca.idMarca == resultMarca.idMarca){
						crudModel.acListMarcas.removeItemAt(crudModel.acListMarcas.getItemIndex(marca));
						crudModel.acListMarcas.refresh();
					}
				}
			}else{
				Alert.show("No se pudo eliminar porque está siendo usada la marca");
			}
			
			
		}
		
		/**
		 * Borra una marca, siempre y cuando no tenga elementos usandos por llave foranea
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.CRUD_DELETE_SUBMARCA",properties="subMarcaVO")]
		public function deleteSubMarca(submarca:SubMarcaVO):void
		{
			crudModel.subMarcaDeleted = submarca;
			executeServiceCall(crudService.deleteSubMarcaService(submarca),deleteSubMarcaResult,crudFault);
		}
		
		private function deleteSubMarcaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			var resultMarca:SubMarcaVO =  crudModel.subMarcaDeleted;
			if (e.result)
			{
				for each (var marca:SubMarcaVO in crudModel.acListSubMarcas) 
				{
					if (marca.idSubmarca == resultMarca.idSubmarca){
						crudModel.acListSubMarcas.removeItemAt(crudModel.acListSubMarcas.getItemIndex(marca));
						crudModel.acListSubMarcas.refresh();
					}
				}
			}else{
				Alert.show("No se pudo eliminar porque está siendo usada la Submarca");
			}
		}
		
		
		
		/**
		 * Borra una falla, siempre y cuando no tenga elementos usandos por llave foranea
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.FALLA_DELETE", properties="fallaVO")]
		public function deleteFalla(falla:FallaVO):void
		{
			crudModel.fallaDeleted = falla;
			executeServiceCall(crudService.deleteFallaService(falla),deleteFallaResult,crudFault);
		}
		
		/**
		 * mensaje entregado pro el server en caso de haber borrado exitosamente
		 * 
		 * @param e ResultEvent
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		private function deleteFallaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			var resultFalla:FallaVO =  crudModel.fallaDeleted;
			if (e.result)
			{
				for each (var falla:FallaVO in crudModel.acListFallas) 
				{
					if (falla.idFalla == resultFalla.idFalla){
						crudModel.acListFallas.removeItemAt(crudModel.acListFallas.getItemIndex(falla));
						crudModel.acListFallas.refresh();
					}
				}
			}else{
				Alert.show("No se pudo eliminar porque está siendo usada la falla");
			}
			
			
		}
		[EventHandler(event="CRUDEvent.ARTICULO_DELETE_DATA", properties="articuloVO")]
		public function deleteArticulo(articulo:ArticuloVO):void
		{
			executeServiceCall(crudService.deleteArticuloService(articulo),deleteArticuloResult,crudFault);
		}
		
		private function deleteArticuloResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(e.result){
				Alert.show("Borrado");
			}else{
				Alert.show("No se puede borrar");
			}
		}
		/**
		 * Borra una subfalla, siempre y cuando no tenga elementos usandos por llave foranea
		 * 
		 * @productversion NOK 1
		 * @author Carlos Zaragoza
		 */
		[EventHandler(event="CRUDEvent.SUBFALLA_DELETE", properties="subfallaVO")]
		public function deleteSubFalla(subfalla:SubfallaVO):void
		{
			crudModel.subFallaDeleted = subfalla;
			executeServiceCall(crudService.deleteSubFallaService(subfalla),deleteSubFallaResult,crudFault);
		}
		
		private function deleteSubFallaResult(e:ResultEvent):void
		{
			// TODO Auto Generated method stub
			var resultFalla:SubfallaVO =  crudModel.subFallaDeleted;
			if (e.result)
			{
				for each (var falla:SubfallaVO in crudModel.acListSubfallas) 
				{
					if (falla.idSubfalla == resultFalla.idSubfalla){
						crudModel.acListSubfallas.removeItemAt(crudModel.acListSubfallas.getItemIndex(falla));
						crudModel.acListSubfallas.refresh();
					}
				}
			}else{
				Alert.show("No se pudo eliminar porque está siendo usada la subfalla");
			}
		}
		
		
		/*********	      SECCIÓN TIPO CATEGORIA     **************/
		/*********  GET_LIST, INSERT, UPDATE, DELETE *************/
		
		/****
		 * Obtiene la lista de tipos de categoría
		 */
		[EventHandler(event="CRUDEvent.TIPOCATEGORIA_GET_LIST", properties="tipocategoriaVO")]
		public function get_tipocategorias(tipocategoriaVO:TipocategoriaVO):void{
			executeServiceCall(crudService.getListTipoCategoria(tipocategoriaVO), resultGetTipocategoria, faultTipocategoria);
		}
		
		//Result Get Tipo categoria
		private function resultGetTipocategoria (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					crudModel.acListTipocategorias = _event.result as ArrayCollection;
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		//FaultEvent Get Tipo categoria
		private function faultTipocategoria (_event:FaultEvent):void{
			trace(_event.fault.message);
			Alert.show("Ocurrio un Error al intentar cargar la lista de Tipo de categorías.");
		}
		
		/****
		 * Inserta un nuevo tipo de categoría
		 * @tipocategoriaVO Value Object que tiene las propiedades de la nueva categoría a insertar
		 */
		[EventHandler(event="CRUDEvent.TIPOCATEGORIA_SAVE_DATA", properties="tipocategoriaVO")]
		public function insertTipocategoria (tipocategoriaVO:TipocategoriaVO):void{
			trace(tipocategoriaVO);
			executeServiceCall(crudService.insertTipocategoria(tipocategoriaVO), resultInsertTipocategoria, faultInsertTipocateria);
		}
		
		//Result Insert Tipo categoria
		private function resultInsertTipocategoria (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					trace("Se inserto el tipo de categoría.");
					trace(_event.result);
					trace(crudModel.acListTipocategorias);
					
					
					crudModel.acListTipocategorias.addItem(_event.result as TipocategoriaVO);
					crudModel.acListTipocategorias.refresh();
					trace(crudModel.acListTipocategorias);
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		//Fault Insert Tipo categoría
		private function faultInsertTipocateria (_event:FaultEvent):void{
			trace("Ocurrio un error al intentar insertar el tipo de categoría. " + _event.fault.message);
		}
		
		/*****
		 * Actualiza el tipo de categoría
		 * @tipocategoriaVO	Value Object que contienen las propiedades a actualizar del tipo de categoría
		 */
		[EventHandler(event="CRUDEvent.TIPOCATEGORIA_UPDATE", properties="tipocategoriaVO")]
		public function updateTipocategoria (tipocategoriaVO:TipocategoriaVO):void{
			trace(tipocategoriaVO.tipocategoria);
			executeServiceCall(crudService.updateTipocategoria(tipocategoriaVO), resultUpdateTipocategoria, faultUpdateTipocategoria);
		}
		
		//Resutl Update tipo categoria
		private function resultUpdateTipocategoria (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					trace("Se actualizo el tipo de categoria.");
					var _tipoCategoriaDTO:TipocategoriaVO = _event.result as TipocategoriaVO;
					for(var i:int = 0; i < crudModel.acListTipocategorias.length; i++){
						if(crudModel.acListTipocategorias[i].id_tipocategoria == _tipoCategoriaDTO.id_tipocategoria){
							crudModel.acListTipocategorias[i].tipocategoria = _tipoCategoriaDTO.tipocategoria;
							crudModel.acListTipocategorias.refresh();
							break;
						}
					}
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		private function faultUpdateTipocategoria (_event:FaultEvent):void{
			trace("Ocurrio un error al intentar actualizar el tipo de categoría. " + _event.fault.message);
		}
		
		/*****
		 * Elimina el tipo de categoría
		 * @tipocategoriaVO	Value Object que contienen las propiedades del tipo de categoría a Eliminar
		 */
		[EventHnadler(event="CRUDEvent.TIPOCATEGORIA_DELETE", properties="tipocategoriaVO")]
		public function deleteTipocategoria (tipocategoriaVO:TipocategoriaVO):void{
			executeServiceCall(crudService.deleteTipocategoria(tipocategoriaVO), resultDeleteTipocategoria, faultDeleteTipocategoria);
		}
		
		//Resutl Update tipo categoria
		private function resultDeleteTipocategoria (_event:ResultEvent):void{
			try{
				if(_event.result != null){
					trace("Se elimino el tipo de categoria.");
					trace(_event.result);
				}
			}catch(e:Error){
				trace(e.message);
			}
		}
		
		private function faultDeleteTipocategoria (_event:FaultEvent):void{
			trace("Ocurrio un error al intentar eliminar el tipo de categoría. " + _event.fault.message);
		}
		
	}
}
