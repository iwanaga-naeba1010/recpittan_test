# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  city             :string
#  number_of_people :integer
#  order_type       :integer
#  prefecture       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recreation_id    :bigint           not null
#  user_id          :bigint           not null
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

  enumerize :order_type, in: { consult: 0, order: 1 }, default: 0
end
