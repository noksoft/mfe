package com.actioninteractive.nok.view.body.component
{
	import spark.components.TextInput;
	
	public class PromptTextInputBase extends TextInput
	{
		public var promptText:String = "";
		
		public function PromptTextInputBase()
		{
			super();
		}
		
		/**
		 * Usado para manejar el text que sale cuando el usuario no ha ingresado nada 
		 * @param input
		 * @param promptText
		 * 
		 */
		protected function textInputClicked():void{
			if(this.text == promptText){
				this.text = "";
			}
			this.setStyle("color", 0xCCCCCC);
		}
		
		/**
		 * Usado para manejar el text que sale cuando el usuario no ha ingresado nada 
		 * @param input
		 * @param promptText
		 * 
		 */
		protected function textInputLoseFocus():void{
			if(this.text.length == 0){
				this.text = promptText;
				this.setStyle("color", 0x666666);
			}
		}
	}
}