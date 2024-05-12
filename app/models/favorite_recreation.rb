# frozen_string_literal: true

# == Schema Information
#
# Table name: favorite_recreations
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_favorite_recreations_on_recreation_id              (recreation_id)
#  index_favorite_recreations_on_user_id                    (user_id)
#  index_favorite_recreations_on_user_id_and_recreation_id  (user_id,recreation_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (user_id => users.id)
#
class FavoriteRecreation < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :recreation, class_name: 'Recreation'
end
