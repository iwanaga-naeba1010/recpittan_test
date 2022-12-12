# == Schema Information
#
# Table name: user_recreations
#
#  id            :bigint           not null, primary key
#  body          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Indexes
#
#  index_user_recreations_on_recreation_id  (recreation_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#
require 'rails_helper'

RSpec.describe UserRecreation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
