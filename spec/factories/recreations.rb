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
#  is_public_price         :boolean          default(TRUE)
#  kind                    :integer          default("visit"), not null
#  material_amount         :integer
#  material_price          :integer
#  memo                    :string
#  minutes                 :integer
#  number_of_past_events   :integer          default(0), not null
#  price                   :integer
#  second_title            :string
#  status                  :integer          default("unapplied"), not null
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint           not null
#  youtube_id              :string
#
# Indexes
#
#  index_recreations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :recreation do
    user
    title { 'MyString' }
    second_title { 'MyString' }
    price { 20000 }
    amount { 10000 }
    material_price { 1000 }
    material_amount { 500 }
    minutes { 60 }
    description { 'MyText' }
    flow_of_day { 'MyString' }
    borrow_item { 'MyString' }
    bring_your_own_item { 'MyString' }
    extra_information { 'MyString' }
    youtube_id { '' }
    capacity { 5 }
    status { 'unapplied' }
    category { 'event' }
    kind { 'online' }
  end
end
