package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.core.usuario.model.dto.UsuarioDTO")]
	public class UsuarioDTO
	{
		public var status:Boolean = true;
		public var idPerfil:String = "";	
		public var perfil:String = "";		
		public var usuario:String = "";
		public var rfcUsuario:String = "";//rfcEmpleado
		public var ip:String = "";
		public var pass:String = "";
		public var nombre:String = "";
		
		public var idUsuario:String = "";
		public var idEmpleado:String = "";
		public var materno:String = "";
		public var paterno:String = "";
		public var fechaAlta:String = "1900/1/1";
		
		public function UsuarioDTO()
		{
		}
	}
}