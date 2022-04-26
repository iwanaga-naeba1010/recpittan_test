# frozen_string_literal: true

# == Schema Information
#
# Table name: company_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  tag_id     :bigint           not null
#
# Foreign Keys
#
#  company_tags_company_id_fkey  (company_id => companies.id)
#  company_tags_tag_id_fkey      (tag_id => tags.id)
#
require 'rails_helper'

RSpec.describe CompanyTag, type: :model do
end
