package com.actioninteractive.nok.view.body.portlet
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.skins.EmptyPortletSkin;
	import com.actioninteractive.nok.skins.PortletSkin;
	import com.actioninteractive.nok.view.AssetManager;
	import com.actioninteractive.nok.view.body.component.PortletDraggableItem;
	import com.actioninteractive.nok.vo.PortletVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	import mx.graphics.ImageSnapshot;
	import mx.managers.DragManager;
	
	import spark.components.SkinnableContainer;
	
	public class PortletBase extends SkinnableContainer
	{
		private var view:Portlet = Portlet(this);
		private var _dataSource:PortletVO = new PortletVO();
		private var _children:Array;
		private var sizeChangePending:Boolean = false;
		private var mouseIsDown:Boolean = false;
		private var isDragging:Boolean = false;
		
		/**
		 * Contiene el skin del contenedor del portlet cuando esta vacio 
		 */
		private var emptySkin:Class = com.actioninteractive.nok.skins.EmptyPortletSkin;
		
		/**
		 * Contiene el skin del contenedor de portlets cuando tiene contenido 
		 */
		private var fullSkin:Class = com.actioninteractive.nok.skins.PortletSkin;
		
		/**
		 * Se usa para deshabilitar uso del mouse mientras los efectos se repoducen 
		 */
		[Bindable]
		protected var effectPlaying:Boolean = false;
		
		/**
		 * Se usa para asignar el skin al componente 
		 */
		[Bindable]
		protected var currentSkin:Class = emptySkin;
		
		/**
		 * Icono usado para el modificar de tamaño izquierdo 
		 */
		[Bindable]
		protected var leftSizeIcon:Class = AssetManager.portletButtonMaximizeLeftSkin;
		
		/**
		 * Icono usado para el modificar de tamaño derecho
		 */
		[Bindable]
		protected var rightSizeIcon:Class = AssetManager.portletButtonFullScreenSkin;
		
		public function PortletBase()
		{
			super();
		}
		
		/**
		 * Se encarga de cuando el usuario hace click para modificar el
		 * tamaño del portlet 
		 */
		protected function leftSizeIconClicked():void{
			
			switch(dataSource.main_posicion){
				case NokConstants.PORTLET_SIZE_MINI:
					//Hay un portlet maximizado y se debe maximizar este portlet
					dataSource.main_posicion = NokConstants.PORTLET_SIZE_MAXIMIZED;
				break;
				case NokConstants.PORTLET_SIZE_NORMAL:
					//Todos los portlets son normales y se debe maximizar este
					dataSource.main_posicion = NokConstants.PORTLET_SIZE_MAXIMIZED;
				break;
				case NokConstants.PORTLET_SIZE_MAXIMIZED:
					//Este portlet esta maximizado y debe ser restaurado
					dataSource.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
				break;
				case NokConstants.PORTLET_SIZE_FULL_SCREEN:
					//Hay un portlet en pantalla completa y se debe maximizar este portlet
					dataSource.main_posicion = NokConstants.PORTLET_SIZE_MAXIMIZED;
				break;
			}
			
			setSizeChangeIcons();
			
			sizeChangePending = true;
			
			dispatchEvent(new CommonEvent(CommonEvent.PORTLET_FADE_OUT_EVENT));
		}
		
		/**
		 * Se encarga de cuando el usuario hace click para modificar el
		 * tamaño del portlet 
		 */
		protected function rightSizeIconClicked():void{
			switch(dataSource.main_posicion){
				case NokConstants.PORTLET_SIZE_MINI:
					//Hay un portlet maximizado y se debe hacer pantalla completa este
					dataSource.main_posicion = NokConstants.PORTLET_SIZE_FULL_SCREEN;
				break;
				case NokConstants.PORTLET_SIZE_NORMAL:
					//Todos los portlets son normales y se debe poner este en pantalla completa
					dataSource.main_posicion = NokConstants.PORTLET_SIZE_FULL_SCREEN;
				break;
				case NokConstants.PORTLET_SIZE_MAXIMIZED:
					//Hay un portlet maximizado y se debe poner este en pantalla completa
					dataSource.main_posicion = NokConstants.PORTLET_SIZE_FULL_SCREEN;
				break;
				case NokConstants.PORTLET_SIZE_FULL_SCREEN:
					//Este portlet esta en pantalla completa y debe ser restaurado a normal
					dataSource.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
				break;
			}
			
			setSizeChangeIcons();
			
			sizeChangePending = true;
			
			dispatchEvent(new CommonEvent(CommonEvent.PORTLET_FADE_OUT_EVENT));
		}
		
		protected function fadeOutEnd():void{
			if(sizeChangePending){
				dispatchSizeChangeEvent();
				
				sizeChangePending = false;
			}
			effectPlaying = true;
		}
		
		protected function fadeInEnd():void{
			effectPlaying = false;
		}
		
		private function dispatchSizeChangeEvent():void{
			var ev:CommonEvent = new CommonEvent(CommonEvent.PORTLET_SIZE_CHANGED_EVENT);
			ev.portlet = dataSource;
			this.dispatchEvent(ev);
		}
		
		[EventHandler(event="CommonEvent.PORTLET_FADE_OUT_EVENT")]
		public function portletFadeOut():void{
			view.fadeOut.play();
			effectPlaying = true;
		}
		
		[EventHandler(event="CommonEvent.PORTLET_FADE_IN_EVENT")]
		public function portletFadeIn():void{
			view.fadeIn.play();
			effectPlaying = true;
		}
	
		
		/**
		 * Agrega todos los elementos visuales en el arreglo @children
		 * 
		 */
		protected function addChildrenToLayout():void{
			for each(var element:UIComponent in children){
				view.portletChildren.addElement(element);
			}
		}
		
		/**
		 * Revisa de que lado esta el portlet y asigna los iconos para el
		 * cambio de tamaño de los portlets. 
		 * 
		 */
		public function setSizeChangeIcons():void{
			var positionLeft:Boolean = false;
			
			if(dataSource.posicion == NokConstants.PORTLET_POSITION_UPPER_LEFT || dataSource.posicion == NokConstants.PORTLET_POSITION_LOWER_LEFT){
				positionLeft = true;
			}
			
			if(dataSource.main_posicion == NokConstants.PORTLET_SIZE_MINI || dataSource.main_posicion == NokConstants.PORTLET_SIZE_NORMAL){
				if(positionLeft == true){
					leftSizeIcon = AssetManager.portletButtonMaximizeLeftSkin;
				}else{
					leftSizeIcon = AssetManager.portletButtonMaximizeRightSkin;
				}
				
				rightSizeIcon = AssetManager.portletButtonFullScreenSkin;
			}else if(dataSource.main_posicion == NokConstants.PORTLET_SIZE_MAXIMIZED){
				leftSizeIcon = AssetManager.portletButtonRestoreSkin;
				rightSizeIcon = AssetManager.portletButtonFullScreenSkin;
			}else if(dataSource.main_posicion == NokConstants.PORTLET_SIZE_FULL_SCREEN){
				if(positionLeft == true){
					leftSizeIcon = AssetManager.portletButtonMaximizeLeftSkin;
				}else{
					leftSizeIcon = AssetManager.portletButtonMaximizeRightSkin;
				}
				
				rightSizeIcon = AssetManager.portletButtonRestoreSkin;
			}
		}
		
		/**
		 * Se encarga de detectar cuando el mouse se ha presionado
		 * para el manejo de los eventos de drag 
		 * @param e Evento del mouse
		 * 
		 */
		protected function mouseDownUpHandler(e:MouseEvent):void{
			mouseIsDown = e.buttonDown;
		}
		
		protected function mouseUpHandler():void{
			mouseIsDown = false;
		}
		
		/**
		 * Se encarga de iniciar el drag and drop si el mouse
		 * esta presionado 
		 * @param e Evento del mouse
		 * 
		 */
		protected function mouseMoveHandler(e:MouseEvent):void{
			if(mouseIsDown){
				if(dataSource.main_posicion != NokConstants.PORTLET_SIZE_FULL_SCREEN){
					var ds:DragSource = new DragSource();
					ds.addData(this.dataSource, "PortletVO");
					
					var snapshot:Image = new Image();
					snapshot.source = new Bitmap(ImageSnapshot.captureBitmapData(this));
					
					DragManager.doDrag(this, ds, e, snapshot);
					
					DragManager.showFeedback(DragManager.NONE);
				}
			}
		}
		
		/**
		 * Se encarga de cancelar el boleano del boton abajo si el usuario
		 * no esta presionandolo
		 * @param e
		 * 
		 */
		protected function mouseOutHandler(e:MouseEvent):void{
			mouseIsDown = false;
		}
		
		/**
		 * Maneja los eventos necesarios cuando se arrastra un portlet
		 * sobre otro portlet 
		 * @param e Evento del drag and drop
		 * 
		 */
		protected function dragEnterHanlder(e:DragEvent):void{
			if(e.dragInitiator is Portlet && e.dragInitiator != this){
				var dragInit:Portlet = e.dragInitiator as Portlet;
				
				DragManager.acceptDragDrop(this);
				DragManager.showFeedback(DragManager.COPY);
			}else if(e.dragInitiator is PortletDraggableItem){
				DragManager.acceptDragDrop(this);
				DragManager.showFeedback(DragManager.COPY);
			}
		}
		
		/**
		 * Maneja los eventos cuando se acepto el drag de un portlet 
		 * @param e
		 * 
		 */
		protected function dragAcceptedHandler(e:DragEvent):void{
			var ev:CommonEvent;
			
			if(e.dragInitiator is Portlet){
				(e.dragInitiator as Portlet).restoreDragSettings();
				
				ev = new CommonEvent(CommonEvent.PORTLET_CHANGE_POSITION_EVENT);
				ev.portletOver = view;
				ev.portletMoved = (e.dragInitiator as Portlet);
				
				this.dispatchEvent(ev);
			}else if(e.dragInitiator is PortletDraggableItem){
				ev = new CommonEvent(CommonEvent.PORTLET_REPLACE_EVENT);
				ev.portletOver = view;
				ev.portlet = (e.dragInitiator as PortletDraggableItem).dataSource;
				
				this.dispatchEvent(ev);
			}
		}
		
		public function restoreDragSettings():void{
			mouseIsDown = false;
		}
		
		[Bindable]
		/**
		 * Contiene los datos del portlet 
		 * @return 
		 * 
		 */
		public function get dataSource():PortletVO
		{
			return _dataSource;
		}

		public function set dataSource(value:PortletVO):void
		{
			_dataSource = value;
			
			if(value.isEmpty){
				currentSkin = emptySkin;
			}else{
				currentSkin = fullSkin;
			}
			
			setSizeChangeIcons();
		}
		
		[Bindable]
		/**
		 * Contiene los elementos visuales que deben agregarse a la vista del portlet 
		 * @return Arreglo con los elementos visuales
		 * 
		 */
		public function get children():Array
		{
			return _children;
		}

		public function set children(value:Array):void
		{
			_children = value;
		}
	}
}