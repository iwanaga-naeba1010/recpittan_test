# frozen_string_literal: true

# == Schema Information
#
# Table name: system_parameters
#
#  id           :bigint           not null, primary key
#  applied_date :datetime
#  param_code   :string
#  param_name   :string
#  value_int    :decimal(15, 4)
#  value_text   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe SystemParameter, type: :model do
  it { is_expected.to have_db_column(:param_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:param_name).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:value_int).of_type(:decimal).with_options(precision: 15, scale: 4, null: true) }
  it { is_expected.to have_db_column(:value_text).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:applied_date).of_type(:datetime).with_options(null: true) }

  describe 'scopes' do
    let!(:past_param) { create(:system_parameter, applied_date: 1.day.ago) }
    let!(:future_param) { create(:system_parameter, applied_date: 1.day.from_now) }
    let!(:company_announcement_public) { create(:system_parameter, param_code: 'company_announcement_public') }
    let!(:company_announcement) { create(:system_parameter, param_code: 'company_announcement') }
    let!(:partner_announcement) { create(:system_parameter, param_code: 'partner_announcement') }

    describe '.available' do
      it 'returns parameters with applied_date in the past or present' do
        expect(SystemParameter.available).to include(past_param)
        expect(SystemParameter.available).not_to include(future_param)
      end
    end

    describe '.company_announcement_public' do
      it 'returns parameters with param_code company_announcement_public' do
        expect(SystemParameter.company_announcement_public).to include(company_announcement_public)
        expect(SystemParameter.company_announcement_public).not_to include(company_announcement)
        expect(SystemParameter.company_announcement_public).not_to include(partner_announcement)
      end
    end

    describe '.company_announcement' do
      it 'returns parameters with param_code company_announcement' do
        expect(SystemParameter.company_announcement).to include(company_announcement)
        expect(SystemParameter.company_announcement).not_to include(company_announcement_public)
        expect(SystemParameter.company_announcement).not_to include(partner_announcement)
      end
    end

    describe '.partner_announcement' do
      it 'returns parameters with param_code partner_announcement' do
        expect(SystemParameter.partner_announcement).to include(partner_announcement)
        expect(SystemParameter.partner_announcement).not_to include(company_announcement_public)
        expect(SystemParameter.partner_announcement).not_to include(company_announcement)
      end
    end
  end
end
