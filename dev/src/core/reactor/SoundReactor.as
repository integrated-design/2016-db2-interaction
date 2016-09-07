package core.reactor
{
	import flash.events.Event;
	import flash.media.Microphone;

	import core.delegate.DelegateCollector;
	import core.util.EnterFrameIntegrator;
	import core.util.Logger;
	import core.util.MathUtil;
	import core.util.Mean;

	/**
	 * @author Yukiya Okuda
	 * @private
	 *
	 * function onSoundStart();
	 * function onSoundStart(volume);
	 *
	 * function onSound();
	 * function onSound(volume);
	 *
	 * function onSoundEnd();
	 */
	public class SoundReactor extends BaseReactor
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function SoundReactor(delegate:DelegateCollector):void
		{
			super(delegate);

			if (delegate.onSoundStart.hasFunction || delegate.onSound.hasFunction || delegate.onSoundEnd.hasFunction)
			{
				_microphone = Microphone.getEnhancedMicrophone();
				Logger.info("+ Microphone : " + (_microphone ? "[OK]" : "[NG]"));
				Logger.info("+");
				if (_microphone)
				{
					_microphone.gain = 50;
					_microphone.rate = 44;
					_microphone.setSilenceLevel(0, 1000);
					_microphone.setLoopBack(true);

					_mean = new Mean(3);
					_minActivityLevel = 0.1;

					_isSoundOn = false;
					EnterFrameIntegrator.addEventListener(_enterFrameHandler);
				}
			}
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		private var _isSoundOn:Boolean;
		private var _mean:Mean;
		private var _microphone:Microphone;
		private var _minActivityLevel:Number;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		private function _enterFrameHandler(event:Event):void
		{
			var currentVolume:Number = MathUtil.map(_microphone.activityLevel / 100, _minActivityLevel, 1, 0, 1);
			var meanVolume:Number = _mean.add(currentVolume);
			if (meanVolume > 0)
			{
				if (_isSoundOn)
					delegate.onSound.execute(meanVolume);
				else
				{
					_isSoundOn = true;
					delegate.onSoundStart.execute(meanVolume);
				}
			}
			else
			{
				if (_isSoundOn)
				{
					_isSoundOn = false;
					delegate.onSoundEnd.execute();
				}
			}
		}
	}
}
