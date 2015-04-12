# Korvet

[吉里吉里Z](http://krkrz.github.io/)上で動作するノベルゲーム製作システムです。開発中のためまともに動作しません。



## 実行方法
実行前にsrc/フォルダのtjsファイルをコンパイルする必要があります。

コンパイルには[GNU M4](https://www.gnu.org/software/m4/)が必要です。ダウンロードしてパスの通っている場所に"m4.exe"を置いてください。
[Ruby](https://www.ruby-lang.org/ja/)の実行環境も必要です。こちらもインストールしてください。

"compile_debug.bat"を実行するとデバッグモード用のファイルをコンパイルします。
コンパイルされたファイルは"data/debug/"に入ります。

"compile_release.bat"を実行するとリリースモード用のファイルをコンパイルします。
コンパイルされたファイルは"data/release_intermediate/"及び"data/release/"に入ります。

"recompile.bat"を実行するとコンパイル後のファイルを全て削除してからデバッグ・リリース両方のファイルをコンパイルします。

"exec_debug.bat"を実行するとゲーム本体がデバッグモードで起動します。
"exec_release.bat"を実行するとゲーム本体がリリースモードで起動します。

公式の吉里吉里Zバイナリでは動作しません。
[フォークしているバージョン](https://github.com/sakano/krkrz)で動作確認しています。



## ライセンス
同梱の"LICENSE.txt"を参照してください
