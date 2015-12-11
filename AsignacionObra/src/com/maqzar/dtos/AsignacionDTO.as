package com.maqzar.dtos
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.asignacion.model.dto.AsignacionDTO")]
	public class AsignacionDTO
	{
		public var idAsignacionObra:String;
		public var tipoAsignacion:String;
		public var idObra:String;
		public var fechaAsignacion:String;
		public var nombreObra:String;
		public var descripcionObra:String;
		public var idEmpleado:String;
		public var nombre:String;
		public var paterno:String;
		public var materno:String;
		public var nombreCompleto:String;
		public var idEquipo:String;
		public var numeroeconomico:String;
		public var descripcion:String;
		public var tipocategoria:String;
		public var categoria:String;
		public var subcategoria:String;
		public var estatus:String;
		public var habilidades:String;
		public var typeQuery:String;
		public var estatusEquipo:String;
		public var typeInsert:String;
		public var transferencia:Boolean;
		public function AsignacionDTO()
		{
		}
	}
}