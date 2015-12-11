package model
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class RequisicionModel
	{
		public var acRequisiciones:ArrayCollection = new ArrayCollection();
		public var acRequisicionesDetalle:ArrayCollection = new ArrayCollection();
		public var requisicionSelected:RequisicionVO = new RequisicionVO();
		public var requisicionDetalleSelected:RequisicionDetalleDTO
		public var acArticulos:ArrayCollection = new ArrayCollection();
		public var acEmpleadosRequisicion:ArrayCollection = new ArrayCollection();
		public var acEmpleadosAdquisicion:ArrayCollection = new ArrayCollection();
		
		public var titleFormulario:String = RequisicionModel.CREAR;
		
		public static const CREAR:String = "Crear";
		public static const ACTUALIZAR:String = "Actualizar";
	}
}