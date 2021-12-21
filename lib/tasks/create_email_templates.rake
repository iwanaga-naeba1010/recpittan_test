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

    EmailTemplate.find_or_create_by(
      id:  9,
      explanation: 'PT:パスワード再発行',
      body: "えぶりプラスをご利用いただきありがとうございます。\n

パスワード再設定用のリンクを送付いたします。\n
下記のリンクより、変更をお願いいたします。\n

再発行URL\n
<%= link_to @url, @url %>\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: 'パスワード再設定のお知らせ',
      signature: '',
      kind: 8
    )

    EmailTemplate.find_or_create_by(
      id:  10,
      explanation: 'PT:相談開始',
      body: "<%= @user_name %> 様\n

えぶりプラスをご利用いただきありがとうございます。\n
<%= @facility_name %>から<%= @recreation.title %>のレクに相談・依頼が届きました。\n

下記リンクから内容をご確認ください。\n
※ページにアクセスするにはログインが必要です。\n
<%= link_to @url, @url %>\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: '施設から相談・依頼が届きました',
      signature: '',
      kind: 9
    )

    EmailTemplate.find_or_create_by(
      id:  11,
      explanation: 'PT:新規メッセージ',
      body: "<%= @user_name %> 様\n

えぶりプラスをご利用いただきありがとうございます。\n
<%= @facility_name %>からメッセージが届いています。\n

下記のリンクからメッセージをご確認ください。\n
※ページにアクセスするにはログインが必要です。\n
<%= link_to @url, @url %>\n

※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: '施設から新着メッセージが届きました',
      signature: '',
      kind: 10
    )

    EmailTemplate.find_or_create_by(
      id:  12,
      explanation: 'PT:正式依頼',
      body: "<%= @user_name %> 様\n

えぶりプラスをご利用いただきありがとうございます。\n

<%= @facility_name %>から正式依頼が届いています。\n
下記のリンクから内容をご確認ください。\n
※ページにアクセスするにはログインが必要です。\n
<%= link_to @url, @url %>\n

注意事項\n
・正式依頼は一度承認するとキャンセルができないためよくご確認いただきますようお願いいたします。\n
・正式依頼をお断りする場合、施設はなぜお断りをされたのか分からないため、その理由を施設にチャットで伝えるようにしましょう。\n
・材料費が発生するなど人数確認が必要なレクの場合、期日までに参加人数の確認の依頼をお願いいたします。\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: '施設から正式依頼が届きました',
      signature: '',
      kind: 11
    )

    EmailTemplate.find_or_create_by(
      id:  13,
      explanation: 'PT:終了報告拒否',
      body: "<%= @user_name %> 様\n

えぶりプラスをご利用いただきありがとうございます。\n

<%= @recreation.title %>の終了報告が施設様よりお断りされました。\n
施設様にお断りされた理由をチャットで伺いましょう。\n
施設様とメッセージ後、再度終了報告をお願い致します。\n

注意事項\n
・終了報告が施設様より承認されないと報酬が受け取れません。\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。",
      title: '終了報告がお断りされました',
      signature: '',
      kind: 12
    )

    EmailTemplate.find_or_create_by(
      id:  14,
      explanation: 'PT:終了報告承認',
      body: "<%= @user_name %> 様\n

えぶりプラスをご利用いただきありがとうございます。\n
<%= @recreation.title %> の終了報告が施設様より承認されました。\n
この案件は以上となります。お疲れ様でした！\n
次の案件をお待ちください。\n

振り込みについて\n
・報酬の受け取りは施設様が終了報告を承認してから翌々月末に行われます。土日祝日の場合次の営業日となります。\n


※このメールアドレスは送信専用です。返信をいただいてもご回答できませんのでご了承ください。\n",
      title: '終了報告がお断りされました',
      signature: '',
      kind: 13
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
