package com.actioninteractive.nok.view.body.component
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.vo.PortletVO;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.graphics.ImageSnapshot;
	import mx.managers.DragManager;
	
	import spark.components.Group;
	
	public class PortletDraggableItemBase extends Group
	{
		private var _dataSource:PortletVO;
		private var mouseIsDown:Boolean = false;
		
		public function PortletDraggableItemBase()
		{
			super();
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
		
		[Bindable]
		public function get dataSource():PortletVO
		{
			return _dataSource;
		}

		public function set dataSource(value:PortletVO):void
		{
			_dataSource = value;
		}

	}
}