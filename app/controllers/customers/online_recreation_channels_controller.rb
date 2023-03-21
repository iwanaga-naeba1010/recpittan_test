# frozen_string_literal: true

class Customers::OnlineRecreationChannelsController < Customers::ApplicationController
  before_action :require_online_channel_subscribers

  def show
    @online_recreation_channel = OnlineRecreationChannel.find(params[:id])
  end

  private def require_online_channel_subscribers
    unless (current_user&.role&.customer? && current_user&.company&.channel_plan_subscriber&.status&.active?) || current_user&.role&.admin?
      redirect_to root_path, alert: t('action_messages.unauthorized')
    end
  end
end
