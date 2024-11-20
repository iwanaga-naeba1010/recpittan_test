# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :text
#  name        :string
#  position    :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Foreign Keys
#
#  profiles_user_id_fkey  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'before_destroy :check_recreation_association' do
    let(:user) { create(:user) }
    let!(:profile) { create(:profile, user:) }

    context 'when the profile is associated with a recreation' do
      let!(:recreation) { create(:recreation, recreation_profile: create(:recreation_profile, profile:, recreation: create(:recreation, user:))) }

      it 'does not allow the profile to be destroyed' do
        expect { profile.destroy }.not_to change(Profile, :count)
        expect(profile.errors[:base]).to include('このプロフィールは関連するレクがあるため削除できません。')
      end
    end

    context 'when the profile is not associated with any recreation' do
      it 'allows the profile to be destroyed' do
        expect { profile.destroy }.to change(Profile, :count).by(-1)
      end
    end
  end
end
