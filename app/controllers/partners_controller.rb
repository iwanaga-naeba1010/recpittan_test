# frozen_string_literal: true

class PartnersController < Partners::ApplicationController
  def index
    is_held = params[:is_held]&.to_s&.downcase == 'true'

    unless is_held
      @orders = current_user.recreations.map do |rec|
        [rec.orders.is_not_held, rec.orders.start_at_is_blank]
      end.flatten.uniq
      return
    end

    @orders = current_user.recreations.map { |rec| rec.orders.is_held }.flatten.uniq
  end
end
