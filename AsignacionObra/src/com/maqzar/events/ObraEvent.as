/**
 * Created by Usuario on 09/05/2015.
 */
package com.maqzar.events {
	import com.maqzar.dtos.EmpleadoDisponibleVO;
	import com.maqzar.dtos.ObraVO;
	import flash.events.Event;
	
	public class ObraEvent extends Event {
		
		public static const OBRA_LIST_DATA:String = "obraListData";
		public static const OBRA_GET_EQUIPO_DISPONIBLE:String = "obraGetEquipoDisponible";
		
		public var obra:ObraVO;
		public var empleadoDisponible:EmpleadoDisponibleVO;
		
		
		public function ObraEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
