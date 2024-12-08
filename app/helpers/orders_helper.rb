# frozen_string_literal: true

module OrdersHelper
  def sort_orders_options
    Order.sort_order.values do |key, _|
      [I18n.t("order.sort_orders.#{key}"), key.to_s]
    end
  end
end
