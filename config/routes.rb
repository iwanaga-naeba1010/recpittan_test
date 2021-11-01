Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'
  get '/step' => 'home#step'

  resources :recreations, shallow: true do
    resources :orders
  end

  devise_for :users, controllers: {
    sessions: 'custom_devise/sessions',
    registrations: 'custom_devise/registrations'
  }
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
