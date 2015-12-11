package com.actioninteractive.nok.model
{
	import com.actioninteractive.nok.vo.FallaVO;
	import com.actioninteractive.nok.vo.MarcaVO;
	import com.actioninteractive.nok.vo.SubMarcaVO;
	import com.actioninteractive.nok.vo.SubfallaVO;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CRUDModel
	{
		/**
		 * Lista de marcas para el list
		 */
		public var acListMarcas:ArrayCollection = new ArrayCollection();
		public var acListSubMarcasEquipo:ArrayCollection = new ArrayCollection();
		public var acListSubMarcas:ArrayCollection = new ArrayCollection();
		public var acListArticulos:ArrayCollection = new ArrayCollection();
		public var acListArticulosResult:ArrayCollection = new ArrayCollection();
		public var acListFallas:ArrayCollection = new ArrayCollection();
		public var acListSubfallas:ArrayCollection = new ArrayCollection();
		public var acListCategorias:ArrayCollection = new ArrayCollection();
		public var acListCategoriasProductos:ArrayCollection = new ArrayCollection();
		public var acListSubcategorias:ArrayCollection = new ArrayCollection();
		public var acListSubcategoriasProcutos:ArrayCollection = new ArrayCollection();
		public var acListMarcasProductos:ArrayCollection = new ArrayCollection();
		public var acListSubMarcasProductos:ArrayCollection = new ArrayCollection();
		public var acListTipocategorias:ArrayCollection = new ArrayCollection();
		
		public var marcaVO:MarcaVO = new MarcaVO();
		public var marcaSaved:Boolean = false;
		public var submarcarSaved:Boolean = false;
		public var articuloUpdated:Boolean = false;
		public var marcaDeleted:MarcaVO;
		public var subMarcaDeleted:SubMarcaVO;
		public var fallaDeleted:FallaVO;
		public var subFallaDeleted:SubfallaVO;
		
		public var flagEnableMarca:Boolean = false;
		public var flagEnableSubMarca:Boolean = false;
		
		public var articuloSaved:Boolean = true;
		public var acListaUnidades:ArrayCollection =new ArrayCollection([
			{label:"Pieza", data:1}, 
			{label:"Caja", data:2}, 
			{label:"Galón", data:3},
			{label:"Litro", data:4},
			{label:"Tonelada", data:5},
			{label:"Kilos", data:6}]);
		
		public var acListaVerificacion:ArrayCollection = new ArrayCollection([
			{idVerificacion:1, verificacion:"00"},
			{idVerificacion:2, verificacion:"01"},
			{idVerificacion:3, verificacion:"02"},
			{idVerificacion:4, verificacion:"03"},
			{idVerificacion:5, verificacion:"04"},
			{idVerificacion:5, verificacion:"AA"}
			]);
	
		public var acListaTenencia:ArrayCollection = new ArrayCollection([
			{idTenencia:1, tenencia:"2000"},
			{idTenencia:2, tenencia:"2001"},
			{idTenencia:3, tenencia:"2002"},
			{idTenencia:4, tenencia:"2003"},
			{idTenencia:5, tenencia:"2004"},
			{idTenencia:6, tenencia:"2005"},
			{idTenencia:7, tenencia:"2006"},
			{idTenencia:8, tenencia:"2007"},
			{idTenencia:9, tenencia:"2008"},
			{idTenencia:10, tenencia:"2009"},
			{idTenencia:11, tenencia:"2010"},
			{idTenencia:12, tenencia:"2011"},
			{idTenencia:13, tenencia:"2012"},
			{idTenencia:14, tenencia:"2013"},
			{idTenencia:15, tenencia:"2014"}
		]);
		
		public var fallaVO:FallaVO = new FallaVO();
		public function CRUDModel()
		{
		}
		
	}
}