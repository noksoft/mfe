package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.obra.model.dto.ObraDTO")]
	public class ObraVO
	{
		public var idObra:String = ''; 
		public var claveObra:String = '';
		public var nombre:String = ''; 
		public var lat:String = '';
		public var lng:String = '';
		public var idEmpleado:String = '';
		public var presupuestoEstimado:Number = 0;
		public var contrato:String = '';
		public var status:String = 'true'; 
		public var fechaInicio:String = '';
		public var fechaTermina:String = '';
		public var idEntidad:String = '';
		public var idMunicipio:String = '';
		public var idLocalidad:String = '';
		public var jornadaLaboral:int = 0;
		public var descripcion:String = '';
		public function ObraVO()
		{
		}
	}
}