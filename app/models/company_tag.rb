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
class CompanyTag < ApplicationRecord
  belongs_to :company, class_name: 'Company'
  belongs_to :tag, class_name: 'Tag'
end
