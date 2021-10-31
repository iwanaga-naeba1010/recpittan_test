# frozen_string_literal: true

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
