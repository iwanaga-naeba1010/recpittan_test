# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_prefectures
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Indexes
#
#  index_recreation_prefectures_on_name_and_recreation_id  (name,recreation_id) UNIQUE
#  index_recreation_prefectures_on_recreation_id           (recreation_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#
class RecreationPrefecture < ApplicationRecord
  include PrefectureList

  belongs_to :recreation, class_name: 'Recreation'

  def self.names
    prefectures
  end
end
