# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Target < ApplicationRecord
  has_many :recreation_targets, dependent: :destroy
  has_many :recreations, through: :recreation_targets
end
