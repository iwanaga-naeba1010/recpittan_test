class HomeController < ApplicationController
  def index
    @categories = Tag.categories
    @recs = Recreation.all
  end
end
