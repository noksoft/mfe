package com.maqzar.views
{
import com.maqzar.dtos.SubFallaDTO;
import com.maqzar.events.DiagnosticoEvent;
import com.maqzar.models.AsignacionModel;
import com.maqzar.models.DiagnosticoModel;

import spark.components.Group;
	
	public class DiagnosticoBase extends Group
	{
		[Inject]
		[Bindable]
		public var diagnosticoModel:DiagnosticoModel;
		
		private var view:DiagnosticoPrincipal = DiagnosticoPrincipal(this);
		public function DiagnosticoBase()
		{
			super();
		}
		public function init():void{
			var fallasEvent:DiagnosticoEvent = new DiagnosticoEvent(DiagnosticoEvent.DIAGNOSTICO_GET_FALLAS);
			var falla:SubFallaDTO = new SubFallaDTO();
			//fallasEvent.subfalla = falla;
			//dispatchEvent(fallasEvent);


		}
	}
}