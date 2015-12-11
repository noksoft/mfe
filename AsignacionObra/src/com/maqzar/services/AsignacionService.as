/**
 * Created by Usuario on 09/05/2015.
 */
package com.maqzar.services {
	import com.maqzar.constant.NOKConstants;
	import com.maqzar.dtos.AsignacionDTO;
	import com.maqzar.dtos.AsignacionVO;
	import com.maqzar.dtos.EmpleadoAsignadoVO;
	import com.maqzar.dtos.EmpleadoDisponibleVO;
	import com.maqzar.dtos.EquipoVO;
	import com.maqzar.dtos.EquiposAsignadosObraVO;
	import com.maqzar.dtos.ObraVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	public class AsignacionService {
		private var asignacionRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_OBRAS);
		private var equiposRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_EQUIPOS);
		private var obrasRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_OBRAS);
		public function AsignacionService() {
			asignacionRemote.endpoint = NOKConstants.SERVICE_URL;
			asignacionRemote.showBusyCursor = true;
			obrasRemote.endpoint = NOKConstants.SERVICE_URL;
			obrasRemote.showBusyCursor = true;
			equiposRemote.endpoint = NOKConstants.SERVICE_URL;
			equiposRemote.showBusyCursor = true;
		}
		
		public function findAll(vo:AsignacionVO):AsyncToken
		{
			return asignacionRemote.infoAsignacion(vo);
		}
		
		public function update(vo:AsignacionVO):AsyncToken
		{
			return asignacionRemote.updateAsignacion(vo);
		}
		
		public function save(vo:AsignacionVO):AsyncToken
		{
			return asignacionRemote.saveAsignacion(vo);
		}
		
		public function del(vo:AsignacionVO):AsyncToken
		{
			return asignacionRemote.delAsignacion(vo);
		}
		
		
		public function findAllObras(vo:ObraVO):AsyncToken {
			return obrasRemote.infoObra(vo);
		}
		
		public function findAllEmpleados(empleado:EmpleadoDisponibleVO):AsyncToken
		{
			return asignacionRemote.infoEmpleadoDisponible(empleado);
		}
		
		public function findAllEquipos(equipo:EquipoVO):AsyncToken
		{
			return equiposRemote.infoEquipo(equipo);
 		}
		
		public function findAllEquiposAsignados(equiposAsignadosObraVO:EquiposAsignadosObraVO):AsyncToken
		{
			var asignacion:AsignacionDTO = new AsignacionDTO();
			asignacion.idObra = equiposAsignadosObraVO.idObra.toString();
			asignacion.idEmpleado = '';
			asignacion.idEquipo = '';
			asignacion.idAsignacionObra = '';
			asignacion.typeQuery = "EQUIPOS-ASIGNADOS";
			return asignacionRemote.infoAsignacionesDisponiblesObra(asignacion);
		}
		
		public function findaAllEmpleadosAsignados(empleadosAsignados:EmpleadoAsignadoVO):AsyncToken
		{
			return asignacionRemote.infoEmpleadosAsignadosObra(empleadosAsignados);
		}
		
		public function cambiaEstatusEquipo2(equipo:EquiposAsignadosObraVO):AsyncToken
		{
			return asignacionRemote.cambiaEstatusEquipo(equipo);
		}
		
		public function cambiaEstatusEmpleado(empleado:EmpleadoAsignadoVO):AsyncToken
		{
			return asignacionRemote.cambiaEstatusEmpleado(empleado);
		}
		
		public function addEmpleado(empleadosAsignados:EmpleadoAsignadoVO):AsyncToken
		{
			return asignacionRemote.addEmpleado(empleadosAsignados);
		}
		
		public function addEquipo(equiposDisponibles:EquiposAsignadosObraVO):AsyncToken
		{
			return asignacionRemote.addEquipo(equiposDisponibles);
		}
		
		public function validaEmpleado(empleado:EmpleadoDisponibleVO):AsyncToken
		{
			// Regresa una lista de equipos que el empleado tiene asignado.
			// Falta revisar el servicio en JAVA
			
			return asignacionRemote.validaEmpleado(empleado);
		}
		
		public function infoAsignacionesDisponiblesObra(asignacion:AsignacionDTO):AsyncToken
		{
			return asignacionRemote.infoAsignacionesDisponiblesObra(asignacion);
		}

		public function insertAsignacionObraService(asignacionDTO:AsignacionDTO):AsyncToken {
			trace("Entra a enviar el insertAisgnacion");
			return asignacionRemote.insertAsignacionObra(asignacionDTO);
		}
	}
}
