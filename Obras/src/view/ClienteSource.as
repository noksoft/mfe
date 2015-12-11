import event.CommonEvent;

import flashx.textLayout.formats.Direction;

import model.ClienteVO;
import model.EntidadVO;
import model.LocalidadVO;
import model.MunicipioVO;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.core.Application;
import mx.events.ValidationResultEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.validators.Validator;

import utils.AlertUtils;

[Bindable]private var titleFormulario:String;
private const CREAR:String = "Crear";
private const ACTUALIZAR:String = "Actualizar";

[Bindable]private var itemSelected:ClienteVO = new ClienteVO();
[Bindable]private var entidadSelected:EntidadVO = null;
[Bindable]private var municipioSelected:MunicipioVO = null;
[Bindable]private var localidadSelected:LocalidadVO = null;


[Bindable]private var flagMunicipio:Boolean = false;
[Bindable]private var flagLocalidad:Boolean = false;
[Bindable]private var flagDateAlta:Boolean = true;
[Bindable]private var listClientes:ArrayCollection;
[Bindable]private var listMunicipios:ArrayCollection;
[Bindable]private var listEntidades:ArrayCollection;
[Bindable]private var listLocalidades:ArrayCollection;

/**
 * Metodo que inicializa los datos de la pantalla
 */
private function init():void{
    itemSelected = new ClienteVO();
    upData();
}

private function upData():void{
    roCliente.catClientes(new ClienteVO());
    roDireccion.catEntidad(new EntidadVO());
    titleFormulario = CREAR;
}

private function clearFormulario():void{
    titleFormulario = "Crear";
    itemSelected = new ClienteVO();
    cmbEntidad.selectedItem = null;
    cmbLocalidad.selectedItem = null;
    cmbMunicipio.selectedItem = null;
    entidadSelected = null;
    municipioSelected = null;
    localidadSelected = null;

    txtRFC.errorString = "";
    txtRazonSocial.errorString = "";
    txtDireccion.errorString = "";
    txtCP.errorString = "";
    cmbEntidad.errorString = "";
    cmbMunicipio.errorString = "";
    cmbLocalidad.errorString = "";
    txtTelefono.errorString = "";
    txtCorreo.errorString = "";
    txtWWW.errorString = "";
    txtContactoNombre.errorString = "";
    dateAlta.selectedDate = null;

}

private function saveCliente():void{
    var arrayValidationResult:Array = Validator.validateAll([validateRFC, validateRazonSocial, validateDireccion, validateCP, validatorEntidad, validatorMunicipio, validatorLocalidad, validatorTelefono, validatorCorreo, validatorNombreContacto, validatorDateAlta]);
    switch(titleFormulario){
        case CREAR:
            if(arrayValidationResult.length == 0){
                saveUpdateCliente();
                roCliente.insertCliente(itemSelected);
            }else{
                AlertUtils.showNoticeMessage("Notificación", "Debe de seleccionar los campos obligatorios");
            }
            //updatePropertiesClienteVO();
            break;
        case ACTUALIZAR:
            if(arrayValidationResult.length == 0){
                saveUpdateCliente();
                roCliente.updateCliente(itemSelected);
            }else{
                AlertUtils.showNoticeMessage("Notificación", "Debe de seleccionar los campos obligatorios");
            }
            break;
        default:
            break;
    }
}

private function saveUpdateCliente():void{
    itemSelected.rfc = txtRFC.text;
    itemSelected.razonSocial = txtRazonSocial.text;
    itemSelected.direccion = txtDireccion.text;
    itemSelected.cp = txtCP.text;
    itemSelected.idEntidad = entidadSelected.idEntidad;
    itemSelected.idMunicipio = municipioSelected.idMunicipio;
    itemSelected.idLocalidad = localidadSelected.idLocalidad;
    itemSelected.telefono = txtTelefono.text;
    itemSelected.correo = txtCorreo.text;
    itemSelected.www = txtWWW.text;
    itemSelected.contactoNombre = txtContactoNombre.text;
    itemSelected.fechaAlta = dateAlta.selectedDate;
    itemSelected.estatus = cbxEstatus.selected;
}

