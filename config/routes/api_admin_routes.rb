# frozen_string_literal: true

namespace :api_admin do
  resources :users, only: [] do
    member do
      patch :unlock
    end
  end
end
