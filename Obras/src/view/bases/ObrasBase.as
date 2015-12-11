package view.bases {
import com.esri.ags.events.MapMouseEvent;
import com.esri.ags.geometry.MapPoint;
import com.esri.ags.utils.WebMercatorUtil;

import flash.events.Event;
import flash.events.MouseEvent;

import model.LocalidadVO;

import model.MunicipioVO;
import model.ObraVO;

import model.ObraVO;

import mx.collections.ArrayCollection;
import mx.collections.IViewCursor;
import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.events.IndexChangedEvent;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.validators.Validator;

import obras.ObrasView;

import spark.collections.Sort;

import spark.collections.SortField;

import spark.components.SkinnableContainer;
import spark.components.gridClasses.GridColumn;

import model.EmpleadoVO;
import model.EntidadVO;

import spark.events.IndexChangeEvent;

import view.ObraMain;

public class ObrasBase extends SkinnableContainer {
    private var form:ObraMain = ObraMain(this);
    [Bindable]
    protected var listObras:ArrayCollection;
    private var _updateObra:Boolean;
    private var _acListEntidad:ArrayCollection;
    private var _acListMunicipio:ArrayCollection;
    private var _acListLocalidad:ArrayCollection;
    private var _acListEmpleados:ArrayCollection;
    private var _aclistObras:ArrayCollection;
    private var _latitud:String;
    private var _longitud:String;

    public function ObrasBase() {
        super();
    }

    /*
     * GETTERS & SETTERS
     *
     * */
    public function get longitud():String {
        return _longitud;
    }

    public function set longitud(value:String):void {
        _longitud = value;
    }

    public function get latitud():String {
        return _latitud;
    }

    public function set latitud(value:String):void {
        _latitud = value;
    }

    [Bindable]
    public var jornadasList:ArrayCollection = new ArrayCollection([
        {label: "Semana", jornadaLaboral: 1},
        {label: "Quincena", jornadaLaboral: 2},
        {label: "Veintena", jornadaLaboral: 3}]);


    [Bindable]
    public function get acListEmpleados():ArrayCollection {
        return _acListEmpleados;
    }

    public function set acListEmpleados(value:ArrayCollection):void {
        _acListEmpleados = value;
    }

    [Bindable]
    public function get acListLocalidad():ArrayCollection {
        return _acListLocalidad;
    }

    public function set acListLocalidad(value:ArrayCollection):void {
        _acListLocalidad = value;
    }

    [Bindable]
    public function get acListMunicipio():ArrayCollection {
        return _acListMunicipio;
    }

    public function set acListMunicipio(value:ArrayCollection):void {
        _acListMunicipio = value;
    }

    [Bindable]
    public function get acListEntidad():ArrayCollection {
        return _acListEntidad;
    }

    public function set acListEntidad(value:ArrayCollection):void {
        _acListEntidad = value;
    }

    [Bindable]
    public function get updateObra():Boolean {
        return _updateObra;
    }

    public function set updateObra(value:Boolean):void {
        _updateObra = value;
    }

    [Bindable]
    public function get aclistObras():ArrayCollection {
        return _aclistObras;
    }

    public function set aclistObras(value:ArrayCollection):void {
        _aclistObras = value;
    }

    private var dataToDelete:Object;
    private var entidadSeleccionada:String;
    private var municipioSeleccionado:String;


    /*
     * OBJETOS REMOTOS, LLAMADAS Y RESULTS*/
    protected function remoteFaultObra(_event:FaultEvent):void {
        Alert.show(_event.fault.message, "Comunicación");
    }

    protected function infoObraResult(_event:ResultEvent):void {
        if (_event.result == null) {
            Alert.show("No hay registros de obras");
        } else {
            aclistObras = _event.result as ArrayCollection;

        }
    }

    protected function insertObraResult(_event:ResultEvent):void {
        form.remoteObra.infoObra(new ObraVO());
        limpiarFormulario();
    }


    protected function deleteObraResult(_event:ResultEvent):void {
        //Remueve el objeto borrado
        //aclistObras.removeItemAt(form.obrasDataGrid.selectedIndex);
        form.remoteObra.infoObra(new ObraVO());
    }

    protected function updateObraResult(_event:ResultEvent):void {
        form.remoteObra.infoObra(new ObraVO());
        limpiarFormulario();
    }

    protected function infoEmpleadoResult(_event:ResultEvent):void {
        if (_event.result == null) {
            Alert.show("No hay empleados");
        } else {
            acListEmpleados = _event.result as ArrayCollection;
            trace(acListEmpleados.length);
        }
    }

    protected function catEntidadResult(_event:ResultEvent):void {
        try {
            acListEntidad = _event.result as ArrayCollection
        }
        catch (error:Error) {
            Alert.show(error.message, "Error");
        }
    }

    private var municipioLocated:Boolean;

    protected function catMunicipioResult(_event:ResultEvent):void {
        // TODO Auto Generated method stub
        try {
            acListMunicipio = _event.result as ArrayCollection;

            if (entidadLocated) {
                doSort('idMunicipio', acListMunicipio);
                cursorMunicipio = acListMunicipio.createCursor();
                var found:Boolean = cursorMunicipio.findAny(obraVOtmp);

                if (found) {
                    form.ddlMunicipio.selectedItem = cursorMunicipio.current;
                    var changeEvent:IndexChangeEvent = new IndexChangeEvent(IndexChangedEvent.CHANGE);
                    form.ddlMunicipio.dispatchEvent(changeEvent);
                    municipioLocated = true;

                }
            }

        }
        catch (error:Error) {
            Alert.show(error.message, "Error");
        }
    }

    protected function catLocalidadResult(_event:ResultEvent):void {
        try {
            acListLocalidad = _event.result as ArrayCollection;
            if (municipioLocated) {
                doSort('idLocalidad', acListLocalidad);
                cursorLocalidad = acListLocalidad.createCursor();
                var found:Boolean = cursorLocalidad.findAny(obraVOtmp);
                if (found) {
                    form.ddlLocalidad.selectedItem = cursorLocalidad.current;

                }
            }


        }
        catch (error:Error) {
            Alert.show(error.message, "Error");
        }
    }

    /*
     * METODOS PARA CONTROL DE FORMULARIO*/
    private function doSort(campo:String, arreglo:*):void {
        var sf:SortField = new SortField(campo);
        var s:Sort = new Sort();
        s.fields = [sf];
        arreglo.sort = s;
        arreglo.refresh();
    }

    private var obraVOtmp:ObraVO;
    private var cursorEntidad:IViewCursor;
    private var cursorMunicipio:IViewCursor;
    private var cursorLocalidad:IViewCursor;
    private var cursorEmpleado:IViewCursor;
    private var cursorLaboral:IViewCursor;
    private var entidadLocated:Boolean;

    public function selectObra(_event:Event):void {
        updateObra = true;
        var obra:ObraVO = ObraVO(_event.currentTarget.selectedItem);
        obraVOtmp = obra;
        form.txtContrato.text = obra.contrato;
        form.txtNombreDeObra.text = obra.nombre;
        form.txtDescripcionObra.text = obra.descripcion;
        form.dateFieldFechaInicio.text = form.dateFormatter.format(obra.fechaInicio);
        form.dateFieldFechadeTermino.text = form.dateFormatter.format(obra.fechaTermina);
        form.txtLat.text = obra.lat;
        form.txtLong.text = obra.lng;

        //Recueprar los datos de combos//

        doSort('idEntidad', acListEntidad);

        /*ubicacion.lat = Number(latitud);
         ubicacion.lon = Number(longitud);
         var wgs:SpatialReference = new SpatialReference(4152);

         var x:Number = 6371 * Math.cos(Number(latitud)) * Math.cos(Number(longitud));
         var y:Number = 6371 * Math.cos(Number(latitud)) * Math.sin(Number(longitud));
         trace ("x " + x + " y " + y);
         var mapa:MapPoint = new MapPoint(Number(longitud),Number(latitud) ,wgs);
         //var mapa:MapPoint = new MapPoint(x,y);
         mapaObra.centerAt(mapa);*/

        cursorEntidad = acListEntidad.createCursor();
        var found:Boolean = cursorEntidad.findAny(obra);
        if (found) {
            form.ddlEntidad.selectedItem = cursorEntidad.current;
            var changeEvent:IndexChangeEvent = new IndexChangeEvent(IndexChangedEvent.CHANGE);
            form.ddlEntidad.dispatchEvent(changeEvent);
            entidadLocated = true;
        }
        doSort('idEmpleado', acListEmpleados);
        cursorEmpleado = acListEmpleados.createCursor();
        var foundEmpleado:Boolean = cursorEmpleado.findAny(obra);
        if (foundEmpleado) {
            form.ddlResidente.selectedItem = cursorEmpleado.current;
        }

        doSort('jornadaLaboral', jornadasList);
        cursorLaboral = jornadasList.createCursor();
        var foundLaboral:Boolean = cursorLaboral.findAny(obra);
        if (foundLaboral) {
            form.ddlJornadaLaboral.selectedItem = cursorLaboral.current;
        }

    }


    public function borrarRegistro(event:Event, data:Object):void {
        dataToDelete = data;
        Alert.show("Estás seguro de borrar el registro?", "", 3, this, borrarRegistroFromAlert);
    }

    private function borrarRegistroFromAlert(_event:CloseEvent):void {
        //Borramos el registro, mandamos el servicio para borrar el registro y lo removemos de la lista
        if (_event.detail == Alert.YES) {
            form.remoteObra.deleteObra(dataToDelete as ObraVO);
        }

    }

    /*
     * Alta de Obra Boton*/
    public function clicAltaDeObra():void {
        // TODO Auto Generated method stub
        var errores:Array = Validator.validateAll([form.validaContrato, form.validaDescripcionObra, form.validaNombreDeObra, form.dateFieldFechaInicioDateValidator, form.dateFieldFechaTerminoDateValidator]);

        if (errores.length == 0 &&
                form.ddlEntidad.selectedIndex != -1 &&
                form.ddlJornadaLaboral.selectedIndex != -1 &&
                form.ddlLocalidad.selectedIndex != -1 &&
                form.ddlMunicipio.selectedIndex != -1 &&
                form.ddlResidente.selectedIndex != -1) {
            //There are not errors, do the action
            var obra:ObraVO = new ObraVO();
            obra.contrato = form.txtContrato.text;
            obra.descripcion = form.txtDescripcionObra.text;
            obra.fechaInicio = form.dateFieldFechaInicio.text;
            obra.fechaTermina = form.dateFieldFechadeTermino.text;
            obra.idEmpleado = form.ddlResidente.selectedItem['idEmpleado'];
            obra.nombre = form.txtNombreDeObra.text;
            obra.presupuestoEstimado = 0;
            obra.status = 'A';
            obra.jornadaLaboral = form.ddlJornadaLaboral.selectedItem['jornadaLaboral'];
            obra.idEntidad = form.ddlEntidad.selectedItem['idEntidad'];
            obra.idMunicipio = form.ddlMunicipio.selectedItem['idMunicipio'];
            obra.idLocalidad = form.ddlLocalidad.selectedItem['idLocalidad'];
            obra.lat = form.txtLat.text;
            obra.lng = form.txtLong.text;
            if (updateObra) {
                obra.idObra = obraVOtmp.idObra;
                form.remoteObra.updateObra(obra);
            } else {
                //var eventObra:ObraEvent = new ObraEvent(ObraEvent.OBRA_SAVE_DATA);
                //eventObra.obraVO = obra;
                //dispatchEvent(eventObra);
                form.remoteObra.insertObra(obra);
            }


        } else {
            Alert.show("Por favor revisar que todo esté completo", "Faltan campos por llenar");
        }
    }

    public function fecha_labelFunc(item:Object, column:GridColumn):String {
        var fecha:String = form.dateFormatter.format(item.fechaInicio);
        return fecha;
    }


    public function changeEntidadList(_event:Event):void {
        entidadSeleccionada = _event.target.selectedItem['idEntidad'];
        var mpio:MunicipioVO = new MunicipioVO();
        mpio.idEntidad = entidadSeleccionada;
        form.remoteDireccion.catMunicipio(mpio);
    }


    public function changeMunicipio(_event:Event):void {
        municipioSeleccionado = _event.target.selectedItem['idMunicipio'];
        var localidad:LocalidadVO = new LocalidadVO();
        localidad.idEntidad = entidadSeleccionada;
        localidad.idMunicipio = municipioSeleccionado;
        form.remoteDireccion.catLocalidad(localidad);

    }

    protected function mapaObra_clickHandler(_event:MapMouseEvent):void {
        // TODO Auto-generated method stub
        const mapPoint:MapPoint = form.mapaObra.toMapFromStage(_event.stageX, _event.stageY);
        const latlong:MapPoint = WebMercatorUtil.webMercatorToGeographic(mapPoint) as MapPoint;
        const xy:MapPoint = WebMercatorUtil.geographicToWebMercator(mapPoint) as MapPoint;
        latitud = latlong.y.toFixed(6);
        longitud = latlong.x.toFixed(6);
        trace("Lat: " + latitud + " Lng: " + longitud);
        var content:Object = {};
        content.wm = _event;
        content.ll = WebMercatorUtil.webMercatorToGeographic(_event.mapPoint) as MapPoint;
        form.ldr.data = content;
        form.ldr.label = "Obra: " + form.txtNombreDeObra.text + "\n " + form.txtContrato.text;
        form.mapaObra.infoWindow.show(_event.mapPoint); // "Show the click"
        form.txtLat.text = latitud;
        form.txtLong.text = longitud;

    }

    protected function cancelarObraEvents(event:MouseEvent):void {
        entidadLocated = false;
        municipioLocated = false;
    }

    protected function loadHandler():void {
        form.mapaObra.addEventListener(MouseEvent.MOUSE_MOVE, mouseCatchCoord);
    }

    protected function mouseCatchCoord(_event:MouseEvent):void {
        const mapPoint:MapPoint = form.mapaObra.toMapFromStage(_event.stageX, _event.stageY);
        const latlong:MapPoint = WebMercatorUtil.webMercatorToGeographic(mapPoint) as MapPoint;
        //txtLat.text = latlong.y.toFixed(6);
        //txtLong.text = latlong.x.toFixed(6);

    }


    private function limpiarFormulario():void {
        form.ddlEntidad.selectedIndex = -1;
        form.ddlJornadaLaboral.selectedIndex = -1;
        form.ddlLocalidad.selectedIndex = -1;
        form.ddlMunicipio.selectedIndex = -1;
        form.ddlResidente.selectedIndex = -1;
        form.txtContrato.text = "";
        form.txtDescripcionObra.text = "";
        form.dateFieldFechaInicio.text = "";
        form.dateFieldFechadeTermino.text = "";
        form.txtNombreDeObra.text = "";
        form.txtLat.text = "";
        form.txtLong.text = "";
        form.txtContrato.setFocus();
    }


    /*
     * Function para traer todos los valores de inicio
     */
    protected function initialValues(_event:Event):void {
        form.remoteEmpleado.infoEmpleado(new EmpleadoVO);
        form.remoteDireccion.catEntidad(new EntidadVO)
        form.remoteObra.infoObra(new ObraVO());
        form.remoteDireccion.catEntidad(new EntidadVO());
    }


}
}