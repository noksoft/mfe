/**
 * Created by jess on 22/08/15.
 */
package com.maqzar.events {
import flash.events.Event;


public class DiagnosticoEvent extends Event{
    public static const DIAGNOSTICO_GET_FALLAS:String = "diagnosticoGetFallas";
    public function DiagnosticoEvent(type:String) {
        super(type, true, true);

    }
}
}
