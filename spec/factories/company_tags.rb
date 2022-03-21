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
# Indexes
#
#  index_company_tags_on_company_id  (company_id)
#  index_company_tags_on_tag_id      (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (tag_id => tags.id)
#
FactoryBot.define do
  factory :company_tag do
    company
    tag
  end
end
