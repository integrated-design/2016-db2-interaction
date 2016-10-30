# What's this
2016年度「デザインベーシック Ⅱ インタラクション」の講義で使うプログラミング教材

正常にコンパイルを通すために以下を守ること
* flaファイルは新規作成せず、サンプルをコピーして使うこと
* flaファイルと同階層にframeworkフォルダを配置すること

# Latest package and examples
[Download 2.0.3](https://github.com/integrated-design/2016-db2-interaction/raw/master/package/2.0.3.zip)

[API Reference 2.0.3](https://integrated-design.github.io/2016-db2-interaction/App.html)

# Release note
* 2.0.3
 * 起動直後に再生時にマウスがステージ上にあった場合にonMoveBeginとonMoveEndが呼び出されるのを回避 (バグ修正)
 * MovieClipController登録時のMovieClip初期状態をstopからplayに変更 (バグ修正)
 * onClick以外のonAbc系のイベントが呼ばれた回数をabcCountとして取得する変数を追加 (機能追加)
 * MouseCursorVisibleを廃止して、showMouseCursor / hideMouseCursor関数を追加 (機能廃止 / 機能追加)
 * MovieClipのループ再生モード / 一回再生モードを切り替えるためのmcLoop / mcNoLoop関数を追加 (機能追加)

* 2.0.2
 * EnterFrameIntegraterのlistener関数実行中にリスナー削除がおこなわれた場合にnullエラーが出るバグを修正 (バグ修正)
 * 現行の学生グループに対する挙動の整合性を優先させるため、MovieClipController登録時の初MovieClip期状態をplayからstopに変更

* 2.0.1
 * MovieClipController登録時の初MovieClip期状態をstopからplayに変更 (バグ修正)

 * 2.0.0
 * 1stリリース
