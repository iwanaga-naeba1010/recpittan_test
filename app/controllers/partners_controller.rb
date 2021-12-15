# frozen_string_literal: true

class PartnersController < Partners::ApplicationController
  def index
    is_held = params[:is_held]&.to_s&.downcase == 'true'

    unless is_held
      @orders = current_user.recreations.map { |rec| rec.orders.is_not_held }.flatten.uniq
      return
    end

    @orders = current_user.recreations.map { |rec| rec.orders.is_held }.flatten.uniq
  end

  # TODO: ここでtosのhtmlデータを取得して表示する
  # https://everyplus.jp/tos/partner/index.html?
  # NOTE: best_practicesで引っかかるので一旦コメント
  # def tos; end
end
