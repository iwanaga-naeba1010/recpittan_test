# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @yoshimoto = Rails.cache.fetch('home/yoshimoto_tag', expires_in: 1.week) do
      Tag.find_by(name: '吉本')
    end

    @yoshimoto_recs = Rails.cache.fetch('home/yoshimoto_recs', expires_in: 1.week) do
      Recreation.public_recs
                .where(title: [
                  '笑って健康！折りがとう！',
                  'オスペンギンの介護オモシレーション',
                  '～オモロさ折り紙付きコンビspan!によるお笑い介護レクリエーション～',
                  'レギュラーの楽しく『お笑い』介護レク♪',
                  '上原チョーと一緒に楽しく踊ろう「トゥートゥー体操」',
                  '【コラボ企画】オール巨人リモートコンサート',
                  'よしもとお笑い介護ブ！にお任せプラン'
                ]).to_a
    end

    @travel_recs = Rails.cache.fetch('home/travel_recs', expires_in: 1.week) do
      Recreation.public_recs
                .where(title: [
                  'ルワンダ伝統アートの工房訪問',
                  'オンラインでカンボジアの日常をぶらり旅',
                  'オンラインで楽しむニュージーランド旅行',
                  '～おはらい町おかげ横丁ツアー～',
                ]).to_a
    end

    @music_recs = Rails.cache.fetch('home/music_recs', expires_in: 6.hours) do
      Recreation.public_recs
                .where(title: [
                  '【著作権料負担無！】歌とトークで綴る昭和ヒットパレード',
                  'ギターとともに楽しいひとときを…ギターとともに楽しいひとときを…',
                  '『八丈島から届く音便り』',
                  '『ねがいごとコンサート』',
                  'コントラバスとピアノで楽しむタンゴコンサート',
                  '八丈島在住のピアニスト・マリンバ奏者の小金沢有希さんによる生演奏会',
                  'クラシック・ギター　オンラインコンサート',
                  '歌とあなただけのメッセージボードで心に残るお誕生日会を',
                  '着物男子の三味線コンサート',
                  '【オンライン】三味線とオカリナのコンサート',
                  '【オンライン】ジュークのほのぼのウクレレコンサート',
                ]).to_a
    end

    @tags = Tag.where(kind: :tag).to_a
  end
end
