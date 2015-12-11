package com.actioninteractive.nok.delegate
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.vo.direccion.EntidadVO;
	import com.actioninteractive.nok.vo.direccion.MunicipioVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	import com.actioninteractive.nok.vo.direccion.LocalidadVO;

	public class DireccionService
	{
		private var direccionRemote:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_DIRECCION);
		public function DireccionService()
		{
			direccionRemote.endpoint = NokConstants.SERVICE_URL;
			direccionRemote.showBusyCursor = true;
		}
		//---->
		public function catEntidadService(entidad:EntidadVO):AsyncToken
		{
			return direccionRemote.catEntidad(entidad);
		}
		public function catMunicipioService(municipio:MunicipioVO):AsyncToken
		{
			return direccionRemote.catMunicipioAopSession(municipio);
		}
		public function catLocalidadService(localidad:LocalidadVO):AsyncToken
		{
			return direccionRemote.catLocalidadAopSession(localidad);
		}
	}
}