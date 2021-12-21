require 'csv'

# rake import:email_templates
namespace :import do
  task email_templates: :environment do
  puts "start to create email_templates data"
  begin
    EmailTemplate.find_or_create_by(
      id:  1,
      explanation: '顧客:メールアドレス認証',
      body: "えぶりプラスにご登録いただきありがとうございます。\n
本メールは、ご登録いただいたメールアドレスが正しいかどうか確認するための認証用メールです。\n
メール認証を完了するために、下記のリンクからえぶりプラスにアクセスをお願いいたします。\n
<%= link_to confirmation_url(@resource, confirmation_token: @token), confirmation_url(@resource, confirmation_token: @token) %>\n
      \n
      \n
※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください",
      title: 'メールアドレス認証のご確認の連絡',
      signature: '',
      kind: 0
    )

    EmailTemplate.find_or_create_by(
      id:  2,
      explanation: '顧客:パスワード再発行',
      body: "<%= @user_name %> 様\n

えぶりプラスをご利用いただきありがとうございます。\n

パスワード再設定用のリンクを送付いたします。\n
下記のリンクより、変更をお願いいたします。\n
再発行リンク\n
<%= link_to @url, @url %>\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: 'パスワード再設定のお知らせ',
      signature: '',
      kind: 1
    )

    EmailTemplate.find_or_create_by(
      id:  3,
      explanation: '顧客:相談開始',
      body: "<%= @user_name %>  様\n

えぶりプラスをご利用いただきありがとうございます。\n
<%= @recreation.title %> の相談・依頼が開始されました。\n
      \n
下記のリンクからパートナーとチャットができます。\n
ご要望をパートナーに伝えましょう。\n
※チャットページにアクセスするにはログインが必要です。\n
<%= link_to @url, @url %>\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: '相談・依頼が開始されました',
      signature: '',
      kind: 2
    )

    EmailTemplate.find_or_create_by(
      id:  4,
      explanation: '顧客:新規メッセージ',
      body: "<%= @user_name %>  様\n

えぶりプラスをご利用いただきありがとうございます。\n
ご相談中のレク<%= @recreation.title %>のパートナーからメッセージが届いています。\n

下記のリンクからメッセージをご確認ください。\n
※チャットページにアクセスするにはログインが必要です。\n
<%= link_to @url, @url %>\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: '新着メッセージが届きました',
      signature: '',
      kind: 3
    )

    EmailTemplate.find_or_create_by(
      id:  5,
      explanation: '顧客:正式依頼_PTが承認',
      body: "<%= @user_name %> 様\n

えぶりプラスをご利用いただきありがとうございます。\n
正式依頼した<%= @recreation.title %>がパートナー様より承認されました。\n
承認されたためレクの開催が決まりました。\n
開催日を楽しみに待ちましょう\n

レク詳細ページのリンクはこちら\n
<%= link_to @url, @url %>\n

注意事項\n
・承認後、レクをキャンセルする事はできません。\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: 'パートナー様が正式依頼を承認されました',
      signature: '',
      kind: 4
    )

    EmailTemplate.find_or_create_by(
      id:  6,
      explanation: '顧客:正式依頼_PTが拒否',
      body: "<%= @user_name %>様\n

えぶりプラスをご利用いただきありがとうございます。\n
正式依頼した<%= @recreation.title %>がパートナー様よりお断りされました。\n
お断りされた理由をパートナー様に伺ってみましょう。\n

チャットページのリンクはこちら\n
<%= link_to @url, @url %>\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: 'パートナー様が正式依頼をお断りされました',
      signature: '',
      kind: 5
    )

    EmailTemplate.find_or_create_by(
      id:  7,
      explanation: '顧客:終了報告投稿',
      body: "<%= @user_name %> 様\n

えぶりプラスをご利用いただきありがとうございます。\n
開催した<%= @recreation.title %>についてパートナーから終了報告のご確認依頼が届きました。\n

終了報告とは、パートナー様と施設様レクが開催された事や金額を確認し、請求書を発行するために行っております。\n
内容ご確認の上、承認をお願い致します。\n
承認後、確認いただいた内容の請求書を翌月５日までに発行致します。\n

終了報告確認ページへのリンクはこちら\n
<%= link_to @url, @url %>\n

注意事項\n
・終了報告を「お断り」する場合パートナー様がなぜお断りされたのか理解するために、なぜお断りをするのかその理由をチャットでお伝えください。\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: 'パートナー様から終了報告のご確認依頼が届きました',
      signature: '',
      kind: 6
    )

    EmailTemplate.find_or_create_by(
      id:  8,
      explanation: 'PT:メールアドレス認証',
      body: "えぶりプラスにご登録いただきありがとうございます。\n

本メールは、ご登録いただいたメールアドレスが正しいかどうか確認するための認証用メールです。\n

メール認証を完了するために、下記のリンクからえぶりプラスにアクセスをお願いいたします。\n
<%= link_to confirmation_url(@resource, confirmation_token: @token), confirmation_url(@resource, confirmation_token: @token) %>\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: 'メールアドレス認証のご確認の連絡',
      signature: '',
      kind: 7
    )



    puts "start to create email_templates data"
    begin
      EmailTemplate.create!(list)
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end
  end
end
