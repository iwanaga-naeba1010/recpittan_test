# frozen_string_literal: true

namespace :api do
  resources :slack_notifiers, only: %i[create]
end
