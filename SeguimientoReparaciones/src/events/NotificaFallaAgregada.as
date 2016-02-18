/**
 * Created by CarlosZaragoza on 1/21/2016.
 */
package events {
import dtos.EmpleadoDTO;
import dtos.FallaEquipoDTO;

import flash.events.Event;

public class NotificaFallaAgregada extends Event {
    public var fallaEquipo:FallaEquipoDTO;
    public var empleado:EmpleadoDTO;
    public function NotificaFallaAgregada(type:String, fallaEquipo:FallaEquipoDTO) {
        super(type);
        this.fallaEquipo = fallaEquipo;
    }
}
}
