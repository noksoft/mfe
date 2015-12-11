package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.proveedor.model.dto.ProveedorDTO")]
	public class ProveedorVO
	{
		public var idProveedor:String = "";
		public var rfcProveedor:String = "";
		public var razonSocial:String = "";
		public var nombreContacto:String = "";
		public var telefonoEmpresa:String = "";
		public var celularEmpleado:String = "";
		public var www:String = "";
		public var correo:String = "";
		public var idLocalidad:String = "";
		public var localidad:String = "";
		public var idMunicipio:String = "";
		public var municipio:String = "";
		public var idEntidad:String = "";
		public var entidad:String = "";
		public var nombreComercial:String = "";
		public var estatus:Boolean = true;
		public var filterEstatusProveedor:String = "true";
	}
}