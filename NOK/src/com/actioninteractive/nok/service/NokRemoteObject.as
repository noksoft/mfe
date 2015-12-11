package com.actioninteractive.nok.service
{
	import mx.rpc.remoting.RemoteObject;
	
	public class NokRemoteObject extends RemoteObject
	{
		public function NokRemoteObject(destination:String = "", url:String = "http://166.78.6.164:8080/nok/messagebroker/amf")
		{
			super(destination);
			this.endpoint = url;
		}
	}
}