# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  building                :string
#  city                    :string
#  date_and_time           :datetime
#  expenses                :integer
#  is_accepted             :boolean          default(FALSE)
#  number_of_people        :integer
#  prefecture              :string
#  status                  :integer
#  street                  :string
#  transportation_expenses :integer
#  zip                     :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  recreation_id           :bigint           not null
#  user_id                 :bigint           not null
#
# Foreign Keys
#
#  orders_recreation_id_fkey  (recreation_id => recreations.id)
#  orders_user_id_fkey        (user_id => users.id)
#
class Order < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :recreation

  has_many :chats, dependent: :destroy

  has_many :order_memos, dependent: :destroy
  accepts_nested_attributes_for :order_memos, allow_destroy: true

  has_one :report, dependent: :destroy

  delegate :title, to: :recreation, prefix: true
  delegate :price, to: :recreation, prefix: true
  delegate :minutes, to: :recreation, prefix: true

  enumerize :status, in: {
    in_progress: 10, waiting_for_a_reply_from_partner: 20, waiting_for_a_reply_from_facility: 30,
    facility_request_in_progress: 40, request_denied: 50, waiting_for_an_event_to_take_place: 60,
    unreported_completed: 70, final_report_admits_not: 80, finished: 200,
    invoice_issued: 210, paid: 220, canceled: 400, travled: 500
  }, default: 10

  # controller のparamsに追加するため
  attribute :title # まずは相談したい、のメッセージ部分
  attribute :dates
  attribute :message
  attribute :tags

  before_save :switch_status_befire_save

  def switch_status_befire_save
    # NOTE: 終了している案件のstatusを変更しても処理は挟まない
    if self.status.finished? || self.status.invoice_issued? || self.status.paid? || self.status.canceled? || self.status.travled?
      return self
    end

    # NOTE: 完了したがレポート書いていないこと
    if self.date_and_time.present? && self.is_accepted && (Time.current >= self.date_and_time) && self.report.blank?
      self.status = :unreported_completed
      return self
    end

    # NOTE: 完了してレポート書いたけど、施設が承認していないこと
    if self.date_and_time.present? && self.is_accepted && (Time.current >= self.date_and_time) && self.report&.present? && !self.report&.status.accepted?
      self.status = :final_report_admits_not
      return self
    end

    # NOTE: 完了してレポート書いて、施設が承認してfinishな状態
    if self.date_and_time.present? && self.is_accepted && (Time.current >= self.date_and_time) && self.report&.present? && self.report&.status.accepted?
      self.status = :finished
      return self
    end

    if self.date_and_time.present? && !self.is_accepted
      self.status = :facility_request_in_progress
      return self
    end

    if self.date_and_time.present? && self.is_accepted
      self.status = :waiting_for_an_event_to_take_place
      return self
    end

    # NOTE: 最後のチャットに応じてstatus変更
    last_chat = self.chats.last
    return self if last_chat.blank?

    if last_chat.user.role.customer?
      self.status = :waiting_for_a_reply_from_partner
      return self
    elsif last_chat.user.role.partner?
      self.status = :waiting_for_a_reply_from_facility
      return self
    else
      self.status = :in_progress
      return self
    end
  end

  # TODO: 残りの住所も入れれるようにする
  def full_address
    "〒#{zip} #{prefecture}#{city}#{street}#{building}"
  end

  def total_price
    regular_price = recreation.regular_price || 0
    regular_material_price = recreation.regular_material_price || 0
    order_transportation_expenses = transportation_expenses || 0
    order_expenses = expenses || 0

    regular_price + regular_material_price + order_transportation_expenses + order_expenses
  end

  def desired_time
    return '' if date_and_time.blank?

    date = date_and_time.strftime('%Y年%m月%d日')
    start_time = date_and_time.strftime('%H:%M')
    end_time = (date_and_time + recreation.minutes.minutes).strftime('%H:%M')

    # TODO: エラーハンドリング入れた方が良いかも
    "#{date} #{start_time} ~ #{end_time}"
  end
end
