# frozen_string_literal: true

ActiveAdmin.register Chat do
  permit_params :order
  permit_params :message
  permit_params :is_read
end
