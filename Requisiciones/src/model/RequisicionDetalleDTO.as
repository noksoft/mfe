package model
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.requisicion.model.dto.RequisicionDetalleDTO")]
	public class RequisicionDetalleDTO
	{
		public var idRequisicionDetalle:String = '';
		public var idRequisicion:String = '';
		public var idArticulo:String = '';
		public var descripcionArticulo:String = '';
		public var cantidadRequerida:String = '0';
		public var cantidadAdquirida:String = '0';
		public var costoUnidad:String = '0';
		public var cosTototal:String = '0';
		public var estatusRequisicionDetalle:String = "Nuevo";
		public var estatus:Boolean = true;
		
		public function RequisicionDetalleDTO(proceso:String = "", idArticulo:String = "", cantidad:String = "", nombreArticulo:String = ""){
			this.estatusRequisicionDetalle = proceso;
			this.idArticulo = idArticulo;
			this.cantidadRequerida = cantidad;
			this.descripcionArticulo = nombreArticulo;
		}
	}
}