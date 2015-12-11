package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="mx.com.nok.solicitud.model.dto.SolicitudDTO")]
	public class SolicitudVO
	{
		public var id_solicitud:String = "";
		public var nombre_solicitud:String = "";
		public var id_falla:String = "";
		public var id_articulo:String = "";
		public var id_prooveedor:String = "";
		public var id_empleado_requisicion:String = "";
		public var id_empleado_adquisicion:String = "";
		public var fecha_requisicion:String = "";
		public var fecha_adquisicion:String = "";
		public var forma_pago:String = "";
		public var cuenta_bancaria:String = "";
		public var cantidad:String = "0";
		public var costo_unidad:String = "0";
		public var costo_total:String = "0";
		public var tiempo_entrega:String = "0";
		public var observaciones:String = ""; 
		public var estatus_proceso:String = ProcesoEstatusEnum.REQUISICION;
		public var descripcion:String = "";
		public var marca:String = "";
		public var submarca:String = "";
		public var subcategoria:String = "";
		public var rfc_requisicion:String = "";
		public var nombre_requisicion:String = "";
		public var paterno_requisicion:String = "";
		public var materno_requisicion:String = "";
		public var rfc_adquisicion:String = "";
		public var nombre_adquisicion:String = "";
		public var paterno_adquisicion:String = "";
		public var materno_adquisicion:String = "";
		public var tipo_falla:String = "";
		public var descripcion_falla:String = "";
		public var nombreequipo:String = "";
		public var subfalla:String = "";
		public var prioridad:String = "";
		public var observaciones_falla:String = "";
		public var estatus:Boolean = true;
	}
}