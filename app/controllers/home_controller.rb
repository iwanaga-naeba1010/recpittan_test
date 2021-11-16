# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @categories = Tag.categories
    @recs = Recreation.all
  end
end
