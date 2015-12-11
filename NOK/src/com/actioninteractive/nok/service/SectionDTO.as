package com.actioninteractive.nok.service
{
	[RemoteClass(alias="mx.com.nok.section.model.dto")]
	public class SectionDTO
	{
		public var idMenu:int;
		public var menu:String;
		public var nombreCortomenu:String;
		public var lisPortlet:Array;
		
		public function SectionDTO()
		{
		}
	}
}