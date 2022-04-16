# frozen_string_literal: true

namespace :api_customer do
  resources :users, only: %i[] do
    collection do
      get :self
    end
  end
  resources :orders, only: %i[show update] do
    collection do
      get :preferred_date
    end
    resources :chats, only: %i[index create], module: :orders
  end
end
