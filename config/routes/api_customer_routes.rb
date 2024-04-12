# frozen_string_literal: true

namespace :api_customer do
  resources :orders, only: %i[show update] do
    collection do
      get :preferred_date
    end
    resources :chats, only: %i[index create], module: :orders
  end
  resources :favorite_recreations, only: %i[index show create destroy]
  resources :recreation_plans, only: %i[show]
  resources :user_recreation_plans, only: %i[show create]
  resources :bank_accounts, only: %i[create]
end
