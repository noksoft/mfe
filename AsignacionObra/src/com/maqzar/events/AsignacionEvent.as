/**
 * Created by Usuario on 09/05/2015.
 */
package com.maqzar.events {
import com.maqzar.dtos.AsignacionDTO;
import com.maqzar.dtos.EmpleadoAsignadoVO;
import com.maqzar.dtos.EmpleadoDisponibleVO;
import com.maqzar.dtos.EquipoVO;
import com.maqzar.dtos.EquiposAsignadosObraVO;

import flash.events.Event;

import mx.collections.ArrayCollection;

public class AsignacionEvent extends Event {
    public static const ASIGNACION_SAVE:String = "asignacionSave";
    public static const ASIGNACION_UPDATE:String = "asignacionUpda";
    public static const ASIGNACION_DELETE:String = "asignacionDelete";
    public static const ASIGNACION_FINDALL:String = "asignacionFindAll";
    public static const ASIGNACION_FINDALL_BY_ID:String = "asignacionFindAllById";
	public static const ASIGNACION_GET_EMPLEADOS_DISPONIBLES:String = "asignacionGetEmpleados";
	public static const ASIGNACION_GET_EQUIPOS_DISPONIBLES:String = "asignacionGetEquiposDisponibles";
	public static const ASIGNACION_GET_EQUIPOS_ASIGNADOS:String = "asignacionGetEquiposAsignados";
	public static const ASIGNACION_GET_EMPLEADOS_ASIGNADOS:String = "asignacionGetEmpleadosAsignados";
	public static const ASIGNACION_CAMBIA_ESTATUS_EQUIPO:String = "asignacionCambiaEstatusEquipo";
	public static const ASIGNACION_CAMBIA_ESTATUS_EMPLEADO:String = "asignacionCambiaEstatusEmpleado";
	public static const ASIGNACION_REFRESCA_GRID_DESDE_COMBO:String = "asignacionRefrescaGridDesdeCombo";
	
	public static const ADD_PERSONAL:String = "addPersonal";
	public static const ADD_EQUIPO:String = "addEquipo";
	public static const EMPLEADO_SELECCIONADO:String = "empleadoSeleccionado";
	public static const VALIDA_EMPLEADO_DISPONIBILIDAD:String = "validaEmpleadoDisponibilidad";
	public static const LISTA_EQUIPOS_ASIGNADOS_A_EMPLEADO:String = "listaEquiposAsignadosAEmpleados";
	
	public static const CALL_ASIGNACIONES_DISPONIBLES_EMPLEADOS:String = "callAsignacionesDisponiblesEmpleados";
	public static const CALL_ASIGNACIONES_DISPONIBLES_EQUIPOS:String = "callAsignacionesDisponiblesEquipos";
	
	public var empleadosDisponibles:EmpleadoDisponibleVO;
	public var equiposDisponibles:EquipoVO;
	public var equiposAsignadosObraVO:EquiposAsignadosObraVO;
	public var empleadosAsignados:EmpleadoAsignadoVO;
	public var listado:ArrayCollection;
	public var asignacionDTO:AsignacionDTO;
	public static const CALL_EQUIPOS_QUE_TIENE_EMPLEADO:String = "callEquiposQueTieneEmpleado";
	public static const LISTA_EQUIPOS_ASIGNADOS_A_EMPLEADO_LISTADO:String = "listaEquiposAsignadosAEmpleadoListado";
	public static const INSERT_ASIGNACION_OBRA:String = "insertAsignacionObra";
	public static const CIERRA_POPUP:String = "cierraPopup";
	
	

	
    public function AsignacionEvent(type:String) {
        super(type, true, true);
    }
}
}
