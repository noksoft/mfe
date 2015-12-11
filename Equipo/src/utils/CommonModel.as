package utils
{
	import mx.collections.ArrayCollection;

	public class CommonModel
	{
		/**
		 * Contiene la lisa de jornadas laborales
		 */
		public static var jornadasList:ArrayCollection = new ArrayCollection([
			{label:"Semana", data:1}, 
			{label:"Quincena", data:2}, 
			{label:"Veintena", data:3}]);
		
		/**
		 * Arreglo meses español
		 */
		[Bindable]public static var monthArray:Array = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"];
		
		/**
		 * Arreglo días en español
		 */
		[Bindable]public static var dayArray:Array = ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"];
		
		public static function getYesterday():Date {
			var today:Date = new Date();
			var millisecondsPerDay:Number = 1000 * 60 * 60 * 24;
			
			var yesterday:Date = new Date();
			yesterday.setTime(today.getTime() - millisecondsPerDay);
			return yesterday;
		}

	}
}