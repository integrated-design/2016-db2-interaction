package core.util
{

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class ColorUtil
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		public static function convertColorRGB2HSV(r:uint, g:uint, b:uint):Object
		{
			var h:Number = 0;
			var s:Number = 0;
			var v:Number = 0;
			var rr:Number = r / 255;
			var gg:Number = g / 255;
			var bb:Number = b / 255;
			var max:Number = Math.max(rr, gg, bb);
			var min:Number = Math.min(rr, gg, bb);
			if (max != 0)
			{
				s = (max - min) / max;
				if (max == rr)
					h = 60 * (gg - bb) / (max - min);
				else if (max == gg)
					h = 60 * (bb - rr) / (max - min) + 120;
				else
					h = 60 * (rr - gg) / (max - min) + 240;
				while (h < 0)
					h += 360;
			}
			v = max;
			return {h: h, s: s, v: v};
		}

		public static function convertColorHSV2RGB(h:Number, s:Number, v:Number):Object
		{
			if (s == 0)
			{
				var gray:uint = v * 255;
				return {r: gray, g: gray, b: gray};
			}
			else
			{
				var hIndex:int = (h / 60) >> 0;
				var f:Number = (h / 60 - hIndex);
				var p:Number = v * (1 - s);
				var q:Number = v * (1 - f * s);
				var t:Number = v * (1 - (1 - f) * s);
				return hIndex == 0 ? {r: uint(v * 255), g: uint(t * 255), b: uint(p * 255)} :
					hIndex == 1 ? {r: uint(q * 255), g: uint(v * 255), b: uint(p * 255)} :
					hIndex == 2 ? {r: uint(p * 255), g: uint(v * 255), b: uint(t * 255)} :
					hIndex == 3 ? {r: uint(p * 255), g: uint(q * 255), b: uint(v * 255)} :
					hIndex == 4 ? {r: uint(t * 255), g: uint(p * 255), b: uint(v * 255)} :
					{r: uint(v * 255), g: uint(p * 255), b: uint(q * 255)};
			}
		}
	}
}
