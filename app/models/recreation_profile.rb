# frozen_string_literal: true

class RecreationProfile < ApplicationRecord
  belongs_to :refreation
  belongs_to :profile
end
