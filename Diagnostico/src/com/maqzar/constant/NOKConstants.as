/**
 * Created by Carlos Zaragoza on 09/05/2015.
 */
package com.maqzar.constant {
[Bindable]
public class NOKConstants {
    public static const SERVICE_DESTINATION_DIAGNOSTICO:String = "equipoBusiness" ;
    public function NOKConstants() {
    }
    public static var SERVICE_URL:String = "http://localhost:8080/nok/messagebroker/amf";
    //public static var SERVICE_URL:String = "https://mmw-carast.c9.io/nok/messagebroker/amf";
    public static var SERVICE_DESTINATION_FALLAS:String = "fallaBusiness";
	public static var SERVICE_DESTINATION_EQUIPOS:String = "equipoBusiness";
}
}
