Rails.application.routes.draw do
  ActiveAdmin.routes(self)
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

  resources :customers, only: %i[index]
  namespace :customers do

    resources :recreations, only: [:show, :index], shallow: true do
      resources :orders, except: [:edit, :destroy, :index] do
        member do
          get :chat
          get :complete
        end

        resources :chats, only: %i[create]
        resources :reports, only: %i[edit update]
      end
    end
  end

  resources :partners, only: %i[index]
  namespace :partners do
    get :tos

    resources :orders, only: %i[show update] do
      member do
        get :chat
        get :confirm
        get :complete
        get :final_check
        get :complete_final_check
      end

      resources :chats, only: %i[create]
      resources :reports, only: %i[new create edit update] do
        member do
          get :complete
        end
      end
    end
  end

  namespace :api do
    resources :slack_notifiers, only: %i[create]
    resources :orders, only: %i[update]
  end

  get 'sitemap', to: redirect("https://#{ENV['AWS_BUCKET']}.s3-ap-northeast-1.amazonaws.com/sitemaps/sitemap.xml.gz")

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  get '*path' => 'errors#routing_error', via: :all
end
