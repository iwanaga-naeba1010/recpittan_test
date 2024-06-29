# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_tags
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#  tag_id        :bigint           not null
#
# Foreign Keys
#
#  recreation_tags_recreation_id_fkey  (recreation_id => recreations.id)
#  recreation_tags_tag_id_fkey         (tag_id => tags.id)
#
class RecreationTag < ApplicationRecord
  belongs_to :recreation, class_name: 'Recreation'
  belongs_to :tag, class_name: 'Tag'
end
