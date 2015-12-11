package com.actioninteractive.nok.vo
{
	
	[Bindable]
	[RemoteClass(alias="mx.com.nok.empleado.model.dto.HabilidadDTO")]
	public class HabilidadDTO
	{
		public var idHabilidad:String='';
		public var habilidad:String='';
		public var idEmpleado:String='';
		public var descripcion:String='';
		public var status:String='';
		public var filterEstatusFalla:String="";
		public function HabilidadDTO()
		{
		}
	}
}