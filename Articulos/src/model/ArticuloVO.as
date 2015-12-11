package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.articulo.model.dto.ArticuloDTO")]
	public class ArticuloVO
	{
		public var idArticulo:String = ""; 
		public var descripcion:String = "";
		public var idMarca:String = "";
		public var marca:String = "";
		public var idSubmarca:String = "";
		public var submarca:String = "";
		public var idsubcategoria:String = "";
		public var subcategoria:String = "";
		public var idcategoria:String = "";
		public var categoria:String = "";
		public var nParte:String = "";
		public var stockMin:int = 0;
		public var stockMax:int = 0; 
		public var cantidad:Number = 0;
		public var costoUnitario:Number = 0;
		public var costoTotal:Number = 0;;
		public var ubicacion:String = ""; 
		public var unidad:String = "";
		public var fechaAdquisicion:Date = new Date();
		public var estatus:Boolean = true;
		public var idTipocategoria:String = "";
		public var nombreTipocategoria:String = "Articulo";
		public var filterEstatusArticulo:String = "true";
	}
}