package view.component
{
	import event.EventSolicitud;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.VGroup;
	
	public class ComponentSolicitudBase extends VGroup
	{
		[Bindable]
		protected var acEmpleadosRequisicion:ArrayCollection = new ArrayCollection();
		[Bindable]
		protected var acArticulos:ArrayCollection = new ArrayCollection();
		[Bindable]
		protected var acFallasEquipo:ArrayCollection = new ArrayCollection();
		[Bindable]
		protected var titleFormulario:String = "";
		protected const CREAR:String = "CREAR";
		protected const ACTUALIZAR = "ACTUALIZAR";
		
		private var componentView:ComponentSolicitud = ComponentSolicitud(this);
		private var eventSolicitud:EventSolicitud;
		
		public function ComponentSolicitudBase()
		{
			super();
		}
		
		/**
		 * Limpia el Formulario de la Adquisición Detalle
		 */
		public function clearFormulario():void{
			titleFormulario = CREAR;
			componentView.txtNomSolicitud.text = "";
			componentView.txtCantidad.text = "";
			componentView.txtObservaciones.text = "";
			componentView.autocompleteEmpleadoRequisicion.removeAll();
			componentView.autocompleteArticulo.removeAll();
			componentView.autocompleteFalla.removeAll();
		}
	}
}