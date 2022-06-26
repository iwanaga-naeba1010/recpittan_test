# frozen_string_literal: true

module InteractionHandling
  extend ActiveSupport::Concern

  included do
    def handle_interaction_errors(variable:, params:, errors:)
      klass = variable.class
      columns = klass.attribute_names.map(&:to_sym) - %i[id user_id created_at updated_at]
      columns.each { |col| variable[col] = params[col] }
      errors.each { |e| variable.errors.add(e.attribute, e.message) }
      variable
    end
  end
end
