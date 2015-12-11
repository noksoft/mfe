package com.actioninteractive.nok.model
{
	import com.actioninteractive.nok.delegate.CommonService;
	import com.actioninteractive.nok.service.UsuarioDTO;
	import com.actioninteractive.nok.vo.NotificationVO;
	import com.actioninteractive.nok.vo.SectionVO;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CommonModel
	{
		/**
		 * Contiene el objeto remoto para llamar los servicios
		 * que obtienen el contenido general de la aplicacion 
		 */
		private var commonService:CommonService = new CommonService();
		
		/**
		 * Los datos del usuario actual 
		 */
		public var currentUser:UsuarioDTO = new UsuarioDTO();
		
		/**
		 * La informacion de la seccion seleccionada 
		 */
		public var currentSection:SectionVO = new SectionVO();
		
		/**
		 * La informacion de la seccion seleccionada anteriormente
		 */
		public var previousSection:SectionVO = new SectionVO();
		
		/**
		 * La lista con las secciones actuales 
		 */
		public var sectionList:ArrayCollection = new ArrayCollection();
		
		/**
		 * Contiene la lisa de notificaciones 
		 */
		public var notificationsList:ArrayCollection = new ArrayCollection();
		
		/**
		 * Se usa para limitar el funcionamiento del menu de secciones
		 * mientras se ejecuta el efecto de transicion entre secciones 
		 */
		public var sectionSlideEffectPlaying:Boolean = false;
		
		/**
		 * Bandera para indicar si el usuario esta logeado correctamente 
		 */
		public var isLoggedIn:Boolean = false;
		
		/**
		 * Bandera para indicar si se muestra el control para cambiar la contraseña del usuario
		 */
		public var isChangePassword:Boolean = false;
		
		/**
		 * Contiene la lisa de jornadas laborales
		 */
		public var jornadasList:ArrayCollection = new ArrayCollection([
			{label:"Semana", data:1}, 
			{label:"Quincena", data:2}, 
			{label:"Veintena", data:3}]);
		
		/**
		 * Arreglo meses español
		 */
		public static var monthArray:Array = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
		
		/**
		 * Arreglo días en español
		 */
		public static var dayArray:Array = ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"]
		
		public function CommonModel()
		{
		}
	}
}