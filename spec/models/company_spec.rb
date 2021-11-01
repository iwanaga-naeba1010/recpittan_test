# == Schema Information
#
# Table name: companies
#
#  id                         :bigint           not null, primary key
#  facility_name              :string
#  name                       :string
#  person_in_charge_name      :string
#  person_in_charge_name_kana :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_id                    :bigint           not null
#
# Indexes
#
#  index_companies_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Company, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
