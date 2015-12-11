package com.actioninteractive.nok.event
{
	import com.actioninteractive.nok.vo.ObraVO;
	
	import flash.events.Event;

	public class ObraEvent extends Event
	{
		public static const OBRA_LIST_DATA:String = "obraListData";
		public static const OBRA_SAVE_DATA:String = "obraSaveData";
		public static const OBRA_UPDATE_DATA:String = "obraUpdateData";
		
		public static const OBRA_BUSQUEDA_DATA:String = "obraBusquedaData";
		public static const OBRA_DELETE_DATA:String = "obraDeleteData";

		public static const OBRA_SAVE_SUCCESS:String = "obraSaveSuccess";
		public static const OBRA_ITEM_FOUND_DATA:String = "obraItemFoundData";
		public static const OBRA_ITEM_SELECTED_DATA:String = "obraItemSelectedData";
		
		public static const OBRA_RESET_CONTROLS:String = "obraResetControls";
		
		
		
		public var obraVO:ObraVO;
		public function ObraEvent(type:String)
		{
			super(type, true, true);
		}
	}
}