package core.util
{

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class Mean
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function Mean(length:int):void
		{
			_length = length;
			_count = 0;
			_value = 0;
			_values = new Vector.<Number>();
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// count 
		//--------------------------------------

		private var _count:int;

		public function get count():int
		{
			return _count;
		}

		//--------------------------------------
		// length 
		//--------------------------------------

		private var _length:int;

		public function get length():int
		{
			return _length;
		}

		private var _value:Number;
		private var _values:Vector.<Number>;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		public function add(value:Number):Number
		{
			_values.push(value);
			if (_values.length > _length)
				_values.splice(0, 1);
			_calc();
			return _value;
		}

		private function _calc():void
		{
			_value = 0;
			_count = _values.length;
			for (var i:int = 0; i < _count; ++i)
				_value += _values[i];
			_value /= _count;
		}
	}
}
