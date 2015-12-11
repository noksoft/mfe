package
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.falla.model.dto.FallaDTO")]
	public class FallaDTO
	{
		public var idFalla:String = "";
		public var falla:String = "";
		public var estatus:Boolean;
		public var filterEstatusFalla:String = "";
		public function FallaDTO()
		{
		}
	}
}