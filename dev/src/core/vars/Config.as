package core.vars
{

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class Config
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		/**
		 * バージョン情報
		 * 2.0.0
		 *   - 1stリリース
		 * 2.0.1
		 *   - MovieClipController登録時の初MovieClip期状態をstopからplayに変更
		 * 2.0.2
		 *   - EnterFrameIntegraterのlistener関数実行中にリスナー削除がおこなわれた場合にnullエラーが出るバグを修正
		 *   - 現行の学生グループに対する挙動の整合性を優先させるため、MovieClipController登録時の初MovieClip期状態をplayからstopに変更
		 */
		public static const FRAMEWORK_VERSION:String = "2.0.2";

		/**
		 * プレゼン時の画面解像度
		 */
		public static const PRESENTATION_AUTO_DETECT:Boolean = true;
		public static const PRESENTATION_SCREEN_W:Number = 1024;
		public static const PRESENTATION_SCREEN_H:Number = 768;
	}
}
