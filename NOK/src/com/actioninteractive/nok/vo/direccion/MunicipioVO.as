package com.actioninteractive.nok.vo.direccion
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.direccion.model.dto.MunicipioDTO")]
	public class MunicipioVO
	{
		public var idMunicipio:String ='';
		public var municipio:String = '';
		public var idEntidad:String = '';
		public var entidad:String = '';
		public function MunicipioVO()
		{
		}
	}
}