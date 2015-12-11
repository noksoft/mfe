package com.actioninteractive.nok.delegate
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.vo.MarcaMotorVO;
	import com.actioninteractive.nok.vo.equipo.EquipoVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import org.swizframework.utils.services.MockDelegateHelper;

	public class EquipoService implements EquipoServiceInterface
	{
		private var EquipoRO:RemoteObject = new RemoteObject (NokConstants.SERVICE_DESTINATION_EQUIPO);
		private var mockHelper : MockDelegateHelper;
		
		public function EquipoService()
		{
			mockHelper = new MockDelegateHelper();
			EquipoRO.endpoint = NokConstants.SERVICE_URL;
			EquipoRO.showBusyCursor = true;
		}
		
		/**
		 * Obtiene la lista de maquinas registradas en el sistema NOK
		 * 
		 * @productversion NOK v1
		 * @author Ricardo Zaragoza
		 * @param MaquneVO
		 * */
		public function getEquipolist(equipoVO:EquipoVO):AsyncToken{
			return EquipoRO.infoEquipoAopSession(equipoVO);
		}
		
		/**
		 * Inserta una nueva equipo
		 * 
		 * @productversion NOK v1
		 * @author Ricardo Zaragoza
		 * @param EquipoVO
		 * */
		public function insertEquipo(equipoVO:EquipoVO):AsyncToken{
			return EquipoRO.insertEquipoAopSession(equipoVO);	
		}
		
		/**
		 * Actualiza un equipo
		 * 
		 * @productversion NOK v1
		 * @author Ricardo Zaragoza
		 * @param EquipoVO
		 * */
		public function updateEquipo(equipoVO:EquipoVO):AsyncToken{
			return EquipoRO.updateEquipoAopSession(equipoVO);
		}
		
		/**
		 * Elimina un equipo
		 * 
		 * @productversion NOK v1
		 * @author Ricardo Zaragoza
		 * @param EquipoVO
		 * */
		public function deleteEquipo(equipoVO:EquipoVO):AsyncToken{
			Alert.show("Se va a eliminar el equipo: " + equipoVO.idEquipo);
			return EquipoRO.deleteEquipoAopSession(equipoVO);
		}
		
		/**
		 * Actualiza el estatus de un equipo
		 * 
		 * @productversion NOK v1
		 * @author Ricardo Zaragoza Solís
		 * @param EquipoVO
		 * */
		public function updateEstatusEquipo(equipoVO:EquipoVO):AsyncToken{
			return EquipoRO.updateEstatusEquipoAopSession(equipoVO);
		}
		
		/**
		 * Obtiene la lista de marcas de motor
		 * 
		 * @productversion NOK v1
		 * @author Ricardo Zaragoza Solís
		 * param MarcaMotorVO
		 **/
		public function getMarcasMotor(marcaMotorVO:MarcaMotorVO):AsyncToken{
			return EquipoRO.infoMarcasMotorAopSession(marcaMotorVO);
		}
	}
}