class PartnersController < Partners::ApplicationController
  def index
    sort_order = params[:sort_order] || :newest
    @is_accepted = params[:is_accepted]&.to_s&.downcase == 'true' || false
    @recreations = current_user.recreations
    rec_ids = params[:recreation_id].present? ? params[:recreation_id] : @recreations.pluck(:id)
    user_id = params[:user_id].present? ? params[:user_id] : nil
    start_date = params[:start_date].present? ? params[:start_date].to_date.beginning_of_day : nil
    end_date = params[:end_date].present? ? params[:end_date].to_date.end_of_day : nil

    @orders = Order.includes([:user])
                   .includes([:recreation])
                   .where(recreation_id: rec_ids)
                   .where(is_accepted: @is_accepted)
                   .where(is_open: true)

    if start_date && end_date
      @orders = @orders.where(start_at: start_date..end_date)
    elsif start_date
      @orders = @orders.where(start_at: start_date..)
    elsif end_date
      @orders = @orders.where(start_at: ..end_date)
    end

    @orders = @orders.sorted_by(sort_order)

    @customers = @orders.map(&:user)
    @orders = @orders.where(user_id: user_id) if user_id.present?
  end
end
