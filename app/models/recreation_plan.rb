# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plans
#
#  id             :bigint           not null, primary key
#  adjustment_fee :integer
#  code           :string           not null
#  disporder      :integer          default(0)
#  release_status :integer          default("draft"), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :bigint
#
# Indexes
#
#  index_recreation_plans_on_code        (code) UNIQUE
#  index_recreation_plans_on_company_id  (company_id)
#
class RecreationPlan < ApplicationRecord
  include Ransackable
  extend Enumerize

  belongs_to :company, class_name: 'Company', optional: true
  has_many :recreation_recreation_plans, dependent: :destroy, class_name: 'RecreationRecreationPlan'
  has_many :recreations, through: :recreation_recreation_plans, class_name: 'Recreation'
  has_many :user_recreation_plans, dependent: :destroy, class_name: 'UserRecreationPlan'
  has_many :users, through: :user_recreation_plans, class_name: 'User'
  has_many :recreation_plan_tags, dependent: :destroy, class_name: 'RecreationPlanTag'
  has_many :tags, through: :recreation_plan_tags, class_name: 'Tag'

  accepts_nested_attributes_for :recreation_recreation_plans, allow_destroy: true

  enumerize :release_status, in: { draft: 0, public: 1 }, default: 0

  validates :code, :release_status, :title, presence: true
  validates :code, uniqueness: true
  before_validation :generate_code, on: :create

  scope :visible_to, ->(user) { where('company_id IS NULL OR company_id = ?', user.company_id) }

  delegate :facility_name, to: :company, allow_nil: true

  def monthly_fee
    latest_month = recreation_recreation_plans.order(month: :desc).first.month
    recreation_price = recreations.sum(&:price)
    material_price = recreations.sum(&:material_price)
    transportation_expenses = recreations.where(kind: :visit).sum do |_rec|
      1000
    end
    total_price = recreation_price + material_price + transportation_expenses + adjustment_fee.to_i

    total_price / latest_month
  end

  def visible_to_company?(user_company)
    company.nil? || user_company == company
  end

  private def generate_code
    last_code = RecreationPlan.maximum(:code)
    sequence_num = if last_code
                     last_code.gsub('P', '').to_i + 1
                   else
                     1
                   end
    self.code = "P#{sequence_num.to_s.rjust(4, '0')}"
  end
end
