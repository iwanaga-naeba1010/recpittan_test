# frozen_string_literal: true

namespace :api do
  resources :users, only: %i[] do
    collection do
      get :self
    end
  end
  resources :slack_notifiers, only: %i[create]
end
