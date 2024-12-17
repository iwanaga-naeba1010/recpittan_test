# frozen_string_literal: true

module OrdersHelper
  def sort_orders_options
    Order.sort_order.values.map do |v|
      [I18n.t("enumerize.order.sort_orders.#{v}"), v]
    end
  end
end
