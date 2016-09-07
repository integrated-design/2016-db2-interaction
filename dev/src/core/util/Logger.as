package core.util
{

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class Logger
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		public static const LEVEL_DEBUG:uint = 0;
		public static const LEVEL_INFO:uint = 1;
		public static const LEVEL_WARN:uint = 2;
		public static const LEVEL_ERROR:uint = 3;
		public static const LEVEL_SILENT:uint = 99;

		public static var level:uint = LEVEL_DEBUG;

		public static function debug(... message):void
		{
			if (level <= LEVEL_DEBUG)
				_log(message);
		}

		public static function info(... message):void
		{
			if (level <= LEVEL_INFO)
				_log(message);
		}

		public static function warn(... message):void
		{
			if (level <= LEVEL_WARN)
				_log(message);
		}

		public static function error(... message):void
		{
			if (level <= LEVEL_ERROR)
				_log(message);
		}

		private static function _log(message:Array):void
		{
			trace.apply(null, message);
		}
	}
}
