package com.actioninteractive.nok.view.body
{
	import com.actioninteractive.nok.constant.NokConstants;
	import com.actioninteractive.nok.event.CommonEvent;
	import com.actioninteractive.nok.model.CommonModel;
	import com.actioninteractive.nok.util.PortletUtil;
	import com.actioninteractive.nok.view.body.portlet.CatalogoArticulos;
	import com.actioninteractive.nok.view.body.portlet.CatalogoEmpleados;
	import com.actioninteractive.nok.view.body.portlet.CatalogoEquipo;
	import com.actioninteractive.nok.view.body.portlet.CatalogoFallas;
	import com.actioninteractive.nok.view.body.portlet.CatalogoMarcas;
	import com.actioninteractive.nok.view.body.portlet.CatalogoObras;
	import com.actioninteractive.nok.view.body.portlet.CatalogoPerfiles;
	import com.actioninteractive.nok.view.body.portlet.CatalogoProveedores;
	import com.actioninteractive.nok.view.body.portlet.CatalogoUsuarios;
	import com.actioninteractive.nok.view.body.portlet.DashboardAltaFalla;
	import com.actioninteractive.nok.view.body.portlet.DashboardFletes;
	import com.actioninteractive.nok.view.body.portlet.DashboardObras;
	import com.actioninteractive.nok.view.body.portlet.DashboardRequisiciones;
	import com.actioninteractive.nok.view.body.portlet.DashboardResguardoEmpleado;
	import com.actioninteractive.nok.view.body.portlet.DashboardTaller;
	import com.actioninteractive.nok.view.body.portlet.Portlet;
	import com.actioninteractive.nok.view.body.portlet.ProgramaMantenimiento;
	import com.actioninteractive.nok.view.body.portlet.TestPortlet1;
	import com.actioninteractive.nok.view.body.portlet.TestPortlet2;
	import com.actioninteractive.nok.vo.PortletVO;
	import com.actioninteractive.nok.vo.SectionVO;
	
	import flash.utils.getDefinitionByName;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	
	import spark.components.SkinnableContainer;
	import spark.components.VGroup;
	
	public class PortletContainerBase extends SkinnableContainer
	{
		/**
		 * Se debe declarar una variable con los tipos de clases
		 * que se van a usar para mostrar informacion en los portlets
		 */
		private var testPortlet1:TestPortlet1;
		private var testPortlet2:TestPortlet2;
		private var altaFalla:DashboardAltaFalla;
		private var catalogoArticulos:CatalogoArticulos;
		private var catalogoEmpleados:CatalogoEmpleados;
		private var catalogoMarcas:CatalogoMarcas;
		private var catalogoProveedores:CatalogoProveedores;
		private var catalogoFallas:CatalogoFallas
		private var catalogoUsuarios:CatalogoUsuarios;
		private var catalogoEquipo:CatalogoEquipo;
		private var catalogoPerfiles:CatalogoPerfiles;
		private var programaMantenimiento:ProgramaMantenimiento;
		private var dashboardFletes:DashboardFletes;
		private var dashboardRequisiciones:DashboardRequisiciones;
		private var dashboardObras:DashboardObras;
		private var dashboardTaller:DashboardTaller;
		private var dashboardResguardoEmpleado:DashboardResguardoEmpleado;
		//private var portletFechas:PortletFechas;
		
		private var catalogoObras:CatalogoObras;
		
		
		/**
		 * Se debe declarar una variable con los tipos de clases
		 * que se van a usar para mostrar informacion en los portlets
		 */
		
		private var view:PortletContainer = PortletContainer(this);
		
		[Bindable]
		protected var mainContainerXFrom:int;
		
		[Bindable]
		protected var mainContainerXTo:int;
		
		[Bindable]
		protected var tempContainerXFrom:int;
		
		[Bindable]
		protected var tempContainerXTo:int;
		
		[Inject]
		public var commonModel:CommonModel;
		
		public var _commonEvent:CommonEvent;
		
		public function PortletContainerBase()
		{
			super();
		}
		
		[PostConstruct]
		public function initializeHomeSection():void{
			//Disparamos evento para seleccionar la seccion HOME
			var ev:CommonEvent = new CommonEvent(CommonEvent.SECTION_CLICKED_EVENT);
			ev.section = SectionVO(commonModel.sectionList.getItemAt(0));
			
			sectionClicked(ev);
		}
		
		[EventHandler(event="CommonEvent.SECTION_CLICKED_EVENT", priority="0")]
		public function sectionClicked(e:CommonEvent):void{
			var userSettings:ArrayCollection = e.section.portletList;
			var adjustSize:Boolean = false;
			var portletSize:PortletVO;
			
			//Guardando la section anterior para saber en que direccion hacer el efecto
			if(commonModel.currentSection != null){
				commonModel.previousSection = commonModel.currentSection;
			}
			commonModel.currentSection = e.section;
			
			view.tempPortletGroupLeft.removeAllElements();
			view.tempPortletGroupRight.removeAllElements();
			
			view.tempPortletGroupLeft.percentWidth = 100;
			view.tempPortletGroupRight.percentWidth = 100;
			
			view.tempPortletGroupLeft.visible = true;
			view.tempPortletGroupRight.visible = true;
			
			view.tempPortletGroupLeft.includeInLayout = true;
			view.tempPortletGroupRight.includeInLayout = true;
			
			view.tempContainer.visible = false;
			
			//Generando los portlets necesarios en el componente temporal
			for each(var portletData:PortletVO in userSettings){
				var portletClass:Class;
				var portlet:UIComponent;
				
				if(portletData.posicion == -1){
					continue;
				}
				
				if(portletData.isEmpty){
					portlet = new Portlet();
				}else{
					portletClass = Class(getDefinitionByName(portletData.componente_class));
					portlet = new portletClass();
				}
				
				portlet["dataSource"] = portletData;
				
				switch(portletData.posicion){
					case(NokConstants.PORTLET_POSITION_UPPER_LEFT):
						view.tempPortletGroupLeft.addElementAt(portlet, 0);
						break;
					case(NokConstants.PORTLET_POSITION_LOWER_LEFT):
						view.tempPortletGroupLeft.addElement(portlet);
						break;
					case(NokConstants.PORTLET_POSITION_UPPER_RIGHT):
						view.tempPortletGroupRight.addElementAt(portlet, 0);
						break;
					case(NokConstants.PORTLET_POSITION_LOWER_RIGHT):
						view.tempPortletGroupRight.addElement(portlet);
						break;
				}
				
				if(portletData.main_posicion == NokConstants.PORTLET_SIZE_MAXIMIZED || portletData.main_posicion == NokConstants.PORTLET_SIZE_FULL_SCREEN){
					adjustSize = true;
					portletSize = portletData;
				}
			}
			
			addBlankPortlets();
			
			if(adjustSize){
				var ev:CommonEvent = new CommonEvent(CommonEvent.PORTLET_SIZE_CHANGED_EVENT);
				ev.portlet = portletSize;
				
				tempPortletSizeChanged(ev);
			}
			
			//El efecto tiene un segundo y medio de retardo para asegurar que se puedan
			//dibujar apropiadamente los componentes antes de comenzar el efecto
			startSlideEffect();
		}
		
		/**
		 * Agrega portlets vacios en los espacios que faltan
		 * para que siempre hayan 4 portlets en pantalla 
		 * 
		 */
		private function addBlankPortlets():void{
			var blank1:Portlet;
			var blank2:Portlet;
			var tempPortlet:Portlet;
			
			if(view.tempPortletGroupLeft.numElements == 0){
				blank1 = new Portlet();
				blank1.dataSource.posicion = NokConstants.PORTLET_POSITION_UPPER_LEFT;
				
				blank2 = new Portlet();
				blank2.dataSource.posicion = NokConstants.PORTLET_POSITION_LOWER_LEFT;
				
				view.tempPortletGroupLeft.addElement(blank1);
				view.tempPortletGroupLeft.addElement(blank2);
			}else if(view.tempPortletGroupLeft.numElements == 1){
				blank1 = new Portlet();
				tempPortlet = view.tempPortletGroupLeft.getElementAt(0) as Portlet;
				
				if(tempPortlet.dataSource.posicion == NokConstants.PORTLET_POSITION_UPPER_LEFT){
					blank1.dataSource.posicion = NokConstants.PORTLET_POSITION_LOWER_LEFT;
					
					view.tempPortletGroupLeft.addElementAt(blank1,1);
				}else{
					blank1.dataSource.posicion = NokConstants.PORTLET_POSITION_UPPER_LEFT;
					
					view.tempPortletGroupLeft.addElementAt(blank1,0);
				}
			}
			
			if(view.tempPortletGroupRight.numElements == 0){
				blank1 = new Portlet();
				blank1.dataSource.posicion = NokConstants.PORTLET_POSITION_UPPER_RIGHT;
				
				blank2 = new Portlet();
				blank2.dataSource.posicion = NokConstants.PORTLET_POSITION_LOWER_RIGHT;
				
				view.tempPortletGroupRight.addElement(blank1);
				view.tempPortletGroupRight.addElement(blank2);
			}else if(view.tempPortletGroupRight.numElements == 1){
				blank1 = new Portlet();
				tempPortlet = view.tempPortletGroupRight.getElementAt(0) as Portlet;
				
				if(tempPortlet.dataSource.posicion == NokConstants.PORTLET_POSITION_UPPER_RIGHT){
					blank1.dataSource.posicion = NokConstants.PORTLET_POSITION_LOWER_RIGHT;
					
					view.tempPortletGroupRight.addElementAt(blank1,1);
				}else{
					blank1.dataSource.posicion = NokConstants.PORTLET_POSITION_UPPER_RIGHT;
					
					view.tempPortletGroupRight.addElementAt(blank1,0);
				}
			}
		}
		
		/**
		 * Realiza todos los ajustes necesarios cuando se cambia el tamaño de un portlet
		 * @param e El evento que contiene la informacion del cambio de tamaño
		 * 
		 */
		[EventHandler(event="CommonEvent.PORTLET_SIZE_CHANGED_EVENT")]
		public function portletSizeChanged(e:CommonEvent):void{
			adjustPortlets(e.portlet, view.portletGroupLeft, view.portletGroupRight);
			
			//Despues de realizar todos los cambios en el layout volvemos a mostrar los porlets
			dispatchEvent(new CommonEvent(CommonEvent.PORTLET_FADE_IN_EVENT));
		}
		
		/**
		 * Es utilizado para ajustar el tamaño de los portlets que vienen en la seccion nueva
		 * @param e
		 */
		public function tempPortletSizeChanged(e:CommonEvent):void{
			adjustPortlets(e.portlet, view.tempPortletGroupLeft, view.tempPortletGroupRight);
		}
		
		private function adjustPortlets(portlet:PortletVO, groupLeft:VGroup, groupRight:VGroup):void{
			var i:int = 0;
			var portletAdjustments:Boolean = false;
			var portletWidth:int = 100;
			var portletHeigth:int = 100;
			var portletSize:String = NokConstants.PORTLET_SIZE_NORMAL;
			var portletGroup:VGroup;
			
			resetPortletPositions(groupLeft, groupRight);
			
			if(portlet.main_posicion == NokConstants.PORTLET_SIZE_NORMAL){//Se restauran todos los portlets a tamaño normal, el tamaño normal es de 1/4
				groupLeft.percentWidth = 100;
				groupRight.percentWidth = 100;
				
				showPortletGroups();
				
				resetPortletSizes(groupLeft, groupRight, true);
				
				trace("Probablemente al poner como true la propiedad de portletAdjustments funcione.");
				//portletAdjustments = true;
				//portletAdjustments
			}else if(portlet.main_posicion == NokConstants.PORTLET_SIZE_MAXIMIZED){//--Cuando el tamaño del protlet es de 3/4
				if(portlet.isLeft == true){
					groupLeft.percentWidth = 75;
					groupRight.percentWidth = 25;
				}else{
					groupLeft.percentWidth = 25;
					groupRight.percentWidth = 75;
				}
				
				showPortletGroups();
				
				portletAdjustments = true;
				portletSize = NokConstants.PORTLET_SIZE_MINI;
				
			}else if(portlet.main_posicion == NokConstants.PORTLET_SIZE_FULL_SCREEN){//Cuabdo el tamño del portlet es de 1
				if(portlet.isLeft == true){
					groupLeft.percentWidth = 100;
					
					groupRight.percentWidth = 0;
					groupRight.visible = false;
					groupRight.includeInLayout = false;
				}else{
					groupLeft.percentWidth = 0;
					groupLeft.visible = false;
					groupLeft.includeInLayout = false;
					
					groupRight.percentWidth = 100;
				}
				
				portletAdjustments = true;
				portletSize = NokConstants.PORTLET_SIZE_HIDDEN;
			}
			
			//Se mueve un portlet de acuerdo al tipo de cambio de tamaño
			if(portletAdjustments){
				if(portlet.isLeft){
					if(portlet.posicion == NokConstants.PORTLET_POSITION_UPPER_LEFT){
						groupRight.addElement(groupLeft.getElementAt(1));
					}else{
						groupRight.addElement(groupLeft.getElementAt(0));
					}
					
					portletGroup = groupRight;
				}else{
					if(portlet.posicion == NokConstants.PORTLET_POSITION_UPPER_RIGHT){
						groupLeft.addElement(groupRight.getElementAt(1));
					}else{
						groupLeft.addElement(groupRight.getElementAt(0));
					}
					
					portletGroup = groupLeft;
				}
				
				var portletTemp:Portlet;
				for(i = 0; i < portletGroup.numElements; i++){
					portletTemp = (portletGroup.getElementAt(i) as Portlet);
					if(portletTemp.dataSource.id_config != portlet.id_config){
						portletTemp.dataSource.main_posicion = portletSize;
						portletTemp.setSizeChangeIcons();
						portletTemp.dataSource.date_last_posicion = new Date();
						portletTemp.dataSource.id_usuario = commonModel.currentUser.idUsuario;
						//Sends an event to save the current changes for portlet to the database
						updatePortletChanged(portletTemp.dataSource);
					}
				}
				
			}
			portlet.date_last_posicion = new Date();
			portlet.id_usuario = commonModel.currentUser.idUsuario;
			//Sends an event to save the current changes for portlet to the database
			updatePortletChanged(portlet);

		}
		
		private function showPortletGroups():void{
			view.portletGroupLeft.visible = true;
			view.portletGroupLeft.includeInLayout = true;
			
			view.portletGroupRight.visible = true;
			view.portletGroupRight.includeInLayout = true;
		}
		
		/**
		 * Regresa los portlets a sus posiciones originales 
		 * 
		 */
		private function resetPortletPositions(leftGroup:VGroup, rightGroup:VGroup):void{
			var portlet:Portlet;
			var i:int;
			
			//Restaurando todos los portlets a sus posiciones originales antes de hacer movimientos
			if(leftGroup.numElements > 2){
				for(i = 0; i < leftGroup.numElements; i++){
					portlet = (leftGroup.getElementAt(i) as Portlet);
					
					if(portlet.dataSource.posicion == NokConstants.PORTLET_POSITION_UPPER_RIGHT){
						rightGroup.addElementAt(portlet,0);
					}else if(portlet.dataSource.posicion == NokConstants.PORTLET_POSITION_LOWER_RIGHT){
						rightGroup.addElementAt(portlet,1);
					}
				}
			}else if(rightGroup.numElements > 2){
				for(i = 0; i < rightGroup.numElements; i++){
					portlet = (rightGroup.getElementAt(i) as Portlet);
					
					if(portlet.dataSource.posicion == NokConstants.PORTLET_POSITION_UPPER_LEFT){
						leftGroup.addElementAt(portlet,0);
					}else if(portlet.dataSource.posicion == NokConstants.PORTLET_POSITION_LOWER_LEFT){
						leftGroup.addElementAt(portlet,1);
					}
				}
			}
		}
		
		/**
		 * Restaura el tamaño de todos los portlets a 1/4 
		 * 
		 */
		private function resetPortletSizes(groupLeft:VGroup, groupRight:VGroup, updatePortlet:Boolean = false):void{
			var i:int;
			var tempPortletDTO:PortletVO
			for(i = 0; i < groupLeft.numElements; i++){
				tempPortletDTO = new PortletVO();
				tempPortletDTO = (groupLeft.getElementAt(i) as Portlet).dataSource;

				tempPortletDTO.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
				(groupLeft.getElementAt(i) as Portlet).setSizeChangeIcons();
				if(updatePortlet && tempPortletDTO.nombre_submenu != ""){
					tempPortletDTO.date_last_posicion = new Date();
					tempPortletDTO.id_usuario = commonModel.currentUser.idUsuario;
					updatePortletChanged(tempPortletDTO);
				}
			}
			for(i = 0; i < groupRight.numElements; i++){
				tempPortletDTO = new PortletVO();
				tempPortletDTO = (groupRight.getElementAt(i) as Portlet).dataSource;

				tempPortletDTO.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
				(groupRight.getElementAt(i) as Portlet).setSizeChangeIcons();
				if(updatePortlet && tempPortletDTO.nombre_submenu != ""){
					updatePortletChanged(tempPortletDTO);
				}
			}
			
		}
		
		/**
		 * Hace los calculos necesarios y ejecuta el efecto de transicion de secciones 
		 * 
		 */
		private function startSlideEffect():void{
			view.mainContainer.x = 0;
			
			//Se ejecutara el efecto de derecha a izquierda
			if(commonModel.currentSection.index > commonModel.previousSection.index){
				mainContainerXFrom = 0;
				mainContainerXTo = -view.mainContainer.width;
				
				view.tempContainer.x = view.tempContainer.width;
				
				tempContainerXFrom = view.tempContainer.width;
				tempContainerXTo = 0;
			}else{//Se ejecutara el efecto de izquierda a derecha
				mainContainerXFrom = 0;
				mainContainerXTo = view.mainContainer.width;
				
				view.tempContainer.x = -view.tempContainer.width;
				
				tempContainerXFrom = -view.tempContainer.width;
				tempContainerXTo = 0;
			}
			
			view.slide.play();
			
			view.tempContainer.visible = true;
			
			commonModel.sectionSlideEffectPlaying = true;
		}
		
		/**
		 * Hace todos los movimientos despues de que se ejecuta el efecto de transicion 
		 * 
		 */
		protected function slideEffectEnd():void{
			view.portletGroupLeft.removeAllElements();
			view.portletGroupRight.removeAllElements();
			
			view.mainContainer.x = 0;
			
			view.portletGroupLeft.percentWidth = view.tempPortletGroupLeft.percentWidth;
			view.portletGroupLeft.visible = view.tempPortletGroupLeft.visible;
			view.portletGroupLeft.includeInLayout = view.tempPortletGroupLeft.includeInLayout;
			
			view.portletGroupRight.percentWidth = view.tempPortletGroupRight.percentWidth;
			view.portletGroupRight.visible = view.tempPortletGroupRight.visible;
			view.portletGroupRight.includeInLayout = view.tempPortletGroupRight.includeInLayout;
			
			//Moviendo todos los elementos del grupo temporal al principal
			var tempLeftSize:int = view.tempPortletGroupLeft.numChildren;
			var tempRightSize:int = view.tempPortletGroupRight.numChildren;
			
			for(var i:int = 0; i < tempLeftSize; i++){
				view.portletGroupLeft.addElement(view.tempPortletGroupLeft.getElementAt(0));
			}
			
			for(i = 0; i < tempRightSize; i++){
				view.portletGroupRight.addElement(view.tempPortletGroupRight.getElementAt(0));
			}
			
			commonModel.sectionSlideEffectPlaying = false;
		}
		
		[EventHandler(event="CommonEvent.PORTLET_CHANGE_POSITION_EVENT")]
		public function changePortletPosition(e:CommonEvent):void{
			//Portlet 
			trace("e.portletMoved.dataSource: " + e.portletMoved.dataSource.posicion + " - " + e.portletMoved.dataSource.main_posicion);
			//Portlet 
			trace("e.portletdOver.dataSource: " + e.portletOver.dataSource.posicion + " - " + e.portletOver.dataSource.main_posicion);
			
			var indexMoved:int = e.portletMoved.parent.getChildIndex(e.portletMoved);
			var indexOver:int = e.portletOver.parent.getChildIndex(e.portletOver);
			var groupMoved:VGroup = VGroup(e.portletMoved.parent);
			var groupOver:VGroup = VGroup(e.portletOver.parent);
			
			var auxPositionMoved:int = e.portletMoved.dataSource.posicion;
			var auxMainPositionMoved:String = e.portletMoved.dataSource.main_posicion;
			var auxPositionOver:int = e.portletOver.dataSource.posicion;
			var auxMainPositionOver:String = e.portletOver.dataSource.main_posicion;
			
			if(groupMoved == groupOver){
				groupMoved.swapElements(e.portletMoved, e.portletOver);
			}else{
				groupMoved.addElementAt(e.portletOver, indexMoved);
				groupOver.addElementAt(e.portletMoved, indexOver);
			}
			
			PortletUtil.swapPortletPositionAndSize(e.portletMoved.dataSource, e.portletOver.dataSource);
			
			e.portletMoved.setSizeChangeIcons();
			e.portletOver.setSizeChangeIcons();

			
			var ev:CommonEvent = new CommonEvent(CommonEvent.PORTLET_SIZE_CHANGED_EVENT);
			trace(e.portletMoved.dataSource.main_posicion);
			trace(e.portletOver.dataSource.main_posicion);
			
			if(e.portletMoved.dataSource.main_posicion == e.portletOver.dataSource.main_posicion){
				trace("Se van actualizar los portlets.");
				//Vamos a realizar la actualización de las propiedades position y mainPosition de los portlets
				
				if(e.portletOver.dataSource.componente_class != ""){
					//Vamos a actualizar la posicion y main_position del portletOver
					
					updatePortletRemplaced(e.portletOver.dataSource);
				}
				if(e.portletMoved.dataSource.componente_class != ""){
					updatePortletChanged(e.portletMoved.dataSource);
				}
				return;
			}
			
			
			if(!e.portletOver.dataSource.isEmpty){
				if(e.portletMoved.dataSource.main_posicion == NokConstants.PORTLET_SIZE_MAXIMIZED){
					ev.portlet = e.portletMoved.dataSource;
					portletSizeChanged(ev);
				}else if(e.portletOver.dataSource.main_posicion == NokConstants.PORTLET_SIZE_MAXIMIZED){
					ev.portlet = e.portletOver.dataSource;
					portletSizeChanged(ev);
				}
			}else{
				if(e.portletOver.dataSource.main_posicion != NokConstants.PORTLET_SIZE_NORMAL){
					e.portletMoved.dataSource.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
					
					ev.portlet = e.portletMoved.dataSource;
					portletSizeChanged(ev);
				}
			}
			
		}
		
		/**
		 * Función que se encarga de actualizar el cambio del portlet
		 * @_portletVO Que contiene las propiedades del portlet a Actualizar
		 */
		private function updatePortletChanged(_portletVO:PortletVO):void{
			trace("PortletVO: " + _portletVO);
			_commonEvent = new CommonEvent(CommonEvent.USER_SAVE_SECTION_PORTLETS_EVENT);
			_commonEvent.portlet = _portletVO;
			dispatchEvent(_commonEvent);
		}
		
		/** Función que se encarga de remover el portlet remplazado del dashboard
		 *@_portletVO Que contiene las propiedades del portlet a Eliminar del dashboar
		 */
		private function updatePortletRemplaced(_portletVO:PortletVO):void{
			trace("_portletVO: " + _portletVO);
			var tempCommonEvent:CommonEvent = new CommonEvent(CommonEvent.USER_SAVE_SECTION_PORTLETS_EVENT);
			tempCommonEvent.portlet = _portletVO;
			dispatchEvent(tempCommonEvent);
		}
		
		[EventHandler(event="CommonEvent.PORTLET_REPLACE_EVENT")]
		public function replacePortlet(e:CommonEvent):void{
			var portletClass:Class;
			var portlet:UIComponent;
			var oldItemIndex:int;
			
			//var tempPortletRemoved:PortletVO = e.portletOver.dataSource;
			//var tempPortletRemplaced:PortletVO = e.portlet;
			
			trace(e.portlet);
			//trace(e.portletMoved.dataSource);
			trace(e.portletOver.dataSource);
			
			var auxPosition:int = e.portlet.posicion;
			var auxMainPosition:String = e.portlet.main_posicion;
			trace("auxPosicion: " + auxPosition);
			trace("auxMainPosition: " + auxMainPosition);
			
			e.portlet.posicion = e.portletOver.dataSource.posicion;
			//e.portletOver.dataSource.posicion = NokConstants.PORTLET_POSITION_NOT_SET;
			e.portletOver.dataSource.posicion = auxPosition;
			
			e.portlet.main_posicion = e.portletOver.dataSource.main_posicion;
			//e.portletOver.dataSource.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
			e.portletOver.dataSource.main_posicion = auxMainPosition
			
			if(e.portlet.isEmpty){
				portlet = new Portlet();
			}else{
				portletClass = Class(getDefinitionByName(e.portlet.componente_class));
				portlet = new portletClass();
			}
			
			portlet["dataSource"] = e.portlet;
			
			oldItemIndex = (e.portletOver.parent as VGroup).getElementIndex(e.portletOver);
			
			(e.portletOver.parent as VGroup).addElementAt(portlet, oldItemIndex);
			(e.portletOver.parent as VGroup).removeElement(e.portletOver);
			
			//Sends an event to save the current changes to the database
			e.portlet.id_usuario = commonModel.currentUser.idUsuario;
			e.portlet.date_last_posicion = new Date();
			e.portletOver.dataSource.id_usuario = commonModel.currentUser.idUsuario;
			e.portletOver.dataSource.date_last_posicion = new Date();
			
			if(e.portlet.posicion < 0){
				e.portlet.main_posicion = "0";
			}
			
			//Elimina el portlet sustituido
			updatePortletRemplaced(e.portletOver.dataSource);
			
			//Guarda el cambio del portlet agregado al dashboard
			updatePortletChanged(e.portlet);
		}
		
		[EventHandler(event="CommonEvent.PORTLET_REMOVE_EVENT")]
		public function removePortlet(e:CommonEvent):void{
			var portletClass:Class;
			var portlet:Portlet;
			var oldItemIndex:int;
			
			portlet = new Portlet();
			
			portlet.dataSource.posicion = e.portletOver.dataSource.posicion;
			e.portletOver.dataSource.posicion = NokConstants.PORTLET_POSITION_NOT_SET;
			
			portlet.dataSource.main_posicion = NokConstants.PORTLET_SIZE_NORMAL;
			
			oldItemIndex = (e.portletOver.parent as VGroup).getElementIndex(e.portletOver);
			
			(e.portletOver.parent as VGroup).addElementAt(portlet, oldItemIndex);
			(e.portletOver.parent as VGroup).removeElement(e.portletOver);
			
			if(e.portletOver.dataSource.main_posicion == NokConstants.PORTLET_SIZE_MAXIMIZED || e.portletOver.dataSource.main_posicion == NokConstants.PORTLET_SIZE_FULL_SCREEN){
				resetPortletSizes(view.portletGroupLeft, view.portletGroupRight);
				resetPortletPositions(view.portletGroupLeft, view.portletGroupRight);
				view.portletGroupLeft.percentWidth = 100;
				view.portletGroupRight.percentWidth = 100;
			}
			
			//Sends an event to save the current changes to the database
			if(e.portlet == null){
				e.portlet = e.portletOver.dataSource;
				if(e.portlet.posicion <= -1){
					e.portlet.main_posicion = "0";
				}
			}
			e.portlet.date_last_posicion = new Date();
			e.portlet.id_usuario = commonModel.currentUser.idUsuario;
			
			updatePortletChanged(e.portlet);
		}
		
		/**
		 * Ordena los elementos del arreglo de los portlets 
		 * @param a Primero elemento a comparar
		 * @param b Segundo elemento a comparar
		 * @param array
		 * @return 0 si son iguales, 1 si "a" es mayor a "b", -1 si "b" es mayor a "a"
		 * 
		 */
		private function sortPortletsByPosition(a:Object, b:Object, array:Array = null):int{
			if(a.position == b.position){
				return 0;
			}else if(a.position > b.position){
				return 1;
			}else{
				return -1;
			}
		}
	}
}