# frozen_string_literal: true

class PartnersController < Partners::ApplicationController
  def index
    @is_accepted = params[:is_accepted]&.to_s&.downcase == 'true' || false

    @orders = if @is_accepted
                current_user.recreations.map { |rec| rec.orders.accepted_by_partner }.flatten.uniq
              else
                current_user.recreations.map do |rec|
                  rec.orders.not_accepted_by_partner
                end.flatten.uniq
              end

    if params[:order].present?
      @orders = sort_by(orders: @orders, key: params[:order])
    end
  end

  # NOTE(okubo): ascで並ぶようにしてある
  private def sort_by(orders:, key:)
    orders.sort do |a, b|
      a[key] <=> b[key]
    end
  end
end
