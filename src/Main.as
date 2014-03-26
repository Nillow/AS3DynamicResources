package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.System;
	import flash.utils.ByteArray;

	import nillow.util.LocalBitmapLoader;
	import nillow.util.LocalLoaderEvent;

	/**
	 * nillow
	 * @author
	 */
	public class Main extends Sprite
	{
		private var imgInstance:Bitmap;

		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}

		public function onMouseClick(e:MouseEvent):void
		{
			if (!imgInstance)
			{
				var filePath:File = File.applicationDirectory.resolvePath("drop.png");
				var loader:LocalBitmapLoader = new LocalBitmapLoader();
				loader.addEventListener(LocalLoaderEvent.COMPLETE, onBitmapComplete);
				loader.load(filePath);										
			}
			else
			{
				removeChild(imgInstance)
				imgInstance.bitmapData.dispose();
				imgInstance = null;
				System.gc();
			}
		}

		private function onBitmapComplete(event:LocalLoaderEvent):void
		{
			imgInstance = event.data as Bitmap;
			addChild(imgInstance);
		}

	}

}