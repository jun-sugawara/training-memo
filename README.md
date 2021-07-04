# Training Memo
## アプリケーション概要
行った筋力トレーニング、及び体重・体脂肪の記録・確認ができるメモアプリケーションです。
## 機能一覧
- ユーザー登録機能  
- トレーニング記録機能  
- トレーニング編集・削除機能  
- トレーニング検索機能  
- MAX重量検索、表示機能  
- 体重、体脂肪記録機能  
- 体重、体脂肪編集・削除機能  
- 体重、体脂肪グラフ表示機能

## アプリケーションURL
https://trainingmemo.com

## チェック担当者様フロー
**チェック用にテストデータをご用意しております。下記の流れに沿ってご確認ください。**  
**日付選択のフォームでは、2021/06/01~2021/06/30の範囲をご指定ください**
1. ヘッダーのログインボタンよりTestアカウントにてログインしてください  
チェック用メールアドレス「**test@gmail.com**」※半角英数  
チェック用パスワード「**a11111**」※半角英数  
2. ヘッダーの「テストアカウント」をクリックしマイページへ遷移してください
3. マイページ内「トレーニングを確認する」「体重・体脂肪を確認する」ボタンより確認画面に遷移します。
4. それぞれの確認ページでは日付を選択し「確認する」ボタンを押すことでその日に行ったトレーニング・体重・体脂肪を確認することができます。  
5. トレーニング確認ページの「MAX重量を確認する」ボタンを押すことで、MAX重量確認ページに遷移します。種目を選択し、「確認する」ボタンを押すことで種目別のMAX重量を確認できます。  
6. 体重・体脂肪確認ページの「推移をグラフで確認する」ボタンを押すことでグラフページへ遷移します。日付を選択し「確認する」ボタンを押すことで入力された日付から１ヶ月（もしくは１週間）の推移をグラフで確認できます。
7. トレーニング・体重・体脂肪確認ページではデータの削除・編集が可能です。また、マイページから「トレーニングを記録する」「体重・体脂肪を記録する」ボタンから入力ページへ遷移します。必要に応じ、ご確認ください。

## 開発環境・使用技術
- 言語:HTML,CSS,Ruby,JavaScript,SQL  
- フレームワーク:Ruby on Rails  
- データベース:MySQL
- 本番環境:AWS EC2  
- デプロイ:Capistranoを用いた自動デプロイ 
- SSL:Route53,Certificate Manager,Application Load Balancerを用いたhttps化
- Rspecを用いた単体テスト及び結合テスト（計71項目）  
- レスポンシブ対応（PC・スマートフォン・タブレット端末）  
- rubocopを用いたコード整形  
- SQLを用いた日付・データの取得
- 投稿時・データ確認時、バリデーションを用いた日本語エラーメッセージ表示
- 非ログインユーザーのトップページリダイレクト処理
- includesメソッドを用いた排他処理
- 他ユーザーページへのアクセス時のトップページリダイレクト処理
- chartkickを用いたグラフ表示

## 作成背景  
パーソナルトレーナーとしての業務経験より、「結果が出ない」原因の１つとして数値確認をしないことがあると思っておりました。記録データを保存できて、それでいてシンプルで使いやすいサービスがあると便利だと思い、作成いたしました。ユーザーのモチベーションを挙げ、よりトレーニングをしてもらえるようなアプリケーションを作成したいと考えたことが作成背景でございます。

## こだわった部分
データの記録をする際に、使いやすい入力フォームを意識しました。具体的には、日付とトレーニング種目を選択してから次ページに遷移し、回数や重さ、セット数などは日付とトレーニング種目を選んでから送信できるようにいたしました。このように実装することで、ユーザーにとってわかりやすい入力フォームとなり、より使いやすいサービスになると考えました。また、ボタン配置は不要なボタンをできる限り排除し、ユーザーが直感的に操作できるような作りを心がけて実装してまいりました。

## 大変だった部分
chartkickを用いたグラフ表示にあたり、データを埋め込む処理に苦労しました。具体的には、コントローラー内のメソッドにSQLを用いて処理を実装しました。思い通りの動きになるよう、インターネットを用いて検索しながら実装するのに苦労いたしました。




## テーブル設計
[![Image from Gyazo](https://i.gyazo.com/5cbbfaf946e8a8660f35bc33742f7e45.png)](https://gyazo.com/5cbbfaf946e8a8660f35bc33742f7e45)

## デモ映像
### 体重・体脂肪差分の表示
選んだ日付と最新の日付との体重・体脂肪差分を表示します
[![Image from Gyazo](https://i.gyazo.com/c9f07cc868bff5590829e7dfec072388.gif)](https://gyazo.com/c9f07cc868bff5590829e7dfec072388)
### 体脂肪グラフ確認
選択した日付より１ヶ月分の数値をグラフ表示します ※１週間表示も可能です
[![Image from Gyazo](https://i.gyazo.com/7502e0e30ff8b909cbad750ed57dba3b.gif)](https://gyazo.com/7502e0e30ff8b909cbad750ed57dba3b)
### 日別筋トレ一覧表示確認
選択した日付の筋トレ履歴を一覧で確認できます
[![Image from Gyazo](https://i.gyazo.com/41911962a7531954d7e9ae6405ee17bd.gif)](https://gyazo.com/41911962a7531954d7e9ae6405ee17bd)
### MAX重量確認
選択された種目の最大重量と、達成日を確認できます
[![Image from Gyazo](https://i.gyazo.com/786c06560d58a5d8f1cb022022cb5637.gif)](https://gyazo.com/786c06560d58a5d8f1cb022022cb5637)