package com.actioninteractive.nok.delegate
{
	import com.actioninteractive.nok.vo.equipo.EquipoVO;
	
	import mx.rpc.AsyncToken;

	public interface EquipoServiceInterface
	{
		
		function getEquipolist(equipoVO:EquipoVO):AsyncToken;
		function insertEquipo(equipoVO:EquipoVO):AsyncToken;
		function updateEquipo(equipoVO:EquipoVO):AsyncToken;
		function deleteEquipo(equipoVO:EquipoVO):AsyncToken;
		function updateEstatusEquipo(equipoVO:EquipoVO):AsyncToken;
	}
}