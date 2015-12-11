package com.actioninteractive.nok.model
{
	import com.actioninteractive.nok.vo.equipo.EquipoVO;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class EquipoModel
	{
		/*****	Listas	******/
		public var acEquipos:ArrayCollection 			= new ArrayCollection();
		public var acMarcasMotor:ArrayCollection 		= new ArrayCollection();
		public var acTipoMotor:ArrayCollection 			= new ArrayCollection();
		public var acSubTipoMotor:ArrayCollection 		= new ArrayCollection();
		public var acEquiposEncontrados:ArrayCollection = new ArrayCollection();
		
		public var acCombustible:ArrayCollection 		= new ArrayCollection([{name:'Gasolina'}, {name:'Diesel'}, {name:'Gas'}, {name:'Otro'}]);
		public var acTipoRodaje:ArrayCollection 		= new ArrayCollection([{descripcion:'Llantas'}, {descripcion:'Cadena'}, {descripcion:"Rodillo"}, {descripcion:'Otro'}]);
		
		public var equipoVO:EquipoVO 					= new EquipoVO();
		
		public var flagCompEquipos:Boolean 				= false;		
		public var flagServiceMarcasMotor:Boolean 		= true;
		public var flagTipoRodaje:Boolean 				= false;
		
		public var flagSerie:Boolean 					= true;
		public var flagFactura:Boolean 					= true;
		public var flagAlta:Boolean						= true;
		public var flagActualizar:Boolean				= false;
		public var flagEliminar:Boolean					= false;
		
		public var maxAnioModelo:Number;
		
		public function EquipoModel()
		{
		}
	}
}