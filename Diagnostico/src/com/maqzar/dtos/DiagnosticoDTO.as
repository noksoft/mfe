/**
 * Created by jess on 08/08/15.
 */
package com.maqzar.dtos {
import spark.skins.spark.StackedFormHeadingSkin;

[Bindable]
[RemoteClass(alias="mx.com.nok.equipo.model.dto.DiagnosticoDTO")]

public class DiagnosticoDTO {
        private var _id_t_diagnostico:String;
        private var _id_equipo:String;
        private var _descripcion:String;
        private var _fecha_diagnostico:String;
        private var _fecha_alta:String;
        private var _id_empleado:String;
        private var _numeroeconomico:String;
        private var _rfc_empleado:String;
        private var _nombre_empleado:String;
        private var _paterno:String;
        private var _materno:String;
        private var _tipo_empleado:String;
        private var _telefono:String;
        private var _celular:String;

    public function DiagnosticoDTO() {
        id_t_diagnostico="";
        id_equipo="";
        descripcion="";
        fecha_diagnostico="";
        fecha_alta="";
        id_empleado="";
        numeroeconomico="";
        rfc_empleado="";
        nombre_empleado="";
        paterno="";
        materno="";
        tipo_empleado="";
        telefono="";
        telefono="";
        celular="";
    }

    public function get id_t_diagnostico():String {
        return _id_t_diagnostico;
    }

    public function set id_t_diagnostico(value:String):void {
        _id_t_diagnostico = value;
    }

    public function get id_equipo():String {
        return _id_equipo;
    }

    public function set id_equipo(value:String):void {
        _id_equipo = value;
    }

    public function get descripcion():String {
        return _descripcion;
    }

    public function set descripcion(value:String):void {
        _descripcion = value;
    }

    public function get fecha_diagnostico():String {
        return _fecha_diagnostico;
    }

    public function set fecha_diagnostico(value:String):void {
        _fecha_diagnostico = value;
    }

    public function get fecha_alta():String {
        return _fecha_alta;
    }

    public function set fecha_alta(value:String):void {
        _fecha_alta = value;
    }

    public function get id_empleado():String {
        return _id_empleado;
    }

    public function set id_empleado(value:String):void {
        _id_empleado = value;
    }

    public function get numeroeconomico():String {
        return _numeroeconomico;
    }

    public function set numeroeconomico(value:String):void {
        _numeroeconomico = value;
    }

    public function get rfc_empleado():String {
        return _rfc_empleado;
    }

    public function set rfc_empleado(value:String):void {
        _rfc_empleado = value;
    }

    public function get nombre_empleado():String {
        return _nombre_empleado;
    }

    public function set nombre_empleado(value:String):void {
        _nombre_empleado = value;
    }

    public function get paterno():String {
        return _paterno;
    }

    public function set paterno(value:String):void {
        _paterno = value;
    }

    public function get materno():String {
        return _materno;
    }

    public function set materno(value:String):void {
        _materno = value;
    }

    public function get tipo_empleado():String {
        return _tipo_empleado;
    }

    public function set tipo_empleado(value:String):void {
        _tipo_empleado = value;
    }

    public function get telefono():String {
        return _telefono;
    }

    public function set telefono(value:String):void {
        _telefono = value;
    }

    public function get celular():String {
        return _celular;
    }

    public function set celular(value:String):void {
        _celular = value;
    }
}
}
