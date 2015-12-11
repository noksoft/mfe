package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.core.usuario.model.dto.PerfilDTO")]
	public class PerfilDTO
	{
		public var idPerfil:String = "";	
		public var descripcion:String = "";
		public var estatus:Boolean = true;
		public var filterEstatusPerfil:String = "";
	}
}