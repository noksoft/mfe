package model
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="mx.com.nok.articulo.model.dto.MarcaDTO")]
	public class MarcaVO
	{
		
		public var idMarca:String = "";	
		public var marca:String = "";		
		public var idSubcategoria:String = "";		
		public var subcategoria:String = "";	
		public var filterEstatusMarca:String = "";
		public var estatus:Boolean = true;

	}
}