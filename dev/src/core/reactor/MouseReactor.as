package core.reactor
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import core.delegate.DelegateCollector;
	import core.util.EnterFrameIntegrator;

	/**
	 * @author Yukiya Okuda
	 * @private
	 *
	 * function onClick();
	 * function onClick(x, y);
	 *
	 * function onMoveBegin();
	 * function onMoveBegin(x, y);
	 *
	 * function onMove();
	 * function onMove(x, y);
	 *
	 * function onMoveEnd();
	 * function onMoveEnd(x, y);
	 *
	 * function onDrag();
	 * function onDrag(x, y);
	 *
	 * function onMouseDown();
	 * function onMouseDown(x, y);
	 *
	 * function onMouseUp();
	 * function onMouseUp(x, y);
	 */
	public class MouseReactor extends BaseReactor
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function MouseReactor(delegate:DelegateCollector, stage:Stage):void
		{
			super(delegate);

			_stage = stage;

			_pmouseX = _mouseX = stage.mouseX;
			_pmouseY = _mouseY = stage.mouseY;
			_vmouseX = _vmouseY = 0;
			_mouseSpeed = 0;
			_clickCount = 0;
			_isMouseDown = false;
			_isMouseMoving = false;
			_isMouseDragging = false;

			_stage.addEventListener(MouseEvent.CLICK, _mouseClickHandler);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDownHandler);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, _mouseMoveHandler);
			_stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUpHandler);
			EnterFrameIntegrator.addEventListener(_enterFrameHandler);
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// clickCount 
		//--------------------------------------

		private var _clickCount:int;

		public function get clickCount():int
		{
			return _clickCount;
		}

		//--------------------------------------
		// isMouseDown 
		//--------------------------------------

		private var _isMouseDown:Boolean;

		public function get isMouseDown():Boolean
		{
			return _isMouseDown;
		}

		//--------------------------------------
		// isMouseDragging 
		//--------------------------------------

		private var _isMouseDragging:Boolean;

		public function get isMouseDragging():Boolean
		{
			return _isMouseDragging;
		}

		//--------------------------------------
		// isMouseMoving 
		//--------------------------------------

		private var _isMouseMoving:Boolean;

		public function get isMouseMoving():Boolean
		{
			return _isMouseMoving;
		}

		//--------------------------------------
		// mouseSpeed 
		//--------------------------------------

		private var _mouseSpeed:Number;

		public function get mouseSpeed():Number
		{
			return _mouseSpeed;
		}

		//--------------------------------------
		// mouseX 
		//--------------------------------------

		private var _mouseX:Number;

		public function get mouseX():Number
		{
			return _mouseX;
		}

		//--------------------------------------
		// mouseY 
		//--------------------------------------

		private var _mouseY:Number;

		public function get mouseY():Number
		{
			return _mouseY;
		}

		//--------------------------------------
		// pmouseX 
		//--------------------------------------

		private var _pmouseX:Number;

		public function get pmouseX():Number
		{
			return _pmouseX;
		}

		//--------------------------------------
		// pmouseY 
		//--------------------------------------

		private var _pmouseY:Number;

		public function get pmouseY():Number
		{
			return _pmouseY;
		}

		//--------------------------------------
		// vmouseX 
		//--------------------------------------

		private var _vmouseX:Number;

		public function get vmouseX():Number
		{
			return _vmouseX;
		}

		//--------------------------------------
		// vmouseY 
		//--------------------------------------

		private var _vmouseY:Number;

		public function get vmouseY():Number
		{
			return _vmouseY;
		}

		private var _stage:Stage;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		private function _enterFrameHandler(event:Event):void
		{
			var isMouseMoved:Boolean = false;
			if (_mouseX != _stage.mouseX || _mouseY != _stage.mouseY)
			{
				isMouseMoved = true;
				_mouseX = _stage.mouseX;
				_mouseY = _stage.mouseY;
			}

			_vmouseX = _mouseX - _pmouseX;
			_vmouseY = _mouseY - _pmouseY;

			_pmouseX = _mouseX;
			_pmouseY = _mouseY;

			_mouseSpeed = Math.sqrt(_vmouseX * _vmouseX + _vmouseY * _vmouseY);

			if (isMouseMoved)
			{
				if (_isMouseDown)
					_isMouseDragging = true;

				if (_isMouseMoving)
					delegate.onMouseMove.execute(_mouseX, _mouseY);
				else
				{
					_isMouseMoving = true;
					delegate.onMouseMoveBegin.execute(_mouseX, _mouseY);
				}

				if (_isMouseDragging)
					delegate.onMouseDrag.execute(_mouseX, _mouseY);
			}
			else
			{
				if (_isMouseMoving)
				{
					_isMouseMoving = false;
					delegate.onMouseMoveEnd.execute(_mouseX, _mouseY);
				}
			}
		}

		private function _mouseClickHandler(event:MouseEvent):void
		{
			++_clickCount;
			delegate.onMouseClick.execute(_mouseX, _mouseY);
		}

		private function _mouseDownHandler(event:MouseEvent):void
		{
			_isMouseDown = true;
			delegate.onMouseDown.execute(_mouseX, _mouseY);
		}

		private function _mouseMoveHandler(event:MouseEvent):void
		{
		}

		private function _mouseUpHandler(event:MouseEvent):void
		{
			_isMouseDown = false;
			_isMouseDragging = false;
			delegate.onMouseUp.execute(_mouseX, _mouseY);
		}
	}
}
