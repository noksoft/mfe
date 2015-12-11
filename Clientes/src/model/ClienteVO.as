package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.cliente.model.dto.ClienteDTO")]
	public class ClienteVO{
		public var idCliente:String = "";
		public var rfc:String = "";
		public var razonSocial:String = "";
		public var direccion:String = "";
		public var cp:String = "";
		public var idMunicipio:String = "";
        public var municipio:String = "";
		public var idEntidad:String = "";
        public var entidad:String = "";
		public var idLocalidad:String = "";
        public var localidad:String = "";
		public var telefono:String = "";
		public var correo:String = "";
		public var www:String = "";
		public var contactoNombre:String = "";
		public var fechaAlta:Date = new Date();
		public var estatus:Boolean = true;
		public var filterEstatus:String = "true";
	}
}