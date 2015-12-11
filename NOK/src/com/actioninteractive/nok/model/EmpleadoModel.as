package com.actioninteractive.nok.model
{
	import com.actioninteractive.nok.vo.EmpleadoVO;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class EmpleadoModel
	{
		public var acListEmpleados:ArrayCollection = new ArrayCollection();
		
		public var empleadosBusquedaList:ArrayCollection = new ArrayCollection();
		
		public var empleadoSelected:EmpleadoVO;
		
		public var habilidadList:ArrayCollection = new ArrayCollection();
		
		public var perfilesList:ArrayCollection;
		
		public function EmpleadoModel()
		{
		}
	}
}