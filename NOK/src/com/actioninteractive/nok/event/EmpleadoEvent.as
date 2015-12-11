package com.actioninteractive.nok.event
{
	import com.actioninteractive.nok.vo.EmpleadoVO;
	import com.actioninteractive.nok.vo.HabilidadDTO;
	
	import flash.events.Event;
	
	public class EmpleadoEvent extends Event
	{
		public static const EMPLEADO_LIST_DATA:String = "empleadoListData";
		public static const EMPLEADO_SAVE:String = "empleadoSave";
		public static const EMPLEADO_BUSCAR_POR_RFC:String = "empleadoBuscarEmpleadoPorRFC";
		public static const EMPLEADO_BUSCAR:String = "empleadoBuscar";
		public static const EMPLEADO_ENCONTRADO_POR_RFC:String = "empleadoEncontradoPorRFC";	
		public static const EMPLEADO_BUSCAR_PERFILES_USUARIO:String = "empleadoBuscarPerfilesUsuario";
		public static const EMPLEADO_GUARDAR_HABILIDAD:String = "empleadoGuardarHabilidad";
		public static const EMPLEADO_LIMPIA_FORMULARIO:String = "empleadoLimpiaFormulario";
		public static const EMPLEADO_ACTUALIZAR_HABILIDAD:String = "empleadoActualizarHabilidad";
		public static const EMPLEADO_RECUPERA_LISTA_DESPUES_ACTUALIZACION:String = "empleadoRecuperaListaDespuesActualizacion";
		public static const EMPLEADO_BOTON_BUSCAR_EMPLEADO:String = "empleadoBotonBuscarEmpleado";
		
		public static const EMPLEADO_HABILIDAD_BORRAR:String = "empleadoHabilidadBorrar";
		
		public var empleadoVO:EmpleadoVO;
		public var busqueda:String;
		public var habilidad:HabilidadDTO;
		
		public function EmpleadoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}