class PartnersController < Partners::ApplicationController
  def index
    column = params[:column].presence || :start_at
    order = params[:order].presence || :desc
    @is_accepted = params[:is_accepted]&.to_s&.downcase == 'true' || false
    @is_open = params[:is_open]&.to_s&.downcase == 'true' || false
    @recreations = current_user.recreations

    if params[:recreation_id].present?
      rec_ids = params[:recreation_id]
    else
      rec_ids = current_user.recreations.pluck(:id)
    end

    # TODO(okubo): model等に移行したい
    @orders = Order.where(
      recreation_id: rec_ids,
      is_accepted: @is_accepted,
      is_open: @is_open
    ).order("#{column} #{order} NULLS LAST")

    @customers = @orders.map(&:user)
  end
end
