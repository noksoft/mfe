import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import spark.components.gridClasses.GridColumn;

import contratos.ClienteDTO;
import contratos.ContratoDTO;

import model.ClienteVO;

[Bindable]
protected var contratosList:ArrayCollection = new ArrayCollection();
[Bindable]
protected var clientesList:ArrayCollection;
[Bindable]
protected var contratoDTO:ContratoDTO;

[Bindable]
protected var contratoHCList:ArrayCollection = new ArrayCollection([{cliente:"Pachuca Municipio", idCliente:1,rfc:"rfcsdede323"}]);

protected function init():void
{

	roClientes.catClientes(new ClienteVO());
	var contrato:ContratoDTO = new ContratoDTO();
	contrato.descripcion = "";
	contrato.estatus = true;
	contrato.fechaAlta = "";
	contrato.fechaInicio = "";
	contrato.idCliente = "";
	contrato.idContrato = "";
	contrato.numeroContrato = "";
	contrato.presupuesto = "";
	contrato.filterEstatus = "true";
	
	roContratos.catContrato(contrato);
}


protected function contratoFault(event:FaultEvent):void
{
	// TODO Auto-generated method stub
	Alert.show(event.fault.message,"Error IO");
	trace("OK-contratoFault");
}

protected function clientesResult(event:ResultEvent):void
{
	// TODO Auto-generated method stub
	clientesList = event.result as ArrayCollection;

}
protected function contratosResult(event:ResultEvent):void{
	contratosList = event.result as ArrayCollection;
}
protected function updateContratoResult(event:ResultEvent):void{
	contratoDTO = event.result as ContratoDTO;
}
protected function deleteContratoResult(event:ResultEvent):void{
	if(Boolean(event.result) == true){
		Alert.show("Se borró el contrato","Actualización")	
	}
}
protected function insertContratoResult(event:ResultEvent):void{
	contratoDTO = event.result as ContratoDTO;
	contratosList.addItem(contratoDTO);
	
}
protected function updateEstatusContratoResult(event:ResultEvent):void{
	contratoDTO = event.result as ContratoDTO;
}

protected function guardarContratoButtonClick():void
{
	var contrato:ContratoDTO = new ContratoDTO();
	contrato.numeroContrato = numeroContratoTextInput.text;
	contrato.presupuesto = presupuestoTextInput.text;
	contrato.descripcion = descripcionTextInput.text;
	contrato.fechaInicio = fechaInicioDateField.text;
	contrato.fechaFin = fechaFinDateField.text;
	contrato.idCliente = clientesComboBox.selectedItem.idCliente;
	contrato.estatus = true;
	contrato.fechaAlta = "";
	contrato.idContrato = "";
	contrato.filterEstatus = 'true';
	roContratos.insertContrato(contrato);
}

protected function actualizarContratoButtonClick():void
{
	var contrato:ContratoDTO = new ContratoDTO();
	contrato.idContrato = contratoDTO.idContrato;
	contrato.numeroContrato = numeroContratoTextInput.text;
	contrato.presupuesto = presupuestoTextInput.text;
	contrato.descripcion = descripcionTextInput.text;
	contrato.fechaInicio = fechaInicioDateField.text;
	contrato.fechaAlta = "";
	contrato.idContrato = "";
	contrato.fechaFin = fechaFinDateField.text;
	contrato.idCliente = clientesComboBox.selectedItem.idCliente;
	contrato.estatus = true;

	roContratos.insertContrato(contrato);
}
protected function borrarContratoButtonClick():void
{
	var contrato:ContratoDTO = new ContratoDTO();
	contrato.idContrato = contratoDTO.idContrato;
	contrato.numeroContrato = numeroContratoTextInput.text;
	contrato.presupuesto = presupuestoTextInput.text;
	contrato.descripcion = descripcionTextInput.text;
	contrato.fechaInicio = fechaInicioDateField.text;
	contrato.fechaFin = fechaFinDateField.text;
	contrato.idCliente = clientesComboBox.selectedItem.idCliente;
	contrato.estatus = true;
	roContratos.insertContrato(contrato);
}
protected function filterFechaFormato(item:Object, column:GridColumn):String
{
	return dateFormato.format(item[column.dataField]);
}

