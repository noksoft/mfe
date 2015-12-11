package controller
{
	import model.ModelEquipo;

	public class EquipoController
	{
		[Inject]
		public var modelEquipo:ModelEquipo;
		
		public function EquipoController()
		{
		}
		
		/*
		[EventHandler(event="MyEvent.BUTTON_VISIBILITY", properties="visibility")]
		public function changeVisibility(value:Boolean):void{
		testModel.buttonVisible = value;
		Alert.show("El boton desaparecerá!!!");
		}
		
		[PostConstruct]
		public function post_construct():void
		{
		testModel.buttonVisible = true;
		}
		*/
	}
}