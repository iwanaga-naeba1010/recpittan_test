# frozen_string_literal: true

namespace :admin do
  resources :invoices, only: %i[index create]
end

ActiveAdmin.routes(self)
