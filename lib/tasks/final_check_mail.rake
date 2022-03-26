# frozen_string_literal: true

namespace :send_final_check_mail do
  task run: :environment do
    Order.where(
      final_check_status: :not_send,
      start_at: Time.current..3.days.since.end_of_day,
      status: :waiting_for_an_event_to_take_place
    ).each do |order|
      ActiveRecord::Base.transaction do
        order.update(final_check_status: :sent)
        FinalCheckMailer.notify(order).deliver_now
      end
    rescue StandardError => e
      logger.error e.message
    end
  end
end
