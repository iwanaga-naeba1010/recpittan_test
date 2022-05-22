# frozen_string_literal: true

# == Schema Information
#
# Table name: email_templates
#
#  id          :bigint           not null, primary key
#  body        :text
#  explanation :string
#  kind        :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :email_template do
    explanation { 'MyText' }
    title { 'MyText' }
    body { 'MyText' }
    kind { 1 }
  end
end
