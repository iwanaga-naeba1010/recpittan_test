# frozen_string_literal: true

# == Schema Information
#
# Table name: plans
#
#  id         :bigint           not null, primary key
#  kind       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_plans_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...           (company_id => companies.id)
#  plans_company_id_fkey  (company_id => companies.id)
#
class Plan < ApplicationRecord
  extend Enumerize
  belongs_to :company

  enumerize :kind, in: { free: 0, paid: 1 }, default: 0
end
