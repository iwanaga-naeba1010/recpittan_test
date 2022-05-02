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
#  end_at                  :datetime
#  expenses                :integer          default(0)
#  final_check_status      :integer
#  is_accepted             :boolean          default(FALSE)
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
class OrderSerializer
  def serialize_list(orders:)
    orders.map { |order| serialize(order: order) }
  end

  def serialize(order:)
    recreation = RecreationSerializer.new.serialize(recreation: order.recreation)
    {
      id: order.id,
      status: order.status,
      expenses: order.expenses,
      transportation_expenses: order.transportation_expenses,
      additional_facility_fee: order.additional_facility_fee,
      number_of_people: order.number_of_people,
      number_of_facilities: order.number_of_facilities,
      price: order.price,
      material_price: order.material_price,
      total_facility_price_for_customer: order.total_facility_price_for_customer,
      total_price_for_customer: order.total_price_for_customer,
      total_material_price_for_customer: order.total_material_price_for_customer,
      recreation: recreation
    }
  end
end
