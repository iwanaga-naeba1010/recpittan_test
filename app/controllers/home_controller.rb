# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  TRIAL_TITLES = [
    '【著作権料負担無！】歌とトークで綴る昭和ヒットパレード',
    '介護福祉漫談家メイミのエンタメ体操！',
    'オスペンギンの介護オモシレーション',
    'オンラインでも参加型！リリムジカの音楽プログラム',
    '【TV特集多数】究極に分かりやすい！ホワイトボード落語とリハビリ体操',
    '～オモロさ折り紙付きコンビspan!によるお笑い介護レクリエーション～',
    '【オンライン】いきいき体操教室',
    '笑顔歌(えがおか)計画！',
    '簡単いすヨガ',
    'オンラインドッグセラピー（動物介在介護）',
  ].freeze

  LESS_THAN_TEN_THOUSANT_YEN_TITLES = [
    'オンライン書道',
    '【オンライン】フクロウカフェ体験',
    'シルバーリトミック（健康音楽教室）',
    'ガラス風鈴絵付け',
    '苔テラリウム制作体験',
    '【オンライン】ジュークのほのぼのウクレレコンサート',
    '【オンライン】脳とカラダのらくらく体操',
    '伝統工芸つまみ細工の歴史探訪',
    'オンライン囲碁多面打ちレッスン',
    '座ったままで楽々健康長寿体操',
    'オンラインで美しい童謡音楽レクリエーション教室',
    'アロマのデュフューザー（香りの芳香剤）（オンライン））',
  ].freeze

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

    @trial_recs = Rails.cache.fetch('home/trial_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(title: TRIAL_TITLES).to_a
      TRIAL_TITLES.map { |title| pick_recreation_by_title(recreations: queried_recreations, title: title) }.compact.flatten
    end

    @less_than_ten_thousand_yen_recs = Rails.cache.fetch('home/under_ten_thou_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(title: LESS_THAN_TEN_THOUSANT_YEN_TITLES).to_a
      LESS_THAN_TEN_THOUSANT_YEN_TITLES.map do |title|
        pick_recreation_by_title(recreations: queried_recreations, title: title)
      end.compact.flatten
    end

    @tags = Tag.where(kind: :tag).to_a
  end

  private

  def pick_recreation_by_title(recreations:, title:)
    recreations.select { |rec| rec.title == title }
  end
end
# rubocop:enable Metrics/AbcSize
