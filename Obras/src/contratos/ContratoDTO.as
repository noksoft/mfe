package contratos
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.contrato.model.dto.ContratoDTO")]
	public class ContratoDTO
	{
		public function ContratoDTO()
		{
		}
		
		public var idContrato:String;
		public var numeroContrato:String;
		public var descripcion:String;
		public var fechaAlta:String;
		public var fechaInicio:String;
		public var fechaFin:String;
		public var presupuesto:String;
		public var idCliente:String;
		public var estatus:Boolean;
		public var filterEstatus:String;
	}
}