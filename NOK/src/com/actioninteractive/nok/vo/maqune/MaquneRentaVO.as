package com.actioninteractive.nok.vo.maqune
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.maqune.model.dto.MaquneRentaDTO")]
	public class MaquneRentaVO
	{
		private var folioRenta:String = "" ;
		private var idProveedor:String = "";
		private var costoRenta:Number;
		private var sueldoOperador:Number;
		private var status:String = "";
		private var fechaRenta:String = "";
		private var fechaRegreso:String = "";
		private var idMaqune:String = "";
	}
}