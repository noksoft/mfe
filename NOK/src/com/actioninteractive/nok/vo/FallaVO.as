package com.actioninteractive.nok.vo
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.falla.model.dto.FallaDTO")]
	public class FallaVO
	{
		public var idFalla:String;
		public var falla:String;
		public var estatus:Boolean;
		public var filterEstatusFalla:String;
		public function FallaVO()
		{
		}
	}
}