# frozen_string_literal: true

namespace :update_held_order do
  task run: :environment do
    set_default_url_options

    Order.find_each do |order|
      next if order&.start_at.blank?

      if order.start_at <= Time.current && order.status == :waiting_for_an_event_to_take_place
        order.update(status: :unreported_completed)
        PartnerCompleteReportMailer.notify(order:).deliver_later
      end
    end
  end

  def set_default_url_options
    domain = ENV.fetch('DOMAIN')
    return if domain.blank?

    Rails.application.routes.default_url_options[:host] = domain
    ActionMailer::Base.default_url_options[:host] = domain
  end
end
