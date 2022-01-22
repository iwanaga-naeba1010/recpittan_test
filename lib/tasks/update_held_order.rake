namespace :update_held_order do
  task run: :environment do
    Order.all.each do |order|
      next if order&.start_at.blank?

      if order.start_at <= Time.current && order.status == :waiting_for_an_event_to_take_place
        order.update(status: :unreported_completed)
      end
    end
  end
end
