class Minute < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
      { id: 1, value: '00' },
      { id: 2, value: '15' },
      { id: 3, value: '30' },
      { id: 4, value: '45' }
  ]
end
