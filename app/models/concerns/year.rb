# frozen_string_literal: true

class Year < ActiveHash::Base
  include ActiveHash::Associations

  current_year = Time.zone.today.year
  self.data =  [
    { id: 1, value: current_year.to_s },
    { id: 2, value: (current_year + 1).to_s }
  ]
end
