# frozen_string_literal: true

namespace :api_partner do
  resources :recreations, only: %i[show create update] do
    collection do
      get :preferred_date
    end
  end
end
