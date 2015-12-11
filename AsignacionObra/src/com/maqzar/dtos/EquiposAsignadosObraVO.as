package com.maqzar.dtos
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.obra.model.dto.EquiposAsignadosObraDTO")]
	public class EquiposAsignadosObraVO
	{
		private var _idObra:int;
		private var _idEquipo:int;
		private var _descripcion:String;
		private var _numeroEconomico:String;
		private var _tipoCategoria:String;
		private var _categoria:String;
		private var _subCategoria:String;
		private var _estatus:String;
		
		public function EquiposAsignadosObraVO()
		{
		}

		public function get estatus():String
		{
			return _estatus;
		}

		public function set estatus(value:String):void
		{
			_estatus = value;
		}

		public function get subCategoria():String
		{
			return _subCategoria;
		}

		public function set subCategoria(value:String):void
		{
			_subCategoria = value;
		}

		public function get categoria():String
		{
			return _categoria;
		}

		public function set categoria(value:String):void
		{
			_categoria = value;
		}

		public function get tipoCategoria():String
		{
			return _tipoCategoria;
		}

		public function set tipoCategoria(value:String):void
		{
			_tipoCategoria = value;
		}

		public function get numeroEconomico():String
		{
			return _numeroEconomico;
		}

		public function set numeroEconomico(value:String):void
		{
			_numeroEconomico = value;
		}

		public function get descripcion():String
		{
			return _descripcion;
		}

		public function set descripcion(value:String):void
		{
			_descripcion = value;
		}

		public function get idEquipo():int
		{
			return _idEquipo;
		}

		public function set idEquipo(value:int):void
		{
			_idEquipo = value;
		}

		public function get idObra():int
		{
			return _idObra;
		}

		public function set idObra(value:int):void
		{
			_idObra = value;
		}

	}
}