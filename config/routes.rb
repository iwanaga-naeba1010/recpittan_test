# frozen_string_literal: true

def draw(routes_name)
  instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}_routes.rb")))
end

Rails.application.routes.draw do
  draw :admin_routes
  # switch userの設定
  get 'switch_user', to: 'switch_user#set_current_user' if Rails.env.development?
  get 'switch_user/remember_user', to: 'switch_user#remember_user' if Rails.env.development?

  root 'home#index'
  get 'home/index'

  devise_for :users, controllers: {
    sessions: 'custom_devise/sessions',
    registrations: 'custom_devise/registrations',
    passwords: 'custom_devise/passwords'
  }

  resources :registration_thanks, only: %i[index]

  draw :api_admin_routes
  draw :api_customer_routes
  draw :api_partner_routes
  draw :api_routes
  draw :customer_routes
  draw :partner_routes

  get 'sitemap', to: redirect("https://#{ENV['AWS_BUCKET']}.s3-ap-northeast-1.amazonaws.com/sitemaps/sitemap.xml.gz")

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  get '*path' => 'errors#routing_error', via: :all
end
