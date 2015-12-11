/**
 * @author Carlos Zaragoza Ortiz
 */
package com.maqzar.views {
import com.maqzar.dtos.AsignacionDTO;
import com.maqzar.dtos.EmpleadoAsignadoVO;
	import com.maqzar.dtos.EmpleadoDisponibleVO;
	import com.maqzar.dtos.EquipoVO;
	import com.maqzar.dtos.EquiposAsignadosObraVO;
	import com.maqzar.dtos.ObraVO;
	import com.maqzar.events.AsignacionEvent;
	import com.maqzar.events.ObraEvent;
	import com.maqzar.models.AsignacionModel;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	import mx.managers.PopUpManager;
	
	import spark.components.Group;
	import spark.components.TitleWindow;
	import spark.events.IndexChangeEvent;

	public class AsignacionBase extends Group {
		/**
		 * inyecciones
		 *
		 * */
		[Inject]
		[Bindable]
		public var asignacionModel:AsignacionModel;
		private var view:Asignacion = Asignacion(this);
		public function AsignacionBase() {
			super();
		}
		public function creacionCompleta():void{
			// Instancian cada una de los eventos de carga para asignacion de recursos.
			var obraEvent:ObraEvent;
			obraEvent = new ObraEvent(ObraEvent.OBRA_LIST_DATA);
			obraEvent.obra = new ObraVO();
			dispatchEvent(obraEvent);

			var empleadosDisponiblesEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ASIGNACION_GET_EMPLEADOS_DISPONIBLES);
			empleadosDisponiblesEvent.empleadosDisponibles = new EmpleadoDisponibleVO();
			dispatchEvent(empleadosDisponiblesEvent);

			// Trae todos los equipos de la empresa
			var equipoDisponibleEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ASIGNACION_GET_EQUIPOS_DISPONIBLES);
			equipoDisponibleEvent.equiposDisponibles = new EquipoVO();
			dispatchEvent(equipoDisponibleEvent);
		}
		/*
		* Recibe la persona que va a pasar al grid de personal asignado.
		*
		* */
		public function asignaPersonal(event:MouseEvent):void {
			if(view.ddlObras.selectedIndex != -1){
				trace(view.dataGridPersonalPorAsignar.selectedItem);
				if(view.dataGridPersonalPorAsignar.selectedItem  != null){
					var asignaEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ADD_PERSONAL);
					var empleado:EmpleadoAsignadoVO = new EmpleadoAsignadoVO();
					empleado.idObra = view.ddlObras.selectedItem.idObra;
					empleado.idEmpleado = EmpleadoDisponibleVO(view.dataGridPersonalPorAsignar.selectedItem).idEmpleado;
					asignaEvent.empleadosAsignados =  empleado;
					dispatchEvent(asignaEvent);	
				}else{
					trace("No puede lanzar");
				}
            }else{
                Alert.show("No puedes continuar si no tienes seleccionada una obra");
            }

		}
		/*
		* Asigna la maquinaria al grid asignado.
		*
		* */
		public function asignaMET(event:MouseEvent):void {
            if(view.ddlObras.selectedIndex != -1){
                //Abrir el Popup para pedir al empleado de la lista de arriba, dicha lista ya esdta cargada en el grid anterior.
				asignacionModel.maquinariaSelected = view.dataGridMaquinaEquipoTransporteDisponible.selectedItem as EquipoVO;
				asignacionModel.obraSelected = view.ddlObras.selectedItem as ObraVO;
				var popUpEmpleado:EmpleadoMaquinariaPopup = EmpleadoMaquinariaPopup(PopUpManager.createPopUp(this, EmpleadoMaquinariaPopup,true)  as spark.components.TitleWindow);
				PopUpManager.centerPopUp(popUpEmpleado);
				

				popUpEmpleado.addEventListener(AsignacionEvent.EMPLEADO_SELECCIONADO,empleadoSeleccionadoEvent);
				
            }else
            {
                Alert.show("No puedes pasar maquinaria si no tienes seleccionada la lista de obras");
            }

		}
		public function empleadoSeleccionadoEvent(event:AsignacionEvent):void
		{
			trace(event);
			trace("Empleado Seleccionado")
			/*
			var asignaEquipoEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ADD_EQUIPO);
			var equipo:EquipoVO = view.dataGridMaquinaEquipoTransporteDisponible.selectedItem as EquipoVO;
			var equipoEnvioServicio:EquiposAsignadosObraVO = new EquiposAsignadosObraVO();
			equipoEnvioServicio.idObra = view.ddlObras.selectedItem.idObra;
			equipoEnvioServicio.idEquipo = int(equipo.id_equipo);
			asignaEquipoEvent.equiposAsignadosObraVO = equipoEnvioServicio;
			dispatchEvent(asignaEquipoEvent);
			*/
		}
		/*
		* Selecciona el objeto del DDL para cambiar los valores dentro del detalle de la función.
		*
		* */
		[EventHandler(event="AsignacionEvent.ASIGNACION_REFRESCA_GRID_DESDE_COMBO")]
		public function obrasSelectedDdl():void
		{
			// 
			asignacionModel.obraSelected = view.ddlObras.selectedItem as ObraVO;
			//Dispara el evento para cargar los equipos-maquinarias asignados a la obra
			var equiposAsignadoEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ASIGNACION_GET_EQUIPOS_ASIGNADOS);
			var equiposAsignadosBusqueda:EquiposAsignadosObraVO = new EquiposAsignadosObraVO();
			equiposAsignadosBusqueda.idObra = Number(asignacionModel.obraSelected.idObra);
			equiposAsignadoEvent.equiposAsignadosObraVO = equiposAsignadosBusqueda;
			dispatchEvent(equiposAsignadoEvent);
			
			var empleadosAsignadosBusqueda:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ASIGNACION_GET_EMPLEADOS_ASIGNADOS);
			var empleado:EmpleadoAsignadoVO = new EmpleadoAsignadoVO();
			empleado.idObra =  Number(asignacionModel.obraSelected.idObra)
			empleadosAsignadosBusqueda.empleadosAsignados = empleado;
			dispatchEvent(empleadosAsignadosBusqueda);
		}
		
		public function cambiaEstatusEquipo(data:*):void
		{
			var equipos:AsignacionDTO = data as AsignacionDTO;
			var vo:EquiposAsignadosObraVO = new EquiposAsignadosObraVO();
			vo.idEquipo = int(equipos.idEquipo);
			vo.idObra = int(equipos.idObra);
			vo.estatus = equipos.estatusEquipo == 'A'?'I':'A';
			var cambiaEstatusEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ASIGNACION_CAMBIA_ESTATUS_EQUIPO);
			cambiaEstatusEvent.equiposAsignadosObraVO = vo;
			dispatchEvent(cambiaEstatusEvent);
		}
		public function cambiaEstatusEmpleado(data:*):void
		{
			var vo:EmpleadoAsignadoVO = data as EmpleadoAsignadoVO;
			var cambiaEstatusEvent:AsignacionEvent = new AsignacionEvent(AsignacionEvent.ASIGNACION_CAMBIA_ESTATUS_EMPLEADO);
			cambiaEstatusEvent.empleadosAsignados = vo;
			dispatchEvent(cambiaEstatusEvent);
		}
	}
}
