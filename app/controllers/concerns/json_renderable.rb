# frozen_string_literal: true

module JsonRenderable
  extend ActiveSupport::Concern

  included do
    def render_json(object, status: :ok)
      render json: Oj.dump(object, mode: :compat), status:
    end
  end
end
