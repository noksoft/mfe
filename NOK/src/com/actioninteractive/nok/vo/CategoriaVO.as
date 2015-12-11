package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.categoria.model.dto.CategoriaDTO")]
	public class CategoriaVO
	{
		public var idCategoria:String = "";
		public var categoria:String = "";
		public var idtipocategoria:String = "";
		public var tipocategoria:String = "";
		public var estatus:Boolean;
		public var filterEstatusCategoria:String = "true";
		public function CategoriaVO()
		{
		}
	}
}