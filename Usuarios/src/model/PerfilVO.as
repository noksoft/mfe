package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.core.usuario.model.dto.PerfilDTO")]
	public class PerfilVO
	{
		public var idPerfil:String = "";	
		public var descripcion:String = "";
		public var estatus:Boolean = true;
	}
}