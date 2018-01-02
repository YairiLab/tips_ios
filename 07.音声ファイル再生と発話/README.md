iOSで、文章読み上げと音声ファイルの再生をするサンプル。  
`AVSpeechSynthesizer`と、`AVAudioPlayer`を使えばできる。
AVFoundationを`import`する必要がある。

## 説明
AVSpeechSynthesizer中の`AVSpeechSynthesisVoice`のrateは、
1（最大）だとかなり早い。
0.5くらいで普通。

AVAudioPlayerで連射したいときは、
いくつか注意しないと期待したとおりに動かない。  
`stop()`の後`player.currentTime = 0`とやって再生位置を原点へ巻き戻す。  
また、再生時間が残り少ないときに次の再生命令が来たら、
今再生中のものは気にせず止め、次の再生を始めたほうが良い。
そうしないと遅れる。

上記２つの機能を
ViewControllerのボタンタップアクションから使うときのコードも付けた。