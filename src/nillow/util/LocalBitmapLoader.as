/**
 * User: EvgenyPik
 * Date: 3/26/2014
 * Time: 11:49 AM
 */
package nillow.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class LocalBitmapLoader extends LocalLoader
	{
		public function LocalBitmapLoader(target:IEventDispatcher = null)
		{
			super(target);
		}

		override public function load(file:File):void
		{
			if (file.exists)
			{
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);

				var ba:ByteArray = new ByteArray();
				stream.readBytes(ba);
				stream.close();

				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event):void
				{
					loader.removeEventListener(Event.COMPLETE, arguments.callee);

					var loaderInfo:LoaderInfo = LoaderInfo(e.target);
					var bmpData:BitmapData = (loaderInfo.content as Bitmap).bitmapData.clone();
					loader.unloadAndStop();
					ba.clear();
					ba = null;

					dispatchEvent(new LocalLoaderEvent(LocalLoaderEvent.COMPLETE, new Bitmap(bmpData)));
				});
				loader.loadBytes(ba);
			}
			else
			{
				dispatchEvent(new LocalLoaderEvent(LocalLoaderEvent.ERROR));
			}
		}
	}
}
