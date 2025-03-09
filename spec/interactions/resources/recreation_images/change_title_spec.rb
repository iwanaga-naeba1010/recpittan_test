# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::RecreationImages::ChangeTitle, type: :interaction do
  let(:recreation_image) { create(:recreation_image) }
  let(:new_title) { 'New Image Title' }

  subject { described_class.run(params) }

  describe '#execute' do
    context 'when recreation_image_id is valid' do
      let(:params) { { recreation_image_id: recreation_image.id, title: new_title } }

      it 'is valid' do
        expect(subject.valid?).to be true
      end

      it 'updates the title of the recreation image' do
        subject
        expect(recreation_image.reload.title).to eq(new_title)
      end
    end

    context 'when recreation_image_id is missing' do
      let(:params) { { title: new_title } }

      it 'is not valid' do
        expect(subject.valid?).to be false
      end

      it 'returns the correct error message' do
        expect(subject.errors.full_messages.join).to match(/can't be blank|が必要です/)
      end
    end

    context 'when recreation_image_id is invalid' do
      it 'raises an ActiveRecord::RecordNotFound error' do
        expect {
          described_class.run!(recreation_image_id: -1, title: new_title)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
