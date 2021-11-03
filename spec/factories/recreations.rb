# == Schema Information
#
# Table name: partners
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :text
#  name        :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_partners_on_user_id  (user_id)
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
