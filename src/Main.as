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
				trace(filePath.exists);
				
				var stream:FileStream = new FileStream();
				stream.open(filePath, FileMode.READ);

				var ba:ByteArray = new ByteArray();
				stream.readBytes(ba);
				stream.close();
				
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void{
					loader.removeEventListener(Event.COMPLETE, arguments.callee);
					
					var loaderInfo:LoaderInfo = LoaderInfo(e.target);
					var bmpData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, false, 0xFFFFFF);
					bmpData.draw(loaderInfo.loader);

					imgInstance = new Bitmap(bmpData);
					
					addChild(imgInstance);
//					addChild(new Bitmap(bmpData));
					
					ba = null;
					System.gc();
				});
				loader.loadBytes(ba);												
			}
			else
			{
				removeChild(imgInstance)
				imgInstance.bitmapData.dispose();
				imgInstance = null;
				System.gc();
			}
		}

	}

}