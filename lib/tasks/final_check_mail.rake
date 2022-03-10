# frozen_string_literal: true

namespace :final_check_mail do
  task run: :mail_send do
    # Order.all.each do |order|
    Order.where(final_check_status: :not_mail_send, start_at: Time.current..3.days.since.end_of_day).each do |order|
      next if order&.start_at.blank?

      order.update(final_check_status: :mail_send)
      FinalCheckMailer.notify(order).deliver_now
      # if Time.current <= order.start_at && order.start_at <= 3.day.since && order.final_check_status == :not_mail_send
      #   order.update(final_check_status: :mail_send)
      #   FinalCheckMailer.notify(order).deliver_now
      # end
    end
  end
end
