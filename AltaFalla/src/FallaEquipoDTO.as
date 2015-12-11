package
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.fallaEquipo.model.dto.FallaEquipoDTO")]
	public class FallaEquipoDTO
	{
		public var id_tfallas:String = "";
        public var tipo_falla:int;
        public var id_empleado:String = "";
        public var id_subfalla:String = "";
        public var descripcion:String;
        public var prioridad:int;
        public var observaciones:String;
        public var fecha_registro:String;
        public var id_equipo:String = "";
        public var id_obra:String = "";
        public var estatus:String = "1";
		
		public var nombreequipo:String;
		public var descripcionequipo:String;
		public var tipoadquisicion:String;
		public var numeroserie:String;
		public var id_tipocategoria:String;
		public var tipocategoria:String;
		public var id_categoria:String;
		public var categoria:String;
		public var numeroeconomico:String = "";
		public var clave_obra:String;
		public var nombreobra:String;
		public var descripcionobra:String;
		public var falla:String;
		public var subfalla:String;
		public function FallaEquipoDTO()
		{
		}
	}
}