package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.falla.model.dto.FallaDTO")]
	public class FallaVO
	{
		public var idFalla:String = "";
		public var falla:String = "";
		public var estatus:Boolean = true;
		public var filterEstatusFalla:String = "true";
	}
}