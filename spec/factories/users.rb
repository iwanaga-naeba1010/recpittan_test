# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  approval_status        :integer          default("unapproved")
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  memo                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("customer"), not null
#  sign_in_count          :integer          default(0), not null
#  title                  :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string
#  username_kana          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint
#
# Foreign Keys
#
#  users_company_id_fkey  (company_id => companies.id)
#
FactoryBot.define do
  factory :user do
    role { :customer }
    email { FFaker::Internet.email }
    password { '11111111' }
    confirmed_at { Time.now.utc }
  end

  trait :with_customer do
    after(:create) do |user|
      company = create(:company)
      user.update(role: :customer, company:)
    end
  end

  # TODO(okubo): 後々削除
  trait :with_recreations do
    after(:create) do |user|
      user.update(role: :partner)
      rec = create(:recreation, user:, status: 'published')
      profile = create(:profile, user:)
      create(:recreation_profile, recreation: rec, profile:)
    end
  end

  trait :with_partner do
    after(:create) do |user|
      user.update(role: :partner)
      rec = create(:recreation, user:, status: 'published', kind: 'visit')
      profile = create(:profile, user:)
      create(:recreation_profile, recreation: rec, profile:)
    end
  end

  trait :with_admin do
    after(:create) do |user|
      user.update(role: :admin)
    end
  end

  trait :with_cs do
    after(:create) do |user|
      user.update(role: :cs)
    end
  end
end
