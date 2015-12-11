package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.empleado.model.dto.TipoEmpleadoDTO")]
	public class TipoEmpleadoVO
	{
		public var idTipoEmpleado:String;
		public var tipoEmpleado:String;
		public var estatus:Boolean;
		public var filterEstatusTipoEmpleado:String;
		public function TipoEmpleadoVO()
		{
		}
	}
}