package contratos
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.cliente.model.dto.ClienteDTO")]
	public class ClienteDTO
	{
		public function ClienteDTO()
		{
			
		}
		public var idCliente:String;
		public var rfc:String;
		public var razonSocial:String;
		public var direccion:String;
		public var cp:String;
		public var idMunicipio:String;
		public var idEntidad:String;
		public var idLocalidad:String;
		public var telefono:String;
		public var correo:String;
		public var www:String;
		public var contactoNombre:String;
		public var fechaAlta:String;
		public var estatus:Boolean;
		public var filterEstatus:String;
		
	}
}