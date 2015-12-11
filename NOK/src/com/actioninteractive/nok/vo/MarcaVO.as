package com.actioninteractive.nok.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="mx.com.nok.articulo.model.dto.MarcaDTO")]
	public class MarcaVO
	{
		
		public var idMarca:String;	
		public var marca:String;		
		public var idSubcategoria:String;		
		public var subcategoria:String;		
		public var filterEstatusMarca:String;		
		public var filterEstatusSubmarca:String;		
		public var filterEstatusArticulo:String;
		public var estatus:Boolean = true;
		
		private var _listSubmarca:ArrayCollection;
		private var _listMarca:ArrayCollection;
		
		
		public function MarcaVO()
		{
			
		}

		public function get listMarca():ArrayCollection
		{
			return _listMarca;
		}

		public function set listMarca(value:ArrayCollection):void
		{
			_listMarca = value;
		}

		public function get listSubmarca():ArrayCollection
		{
			return _listSubmarca;
		}

		public function set listSubmarca(value:ArrayCollection):void
		{
			_listSubmarca = value;
		}
		public function getMarca():String
		{
			return marca;
		}

	}
}