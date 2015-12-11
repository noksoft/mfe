package com.actioninteractive.nok.vo.equipo
{
	import flash.utils.ByteArray;

	[Bindable]
	[RemoteClass(alias="mx.com.nok.equipo.model.dto.EquipoDTO")]
	public class EquipoVO
	{
		
		public var idEquipo:String = "";
		public var nombre:String = "";
		public var idMarcamotor:String = "0";
		public var marcamotor:String = "";
		//public var idModelomotor:String = "";
		public var modelomotor:String = "";
		public var idMarca:String = "0";
		public var marca:String = "";
		public var idSubmarca:String = "0";
		public var submarca:String = "";
		public var idSubcategoria:String = "0";
		public var subcategoria:String = "";
		public var idCategoria:String = "0";
		public var categoria:String = "";
		public var idtipocategoria:String = "0";
		public var tipocategoria:String = "";
		public var uso:String = "";
		public var numeroeconomico:String = "";
		public var descripcion:String = "";
		public var factura:String = "";
		public var pedimiento:String = "";
		public var permisofederal:String = "";
		public var cambioaceite:String = "0";
		public var combustible:String = "0";
		public var tipomedida:String = "";
		public var verificacion:String = "0";
		public var fechaverificacion:String = "1900/1/1";
		public var tipoverificacion:String = "";
		public var tenencia:String = "1900";
		public var fechatenencia:String = "1900/1/1";
		public var tiporodaje:String = "";
		public var numerollantas:String = "0";
		public var tipollanta:String = "";
		public var rin:String = "0";
		public var numeroserie:String = "0";
		public var hp:String = "0";
		public var torque:String = "0";
		public var peso:String = "0";
		public var dimensioneslargo:String = "0";
		public var dimensionesancho:String = "0";
		public var dimensionesalto:String = "0";
		public var dimaditamientolargo:String = "0";
		public var dimaditamientoancho:String = "0";
		public var dimaditamientoalto:String = "0";
		public var anioequipo:String = "0";
		public var capacidadcarga:String = "0";
		public var numeroejes:String = "0";
		public var numeromotor:String = "0";
		public var numerochasis:String = "0";
		public var numerocabina:String = "0";
		public var kw:String = "0";
		public var voltaje:String = "0";
		public var amperes:String = "0";
		public var capacidadpresion:String = "0";
		public var tipomotor:String = "";
		public var cilindros:String = "0";
		public var sizemotor:String = "0";
		public var pica:String = "0";
		public var golpesminuto:String = "0";
		public var tipoadquisicion:String = "";
		public var fechaadquisicion:String = "1900/1/1";
		public var anioadquisicion:String = "0";
		public var estatus:Boolean;
		public var filterEstatusEquipo:String = "";
		
		//Propiedades de la imagen de la foto
		public var fotoequipo:String = "";
		public var contentFoto:ByteArray = new ByteArray();
		
		//Propiedades de la imagen de la factura
		public var fotofactura:String = "";
		public var contentFactura:ByteArray = new ByteArray();
		
		//Propiedades de la imagen de Pedimento
		public var fotopedimento:String = "";
		public var contentPedimento:ByteArray = new ByteArray();

		
	}
}