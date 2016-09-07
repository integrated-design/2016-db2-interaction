package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;

	import core.reactor.CameraReactor;
	import core.util.EnterFrameIntegrator;

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class Cam extends MovieClip
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function Cam():void
		{
			_camera = CameraReactor.getCamera();
			if (_camera)
			{
				_videoContainer = new Sprite();
				addChild(_videoContainer);

				_video = new Video();
				_video.smoothing = true;
				_video.attachCamera(_camera);
				_videoContainer.addChild(_video);

				_fit();
				EnterFrameIntegrator.addEventListener(_enterFrameHandler);
			}
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		private var _camera:Camera;
		private var _video:Video;
		private var _videoContainer:Sprite;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		private function _fit():void
		{
			removeChild(_videoContainer);

			var bounds:Rectangle = getBounds(this);
			_videoContainer.x = bounds.x;
			_videoContainer.y = bounds.y;
			_videoContainer.width = bounds.width;
			_videoContainer.height = bounds.height;

			addChild(_videoContainer);
		}

		private function _enterFrameHandler(event:Event):void
		{
			_fit();
		}
	}
}
