# frozen_string_literal: true

namespace :final_check_mail do
  namespace :batch do
    task mail_send: :environment do
      Order.where(final_check_status: :not_mail_send, start_at: Time.current..3.days.since.end_of_day).each do |order|
        order.update(final_check_status: :mail_send)
        FinalCheckMailer.notify(order).deliver_now
      end
    end
  end
end
