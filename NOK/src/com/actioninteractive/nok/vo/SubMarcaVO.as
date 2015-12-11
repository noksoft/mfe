package com.actioninteractive.nok.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="mx.com.nok.articulo.model.dto.SubmarcaDTO")]
	public class SubMarcaVO
	{
		
		public var idMarca:String;
		public var idSubmarca:String;
		public var idSubcategoria:String = "";
		public var submarca:String;
		public var marca:String = "";
		public var subcategoria:String = "";
		
		public var filterEstatusSubmarca:String;
		
		public var estatus:String;
		
		public var listSubmarca:ArrayCollection;
				
		public function SubMarcaVO()
		{
		}
	}
}