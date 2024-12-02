# frozen_string_literal: true

# モデルにインクルードすることで、Ransackのransackable_attributesとransackable_associationsを
# 動的に定義し、不要なカラムやassociationを簡単に除外できるモジュール
module Ransackable
  extend ActiveSupport::Concern

  # モジュールがインクルードされた際に実行される処理
  included do
    # ransackable_attributesを動的に定義
    # デフォルトではモデルのすべてのカラムを取得し、除外リストに基づいて不要なカラムを除外
    define_singleton_method(:ransackable_attributes) do |_auth_object = nil|
      column_names.map(&:to_s) - default_excluded_attributes
    end

    # ransackable_associationsを動的に定義
    # モデルのすべてのassociationを取得し、除外リストに基づいて不要なassociationを除外
    define_singleton_method(:ransackable_associations) do |_auth_object = nil|
      reflect_on_all_associations.map(&:name).map(&:to_s) - default_excluded_associations
    end
  end

  class_methods do
    # デフォルトで除外するカラムを返す
    # 初期値として`created_at`と`updated_at`を除外
    def default_excluded_attributes
      %w[created_at updated_at]
    end

    # デフォルトで除外するassociationを返す
    # 初期値として除外するassociationはなし
    def default_excluded_associations
      []
    end

    # 除外するカラムを追加するメソッド
    # 個別のモデルでこのメソッドを呼び出すことで、デフォルトの除外リストにカラムを追加可能
    def exclude_attributes(*attributes)
      # デフォルトの除外リストに引数で指定されたカラムを追加する
      define_singleton_method(:default_excluded_attributes) do
        super() + attributes.map(&:to_s)
      end
    end

    # 除外するassociationを追加するメソッド
    # 個別のモデルでこのメソッドを呼び出すことで、デフォルトの除外リストにassociationを追加可能
    def exclude_associations(*associations)
      # デフォルトの除外リストに引数で指定されたassociationを追加する
      define_singleton_method(:default_excluded_associations) do
        super() + associations.map(&:to_s)
      end
    end
  end
end
