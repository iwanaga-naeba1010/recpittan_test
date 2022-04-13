# frozen_string_literal: true

# rubocop:disable Style/HashLikeCase
def str_to_num(category)
  case category
  when 'イベント'
    :event
  when '創作'
    :work
  when '音楽'
    :music
  when '健康'
    :health
  when '旅行'
    :travel
  when '趣味'
    :hobby
  when '食べ物'
    :food
  when 'その他'
    :other
  end
end
# rubocop:enable Style/HashLikeCase

namespace :copy_category do
  task run: :environment do
    recreations = Recreation.all

    recreations.each do |rec|
      category = str_to_num(rec.tags.categories&.first&.name)
      next if category.blank?

      rec.update(category: category)
    end
  end
end
