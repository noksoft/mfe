package com.actioninteractive.nok.vo
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.view.AssetManager;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="mx.com.nok.portlet.model.dto.PortletDTO")]
	public class PortletVO
	{
		private var _posicion:int = NokConstants.PORTLET_POSITION_NOT_SET;
		private var _main_posicion:String = NokConstants.PORTLET_SIZE_NORMAL;	//Modifique la propiedad _size por la propiedad main_posicion
		private var _componente_class:String = "";				//Modifique esta propiedad por _name por componente_class
		
		/**
		 * El indentificador unico del portlet, es el id_config
		 */
		public var id_config:int;			//Modifique la propiedad id por id_config
		
		/**
		 * Propiedad que guarda el id del componente
		 */
		public var id_componente:int;
		
		/**
		 * Propiedad que guarda el id del menu
		 */
		public var id_menu:int;
		
		/**
		 * El nombre corto del portlet
		 */
		public var nombreCortoComponente:String = "";
		
		/**
		 * El nombre corto del Menú
		 */
		public var nombreCortoMenu:String = "";
		
		/**
		 * El nombre del portlet mostrado al usuario 
		 */
		public var nombre_submenu:String = "";
		
		/**
		 * Contiene el icono del portlet 
		 */
		public var icon:Class = AssetManager.portletMiniSkin;
		
		/**
		 * Indica si el portlet esta activo 
		 */
		public var selected:Boolean = false;
		
		/**
		 * Usado para indicar un portlet vacio 
		 */
		public var isEmpty:Boolean = true;
		
		/**
		 * Usado para indicar que el portlet esta maximizado 
		 */
		public var isMaximized:Boolean = false;
		
		/**
		 * Usado para indicar si un portlet esta en pantalla completa
		 */
		public var isFullScreen:Boolean = false;
		
		/**
		 * Indica si el lado del portlet es izquierdo o derecho 
		 */
		public var isLeft:Boolean = false;
		
		/**
		 * Indica si el portlet es superior o inferior
		 */
		public var isTop:Boolean = false;
		
		/**
		 * Indica el id_config que se utiliza para actualizar el portlet en base de datos
		 */
		public var id_usuario:String = "";
		
		/**
		 * 
		 */
		public var date_last_posicion:Date;
		
		
		public function PortletVO()
		{
		}
		
		
		/**
		 * El nombre usado para generar portlets dinamicos (nombre de la clase)
		 */
		public function get componente_class():String
		{
			return _componente_class;
		}

		/**
		 * @private
		 */
		public function set componente_class(value:String):void
		{
			_componente_class = value;
			
			if(value != null && value != "" && value.length != 0){
				isEmpty = false;
			}
		}

		public function get posicion():int
		{
			return _posicion;
		}

		public function set posicion(value:int):void
		{
			_posicion = value;
			
			//Determina si el portlet esta en el lado izquierdo o derecho
			if(value == NokConstants.PORTLET_POSITION_UPPER_LEFT){
				isLeft = true;
				isTop = true;
				selected = true;
			}else if(value == NokConstants.PORTLET_POSITION_LOWER_LEFT){
				isLeft = true;
				isTop = false;
				selected = true;
			}else if(value == NokConstants.PORTLET_POSITION_UPPER_RIGHT){
				isLeft = false;
				isTop = true;
				selected = true;
			}else if(value == NokConstants.PORTLET_POSITION_LOWER_RIGHT){
				isLeft = false;
				isTop = false;
				selected = true;
			}else if(value == NokConstants.PORTLET_POSITION_NOT_SET){
				selected = false;
			}
		}

		public function get main_posicion():String
		{
			return _main_posicion;
		}

		public function set main_posicion(value:String):void
		{
			_main_posicion = value;
			
			if(value == NokConstants.PORTLET_SIZE_MAXIMIZED){
				isMaximized = true;
				isFullScreen = false;
			}else if(value == NokConstants.PORTLET_SIZE_FULL_SCREEN){
				isMaximized = false;
				isFullScreen = true;
			}
		}


	}
}