package com.actioninteractive.nok.service
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.core.usuario.model.dto.UsuarioDTO")]
	public class UsuarioDTO
	{		
		public var status:Boolean = true;
		public var idPerfil:String = "";	
		public var perfil:String = "";		
		public var usuario:String = ""; //"ZAOC810304NM0";
		public var rfcUsuario:String = ""; //"ZAOC810304NM0";//rfcEmpleado
		public var ip:String = "";
		public var pass:String = "";//"admin";
		public var nombre:String = "Loguearse...";	
		
		public var idUsuario:String = "";
		public var idEmpleado:String = "";
		public var materno:String = "";
		public var paterno:String = "";
		public var fechaAlta:String = "";
		public var errorLogin:String = "";
		
		public var filterEstatusUsuario:String = "true";

	}
}