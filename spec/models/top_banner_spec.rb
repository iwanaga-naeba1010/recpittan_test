# frozen_string_literal: true

# == Schema Information
#
# Table name: top_banners
#
#  id         :bigint           not null, primary key
#  end_date   :date             not null
#  image      :string           not null
#  start_date :date             not null
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe TopBanner, type: :model do
  describe '#validate_display_date_no_overlap' do
    context 'not overlap display dates' do
      let(:top_banner) { create(:top_banner, start_date: '2022-12-20', end_date: '2022-12-31') }
      let(:top_banner2) { build(:top_banner, start_date: '2023-01-01', end_date: '2023-01-10') }

      before do
        top_banner
      end

      it do
        expect(top_banner2).to be_valid
      end
    end

    context 'overlap display dates' do
      let(:top_banner) { create(:top_banner, start_date: '2022-12-20', end_date: '2022-12-31') }
      let(:top_banner2) { build(:top_banner, start_date: '2022-12-25', end_date: '2023-01-10') }

      before do
        top_banner
      end

      it do
        expect(top_banner2).to be_invalid
        expect(top_banner2.errors[:base]).to include('表示日が他のレコードと重複しています')
      end
    end
  end
end
