package com.actioninteractive.nok.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class DireccionModel
	{
		public var acListEntidad:ArrayCollection = new ArrayCollection();
		public var acListMunicipio:ArrayCollection = new ArrayCollection();
		public var acListLocalidad:ArrayCollection = new ArrayCollection();
		
		public var entidadLocated:Boolean;
		public var municipioLocated:Boolean;
		public var localidadLocated:Boolean;
		
		public function DireccionModel()
		{
		}
	}
}