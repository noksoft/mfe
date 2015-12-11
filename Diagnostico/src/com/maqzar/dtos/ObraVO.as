/**
 * Created by Usuario on 09/05/2015.
 */
package com.maqzar.dtos {
	import mx.formatters.DateFormatter;

[Bindable]
[RemoteClass(alias="mx.com.nok.obra.model.dto.ObraDTO")]
public class ObraVO {
    public var idObra:String = '';
    public var claveObra:String = '';
    public var nombre:String = '';
    public var lat:String = '';
    public var lng:String = '';
    public var idEmpleado:String = '';
	public var nombreEmpleado:String = '';
	
	
	
    public var presupuestoEstimado:Number = 0;
    public var contrato:String = '';
    public var status:String = 'true';
    private var _fechaInicio:String = '';
    private var _fechaTermina:String = '';
    public var idEntidad:String = '';
    public var idMunicipio:String = '';
    public var idLocalidad:String = '';
    public var jornadaLaboral:int = 0;
    public var descripcion:String = '';
	public var tipoJornada:String = '';
	private var formatoFecha:DateFormatter = new DateFormatter();
	
    public function ObraVO() {
		formatoFecha.formatString = "YYYY-MM-DD";
		
		
    }

	public function get fechaTermina():String
	{
		return formatoFecha.format(_fechaTermina);
	}

	public function set fechaTermina(value:String):void
	{
		_fechaTermina = value;
	}

	public function get fechaInicio():String
	{
		return formatoFecha.format(_fechaInicio);
	}

	public function set fechaInicio(value:String):void
	{
		_fechaInicio = value;
	}

}
}
