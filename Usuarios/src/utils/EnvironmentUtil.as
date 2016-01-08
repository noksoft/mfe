package utils
{
	import flash.external.ExternalInterface;
	
	import mx.core.Application;

	public class EnvironmentUtil
	{
		/**
		* AMF_FILE contains amf. location in dev, stage and production, locations should be the same for each environment.
		*/
		public static var AMF_FILE:String = "amf";
		
		/**
		 * Contructor
		 * @private
		 */
		public function EnvironmentUtil()
		{
		}
		
		/**
		 * This function will retrieve full amf.php locations,
		 * this fail contains all the services to be used inside MTM
		 * @private
		 */
		public static function getEnvironment():String
		{
			var url:String = "";
			var rawUrl:String = "";
			
			if(Application.application.url == null){
				//Using ExternalInterface just if Application is not ready 
				if(ExternalInterface.available){
					rawUrl = ExternalInterface.call("window.location.toString");
				}else{
					//Returning just amf.php as relative path 
					return AMF_FILE;
				}				
			}else{
				rawUrl = Application.application.url;
			}
			
			if( rawUrl.indexOf('file:///') > -1){
				//This flow will help us to test the application in any environment as local, only for front-end testing.
				
				url = "http://localhost:8080/nok/messagebroker/" + AMF_FILE; //Official Localhost
				//url = "http://dev.mtm.corporate.ge.com/" + AMF_FILE;
				//url = "http://stage.mtm.corporate.ge.com/" + AMF_FILE;
			}else{
				//Flow for running the application in any environment local, sandbox, dev, stage and production. 
				var filePosition:int = rawUrl.indexOf('/index.html');
				
				if(filePosition == -1){
					filePosition = rawUrl.indexOf('/Empledos.swf');
				}
				
				if(filePosition == -1){
					filePosition = rawUrl.indexOf('/Empledos.html');
				}
				
				if(filePosition == -1){
					filePosition = rawUrl.indexOf('/?');
				}
				
				if(filePosition > -1){
					url = rawUrl.substring(0, filePosition+1) + AMF_FILE;
				}else{
					url = rawUrl + AMF_FILE;
				}
			}
			
			return url;
		}
	}
}