package com.actioninteractive.nok.view.header
{
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.view.AssetManager;
	import com.actioninteractive.nok.view.body.component.PortletDraggableItem;
	import com.actioninteractive.nok.view.body.portlet.Portlet;
	import com.actioninteractive.nok.vo.PortletVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import spark.components.Group;
	
	public class PortletMenuBase extends Group
	{
		private var view:PortletMenu = PortletMenu(this); 
		private var _portletList:ArrayCollection;
		
		[Bindable]
		protected var currentPortletContainerHScrollPosition:int = 0;
		
		[Bindable]
		protected var newPortletContainerHScrollPosition:int = 0;
		
		[Bindable]
		protected var showSlideButtons:Boolean = false;
		[Bindable]
		protected var showSlideButtonsEnabled:Boolean = false;
		
		public function PortletMenuBase()
		{
			super();
		}
		
		/**
		 * Muestro u Oculta el menu de los portlets 
		 * 
		 */
		protected function showHidePortletMenu():void{
			if(view.portletButton.selected == true){
				if(view.hideEffect.isPlaying){
					view.hideEffect.stop();
					view.showEffect.play();
				}else{
					view.showEffect.play();
				}
			}else{
				if(view.showEffect.isPlaying){
					view.showEffect.stop();
					view.hideEffect.play();
				}else{
					view.hideEffect.play();
				}
			}
		}
	
		/**
		 * Activa el scroll horizontal cuando se muestra el menu
		 * menu de portlets completo
		 * 
		 */
		protected function showPortletEffectEnd():void{
			showSlideButtons = true;
		}
		
		/**
		 * Oculta el scroll horizontal cuando se oculta el menu
		 * de portlets 
		 * 
		 */
		protected function hidePortletEffectEnd():void{
			showSlideButtons = false;
		}
		
		/**
		 * A 
		 * @param rightClicked Indica si se dio click al efecto para mover
		 * los portlets a la derecha o a la izquierda
		 * 
		 */
		protected function updateSlideEffectValues(rightClicked:Boolean):void{
			if(!view.slidePortlets.isPlaying){
				var scrollPosition:int = 0;
				var currentScrollPosition:int = view.portletContainer.horizontalScrollPosition;
				var portletContainerWidth:int = view.portletContainer.width;
				
				if(rightClicked){
					scrollPosition = currentScrollPosition + portletContainerWidth;
					
					if(scrollPosition > (view.portletContainer.contentWidth - view.portletContainer.width)){
						scrollPosition = view.portletContainer.contentWidth - view.portletContainer.width;
					}
				}else{
					scrollPosition = currentScrollPosition - portletContainerWidth;
					
					if(scrollPosition < 0){
						scrollPosition = 0;
					}
				}
				
				currentPortletContainerHScrollPosition = currentScrollPosition;
				newPortletContainerHScrollPosition = scrollPosition;
				
				view.slidePortlets.play();
			}
		}
		
		/**
		 * Maneja los eventos necesarios cuando se arrastra un portlet
		 * sobre otro portlet 
		 * @param e Evento del drag and drop
		 * 
		 */
		protected function dragEnterHanlder(e:DragEvent):void{
			if(e.dragInitiator is Portlet){
				var dragInit:Portlet = e.dragInitiator as Portlet;
				
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
				
				ev = new CommonEvent(CommonEvent.PORTLET_REMOVE_EVENT);
				ev.portletOver = (e.dragInitiator as Portlet);


				
				this.dispatchEvent(ev);
			}
		}
		
		/**
		 * Contiene la lista de los portlets que deben estar visibles al momento 
		 * 
		 */
		public function get portletList():ArrayCollection
		{
			return _portletList;
		}

		public function set portletList(value:ArrayCollection):void
		{
			_portletList = value;
			
			view.portletContainer.removeAllElements();
			
			for each(var portlet:PortletVO in _portletList){
				var portletIcon:PortletDraggableItem = new PortletDraggableItem();
				portletIcon.dataSource = portlet;
				
				view.portletContainer.addElement(portletIcon);
			}
			
			if(_portletList.length > 5){
				showSlideButtonsEnabled = true;
			}else{
				showSlideButtonsEnabled = false;
			}
		}

	}
}