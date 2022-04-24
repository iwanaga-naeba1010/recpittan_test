# frozen_string_literal: true

class UserRecreation < ApplicationRecord
  belongs_to :user
  belongs_to :recreation
end
