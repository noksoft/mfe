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
		public var cantidad:Number; 
		public var stockMin:int;
		public var stockMax:int;
		public var costoUnitario:Number;
		public var costoTotal:Number;
		public var ubicacion:String = ""; 
		public var unidad:String = "";
		public var fechaAdquisicion:Date = new Date();
		public var estatus:Boolean = true;
		public var filterEstatusArticulo:String = "";
		public var idTipocategoria:String = "";
		public var nombreTipocategoria:String = "Articulo";
	}
}