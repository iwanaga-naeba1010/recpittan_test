# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    user
    name { 'MyString' }
    title { 'MyString' }
    description { 'MyText' }
    # TODO(okubo): 画像をテンプする
    image { 'MyText' }
    position { 'MyString' }
  end
end
