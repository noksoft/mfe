package com.maqzar.nok.view
{
	import mx.preloaders.DownloadProgressBar;
	import flash.display.Sprite;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import mx.events.FlexEvent;
	import flash.display.MovieClip;

	
	public class Preloader extends DownloadProgressBar
	{
		[Embed(source='../../../../assets/swf/MTM_Assets.swf', symbol='splashLoader')]
		public static var PreloaderSWF:Class;
		public var pl:MovieClip;
		private var _preloader:Sprite;
		
		public function Preloader():void
		{
			super();
			pl = new PreloaderSWF();
			addChild(pl);
			pl.gotoAndStop(0);
		}
		
		public override function set preloader(preloader:Sprite):void
		{
			_preloader = preloader;
			_preloader.addEventListener(ProgressEvent.PROGRESS, onSWFDownloadProgress);
			_preloader.addEventListener(Event.COMPLETE, onSWFDownloadComplete);
			_preloader.addEventListener(FlexEvent.INIT_PROGRESS, onFlexInitProgress);
			_preloader.addEventListener(FlexEvent.INIT_COMPLETE, onFlexInitComplete);
			centerPreloader();
		}
		private function centerPreloader():void
		{
			x = (stageWidth / 2) - (pl.width / 2);
			y = (stageHeight / 2) - (pl.height / 2);
			//x += 125;
			//y += 200;
		}
		private function onSWFDownloadProgress(event:ProgressEvent):void
		{
			var t:Number = event.bytesTotal;
			var l:Number = event.bytesLoaded;
			var p:Number = Math.round((l/t) * 100);
			pl.gotoAndStop(p);
		}
		private function onSWFDownloadComplete(event:Event):void
		{
			pl.gotoAndStop(100);
		}
		private function onFlexInitProgress(event:FlexEvent):void
		{
			pl.gotoAndStop(100);
		}
		private function onFlexInitComplete(event:FlexEvent):void
		{
			pl.gotoAndStop(100);
			_preloader.removeEventListener(ProgressEvent.PROGRESS, onSWFDownloadProgress);
			_preloader.removeEventListener(Event.COMPLETE, onSWFDownloadComplete);
			_preloader.removeEventListener(FlexEvent.INIT_PROGRESS, onFlexInitProgress);
			_preloader.removeEventListener(FlexEvent.INIT_COMPLETE, onFlexInitComplete);
			dispatchEvent( new Event(Event.COMPLETE));
		}
	}
}