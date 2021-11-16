# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @categories = Tag.categories
    @recs = Recreation.all

    # SlackNotifier.new(channel: '#料金お問い合わせ').send('新規お問い合わせ', '料金お問い合わせのご連絡。')
  end
end
