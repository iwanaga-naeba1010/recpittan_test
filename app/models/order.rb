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

  # TODO: number_of_peopleは削除 => messageに追加
  has_many :chats, dependent: :destroy

  has_many :order_memos, dependent: :destroy
  accepts_nested_attributes_for :order_memos, allow_destroy: true

  delegate :title, to: :recreation, prefix: true
  delegate :price, to: :recreation, prefix: true
  delegate :minutes, to: :recreation, prefix: true

  enumerize :status, in: { consult: 0, order: 1 }, default: 0

  # controller のparamsに追加するため
  attribute :title # まずは相談したい、のメッセージ部分
  attribute :dates
  attribute :message
  attribute :tags

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
end
