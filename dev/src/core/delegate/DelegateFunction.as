package core.delegate
{

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class DelegateFunction
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function DelegateFunction(target:Object, funcName:String):void
		{
			_target = target;
			_funcName = funcName;
			try
			{
				_func = _target[_funcName];
				_hasFunction = true;
			}
			catch (error:Error)
			{
				_func = null;
				_hasFunction = false;
			}
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// hasFunction 
		//--------------------------------------

		private var _hasFunction:Boolean;

		public function get hasFunction():Boolean
		{
			return _hasFunction;
		}

		private var _func:Function;
		private var _funcName:String;
		private var _target:Object;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		public function execute(... parameters):void
		{
			if (_hasFunction)
				_func.apply(null, parameters.slice(0, _func.length));
		}
	}
}
