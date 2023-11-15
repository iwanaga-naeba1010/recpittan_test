# frozen_string_literal: true

resources :customers, only: %i[index]

namespace :customers do
  resources :recreations, only: %i[show index], shallow: true do
    resources :evaluations, only: %i[index]
    resources :orders, only: %i[show new create] do
      member do
        get :chat
        get :complete
      end

      resources :chats, only: %i[create]
      resources :reports, only: %i[edit update]
    end
  end
  resources :recreation_plans, only: %i[index show]
  resources :favorite_recreations, only: %i[index]
  resources :invoice_informations, only: %i[new create edit update]
  resources :online_recreation_channels, only: %i[show] do
    get :download, on: :member
  end
end
