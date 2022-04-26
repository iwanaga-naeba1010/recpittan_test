# frozen_string_literal: true

# == Schema Information
#
# Table name: recreations
#
#  id                      :bigint           not null, primary key
#  additional_facility_fee :integer          default(2000)
#  amount                  :integer
#  base_code               :string
#  borrow_item             :text
#  bring_your_own_item     :text
#  capacity                :integer
#  category                :integer          default("event"), not null
#  description             :text
#  extra_information       :text
#  flow_of_day             :text
#  flyer_color             :string
#  instructor_description  :text
#  instructor_image        :text
#  instructor_name         :string
#  instructor_position     :string
#  instructor_title        :string
#  is_online               :boolean          default(FALSE)
#  is_public               :boolean
#  is_public_price         :boolean          default(TRUE)
#  material_amount         :integer
#  material_price          :integer
#  minutes                 :integer
#  prefectures             :string           default([]), is an Array
#  price                   :integer
#  second_title            :string
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint           not null
#  youtube_id              :string
#
# Foreign Keys
#
#  recreations_user_id_fkey  (user_id => users.id)
#
FactoryBot.define do
  factory :recreation do
    user
    title { 'MyString' }
    second_title { 'MyString' }
    borrow_item { 'MyString' }
    bring_your_own_item { 'MyString' }
    extra_information { 'MyString' }
    flow_of_day { 'MyString' }
    minutes { 60 }
    price { 20000 }
    material_price { 1000 }
    amount { 10000 }
    material_amount { 500 }
    description { 'MyText' }
    youtube_id { '' }
    instructor_name { 'MyText' }
    instructor_title { 'MyText' }
    instructor_description { 'MyText' }
    is_public { true }
    instructor_image do
      ActionDispatch::Http::UploadedFile.new(
        filename: 'test.png',
        type: 'image/png',
        tempfile: File.open(Rails.root.join('spec/files/test.png'))
      )
    end
  end
end
