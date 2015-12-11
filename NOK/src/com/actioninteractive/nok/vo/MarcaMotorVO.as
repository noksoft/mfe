package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.equipo.model.dto.MarcaMotorDTO")]
	public class MarcaMotorVO
	{
		public var idMarcaMotor:String = "";
		public var marcaMotor:String = "";
		public var filterEstatusMarcaMotor:String ="";
		public var estatus:Boolean = false;	
	}
}