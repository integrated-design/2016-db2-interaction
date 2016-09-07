package core.util
{
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class EnterFrameIntegrator
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		private static var _listeners:Vector.<Function> = new Vector.<Function>();
		private static var _ticker:Shape = new Shape();

		public static function addEventListener(listener:Function):void
		{
			if (_listeners.indexOf(listener) == -1)
			{
				_listeners.push(listener);
				if (!_ticker.hasEventListener(Event.ENTER_FRAME))
					_ticker.addEventListener(Event.ENTER_FRAME, _enterFrameHandler);
			}
		}

		public static function removeEventListener(listener:Function):void
		{
			var index:int = _listeners.indexOf(listener);
			if (index != -1)
			{
				_listeners.splice(index, 1);
				if (_listeners.length == 0)
					_ticker.removeEventListener(Event.ENTER_FRAME, _enterFrameHandler);
			}
		}

		private static function _enterFrameHandler(event:Event):void
		{
			var n:int = _listeners.length;
			for (var i:int = 0; i < n; ++i)
				_listeners[i](event);
		}
	}
}
