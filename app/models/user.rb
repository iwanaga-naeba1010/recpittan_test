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
# Foreign Keys
#
#  users_company_id_fkey  (company_id => companies.id)
#
class User < ApplicationRecord
  include Ransackable
  extend Enumerize

  # Include default devise modules. Others available are:
  # :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :lockable,
         :timeoutable

  enumerize :role, in: { customer: 0, partner: 1, admin: 2, cs: 3 }, default: 0
  enumerize :approval_status, in: { unapproved: 0, approved: 1 }, default: 0
  enumerize :manage_company_code, in: { EP: 0, WB: 1, RP: 2 }, default: 2

  # TODO: role == userの場合、の条件加えたい
  belongs_to :company, optional: true, class_name: 'Company'
  accepts_nested_attributes_for :company, allow_destroy: true
  has_one :invoice_information, dependent: :destroy, class_name: 'InvoiceInformation'
  has_many :recreations, dependent: :destroy, class_name: 'Recreation'
  has_many :orders, dependent: :destroy, class_name: 'Order'
  has_many :chats, dependent: :destroy, class_name: 'Chat'
  has_many :profiles, dependent: :destroy, class_name: 'Profile'
  has_many :user_memos, dependent: :destroy, class_name: 'UserMemo'
  has_many :favorite_recreations, dependent: :destroy, class_name: 'FavoriteRecreation'
  has_many :favorited_recreations, through: :favorite_recreations, source: :recreation, class_name: 'Recreation'
  has_many :user_recreation_plans, dependent: :destroy, class_name: 'UserRecreationPlan'
  has_many :recreation_plans, through: :user_recreation_plans, class_name: 'RecreationPlan'
  has_one :bank_account, dependent: :destroy, class_name: 'BankAccount', inverse_of: :user
  has_one :partner_info, dependent: :destroy, class_name: 'PartnerInfo', inverse_of: :user
  accepts_nested_attributes_for :partner_info, allow_destroy: true

  scope :customers, -> { where(role: :customer) }

  validates :password, password_complexity: true, if: -> { password.present? }

  def facility_name
    company&.facility_name
  end

  # NOTE: deviseの認証が発火した時に動く。
  def after_confirmation
    # Do something...
    AfterConfirmationMailer.notify(user: self).deliver_now
  end

  # passwordなしで保存できるようにする
  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

  # unlockable なユーザーか判定
  def lockable?
    failed_attempts >= Devise.maximum_attempts
  end

  # ロック解除メソッド
  def unlock!
    update!(failed_attempts: 0, locked_at: nil, unlock_token: nil)
  end
end
