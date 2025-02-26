# frozen_string_literal: true

namespace :send_final_check_mail do
  task run: :environment do
    set_default_url_options

    Order.where(
      final_check_status: [:not_send, nil],
      start_at: Time.current..3.days.since.end_of_day,
      status: :waiting_for_an_event_to_take_place
    ).find_each do |order|
      ActiveRecord::Base.transaction do
        order.update!(final_check_status: :sent)
        FinalCheckMailer.notify(order:).deliver_later
      end
    rescue StandardError => e
      logger.error e.message
    end
  end

  def set_default_url_options
    domain = ENV.fetch('DOMAIN')
    return if domain.blank?

    Rails.application.routes.default_url_options[:host] = domain
    ActionMailer::Base.default_url_options[:host] = domain
  end
end
