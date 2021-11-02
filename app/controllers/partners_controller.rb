class PartnersController < Partners::ApplicationController
  def index
    @orders = current_user.recreations.map(&:orders).flatten
  end
end
