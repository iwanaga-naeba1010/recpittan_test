# frozen_string_literal: true

module OrdersHelper
  def order_sort_order_options
    Order.sort_orders.map do |key, _value|
      [I18n.t("order.sort_orders.#{key}"), key.to_s]
    end
  end
end
