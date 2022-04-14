# frozen_string_literal: true

class OrderSerializer
  def serialize_list(orders:)
    orders.map { |order| serialize(order: order) }
  end

  def serialize(order:)
    recreation = RecreationSerializer.new.serialize(recreation: order.recreation)
    {
      id: order.id,
      status: order.status.value,
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
