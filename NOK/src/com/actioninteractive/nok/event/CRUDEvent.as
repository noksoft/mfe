package com.actioninteractive.nok.event
{
	import com.actioninteractive.nok.vo.ArticuloVO;
	import com.actioninteractive.nok.vo.CategoriaVO;
	import com.actioninteractive.nok.vo.FallaVO;
	import com.actioninteractive.nok.vo.MarcaVO;
	import com.actioninteractive.nok.vo.SubCategoriaVO;
	import com.actioninteractive.nok.vo.SubMarcaVO;
	import com.actioninteractive.nok.vo.SubfallaVO;
	import com.actioninteractive.nok.vo.TipocategoriaVO;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	public class CRUDEvent extends Event
	{
		public static const CRUD_SAVE_DATA:String = "crudSaveData";
		public static const CRUD_SAVE_SUBMARCA:String = "crudSaveSubMarca";
		public static const CRUD_DELETE_DATA:String = "crudDeleteData";
		public static const CRUD_UPDATE_DATA:String = "crudUpdateData";
		public static const CRUD_GET_DATA:String = "crudGetData";
		public static const CRUD_LIST_MARCAS:String = "crudListMarcas";
		public static const CRUD_LIST_SUBMARCAS:String = "crudListSubMarcas";
		public static const CRUD_DELETE_SUBMARCA:String = "crudDeleteSubMarca";
		public static const CRUD_UPDATE_SUBMARCA:String = "crudUpdateSubMarca";
		
		public static const EVENT_ACTUALIZAR_CATALOGOS_ALTA_EQUIPOS:String = "EventActualizarCatalogosAltaEquipos";
		
		public static const FALLA_SAVE:String = "fallaSave";
		public static const FALLA_DELETE:String = "fallaDelete";
		public static const FALLA_UPDATE:String = "fallaUpdate";
		public static const FALLA_GET_ID:String = "fallaGetId";
		public static const FALLA_LIST:String = "fallaList";
		
		public static const SUBFALLA_SAVE:String = "subfallaSave";
		public static const SUBFALLA_DELETE:String = "subfallaDelete";
		public static const SUBFALLA_UPDATE:String = "subfallaUpdate";
		public static const SUBFALLA_GET_ID:String = "subfallaGetId";
		public static const SUBFALLA_LIST:String = "subfallaList";
		
		public static const CATEGORIA_SAVE:String = "categoriaSave";
		public static const CATEGORIA_DELETE:String = "categoriaDelete";
		public static const CATEGORIA_UPDATE:String = "categoriaUpdate";
		public static const CATEGORIA_GET_ID:String = "categoriaGetId";
		public static const CATEGORIA_LIST:String = "categoriaList";
		
		public static const SUBCATEGORIA_SAVE_PRODUCTOS:String = "subcategoriaSaveProductos";
		public static const SUBCATEGORIA_DELETE_PRODUCTOS:String = "subcategoriaDeleteProductos";
		public static const SUBCATEGORIA_UPDATE_PRODUCTOS:String = "subcategoriaUpdateProductos";
		public static const SUBCATEGORIA_GET_ID_PRODUCTOS:String = "subcategoriaGetIdProductos";
		public static const SUBCATEGORIA_LIST_PRODUCTOS:String = "subcategoriaListProductos";
		
		//public static const CATEGORIA_LIST_PRODUCT:String = "categoriaListProduct";
		public static const CATEGORIA_PRODUCTO_UPDATE:String = "categoriaProductoUpdate";
		
		public static const SUBCATEGORIA_SAVE:String = "subcategoriaSave";
		public static const SUBCATEGORIA_DELETE:String = "subcategoriaDelete";
		public static const SUBCATEGORIA_UPDATE:String = "subcategoriaUpdate";
		public static const SUBCATEGORIA_GET_ID:String = "subcategoriaGetId";
		public static const SUBCATEGORIA_LIST:String = "subcategoriaList";
		
		public static const ARTICULO_SAVE_DATA:String = "articuloSaveData";
		public static const ARTICULO_UPDATE_DATA:String = "articuloUpdateData";
		public static const ARTICULO_DELETE_DATA:String = "articuloDeleteData";
		public static const ARTICULO_LIST_DATA:String = "articuloListData";
		public static const ARTICULO_BUSQUEDA_DATA:String = "articuloBusquedaData";
		public static const ARTICULO_UPDATED:String = "articuloUpdated";
		
		public static const TIPOCATEGORIA_SAVE_DATA:String = "tipocategoriaSaveData";
		public static const TIPOCATEGORIA_DELETE:String = "tipocategoriaDelete";
		public static const TIPOCATEGORIA_UPDATE:String = "tipocategoriaUpdate";
		public static const TIPOCATEGORIA_GET_LIST:String = "tipocategoriaGetList";
		
		public static const MARCAS_GET_LIST:String = "marcasGetList";
		public static const SUBMARCA_GET_LIST:String = "submarcaGetList";
		
		public static const SUBMARCA_GET_LIST_EQUIPO:String = "submarcaGetListEquipo";
		
		public static const ITEM_FOUND_DATA:String = "itemFoundData";
		public static const ITEM_SELECTED_DATA:String = "itemSelectedData";
		
		public static const EVENT_SELECCIONA_CATEGORIA:String = "seleccionaCategoriaEvent";
		
		
		public static const EVENT_SELECT_MOUSE_EVENT:String = "eventSelectMouseEvent";
		
		public var indexListToDelete:int;
		public var marcaVO:MarcaVO;
		public var subMarcaVO:SubMarcaVO;
		public var fallaVO:FallaVO;
		public var subfallaVO:SubfallaVO;
		public var categoriaVO:CategoriaVO;
		public var subcategoriaVO:SubCategoriaVO;
		public var articuloVO:ArticuloVO;
		public var articuloResultado:ArrayCollection;
		public var tipocategoriaVO:TipocategoriaVO;
		
		public var _eventSelected:MouseEvent;
		
		public function CRUDEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}