protected function deleteClient():void{
    if(itemSelected != null && itemSelected.idCliente != null && itemSelected.idCliente != ""){
        var customAlertConfirmation:AlertConfirmation = new AlertConfirmation();
        customAlertConfirmation.newCustomAlert("Por favor confirma!", "¿Estás seguro de Eliminar el Cliente?", 340, 155);
        customAlertConfirmation.addEventListener(CommonEvent.CUSTOM_ALERT_ACCEPTED_EVENT, listenerAcceptedConfirmation);
        PopUpManager.addPopUp(customAlertConfirmation, DisplayObject(Application.application),true);
    }
}

/**
 * Confirmación de eliminación
 */
private function listenerAcceptedConfirmation (_event:CommonEvent):void{
    roCliente.deleteCliente(itemSelected);
}

protected function selectCliente(_event:MouseEvent):void
{
    titleFormulario = "Actualizar";
    itemSelected = _event.currentTarget.selectedItem as ClienteVO;
    for(var i:int = 0; i < listEntidades.length; i++){
        var objEntidad:EntidadVO = listEntidades[i] as EntidadVO;
        if(objEntidad.idEntidad == itemSelected.idEntidad){
            cmbEntidad.selectedItem = objEntidad;
            selectEntidad();
            break;
        }
    }
}

/**
 * Obtienen los municipios de acuerdo a la entidad seleccionada
 */
private function selectEntidad():void{
    if(cmbEntidad.selectedItem != null){
        cmbEntidad.errorString = "";
        municipioSelected = null;
        localidadSelected = null;

        entidadSelected = cmbEntidad.selectedItem as EntidadVO;
        var tempMunicipio:MunicipioVO = new MunicipioVO();
        tempMunicipio.idEntidad = entidadSelected.idEntidad;
        roDireccion.catMunicipio(tempMunicipio);
    }
}

/**
 * Obtiene las localidades de acuerdo al municipio seleccionado
 */
private function selectMunicipio():void{
    if(cmbMunicipio.selectedItem != null){
        cmbMunicipio.errorString = "";
        localidadSelected = null;

        municipioSelected = cmbMunicipio.selectedItem as MunicipioVO;
        var tempLocalidad:LocalidadVO = new LocalidadVO();

        tempLocalidad.idEntidad = entidadSelected.idEntidad;
        tempLocalidad.idMunicipio = municipioSelected.idMunicipio;
        roDireccion.catLocalidad(tempLocalidad);
    }
}

/**
 * Setea la Localidad seleccionada
 */
private function selectLocalidad():void{
    if(cmbLocalidad.selectedItem != null){
        cmbLocalidad.errorString = "";
        localidadSelected = cmbLocalidad.selectedItem as LocalidadVO;
    }
}

/********************************************/
/*****		REMOTE OBJECT		*************/
/********************************************/
//resultCatMunicipios
private function resultCatMunicipios(_event:ResultEvent):void{
    try{
        if(_event.result != null){
            flagMunicipio = true;
            listMunicipios = _event.result as ArrayCollection;

            //Esto aplica únicamente cuando se ha seleccionado un elemento del grid
            if(itemSelected != null && itemSelected.idMunicipio != null && itemSelected.idMunicipio != ""){
                if(cmbEntidad.selectedItem != null){
                    for(var j:int = 0; j < listMunicipios.length; j++){
                        var objMunicipio:MunicipioVO = listMunicipios[j] as MunicipioVO;
                        if(objMunicipio.idMunicipio == itemSelected.idMunicipio){
                            cmbMunicipio.selectedItem = objMunicipio;
                            selectMunicipio();
                            break;
                        }
                    }
                }
            }
        }
    }catch(e:Error){
        AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de los Municipios");
    }
}
private function faultCatMunicipios(_event:FaultEvent):void{
    flagMunicipio = false;
    //Alert.show(_event.fault.message,"faultCatMunicipios");
    AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de los Municipios");
}

//resultCatEntidad
private function resultCatEntidad(_event:ResultEvent):void{
    try{
        if(_event.result != null){
            listEntidades = _event.result as ArrayCollection;
        }
    }catch(e:Error){
        //trace("Error" + e.message);
        AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las Entidades");
    }
}

private function faultCatEntidad(_event:FaultEvent):void{
    //Alert.show(_event.fault.message,"faultCatEntidad");
    trace(_event.fault.message);
    AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las Entidades");
}

