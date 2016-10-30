package core.reactor
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import core.delegate.DelegateCollector;

	/**
	 * @author Yukiya Okuda
	 * @private
	 *
	 * function onKeyDown();
	 * function onKeyDown(key);
	 *
	 * function onKeyUp();
	 * function onKeyUp(key);
	 */
	public class KeyboardReactor extends BaseReactor
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function KeyboardReactor(delegate:DelegateCollector, stage:Stage):void
		{
			super(delegate);

			_keyDownCount = 0;
			_keyUpCount = 0;

			stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, _keyUpHandler);
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// keuDownCount 
		//--------------------------------------

		private var _keyDownCount:int;

		public function get keyDownCount():int
		{
			return _keyDownCount;
		}

		//--------------------------------------
		// keyUpCount 
		//--------------------------------------

		private var _keyUpCount:int;

		public function get keyUpCount():int
		{
			return _keyUpCount;
		}

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		private function _keyDownHandler(event:KeyboardEvent):void
		{
			++_keyDownCount;
			delegate.onKeyDown.execute(_getKeyString(event.keyCode));
		}

		private function _keyUpHandler(event:KeyboardEvent):void
		{
			++_keyUpCount;
			delegate.onKeyUp.execute(_getKeyString(event.keyCode));
		}

		private function _getKeyString(keyCode:int):String
		{
			switch (keyCode)
			{
				case Keyboard.SPACE:
				{
					return " ";
				}

				case Keyboard.UP:
				{
					return "UP";
				}
				case Keyboard.DOWN:
				{
					return "DOWN";
				}
				case Keyboard.LEFT:
				{
					return "LEFT";
				}
				case Keyboard.RIGHT:
				{
					return "RIGHT";
				}

				case Keyboard.SHIFT:
				{
					return "SHIFT";
				}
				case Keyboard.COMMAND:
				{
					return "COMMAND";
				}
				case Keyboard.CONTROL:
				{
					return "CTRL";
				}
				case Keyboard.ALTERNATE:
				{
					return "ALT";
				}
				case Keyboard.CAPS_LOCK:
				{
					return "CAPS";
				}
				case Keyboard.TAB:
				{
					return "TAB";
				}
				case Keyboard.BACKSPACE:
				{
					return "BACKSPACE";
				}
				case Keyboard.DELETE:
				{
					return "DEL";
				}
				case Keyboard.ESCAPE:
				{
					return "ESC";
				}

				default:
				{
					return String.fromCharCode(keyCode);
				}
			}
		}
	}
}
