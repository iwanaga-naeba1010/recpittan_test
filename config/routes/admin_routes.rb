# frozen_string_literal: true

namespace :admin do
  resources :invoices, only: %i[index create]
  resources :orders do
    resources :chats, only: %i[create]
  end
end

ActiveAdmin.routes(self)
