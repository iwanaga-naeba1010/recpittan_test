class Year < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
      { id: 1, value: '2021' },
      { id: 2, value: '2022' }
  ]
end
