# このリポジトリについて
多摩美術大学統合デザイン学科 2016年度「デザインベーシック Ⅱ インタラクション」の講義で使うプログラミング教材を格納しています。
入力と出力の関係を、アニメーションを通じて学べるように設計されています。

# 最新版のダウンロード
[Download 2.0.3](https://github.com/integrated-design/2016-db2-interaction/raw/master/package/2.0.3.zip)

# はじめましょう
（執筆中）

正常にコンパイルを通すために以下を守ること
* **flaファイルは新規作成せず、サンプルをコピーして使うこと**
* **flaファイルと同階層にframeworkフォルダを配置すること**

# 動かないときのよくある原因
まずコンパイルエラーパネルをよく見ましょう。多くの場合、原因究明のヒントが書かれています。

* **「シンタックスエラー : ○○○」**
 * 原因** : 文法エラーです。以下を調べてみましょう。
  * 開くカッコ({[と、閉じるカッコ)}]の対応関係は完璧ですか？必ず開いたら閉じなければいけません。特に、onClickなどの関数を閉じ忘れている場合が多いです。
  * if文は正しく書けていますか？ `if(条件){ 条件を満たせばここが処理される; }else{ 条件を満たさなければここが処理される; }`
 
* **「未定義である可能性が高いメソッド ○○○ の呼び出しです。」**
 * 原因1 : ○○○の部分のスペルは合っていますか？大文字小文字が異なっているだけで動かないので、確認してみましょう。
 * 原因2 : flaファイルを新規作成してしまいましたか？flaファイルはあらかじめ初期設定が必要です。サンプルファイルをフォルダごとコピーしてから、flaファイルの名前を変更したものを使いましょう。
 
* **「未定義のプロパティ ○○○ へのアクセスです。」**
 * 原因1 : ○○○の部分のスペルは合っていますか？大文字小文字が異なっているだけで動かないので、確認してみましょう。
 * 原因2 : ○○○はインスタンスの名前ですか？だとすると、ステージ上のインスタンス○○○を間違えて消してしまったのかも知れません。もしステージ上になければ、ライブラリからステージに配置して名前○○○を付けてあげましょう。

* **「ソースパス「framework」が有効なディレクトリに解決されません。」**
 * 原因 : frameworkディレクトリが見つからないようです。flaファイルと同階層に、frameworkディレクトリをコピーしてみましょう。

* コンパイルエラーパネルに何も表示されていないのに期待通りの動きをしてくれない
 * アニメーションとプログラムの設計が間違っている可能性があります。コンピュータに対して、どのような命令を、どのような条件で、どのような順番でおこなえばよいか見直してみましょう。

# 詳しいドキュメント
[API Reference 2.0.3](https://integrated-design.github.io/2016-db2-interaction/App.html)

# 更新履歴
* 2.0.3
 * 起動直後に再生時にマウスがステージ上にあった場合にonMoveBeginとonMoveEndが呼び出されるのを回避 (バグ修正)
 * MovieClipController登録時のMovieClip初期状態をstopからplayに変更 (バグ修正)
 * onClick以外のonAbc系のイベントが呼ばれた回数をabcCountとして取得する変数を追加 (機能追加)
 * mouseCursorStateを廃止して、showMouseCursor / hideMouseCursor関数を追加 (機能廃止 / 機能追加)
 * MovieClipのループ再生モード / 一回再生モードを切り替えるためのmcLoop / mcNoLoop関数を追加 (機能追加)

* 2.0.2
 * EnterFrameIntegraterのlistener関数実行中にリスナー削除がおこなわれた場合にnullエラーが出るバグを修正 (バグ修正)
 * 現行の学生グループに対する挙動の整合性を優先させるため、MovieClipController登録時の初MovieClip期状態をplayからstopに変更

* 2.0.1
 * MovieClipController登録時の初MovieClip期状態をstopからplayに変更 (バグ修正)

* 2.0.0
 * 1stリリース

# 作者
Yukiya Okuda ([@alumican](https://github.com/alumican))
