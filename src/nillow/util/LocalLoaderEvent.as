/**
 * User: EvgenyPik
 * Date: 3/26/2014
 * Time: 11:46 AM
 */
package nillow.util
{
	import flash.events.Event;

	public class LocalLoaderEvent extends Event
	{
		public static const COMPLETE:String = "LocalLoaderEvent::COMPLETE";
		public static const ERROR:String = "LocalLoaderEvent::ERROR";
		
		private var _data:Object;
		
		public function LocalLoaderEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}

		public function get data():Object
		{
			return _data;
		}

		override public function clone():Event
		{
			return new LocalLoaderEvent(type, data, bubbles, cancelable);
		}
	}
}
