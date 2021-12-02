# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  city                    :string
#  date_and_time           :datetime
#  expenses                :integer
#  is_accepted             :boolean          default(FALSE)
#  number_of_people        :integer
#  prefecture              :string
#  status                  :integer
#  transportation_expenses :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  recreation_id           :bigint           not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_orders_on_recreation_id  (recreation_id)
#  index_orders_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :recreation

  # TODO: number_of_peopleは削除 => messageに追加

  has_many :order_tags, dependent: :destroy
  has_many :tags, through: :order_tags

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

  # TODO: 残りの住所も入れれるようにする
  def full_address
    "#{prefecture}#{city}"
  end
end
