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
  factory :partner do
    name { "MyString" }
    title { "MyString" }
    description { "MyText" }
    user { nil }
  end
end
