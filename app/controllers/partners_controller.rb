class PartnersController < Partners::ApplicationController
  def index
    @orders = current_user.orders
  end
end
