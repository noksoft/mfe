package com.actioninteractive.nok.view.header
{
	import com.actioninteractive.nok.model.CommonModel;
	
	import spark.components.SkinnableContainer;
	
	public class HeaderBase extends SkinnableContainer
	{
		[Inject]
		[Bindable]
		public var commonModel:CommonModel;
		
		public function HeaderBase()
		{
			super();
		}
	}
}