package core.reactor
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;

	import core.delegate.DelegateCollector;
	import core.util.ColorUtil;
	import core.util.EnterFrameIntegrator;
	import core.util.Logger;

	/**
	 * @author Yukiya Okuda
	 * @private
	 *
	 * function onCamera();
	 * function onCamera(activity);
	 *
	 * function onCameraColor();
	 * function onCameraColor(h, s, v);
	 */
	public class CameraReactor extends BaseReactor
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		private static var _camera:Camera;

		public static function getCamera():Camera
		{
			if (!_camera)
			{
				_camera = Camera.getCamera();
				_camera.setMode(320, 240, 30);
			}
			return _camera;
		}

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function CameraReactor(delegate:DelegateCollector):void
		{
			super(delegate);

			_captureEnabled = delegate.onCameraColor.hasFunction;
			if (_captureEnabled || delegate.onCamera.hasFunction)
			{
				_camera = getCamera();
				Logger.info("+ Camera : " + (Camera ? "[OK]" : "[NG]"));
				Logger.info("+");
				if (_camera)
				{
					_video = new Video();
					_video.attachCamera(_camera);
					_videoFrame = 0;

					if (_captureEnabled)
					{
						_captureScale = 0.1; // キャプチャ画像のオリジナルに対するスケール
						_captureMargin = 0.2; // 色抽出の際に切り捨てる周辺のマージン比率
						_captureFrame = 0;
						_captureImage = new BitmapData(_camera.width * _captureScale, _camera.height * _captureScale, false, 0x0);
						_captureMatrix = new Matrix(_captureScale, 0, 0, _captureScale);
						_captureRect = new Rectangle(_captureImage.width * _captureMargin, _captureImage.height * _captureMargin, _captureImage.width * (1 - _captureMargin * 2), _captureImage.height * (1 - _captureMargin * 2));
						_captureDebug = new Bitmap(_captureImage);
					}

					_camera.addEventListener(ActivityEvent.ACTIVITY, _cameraActivityHandler);
					EnterFrameIntegrator.addEventListener(_enterFrameHandler);
				}
			}
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// captureDebug 
		//--------------------------------------

		private var _captureDebug:Bitmap;

		public function get captureDebug():Bitmap
		{
			return _captureDebug;
		}

		private var _captureColorHSV:Object;
		private var _captureEnabled:Boolean;
		private var _captureFrame:int;
		private var _captureImage:BitmapData;
		private var _captureMargin:Number;
		private var _captureMatrix:Matrix;
		private var _captureRect:Rectangle;
		private var _captureScale:Number;
		private var _video:Video;
		private var _videoFrame:int;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		private function _enterFrameHandler(event:Event):void
		{
			++_videoFrame;

			var activity:Number = _camera.activityLevel / 100;
			if (activity > 0)
				delegate.onCamera.execute(activity);

			if (_captureEnabled)
			{
				_captureColor();
				delegate.onCameraColor.execute(_captureColorHSV.h, _captureColorHSV.s, _captureColorHSV.v);
			}
		}

		private function _cameraActivityHandler(event:ActivityEvent):void
		{
		}

		private function _captureColor():void
		{
			if (_captureFrame != _videoFrame)
			{
				_captureFrame = _videoFrame;
				_captureImage.draw(_video, _captureMatrix);
				var meanR:Number = 0;
				var meanG:Number = 0;
				var meanB:Number = 0;
				var pixels:Vector.<uint> = _captureImage.getVector(_captureRect);
				var pixelCount:int = pixels.length;
				var pixel:uint;
				for (var i:int = 0; i < pixelCount; ++i)
				{
					pixel = pixels[i];
					meanR += (pixel >> 16) & 0xff;
					meanG += (pixel >> 8) & 0xff;
					meanB += pixel & 0xff;
				}
				meanR /= pixelCount;
				meanG /= pixelCount;
				meanB /= pixelCount;
				_captureColorHSV = ColorUtil.convertColorRGB2HSV(meanR, meanG, meanB);
			}
		}
	}
}
