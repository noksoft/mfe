package view
{
	import event.CommonEvent;
	import event.EventEquipo;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import model.EquipoVO;
	import model.SubCategoriaVO;
	import model.TipoCategoriaVO;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.swizframework.processors.DispatcherProcessor;
	
	import spark.components.Panel;
	
	import utils.AlertUtils;
	
	public class EquipoViewBase extends Panel
	{
		public function EquipoViewBase()
		{
			super();
		}		
	}
}