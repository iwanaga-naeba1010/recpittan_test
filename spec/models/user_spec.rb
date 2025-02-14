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
#  is_facility            :boolean          default(FALSE)
#  is_mfa_enabled         :boolean          default(FALSE), not null
#  is_partner             :boolean          default(FALSE)
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  manage_company_code    :string
#  memo                   :string
#  mfa_authenticated_at   :datetime
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
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_db_column(:is_mfa_enabled).of_type(:boolean).with_options(default: false, null: false) }
  it { is_expected.to have_db_column(:mfa_authenticated_at).of_type(:datetime).with_options(null: true) }
  it { is_expected.to have_db_column(:is_partner).of_type(:boolean).with_options(null: true) }
  it { is_expected.to have_db_column(:is_facility).of_type(:boolean).with_options(null: true) }
  it { is_expected.to have_db_column(:manage_company_code).of_type(:string).with_options(null: true) }

  it 'includes Devise timeoutable module' do
    expect(User.devise_modules).to include(:timeoutable)
  end

  it 'times out after 24 hours of inactivity' do
    last_access_time = 25.hours.ago
    expect(user.timedout?(last_access_time)).to be true
  end

  it 'does not time out before 24 hours' do
    last_access_time = 23.hours.ago
    expect(user.timedout?(last_access_time)).to be false
  end
end
