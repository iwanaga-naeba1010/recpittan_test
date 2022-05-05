# frozen_string_literal: true

require 'csv'

def add_tag_by_key(rec:, tag:)
  rec.tags << tag
end

namespace :restore_tags do
  task run: :environment do
    ActiveRecord::Base.transaction do
      tags = Tag.where(kind: [:category, :tag])
      tags.destroy_all

      recreations = Recreation.all.to_a
      path = Rails.root.join('lib/tasks/restore_tags.csv')
      CSV.foreach(path, headers: true) do |row|
        rec = recreations.select { |elm| elm.id == row[0].to_i }.first
        next if rec.blank?

        rec.update!(kind: :mailing) if row[1] == '郵送'

        tags = %w[
          現場実績多数
          作品持ち帰り
          10,000円以下
          男性にも人気
          予防リハ要素有
          鑑賞型
          吉本興業
          見守り中心
          難易度相談可
          作品キットの郵送のみ
          郵送物あり
          季節感有
          行事におすすめ
          飲食
          美容
          芸能
          習い事
          パフォーマー
          口コミ高評価
          現場絶賛
          ほぼ自立
          軽度認知症
          中重度認知症
          介護度2以下
          介護度3以上
          寝たきり
        ]

        tags.each do |tag|
          next if row[tag] == 'FALSE'

          tag_record = Tag.find_or_create_by(name: tag) do |t|
            t.kind = :tag
          end
          add_tag_by_key(rec: rec, tag: tag_record)
        end

        rec.save!
      end
    end
  rescue StandardError => e
    puts e
  end
end
