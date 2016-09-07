package core.reactor
{
	import flash.display.Stage;
	import flash.events.Event;

	import core.delegate.DelegateCollector;

	/**
	 * @author Yukiya Okuda
	 * @private
	 *
	 * function onResize();
	 * function onResize(width, height);
	 */
	public class ResizeReactor extends BaseReactor
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function ResizeReactor(delegate:DelegateCollector, stage:Stage):void
		{
			super(delegate);

			_stage = stage;

			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;

			_stage.addEventListener(Event.RESIZE, _resizeHandler);
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// stageHeight 
		//--------------------------------------

		private var _stageHeight:int;

		public function get stageHeight():int
		{
			return _stageHeight;
		}

		//--------------------------------------
		// stageWidth 
		//--------------------------------------

		private var _stageWidth:int;

		public function get stageWidth():int
		{
			return _stageWidth;
		}

		private var _stage:Stage;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		private function _resizeHandler(event:Event):void
		{
			_stageWidth = _stage.stageWidth;
			_stageHeight = _stage.stageHeight;
			delegate.onResize.execute(_stageWidth, _stageHeight);
		}
	}
}
