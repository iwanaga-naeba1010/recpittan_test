# == Schema Information
#
# Table name: instructors
#
#  id            :bigint           not null, primary key
#  description   :text
#  image         :text
#  name          :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Indexes
#
#  index_instructors_on_recreation_id  (recreation_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#
require 'rails_helper'

RSpec.describe Instructor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
