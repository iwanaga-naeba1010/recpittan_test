# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
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
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("customer"), not null
#  sign_in_count          :integer          default(0), not null
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
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  enumerize :role, in: { customer: 0, partner: 1, admin: 2, cs: 3 }, default: 0

  # TODO: role == userの場合、の条件加えたい
  belongs_to :company, optional: true
  accepts_nested_attributes_for :company, allow_destroy: true

  has_many :recreations, dependent: :destroy

  has_many :orders, dependent: :destroy

  has_many :chats, dependent: :destroy

  scope :customers, -> { where(role: :customer) }

  # NOTE: deviseの認証が発火した時に動く。
  def after_confirmation
    # Do something...
    AfterConfirmationMailer.notify(self).deliver_now
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
end
