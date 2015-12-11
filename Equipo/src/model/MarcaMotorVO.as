package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.equipo.model.dto.MarcaMotorDTO")]
	public class MarcaMotorVO
	{
		public var idMarcaMotor = "";
		public var marcaMotor = "";
		public var filterEstatusMarcaMotor = "true";
		public var estatus:Boolean = true;;	
	}
}