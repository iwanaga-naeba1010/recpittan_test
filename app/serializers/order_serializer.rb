class OrderSerializer
  def serialize_list(orders:)
    orders.map { |order| serialize(order: order) }
  end

  def serialize(order:)
    {
      id: order.id,
      expenses: order.expenses,
      transportation_expenses: order.transportation_expenses,
      additional_facility_fee: order.additional_facility_fee,
      number_of_people: order.number_of_people,
      number_of_facilities: order.number_of_facilities,
      price: order.price,
      material_price: order.material_price,
      total_price_for_customer: order.total_price_for_customer
    }
  end
end
