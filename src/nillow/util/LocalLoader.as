/**
 * User: EvgenyPik
 * Date: 3/26/2014
 * Time: 11:45 AM
 */
package nillow.util
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;

	public class LocalLoader extends EventDispatcher
	{
		public function LocalLoader(target:IEventDispatcher = null)
		{
			super(target);
		}
		
		public function load(file: File):void
		{
			
		}
	}
}
