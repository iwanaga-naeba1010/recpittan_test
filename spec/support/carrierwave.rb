# frozen_string_literal: true

# CarrierWave のテスト用マッチャー（ヘルパーメソッド）を使用できるようにする
require 'carrierwave/test/matchers'

RSpec.configure do |config|
  # CarrierWave のテスト用マッチャーを RSpec に組み込む
  config.include CarrierWave::Test::Matchers

  # テスト実行前に CarrierWave の設定を変更
  config.before(:suite) do
    CarrierWave.configure do |carrierwave_config|
      # ストレージを :file（ローカルストレージ）に設定
      carrierwave_config.storage = :file

      # 画像の処理（リサイズなど）を無効化（テストのパフォーマンス向上のため）
      carrierwave_config.enable_processing = false
    end
  end

  # テスト実行後にアップロードされたファイルを削除
  config.after(:suite) do
    # spec/uploads ディレクトリを削除（テスト用アップロードファイルのクリーンアップ）
    FileUtils.rm_rf(Dir[Rails.root.join('spec/uploads').to_s])
  end
end
