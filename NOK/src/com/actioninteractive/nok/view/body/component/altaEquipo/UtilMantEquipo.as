package com.actioninteractive.nok.view.body.component.altaEquipo
{
	import com.actioninteractive.nok.event.EquipoEvent;
	import com.actioninteractive.nok.model.CRUDModel;
	import com.actioninteractive.nok.model.EquipoModel;
	import com.actioninteractive.nok.vo.MarcaMotorVO;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.controls.DateField;

	public class  UtilMantEquipo
	{
		[Inject]
		[Bindable]
		public var marcasModel:CRUDModel;
		
		[Inject]
		[Bindable]
		public var modelEquipo:EquipoModel;
		
		public var eventEquipo:EquipoEvent;
		[Bindable] public var flagTipoRodaje:Boolean = false;
		
		public function changeTipoRodaje (event:Event, value:String = ""):void{
			var value:String = Object(event.target.selectedItem).descripcion;
			if(value == "Otro"){
				modelEquipo.flagTipoRodaje = true;
				value = value;
			}else{
				modelEquipo.flagTipoRodaje = false;
			}
			
			modelEquipo.equipoVO.tiporodaje = value;
		}
		
		/**
		 * Guarda la marca de motor seleccionada
		 **/
		public function changeMarcaMotor (evt:Event):void{
			var _marcaMotor:MarcaMotorVO = evt.target.selectedItem as MarcaMotorVO;
			modelEquipo.equipoVO.idMarcamotor = _marcaMotor.idMarcaMotor
			modelEquipo.equipoVO.marcamotor = _marcaMotor.marcaMotor;
			
		}
		
		/**
		 * Guarda el modelo del motor
		 **/
		public function changeModeloMotor (event:Event, value:String = ""):void{
			var tempValue:String = value;
			if(tempValue != ""){
				modelEquipo.equipoVO.modelomotor = tempValue;
				//modelEquipo.equipoVO.idModelomotor = tempValue;
			}
		}
		
		/**
		 * Guarda el cambio de la selección de cilindros
		 **/
		public function changeCilindros (event:Event):void{
			var tempValue:Number = event.target.value;
			if(tempValue > 0){
				modelEquipo.equipoVO.cilindros = tempValue.toString();
			}
			
		}
		
		public function changeCambioAceite (event:Event):void{
			var value:String = event.target.value;
			if(value != ""){
				modelEquipo.equipoVO.cambioaceite = value;
			}
		}
		
		public function changeCombustible (event:Event):void{
			var item:Object = event.target.selectedItem;
			modelEquipo.equipoVO.combustible = item.name;
		}
		
		public function changeNumMotor (event:Event):void{
			var value:String = event.target.text;
			if(value != ""){
				modelEquipo.equipoVO.numeromotor = value;
			}
		}
		
		public function changeTipoMedida(event:Event):void{
			var value:String = event.target..text;
			if(value != ""){
				modelEquipo.equipoVO.tipomedida = value;
			}
		}
		
		public function changeRin(event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.rin = value;
			}
		}
		
		public function changeHP (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.hp = value;
			}
		}
		
		public function changeTorque (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.torque = value;
			}
		}
		
		public function changeLlanta (event:Event):void{
			var value:String = event.target..text;
			if(value != ""){
				modelEquipo.equipoVO.tipollanta = value;
			}
		}
		
		public function changeLargoDim (event:Event):void{
			var value:String =  event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.dimensionesalto = value;
			}
		}
		
		public function changeAnchoDim (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.dimensionesancho = value;
			}
		}
		
		public function changeAltoDim (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.dimensionesalto = value;
			}
		}
		
		
		public function changeLargoAdi (event:Event):void{
			var value:String =  event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.dimensionesalto = value;
			}
		}
		
		public function changeAnchoAdi (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.dimensionesancho = value;
			}
		}
		
		public function changeAltoAdi (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.dimensionesalto = value;
			}
		}
		
		public function changekw (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.kw = value;
			}
		}
		
		public function changeVoltaje (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.voltaje = value;
			}
		}
		
		public function changePica (event:Event):void{
			var value:String = event.target.text;
			if(value != ""){
				modelEquipo.equipoVO.pica = value;
			}
		}
		
		public function changeAmperes (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.amperes = value;
			}
		}
		
		public function changeCapPresion (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.capacidadpresion = value;
			}
		}
		
		public function changeGolpesXMinuto (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.golpesminuto = value;
			}
		}
		
		public function changeCapCarga (event:Event):void{
			var value:String = event.target.value.toString();
			if(value != ""){
				modelEquipo.equipoVO.capacidadcarga = value;
			}
		}
		
		/**
		 * Método para obetner la fecha seleccionada en Fecha de Verificación
		 */
		public function selectFechaVerificacion (dtf:DateField):void{
			var tempDate:Date = dtf.selectedDate;
			if(tempDate == null){
				dtf.text = "Fecha:__ ___ ___";
			}else{
				modelEquipo.equipoVO.fechaverificacion = tempDate.getFullYear().toString() +	'/' + (tempDate.getMonth()+1).toString() + '/' + tempDate.getDate();
			}
		}
		
		/**
		 * Método para obetner la fecha seleccionada en Fecha de Tenencia
		 */
		public function selectFechaTenencia (dtf:DateField):void{
			var tempDate:Date = dtf.selectedDate;
			if(tempDate == null){
				dtf.text = "Fecha:__ ___ ___";
			}else{
				modelEquipo.equipoVO.fechatenencia = tempDate.getFullYear().toString() +	'/' + (tempDate.getMonth()+1).toString() + '/' + tempDate.getDate();
			}
		}
		
		public function changePedimento (event:Event):void{
			var value:String = event.target.text;
			if(value != ""){
				modelEquipo.equipoVO.pedimiento = value;
			}
		}
		
		public function cleanEquipoVO ():void{
			modelEquipo.equipoVO.amperes = "";
			modelEquipo.equipoVO.anioadquisicion = "";
			modelEquipo.equipoVO.anioequipo = "";
			modelEquipo.equipoVO.cambioaceite = "";
			modelEquipo.equipoVO.capacidadcarga = "";
			modelEquipo.equipoVO.capacidadpresion = "";
			modelEquipo.equipoVO.categoria = "";
			modelEquipo.equipoVO.cilindros = "";
			modelEquipo.equipoVO.combustible = "";
			modelEquipo.equipoVO.contentFactura = new ByteArray();
			modelEquipo.equipoVO.contentFoto = new ByteArray();
			modelEquipo.equipoVO.contentPedimento = new ByteArray();
			modelEquipo.equipoVO.descripcion = "";
			modelEquipo.equipoVO.dimaditamientoalto = "";
			modelEquipo.equipoVO.dimaditamientoancho = "";
			modelEquipo.equipoVO.dimaditamientolargo = "";
			modelEquipo.equipoVO.dimensionesalto = "";
			modelEquipo.equipoVO.dimensionesancho = "";
			modelEquipo.equipoVO.dimensioneslargo = "";
			modelEquipo.equipoVO.estatus = false;
			modelEquipo.equipoVO.factura = "";
			modelEquipo.equipoVO.fechaadquisicion = "";
			modelEquipo.equipoVO.fechatenencia = "";
			modelEquipo.equipoVO.fechaverificacion = "";
			modelEquipo.equipoVO.filterEstatusEquipo = "false";
			modelEquipo.equipoVO.golpesminuto = "";
			modelEquipo.equipoVO.hp = "";
			modelEquipo.equipoVO.idCategoria = "";
			modelEquipo.equipoVO.idEquipo = "";
			modelEquipo.equipoVO.idMarca = "";
			modelEquipo.equipoVO.idMarcamotor = "";
			modelEquipo.equipoVO.idSubcategoria = "";
			modelEquipo.equipoVO.idSubmarca = "";
			modelEquipo.equipoVO.idtipocategoria = "";
			modelEquipo.equipoVO.kw = "";
			modelEquipo.equipoVO.marca = "";
			modelEquipo.equipoVO.marcamotor = "";
			modelEquipo.equipoVO.modelomotor = "";
			modelEquipo.equipoVO.fotoequipo = "";
			modelEquipo.equipoVO.fotofactura = "";
			modelEquipo.equipoVO.fotopedimento = "";
			modelEquipo.equipoVO.nombre = "";
			modelEquipo.equipoVO.numerocabina = "";
			modelEquipo.equipoVO.numerochasis = "";
			modelEquipo.equipoVO.numeroeconomico = "";
			modelEquipo.equipoVO.numeroejes = "";
			modelEquipo.equipoVO.numerollantas = "";
			modelEquipo.equipoVO.numeromotor = "";
			modelEquipo.equipoVO.numeroserie = "";
			modelEquipo.equipoVO.pedimiento = "";
			modelEquipo.equipoVO.permisofederal = "";
			modelEquipo.equipoVO.peso = "";
			modelEquipo.equipoVO.pica = "";
			modelEquipo.equipoVO.rin = "";
			modelEquipo.equipoVO.sizemotor = "";
			modelEquipo.equipoVO.subcategoria = "";
			modelEquipo.equipoVO.submarca = "";
			modelEquipo.equipoVO.tenencia = "";
			modelEquipo.equipoVO.tipoadquisicion = "";
			modelEquipo.equipoVO.tipocategoria = "";
			modelEquipo.equipoVO.tipollanta = "";
			modelEquipo.equipoVO.tipomedida = "";
			modelEquipo.equipoVO.tipomotor = "";
			modelEquipo.equipoVO.tiporodaje = "";
			modelEquipo.equipoVO.tipoverificacion = "";
			modelEquipo.equipoVO.torque = "";
			modelEquipo.equipoVO.uso = "";
			modelEquipo.equipoVO.verificacion = "";
			modelEquipo.equipoVO.voltaje = "";
		}
	}
}