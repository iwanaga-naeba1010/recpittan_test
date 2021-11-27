# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @categories = sort_categories(Tag.categories)
    @recs = Recreation.all
  end

  def sort_categories(categories)
    categories = categories.to_a
    [
      categories.map {|c| c if c.name == '音楽'}.compact.first,
      categories.map {|c| c if c.name == '健康'}.compact.first,
      categories.map {|c| c if c.name == '趣味'}.compact.first,
      categories.map {|c| c if c.name == '創作'}.compact.first,
      categories.map {|c| c if c.name == '旅行'}.compact.first,
      categories.map {|c| c if c.name == '飲食'}.compact.first,
      categories.map {|c| c if c.name == 'イベント'}.compact.first,
      categories.map {|c| c if c.name == 'その他'}.compact.first,
    ]
  end
end
