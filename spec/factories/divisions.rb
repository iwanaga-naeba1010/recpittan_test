# frozen_string_literal: true

# == Schema Information
#
# Table name: divisions
#
#  id         :bigint           not null, primary key
#  classname  :string
#  code       :string
#  disporder  :integer
#  i18n_class :string
#  i18n_flag  :boolean
#  key        :string
#  memo       :text
#  valuedate  :datetime
#  valueint   :integer
#  valuetext  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :division do
    classname { 'MyString' }
    code { 'MyString' }
    valuetext { 'MyString' }
    valueint { 1 }
    valuedate { '2025-02-09 22:47:06' }
    disporder { 1 }
    memo { 'MyText' }
    key { 'MyString' }
    i18n_flag { false }
    i18n_class { 'MyString' }
  end
end
