/**
 * Created by Usuario on 09/05/2015.
 */
package com.maqzar.models {
import com.maqzar.dtos.ObraVO;

import mx.collections.ArrayCollection;

[Bindable]
public class AsignacionModel {
    public function AsignacionModel() {
    }
    public var acPersonalDisponible:ArrayCollection;
    public var acPersonalAsignado:ArrayCollection;
    public var acObras:ArrayCollection;
    public var obraSelected:ObraVO;
    public var acEquiposDisponibles:ArrayCollection;
    public var acEquiposAsignados:ArrayCollection;
    public var acEmpleadosAsignados:ArrayCollection;

}
}
