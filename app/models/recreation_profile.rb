# frozen_string_literal: true

class RecreationProfile < ApplicationRecord
  belongs_to :recreation
  belongs_to :profile
end
