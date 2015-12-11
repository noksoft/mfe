package com.actioninteractive.nok.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="mx.com.nok.categoria.model.dto.SubcategoriaDTO")]
	public class SubCategoriaVO
	{
		
		public var idCategoria:String = "";
		public var categoria:String = "";
		public var idSubcategoria:String = "";
		public var subcategoria:String = "";
		public var estatus:Boolean;
		public var filterEstatusSubcategoria:String = "";
				
		public function SubCategoriaVO()
		{
		}
	}
}