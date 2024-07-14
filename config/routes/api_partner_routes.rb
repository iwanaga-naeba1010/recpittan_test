# frozen_string_literal: true

namespace :api_partner do
  resources :bank_accounts, only: %i[show create update]
  resources :recreations, only: %i[index show create update] do
    resources :recreation_images, only: %i[create destroy]
    resources :recreation_prefectures, only: %i[create update destroy]
    collection do
      get :config_data
    end
    resources :evaluations, only: %i[index]
    resources :evaluation_replies, only: %i[create]
  end

  resources :profiles, only: %i[index]
end
