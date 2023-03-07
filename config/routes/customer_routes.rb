# frozen_string_literal: true

resources :customers, only: %i[index]

namespace :customers do
  resources :recreations, only: [:show, :index], shallow: true do
    resources :evaluations, only: [:index]
    resources :orders, only: [:show, :new, :create] do
      member do
        get :chat
        get :complete
      end

      resources :chats, only: %i[create]
      resources :reports, only: %i[edit update]
    end
  end
  resources :invoice_informations, only: %i[new create edit update]
  resources :online_rec_channels, only: [:show]
end
