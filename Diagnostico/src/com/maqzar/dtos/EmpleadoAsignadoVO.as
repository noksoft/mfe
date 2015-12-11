package com.maqzar.dtos
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.obra.model.dto.EmpleadosAsignadosObraDTO")]
	public class EmpleadoAsignadoVO
	{
		public var nombre:String='';
		public var estatus:String='';
		public var habilidades:String='';
		public var idEmpleado:int=0;
		public var idObra:int=0;
		public function EmpleadoAsignadoVO()
		{
		}
	}
}