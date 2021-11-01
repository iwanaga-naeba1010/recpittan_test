# frozen_string_literal: true

module ApplicationHelper
  def active_link?(target)
    # binding.pry
    controller.controller_name.in?(target)
  end
end
