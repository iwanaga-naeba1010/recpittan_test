# frozen_string_literal: true

class PartnersController < Partners::ApplicationController
  def index
    column = params[:column].presence || :start_at
    @is_accepted = params[:is_accepted]&.to_s&.downcase == 'true' || false
    rec_ids = current_user.recreations.pluck(:id)

    # TODO(okubo): model等に移行したい
    @orders = Order.where(
      recreation_id: rec_ids,
      is_accepted: @is_accepted
    ).order("#{column} asc NULLS LAST")
  end
end
