///**
// * Created by Usuario on 09/05/2015.
// */
//package com.maqzar.services {
//	import com.maqzar.constant.NOKConstants;
//	import com.maqzar.dtos.AsignacionVO;
//	import com.maqzar.dtos.EmpleadoAsignadoVO;
//	import com.maqzar.dtos.EmpleadoDisponibleVO;
//	import com.maqzar.dtos.EquipoVO;
//	import com.maqzar.dtos.EquiposAsignadosObraVO;
//	import com.maqzar.dtos.ObraVO;
//
//	import mx.rpc.AsyncToken;
//	import mx.rpc.remoting.RemoteObject;
//
//	public class AsignacionService {
//		private var asignacionRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_OBRAS);
//		private var equiposRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_EQUIPOS);
//		private var obrasRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_OBRAS);
//		public function AsignacionService() {
//			asignacionRemote.endpoint = NOKConstants.SERVICE_URL;
//			asignacionRemote.showBusyCursor = true;
//			obrasRemote.endpoint = NOKConstants.SERVICE_URL;
//			obrasRemote.showBusyCursor = true;
//			equiposRemote.endpoint = NOKConstants.SERVICE_URL;
//			equiposRemote.showBusyCursor = true;
//
//
//		}
//
//		public function findAll(vo:AsignacionVO):AsyncToken
//		{
//			return asignacionRemote.infoAsignacion(vo);
//		}
//
//		public function update(vo:AsignacionVO):AsyncToken
//		{
//			return asignacionRemote.updateAsignacion(vo);
//		}
//
//		public function save(vo:AsignacionVO):AsyncToken
//		{
//			return asignacionRemote.saveAsignacion(vo);
//		}
//
//		public function del(vo:AsignacionVO):AsyncToken
//		{
//			return asignacionRemote.delAsignacion(vo);
//		}
//
//
//		public function findAllObras(vo:ObraVO):AsyncToken {
//			return obrasRemote.infoObra(vo);
//		}
//
//		public function findAllEmpleados(empleado:EmpleadoDisponibleVO):AsyncToken
//		{
//			// TODO Auto Generated method stub
//			return asignacionRemote.infoEmpleadoDisponible(empleado);
//		}
//
//		public function findAllEquipos(equipo:EquipoVO):AsyncToken
//		{
//			return equiposRemote.infoEquipo(equipo);
// 		}
//
//		public function findAllEquiposAsignados(equiposAsignadosObraVO:EquiposAsignadosObraVO):AsyncToken
//		{
//			// TODO Auto Generated method stub
//			return asignacionRemote.infoEquiposAsignadosObra(equiposAsignadosObraVO);
//		}
//
//		public function findaAllEmpleadosAsignados(empleadosAsignados:EmpleadoAsignadoVO):AsyncToken
//		{
//			// TODO Auto Generated method stub
//			return asignacionRemote.infoEmpleadosAsignadosObra(empleadosAsignados);
//		}
//
//		public function cambiaEstatusEquipo(equipo:EquiposAsignadosObraVO):AsyncToken
//		{
//			// TODO Auto Generated method stub
//			return asignacionRemote.cambiaEstatusEquipo(equipo);
//		}
//
//		public function cambiaEstatusEmpleado(empleado:EmpleadoAsignadoVO):AsyncToken
//		{
//			// TODO Auto Generated method stub
//			return asignacionRemote.cambiaEstatusEmpleado(empleado);
//		}
//
//		public function addEmpleado(empleadosAsignados:EmpleadoAsignadoVO):AsyncToken
//		{
//			// TODO Auto Generated method stub
//			return asignacionRemote.addEmpleado(empleadosAsignados);
//		}
//
//		public function addEquipo(equiposDisponibles:EquiposAsignadosObraVO):AsyncToken
//		{
//			// TODO Auto Generated method stub
//			return asignacionRemote.addEquipo(equiposDisponibles);
//		}
//	}
//}
