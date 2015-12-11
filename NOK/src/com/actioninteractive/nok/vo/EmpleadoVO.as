package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.empleado.model.dto.EmpleadoDTO")]
	public class EmpleadoVO
	{
		public var idEmpleado:String = '';
		public var rfcEmpleado:String = '';
		public var nombre:String= '';
		public var paterno:String= '';
		public var materno:String= '';
		public var telefono:String= '';
		public var celular:String= '';
		public var idLocalidad:String= '';
		public var localidad:String= '';
		public var idMunicipio:String= '';
		public var municipio:String= '';
		public var idEntidad:String= '';
		public var entidad:String= '';
		public var cp:String= '';
		public var numInterior:String= '';
		public var numExterior:String= '';
		public var idTipoEmpleado:String= '';
		public var tipoEmpleado:String= '';
		public var fechaAlta:String= '';
		public var domicilio:String= '';
		public var colonia:String= '';
		public var estatus:String= 'true';
		public var filterEstatusEmpleado:String= '';
		public var isusersystemNOK:Boolean;
		public var esusuario:String = 'false';
		public var password:String='';
		public var idPerfil:String='';
		public function EmpleadoVO()
		{
		}
	}
}