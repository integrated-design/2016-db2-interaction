# このリポジトリについて
多摩美術大学統合デザイン学科 2016年度「デザインベーシック Ⅱ インタラクション」の講義で使うプログラミング教材を格納しています。
**入力**と**出力**の関係を、アニメーションを通じて学べるように設計されています。
プログラミング言語として、ActionScriptに独自の改造を加えたものを使用します。
開発ツールとして、Adobe社のソフトウェア「Animate CC」を使用します。

# 最新版のダウンロード
[Download 2.0.3](https://github.com/integrated-design/2016-db2-interaction/raw/master/package/2.0.3.zip)

正常にコンパイルを通すために以下を守ること
* **flaファイルは新規作成せず、サンプルをコピーして使うこと**
* **flaファイルと同階層にframeworkフォルダを配置すること**

# 入力と出力
本プログラミング教材では、様々な入力と出力を組み合わせることで、インタラクティブなアニメーションを作ることを目的としています。
入力としてマウス、キーボード、サウンド（マイク）を用意しています。出力としては、様々なアニメーション操作方法を用意しています。
以下に具体的な入力と出力の実装方法を、順を追って説明します。

## 出力
用意した様々な命令によって、ステージに置かれているインスタンスを操作することができます。
カッコ()の中のaはステージに置かれているインスタンスの名前です。動かしたいインスタンスの名前に置き換えてください。

### mcPlay(a);
aを現在のフレームから再生します。

### mcReverse(a);
aを現在のフレームから逆再生します。

### mcStop(a);
aの再生を停止します。

### mcStopAndHide(a);
aの再生を停止して非表示にします。

### mcGotoAndPlay(a, frame);
aを指定したフレーム(frame)に移動して再生します。

### mcGotoAndReverse(a, frame);
aを指定したフレーム(frame)に移動して逆再生します。

### mcGotoAndStop(a, frame);
aを指定したフレーム(frame)に移動して停止します。

### mcNext(a);
aを1フレーム進めます。
最終フレームより先に進めると最初のフレームにループします。

### mcPrev(a);
aを1フレーム戻します。
最初のフレームより前に戻すと最後のフレームにループします。

### mcShow(a);
aを表示します。
mcPlay、mcReverse、mcGotoAndPlay、mcGotoAndReverse、mcNext、mcPrevを呼んだ場合には自動的に呼ばれます。

### mcHide(a);
aを非表示にします。
非表示にするだけなので、見えないだけで再生状態は保持されます。

### mcLoop(a);
aをループ再生モードにします。デフォルトでは既にループ再生モードになっています。

### mcNoLoop(a);
aを一回再生モードにします。mcPlay、mcReverse、mcGotoAndPlay、mcGotoAndReverse、mcNext、mcPrevで端のフレームに到達した場合にループ再生がされなくなります。


## 初期化
flaファイルにはsetupという関数が用意してあります。setupは起動直後に1度だけ処理されるので、アニメーションの初期状態（インスタンスaを止めて、インスタンスbをあらかじめ10フレームから再生しておく、など）を作ることができます。
```
//最初に一度だけ実行したい処理を書く
function setup() {
    //インスタンスaを止める
    mcStop(a);
    
    //インスタンスbを10フレームから再生する
    mcGotoAndPlay(b);
}
```

## 入力
入力とは、出力のきっかけとなる出来事です。「マウスをクリックしたら動き出す」「キーボードがたたかれたら表示する」などの「○○○たら〜〜〜」の○○○の部分です。

### マウス
TODO

### キーボード
TODO

### サウンド
TODO

### 回数
色々な関数（function）が呼び出された回数を使って、プログラムを書くことができます。
例えば、onClickが呼び出された回数（クリックされた回数）は、clickCountとして取得することができます。これによって「10回以上クリックされたらこのアニメーションを再生する」「クリックされる毎に2つのアニメーションaとbを交互に再生する」といった複雑な制御が可能となります。
関数と、それが呼び出された回数の対応関係は以下の通りです。

関数 | 回数
--- | ---
onClick | clickCount
onMoveBegin | moveBeginCount
onMove | moveCount
onMoveEnd | moveEndCount
onDrag | dragCount
onMouseDown | mouseDownCount
onMouseUp | mouseUpCount
onKeyDown | keyDownCount
onKeyUp | keyUpCount
onSoundBegin | soundBeginCount
onSound | soundCount
onSoundEnd | soundEndCount


## デバッグ
trace命令によって、実行中のプログラムの状態を知る事ができます。
任意の関数の中にtrace命令を書くことで、Animateの出力パネルに情報を表示します。
```
function onMove() { //何の関数でもよい
    trace(clickCount); //何かの回数を知りたいときはこのように書く
    trace("文字列"); //文字列を入れる場合は、ダブルクォーテーション"で囲む
    trace("クリックした回数は", clickCount, "回"); //カンマで区切って何個も一度に出力できる
}
```

# 動かないときのよくある原因
まずコンパイルエラーパネルをよく見ましょう。多くの場合、原因究明のヒントが書かれています。

* **「シンタックスエラー : ○○○」**
 * 原因 : 文法エラーです。以下を調べてみましょう。
  * 開くカッコ({[と、閉じるカッコ)}]の対応関係は完璧ですか？必ず開いたら閉じなければいけません。特に、onClickなどの関数を閉じ忘れている場合が多いです。
  * if文は正しく書けていますか？
  ```
  if (条件){
      条件を満たせばここが処理される;
  } else {
      条件を満たさなければここが処理される;
  }
  ```
 
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
