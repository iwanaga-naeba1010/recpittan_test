# frozen_string_literal: true

class Hour < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 1, value: '08' },
    { id: 2, value: '09' },
    { id: 3, value: '10' },
    { id: 4, value: '11' },
    { id: 5, value: '12' },
    { id: 6, value: '13' },
    { id: 7, value: '14' },
    { id: 8, value: '15' },
    { id: 9, value: '16' },
    { id: 10, value: '17' },
    { id: 11, value: '18' }
  ]
end
