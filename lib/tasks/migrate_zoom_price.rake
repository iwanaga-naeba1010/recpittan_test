# frozen_string_literal: true

# NOTE(okubo): zoom_priceをzoom tableに移動するタスク
namespace :migrate_zoom_price do
  task run: :environment do
    Order.all.each do |order|
      next if order&.zoom_price.blank?

      order.create_zoom(price: order.zoom_price, created_by: :admin)
    end
  end
end
