package dtos {
[Bindable]
[RemoteClass(alias="mx.com.nok.fallaEquipo.model.dto.FallaEquipoDTO")]
public class FallaEquipoDTO {
    public var id_tfallas:String = "";
    public var tipo_falla:int;
    public var id_empleado:String = "";
    public var id_subfalla:String = "";
    public var descripcion:String = "";
    public var prioridad:int;
    public var observaciones:String = "";
    public var fecha_registro:String = "";
    public var id_equipo:String = "";
    public var id_obra:String = "";
    public var estatus:String = "TRUE";

    public var nombreequipo:String = "";
    public var descripcionequipo:String = "";
    public var tipoadquisicion:String = "";
    public var numeroserie:String = "";
    public var id_tipocategoria:String = "";
    public var tipocategoria:String = "";
    public var id_categoria:String = "";
    public var categoria:String = "";
    public var numeroeconomico:String = "";
    public var clave_obra:String = "";
    public var nombreobra:String = "";
    public var descripcionobra:String = "";
    public var falla:String = "";
    public var subfalla:String = "";
    public var fechaInicio:String = "";
    public var fechaFin:String = "";
    public var estatusProceso:String = "";
    public var idEmpleadoReparador:String;
    public var rfcEmpleadoReparador:String;
    public var nombreReparador:String;
    public var paternoReparador:String;
    public var maternoReparador:String;
    public var rfcEmpleado:String;
    public var nombre:String;
    public var paterno:String;
    public var materno:String;
    private var _reparador:String = "";
    public var reparador_id:int;
    private var _falla_descripcion:String = "";

    public function FallaEquipoDTO() {
    }

    public function get falla_descripcion():String {
        return numeroeconomico + "->" + falla;
    }

    public function get reparador():String {
        return nombreReparador + " " + paternoReparador + " " + maternoReparador;
    }


}
}