package view
{
	import event.CommonEvent;
	
	import flash.events.MouseEvent;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public interface IMainView
	{
		function init():void;
		function updateData():void;
		function getItems():void;
		function saveUpdate():void;
		function saveItem():void;
		function deleteItem():void;
		function cleanFormulario():void;
		function selectedItem(_event:MouseEvent):void;
		function listenerAcceptedConfirmation(_event:CommonEvent):void;
		/********	REMOTE OBJECTS	**************/
		function resultCatItems(_event:ResultEvent):void;
		function faultCatItems(_event:FaultEvent):void;
		function insertItemHandler(_event:ResultEvent):void;
		function insertItemFault(_event:FaultEvent):void;
		function updateItemHandler(_event:ResultEvent):void;
		function updateItemFault(_event:FaultEvent):void;
		function deleteItemHandler(_event:ResultEvent):void;
		function deleteItemFault(_event:FaultEvent):void;
	}
}