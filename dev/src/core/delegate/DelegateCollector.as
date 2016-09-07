package core.delegate
{

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class DelegateCollector
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function DelegateCollector(target:Object):void
		{
			_setup = new DelegateFunction(target, "setup");
			_loop = new DelegateFunction(target, "loop");

			_onMouseClick = new DelegateFunction(target, "onClick");

			_onMouseDown = new DelegateFunction(target, "onMouseDown");
			_onMouseUp = new DelegateFunction(target, "onMouseUp");

			_onMouseMoveBegin = new DelegateFunction(target, "onMoveBegin");
			_onMouseMove = new DelegateFunction(target, "onMove");
			_onMouseMoveEnd = new DelegateFunction(target, "onMoveEnd");

			_onMouseDrag = new DelegateFunction(target, "onDrag");

			_onKeyDown = new DelegateFunction(target, "onKeyDown");
			_onKeyUp = new DelegateFunction(target, "onKeyUp");

			_onSoundBegin = new DelegateFunction(target, "onSoundBegin");
			_onSound = new DelegateFunction(target, "onSound");
			_onSoundEnd = new DelegateFunction(target, "onSoundEnd");

			_onCamera = new DelegateFunction(target, "onCamera");
			_onCameraColor = new DelegateFunction(target, "onCameraColor");

			_onResize = new DelegateFunction(target, "onResize");
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// loop 
		//--------------------------------------

		private var _loop:DelegateFunction;

		public function get loop():DelegateFunction
		{
			return _loop;
		}

		//--------------------------------------
		// onCamera 
		//--------------------------------------

		private var _onCamera:DelegateFunction;

		public function get onCamera():DelegateFunction
		{
			return _onCamera;
		}

		//--------------------------------------
		// onCameraColor 
		//--------------------------------------

		private var _onCameraColor:DelegateFunction;

		public function get onCameraColor():DelegateFunction
		{
			return _onCameraColor;
		}

		//--------------------------------------
		// onKeyDown 
		//--------------------------------------

		private var _onKeyDown:DelegateFunction;

		public function get onKeyDown():DelegateFunction
		{
			return _onKeyDown;
		}

		//--------------------------------------
		// onKeyUp 
		//--------------------------------------

		private var _onKeyUp:DelegateFunction;

		public function get onKeyUp():DelegateFunction
		{
			return _onKeyUp;
		}

		//--------------------------------------
		// onMouseClick 
		//--------------------------------------

		private var _onMouseClick:DelegateFunction;

		public function get onMouseClick():DelegateFunction
		{
			return _onMouseClick;
		}

		//--------------------------------------
		// onMouseDown 
		//--------------------------------------

		private var _onMouseDown:DelegateFunction;

		public function get onMouseDown():DelegateFunction
		{
			return _onMouseDown;
		}

		//--------------------------------------
		// onMouseDrag 
		//--------------------------------------

		private var _onMouseDrag:DelegateFunction;

		public function get onMouseDrag():DelegateFunction
		{
			return _onMouseDrag;
		}

		//--------------------------------------
		// onMouseMove 
		//--------------------------------------

		private var _onMouseMove:DelegateFunction;

		public function get onMouseMove():DelegateFunction
		{
			return _onMouseMove;
		}

		//--------------------------------------
		// onMouseMoveBegin 
		//--------------------------------------

		private var _onMouseMoveBegin:DelegateFunction;

		public function get onMouseMoveBegin():DelegateFunction
		{
			return _onMouseMoveBegin;
		}

		//--------------------------------------
		// onMouseMoveEnd 
		//--------------------------------------

		private var _onMouseMoveEnd:DelegateFunction;

		public function get onMouseMoveEnd():DelegateFunction
		{
			return _onMouseMoveEnd;
		}

		//--------------------------------------
		// onMouseUp 
		//--------------------------------------

		private var _onMouseUp:DelegateFunction;

		public function get onMouseUp():DelegateFunction
		{
			return _onMouseUp;
		}

		//--------------------------------------
		// onResize 
		//--------------------------------------

		private var _onResize:DelegateFunction;

		public function get onResize():DelegateFunction
		{
			return _onResize;
		}

		//--------------------------------------
		// onSound 
		//--------------------------------------

		private var _onSound:DelegateFunction;

		public function get onSound():DelegateFunction
		{
			return _onSound;
		}

		//--------------------------------------
		// onSoundBegin 
		//--------------------------------------

		private var _onSoundBegin:DelegateFunction;

		public function get onSoundBegin():DelegateFunction
		{
			return _onSoundBegin;
		}

		//--------------------------------------
		// onSoundEnd 
		//--------------------------------------

		private var _onSoundEnd:DelegateFunction;

		public function get onSoundEnd():DelegateFunction
		{
			return _onSoundEnd;
		}

		//--------------------------------------
		// setup 
		//--------------------------------------

		private var _setup:DelegateFunction;

		public function get setup():DelegateFunction
		{
			return _setup;
		}
	}
}
