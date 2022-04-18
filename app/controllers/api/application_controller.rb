# frozen_string_literal: true

class Api::ApplicationController < ApplicationController
  include JsonRenderable
  before_action :set_default_url_options
  before_action :authenticate_user!
end
