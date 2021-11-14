# frozen_string_literal: true

# == Schema Information
#
# Table name: recreations
#
#  id                  :bigint           not null, primary key
#  borrow_item         :text
#  bring_your_own_item :text
#  description         :text
#  extra_information   :text
#  flow_of_day         :text
#  minutes             :integer
#  price               :integer          default(0), not null
#  second_title        :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  partner_id          :bigint           not null
#  youtube_id          :string
#
# Indexes
#
#  index_recreations_on_partner_id  (partner_id)
#
# Foreign Keys
#
#  fk_rails_...  (partner_id => partners.id)
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
    description { 'MyText' }
    youtube_id { '' }
  end
end
