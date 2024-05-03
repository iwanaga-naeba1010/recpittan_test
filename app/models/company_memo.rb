# frozen_string_literal: true

# == Schema Information
#
# Table name: company_memos
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_company_memos_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class CompanyMemo < ApplicationRecord
  belongs_to :company, class_name: 'Company'
end
