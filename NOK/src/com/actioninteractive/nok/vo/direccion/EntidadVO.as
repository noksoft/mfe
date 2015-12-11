package com.actioninteractive.nok.vo.direccion
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.direccion.model.dto.EntidadDTO")]
	public class EntidadVO
	{
		public var idEntidad:String='';
		public var entidad:String='';
		public var sigla:String='';
		public function EntidadVO()
		{
		}
	}
}