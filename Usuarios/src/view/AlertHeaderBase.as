package view
{
	import mx.containers.HBox;
	
	public class AlertHeaderBase extends HBox
	{
		[Bindable]
		public var headerTitle:String;
		
		public function AlertHeaderBase()
		{
			super();
		}
	}
}