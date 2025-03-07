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
#  facility_flag          :boolean          default(FALSE)
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  manage_company_code    :string
#  memo                   :string
#  mfa_authenticated_at   :datetime
#  mfa_enabled_flag       :boolean          default(FALSE), not null
#  partner_flag           :boolean          default(FALSE)
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
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do
  factory :user do
    role { :customer }
    email { FFaker::Internet.email }
    password { 'Aa1!aaaa' }
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

  trait :partner_with_orders do
    start_date = Time.current.last_month.beginning_of_month
    end_date = Time.current.last_month.end_of_month
    max_order = 3

    after(:create) do |user|
      user.update(role: :partner, username: 'hogehoge')
      rec = create(:recreation, user:, status: 'published', kind: 'visit')
      create(:profile, user:)
      create(:bank_account, user:, invoice_number: '1234567')

      create_list(:order, max_order, recreation: rec) do |order|
        order.update(start_at: rand(start_date..end_date))
      end
    end
  end
end
