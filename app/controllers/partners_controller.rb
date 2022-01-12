# frozen_string_literal: true

class PartnersController < Partners::ApplicationController
  def index
    is_accepted = params[:is_accepted]&.to_s&.downcase == 'true'

    if is_accepted
      @orders = current_user.recreations.map { |rec| rec.orders.accepted_by_partner }.flatten.uniq
    else
      @orders = current_user.recreations.map do |rec|
        rec.orders.not_accepted_by_partner
      end.flatten.uniq
    end

    # NOTE(okubo): updated_atでsort
    @orders = @orders.to_a.sort do |a, b|
      b[:updated_at] <=> a[:updated_at]
    end
  end
end
