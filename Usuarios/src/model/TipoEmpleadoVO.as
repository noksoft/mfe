package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.empleado.model.dto.TipoEmpleadoDTO")]
	public class TipoEmpleadoVO
	{
		public var idTipoEmpleado:String = "";
		public var tipoEmpleado:String = "";
		public var estatus:Boolean = true;
		public var filterEstatusTipoEmpleado:String = "true";
	}
}