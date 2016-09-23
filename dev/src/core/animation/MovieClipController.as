package core.animation
{
	import flash.display.MovieClip;
	import flash.events.Event;

	import core.util.EnterFrameIntegrator;

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class MovieClipController
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		private static const MODE_STOP:int = 0;
		private static const MODE_PLAY:int = 1;
		private static const MODE_REVERSE:int = 2;

		private static var _movieClips:Vector.<MovieClip> = new Vector.<MovieClip>();
		private static var _controllers:Vector.<MovieClipController> = new Vector.<MovieClipController>();

		public static function register(target:MovieClip):MovieClipController
		{
			var index:int = _movieClips.indexOf(target);
			if (index != -1)
				return _controllers[index];
			else
			{
				var controller:MovieClipController = new MovieClipController(target);
				_movieClips.push(target);
				_controllers.push(controller);
				return controller;
			}
		}

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function MovieClipController(target:MovieClip):void
		{
			_target = target;
			play();
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		private var _mode:int;
		private var _target:MovieClip;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		public function play():void
		{
			show();
			_target.stop();
			_mode = MODE_PLAY;
			EnterFrameIntegrator.addEventListener(_enterFrameHandler);
		}

		public function reverse():void
		{
			show();
			_target.stop();
			_mode = MODE_REVERSE;
			EnterFrameIntegrator.addEventListener(_enterFrameHandler);
		}

		public function stop():void
		{
			_target.stop();
			_mode = MODE_STOP;
			EnterFrameIntegrator.removeEventListener(_enterFrameHandler);
		}

		public function stopAndHide():void
		{
			stop();
			hide();
		}

		public function gotoAndPlay(frame:int):void
		{
			show();
			_target.gotoAndStop(frame);
			_mode = MODE_PLAY;
			EnterFrameIntegrator.addEventListener(_enterFrameHandler);
		}

		public function gotoAndReverse(frame:int):void
		{
			show();
			_target.gotoAndStop(frame);
			_mode = MODE_REVERSE;
			EnterFrameIntegrator.addEventListener(_enterFrameHandler);
		}

		public function gotoAndStop(frame:int):void
		{
			_target.gotoAndStop(frame);
			_mode = MODE_STOP;
			EnterFrameIntegrator.removeEventListener(_enterFrameHandler);
		}

		public function next():void
		{
			show();
			_gotoNextFrame(true);
			_mode = MODE_STOP;
			EnterFrameIntegrator.removeEventListener(_enterFrameHandler);
		}

		public function prev():void
		{
			show();
			_gotoPrevFrame(true);
			_mode = MODE_STOP;
			EnterFrameIntegrator.removeEventListener(_enterFrameHandler);
		}

		public function show():void
		{
			_target.visible = true;
		}

		public function hide():void
		{
			_target.visible = false;
		}

		private function _enterFrameHandler(event:Event):void
		{
			if (_mode == MODE_PLAY)
				_gotoNextFrame(true);
			else if (_mode == MODE_REVERSE)
				_gotoPrevFrame(true);
		}

		private function _gotoNextFrame(loop:Boolean):void
		{
			if (loop && _target.currentFrame == _target.totalFrames)
				_target.gotoAndStop(1);
			else
				_target.nextFrame();
		}

		private function _gotoPrevFrame(loop:Boolean):void
		{
			if (loop && _target.currentFrame == 1)
				_target.gotoAndStop(_target.totalFrames);
			else
				_target.prevFrame();
		}
	}
}
