package core.reactor
{
	import core.delegate.DelegateCollector;

	/**
	 * Abstract
	 * @author Yukiya Okuda
	 * @private
	 */
	public class BaseReactor
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function BaseReactor(delegate:DelegateCollector):void
		{
			_delegate = delegate;
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// delegate 
		//--------------------------------------

		private var _delegate:DelegateCollector;

		public function get delegate():DelegateCollector
		{
			return _delegate;
		}
	}
}
