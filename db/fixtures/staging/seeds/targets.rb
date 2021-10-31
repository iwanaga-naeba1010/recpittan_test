# frozen_string_literal: true

Tag.seed do |s|
  s.id = 19
  s.name = 'ほぼ自立'
  s.kind = :target
end

Tag.seed do |s|
  s.id = 20
  s.name = '軽度認知症'
  s.kind = :target
end

Tag.seed do |s|
  s.id = 21
  s.name = '中重度認知症'
  s.kind = :target
end


Tag.seed do |s|
  s.id = 22
  s.name = '介護度2以下が多い'
  s.kind = :target
end

Tag.seed do |s|
  s.id = 23
  s.name = '介護度3以上が多い'
  s.kind = :target
end

Tag.seed do |s|
  s.id = 24
  s.name = '寝たきり'
  s.kind = :target
end

