# Rails 7.2以降、ActiveSupport::Deprecation.warn メソッドがプライベートメソッドとして定義されるようになりました。
# これにより、carrierwave gem（バージョン 3.0.7）が内部で ActiveSupport::Deprecation.warn を直接呼び出す際にエラーが発生します。
# 現在のプロジェクトでは carrierwave を削除できないため、一時的な回避策として warn メソッドをパブリックメソッドに変更しています。
# この修正により、Rails 7.2以降の環境でも carrierwave が正常に動作するようになります。
# この対応は根本的な解決策ではないため、将来的には carrierwave のアップデートや他の代替手段を検討してください。

module ActiveSupport
  class Deprecation
    class << self
      public :warn
    end
  end
end
