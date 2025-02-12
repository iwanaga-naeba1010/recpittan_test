# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  delegate_all

  def to_s
    "#{I18n.t("activerecord.models.#{object.class.name.underscore}")} ##{object.id}"
  end
end
