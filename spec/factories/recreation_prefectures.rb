# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_prefectures
#
#  id            :bigint           not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Foreign Keys
#
#  recreation_prefectures_recreation_id_fkey  (recreation_id => recreations.id)
#
FactoryBot.define do
  factory :recreation_prefecture do
    recreation
    name { 'MyString' }
  end
end
