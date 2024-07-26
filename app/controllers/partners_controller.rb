# frozen_string_literal: true

class PartnersController < Partners::ApplicationController
  # rubocop:disable Metrics/AbcSize
  def index
    sort_order = params[:sort_order] || :newest
    is_accepted = params[:is_accepted]&.to_s&.downcase == 'true' || false
    @recreations = current_user.recreations
    rec_ids = params[:recreation_id].presence || @recreations.pluck(:id)
    user_id = params[:user_id].presence
    start_date = params[:start_date].present? ? params[:start_date].to_date.beginning_of_day : nil
    end_date = params[:end_date].present? ? params[:end_date].to_date.end_of_day : nil

    @orders = Order.includes([:user, :recreation])
                   .by_recreation_id(rec_ids)
                   .where(is_accepted:)
                   .where(is_open: true)
                   .by_date_range(start_date, end_date)
                   .sorted_by(sort_order)

    @orders = @orders.by_user_id(user_id) if user_id.present?
    @customers = @orders.map(&:user)
  end
  # rubocop:enable Metrics/AbcSize
end
