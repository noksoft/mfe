package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class UsuarioModel
	{
		public var acUsuarios:ArrayCollection 					= new ArrayCollection();
		public var acEmpleados:ArrayCollection 					= new ArrayCollection();
		public var acPerfiles:ArrayCollection					= new ArrayCollection();
		public var acTiposEmpleados:ArrayCollection 			= new ArrayCollection();
		public var usuarioSelected:UsuarioDTO 					= new UsuarioDTO();
		
		public var titleFormulario:String = UsuarioModel.CREAR;
		
		public static const CREAR:String 		= "Crear";
		public static const ACTUALIZAR:String 	= "Actualizar";
	}
}