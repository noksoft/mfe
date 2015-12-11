/**
 * Created by Usuario on 09/05/2015.
 */
package com.maqzar.events {
import com.maqzar.dtos.EmpleadoDisponibleVO;
import com.maqzar.dtos.EquipoVO;

import flash.events.Event;
import com.maqzar.dtos.EquiposAsignadosObraVO;
import com.maqzar.dtos.EmpleadoAsignadoVO;

public class AsignacionEvent extends Event {
    public static const ASIGNACION_SAVE:String = "asignacionSave";
    public static const ASIGNACION_UPDATE:String = "asignacionUpda";
    public static const ASIGNACION_DELETE:String = "asignacionDelete";
    public static const ASIGNACION_FINDALL:String = "asignacionFindAll";
    public static const ASIGNACION_FINDALL_BY_ID:String = "asignacionFindAllById";
	public static const ASIGNACION_GET_EMPLEADOS_DISPONIBLES:String = "asignacionGetEmpleados";
	public static const ASIGNACION_GET_EQUIPOS_DISPONIBLES:String = "asignacionGetEquiposDisponibles";
	public var empleadosDisponibles:EmpleadoDisponibleVO;
	public var equiposDisponibles:EquipoVO;
	public var equiposAsignadosObraVO:EquiposAsignadosObraVO;
	public static const ASIGNACION_GET_EQUIPOS_ASIGNADOS:String = "asignacionGetEquiposAsignados";
	public static const ASIGNACION_GET_EMPLEADOS_ASIGNADOS:String = "asignacionGetEmpleadosAsignados";
	public static const ASIGNACION_CAMBIA_ESTATUS_EQUIPO:String = "asignacionCambiaEstatusEquipo";
	public static const ASIGNACION_CAMBIA_ESTATUS_EMPLEADO:String = "asignacionCambiaEstatusEmpleado";
	public static const ASIGNACION_REFRESCA_GRID_DESDE_COMBO:String = "asignacionRefrescaGridDesdeCombo";
	public var empleadosAsignados:EmpleadoAsignadoVO;
	public static const ADD_PERSONAL:String = "addPersonal";
	public static const ADD_EQUIPO:String = "addEquipo";
	
	

	
    public function AsignacionEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }
}
}
