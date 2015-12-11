/**
 * Created by jess on 08/08/15.
 */
package com.maqzar.dtos{
[Bindable]
[RemoteClass(alias="mx.com.nok.falla.model.dto.SubfallaDTO")]
	public class SubFallaDTO	{
		private var _idFalla:String;
		private var _falla:String;
		private var _idSubfalla:String;
		private var _subfalla:String;
		private var _estatus:Boolean;
		public function SubFallaDTO()
		{
			idFalla = "";
			falla = "";
			idSubfalla = "";
			subfalla = "";
			estatus = true;
		}

		public function get idFalla():String {
			return _idFalla;
		}

		public function set idFalla(value:String):void {
			_idFalla = value;
		}

		public function get falla():String {
			return _falla;
		}

		public function set falla(value:String):void {
			_falla = value;
		}

		public function get idSubfalla():String {
			return _idSubfalla;
		}

		public function set idSubfalla(value:String):void {
			_idSubfalla = value;
		}

		public function get subfalla():String {
			return _subfalla;
		}

		public function set subfalla(value:String):void {
			_subfalla = value;
		}

		public function get estatus():Boolean {
			return _estatus;
		}

		public function set estatus(value:Boolean):void {
			_estatus = value;
		}
	}
}