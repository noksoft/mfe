package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.categoria.model.dto.TipoCategoriaDTO")]
	public class TipocategoriaVO
	{
		public var id_tipocategoria:String = "";
		public var tipocategoria:String = "";
		public var estatus:Boolean = true;
		public var filterEstatusTipocategoria:String = "true";
	}
}