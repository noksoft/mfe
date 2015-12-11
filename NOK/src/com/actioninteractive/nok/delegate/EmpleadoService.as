package com.actioninteractive.nok.delegate
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.vo.EmpleadoVO;
	import com.actioninteractive.nok.vo.HabilidadDTO;
	import com.actioninteractive.nok.vo.PerfilDTO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	public class EmpleadoService
	{
		private var empleadoRemote:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_EMPLEADO);
		private var tipo_test:RemoteObject = new RemoteObject(NokConstants.SERVICE_DESTINATION_TIPO_EMPLEADO);
		
		public function EmpleadoService()
		{
			empleadoRemote.endpoint = NokConstants.SERVICE_URL;
			empleadoRemote.showBusyCursor = true;
			tipo_test.endpoint = NokConstants.SERVICE_URL;
			
		}
		//---->OBRAS
		public function catEmpleadoService(empleado:EmpleadoVO):AsyncToken
		{
			return empleadoRemote.infoEmpleado(empleado);
		}
		public function empleadoSave(empleado:EmpleadoVO):AsyncToken
		{
			return empleadoRemote.insertEmpleadoAopSession(empleado);
		}
		
		public function empleadoBusquedaRFC(empleado:EmpleadoVO):AsyncToken
		{
			return empleadoRemote.infoEmpleadoAopSession(empleado);
		}
		public function empleadoBusqueda(empleado:EmpleadoVO):AsyncToken
		{
			return empleadoRemote.infoEmpleadoAopSession(empleado);
		}
		
		public function empleadoHabilidadSave(habilidad:HabilidadDTO):AsyncToken
		{
			return empleadoRemote.insertHabilidadAopSession(habilidad);
		}
		
		public function empleadoHabilidades(habilidad:HabilidadDTO):AsyncToken
		{
			return empleadoRemote.catHabilidadAopSession(habilidad);
		}
		
		public function empleadoHabilidadActualizar(habilidad:HabilidadDTO):AsyncToken
		{
			return empleadoRemote.updateHabilidadAopSession(habilidad);
		}
		
		public function empleadoBorrarHabilidad(habilidad:HabilidadDTO):AsyncToken
		{
			return empleadoRemote.deleteHabilidadAopSession(habilidad);
		}
		
		
	}
}