package core.util
{

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class MathUtil
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		public static function map(value:Number, srcMin:Number, srcMax:Number, dstMin:Number, dstMax:Number):Number
		{
			value = value < srcMin ? srcMin : value > srcMax ? srcMax : value;
			return (value - srcMin) * (dstMax - dstMin) / (srcMax - srcMin) + dstMin;
		}
	}
}
