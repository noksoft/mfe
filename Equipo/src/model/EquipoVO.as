package model
{
	import flash.utils.ByteArray;

	[Bindable]
	[RemoteClass(alias="mx.com.nok.equipo.model.dto.EquipoDTO")]
	public class EquipoVO
	{
		public var  id_equipo:String = "";
		public var  nombre:String = "";
		public var  id_submarca:String = "";
		public var  submarca:String = "";
		public var  descripcion:String = "";
		public var  numeroserie:String = "";
		public var  tipoadquisicion:String = "";
		public var  fotoequipo:String = "";
		public var  fechaadquisicion:String = "1900/1/1";
		public var  id_marcamotor:String = "0";
		public var  marcamotor:String = "";
		public var  modelomotor:String = "";
		public var  id_marca:String = "";
		public var  marca:String = "";
		public var  id_subcategoria:String = "";
		public var  subcategoria:String = "";
		public var  id_categoria:String = "";
		public var  categoria:String = "";
		public var  id_tipocategoria:String = "";
		public var  tipocategoria:String = "";
		public var  numeroeconomico:String = "";
		public var  factura:String = "";
		public var  pedimiento:String = "";
		public var  cambioaceite:String = "";
		public var  tipomedida:String = "";
		public var  verificacion:String = "";
		public var  fechaverificacion:String = "1900/1/1";
		public var  llanta:String = "";
		public var  hp:String = "";
		public var  torque:String = "";
		public var  peso:String = "";
		public var  dimensioneslargo:String = "";
		public var  dimensionesancho:String = "";
		public var  dimensionesalto:String = "";
		public var  anioequipo:String = "";
		public var  capacidad:String = "";
		public var  numeromotor:String = "0";
		public var  numerochasis:String = "";
		public var  numerocabina:String = "";
		public var  kw:String = "0";
		public var  voltaje:String = "0";
		public var  amperes:String = "0";
		public var  capacidadpresion:String = "";
		public var  pica:String = "";
		public var  golpesminuto:String = "0";
		public var  anioadquisicion:String = "";
		public var filterEstatusEquipo:String = "true";
		public var estatus:Boolean = true;
		
		//Propiedades de la imagen de la foto
		public var contentFoto:ByteArray = new ByteArray();

	}
}