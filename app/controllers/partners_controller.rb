# frozen_string_literal: true

class PartnersController < Partners::ApplicationController
  def index
    @orders = current_user.partner.recreations.map(&:orders).flatten
  end

  # TODO: ここでtosのhtmlデータを取得して表示する
  # https://everyplus.jp/tos/partner/index.html?
  # NOTE: best_practicesで引っかかるので一旦コメント
  # def tos; end
end
