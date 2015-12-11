package com.actioninteractive.nok.delegate
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.vo.ObraVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;

	public class ObraService
	{
		private var obraRemote:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_OBRA);
		public function ObraService()
		{
			obraRemote.endpoint = NokConstants.SERVICE_URL;
			obraRemote.showBusyCursor = true;
		}
		//---->OBRAS
		public function catObraService(obra:ObraVO):AsyncToken
		{
			return obraRemote.infoObraAopSession(obra);
		}
		public function saveObraService(obra:ObraVO):AsyncToken
		{
			return obraRemote.insertObraAopSession(obra);
		}
		public function deleteObraService(obra:ObraVO):AsyncToken
		{
			return obraRemote.deleteObraAopSession(obra);
		}
		
		public function updateObraService(obra:ObraVO):AsyncToken
		{
			// TODO Auto Generated method stub
			return obraRemote.updateObraAopSession(obra);
		}
	}
}