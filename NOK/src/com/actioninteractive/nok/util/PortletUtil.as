package com.actioninteractive.nok.util
{
	import com.actioninteractive.nok.vo.PortletVO;

	public class PortletUtil
	{
		public function PortletUtil()
		{
		}
		
		/**
		 * Cambia el tamaño y la posición de un portlet a otro para cuando
		 * se mueve de lugar un portlet 
		 * @param portlet1
		 * @param portlet2
		 * 
		 */
		public static function swapPortletPositionAndSize(portlet1:PortletVO, portlet2:PortletVO):void{
			var size1:String = portlet1.main_posicion;
			var size2:String = portlet2.main_posicion;
			var position1:int = portlet1.posicion;
			var position2:int = portlet2.posicion;
			
			portlet1.main_posicion = size2;
			portlet2.main_posicion = size1;
			
			portlet1.posicion = position2;
			portlet2.posicion = position1;
		}
	}
}