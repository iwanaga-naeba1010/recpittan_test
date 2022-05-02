# frozen_string_literal: true

namespace :api_partner do
  resources :recreations, only: %i[show create update] do
    collection do
      get :config_data
    end
  end

  resources :profiles, only: %i[index]
end
