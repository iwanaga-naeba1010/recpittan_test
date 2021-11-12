# frozen_string_literal: true

## 吉本
Recreation.seed do |s|
  s.id = 1
  s.title = 'オモロさ折り紙付きコンビＳＰＡＮ！によるお笑い介護レクリエーション'
  s.second_title = '笑って健康！折りがとう！'
  s.minutes = '60'
  s.description = "まず初めに、レクリエーション介護士２級の資格を持つ水本と一緒に画面を通して皆様でできる簡単介護レクリエーション(手遊び等)をします。その時にも参加者さんとコミュニケーションをとりながら進めて行きます。\n
そして、その後は折り紙講師の資格を持つマコトと一緒に皆様と折り紙をします。\n

折り紙も指先を使うので介護レクリエーションになります。\n

昔懐かしい折り紙を通じて脳の活性化、認知症予防をしてきます。\n

笑うことが健康に繋がりますので、とにかく皆様と笑いながら楽しい時間になれば、\n
と思っております。"
  s.flow_of_day = "5分　 挨拶\n
25分　簡単な介護レクリエーション(手遊びなど)\n
25分　折り紙レクリエーション\n
5分　 まとめ"
  s.borrow_item = "なし"
  s.bring_your_own_item = "なし"
  s.extra_information = "なし"
  s.user_id = 4
  s.youtube_id = 'RGR24pRw69Y'
end

# カテゴリー
RecreationTag.seed do |s|
  s.recreation_id = 1
  s.tag_id = 9
end

RecreationTag.seed do |s|
  s.recreation_id = 1
  s.tag_id = 10
end

# イベント種別
RecreationTag.seed do |s|
  s.recreation_id = 1
  s.tag_id = 9
end

RecreationTag.seed do |s|
  s.recreation_id = 1
  s.tag_id = 10
end

RecreationTag.seed do |s|
  s.recreation_id = 1
  s.tag_id =13
end

RecreationTag.seed do |s|
  s.recreation_id = 1
  s.tag_id = 14
end

# 利用者層
RecreationTag.seed do |s|
  s.recreation_id = 1
  s.tag_id = 19
end

RecreationTag.seed do |s|
  s.recreation_id = 1
  s.tag_id = 20
end

## 横丁
Recreation.seed do |s|
  s.id = 2
  s.title = '生中継！オンライン伊勢旅行'
  s.second_title = '～おはらい町おかげ横丁ツアー～'
  s.minutes = '40'
  s.description = "おかげ横丁、おはらい町から伊勢神宮まで生中継双方向で撮影をしながら、様々なお土産店にも入店。３～５種類のお土産付き！ 実際に施設に届くお土産を試食しながらの参加となるので旅行している気分に！ご要望があれば、買い物もツアー後に可能です。ツアー最後には、伊勢神宮内宮入り口近くにある足に良いとされる「足神さん」 と呼ばれる宇治神社でツアーフィニッシュ。"
  s.flow_of_day = "0:00～00:05 　ツアーのご紹介　コンダクター自己紹介\n

00:05～00:20 　おはらい町探索　お店やお土産について\n

お土産のご紹介\n

00:20～00:30　人力車体験・クイズ等\n

00:25～00:30　 内宮前\n

00:30～00:40 　足神神社\n

※スケジュールは変更する可能性がございます。"
  s.borrow_item = "なし"
  s.bring_your_own_item = "なし"
  s.extra_information = "【前田竜】\n

伊勢神宮内宮のお膝元で、生まれ育った日本一優しい物知りお兄さん。地元民ならではの地元トークを取り入れながら、ご案内をさせて頂きますので、是非遊びに来てください\n

【田中宏典】\n

日本各地を旅や営業を通して練り歩き、最後に辿り着いた伊勢の地。他の土地を知るからこそ、お伊勢さん特有の魅力をたっぷりとご案内させて頂きます！\n"
  s.user_id = 5
  s.youtube_id = 'Iwo6Bc--stY'
end

# カテゴリー
RecreationTag.seed do |s|
  s.recreation_id = 2
  s.tag_id = 9
end

RecreationTag.seed do |s|
  s.recreation_id = 2
  s.tag_id = 10
end

# イベント種別
RecreationTag.seed do |s|
  s.recreation_id = 2
  s.tag_id = 9
end

RecreationTag.seed do |s|
  s.recreation_id = 2
  s.tag_id = 10
end

RecreationTag.seed do |s|
  s.recreation_id = 2
  s.tag_id =13
end

RecreationTag.seed do |s|
  s.recreation_id = 2
  s.tag_id = 14
end

# 利用者層
RecreationTag.seed do |s|
  s.recreation_id = 2
  s.tag_id = 19
end

RecreationTag.seed do |s|
  s.recreation_id = 2
  s.tag_id = 20
end
