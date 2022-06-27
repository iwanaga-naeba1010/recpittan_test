# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :text
#  name        :string
#  position    :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Foreign Keys
#
#  profiles_user_id_fkey  (user_id => users.id)
#
FactoryBot.define do
  factory :profile do
    user
    name { 'MyString' }
    title { 'MyString' }
    description { 'MyText' }
    position { 'MyString' }
    image { Rack::Test::UploadedFile.new('spec/files/test.png', 'image/png') }
  end
end
