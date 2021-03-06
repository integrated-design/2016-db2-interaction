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
		 *   - MovieClipController登録時の初MovieClip期状態をstopからplayに変更 (バグ修正)
		 * 2.0.2
		 *   - EnterFrameIntegraterのlistener関数実行中にリスナー削除がおこなわれた場合にnullエラーが出るバグを修正 (バグ修正)
		 *   - 現行の学生グループに対する挙動の整合性を優先させるため、MovieClipController登録時の初MovieClip期状態をplayからstopに変更
		 * 2.0.3
		 *   - 起動直後に再生時にマウスがステージ上にあった場合にonMoveBeginとonMoveEndが呼び出されるのを回避 (バグ修正)
		 *   - MovieClipController登録時のMovieClip初期状態をstopからplayに変更 (バグ修正)
		 *   - onClick以外のonAbc系のイベントが呼ばれた回数をabcCountとして取得する変数を追加 (機能追加)
		 *   - MouseCursorVisibleを廃止して、showMouseCursor / hideMouseCursor関数を追加 (機能廃止 / 機能追加)
		 *   - MovieClipのループ再生モード / 一回再生モードを切り替えるためのmcLoop / mcNoLoop関数を追加 (機能追加)
		 */
		public static const FRAMEWORK_VERSION:String = "2.0.3";

		/**
		 * プレゼン時の画面解像度
		 */
		public static const PRESENTATION_AUTO_DETECT:Boolean = false;
		public static const PRESENTATION_SCREEN_W:Number = 1024;
		public static const PRESENTATION_SCREEN_H:Number = 768;
	}
}
