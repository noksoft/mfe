package com.actioninteractive.nok.view.body.component
{
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.model.CommonModel;
	import com.actioninteractive.nok.view.AssetManager;
	import com.actioninteractive.nok.vo.SectionVO;
	
	import spark.components.Group;
	
	public class SectionButtonBase extends Group
	{
		private var selected:Boolean = false;
		private var view:SectionButton = SectionButton(this);
		
		[Bindable]
		protected var icon:Class = AssetManager.sectionButtonUpSkin;
		
		[Bindable]
		protected var font:String = "Helvetica";
		
		[Bindable]
		protected var tracking:Number = 0;
		
		public var _dataSource:SectionVO;
		
		[Inject]
		public var commonModel:CommonModel;
		
		public function SectionButtonBase()
		{
			super();
		}
		
		/**
		 * Dispara un evento para indicar que se ha dado clic en un boton
		 * para hacer un cambio de seccion 
		 * 
		 */
		protected function sectionButtonCliked():void{
			if(!commonModel.sectionSlideEffectPlaying && !this.selected){
				var ev:CommonEvent = new CommonEvent(CommonEvent.SECTION_CLICKED_EVENT);
				ev.section = this.dataSource;
				
				this.dispatchEvent(ev);
			}
		}
		
		[EventHandler(event="CommonEvent.SECTION_CLICKED_EVENT")]
		public function unselectButton(e:CommonEvent):void{
			if(dataSource.id != e.section.id){
				this.selected = false;
				this.icon = AssetManager.sectionButtonUpSkin;
				font = "Helvetica";
				tracking = 0;
				view.sectionName.filters = [];
			}else{
				this.selected = true;
				this.icon = AssetManager.sectionButtonDownSkin;
				font = "HelveticaBold";
				tracking = 0.6;
				view.sectionName.filters = [view.glowText];
			}
		}
		
		[Bindable]
		public function get dataSource():SectionVO
		{
			return _dataSource;
		}
		
		public function set dataSource(value:SectionVO):void
		{
			_dataSource = value;
			
			//Si la seccion esta seleccionada muestra presionado el boton
			if(value.selected){
				this.selected = true;
				this.icon = AssetManager.sectionButtonDownSkin;
				font = "HelveticaBold";
				tracking = 0.6;
				view.sectionName.filters = [view.glowText];
			}
		}
		
	}
}