# frozen_string_literal: true

class ApiPartner::ApplicationController < ApplicationController
  include JsonRenderable
  before_action :require_partner

  def require_partner
    return if current_user.role.partner?

    render_json(['権限がありません'], status: 401)
  end
end
