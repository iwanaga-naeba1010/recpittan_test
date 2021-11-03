# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @categories = Tag.categories
    @recs = Recreation.all
  end

  # def step
  #   @breadcrumbs = [
  #     { name: 'トップ' },
  #     { name: '一覧' },
  #     { name: '旅行' },
  #     { name: '～おはらい町おかげ横丁ツアー～' },
  #   ]
  # end
end
