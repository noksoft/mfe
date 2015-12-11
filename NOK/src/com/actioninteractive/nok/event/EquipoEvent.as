package com.actioninteractive.nok.event
{
	import com.actioninteractive.nok.vo.CategoriaVO;
	import com.actioninteractive.nok.vo.MarcaMotorVO;
	import com.actioninteractive.nok.vo.MarcaVO;
	import com.actioninteractive.nok.vo.SubCategoriaVO;
	import com.actioninteractive.nok.vo.equipo.EquipoVO;
	
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class EquipoEvent extends Event
	{
		public static const GET_EQUIPO_LIST:String 		= "getEquipoList";
		public static const INSERT_EQUIPO:String 		= "insertEquipo";
		public static const UPDATE_EQUIPO:String 		= "updateEquipo";
		public static const DELETE_EQUIPO:String 		= "deleteEquipo";
		public static const REFRESH_EQUIPO:String 		= "refreshEquipo";
		
		public static const BUSCAR_EQUIPO:String 		= "buscarEquipo";
		
		public static const UPLOAD_FOTO:String 			= "uploadFoto";
		public static const UPLOAD_FACTURA:String 		= "uploadFactura";
		public static const UPLOAD_PEDIMENTO:String 	= "uploadPedimento";
		
		public static const MARCAS_GET_LIST:String 		= "marcasGetList";
		public static const GET_MARCAS_MOTOR:String 	= "getMarcasMotor";
		public static const CLEAN_CONTROLS:String 		= "cleanControls";
		public static const EQUIPOS_ENCONTRADOS:String 	= "equiposEncontrados";
		public static const SELECTED_ITEM_FIND:String 	= "selectedItemFind";
		
		public var equipoVO:EquipoVO = new EquipoVO();
		public var categoriaVO:CategoriaVO = new CategoriaVO();
		public var subcategoriaVO:SubCategoriaVO = new SubCategoriaVO();
		public var marcaVO:MarcaVO = new MarcaVO();
		public var marcaMotorVO:MarcaMotorVO = new MarcaMotorVO();
		
		public var name:String = "";
		public var directory:String = "";
		public var content:ByteArray = new ByteArray();
		
		public function EquipoEvent(type:String)
		{
			super(type, true, true);
		}
	}
}