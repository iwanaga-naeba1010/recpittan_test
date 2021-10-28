class HomeController < ApplicationController
  def index
    @categories = [
      { name: '音楽', description: "音楽療法\n和太鼓奏法など", image: '' }
    ]
  end
end
