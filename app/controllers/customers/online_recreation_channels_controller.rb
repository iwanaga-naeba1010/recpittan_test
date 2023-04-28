# frozen_string_literal: true

class Customers::OnlineRecreationChannelsController < Customers::ApplicationController
  before_action :require_online_channel_subscribers

  def show
    @online_recreation_channel = OnlineRecreationChannel
                                 .includes(:online_recreation_channel_recreations, :online_recreation_channel_download_images)
                                 .find(params[:id])
    @download_image = @online_recreation_channel.online_recreation_channel_download_images
    @next_month_online_recreation_channel = OnlineRecreationChannel
                                            .public_channels
                                            .where(period: @online_recreation_channel.period.next_month)
                                            .first
    @data_options = { turbolinks: 'false', confirm: 'ダウンロードしますか?' }
    @download_path = download_customers_online_recreation_channel_path(@online_recreation_channel)

    @calendar_download_image = @online_recreation_channel
                               .online_recreation_channel_download_images
                               .where(kind: %w[calendar_image calendar_pdf])
    @flyer_download_image = @online_recreation_channel
                            .online_recreation_channel_download_images
                            .where(kind: %w[flyer_image flyer_pdf])
  end

  def download
    online_recreation_channel = OnlineRecreationChannel.includes(:online_recreation_channel_download_images).find(params[:id])
    image_name = params[:image_name]
    image = online_recreation_channel.online_recreation_channel_download_images.find_by(kind: image_name)&.image
    if image.nil?
      redirect_to customers_online_recreation_channel_path(online_recreation_channel.id), alert: t('action_messages.file_not_found')
    else
      extension = { 'calendar_pdf' => 'pdf', 'flyer_pdf' => 'pdf', 'calendar_image' => 'png', 'flyer_image' => 'png' }[image_name]
      send_data(image.read, filename: "download_#{image_name}.#{extension}")
    end
  end

  private def require_online_channel_subscribers
    unless (current_user&.role&.customer? && current_user&.company&.channel_plan_subscriber&.status&.active?) || current_user&.role&.admin?
      redirect_to root_path, alert: t('action_messages.unauthorized')
    end
  end
end
