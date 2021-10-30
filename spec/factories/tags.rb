# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  image      :text
#  kind       :integer
#  name       :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :tag do
    name { 'MyString' }
    kind { 1 }
    text { '' }
  end
end
