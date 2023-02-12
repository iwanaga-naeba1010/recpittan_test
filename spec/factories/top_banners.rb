# frozen_string_literal: true

# == Schema Information
#
# Table name: top_banners
#
#  id         :bigint           not null, primary key
#  end_date   :date             not null
#  image      :string           not null
#  start_date :date             not null
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :top_banner do
    image { Rack::Test::UploadedFile.new('spec/files/test.png', 'image/png') }
    url { 'MyString' }
    start_date { '2023-01-23' }
    end_date { '2023-01-23' }
  end
end
