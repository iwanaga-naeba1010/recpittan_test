# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageUploader, type: :uploader do
  let(:user) { create(:user) }
  let(:uploader) { described_class.new(user, :avatar) }
  let(:file) { Rails.root.join('spec/files/test.png').open }

  before do
    uploader.store!(file)
  end

  after do
    uploader.remove!
  end

  context 'File upload' do
    it 'saves the file correctly' do
      expect(uploader.file).to be_present
    end

    it 'allows only specific file extensions' do
      expect(uploader.extension_allowlist).to include('jpg', 'jpeg', 'gif', 'png', 'pdf', 'pptx', 'ppt', 'doc', 'docx', 'xls', 'xlsx')
    end

    it 'retrieves the uploaded file URL' do
      expect(uploader.url).to match(%r{uploads/user/avatar/\d+})
    end
  end

  context 'Storage settings' do
    it 'uses local storage in the test environment' do
      expect(uploader.file).to be_a(CarrierWave::SanitizedFile)
    end
  end

  context 'File deletion' do
    it 'removes the file when the user is deleted' do
      path = uploader.file.path
      user.destroy
      uploader.remove!
      expect(File.exist?(path)).to be_falsey
    end
  end
end
