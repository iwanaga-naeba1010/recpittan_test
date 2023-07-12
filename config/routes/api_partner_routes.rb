# frozen_string_literal: true

namespace :api_partner do
  resources :recreations, only: %i[index show create update] do
    resources :recreation_images, only: %i[create destroy]
    resources :recreation_prefectures, only: %i[create update destroy]
    collection do
      get :config_data
    end
    resources :evaluations, only: %i[index]
  end

  resources :profiles, only: %i[index]
end
