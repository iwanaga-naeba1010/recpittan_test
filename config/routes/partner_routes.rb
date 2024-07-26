# frozen_string_literal: true

resources :partners, only: %i[index]
namespace :partners do
  get :tos
  get :setting_menus

  resources :informations, only: %i[edit]
  resources :registrations, only: %i[new] do
    get :complete, on: :collection
    get :confirm, on: :collection
  end
  resources :recreations, only: %i[index new show create edit update complete_final_check] do
    resources :evaluations, only: %i[index]
  end
  resource :bank_accounts, only: %i[new edit]
  resources :profiles, except: :show
  resources :orders, only: %i[show update] do
    member do
      get :chat
      get :confirm
      get :complete
      get :final_check
      patch :update_final_check
      get :complete_final_check
    end

    resources :chats, only: %i[create]
    resources :zooms, only: %i[new create edit update]
    resources :evaluations, only: %i[show]
    resources :reports, only: %i[new create edit update] do
      member do
        get :complete
      end
    end
  end
end
