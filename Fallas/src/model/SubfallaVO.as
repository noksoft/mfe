package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.falla.model.dto.SubfallaDTO")]
	public class SubfallaVO
	{
		public var idFalla:String = "";
		public var falla:String = "";
		public var idSubfalla:String = "";
		public var subfalla:String = "";
		public var estatus:Boolean = true;
	}
}