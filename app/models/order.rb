# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  additional_facility_fee :integer          default(0)
#  amount                  :integer          default(0)
#  building                :string
#  city                    :string
#  contract_number         :string
#  coupon_code             :string
#  end_at                  :datetime
#  expenses                :integer          default(0)
#  final_check_status      :integer
#  is_accepted             :boolean          default(FALSE)
#  is_open                 :boolean          default(TRUE), not null
#  material_amount         :integer          default(0)
#  material_price          :integer          default(0)
#  memo                    :string
#  number_of_facilities    :integer
#  number_of_people        :integer
#  prefecture              :string
#  price                   :integer          default(0)
#  start_at                :datetime
#  status                  :integer
#  street                  :string
#  support_price           :integer          default(0)
#  transportation_expenses :integer          default(0)
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
  include Ransackable
  extend Enumerize

  belongs_to :user, class_name: 'User'
  belongs_to :recreation, class_name: 'Recreation'

  has_many :chats, dependent: :destroy, class_name: 'Chat'

  has_many :order_memos, dependent: :destroy, class_name: 'OrderMemo'
  accepts_nested_attributes_for :order_memos, allow_destroy: true

  has_many :order_dates, dependent: :destroy, class_name: 'OrderDate'
  accepts_nested_attributes_for :order_dates

  has_one :report, dependent: :destroy, class_name: 'Report'
  accepts_nested_attributes_for :report, allow_destroy: true

  has_one :zoom, dependent: :destroy, class_name: 'Zoom'
  accepts_nested_attributes_for :zoom, allow_destroy: true

  delegate :title, :price, :minutes, :instructor_name, :capacity, :kind, to: :recreation, prefix: true, allow_nil: true
  delegate :status, :body, to: :report, prefix: true, allow_nil: true
  delegate :url, to: :zoom, prefix: true, allow_nil: true
  delegate :kind, to: :recreation, prefix: true, allow_nil: true

  enumerize :status, in: {
    in_progress: 10, waiting_for_a_reply_from_partner: 20, waiting_for_a_reply_from_facility: 30,
    facility_request_in_progress: 40, request_denied: 50, waiting_for_an_event_to_take_place: 60,
    unreported_completed: 70, final_report_admits_not: 80, finished: 200,
    invoice_issued: 210, paid: 220, canceled: 400, travled: 500
  }, default: 10

  enumerize :final_check_status, in: {
    not_send: 0, sent: 1, checked: 2
  }, default: 0

  enumerize :sort_order, in: { newest: 0, chat_desc: 1, event_date: 2 }, default: :newest

  # controller のparamsに追加するため
  attribute :title # まずは相談したい、のメッセージ部分
  attribute :message
  attribute :tags

  before_save :switch_status_before_save

  scope :by_recreation_id, ->(recreation_id) { where(recreation_id:) }
  scope :by_user_id, ->(user_id) { where(user_id:) }
  scope :by_date_range, ->(start_date, end_date) {
    if start_date && end_date
      where(start_at: start_date..end_date)
    elsif start_date
      where(start_at: start_date..)
    elsif end_date
      where(start_at: ..end_date)
    end
  }
  scope :order_asc, -> { includes(:chats).order('chats.created_at asc') }
  scope :sorted_by, ->(sort_order) {
    case sort_order.to_sym
    when :newest
      order(created_at: :desc)
    when :chat_desc
      includes(:chats).order('chats.created_at desc')
    when :event_date
      order(start_at: :asc)
    end
  }

  validates :price, :material_price, :amount,
            :material_amount, :expenses, :transportation_expenses,
            :additional_facility_fee, presence: true

  # validates :start_at, :end_at, presence: true, if: -> { status != :in_progress }

  # validate :reject_empty_date # TODO(okubo): React化が完了したら削除する
  # validate :restrict_start_at, if: -> { status == :facility_request_in_progress }

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
  def switch_status_before_save
    # NOTE: 終了している案件のstatusを変更しても処理は挟まない
    if self.status.finished? || self.status.invoice_issued? || self.status.paid? || self.status.canceled? || self.status.travled?
      return self
    end

    # NOTE: 完了したがレポート書いていないこと
    if self.start_at.present? && self.is_accepted && (Time.current >= self.start_at) && self.report.blank?
      self.status = :unreported_completed
      # NOTE(okubo): メールはtaskに移動
      return self
    end

    # NOTE: 完了してレポート書いたけど、施設が承認していないこと
    # rubocop:disable Layout/LineLength
    if self.start_at.present? && self.is_accepted && (Time.current >= self.start_at) && self.report.present? && !self.report&.status&.accepted?
      self.status = :final_report_admits_not
      return self
    end

    # NOTE: 完了してレポート書いて、施設が承認してfinishな状態
    if self.start_at.present? && self.is_accepted && (Time.current >= self.start_at) && self.report.present? && self.report&.status&.accepted?
      self.status = :finished
      return self
    end
    # rubocop:enable Layout/LineLength

    if self.start_at.present? && !self.is_accepted
      self.status = :facility_request_in_progress
      return self
    end

    if self.start_at.present? && self.is_accepted
      self.status = :waiting_for_an_event_to_take_place
      return self
    end

    # NOTE: 最後のチャットに応じてstatus変更
    last_chat = self.chats.last
    return self if last_chat.blank?

    self.status = if last_chat.user.role.customer?
                    :waiting_for_a_reply_from_partner
                  elsif last_chat.user.role.partner?
                    :waiting_for_a_reply_from_facility
                  else
                    :in_progress
                  end
    self
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize

  # TODO: 残りの住所も入れれるようにする
  def full_address
    "〒#{zip} #{prefecture}#{city}#{street}#{building}"
  end

  def additional_facility_fee_for_partner
    # NOTE: エブリプラスが1000円を運営費用として取得するので、その金額
    additional_facility_fee - 1000
  end

  def zoom_cost
    return zoom&.price if zoom&.created_by&.admin?

    0
  end

  def expenses_for_partner
    # NOTE: エブリプラスが10%を運営費用として取得するのでその金額
    expenses * 0.9
  end

  def total_facility_price_for_customer
    if number_of_facilities.present?
      number_of_facilities * additional_facility_fee
    else
      0
    end
  end

  def total_facility_price_for_partner
    if number_of_facilities.present?
      number_of_facilities * additional_facility_fee_for_partner
    else
      0
    end
  end

  def total_material_price_for_customer
    if number_of_people.present?
      number_of_people * material_price
    else
      0
    end
  end

  def total_material_price_for_partner
    if number_of_people.present?
      number_of_people * material_amount
    else
      0
    end
  end

  def total_price_for_customer
    price + total_material_price_for_customer + transportation_expenses + expenses + total_facility_price_for_customer + support_price
  end

  def total_price_for_partner
    # NOTE(okubo): zoom_priceは運営が入力する
    amount + total_material_price_for_partner + transportation_expenses + expenses_for_partner +
      total_facility_price_for_partner - zoom_cost
  end

  def desired_time
    return '' if start_at.blank?

    date = start_at.strftime('%Y年%m月%d日')
    start_time = start_at.strftime('%H:%M')
    end_time = end_at&.strftime('%H:%M')

    # TODO: エラーハンドリング入れた方が良いかも
    "#{date} #{start_time} ~ #{end_time}"
  end
end
