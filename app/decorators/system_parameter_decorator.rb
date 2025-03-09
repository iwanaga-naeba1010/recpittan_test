# frozen_string_literal: true

class SystemParameterDecorator < ApplicationDecorator
  def applied_date_formatted
    object.applied_date.strftime('%Y/%m/%d') if object.applied_date.present?
  end
end
