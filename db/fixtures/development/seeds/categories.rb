# frozen_string_literal: true

Tag.seed do |s|
  s.id = 1
  s.name = '音楽'
  s.kind = :category
  s.text = "音楽療法\n和太鼓演奏など"
  s.image = Rails.root.join("db/fixtures/images/music.png").open
end

Tag.seed do |s|
  s.id = 2
  s.name = '健康'
  s.kind = :category
  s.text = "体操、フラダンス\n嚥下予防など"
  s.image = Rails.root.join("db/fixtures/images/helth.png").open
end

Tag.seed do |s|
  s.id = 3
  s.name = '趣味'
  s.kind = :category
  s.text = "書道\n囲碁など"
  s.image = Rails.root.join("db/fixtures/images/hobby.png").open
end

Tag.seed do |s|
  s.id = 4
  s.name = '創作'
  s.kind = :category
  s.text = "生花\nガラス工芸など"
  s.image = Rails.root.join("db/fixtures/images/sosaku.png").open
end

Tag.seed do |s|
  s.id = 5
  s.name = '旅行'
  s.kind = :category
  s.text = "エステ\nネイルなど"
  s.image = Rails.root.join("db/fixtures/images/trip.png").open
end

Tag.seed do |s|
  s.id = 6
  s.name = '飲食'
  s.kind = :category
  s.text = "マグロ解体ショー\n和菓子作りなど"
  s.image = Rails.root.join("db/fixtures/images/food.png").open
end

Tag.seed do |s|
  s.id = 7
  s.name = 'イベント'
  s.kind = :category
  s.text = "大道芸\n落語など"
  s.image = Rails.root.join("db/fixtures/images/event.png").open
end


Tag.seed do |s|
  s.id = 8
  s.name = 'その他'
  s.kind = :category
  s.text = "アニマルセラピー\n写真撮影など"
  s.image = Rails.root.join("db/fixtures/images/other.png").open
end
