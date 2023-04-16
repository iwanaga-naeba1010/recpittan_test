# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Customers::OnlineRecreationChannelsController, type: :request do
  let!(:customer) { create :user, :with_customer }
  let!(:customer2) { create :user, :with_customer }
  let!(:online_recreation_channel) { create :online_recreation_channel }
  let!(:channel_plan_subscriber) { create :channel_plan_subscriber, company: customer.company, status: :active }
  let!(:download_calendar_image) { create :online_recreation_channel_download_image, :calendar_image, online_recreation_channel: }
  let!(:download_calendar_pdf) { create :online_recreation_channel_download_image, :calendar_pdf, online_recreation_channel: }
  let!(:download_flyer_image) { create :online_recreation_channel_download_image, :flyer_image, online_recreation_channel: }
  let!(:download_flyer_pdf) { create :online_recreation_channel_download_image, :flyer_pdf, online_recreation_channel: }

  before do
    sign_in customer
  end

  describe '#show' do
    context 'when user is authorized to view the channel' do
      describe 'GET /customers/online_recreation_channels/:id' do
        let!(:id) { online_recreation_channel.id }
        it_behaves_like 'an endpoint returns 2xx status'
      end
    end

    describe 'GET /customers/online_recreation_channels/:id' do
      let(:id) { online_recreation_channel.id }
      before do
        sign_out customer
        sign_in customer2
      end
      let(:expected_redirect_to) { root_path }
      it_behaves_like 'an endpoint returns 3xx status'
    end
  end

  describe '#download' do
    shared_examples_for 'downloadable file' do |image_name|
      it 'returns http success' do
        get download_customers_online_recreation_channel_path(online_recreation_channel, params: { image_name: })
        expect(response).to have_http_status(:ok)
      end
    end

    shared_examples_for 'not downloadable file' do |image_name|
      it 'returns http failure' do
        get download_customers_online_recreation_channel_path(online_recreation_channel, params: { image_name: })
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to customers_online_recreation_channel_path(online_recreation_channel.id)
        expect(flash[:alert]).to eq I18n.t('action_messages.file_not_found')
      end
    end

    context 'download calendar_image' do
      context 'when download calendar_image is exists' do
        it_behaves_like 'downloadable file', 'calendar_image'
      end

      context 'when download calendar_image is not exists' do
        before do
          download_calendar_image.destroy
        end

        it_behaves_like 'not downloadable file', 'calendar_image'
      end
    end

    context 'download calendar_pdf' do
      context 'when download calendar_pdf is exists' do
        it_behaves_like 'downloadable file', 'calendar_pdf'
      end

      context 'when download calendar_pdf is not exists' do
        before do
          download_calendar_pdf.destroy
        end

        it_behaves_like 'not downloadable file', 'calendar_pdf'
      end
    end

    context 'download flyer_image' do
      context 'when download flyer_image is exists' do
        it_behaves_like 'downloadable file', 'flyer_image'
      end

      context 'when download flyer_image is not exists' do
        before do
          download_flyer_image.destroy
        end

        it_behaves_like 'not downloadable file', 'flyer_image'
      end
    end

    context 'download flyer_pdf' do
      context 'when download flyer_pdf is exists' do
        it_behaves_like 'downloadable file', 'flyer_pdf'
      end

      context 'when download flyer_pdf is not exists' do
        before do
          download_flyer_pdf.destroy
        end

        it_behaves_like 'not downloadable file', 'flyer_pdf'
      end
    end

    context 'when params is nil' do
      it_behaves_like 'not downloadable file', nil
    end
  end
end
