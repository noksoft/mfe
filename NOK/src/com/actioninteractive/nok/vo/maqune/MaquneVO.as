package com.actioninteractive.nok.vo.maqune
{
	import flash.utils.ByteArray;

	[Bindable]
	[RemoteClass(alias="mx.com.nok.maqune.model.dto.MaquneDTO")]
	public class MaquneVO
	{
		
		public var idMaqune:String = "";
		public var nombre:String = "";
		public var idMarcamotor:String = "";
		public var marcamotor:String = "";
		//public var idModelomotor:String = "";
		public var modelomotor:String = "";
		public var idMarca:String = "";
		public var marca:String = "";
		public var idSubmarca:String = "";
		public var submarca:String = "";
		public var idSubcategoria:String = "";
		public var subcategoria:String = "";
		public var idCategoria:String = "";
		public var categoria:String = "";
		public var uso:String = "";
		public var numeroeconomico:String = "";
		public var descripcion:String = "";
		public var factura:String = "";
		public var pedimiento:String = "";
		public var permisofederal:String = "";
		public var cambioaceite:String = "";
		public var combustible:String = "";
		public var tipomedida:String = "";
		public var verificacion:String = "";
		public var fechaverificacion:String = "";
		public var tipoverificacion:String = "";
		public var tenencia:String = "";
		public var fechatenencia:String = "";
		public var tiporodaje:String = "";
		public var numerollantas:String = "";
		public var tipollanta:String = "";
		public var rin:String = "";
		public var numeroserie:String = "";
		public var hp:String = "";
		public var torque:String = "";
		public var peso:String = "";
		public var dimensioneslargo:String = "";
		public var dimensionesancho:String = "";
		public var dimensionesalto:String = "";
		public var dimaditamientolargo:String = "";
		public var dimaditamientoancho:String = "";
		public var dimaditamientoalto:String = "";
		public var anioequipo:String = "";
		public var capacidadcarga:String = "";
		public var numeroejes:String = "";
		public var numeromotor:String = "";
		public var numerochasis:String = "";
		public var numerocabina:String = "";
		public var kw:String = "";
		public var voltaje:String = "";
		public var amperes:String = "";
		public var capacidadpresion:String = "";
		public var tipomotor:String = "";
		public var cilindros:String = "";
		public var sizemotor:String = "";
		public var pica:String = "";
		public var golpesminuto:String = "";
		public var tipoadquisicion:String = "";
		public var fechaadquisicion:String = "";
		public var anioadquisicion:String = "";
		public var foto:String = "";
		public var estatus:Boolean;
		public var filterEstatusMaqune:String = "";
		
		//Propiedades de la imagen de la foto
		public var nameFoto:String = "";
		public var contentFoto:ByteArray = new ByteArray();
		
		//Propiedades de la imagen de la factura
		public var nameFactura:String = "";
		public var contentFactura:ByteArray = new ByteArray();
		
		//Propiedades de la imagen de Pedimento
		public var namePedimento:String = "";
		public var contentPedimento:ByteArray = new ByteArray();
		
	}
}