package com.actioninteractive.nok.view.header
{
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.view.body.component.SectionButton;
	import com.actioninteractive.nok.vo.SectionVO;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.HGroup;
	
	public class SectionContainerBase extends HGroup
	{
		private var _sectionArray:ArrayCollection;
		
		public function SectionContainerBase()
		{
			super();
		}
		
		[Bindable]
		public function get sectionArray():ArrayCollection
		{
			return _sectionArray;
		}

		public function set sectionArray(value:ArrayCollection):void
		{
			_sectionArray = value;
			
			this.removeAllElements();
			
			for each(var sectionData:SectionVO in _sectionArray){
				var section:SectionButton = new SectionButton();
				section.dataSource = sectionData;
				
				this.addElement(section);
			}
		}

	}
}