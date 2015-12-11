package constants
{
	public class NOKConstants
	{
		public function NOKConstants()
		{
		}
		public static var SERVICE_URL:String = "http://localhost:8080/nok/messagebroker/amf";
		public static var SERVICE_DESTINATION_REQUISICIONES:String = "requisicionBusiness";
		public static var SERVICE_DESTINATION_ARTICULOS:String = "articuloBusiness";
		public static var SERVICE_DESTINATION_CATEGORIAS:String = "categoriaBusiness";
		public static var SERVICE_DESTINATION_EMPLEADOS:String = "empleadoBusiness";
		public static var SERVICE_DESTINATION_FALLA:String = "fallaBusiness";
	}
}