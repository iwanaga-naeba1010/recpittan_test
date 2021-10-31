# == Schema Information
#
# Table name: recreation_images
#
#  id            :bigint           not null, primary key
#  image         :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Indexes
#
#  index_recreation_images_on_recreation_id  (recreation_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#
require 'rails_helper'

RSpec.describe RecreationImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
