# frozen_string_literal: true

Tag.seed do |s|
  s.id = 9
  s.name = 'イベント'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 10
  s.name = 'オンライン'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 11
  s.name = '話題性あり'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 12
  s.name = '行事'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 13
  s.name = 'スタッフも楽しい'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 14
  s.name = '作品お持ち帰り'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 15
  s.name = '予防・リハビリ'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 16
  s.name = 'プロ'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 17
  s.name = '人気'
  s.kind = :event
end

Tag.seed do |s|
  s.id = 18
  s.name = 'スタッフおすすめ'
  s.kind = :event
end
