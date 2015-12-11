package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SolicitudModel
	{
		public var acSolicitudes:ArrayCollection 					= new ArrayCollection();
		public var acSolicitudesDetalle:ArrayCollection 			= new ArrayCollection();
		public var solicitudSelected:SolicitudVO 					= new SolicitudVO();
		public var acEmpleadosRequisicion:ArrayCollection 			= new ArrayCollection();
		public var acEmpleadosSolicitud:ArrayCollection				= new ArrayCollection();
		public var acEmpleadosAdquisicion:ArrayCollection			= new ArrayCollection();
		public var acArticulos:ArrayCollection 						= new ArrayCollection();
		public var acFallasEquipo:ArrayCollection					= new ArrayCollection();
		
		public var titleFormulario:String = SolicitudModel.CREAR;
		
		public static const CREAR:String 		= "Crear";
		public static const ACTUALIZAR:String 	= "Actualizar";
		
	}
}