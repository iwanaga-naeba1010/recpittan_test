# frozen_string_literal: true

module Ransackable
  extend ActiveSupport::Concern

  included do
    define_singleton_method(:ransackable_attributes) do |_auth_object = nil|
      column_names.map(&:to_s) - default_excluded_attributes
    end

    define_singleton_method(:ransackable_associations) do |_auth_object = nil|
      reflect_on_all_associations.map(&:name).map(&:to_s) - default_excluded_associations
    end
  end

  class_methods do
    # 除外するデフォルトのカラムを設定
    def default_excluded_attributes
      %w[created_at updated_at]
    end

    # 除外するデフォルトの関連を設定
    def default_excluded_associations
      []
    end

    # モデルごとにカスタマイズできるメソッド
    def exclude_attributes(*attributes)
      define_singleton_method(:default_excluded_attributes) do
        super() + attributes.map(&:to_s)
      end
    end

    def exclude_associations(*associations)
      define_singleton_method(:default_excluded_associations) do
        super() + associations.map(&:to_s)
      end
    end
  end
end
