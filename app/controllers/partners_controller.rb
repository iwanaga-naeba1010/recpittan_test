# frozen_string_literal: true

class PartnersController < Partners::ApplicationController
  def index
    is_accepted = params[:is_accepted]&.to_s&.downcase == 'true'

    unless is_accepted
      @orders = current_user.recreations.map do |rec|
        rec.orders.not_accepted_by_partner
      end.flatten.uniq
      return
    end

    @orders = current_user.recreations.map { |rec| rec.orders.accepted_by_partner }.flatten.uniq
  end
end
