# frozen_string_literal: true

class Minute < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 1, value: '00' },
    { id: 2, value: '05' },
    { id: 3, value: '10' },
    { id: 4, value: '15' },
    { id: 5, value: '20' },
    { id: 6, value: '25' },
    { id: 7, value: '30' },
    { id: 8, value: '35' },
    { id: 9, value: '40' },
    { id: 10, value: '45' },
    { id: 11, value: '50' },
    { id: 12, value: '55' }
  ]
end
