package com.actioninteractive.nok.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ObraModel
	{
		public var acListObras:ArrayCollection = new ArrayCollection();
		public var acListObrasEncontradas:ArrayCollection = new ArrayCollection();
		
		/**
		 * Contiene la lisa de jornadas laborales
		 */
		public var jornadasList:ArrayCollection = new ArrayCollection([
			{label:"Semana", jornadaLaboral:1}, 
			{label:"Quincena", jornadaLaboral:2}, 
			{label:"Veintena", jornadaLaboral:3}]);
		
		public function ObraModel()
		{
		}
	}
}