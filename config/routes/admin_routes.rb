# frozen_string_literal: true

namespace :admin do
  resources :invoices, only: %i[index create]
  resources :final_check_mails, only: %i[index create]
end

ActiveAdmin.routes(self)
