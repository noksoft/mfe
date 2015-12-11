package com.actioninteractive.nok.delegate
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.vo.ArticuloVO;
	import com.actioninteractive.nok.vo.CategoriaVO;
	import com.actioninteractive.nok.vo.FallaVO;
	import com.actioninteractive.nok.vo.MarcaVO;
	import com.actioninteractive.nok.vo.SubCategoriaVO;
	import com.actioninteractive.nok.vo.SubMarcaVO;
	import com.actioninteractive.nok.vo.SubfallaVO;
	import com.actioninteractive.nok.vo.TipocategoriaVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import org.swizframework.utils.services.MockDelegateHelper;
	
	public class CRUDService
	{
		private var CRUDRO:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_CRUD);
		private var fallaRO:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_FALLA);
		private var categoriaRO:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_CATEGORIA);
		private var mockHelper : MockDelegateHelper;
		public function CRUDService()
		{
			mockHelper = new MockDelegateHelper();
			CRUDRO.endpoint = NokConstants.SERVICE_URL;
			CRUDRO.showBusyCursor = true;
			fallaRO.endpoint = NokConstants.SERVICE_URL;
			fallaRO.showBusyCursor = true;
			categoriaRO.endpoint = NokConstants.SERVICE_URL;
			categoriaRO.showBusyCursor = true;
		}
/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										CREATE SERVICES
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		public function saveDataMarca(marca:MarcaVO):AsyncToken{
			
			return CRUDRO.insertMarca(marca);
		}
		
		public function saveSubMarcaService(subMarca:SubMarcaVO):AsyncToken{
			
			return CRUDRO.insertSubmarca(subMarca);
		}
		
		public function saveArticuloService(articulo:ArticuloVO):AsyncToken{
			
			return CRUDRO.insertArticulo(articulo);
			trace(articulo.descripcion)
		}
		public function saveFallaService(falla:FallaVO):AsyncToken{
			
			return fallaRO.insertFalla(falla);
		}
		public function saveSubfallaService(subfalla:SubfallaVO):AsyncToken{
			
			return fallaRO.insertSubfalla(subfalla);
		}
		
		public function saveCategoria(categoriaVO:CategoriaVO):AsyncToken{
			return categoriaRO.insertCategoriaAopSession(categoriaVO);
		}
		
		
/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										READ SERVICES
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		/**
		 * Obtiene la lista de marcas
		 * 
		 * @productversion NOK v1
		 * @author Carlos Zaragoza
		 * */
		public function getListMarcas(_marcaVO:MarcaVO):AsyncToken
		{
			return CRUDRO.catMarcaAopSession(_marcaVO);
		}
		public function catSubmarcaServiceEquipo(subMarca:SubMarcaVO):AsyncToken
		{
			return CRUDRO.catSubmarcaAopSession(subMarca);
		}
		public function catSubmarcaService(subMarca:SubMarcaVO):AsyncToken
		{
			return CRUDRO.catSubmarcaAopSession(subMarca);
		}
		//---->FALLAS
		public function getListFallasServices():AsyncToken
		{
			var falla:FallaVO =  new FallaVO();
			falla.idFalla = "";
			falla.filterEstatusFalla = "";
			return fallaRO.catFalla(falla);
		}
		//---->SUBFALLAS
		public function catSubfallaService(subfalla:SubfallaVO):AsyncToken
		{
			return fallaRO.catSubfalla(subfalla);
		}
		//---->CATEGORIAS
		public function getListCategoriasServices(catVO:CategoriaVO):AsyncToken
		{
			/*var categoria:CategoriaVO =  new CategoriaVO();
			categoria.idCategoria = "";
			categoria.filterEstatusCategoria = "";*/
			return categoriaRO.catCategoriaAopSession(catVO);
		}
		//---->SUB CATEGORIA
		public function catSubcategoriasService(subcategoriaVO:SubCategoriaVO):AsyncToken
		{
			return categoriaRO.catSubcategoriaAopSession(subcategoriaVO);
		}
		public function searchArticulosServices(articulo:ArticuloVO):AsyncToken
		{
			return CRUDRO.buscaArticulo(articulo);
		}
		
		
/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										UPDATE SERVICES
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		
		/**
		 * Actualiza el nombre de la marca
		 * 
		 * @productversion NOK v1
		 * @author Carlos Zaragoza
		 * */
		public function updateMarcaService(marca:MarcaVO):AsyncToken
		{
			return CRUDRO.updateMarca(marca);
		}
		/**
		 * Actualiza el nombre de la submarca
		 * 
		 * @productversion NOK v1
		 * @author Carlos Zaragoza
		 * */
		public function updateSubMarcaService(submarca:SubMarcaVO):AsyncToken
		{
			return CRUDRO.updateSubMarca(submarca);
			
		}
		
		public function updateFallaService(falla:FallaVO):AsyncToken
		{
			return fallaRO.updateFalla(falla);
		}
		public function updateSubFallaService(subFalla:SubfallaVO):AsyncToken
		{
			return fallaRO.updateSubfalla(subFalla);
			
		}
		
		public function updateArticuloService(articulo:ArticuloVO):AsyncToken
		{
			return CRUDRO.updateArticulo(articulo);
			
		}
		
		public function updateCategoriaProducto(categoriaVO:CategoriaVO):AsyncToken{
			return categoriaRO.updateCategoriaAopSession(categoriaVO);
		}
		
/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										DELETE SERVICES
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		public function deleteMarcaService(marca:MarcaVO):AsyncToken
		{
			return CRUDRO.deleteMarca(marca);
		}
		public function deleteSubMarcaService(submarca:SubMarcaVO):AsyncToken
		{
			return CRUDRO.deleteSubmarca(submarca);
		}
		//FALLA
		public function deleteFallaService(falla:FallaVO):AsyncToken
		{
			return fallaRO.deleteFalla(falla);
		}
		//SUBFALLA
		public function deleteSubFallaService(subfalla:SubfallaVO):AsyncToken
		{
			return fallaRO.deleteSubfalla(subfalla);
		}
		
		
		public function deleteArticuloService(articulo:ArticuloVO):AsyncToken
		{
			return CRUDRO.deleteArticulo(articulo);
		}

/**
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 										TIPO CATEGORIAS
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * */
		//GET LIST TIPO CATEGORIAS
		public function getListTipoCategoria (tipocategoriaVO:TipocategoriaVO):AsyncToken{
			return categoriaRO.infoTipocategoriaAopSession(tipocategoriaVO);
		}
		
		//INSERT TIPO CATEGORIA
		public function insertTipocategoria(tipocategoriaVO:TipocategoriaVO):AsyncToken{
			return categoriaRO.insertTipocategoriaAopSession(tipocategoriaVO);
		}
		
		//UPDATE TIPO CATEGORIA
		public function updateTipocategoria(tipocategoriVO:TipocategoriaVO):AsyncToken{
			trace(tipocategoriVO.tipocategoria);
			return categoriaRO.updateTipocategoriaAopSession(tipocategoriVO);
		}
		
		//DELETE TIPO CATEGORIA
		public function deleteTipocategoria(tipocategoriaVO:TipocategoriaVO):AsyncToken{
			return categoriaRO.deleteTipocategoriaAopSession(tipocategoriaVO);
		}
	}
}