package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	import flash.utils.getTimer;

	import core.controller.MovieClipController;
	import core.delegate.DelegateCollector;
	import core.reactor.CameraReactor;
	import core.reactor.KeyboardReactor;
	import core.reactor.MouseReactor;
	import core.reactor.ResizeReactor;
	import core.reactor.SoundReactor;
	import core.util.ColorUtil;
	import core.util.EnterFrameIntegrator;
	import core.util.Logger;
	import core.vars.Config;

	/**
	 * 多摩美術大学統合デザイン学科 デザインベーシックⅡ インタラクション
	 * @author Yukiya Okuda
	 */
	public class App extends Sprite
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		public static const PI:Number = Math.PI;

		/**
		 * バージョン情報
		 * @private
		 */
		public static const VERSION:String = Config.FRAMEWORK_VERSION;

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		/**
		 * ドキュメントクラスに設定もしくは明示的にインスタンス化して使用する
		 * @param stage ステージへの参照
		 * @param target 諸々の機能を委譲する先のオブジェクト
		 * @private
		 */
		public function App(stage:Stage = null, target:Object = null):void
		{
			_stage = stage;
			_target = target || this;

			if (_stage && _target)
				_initialize();
			else
				addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		/**
		 * onClickの呼び出し回数を取得する
		 */
		public function get clickCount():int
		{
			return _mouseReactor.clickCount;
		}

		/**
		 * onDragの呼び出し回数を取得する
		 */
		public function get dragCount():int
		{
			return _mouseReactor.mouseDragCount;
		}

		//--------------------------------------
		// frameCount 
		//--------------------------------------

		private var _frameCount:int;

		/**
		 * プログラムを起動してから経過したフレーム数
		 */
		public function get frameCount():int
		{
			return _frameCount;
		}

		//--------------------------------------
		// frameRate 
		//--------------------------------------

		/**
		 * フレームレートを取得 / 設定する
		 */
		public function get frameRate():Number
		{
			return _stage.frameRate;
		}

		public function set frameRate(frameRate:Number):void
		{
			_stage.frameRate = frameRate;
		}

		/**
		 * ステージ全体の高さを取得する
		 * @private
		 */
		override public function get height():Number
		{
			return _resizeReactor.stageHeight;
		}

		/**
		 * 現在マウスのボタンが押されているかどうかを取得する
		 */
		public function get isMouseDown():Boolean
		{
			return _mouseReactor.isMouseDown;
		}

		/**
		 * 現在マウスがドラッグされているかどうかを取得する
		 */
		public function get isMouseDragging():Boolean
		{
			return _mouseReactor.isMouseDragging;
		}

		/**
		 * onKeyDownの呼び出し回数を取得する
		 */
		public function get keyDownCount():int
		{
			return _keyboardReactor.keyDownCount;
		}

		/**
		 * onKeyUpの呼び出し回数を取得する
		 */
		public function get keyUpCount():int
		{
			return _keyboardReactor.keyUpCount;
		}

		//--------------------------------------
		// milliSeconds 
		//--------------------------------------

		private var _milliSeconds:int;

		/**
		 * プログラムを起動してから経過したミリ秒数を取得する
		 */
		public function get milliSeconds():int
		{
			return _milliSeconds;
		}

		/**
		 * onMouseDownの呼び出し回数を取得する
		 */
		public function get mouseDownCount():int
		{
			return _mouseReactor.mouseDownCount;
		}

		/**
		 * マウスの現在の移動速度を取得する
		 */
		public function get mouseSpeed():Number
		{
			return _mouseReactor.mouseSpeed;
		}

		/**
		 * onMouseUpの呼び出し回数を取得する
		 */
		public function get mouseUpCount():int
		{
			return _mouseReactor.mouseUpCount;
		}

		/**
		 * マウスの現在のx座標を取得する
		 */
		override public function get mouseX():Number
		{
			return _mouseReactor.mouseX;
		}

		/**
		 * マウスの現在のy座標を取得する
		 */
		override public function get mouseY():Number
		{
			return _mouseReactor.mouseY;
		}

		/**
		 * onMoveBeginの呼び出し回数を取得する
		 */
		public function get moveBeginCount():int
		{
			return _mouseReactor.mouseMoveBeginCount;
		}

		/**
		 * onMoveの呼び出し回数を取得する
		 */
		public function get moveCount():int
		{
			return _mouseReactor.mouseMoveCount;
		}

		/**
		 * onMoveEndの呼び出し回数を取得する
		 */
		public function get moveEndCount():int
		{
			return _mouseReactor.mouseMoveEndCount;
		}

		/**
		 * マウスの直前のx座標を取得する
		 */
		public function get pmouseX():Number
		{
			return _mouseReactor.pmouseX;
		}

		/**
		 * マウスの直前のy座標を取得する
		 */
		public function get pmouseY():Number
		{
			return _mouseReactor.pmouseY;
		}

		/**
		 * onResizeの呼び出し回数を取得する
		 */
		public function get resizeCount():int
		{
			return _resizeReactor.resizeCount;
		}

		/**
		 * onSoundBeginの呼び出し回数を取得する
		 */
		public function get soundBeginCount():int
		{
			return _soundReactor.soundBeginCount;
		}

		/**
		 * onSoundの呼び出し回数を取得する
		 */
		public function get soundCount():int
		{
			return _soundReactor.soundCount;
		}

		/**
		 * onSoundEndの呼び出し回数を取得する
		 */
		public function get soundEndCount():int
		{
			return _soundReactor.soundEndCount;
		}

		//--------------------------------------
		// stage 
		//--------------------------------------

		private var _stage:Stage;

		/**
		 * @private
		 */
		override public function get stage():Stage
		{
			return _stage;
		}

		/**
		 * ステージ全体の高さを取得する
		 */
		public function get stageHeight():Number
		{
			return _resizeReactor.stageHeight;
		}

		/**
		 * ステージ全体の幅を取得する
		 */
		public function get stageWidth():Number
		{
			return _resizeReactor.stageWidth;
		}

		/**
		 * マウスのx軸方向の移動速度を取得する
		 */
		public function get vmouseX():Number
		{
			return _mouseReactor.vmouseX;
		}

		/**
		 * マウスのy軸方向の移動速度を取得する
		 */
		public function get vmouseY():Number
		{
			return _mouseReactor.vmouseY;
		}

		/**
		 * ステージ全体の幅を取得する
		 * @private
		 */
		override public function get width():Number
		{
			return _resizeReactor.stageWidth;
		}

		private var _cameraReactor:CameraReactor;
		private var _delegate:DelegateCollector;

		//--------------------------------------
		// mouseCursorState 
		//--------------------------------------

		private var _isMouseCursorVisible:Boolean;
		private var _keyboardReactor:KeyboardReactor;
		private var _mouseReactor:MouseReactor;
		private var _resizeReactor:ResizeReactor;
		private var _soundReactor:SoundReactor;
		private var _target:Object;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		/**
		 * マウスカーソルを表示する
		 * <listing version="3.0">
		 * showMouseCursor();
		 * </listing>
		 */
		public function showMouseCursor():void
		{
			if (_isMouseCursorVisible)
				return;
			_isMouseCursorVisible = true;
			Mouse.show();
		}

		/**
		 * マウスカーソルを隠す
		 * <listing version="3.0">
		 * hideMouseCursor();
		 * </listing>
		 */
		public function hideMouseCursor():void
		{
			if (!_isMouseCursorVisible)
				return;
			_isMouseCursorVisible = false;
			Mouse.hide();
		}

		/**
		 * フレームスクリプトの記述を許容するが実行はしない
		 * @private
		 */
		public function addFrameScript(... args):void
		{
		}

		/**
		 * ランダムな小数値を生成する
		 * @param min ランダムの下限値
		 * @param max ランダムの上限値
		 * @return 生成されたランダムの値
		 * @example 以下の例では、5から10までのランダムな数字を生成して出力します。
		 * <listing version="3.0">
		 * var n = ramdom(5, 10);
		 * trace(n);
		 * </listing>
		 */
		public function random(min:Number, max:Number):Number
		{
			return min + Math.random() * (max - min);
		}

		/**
		 * 指定された引数のうち、ランダムに選択する
		 * @param value ランダムの選択肢
		 * @return ランダムに選ばれた値
		 * @example 以下の例では、1, 5, 10, 22, 46, 100の中からランダムに選んでひとつ出力します。
		 * <listing version="3.0">
		 * var n = choose(1, 5, 10, 22, 46, 100);
		 * trace(n);
		 * </listing>
		 */
		public function choose(... value):*
		{
			return value[int(Math.random() * value.length)];
		}

		/**
		 * 複数の数値の中から最小値を見つける
		 * @param number 複数の数値
		 * @return 見つかった最小値
		 */
		public function min(... number):Number
		{
			return number.length == 1 ? number[0] : Math.min.apply(null, number);
		}

		/**
		 * 複数の数値の中から最大値を見つける
		 * @param number 複数の数値
		 * @return 見つかった最大値
		 */
		public function max(... number):Number
		{
			return number.length == 1 ? number[0] : Math.max.apply(null, number);
		}

		/**
		 * 小数部分を切り捨てて整数に変換する
		 * @param number 変換前の小数値
		 * @return 変換後の整数
		 */
		public function floor(number:Number):Number
		{
			return Math.floor(number);
		}

		/**
		 * 小数部分を切り上げて整数に変換する
		 * @param number 変換前の小数値
		 * @return 変換後の整数
		 */
		public function ceil(number:Number):Number
		{
			return Math.ceil(number);
		}

		/**
		 * 小数部分を四捨五入して整数に変換する
		 * @param number 変換前の小数値
		 * @return 変換後の整数
		 */
		public function round(number:Number):Number
		{
			return Math.round(number);
		}

		/**
		 * サイン関数を計算する
		 * @param angle 入力するラジアン角度
		 * @return 計算結果
		 */
		public function sin(angle:Number):Number
		{
			return Math.sin(angle);
		}

		/**
		 * コサイン関数を計算する
		 * @param angle 入力するラジアン角度
		 * @return 計算結果
		 */
		public function cos(angle:Number):Number
		{
			return Math.cos(angle);
		}

		/**
		 * タンジェント関数を計算する
		 * @param angle 入力するラジアン角度
		 * @return 計算結果
		 */
		public function tan(angle:Number):Number
		{
			return Math.tan(angle);
		}

		/**
		 * アークサイン関数を計算する
		 * @param sin 入力するサイン値
		 * @return 計算結果
		 */
		public function asin(sin:Number):Number
		{
			return Math.asin(sin);
		}

		/**
		 * アークコサイン関数を計算する
		 * @param sin 入力するコサイン値
		 * @return 計算結果
		 */
		public function acos(cos:Number):Number
		{
			return Math.acos(cos);
		}

		/**
		 * アークタンジェント関数を計算する
		 * @param x 入力するx値
		 * @param y 入力するy値
		 * @return 計算結果
		 */
		public function atan(x:Number, y:Number):Number
		{
			return Math.atan2(y, x);
		}

		/**
		 * 平方根を計算する
		 * @param value 数値
		 * @return valueの平方根
		 */
		public function sqrt(number:Number):Number
		{
			return Math.sqrt(number);
		}

		/**
		 * 累乗を計算する
		 * @param base 元の値
		 * @param pow 累乗する値
		 * @return baseの数値をpowの数値で累乗した値
		 */
		public function pow(base:Number, pow:Number):Number
		{
			return Math.pow(base, pow);
		}

		/**
		 * オブジェクトの色を16進数で指定して変更する
		 * @param target カラー変更対象の表示オブジェクト
		 * @param hex 16進数カラー（0xRRGGBB）
		 * @example 以下の例では、ステージに配置してあるballオブジェクトをカラーコード#FF3366に着色します。
		 * <listing version="3.0">
		 * setColorHEX(ball, 0xFF3366);
		 * </listing>
		 */
		public function setColorHEX(target:DisplayObject, hex:uint):void
		{
			var colorTransform:ColorTransform = target.transform.colorTransform;
			colorTransform.color = hex;
			target.transform.colorTransform = colorTransform;
		}

		/**
		 * オブジェクトの色をRGB値で指定して変更する
		 * @param target カラー変更対象の表示オブジェクト
		 * @param r 赤（0〜255）
		 * @param g 緑（0〜255）
		 * @param b 青（0〜255）
		 * @example 以下の例では、ステージに配置してあるballオブジェクトを赤100、緑56、青255に着色します。
		 * <listing version="3.0">
		 * setColorRGB(ball, 100, 56, 255);
		 * </listing>
		 */
		public function setColorRGB(target:DisplayObject, r:uint, g:uint, b:uint):void
		{
			setColorHEX(target, (r << 16) | (g << 8) | b);
		}

		/**
		 * オブジェクトの色をHSV値で指定して変更する
		 * @param target カラー変更対象の表示オブジェクト
		 * @param h 色相（0〜360）
		 * @param s 彩度（0〜1）
		 * @param v 明度（0〜1）
		 * @example 以下の例では、ステージに配置してあるballオブジェクトを色相210、彩度0.5、明度0.8に着色します。
		 * <listing version="3.0">
		 * setColorHSV(ball, 210, 0.5, 0.8);
		 * </listing>
		 */
		public function setColorHSV(target:DisplayObject, h:Number, s:Number, v:Number):void
		{
			var rgb:Object = convertColorHSV2RGB(h, s, v);
			setColorRGB(target, rgb.r, rgb.g, rgb.b);
		}

		/**
		 * RGBをHSVに色変換する
		 * @param r 赤（0〜255）
		 * @param g 緑（0〜255）
		 * @param b 青（0〜255）
		 * @return h,s,vという名前のプロパティをもったオブジェクト
		 * <listing version="3.0">
		 * var hsv:Object = convertColorRGB2HSV(38, 82, 127);
		 * trace("H", hsv.h); //210.33707865168537
		 * trace("S", hsv.s); //0.7007874015748031
		 * trace("V", hsv.v); //0.4980392156862745
		 * </listing>
		 */
		public function convertColorRGB2HSV(r:uint, g:uint, b:uint):Object
		{
			return ColorUtil.convertColorRGB2HSV(r, g, b);
		}

		/**
		 * HSVをRGBに色変換する
		 * @param h 色相（0〜360）
		 * @param s 彩度（0〜1）
		 * @param v 明度（0〜1）
		 * @return r,g,bという名前のプロパティをもったオブジェクト
		 * <listing version="3.0">
		 * var rgb:Object = convertColorHSV2RGB(210, 0.7, 0.5);
		 * trace("R", rgb.r); //38
		 * trace("G", rgb.g); //82
		 * trace("B", rgb.b); //127
		 * </listing>
		 */
		public function convertColorHSV2RGB(h:Number, s:Number, v:Number):Object
		{
			return ColorUtil.convertColorHSV2RGB(h, s, v);
		}

		/**
		 * マウスカーソルがオブジェクトに重なっているかどうかを判定する
		 * @param target 判定対象の表示オブジェクト
		 * @return マウスカーソルがtargetに重なっている場合はtrueを返す
		 * @example 以下の例では、ステージに配置してあるballオブジェクトに対してマウスの重なりを判定します。
		 * <listing version="3.0">
		 * var result = checkMouseOver(ball);
		 * trace(result);
		 * </listing>
		 */
		public function checkMouseOver(target:DisplayObject):Boolean
		{
			return target.hitTestPoint(mouseX, mouseY, true);
		}

		/**
		 * MovieClipを再生する
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcPlay(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.play();
		}

		/**
		 * MovieClipを逆再生する
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcReverse(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.reverse();
		}

		/**
		 * MovieClipを停止する
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcStop(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.stop();
		}

		/**
		 * MovieClipを停止して非表示にする
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcStopAndHide(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.stopAndHide();
		}

		/**
		 * MovieClipを指定したフレーム移動させた後に再生する
		 * @param target 操作対象のMovieClip
		 * @param frame 移動させるフレーム
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcGotoAndPlay(target:MovieClip, frame:int):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.gotoAndPlay(frame);
		}

		/**
		 * MovieClipを指定したフレーム移動させた後に逆再生する
		 * @param target 操作対象のMovieClip
		 * @param frame 移動させるフレーム
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcGotoAndReverse(target:MovieClip, frame:int):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.gotoAndReverse(frame);
		}

		/**
		 * MovieClipを指定したフレーム移動させた後に停止する
		 * @param target 操作対象のMovieClip
		 * @param frame 移動させるフレーム
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcGotoAndStop(target:MovieClip, frame:int):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.gotoAndStop(frame);
		}

		/**
		 * MovieClipを1フレーム進めて停止する
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcNext(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.next();
		}

		/**
		 * MovieClipを1フレーム戻して停止する
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcPlay(ball);
		 * </listing>
		 */
		public function mcPrev(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.prev();
		}

		/**
		 * MovieClipを表示する
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcShow(ball);
		 * </listing>
		 */
		public function mcShow(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.show();
		}

		/**
		 * MovieClipを非表示にする
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcShow(ball);
		 * </listing>
		 */
		public function mcHide(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.hide();
		}

		/**
		 * MovieClipをループ再生モードにする
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcLoop(ball);
		 * </listing>
		 */
		public function mcLoop(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.loop();
		}

		/**
		 * MovieClipを一回再生モードにする
		 * @param target 操作対象のMovieClip
		 * @example 以下の例では、ballというインスタンス名のMovieClipを操作しています。
		 * <listing version="3.0">
		 * mcNoLoop(ball);
		 * </listing>
		 */
		public function mcNoLoop(target:MovieClip):void
		{
			var controller:MovieClipController = MovieClipController.register(target);
			controller.noLoop();
		}

		/**
		 * オブジェクトの上下左右の端の座標を取得する
		 * @param target 座標を取得する対象の表示オブジェクト
		 * @return 上下左右の端の座標を格納したオブジェクトを返します。
		 * @example 以下の例では、ステージに配置してあるballオブジェクトの基準点から、ballオブジェクトの上下左右の端までの距離を取得しています。
		 * <listing version="3.0">
		 * var bounds = getBounds(ball);
		 * trace("top    ", bounds.top);
		 * trace("bottom ", bounds.bottom);
		 * trace("left   ", bounds.left);
		 * trace("right  ", bounds.right);
		 * trace("");
		 * </listing>
		 */
		override public function getBounds(target:DisplayObject):Rectangle
		{
			var bounds:Rectangle = target.getBounds(target);
			return bounds;
		}

		private function _initialize():void
		{
			Logger.level = Logger.LEVEL_INFO;
			Logger.info("+--------------------------------------------------");
			Logger.info("+");
			Logger.info("+ Interaction Framework " + VERSION);
			Logger.info("+");

			//
			_stage = _stage || super.stage;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;

			//
			if (Config.PRESENTATION_AUTO_DETECT && Capabilities.screenResolutionX == Config.PRESENTATION_SCREEN_W && Capabilities.screenResolutionY == Config.PRESENTATION_SCREEN_H)
				_stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;

			//
			_delegate = new DelegateCollector(_target);

			//
			_milliSeconds = 0;
			_frameCount = 0;
			_isMouseCursorVisible = true;

			//
			_mouseReactor = new MouseReactor(_delegate, _stage);
			_keyboardReactor = new KeyboardReactor(_delegate, _stage);
			_soundReactor = new SoundReactor(_delegate);
			_cameraReactor = new CameraReactor(_delegate);
			_resizeReactor = new ResizeReactor(_delegate, _stage);

			//
			//if (_cameraReactor.captureDebug)
			//	_stage.addChild(_cameraReactor.captureDebug);

			//
			EnterFrameIntegrator.addEventListener(_enterFrameHandler);

			//
			Logger.info("+--------------------------------------------------");
			Logger.info("");

			//
			_delegate.setup.execute();
		}

		private function _addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
			_initialize();
		}

		private function _enterFrameHandler(event:Event):void
		{
			++_frameCount;
			_milliSeconds = getTimer();
			_delegate.loop.execute();
		}
	}
}
