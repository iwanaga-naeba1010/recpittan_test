# frozen_string_literal: true

namespace :api_partner do
  resources :recreations, only: %i[index show create update] do
    resources :recreation_images, only: %i[create destroy]
    resources :recreation_prefectures, only: %i[create destroy]
    collection do
      get :config_data
    end
  end

  resources :profiles, only: %i[index]
end
