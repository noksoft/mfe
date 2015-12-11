package
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.obra.model.dto.ObraDTO")]
	public class ObraDTO
	{
		public var idObra:String = ""; 
		public var claveObra:String = "";
		public var nombre:String = ""; 
		public var lat:String = "";
		public var lng:String = "";
		public var idEmpleado:String = "";
		public var presupuestoEstimado:Number;
		public var contrato:String = "";
		public var status:String = ""; 
		public var fechaInicio:String = "";
		public var fechaTermina:String = "";
		public var idEntidad:String = "";
		public var idMunicipio:String = "";
		public var idLocalidad:String = "";
		public var jornadaLaboral:int;
		public var descripcion:String = "";
		public function ObraDTO()
		{
		}
	}
}