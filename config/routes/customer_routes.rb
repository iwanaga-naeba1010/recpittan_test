# frozen_string_literal: true

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
