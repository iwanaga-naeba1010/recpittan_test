# frozen_string_literal: true

namespace :api_partner do
  resource :bank_accounts, only: %i[show create update]
  resources :recreations, only: %i[index show create update] do
    resources :recreation_images, only: %i[create destroy]
    collection do
      get :config_data
    end
    resources :evaluations, only: %i[index]
    resources :evaluation_replies, only: %i[create]
  end
  resources :registrations, only: %i[create]
  resources :partner_information, only: %i[show update]

  resources :profiles, only: %i[index]
end
