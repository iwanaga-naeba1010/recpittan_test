# frozen_string_literal: true

class Year < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 1, value: '2023' }
    { id: 2, value: '2024' }
  ]
end
