package com.actioninteractive.nok.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SectionVO
	{
		/**
		 * El identificador para la seccion 
		 */
		public var id:int;
		
		/**
		 * La posicion horizontal de la seccion 
		 */
		public var index:int;
		
		/**
		 * El nombre de la seccion usado en el backend 
		 */
		public var name:String;
		
		/**
		 * El nombre de la seccion que es mostrado al usuario
		 */
		public var label:String;
		
		/**
		 * Indica si esta seleccionada la seccion
		 */
		public var selected:Boolean;
		
		/**
		 * Contiene los porlets que el usuario ha definido para esta seccion 
		 */
		public var userSettings:ArrayCollection = new ArrayCollection();
		
		/**
		 * La lista de los portlets que pertenecen a esta seccion 
		 */
		public var portletList:ArrayCollection = new ArrayCollection();
		
		public function SectionVO()
		{
		}
	}
}