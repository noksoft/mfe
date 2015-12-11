package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.componente.model.dto.ComponenteDTO")]
	public class ComponenteVO
	{
		public var idComponente:String;
		public var descripcion:String;
		public var idMenu:String;
		public var menu:String;
		public var componente:String;
		public var nombreSubmenu:String;
		public var nombreCortoComponente:String;	
		public var estatus:Boolean;
		public var filterEstatusComponente:String;
		public function ComponenteVO()
		{
		}
	}
}