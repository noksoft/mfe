/**
 * Created by jess on 27/10/15.
 */
package com.maqzar.dtos {
[Bindable]
[RemoteClass(alias="mx.com.nok.categoria.model.dto.SubcategoriaDTO")]
public class SubCategoriaDTO {
    private var _idSubcategoria:String;
    private var _subcategoria:String;
    private var _idCategoria:String;
    private var _categoria:String;
    private var _estatus:Boolean;
    public function SubCategoriaDTO() {

        idSubcategoria = "";
        idCategoria = "";
        subcategoria = "";
        categoria = "";
        estatus = true;

    }

    public function get idSubcategoria():String {
        return _idSubcategoria;
    }

    public function set idSubcategoria(value:String):void {
        _idSubcategoria = value;
    }

    public function get subcategoria():String {
        return _subcategoria;
    }

    public function set subcategoria(value:String):void {
        _subcategoria = value;
    }

    public function get idCategoria():String {
        return _idCategoria;
    }

    public function set idCategoria(value:String):void {
        _idCategoria = value;
    }

    public function get categoria():String {
        return _categoria;
    }

    public function set categoria(value:String):void {
        _categoria = value;
    }

    public function get estatus():Boolean {
        return _estatus;
    }

    public function set estatus(value:Boolean):void {
        _estatus = value;
    }
}
}
