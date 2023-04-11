# frozen_string_literal: true

class Customers::OnlineRecreationChannelsController < Customers::ApplicationController
  before_action :require_online_channel_subscribers

  def show
    @online_recreation_channel = OnlineRecreationChannel.includes(:online_recreation_channel_recreations).find(params[:id])
    @next_month_online_recreation_channel = OnlineRecreationChannel
                                            .public_channels
                                            .where(period: @online_recreation_channel.period.next_month)
                                            .first
    @data_options = { turbolinks: 'false', confirm: 'ダウンロードしますか?' }
    @download_path = download_customers_online_recreation_channel_path(@online_recreation_channel)
  end

  def download
    online_recreation_channel = OnlineRecreationChannel.find(params[:id])
    image_name = params[:image_name]
    image = case image_name
            when 'calendar_pdf'
              online_recreation_channel.calendar_pdf
            when 'calendar_image'
              online_recreation_channel.calendar_image
            when 'flyer_pdf'
              online_recreation_channel.flyer_pdf
            when 'flyer_image'
              online_recreation_channel.flyer_image
            end

    if image.nil?
      redirect_to customers_online_recreation_channel_path(online_recreation_channel.id), alert: t('action_messages.file_not_found')
    else
      send_data(image.read, filename: "download_#{image_name}")
    end
  end

  private def require_online_channel_subscribers
    unless (current_user&.role&.customer? && current_user&.company&.channel_plan_subscriber&.status&.active?) || current_user&.role&.admin?
      redirect_to root_path, alert: t('action_messages.unauthorized')
    end
  end
end
