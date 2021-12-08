# == Schema Information
#
# Table name: email_templates
#
#  id          :bigint           not null, primary key
#  body        :text
#  explanation :string
#  signature   :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :email_template do
    
  end
end
