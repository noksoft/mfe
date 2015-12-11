package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="mx.com.nok.requisicion.model.dto.RequisicionDTO")]
	public class RequisicionVO
	{
		public var  folioReq:String = "";
		public var  idEmpleadoRequisicion:String = "";
		public var  idEmpleadoAdquisicion:String = "";
		public var  idFalla:String = "";
		public var  observacionRequisicion:String = "";
		public var  observacionAdquisicion:String = "";
		public var  estatusProceso:String = "";
		public var  fechaRequisicion:String = "1900/1/1";
		public var  fechaAdquisicion:String = "1900/1/1";
		public var  rfcRequisicion:String = "";
		public var  nombreRequisicion:String = "";
		public var  paternoRequisicion:String = "";
		public var  maternoRequisicion:String = "";
		public var  rfcAdquisicion:String = "";
		public var  nombreAdquisicion:String = "";
		public var  paternoAdquisicion:String = "";
		public var  maternoAdquisicion:String = "";
		public var  tipoFalla:String = "";
		public var  descripcion:String = "";
		public var  nombreEquipo:String = "";
		public var  subfalla:String = "";
		public var  prioridad:String = "";
		public var listRequisicionDetalle:ArrayCollection = new ArrayCollection();
	}
}