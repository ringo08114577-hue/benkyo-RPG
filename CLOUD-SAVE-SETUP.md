# アカウント保存の設定（初回のみ）

このゲームは GitHub Pages だけではユーザーアカウントやクラウドDBを持てないため、Supabase Auth + Database を使ってアカウントごとのセーブを保存します。**この手順を完了するまでは、アカウント保存はまだ動きません。** 通常のブラウザ内セーブはそのまま使えます。

## 1. Supabase プロジェクトを作る

1. [Supabase Dashboard](https://supabase.com/dashboard) を開き、ログインまたはアカウントを作成します。
2. 「New project」からプロジェクトを作ります。
3. プロジェクトの準備が完了するまで待ちます。

## 2. セーブ用テーブルを作る

1. Supabase のプロジェクトで「SQL Editor」を開きます。
2. [supabase-setup.sql](https://github.com/ringo08114577-hue/benkyo-RPG/blob/main/supabase-setup.sql) を開き、ファイルのSQL全文をコピーします。
3. SQL Editorで新しいクエリを作り、コピーしたSQLを貼り付けて実行します。

このSQLは、ログイン中のユーザーが **自分の行だけ** 読み書きできるよう Row Level Security (RLS) を有効にします。

## 3. メールログインのリダイレクト先を設定

Supabase の Authentication 設定で、Site URL と Redirect URLs に次の公開URLを登録します。

- Site URL: `https://ringo08114577-hue.github.io/benkyo-RPG/`
- Redirect URL: `https://ringo08114577-hue.github.io/benkyo-RPG/`

メール確認を有効にしている場合、アカウント登録後に確認メールのリンクを開いてください。

## 4. ゲームとSupabaseを接続

1. [勉強RPG](https://ringo08114577-hue.github.io/benkyo-RPG/) を開き、画面下の「その他」を開きます。
2. Supabaseの Project URL と **Publishable key**（または古い形式の anon public key）を入力します。
3. 「接続設定を保存」を押します。
4. メールアドレスとパスワードを入力し、「新しいアカウントを作成」を押すか、すでに作成したアカウントで「ログイン」を押します。

Project URL と Publishable/anon public key はブラウザ向けの公開情報です。**`service_role` キーや secret key は絶対にゲームに入力・公開しないでください。** セーブデータの保護は、SQLで設定するRLSポリシーが行います。

## 5. セーブを確認

ログイン後は、ゲーム内の変更をローカル保存し、少し待ってからクラウドにも自動保存します。「その他」画面で「クラウド保存済み」と表示されたことを確認できます。「今すぐクラウド保存」も使えます。

すでにクラウドデータがあるアカウントにログインした場合：
- OK：クラウドデータを今の端末に読み込む
- キャンセル：この端末のデータでクラウドデータを上書きする

別端末では、同じアカウントでログインしてください。初回は、既存セーブをどちらから引き継ぐかの選択に注意してください。念のため、ゲームの「バックアップを書き出す」も定期的に使ってください。

## トラブル時

- 「relation game_saves does not exist」などが出る: 2のSQLが実行されていない可能性があります。
- ログイン後にメール確認を求められる: メールの確認リンクを開いてからログインします。
- リダイレクトでエラーになる: 3の Site URL / Redirect URLs にGitHub PagesのURLを正確に登録したか確認します。
- 「クラウド保存に失敗」と出る: Project URL、Publishable/anon public key、SQL実行状態を確認してください。
- オフラインではログイン・クラウド保存は使えません。ローカル自動保存も残りますが、ブラウザデータの削除に備えてバックアップを保管してください。