//resultCatLocalidad
private function resultCatLocalidad(_event:ResultEvent):void{
    try{
        if(_event.result != null){
            flagLocalidad = true;
            listLocalidades = _event.result as ArrayCollection;

            //Aplica unicamente cuando se a seleccionado un elemento del grid
            if(itemSelected != null && itemSelected.idLocalidad != null && itemSelected.idLocalidad != ""){
                for(var k:int = 0; k < listLocalidades.length; k++){
                    var objLocalidad:LocalidadVO = listLocalidades[k] as LocalidadVO;
                    if(objLocalidad.idLocalidad == itemSelected.idLocalidad){
                        cmbLocalidad.selectedItem = objLocalidad;
                        selectLocalidad();
                        break;
                    }
                }
            }
        }
    }catch(e:Error){
        flagLocalidad = false;
        //trace("Error" + e.message);
        AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las Localidades");
    }
}

private function faultCatLocalidad(_event:FaultEvent):void{
    flagLocalidad = false;
    //Alert.show(_event.fault.message,"faultCatLocalidad");
    AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de las Localidades");
}

//catClientes
private function resultCatClientes (_event:ResultEvent):void{
    try{
        if(_event.result != null){
            listClientes = _event.result as ArrayCollection;
        }
    }catch(e:Error){
        //trace("Error" + e.message);
        AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de los Clientes");
    }
}

private function faultCatClientes (_event:FaultEvent):void{
    //Alert.show(_event.fault.message,"faultCatClientes");
    AlertUtils.showErrorMessage("Error", "No se pudo cargar la información de los Clientes");
}

//insertCliente
private function resultInsertCliente (_event:ResultEvent):void{
    try{
        if(_event.result != null){
            itemSelected = new ClienteVO();
            if(listClientes != null){
                listClientes.addItem(ClienteVO(_event.result));
                clearFormulario();
            }
        }
    }catch(e:Error){
        //Alert.show("Error", "insertCliente" + e.message);
        AlertUtils.showErrorMessage("Error", "No se pudo guardar la información del Cliente");
    }
}
private function faultInsertCliente (_event:FaultEvent):void{
    //Alert.show("Error", "insertCliente" + _event.fault.message);
    AlertUtils.showErrorMessage("Error", "No se pudo guardar la información del Cliente");
}

//updateCliente
private function resultUpdateCliente(_event:ResultEvent):void{
    try{
        if(_event.result != null){
            itemSelected = new ClienteVO();
            upData();
            clearFormulario();
        }
    }catch(e:Error){
        //Alert.show("Error", "updateCliente" + e.message);
        AlertUtils.showErrorMessage("Error", "No se pudo actualizar la información del Cliente");
    }
}
private function faultUpdateCliente(_event:FaultEvent):void{
    //Alert.show("Error", "updateCliente" + _event.fault.message);
    AlertUtils.showErrorMessage("Error", "No se pudo actualizar la información del Cliente");
}

//deleteCliente
private function resultDeleteCliente(_event:ResultEvent):void{
    try{
        if(_event.result != null){
            itemSelected = null;
            clearFormulario();
            upData();
        }
    }catch(e:Error){
        //Alert.show("Error", "deleteCliente" + e.message);
        AlertUtils.showErrorMessage("Error", "No se pudo borrar el Cliente");
    }
}
private function faultDeleteCliente (_event:FaultEvent):void{
    //Alert.show("Error", "deleteCliente" + _event.fault.message);
    AlertUtils.showErrorMessage("Error", "No se pudo borrar el Cliente");
}

/**	Validadores**/

protected function validEntidadHandler(type:int):void {
    switch(type){
        case 1:
            cmbEntidad.errorString = "";
            break;
        case 2:
            cmbMunicipio.errorString = "";
            break;
        case 3:
            cmbLocalidad.errorString = "";
            break;
        default:
            break;
    }
}

protected function validEntidadFault(type:int):void {
    switch(type){
        case 1:
            cmbEntidad.errorString = "Debe de seleccionar una Entidad";
            break;
        case 2:
            cmbMunicipio.errorString = "Debe de seleccionar un Municipio";
            break;
        case 3:
            cmbLocalidad.errorString = "Debe de seleccionar una Localidad";
            break;
        default:
            break;
    }
}

